# Harish Suresh — Portfolio Site

## What this is

A one-page personal portfolio for a software engineer (backend-leaning full-stack).
Single self-contained HTML file for now (`index.html`) — no build step yet.

## Design system (do not deviate without asking)

- Dark (default): bg #0B0A08, surface #100F0C, text #E9E8E3, border #282622,
  accent #4DBF74
- Light: bg #FAF9F6, surface #FFFFFF, text #15140F, border #E3DFD5,
  accent #217A45 (darker green — #4DBF74 fails contrast on a light ground)
- Every color goes through a CSS custom property defined in both palettes.
  Never hardcode a hex in a rule; add a token instead.
- Accent used sparingly — primary CTAs, key emphasis, `+` bullets, current-role
  rail. Text on an accent fill is `--accent-text` (near-black on dark green),
  not white: white-on-#4DBF74 only reaches ~2.2:1.
- Borders: thin borders instead of shadows, everything stays flat
- Fonts: JetBrains Mono for headings, nav, metadata, tags, dates and labels;
  Epilogue for body copy and bullet text. The mono headings are the site's
  defining trait — don't soften them back to sans.
- Border radius: 4.8px on buttons, near-square everywhere else
- Content max-width is 1120px (`--max-w`). Headings and the hero use `clamp()`
  so type scales with the viewport — change the clamp, not a fixed px size.
- Stack logos come from Devicon via jsDelivr, pinned to v2.16.0. Each `<img>`
  removes itself on error, so a CDN miss degrades to a text-only chip.
- No heavy shadows, no gradients beyond the one subtle radial glow in the hero
- Motion: sections fade-slide-up on scroll via IntersectionObserver (`.reveal`,
  staggered with `--d`). Hero has its own staggered entrance, the nav mark and
  typewriter share a blinking caret, and the current-role dot pulses. Every one
  of these is disabled under `prefers-reduced-motion` — keep it that way.

## Content rules

- Every claim must be true and traceable to my actual resume/projects — do not
  invent metrics, testimonials, or experience I don't have.
- Tone: confident, plain, technical. No marketing language, no "passionate about."
- Sections stay in this order: hero → what I do → experience → projects →
  education → contact.
- Visual language is modelled on jozsefpallagi.com. Two things from that site
  were deliberately NOT copied and should stay out: a CV download counter
  (there's no real number to show) and a "N+ years" badge (doesn't match the
  actual timeline). Both would be invented metrics.

## Current known gaps (don't silently "fix" these — ask first)

- No testimonials section — deliberately dropped, don't add placeholder quotes.
- Only 2 projects (Warden, SnapSend) — a 3rd is planned, layout should tolerate
  3+ cards without redesign.
- No favicon and no Open Graph / social preview tags yet.
- Hero background is placeholder — a single radial glow. A replacement is
  planned from a 21st.dev prompt; don't invest in the current one.
- Zustand is the one stack chip with no logo (Devicon has no Zustand icon).
  Chips degrade to text-only on their own, so this is fine, not a bug.

## Workflow preferences

- Keep it a single HTML file until there's a real reason to split it
  (e.g. adding a build step, a second page, or a CMS-like project data source).
- When adding a project card, pull structure from the existing ones in
  `#projects` rather than inventing new markup patterns.
- Ask before changing color tokens, fonts, or spacing scale — cosmetic tweaks
  within the existing system are fine without asking.
- After any visual change, describe what changed in plain terms rather than
  just diffing code, since I'm reviewing on look/feel, not implementation.

## Deployment target

- Domain: harishsuresh.dev (GoDaddy, not yet pointed anywhere)
- Planned host: TBD (Vercel/Netlify/GitHub Pages — ask before assuming one)
