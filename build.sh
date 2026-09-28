#!/bin/sh
# Copy ONLY the public site into dist/. Anything not listed here (Claude.md,
# tools/, hook configs, unused images) is never uploaded. wrangler runs this
# before every deploy, locally and in Cloudflare's builds.
set -e
cd "$(dirname "$0")"
rm -rf ./dist
mkdir -p ./dist/assets
cp index.html 404.html robots.txt sitemap.xml resume.pdf _headers ./dist/
cp assets/favicon.svg assets/apple-touch-icon.png assets/avatar.jpg assets/og.png ./dist/assets/
cp -R assets/fonts ./dist/assets/fonts
