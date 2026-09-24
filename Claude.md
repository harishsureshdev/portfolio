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
- The alternation STARTS banded: hero, experience and education carry `.band`.
  Adding, removing or reordering a section means re-striping all of them, or
  two same-coloured sections end up adjacent. The nav is tinted from `--bg`,
  so a banded hero is what makes the nav read as a distinct bar on first load.
  Don't flip the order back.
- Education is a two-card grid, not a list — the row layout read as too thin.
  Each card holds a logo tile, a date pill, degree, school and stat chips.
- Both universities use real logos at 44px inside 62px tiles. The Anna crest
  needs that size: at 28px it collapsed into a blob. The bar is a RECOGNISABLE
  silhouette, not readable text — nobody needs to read "progress through
  knowledge", they need the gear shape. Don't shrink these tiles.
- `.edu-mark img` renders any source file true monochrome — `brightness(0)`
  flattens it to solid black, `invert(1)` lifts it to white for dark mode.
  Needs a transparent background.
- Tech tags are accent text on `--accent-soft`, everywhere they appear
  (experience and projects both).
- The command palette (⌘K / Ctrl-K, or the search button in the nav) holds its
  actions in one `commands` array. The planned terminal easter egg should reuse
  that array rather than defining its own copy. The nav button stays visible at
  every width — on mobile `.nav-links` is hidden, so the palette is the only
  way to jump between sections.
- Project cards print everything inline — lead paragraph, a `// label`, the
  detail paragraph, then tags. They used to expand (whole-card click, a
  `grid-template-rows: 0fr -> 1fr` panel). That was REMOVED on 2026-09-23 after
  measuring the panels at 20-33 words each: a click that reveals two sentences
  is friction between a recruiter and the best material on the card. Don't
  re-add an expand/modal unless the detail grows past roughly a paragraph per
  card — at which point the old implementation is in git history at 0963169.
- The skills grid has 7 groups in a 3-column auto-fit, so one always orphans on
  the last row. The order (Languages, Backend, Data, AI & LLM, Cloud, Testing,
  Frontend) is chosen so the orphan is Frontend, the shortest group. Reordering
  or adding a group means re-checking which one lands alone.
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
- The experience bullets and project copy were reconciled against `resume.pdf`
  on 2026-09-23 and now carry its full detail (HTTP 409 on conflicting
  reservations, SHA-256 change detection, capped backoff retries, step caps and
  tool-failure recovery, and so on). If the resume changes, re-reconcile.
- Two deliberate divergences from `resume.pdf`, both Harish's call — don't
  "fix" either silently:
  1. Sirius Technologies (May-Aug 2020) is on the site but NOT on the resume.
     He wants it kept on the site.
  2. Home Credit Default Risk is on the site but NOT in the committed
     `resume.pdf` — that file is STALE relative to the newer resume he has.
     Replacing `resume.pdf` is still outstanding.
- Tone: confident, plain, technical. No marketing language, no "passionate about."
- Sections stay in this order: hero → what I do → experience → projects →
  education → contact.
- There is deliberately NO About section. One was built and removed on
  2026-09-18 after auditing it: of six statements, five already appeared
  verbatim or near-verbatim in the hero, experience or contact sections, and
  the only new fact ("from Chennai") doesn't differentiate him among
  international MS students applying for the same roles. The hero already
  carries name, photo, location, university, what he does, stack, resume and
  contact. Don't re-add a bio section unless there is genuinely new
  information to put in it.
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
- 3 projects (Warden, Home Credit Default Risk, SnapSend). Layout tolerates
  more without redesign.
- Project detail is still THIN (one short paragraph per card). Everything the
  resume has on each project is now on the page, so there is nothing left to
  import — more depth (architecture, trade-offs) has to be written by Harish.
  Don't invent it.
- All three projects link to `github.com/harishs2000`, the profile, not to
  per-project repos. Harish still owes the specific repo URLs.
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
