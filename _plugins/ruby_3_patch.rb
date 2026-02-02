# Patch for Ruby 3.2+ compatibility with older Jekyll/Liquid
# Ruby 3.2 removed tainted?, taint, and untaint methods.

if RUBY_VERSION >= '3.2'
  class Object
    def tainted?
      false
    end

    def taint
      self
    end

    def untaint
      self
    end
  end
end
