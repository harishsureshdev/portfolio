#!/bin/sh
# Copy ONLY the public site into dist/ and deploy it. Anything not listed
# here (Claude.md, tools/, hook configs, unused images) is never uploaded.
set -e
cd "$(dirname "$0")"
rm -rf ./dist
mkdir -p ./dist/assets
cp index.html 404.html robots.txt sitemap.xml resume.pdf ./dist/
cp assets/favicon.svg assets/apple-touch-icon.png assets/avatar.jpg assets/og.png ./dist/assets/
cp -R assets/fonts ./dist/assets/fonts
npx wrangler deploy
