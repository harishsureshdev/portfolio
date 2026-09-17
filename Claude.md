# Harish Suresh — Portfolio Site

## What this is

A one-page personal portfolio for a software engineer (backend-leaning full-stack).
Single self-contained HTML file for now (`index.html`) — no build step yet.

## Design system (do not deviate without asking)

- Background: #0B0A08 (near-black)
- Text: #E9E8E3 (off-white)
- Accent: #4DBF74 (green) — used sparingly, primary CTAs and key emphasis only
- Borders: #282622 — thin borders instead of shadows, everything stays flat
- Fonts: Epilogue (body/headings), JetBrains Mono (metadata, tags, dates, labels)
- Border radius: 4.8px on buttons, near-square everywhere else
- No heavy shadows, no gradients beyond the one subtle radial glow in the hero
- Motion: minimal. One entrance animation on the hero, subtle hover/border
  transitions elsewhere. No fade-slide-up on every section.

## Content rules

- Every claim must be true and traceable to my actual resume/projects — do not
  invent metrics, testimonials, or experience I don't have.
- Tone: confident, plain, technical. No marketing language, no "passionate about."
- Sections stay in this order: hero → what I do → experience → projects →
  education → contact.

## Current known gaps (don't silently "fix" these — ask first)

- resume.pdf does not exist yet — download button should degrade gracefully,
  not 404 gonzo.
- Avatar is initials-only ("HS") — no real photo yet.
- No testimonials section — deliberately dropped, don't add placeholder quotes.
- Only 2 projects (Warden, SnapSend) — a 3rd is planned, layout should tolerate
  3+ cards without redesign.

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
