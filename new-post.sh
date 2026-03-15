#!/usr/bin/env bash
set -e

BLOG_DIR="$(cd "$(dirname "$0")" && pwd)"
TODAY=$(date +%Y-%m-%d)

# ── helpers ──────────────────────────────────────────────────────────────────
slugify() {
  echo "$1" | tr '[:upper:]' '[:lower:]' | sed 's/[[:space:]]/-/g' | sed 's/[^a-z0-9-]//g'
}

prompt() {
  local var_name="$1" msg="$2" default="$3"
  read -r -p "$msg${default:+ [$default]}: " value
  eval "$var_name='${value:-$default}'"
}

# ── type selection ────────────────────────────────────────────────────────────
echo ""
echo "What type of content do you want to create?"
echo "  1) post"
echo "  2) book"
echo "  3) project"
echo ""
prompt TYPE_CHOICE "Choose [1-3]" "1"

case "$TYPE_CHOICE" in
  1) CONTENT_TYPE="post"    ;;
  2) CONTENT_TYPE="book"    ;;
  3) CONTENT_TYPE="project" ;;
  *) echo "Invalid choice. Exiting."; exit 1 ;;
esac

# ── gather fields ─────────────────────────────────────────────────────────────
echo ""
echo "=== New $CONTENT_TYPE ==="
echo ""

prompt TITLE       "Title"                       ""
prompt DESCRIPTION "Description (one-liner)"     ""
prompt TAGS        "Tags (comma-separated)"       ""
prompt DATE        "Date"                         "$TODAY"

SLUG=$(slugify "$TITLE")
prompt SLUG "Slug" "$SLUG"

# type-specific fields
case "$CONTENT_TYPE" in
  post)
    prompt CATEGORIES "Categories (comma-separated)" "reflections"
    ;;
  book)
    prompt NOTION_LINK "Notion link (leave blank to skip)" ""
    ;;
  project)
    prompt GITHUB_LINK "GitHub repo URL (leave blank to skip)" ""
    prompt CATEGORIES  "Categories (comma-separated)"          ""
    ;;
esac

prompt DRAFT "Draft? [true/false]" "false"

# ── build frontmatter ─────────────────────────────────────────────────────────
tags_yaml=""
if [[ -n "$TAGS" ]]; then
  IFS=',' read -ra TAG_ARR <<< "$TAGS"
  tags_yaml="tags: ["
  for t in "${TAG_ARR[@]}"; do
    t=$(echo "$t" | xargs)   # trim whitespace
    tags_yaml+="\"$t\", "
  done
  tags_yaml="${tags_yaml%, }]"
fi

categories_yaml=""
if [[ -n "$CATEGORIES" ]]; then
  IFS=',' read -ra CAT_ARR <<< "$CATEGORIES"
  categories_yaml="categories: ["
  for c in "${CAT_ARR[@]}"; do
    c=$(echo "$c" | xargs)
    categories_yaml+="\"$c\", "
  done
  categories_yaml="${categories_yaml%, }]"
fi

# ── determine file path ───────────────────────────────────────────────────────
case "$CONTENT_TYPE" in
  post)    DIR="$BLOG_DIR/content/posts";    FILENAME=$(echo "$TITLE" | sed 's/ /-/g').md ;;
  book)    DIR="$BLOG_DIR/content/books";    FILENAME=$(slugify "$TITLE").md ;;
  project) DIR="$BLOG_DIR/content/projects"; FILENAME=$(slugify "$TITLE").md ;;
esac

FILE="$DIR/$FILENAME"

if [[ -f "$FILE" ]]; then
  echo ""
  echo "File already exists: $FILE"
  prompt OVERWRITE "Overwrite? [y/N]" "N"
  [[ "$OVERWRITE" =~ ^[Yy]$ ]] || { echo "Aborted."; exit 1; }
fi

# ── write file ────────────────────────────────────────────────────────────────
{
  echo "---"
  echo "title: \"$TITLE\""
  echo "date: $DATE"
  echo "draft: $DRAFT"
  [[ -n "$DESCRIPTION" ]]   && echo "description: \"$DESCRIPTION\""
  [[ -n "$tags_yaml" ]]     && echo "$tags_yaml"
  [[ -n "$categories_yaml" ]] && echo "$categories_yaml"
  [[ "$CONTENT_TYPE" == "post" ]]    && echo "slug: \"$SLUG\""
  [[ "$CONTENT_TYPE" == "book" && -n "$NOTION_LINK" ]]   && echo "notionLink: \"$NOTION_LINK\""
  [[ "$CONTENT_TYPE" == "project" && -n "$GITHUB_LINK" ]] && echo "link: \"$GITHUB_LINK\""
  echo "---"
  echo ""

  case "$CONTENT_TYPE" in
    post)
      echo "<!-- Write your post here -->"
      ;;
    book)
      echo "## Summary"
      echo ""
      echo "<!-- Write your book summary here -->"
      echo ""
      echo "---"
      echo ""
      ;;
    project)
      echo "# $TITLE"
      echo ""
      echo "<!-- Describe your project here -->"
      echo ""
      echo "## Overview"
      echo ""
      echo "## Features"
      echo ""
      echo "## How It Works"
      echo ""
      echo "## Technologies Used"
      echo ""
      [[ -n "$GITHUB_LINK" ]] && echo "## Repository" && echo "" && echo "[View on GitHub]($GITHUB_LINK)" && echo ""
      ;;
  esac
} > "$FILE"

echo ""
echo "Created: $FILE"
