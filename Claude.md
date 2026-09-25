# Harish Suresh — Portfolio Site

## What this is

A one-page personal portfolio for a FULL-STACK software engineer with applied
AI as a second leg. Single self-contained HTML file
(`index.html`) — no build step. `tools/` holds generators for assets and is
not part of the site.

## Design system (do not deviate without asking)

- Dark (default): bg #0B0A08, surface #1A1813, text #E9E8E3, border #282622,
  accent #4DBF74
- Light: bg #FAF9F6, surface #FFFFFF, text #15140F, border #CFC8B8,
  border-strong #B3AA99, text-dim #635F56, accent #1A6238
- The light palette was retuned on 2026-09-24 after a critique measured 32
  failing text instances. The old values (#217A45 accent, #726E65 text-dim,
  #E3DFD5 border) put tags, the `current` badge and both `.hl` bold leads at
  4.12:1 and the hero meta at 4.38:1, against a 4.5 requirement — and the
  detector could not see the worst of it, because that background only exists
  after compositing `--accent-soft` over `--band`. They now measure 5.58 and
  5.49. Do not lighten these back.
- `.btn-secondary` borders on `--border-strong`, not `--border`: a control
  needs a visible edge and at --border the light secondary CTA read as
  floating text. Even at --border-strong it is 2.19:1, short of WCAG 1.4.11's
  3:1 — reaching that needs roughly #8F8878, dark enough to make the flat
  thin-border aesthetic look boxy. That trade is unresolved, not overlooked.
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
- The hero OWNS the first screen: `min-height: calc(100svh - var(--header-h))`
  with `align-items: center`, so its bottom divider lands exactly on the fold.
  Sized to its content it ended ~250px short, and every load showed a slice of
  `#work`'s empty top padding beneath a divider — which reads as an
  unexplained black gap, not as the next section. `--header-h` is 77px and the
  header measures 77px at every width; if that changes, change the token.
- Fading `.hero.band` into `--bg` was tried for the same problem on
  2026-09-23 and made it WORSE — a black hero bottom merged with the black
  padding below into one larger void. It was reverted; the hero band stays
  flat and the pattern stays unmasked. Don't reach for the gradient again.
- On phones the hero exceeds one screen because the layout stacks. That is
  correct — `min-height` is a floor, not a cap. But the CTAs must stay above
  the fold, including on a 360x740 Android: the portrait drops to 130px and
  mobile hero padding is 40/48px. Measure `.cta-row`'s BOTTOM edge against
  the viewport height at 390x844 and 360x740 after any hero change.
- The hero has ONE perpetually moving thing: the cycler. The section
  typewriter and the rotating stack-line underline were REMOVED on 2026-09-24
  so it isn't competing. One-shot entrances that finish in under a second are
  allowed (the name decode, ~1.3s at Harish's request, done before the
  cycler starts at 2.6s; its forced-settle timeout is 2s), as
  is motion that only answers the user (the cursor spotlight). Nothing else
  may loop.
- The cycler reads "Building systems that / scale. ship. hold up. last." —
  Harish's own wording, chosen on 2026-09-24 over evidence-mapped
  alternatives ("don't double-book", "are safe to retry", "ask before they
  act"…) after the trade-off was put to him twice. It is his call. Don't
  re-pitch it; if the list changes, keep the `.sr-only` sentence in step.
- The cycling line is `white-space: nowrap` with `min-height: 1.3em`, so no
  phrase can change the box's size. Its predecessor reserved too little and
  shifted ~2500px of page by 31px every few seconds, forever. The first
  phrase ships in the HTML and the loop starts by deleting it, so no-JS and
  reduced motion both show a complete sentence. Screen readers get the full
  list once from an `.sr-only` span; the animated copy is `aria-hidden`.
- There is NO prose summary in the hero. Under the cycler sits `.hero-stack`,
  a static lowercase mono row: react / spring boot / fastapi / aws / langchain.
  History, all Harish's calls on 2026-09-24: java/python/typescript/react/
  postgres was rejected as "simple"; react/fastapi/langchain/neo4j/
  opentelemetry came next; then he asked for Spring Boot, dropped neo4j, and
  took AWS over Docker (AWS reads as production experience, Docker as table
  stakes). Every name must appear in an experience bullet or tag. Spans are
  `white-space: nowrap` so "spring boot" never splits. `tools/og.html`
  carries the same row; keep them in step. It must stay static.
- The hero's two wrapping rows break at a chosen separator marked
  `.wrap-here` (a full-width invisible line break), each on its OWN measured
  breakpoint: the meta line below 800px, the keyword row below 750px (it fits
  on one line from ~760). Left to wrap freely they stranded a `·` or `/` at a
  line end. If you change either row's text, re-run the width sweep.
- The hero badge says "2+ yrs". CLAUDE.md used to ban an "N+ years" badge as
  an invented metric; Harish asked for one on 2026-09-24 and it is now
  allowed, but ONLY as "2+". The honest arithmetic: Sify Aug 2022-Jul 2024
  (~23 months) + Heartland from Jun 2026 (~3+ months) = ~2.2 years of
  professional work. "2.5+" only works by also counting the 3-month 2020
  Sirius internship and ignoring the two-year gap in between, so don't round
  up. "2+" stays true from now on; a bigger number needs recomputing.
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
- Experience is a continuous timeline. `.job` carries a 2px `--rail` left
  border (accent on the current role) and a 14px node in `::before`, hollow
  for past roles and filled for the current one. The first job's rail begins
  at its node's centre (`--node-y` via a `border-image` gradient); it used to
  poke ~20px above the node, so the timeline looked like it started in
  mid-air.
- The timeline DRAWS ITSELF: JS appends `.timeline-fill` (2px, accent) and
  adds `.has-fill`, which turns every rail grey; the fill grows to wherever
  the viewport's 60% line sits, and each `.job` gets `.is-reached` (node ring
  turns green) as the fill passes it. Harish asked why the rail wasn't all
  green and whether it should move — this answers both. Without JS the old
  look holds (current role's own rail green); under reduced motion the fill
  is static to the bottom of the current role. Headless never fires the rAF
  scroll handler: verify by replacing `requestAnimationFrame` with a direct
  call and dispatching a synthetic `scroll`. Jobs are spaced with
  padding-bottom, not flex gap, so each job's rail runs into the next. The
  old rail was `--border-strong` at 1.6:1 — invisible — which left past roles
  indented for no visible reason. `--rail` is #66625A dark / #8F8676 light,
  ~3:1 on the band.
- At >=1000px each `.job` is a grid: bullets hold their 74ch column on the
  left and the tag row takes the right column under a CSS-generated
  `// stack` label, filling the space the measure cap used to leave empty.
  Below that, tags fall back under the bullets.
- The per-job tags list the HEAVIER tech each job's bullets actually name, not
  just the headline languages: Heartland 11 (FastAPI, PostgreSQL, Celery,
  Redis, Qdrant, LangChain, OpenTelemetry, FFmpeg, S3, React, TypeScript),
  Sify 12 (incl. Spring Security, OAuth 2.0, JPA/Hibernate, SNMP, NETCONF,
  Neo4j, Docker), Sirius 5. Harish called the first pass "very very basic" and
  said it undersold the work. Every tag must be named in that job's bullets.
- The hero meta says "MS CS, Indiana University" where `#education` and the
  JSON-LD carry the full degree and "Indiana University Bloomington" —
  shortened so the smallest type in the hero doesn't make its longest line.
- `.job-id` wraps org + role + ext in one inline `.job-path` span so the
  filename reads as a single token. `.job-id` is a flex row with a 10px gap,
  and when the three spans were direct flex children it rendered as
  "heartland /software-engineer .py". Keep the gap between the path and the
  `current` badge only.
- `.job-list li` is capped at 74ch; uncapped, bullets ran ~119 characters
  per line.
- The `+` in `// Beyond the stack` items hangs in a 20px grid gutter level with
  the heading, and is `aria-hidden`. On its own line above the heading it
  read as stray punctuation and screen readers announced "plus" each time.
- `#contact` is two matching terminal panes on the same auto-fit grid as
  `#education`: `$ mail --to harish` on the left (address, copy button,
  bottom-anchored mail CTA) and `$ ls ~/links` on the right (GitHub, LinkedIn,
  resume as label/handle rows). It used to be one 480px card in a 1120px wrap
  with a button row underneath, which read as small and fallen to one side.
  The mail CTA stays `align-self: flex-start` — stretching it full width was
  tried on 2026-09-23 and shouts next to the quiet link pane.
- The `#contact` sub-line reads "Open to SDE roles and to relocation. Let's
  build something that matters — get in touch." Harish's wording, 2026-09-24:
  he rejected "if there's something worth building" as arrogant.
- GitHub and LinkedIn are both `harishsureshdev`
  (github.com/harishsureshdev, linkedin.com/in/harishsureshdev) as of
  2026-09-24. The old `github.com/harishs2000` returned 404, so every GitHub
  link on the site had been dead. `resume.pdf` still carries the old handles.
- There is NO top scroll-progress bar. It was removed on 2026-09-24: with
  the timeline fill growing down while the bar grew right, two green bars
  moved in different directions on every scroll and read as awkward.
- The nav mark is a link to `#top`, `clamp(15px, 4.4vw, 17px)`. A flat 17px
  pushed the nav icons 5px off-screen at 360px.
- A static `↓ scroll` cue sits at the bottom of the desktop hero. It never
  bounces, and it's hidden at <=680px and at max-height 720px.
- Theme toggle uses `document.startViewTransition` for a circular wipe from
  the button (`--vt-x/--vt-y`). `html.vt-running` kills transitions while it
  runs and is removed on `finished` AND by a 900ms timeout: if the promise
  ever stalls, leaving it on would disable every hover transition on the page.
- The name decode swaps `.hero h1` text for an `aria-hidden` span and puts the
  real name in `aria-label`. A 1s timeout forces the real name even if
  animation frames stall (background tab, throttling, headless).
- Cursor spotlight: `.hb-hot` is a second dot grid in `--hero-dot-hot`,
  masked to a 220px circle at `--mx/--my`, only under
  `(hover: hover) and (pointer: fine)`.
- `--selection` and `--hero-dot-hot` are tokens in both palettes; text
  selection, scrollbar and the palette caret/focus are themed from them.
- On phones (<=680px) EVERY job collapses to title and dates behind a
  `.job-toggle` button (44px tall, `aria-expanded`, `aria-controls` naming the
  list and tag row). Harish chose collapse-all over collapse-older-only on
  2026-09-24. Chips also drop their logos there. A button rather than
  `<details>` because details would break the >=1000px `.job` grid. The
  390px page went from ~10,000px to ~7,300px.
- Phones (<=680px) get a density pass: skill chips render as slash-
  separated mono text (no boxes, no logos) — Skills was 2,200px, 30% of the
  390px page. Separators are a fixed 28px `::before` box on EVERY chip; the
  row is pulled 28px left and the GROUP (`.skill-groups > div`) clips, so the
  slash that would start each line is hidden. Clipping the row itself does
  nothing — its box includes the 28px it was pulled. Also tighter
  Beyond-the-stack and project-card padding.
- Tap targets on phones are enlarged with invisible `::after` hit areas
  (icons, palette button, copy) and padding/negative-margin pairs (project
  links, footer and nav marks) so every visible control reaches ~44px without
  changing the visuals; the nav has no room for larger icons at 360px.
- Email, GitHub and LinkedIn appear in exactly TWO places: the nav icons
  (persistent, reachable from anywhere) and `#contact` (the destination the
  nav link points at). The footer used to repeat all three a third time,
  directly below the contact section — removed 2026-09-23. The footer is now
  just the `harish/suresh` mark, which doubles as back-to-top, and the
  copyright line. Don't put contact links back into it.
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
  removes itself on error, so a CDN miss degrades to a text-only chip. THREE
  chips are text-only, not one: Zustand has no Devicon icon, and
  `celery-original.svg` and `jwt-original.svg` both 404 at this tag (verified
  2026-09-24). Check a URL resolves before adding a chip icon.
- `.chip img` is `grayscale(1)` ONLY — never the `brightness(0)` trick used on
  `.edu-mark img`. The university marks are transparent line art, so
  flattening them works; Devicon logos are filled plates, so `brightness(0)`
  turns TypeScript and JavaScript into solid black squares. Tried and reverted
  on 2026-09-24. The point of the filter is to stop Java red and Redis red
  being the only saturated colour on a one-accent page.
- `.skill-groups` uses CSS multi-column (`columns: 290px`), not grid.
  `auto-fit` sized every track to the tallest group, leaving ~108px voids
  inside the short ones and stranding the last group alone in a three-up row.
- The skills section is headed "What I build with" (nav link and palette
  command say "Skills" — Harish rejected "Stack" for the nav on 2026-09-24): tool chips first, then the six principles under
  `// Beyond the stack`. Harish chose the order and the heading on
  2026-09-24. "How I build" was dropped because the first thing under it is a
  tool list. Principles-first read as a weak opener. He also declined a
  rewritten set of principles; the ORIGINAL six stay. Don't re-pitch either.
- `.beyond-item` is a grid (hanging `+` gutter) with `align-content: start`.
  Row neighbours stretch to equal height, and without it the shorter item
  spread the slack between its heading and its text.
- No heavy shadows, no gradients beyond the one subtle radial glow in the hero
- Motion: sections fade-slide-up on scroll via IntersectionObserver (`.reveal`,
  staggered with `--d`). Hero has its own staggered entrance, the nav mark and
  hero cycler share a blinking caret, and the current-role dot pulses. Every one
  of these is disabled under `prefers-reduced-motion` — keep it that way.

## Content rules

- POSITIONING: FULL-STACK, with applied AI. NEVER describe Harish as
  backend-anything — not "backend depth", "backend-leaning", "deepest in the
  backend", nothing — in any positioning sentence, the hero, contact line,
  meta/OG/Twitter descriptions, image alt text, or inside `assets/og.png`.
  He has objected THREE times (2026-09-23 "I'm not just a backend dev",
  2026-09-24 twice, the last "i keep telling you don't emphasise the backend
  part"). It kept coming back because this file used to carry a rule saying
  to keep the word "backend" in search copy. That rule is reversed: search
  relevance comes from the concrete tech names in the tags and JSON-LD
  `knowsAbout`, not from the word. The only "backend" on the page is the
  neutral `// Backend & APIs` chip-group label.
- Positioning is stated in EIGHT places and they must agree (and none may
  lean backend): the hero `.hero-stack` row, the cycler `phrases` (plus its
  `.sr-only` twin), the `#contact` sub-line, `meta[name=description]`,
  `og:description`, `twitter:description`, `og:image:alt`, and the role line
  rendered INSIDE `assets/og.png` (an image: it silently keeps saying the old
  thing unless regenerated from `tools/og.html`).

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
- Tone: confident, plain, technical. No marketing language, no "passionate
  about." This rule gets broken by DEGREES, not in one obvious step — the hero
  summary was rewritten on 2026-09-23 and came back reading as a brochure.
  What counted as marketing there, all of it cut: "build products end to end",
  "the React and TypeScript people actually touch", "put LLMs on live paths",
  "I like the parts people skip", "systems that hold up once real traffic hits
  them". The through-line is claims about ATTITUDE and RESILIENCE that nothing
  on the page can verify. State the stack and name the systems; let
  #experience carry the evidence. The summary is ~47 words and should stay in
  that range.
- Sections stay in this order: hero → what I build with → experience → projects →
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
- All three projects link to `github.com/harishsureshdev`, the profile, not to
  per-project repos. Harish still owes the specific repo URLs.
- Analytics is NOT wired up. Cloudflare Web Analytics / Umami both need a site
  token from Harish's own account, so it can't be added unattended. If the site
  lands on Cloudflare Pages it's a dashboard toggle and needs no code at all.
- `assets/og.png` is a GENERATED file, not hand-made — render it from
  `tools/og.html` (that file has the command in `tools/README.md`) rather than
  editing the PNG. Use a generous `--virtual-time-budget`: a short one silently
  captures the fallback fonts instead of JetBrains Mono and Epilogue.
- Hero background is a 21st.dev pattern ported from React/Tailwind to plain
  CSS (`.hero-bg`): corner lift, five skewed accent streaks, a dot grid and
  inline SVG grain. Recoloured from the original cyan to the accent green, and
  the grain is generated inline rather than fetched from `cdn.21st.dev`.
  It is deliberately faint — at full strength it washes the hero green.
  `.hero` keeps `overflow: hidden` to clip the skewed streaks.
- Zustand is the one stack chip with no logo (Devicon has no Zustand icon).
  Chips degrade to text-only on their own, so this is fine, not a bug.

## Verifying in headless Brave

- Toggling `data-theme` at runtime and reading `getComputedStyle` gives FALSE
  readings: `body` has `transition: color 0.3s`, and that transition never
  completes under virtual time, so inherited colours stay pinned at the
  pre-toggle value while rules with their own `color` snap immediately. It
  looks exactly like a broken light palette. To check a theme, set
  `localStorage.theme` in the parent page BEFORE the iframe loads and take a
  screenshot instead.
- Do NOT screenshot through a tall iframe. Wrapping the page in an iframe of
  e.g. 9000px to window into a lower region makes `100svh` resolve against
  THAT height, so `.hero`'s `min-height` balloons and its centred content
  lands thousands of pixels down — the capture comes back looking blank and
  broken. Set the iframe to the real viewport height and scroll inside it with
  `contentWindow.scrollTo` instead.
- Entrance animations can capture mid-flight and screenshot as empty. Inject
  `*{animation:none!important;transition:none!important}` plus
  `.reveal{opacity:1!important}` into the frame before capturing.
- `range.getClientRects()` on a FLEX container returns one rect per child,
  not per line, so "widest rect" silently measures the widest single span.
  `.hero-meta` read as 413px that way when the line was really 712px. Measure
  a flex row as its last child's right edge minus the container's left.
- Measure text only after `document.fonts.ready` — before it resolves, widths
  come from the fallback face and are meaningless for layout tuning.
- Headless dispatches no scroll events and never fires post-load `rAF`
  callbacks, `--screenshot` always captures from the document origin, and the
  viewport clamps to 500px minimum. Window into a region with an absolutely
  positioned iframe at a negative `top`, and use `behavior: "instant"` since
  `scroll-behavior: smooth` swallows programmatic scrolls.
- Pseudo-elements are invisible to `querySelectorAll('*')` overflow probes —
  isolate one by injecting `display: none` and re-measuring `scrollWidth`.

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
