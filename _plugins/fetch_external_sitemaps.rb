require 'net/http'
require 'uri'
require 'rexml/document'
require 'yaml'

Jekyll::Hooks.register :site, :after_reset do |site|
  sitemaps = [
    "https://sadatian.io/MLOps/sitemap.xml",
    "https://sadatian.io/xpyrment/sitemap.xml"
  ]
  
  external_urls = []
  
  sitemaps.each do |url|
    Jekyll.logger.info "Sitemap Downloader:", "Fetching external sitemap from #{url}"
    begin
      uri = URI.parse(url)
      # Setup Net::HTTP with a reasonable timeout of 5 seconds
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = (uri.scheme == 'https')
      http.open_timeout = 5
      http.read_timeout = 5
      
      request = Net::HTTP::Get.new(uri.request_uri)
      response = http.request(request)
      
      if response.is_a?(Net::HTTPSuccess)
        xml_data = response.body
        doc = REXML::Document.new(xml_data)
        count = 0
        doc.elements.each('urlset/url') do |url_element|
          loc = url_element.elements['loc']&.text
          lastmod = url_element.elements['lastmod']&.text
          changefreq = url_element.elements['changefreq']&.text
          priority = url_element.elements['priority']&.text
          
          if loc
            begin
              sitemap_uri = URI.parse(url)
              subpath = sitemap_uri.path.chomp('sitemap.xml').chomp('/')
              
              loc_uri = URI.parse(loc)
              parent_uri = URI.parse(site.config['url'] || "https://sadatian.io")
              
              loc_uri.scheme = parent_uri.scheme
              loc_uri.host = parent_uri.host
              loc_uri.port = parent_uri.port
              
              if !subpath.empty? && !loc_uri.path.start_with?(subpath)
                loc_uri.path = File.join(subpath, loc_uri.path).gsub('//', '/')
              end
              
              loc = loc_uri.to_s
            rescue => parse_err
              Jekyll.logger.warn "Sitemap Downloader:", "Failed to rewrite URL #{loc}: #{parse_err.message}"
            end

            external_urls << {
              'loc' => loc,
              'lastmod' => lastmod,
              'changefreq' => changefreq,
              'priority' => priority
            }
            count += 1
          end
        end
        Jekyll.logger.info "Sitemap Downloader:", "Successfully fetched and parsed #{count} URLs from #{url}"
      else
        Jekyll.logger.warn "Sitemap Downloader:", "Failed to fetch #{url}: #{response.code} #{response.message}"
      end
    rescue => e
      Jekyll.logger.warn "Sitemap Downloader:", "Error fetching #{url}: #{e.message}"
    end
  end
  
  # Ensure the _data directory exists
  data_dir = File.join(site.source, '_data')
  Dir.mkdir(data_dir) unless File.directory?(data_dir)
  output_file = File.join(data_dir, 'external_sitemaps.yml')
  
  # Write file or handle caching/failure
  if !external_urls.empty?
    File.write(output_file, external_urls.to_yaml)
    Jekyll.logger.info "Sitemap Downloader:", "Wrote #{external_urls.size} external URLs to #{output_file}"
  elsif File.exist?(output_file)
    Jekyll.logger.info "Sitemap Downloader:", "No external URLs fetched. Using cached sitemaps from #{output_file}"
  else
    File.write(output_file, [].to_yaml)
    Jekyll.logger.info "Sitemap Downloader:", "No external URLs fetched and no cache found. Created empty #{output_file}"
  end
end
