#!/bin/bash

# Check for input file
if [ -z "$1" ]; then
  echo "Usage: $0 urls.txt"
  exit 1
fi

mkdir -p downloads

while IFS= read -r url; do
  echo "Processing $url..."

  # Fetch the HTML page
  html=$(curl -s "$url")

  # Extract title from h1 with itemprop="name"
  title=$(echo "$html" | grep -oP '<h1[^>]*itemprop="name"[^>]*>.*?</h1>' | sed -e 's/<[^>]*>//g' | xargs)

  # Sanitize title to be a valid filename
  safe_title=$(echo "$title" | tr -cd '[:alnum:] ._-' | tr ' ' '_')

  # Extract ebook ID from URL
  ebook_id=$(basename "$url")

  # Construct download URL
  download_url="https://www.gutenberg.org/ebooks/${ebook_id}.epub3.images"

  # Download the file
  output_file="downloads/${safe_title}.epub"
  curl -s -L -o "$output_file" "$download_url"

  if [ $? -eq 0 ]; then
    echo "Downloaded: $output_file"
  else
    echo "Failed to download $download_url"
  fi

done < "$1"
