# tools

Not part of the site — the site is still a single `index.html`.

## og.html

Source for `assets/og.png`, the 1200x630 social preview. Regenerate whenever
the name, role line or stack line changes:

```sh
"/Applications/Brave Browser.app/Contents/MacOS/Brave Browser" \
  --headless --disable-gpu --allow-file-access-from-files --hide-scrollbars \
  --virtual-time-budget=12000 --window-size=1200,630 \
  --screenshot=../assets/og.png tools/og.html
```

The generous virtual-time budget is there so the self-hosted fonts resolve before
the capture; a short budget silently renders the fallback faces.
