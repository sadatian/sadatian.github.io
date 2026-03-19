# Dan Sadatian Portfolio Website

A Jekyll-based professional portfolio and personal website for Dan Sadatian, a Data Science Manager. The site showcases professional experience, education, skills, and projects.

## Project Overview

- **Purpose:** Professional portfolio and blog.
- **Technologies:** Jekyll (Ruby), SASS, HTML/CSS, JavaScript, Docker.
- **Architecture:** 
  - **Content:** Primarily managed through `_data/data.yml` for profile/career info.
  - **Projects/Posts:** Stored in `_posts/` as Markdown files.
  - **Layouts:** Located in `_layouts/` (e.g., `default.html`, `project_detail.html`).
  - **Components:** Modular HTML snippets in `_includes/`.
  - **Styling:** SASS-based styles in `_sass/`, compiled into `assets/css/main.scss`.
  - **Static Assets:** Images and PDFs in `assets/`.

## Building and Running

### Prerequisites
- **Docker** (recommended) or **Ruby & Bundler**

### Option 1: Docker (Recommended)
This is the easiest way to run the site locally without managing Ruby versions.
```powershell
# Start the development server
docker-compose up
```
The site will be available at `http://localhost:4000`.

### Option 2: Local Jekyll
If you have Ruby and Bundler installed locally:
```powershell
# Install dependencies
bundle install

# Start the development server
bundle exec jekyll serve
```
The site will be available at `http://localhost:4000`.

## Development Conventions

### Content Updates
- **Profile/Resume:** Edit `_data/data.yml` to update the career profile, education, and experience sections.
- **Projects/Blog Posts:** Add new Markdown files to `_posts/` with the naming convention `YYYY-MM-DD-title.md`.
- **Project Detail Pages:** Some projects are also detailed in the `projects/` directory as individual HTML files.

### Styling
- **Themes:** The site supports different color skins (e.g., `blue`, `turquoise`, `green`, `berry`, `orange`, `ceramic`). Change the `theme_skin` in `_config.yml`.
- **Custom CSS:** Add or modify SASS files in `_sass/`.

### Compatibility
- The project includes a `_plugins/ruby_3_patch.rb` to ensure compatibility with Ruby 3.2+, which removed some legacy methods used by older versions of Jekyll/Liquid.

## Key Files
- `_config.yml`: Global site configuration.
- `_data/data.yml`: Central repository for resume/profile content.
- `_layouts/default.html`: Main HTML template.
- `index.html`: Home page (uses `career-profile.html` and `experiences.html` includes).
- `projects.html`: Lists projects/posts from `_posts/`.
