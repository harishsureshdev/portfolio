#!/bin/sh
# Manual deploy. wrangler.jsonc runs build.sh first, so dist/ is always fresh.
set -e
cd "$(dirname "$0")"
npx wrangler deploy
