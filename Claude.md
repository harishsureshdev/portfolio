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
- Every grey is WARM — they sit on a warm near-black. Never introduce a cool
  or blue-tinted grey; it reads as a mismatch immediately next to the borders
  and off-white text.
- Nav links are `--text-dim` (deliberately quieter than body copy) while the
  nav icons are full `--text`. That contrast is intentional, not an oversight.
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
- Sections are full-bleed (`<section>` spans the viewport, an inner `.wrap`
  holds the content) so dividers reach both edges. Sections alternate
  background via `.band` (`--band`), and cards sit on `--surface` above it —
  keep those two tokens distinct or cards vanish into the band.
- The alternation STARTS banded: hero, what-I-do, projects and contact carry
  `.band`. Adding or removing a section means re-striping all of them.
  The nav is tinted from `--bg`, so a banded hero is what makes the nav read as
  a distinct bar on first load. Don't flip the order back.
- Tech tags are accent text on `--accent-soft`, everywhere they appear
  (experience and projects both).
- The command palette (⌘K / Ctrl-K, or the search button in the nav) holds its
  actions in one `commands` array. The planned terminal easter egg should reuse
  that array rather than defining its own copy. The nav button stays visible at
  every width — on mobile `.nav-links` is hidden, so the palette is the only
  way to jump between sections.
- Project cards expand via `grid-template-rows: 0fr -> 1fr`, which animates to
  the natural height without measuring it in JS. Don't swap this for a
  max-height hack.
- `html` carries `overflow-x: clip`. Do NOT add `overflow-x: hidden` to `body`:
  together they make body the scroll container, which silently kills the
  sticky nav. Verified — it is not a theoretical concern.
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
- Sections stay in this order: hero → about → what I do → experience →
  projects → education → contact.
- The About prose is a DRAFT written from facts already on the site (Chennai →
  Sify → Bloomington → San Jose). It is in Harish's voice but not his words —
  he should rewrite it. Don't add motivation, hobbies or backstory that isn't
  already evidenced elsewhere on the page.
- Visual language is modelled on jozsefpallagi.com. Two things from that site
  were deliberately NOT copied and should stay out: a CV download counter
  (there's no real number to show) and a "N+ years" badge (doesn't match the
  actual timeline). Both would be invented metrics.

## Current known gaps (don't silently "fix" these — ask first)

- No testimonials section — deliberately dropped, don't add placeholder quotes.
- Only 2 projects (Warden, SnapSend) — a 3rd is planned, layout should tolerate
  3+ cards without redesign.
- The expandable project detail panels are THIN. Their content is just the
  second half of the original card paragraph, split out — no new material was
  written, since inventing project detail would breach the content rule. They
  need real writing from Harish (architecture, trade-offs) to earn the expand.
- Analytics is NOT wired up. Cloudflare Web Analytics / Umami both need a site
  token from Harish's own account, so it can't be added unattended. If the site
  lands on Cloudflare Pages it's a dashboard toggle and needs no code at all.
- `assets/og.png` is a GENERATED file, not hand-made — it is a 1200x630 render
  of a card built from the same fonts and tokens as the site. If the name, role
  or stack line changes, regenerate it rather than editing the PNG.
- Hero background is a 21st.dev pattern ported from React/Tailwind to plain
  CSS (`.hero-bg`): corner lift, five skewed accent streaks, a dot grid and
  inline SVG grain. Recoloured from the original cyan to the accent green, and
  the grain is generated inline rather than fetched from `cdn.21st.dev`.
  It is deliberately faint — at full strength it washes the hero green.
  `.hero` keeps `overflow: hidden` to clip the skewed streaks.
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
