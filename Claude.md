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
- Fonts are SELF-HOSTED (2026-09-27) in `assets/fonts/`: the Latin and
  Latin-extended subsets of both variable fonts (one woff2 per subset covers
  every weight; ~111KB total), with `font-display: swap`, the two Latin files
  preloaded, and the OFL licenses alongside. No request goes to Google.
  `tools/og.html` uses the same files. If a new weight or character set is
  needed, fetch it the same way; don't re-add the Google Fonts link.
- Fonts: JetBrains Mono for headings, nav, metadata, tags, dates and labels;
  Epilogue for body copy and bullet text. The mono headings are the site's
  defining trait — don't soften them back to sans.
- TYPE SCALE (2026-09-27): fixed sizes use six tokens only, `--fs-1`..`--fs-6`
  = 12 / 13 / 14 / 15.5 / 17 / 21px. They replaced 14 near-duplicate sizes
  (11.5 / 12 / 12.5, 15 / 15.5 / 16, 17 / 18, 21 / 22). Responsive display
  sizes (h1, h2, hero rows, the wall tiers, job and project titles) stay as
  `clamp()` on their own rules. Never add a new fixed px font size; pick a
  step. The smallest text on the page (tags, labels) is now 12px, up from
  11.5.
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
  the fold, including on a 360x740 Android: the portrait is 160px and
  CENTRED on phones (130px on the left read as small and stranded, Harish
  2026-09-27; 360x740 CTA bottom now 680) and mobile hero padding is 40/48px. Measure `.cta-row`'s BOTTOM edge against
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
- There is NO prose summary in the hero, and as of 2026-09-27 NO tech-stack
  row either. `.hero-stack` (react / spring boot / fastapi / aws / langchain,
  iterated repeatedly through 2026-09-24: rejected java/python/typescript/
  react/postgres as "simple", then neo4j swapped for Spring Boot, Docker
  swapped for AWS) was removed once the skills wall existed: the wall opens
  on the exact same five words, large and bold, one scroll away, so the hero
  copy was carrying information the page already stated. The hero now ends
  on the cycler; `.hero-line`'s margin-bottom grew from 18px to 32px to give
  the CTAs the room the removed row used to.
- The five core tools still have ONE canonical list: the wall's `.t1` items.
  `tools/og.html`'s stack row and the JSON-LD `knowsAbout` array are
  independent copies (not read from the DOM) and must be kept in step by
  hand if the five ever change. `whoami` in the terminal reads them live from
  `.wall .t1`, so it needs no separate update.
- The hero meta line is JUST "San Jose, CA · MS CS, Indiana University"
  (2026-09-27). "open to relocation" was dropped from it: Contact's sub-line
  already says "Open to SDE roles and to relocation", and an earlier version
  forced the meta to break after "relocation" at EVERY width, including
  2000px, to avoid a two-dot line, wasting the row's width on every screen
  size. Now it only breaks where the content doesn't fit.
- The hero's two wrapping rows break at a chosen separator marked
  `.wrap-here` (a full-width invisible line break), each on its OWN measured
  breakpoint: the meta line below 480px (measured 2026-09-27, after dropping
  "open to relocation"; re-check if the text changes again), the keyword row
  below 750px (it fits on one line from ~760). Left to wrap freely they
  stranded a `·` or `/` at a line end. If you change either row's text,
  re-run the width sweep.
- The hero meta line ALWAYS breaks after "relocation" (its `.wrap-here` rule
  applies at every width, not just phones), so it's two lines everywhere:
  "San Jose, CA · open to relocation" / "MS CS, Indiana University".
- On phones the badge drops its `.badge-role` ("software engineer, ") so it
  reads "// 2+ yrs · open to SDE roles" on one line; the full badge wrapped as
  "open to / SDE roles".
- Under the forced line break (<=480px) `.hero-meta` uses
  `row-gap: 0`. The `.wrap-here` element is its own zero-height flex line, so
  it collected a row gap on both sides and every wrap got double spacing; a
  zero-height line can't take a negative margin, so the gap has to go.
- The phone `.nav-mark` hit-area fix uses margin-top/-bottom, NEVER the
  `margin` shorthand: the shorthand zeroed `margin-right: auto`, which is what
  pushes the nav icons to the right edge (they sat ~60px short on 2026-09-25).
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
- Education is a two-card grid of FILES, matching Experience (2026-09-25):
  a path title as an `h3` (`iu-bloomington/ms-cs.md`,
  `anna-university/be-cs.md`), a `//` comment line for dates and place, then
  `degree` / `school` / `gpa` key-value lines. The university crest tiles
  were dropped at Harish's choice: generic card UI outside the editor world,
  and the Anna crest never survived being shrunk. `assets/iu.png` and
  `assets/au.png` are still on disk, unused.
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
- EXPERIENCE PANS SIDEWAYS (2026-09-27, Harish asked for "horizontal scroll or
  something lively"; he had rejected a static Warden diagram). `#experience` is
  `.hpin`: a tall `.hpin-runway` holding a `position: sticky` `.hpin-sticky`,
  and JS drives the `.timeline` track with `translate3d` from scroll progress.
  Newest role on the left. A fixed rail with three stations (heartland, sify,
  sirius) fills as you pan and its dots are buttons that jump to a role; a
  dashed `.hpin-gap` marks 2024-2026 (MS CS). Cards get two-column bullets and
  the stack row underneath, at 14px, because a card plus header has to fit one
  screen. Progressive enhancement: JS adds `.is-pinned` only at
  `(min-width:1000px) and (min-height:700px)` with motion allowed, and UNPINS
  again if the tallest card plus header does not fit the sticky frame (about
  675px of usable height). Everywhere else, the vertical self-drawing timeline
  and the phone collapse buttons above are what shows, unchanged. Focus moving
  into an off-screen card scrolls it in (`behavior: "instant"`, since "auto"
  inherits `scroll-behavior: smooth`). Cards are unevenly spaced, so progress
  maps to the track offset piecewise. Projects stay a normal vertical stack; a
  pan needs richer cards than three thin ones. A Warden "policy gate" animation
  was prototyped and cut until Harish's project content exists.
- The skills wall has a pointer lens: `--p` (0..1) per word, set from cursor
  distance (150px), mixes the tier colour toward the accent with `color-mix()`
  and lifts the word 3px with the individual `translate` property (not
  `transform`, which the settle-in animation holds). Fine pointers only.
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
  build something that matters. Get in touch." Harish's wording, 2026-09-24:
  he rejected "if there's something worth building" as arrogant.
- GitHub and LinkedIn are both `harishsureshdev`
  (github.com/harishsureshdev, linkedin.com/in/harishsureshdev) as of
  2026-09-24. The old `github.com/harishs2000` returned 404, so every GitHub
  link on the site had been dead. The new `resume.pdf` carries the new handles too.
- There is NO top scroll-progress bar. It was removed on 2026-09-24: with
  the timeline fill growing down while the bar grew right, two green bars
  moved in different directions on every scroll and read as awkward.
- The nav mark is a link to `#top`, `clamp(15px, 4.4vw, 17px)`. A flat 17px
  pushed the nav icons 5px off-screen at 360px.
- There is NO scroll cue. A static `↓ scroll` was added on 2026-09-24 and
  removed on 2026-09-27: the design-taste skill bans scroll cues outright
  ("if they haven't scrolled, they're looking at the hero").
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
- The light palette declares `color-scheme: only light` (index.html AND
  404.html). Plain `light` let Chrome's Android auto dark mode (and similar
  browser dark modes) re-darken the light theme into a muddy dark page, so the
  toggle looked broken on Harish's phone (2026-09-27); the dark theme escaped
  only because it declares `dark`. Reproduce in headless with
  `--enable-features=WebContentsForceDark --force-dark-mode`. `syncToggle()`
  also sets `meta[name=theme-color]` from `--bg`, so the phone's address bar
  follows the theme.
- `--selection` and `--hero-dot-hot` are tokens in both palettes; text
  selection, scrollbar and the palette caret/focus are themed from them.
- On phones (<=680px) EVERY job collapses to title and dates behind a
  `.job-toggle` button (44px tall, `aria-expanded`, `aria-controls` naming the
  list and tag row). Harish chose collapse-all over collapse-older-only on
  2026-09-24. A button rather than
  `<details>` because details would break the >=1000px `.job` grid. The
  390px page went from ~10,000px to ~7,300px.
- Phones (<=680px) get tighter Beyond-the-stack and project-card padding.
- Narrow-phone fit (2026-09-27): the `.contact-grid` and `.edu-grid` columns use
  `minmax(min(Npx, 100%), 1fr)`, because a bare 330/340px minimum overflowed
  the right gutter below ~370px wide. On <=480px the hero CTA pair spans the row
  (`flex: 1 1 auto`, and `.hero-content` stretches in the column layout), and the
  contact email is sized to the pane (`clamp(12px, 5vw - 4.5px, --fs-5)`) so its
  33 characters never break mid-word. Link rows wrap, so the LinkedIn handle
  drops under its label instead of overflowing.
- Tap targets on phones are enlarged with invisible `::after` hit areas
  (icons, copy) and padding/negative-margin pairs (project
  links, footer and nav marks) so every visible control reaches ~44px without
  changing the visuals; the nav has no room for larger icons at 360px.
- Email, GitHub and LinkedIn appear in exactly TWO places: the nav icons
  (persistent, reachable from anywhere) and `#contact` (the destination the
  nav link points at). The footer used to repeat all three a third time,
  directly below the contact section — removed 2026-09-23. The footer is now
  just the `harish/suresh` mark, which doubles as back-to-top, and the
  copyright line. Don't put contact links back into it.
- The command palette has NO visible trigger: the nav search button was
  removed on 2026-09-25 at Harish's request once the terminal existed, and
  the `>_` terminal button took its slot. ⌘K / Ctrl-K still opens it as a
  hidden shortcut. It holds its actions in one `commands` array, hoisted OUT of the palette block (with
  `go()` and `runCommand(label)`) so the terminals reuse it rather than
  defining their own copy.
- TERMINAL, built 2026-09-24, two front ends over one `termCmds` engine:
  an in-page `<dialog id="term">` (opened by the backtick key, the `>_` nav
  button, or ⌘K "Open terminal"), and the browser dev console, where the commands are
  global functions (`help()`, `whoami()`, `cat("warden")`, `sudo()`…) and a
  styled banner greets anyone who opens devtools. Commands: help, whoami, ls,
  cd, cat, stack, resume, hire, github, linkedin, theme, sudo, no, clear,
  exit, rm. The in-page terminal has history (up/down arrows) and Tab
  completion for commands and cd/cat arguments. `whoami`, `cat` and `stack`
  READ THE PAGE (hero, project cards, skill groups) rather than holding their
  own copy, so they can't drift. `sudo` is always "Permission denied." plus a
  No-as-a-Service reason, EXCEPT `sudo hire …`, which is granted and opens
  mail. Harish didn't know what the dev console was; he chose both front
  ends after it was explained.
- The terminal is DESKTOP ONLY. The `>_` button and the palette's "Open
  terminal" entry are hidden under `(max-width: 680px), (pointer: coarse)`
  — narrow screens and any touch-first device, tablets included. Harish, on
  2026-09-25: "terminal on mobile sucks". The dev-console version is
  unaffected (phones don't have devtools anyway).
- No-as-a-Service (naas.isalman.dev/no, CORS open, rate-limited) is called
  ONLY when someone runs `sudo` or `no`, never on load, so visitor IPs don't
  go to a third party unasked. A 2s timeout falls back to a local list of
  original lines. The repo (github.com/hotheadhacker/no-as-a-service) is
  credited in `help`. Harish chose console-only placement for it: keep it off
  the visible page, since a "no" joke on a hiring page can read as arrogant. The nav button stays visible at
  every width.
- Projects read as repos (2026-09-27): each title is a README path
  (`warden/README.md`, `home-credit-default-analysis/README.md`,
  `snapsend/README.md`) with a `<wbr>` after the slash so the long one breaks
  there on phones. At >=1000px the tags move into a right "// stack" rail,
  same pattern as `.job`. The terminal's project keys split on "/" so
  `cat warden` and Tab completion stay clean.
- Project cards print everything inline — lead paragraph, a `// label`, the
  detail paragraph, then tags. They used to expand (whole-card click, a
  `grid-template-rows: 0fr -> 1fr` panel). That was REMOVED on 2026-09-23 after
  measuring the panels at 20-33 words each: a click that reveals two sentences
  is friction between a recruiter and the best material on the card. Don't
  re-add an expand/modal unless the detail grows past roughly a paragraph per
  card — at which point the old implementation is in git history at 0963169.
- `html` carries `overflow-x: clip`. Do NOT add `overflow-x: hidden` to `body`:
  together they make body the scroll container, which silently kills the
  sticky nav. Verified — it is not a theoretical concern.
- SKILLS WALL (2026-09-27): all 44 skills (resume skills, plus Node.js and
  MongoDB for Sirius) are one `<ul class="wall">`,
  weighted by size and brightness instead of boxes. `.t1` = the five the hero
  leads with (also the hero badge/meta era's old .hero-stack; that row is
  gone, this is the one place the five are still spelled out on the page),
  `.t2` = named in an
  experience or project tag, `.t3` = the rest; the order interleaves sizes so
  no tier clusters. Each `<li>` carries `data-group` so the terminal's `stack`
  command still prints skills by category. Word spacing is `margin-right:
  0.5em` in each word's OWN em (a flat gap crowded the big words). Chosen by
  Harish after rejecting, in order: chip grid, grep-on-hover (exposes skills
  with no evidence), stack.yml (bad on phones), type-in on scroll, featured
  proof tiles and rows ("proofs not worthy of a card"), and a system-layer
  diagram. Devicon and every chip logo are gone — 24 fewer CDN requests.
- The skills section is headed "What I build with" (nav link and palette
  command say "Skills" — Harish rejected "Stack" for the nav on 2026-09-24): the skills wall first, then the six principles under
  `// Beyond the stack`. Harish chose the order and the heading on
  2026-09-24. "How I build" was dropped because the first thing under it is a
  tool list. Principles-first read as a weak opener. He also declined a
  rewritten set of principles; the ORIGINAL six stay. Don't re-pitch either.
- `.beyond-item` is a grid (hanging `+` gutter) with `align-content: start`.
  Row neighbours stretch to equal height, and without it the shorter item
  spread the slack between its heading and its text.
- No heavy shadows, no gradients beyond the one subtle radial glow in the hero
- Motion (2026-09-27): sections NO LONGER fade up on scroll. Every section
  entering the same way read as a template and dulled the moments that
  matter. `.reveal` is used by exactly ONE element, the skills wall, whose
  words settle in by weight (t1, then t2 at 0.18s, then t3 at 0.36s). The
  other scroll-linked motion is the timeline drawing itself. The hero keeps
  its one-shot entrance, the nav mark and cycler share a blinking caret, and
  the current-role dot pulses. All of it is off under
  `prefers-reduced-motion`.
- No-JS safety: CSS never hides content on its own. JS adds `.reveal-pending`
  (the hidden state) only once an IntersectionObserver exists to remove it,
  so if the script fails to load, everything simply shows. Verified by
  loading the page with the main script stripped out. Don't reintroduce a
  bare `.reveal { opacity: 0 }`.

- AESTHETIC, named: "warm terminal" — the site is a code editor used as a
  portfolio. Filenames as titles, `//` comments as labels, `$` prompts, mono
  for structure, warm near-black, one phosphor-green accent, flat hairlines.
  A new section should use that vocabulary.

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
  `knowsAbout`, not from the word. Since the skills wall replaced the chip groups
  (2026-09-27), "backend" appears nowhere visible on the page; it survives
  only as a `data-group` value the terminal's `stack` command prints as a
  category name.
- Positioning is stated in EIGHT places and they must agree (and none may
  lean backend): the wall's `.t1` row (the hero's own stack row was
  removed 2026-09-27), the cycler `phrases` (plus its
  `.sr-only` twin), the `#contact` sub-line, `meta[name=description]`,
  `og:description`, `twitter:description`, `og:image:alt`, and the role line
  rendered INSIDE `assets/og.png` (an image: it silently keeps saying the old
  thing unless regenerated from `tools/og.html`).

- Every claim must be true and traceable to my actual resume/projects — do not
  invent metrics, testimonials, or experience I don't have.
- `resume.pdf` was replaced on 2026-09-27 with Harish's current resume
  (source: ~/Downloads/Latest Resumes/Harish-Suresh.pdf), and the site was
  re-reconciled to it the same day: Heartland title "Software Development
  Engineer", 5 bullets incl. draft-state cleanup; Sify 7 bullets incl.
  AngularJS dashboards and code reviews; Warden now Gemini API, 39-40/40 eval,
  12/12 blocked vs 3-5/12 prompt-only (the old "11 of 12" and "step caps" are
  gone); SnapSend JWT, 24-hour links, 2 GB presigned multipart uploads; Anna
  CGPA 8.6. The resume uses en-dashes; the site converts them to hyphens.
  If the resume changes again, re-reconcile the same way.
- Deliberate divergences from `resume.pdf` — don't "fix" either silently:
  1. Sirius Technologies (May-Aug 2020) is on the site but NOT on the resume.
     Harish reconfirmed on 2026-09-27: keep it.
  2. Home Credit Default Risk is on the site but NOT on the current resume.
     Harish confirmed on 2026-09-27: keep it for now, he'll edit the card
     later. Don't drop or rewrite it unprompted.
- ZERO em-dashes (and no en-dashes as separators) in anything a person reads:
  page copy, the `<title>`, meta/OG/Twitter text, `og:image:alt`, the share
  image and terminal output. Date and number ranges use a hyphen
  ("Aug 2022 - Jul 2024", "15-20"); sentences use a comma, colon, full stop
  or parentheses. Middle dots: at most ONE per line. Harish adopted both
  rules from the design-taste skill on 2026-09-27; 18 dashes were rewritten
  without changing any fact.
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
- Warden links to `github-triage-agent` and Home Credit to
  `home-credit-default-analysis` (2026-09-27). SnapSend still links to the
  profile; Harish owes that repo URL. The HCDR repo is one notebook with no
  README and reads as a course project ("our" team write-up): its best model
  was tuned logistic regression at 0.734 (top 40%), ahead of the PyTorch MLP at
  0.728, which the card now says. Whether to label it a course/team project is
  Harish's call. The Warden card's "what the eval showed" paragraph comes from
  that repo's README, including its own caveat that 12/12 holds by construction.
- Analytics is NOT wired up. Cloudflare Web Analytics / Umami both need a site
  token from Harish's own account, so it can't be added unattended. If the site
  lands on Cloudflare Pages it's a dashboard toggle and needs no code at all.
- No `robots.txt` / `sitemap.xml` before 2026-09-27; both now exist at the
  repo root, referencing `https://harishsuresh.dev/`. Update `sitemap.xml`'s
  `lastmod` on a real content change, not a typo fix.
- `.skip-link` (2026-09-27): a keyboard-only "Skip to content" landing on
  `#main`, `<main id="main">`. Hidden via `top: -100%`, not `display: none`,
  so it stays in the tab order and simply moves on `:focus-visible`.
- `assets/og.png` is a GENERATED file, not hand-made — render it from
  `tools/og.html` (that file has the command in `tools/README.md`) rather than
  editing the PNG. It loads the self-hosted fonts from `assets/fonts/`.
- Hero background (2026-09-25): a dot grid (graph paper), inline SVG grain,
  the cursor spotlight, and ONE faint `--accent-soft` glow in the top-left
  corner (`.hb-glow`). The 21st.dev diagonal streaks and corner lift were
  removed: pure decoration with no meaning in the editor aesthetic, a visible
  diagonal seam at wide widths, and a mint wash over the warm cream in light
  mode. `.hero` keeps `overflow: hidden`.
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
- Reading `getComputedStyle` right after triggering a CSS TRANSITION (focus,
  hover, a class toggle) can catch it mid-interpolation under virtual time,
  reporting neither the start nor end value and looking like the rule never
  matched. Verified on `.skip-link:focus-visible` on 2026-09-27: reading
  `top` immediately after `.focus()` showed no change; injecting
  `transition: none !important` first showed the correct `12px`. Isolate
  transition timing from a cascade question the same way, or use
  `:focus-visible` matched via `.matches(':focus-visible')` rather than
  `.focus()` alone — script-triggered `.focus()` alone does not reliably
  produce `:focus-visible` outside headless either.

## Editing this file safely

- When removing a CSS or JS block by cutting from its start marker to the
  NEXT section marker, check what else sits in between. On 2026-09-25 cutting
  the `.kbd-hint` block "up to the Footer heading" also deleted the entire
  terminal stylesheet, which had been inserted in that gap. Functional checks
  (dialog opens, no overflow) passed; the terminal just rendered unstyled.
  After any block removal, grep for the neighbouring features' selectors,
  and verify STYLING (a computed style), not only behaviour.

## Workflow preferences

- Keep it a single HTML file until there's a real reason to split it
  (e.g. adding a build step, a second page, or a CMS-like project data source).
- When adding a project card, pull structure from the existing ones in
  `#projects` rather than inventing new markup patterns.
- Ask before changing color tokens, fonts, or spacing scale — cosmetic tweaks
  within the existing system are fine without asking.
- After any visual change, describe what changed in plain terms rather than
  just diffing code, since I'm reviewing on look/feel, not implementation.

## Deploy-ready pieces

- `404.html` (repo root) is a standalone shell-error page: `cd /missing:
  No such file or directory`, an `ls` of the sections and a `cd ~` home
  button. Hosts (Cloudflare Pages, Netlify, GitHub Pages) serve it for any
  missing path, so every URL in it is ROOT-ABSOLUTE (`/assets/...`,
  `/#work`); opened from disk its font falls back, which is expected. Its
  colours are COPIES of the site tokens (it can't share the stylesheet);
  change both if the palette changes. The missing path is inserted as text
  only, and a malformed %-escape falls back to the raw path.
- Print stylesheet (`@media print` in index.html): white tokens (the
  `:root:not(#_)` selector is deliberate, it must outrank the light-theme
  `:root:not([data-theme="dark"])`), no nav/portrait/effects/buttons, the
  cycler replaced by its static sentence, every job expanded, entrance
  animations forced visible (a printer never plays them, and the hero once
  printed EMPTY), no card, bullet or tag row split across a page break (jobs themselves MAY split between bullets: kept whole, each tall job took its own page and printing ran to 8 pages), and headings, sub-lines and job titles never end a page. Seven Letter pages as of 2026-09-27.

## Deployment target

- Domain: harishsuresh.dev, bought on Cloudflare Registrar 2026-09-27 (not
  GoDaddy). ICANN email verification is due within 14 days of purchase.
- LIVE at https://harishsuresh.dev since 2026-09-27 (Worker `harishsuresh-dev`).
- Host: Cloudflare Workers static assets. `build.sh` copies ONLY the public
  files into `dist/` (gitignored); `wrangler.jsonc` runs it as its build
  command, so every `npx wrangler deploy` (`./deploy.sh`, or Cloudflare's own
  build on push) rebuilds it. `404.html` serves missing paths. `worker.js`
  301s `www.harishsuresh.dev` to the apex with path and query kept; that needs
  `run_worker_first: true`, or a www request for an existing file would be
  served without redirecting. Both hostnames are custom domains on the Worker.
- Source is the PRIVATE repo github.com/harishsureshdev/portfolio (private
  because Claude.md holds working notes). Auto-deploy is Cloudflare Workers
  Builds connected to `main`. NEVER point the assets directory at the
  repo root: that would publish Claude.md, tools/ and the hook configs. A new
  public file must be added to deploy.sh's copy list, or it won't ship.
