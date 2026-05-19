# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a personal blog built with **Hugo**, a static site generator. The site is deployed to GitHub Pages and focuses on backend engineering, systems design, Go, C/C++, and distributed systems content.

- **Theme**: Terminal (GitHub-hosted theme)
- **Deployment**: GitHub Pages via GitHub Actions (`.github/workflows/deploy.yaml`)
- **Content Types**: Posts, Books, Projects
- **Hosting**: mmoumni.com (configured in `hugo.toml`)

## Getting Started

### Install Hugo

This project requires Hugo with extended support (for SCSS/SASS compilation if needed):
```bash
brew install hugo  # macOS with Homebrew
# Or download from https://gohugo.io/installation/
```

### Run Locally

```bash
hugo server
# or with drafts included:
hugo server -D
```

The site will be available at `http://localhost:1313`.

### Build for Production

```bash
hugo --minify
# Output goes to ./public/
```

## Content Structure

The blog has three types of content, each in its own directory:

### Posts (`content/posts/`)
- Regular blog posts
- Frontmatter fields:
  - `title`: Post title
  - `date`: Publication date (YYYY-MM-DD)
  - `draft`: Boolean (true/false)
  - `description`: One-liner summary
  - `tags`: Array of tags (auto-linked)
  - `categories`: Array of categories
  - `slug`: URL-friendly title slug

### Books (`content/books/`)
- Book reviews and summaries
- Additional frontmatter field: `notionLink` (optional Notion link to original notes)
- Custom layout at `layouts/books/single.html` displays Notion link

### Projects (`content/projects/`)
- Project showcases
- Additional frontmatter field: `link` (GitHub repo URL)
- Predefined sections: Overview, Features, How It Works, Technologies Used

## Creating New Content

Use the included `new-post.sh` script to scaffold new content:

```bash
./new-post.sh
```

The script will:
1. Prompt you to choose content type (post/book/project)
2. Collect metadata (title, description, tags, categories, date, etc.)
3. Generate frontmatter and initial markdown file
4. Create file in appropriate directory with proper slug

**Important Note**: Tags and categories in frontmatter are stored as arrays. The script handles this, but when manually editing, ensure they follow YAML array syntax: `tags: ["tag1", "tag2"]`

## Customizations & Layouts

### Custom Layouts
- `layouts/books/single.html`: Custom template for book pages, displays Notion link if provided
- `layouts/partials/extended_head.html`: Custom HTML head extensions
- `layouts/partials/comments.html`: Comments section partial

### Theme Customization
The Terminal theme is configured in `hugo.toml`. Key settings:
- `centerTheme`: Centered layout
- `primaryColor`: Blue (#1a73e8)
- `readingTime`: Show estimated reading time
- `author`: Default author name

### Hugo Configuration
- `hugo.toml`: Main configuration file
- `baseURL`: https://mmoumni.com/
- `markup.goldmark.renderer.unsafe`: Allows raw HTML in markdown
- Multi-language support for English (default)

## Deployment

The site auto-deploys on every push to `main` branch via GitHub Actions:
- Workflow file: `.github/workflows/deploy.yaml`
- Trigger: Push to `main`
- Build step: `hugo --minify`
- Deploy target: GitHub Pages publish directory (`./public/`)

**Note**: The theme is included as a regular directory in `/themes/terminal/`, not as a Git submodule.

## Common Workflows

### Add a New Blog Post
```bash
./new-post.sh
# Select "post", fill in metadata
# Edit the generated markdown file
git add content/posts/Your-Title.md
git commit -m "feat: add blog post about X"
git push origin main  # Auto-deploys
```

### Update Homepage
Edit `content/_index.md` to modify the about section and social links.

### Add Images
Place static assets in `/static/images/`. Reference them as `/images/filename.ext` in markdown.

### Modify Theme Colors
Update `primaryColor` in `hugo.toml` (currently #1a73e8 for blue).

## Key Files & Architecture

```
MyBlog/
├── content/              # Markdown content
│   ├── _index.md        # Homepage/about page
│   ├── posts/           # Blog posts
│   ├── books/           # Book reviews
│   └── projects/        # Project showcases
├── layouts/             # Hugo template overrides
│   ├── books/           # Custom book layout
│   └── partials/        # Reusable template components
├── static/              # Static files (images, etc.)
├── themes/terminal/     # Terminal theme
├── public/              # Built site (generated)
├── hugo.toml            # Hugo configuration
├── new-post.sh          # Content scaffolding script
└── .github/workflows/   # GitHub Actions
    └── deploy.yaml      # Auto-deploy to GitHub Pages
```

## Git & Commit Conventions

- **Commit Messages**: Use clean commit messages without the "Co-Authored-By" suffix
- **Branch**: Push directly to `main` (auto-deploys via GitHub Actions)
- **Format**: Follow conventional commits where applicable (e.g., `feat:`, `fix:`, `docs:`)

## Tips

- **Reading Time**: Hugo automatically calculates and displays reading time on posts
- **Tags/Categories**: Both are clickable and generate archive pages
- **Draft Posts**: Set `draft: true` in frontmatter to hide from production build
- **Local Testing**: Use `hugo server -D` to preview drafts locally before publishing
- **SEO**: Site includes `robots.txt`, meta descriptions, and social media tags (Twitter)
