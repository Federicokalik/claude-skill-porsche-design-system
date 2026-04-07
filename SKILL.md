---
name: porsche-design-system
description: >-
  Build web interfaces using the Porsche Design System (PDS), a web-components
  design system with Tailwind CSS theme integration. Use this skill whenever the
  user mentions "Porsche Design System", "PDS", "Porsche style", "Porsche
  components", or references PDS components like PButton, PHeading, PWordmark, or
  asks to build UI with Porsche's design language, tokens, or theming. Covers setup
  for Astro, React (Vite), Next.js, React Router, and Vanilla JS, for both v3 and
  v4 with major API differences. All snippets use Tailwind CSS v4 with the PDS
  theme. IMPORTANT — PDS has a hybrid license (Apache 2.0 source + restrictive
  brand assets). Non-Porsche projects in any industry are permitted if the result
  is "dissimilar and visually distinct from Porsche products". Porsche brand
  components (wordmark, crest, model signature, flag) must never be used outside
  a Porsche context. For non-Porsche projects, advise customizing colors and font.
  Refuse only for direct Porsche competitors or projects imitating the Porsche look.
---

# Porsche Design System (PDS) skill

This skill provides setup, code snippets, design tokens and patterns for building web interfaces using the Porsche Design System. PDS is based on **Web Components** (Stencil.js under the hood) with framework-specific wrappers for React, Vue, Angular, and direct bindings for Vanilla JS/HTML/Astro.

The skill supports **two versions in parallel** — v3 and v4 — because they have significantly different APIs and the team keeps both actively maintained (v4 is the current release, v3 is stable and more widespread).

## ⚠️ Mandatory CHECK before starting: licensing and usage context

**BEFORE writing any PDS code**, verify the user's project context and apply the licensing rules. PDS is not a generic MIT UI library — it is released under a hybrid license (Apache 2.0 for source code + restrictive license for brand assets). The license **does permit** using PDS for non-Porsche projects in any industry, but under one constraint: the visual result must be **"dissimilar and visually distinct from Porsche products and services"**, at Porsche's sole discretion. The sector does not matter; the visual outcome does. Read `references/licensing.md` for full details and use this decision tree:

- Is the project for Porsche, one of its subsidiaries, or an official partner? → **OK, proceed normally, including brand assets (`<p-wordmark>`, `<p-crest>`, etc.).**
- Is the project **non-Porsche** (any industry, including automotive, SaaS, e-commerce, B2B, etc.)? → **Proceed, but apply the rules for "visual distinction"**: (1) do NOT use brand components `<p-wordmark>`, `<p-crest>`, `<p-model-signature>`, `<p-flag>`; (2) consider overriding the primary color palette via CSS variables if you want a distinctive visual identity; (3) consider overriding the Porsche Next font with an alternative (Inter, Manrope, etc.); (4) do not copy layouts/imagery from porsche.com.
- Is the project a **direct competitor of Porsche** (other premium sports car manufacturers, Porsche-competing tuners, services positioning themselves as Porsche alternatives)? → **STOP. Suggest alternatives** (Radix UI, shadcn/ui, HeroUI, Mantine, Park UI, etc.). Even with visual distinction, the combination "automotive context + PDS technology" creates consumer confusion about affiliation.
- Is the goal explicitly to **"look like Porsche"** to capitalize on the premium aesthetic (even outside automotive)? → **Warn the user**: this violates the "dissimilar and visually distinct" clause. Suggest either differentiating the visual identity or using a different design system.

This is the first check to perform. PDS is a solid technical foundation (accessible components, good theming, performant) usable in many contexts — but the brand elements (wordmark, crest, Porsche Next font as the primary dominant) stay locked to the Porsche context.

## Which version to use?

Ask the user which version of the package they have installed or want to install. In general:

- **v4** (`@4` package) is the current release, with a new design language, color system based on CSS `light-dark()` and `color-scheme`, mandatory stylesheet import, and removal of several deprecated components. Use v4 for **new projects**.
- **v3** (`@3` package) is still widespread, has different APIs (theming via `theme="light|dark|auto"` attribute, `PorscheDesignSystemProvider` with theme prop, mandatory `getInitialStyles()` partial, etc.). Use v3 if the user **is already working on an existing v3 project**.

If the user does not specify, **default to v4** (it is the active release recommended by the PDS team).

The key differences between v3 and v4 are documented in `references/v3-vs-v4.md` — ALWAYS read it before generating code if the project mixes references from both versions, or if the user passes you v3 code to migrate to v4.

## Skill structure

```
porsche-design-system/
├── SKILL.md                      # (this file) triggers, workflow, quick reference
├── references/
│   ├── licensing.md              # License, when NOT to use PDS, recommended alternatives
│   ├── v3-vs-v4.md               # Key differences between v3 and v4, concise migration guide
│   ├── setup-astro.md            # Complete Astro + Tailwind setup (v3 and v4)
│   ├── setup-react-vite.md       # React/Vite + Tailwind setup (v3 and v4)
│   ├── setup-nextjs.md           # Next.js App Router + Tailwind setup (v3 and v4)
│   ├── setup-react-router.md     # React Router + Tailwind setup (v3 and v4)
│   ├── setup-vanilla.md          # Vanilla JS / HTML / pure Astro setup (v3 and v4)
│   ├── tokens-colors.md          # Color tokens, color-scheme, semantic colors, theming
│   ├── tokens-spacing.md         # Fluid & static spacing, gap, padding, margin
│   ├── tokens-typography.md      # Font face, prose-*, heading sizes, text sizes
│   ├── components-catalog.md     # PDS v3/v4 component list, when to use what
│   ├── components-snippets.md    # Ready-to-use snippets of the most common components
│   ├── patterns-layout.md        # Layout patterns: hero, card grid, form, header, footer
│   └── tailwind-pds-utilities.md # PDS-specific Tailwind utilities (bg-surface, gap-fluid-md, prose-*, etc.)
└── scripts/
    └── check-updates.sh          # Script to check the current version via npm registry
```

## Recommended workflow

Follow these steps when the user asks you to do something with PDS:

**Step 1 — Verify context and license.** If the project context is not clear from the conversation or memory, explicitly ask what it is about and apply the decision tree in "⚠️ Mandatory CHECK" above. Do not skip this step.

**Step 2 — Identify the target framework.** Astro? Astro + React islands? Next.js App Router? Pure React with Vite? React Router? Vanilla HTML? Load the corresponding `references/setup-<framework>.md` file.

**Step 3 — Identify the version.** v3 or v4? If not specified, ask or default to v4. Every setup file has separate sections for v3 and v4.

**Step 4 — Apply setup.** Follow the reference file guide exactly, including: package installation, Provider wrap, global stylesheet import (v4) or partials (v3), Tailwind theme import, lightning CSS polyfill (v4 with Vite 8+).

**Step 5 — Use components and tokens.** For every snippet you generate, use PDS design tokens — spacing, colors, prose classes — via the PDS Tailwind utilities (e.g. `gap-fluid-md`, `bg-surface`, `prose-heading-lg`, `text-primary`). Do not hardcode custom pixel colors or spacings if an equivalent token exists. Load `references/tokens-*.md` and `references/tailwind-pds-utilities.md` for the complete list.

**Step 6 — Build components.** For complex UIs, draw from the patterns in `references/patterns-layout.md` and the snippets in `references/components-snippets.md`. Always prefer native PDS components over custom versions when an equivalent exists (e.g. `PButton` instead of a styled `<button>`).

## Hard rules (non-negotiable)

These rules protect output quality and consistency with the Porsche design language. Do not skip any of them.

**Tailwind CSS is mandatory.** All skill snippets use Tailwind v4 with the PDS theme (`@import '@porsche-design-system/components-{js|react}/tailwindcss'`). Do not write custom CSS if an equivalent PDS Tailwind utility exists. If the user explicitly asks not to use Tailwind, warn them they are giving up an important part of the PDS ecosystem and ask for confirmation before proceeding with only Web Components + pure CSS.

**The theme is always `auto` (v3) or `scheme-light-dark` (v4).** Unless the user explicitly asks for light-only or dark-only, always set the theme to follow the user's system preference. In v3 this means `<PorscheDesignSystemProvider theme="auto">` or `theme="auto"` attribute on components. In v4 this means adding `class="scheme-light-dark"` to the `<body>`.

**In Next.js / React Router / Remix, ALWAYS use the `/ssr` sub-package.** All imports must come from `@porsche-design-system/components-react/ssr`, not from `@porsche-design-system/components-react`. This applies both to the Provider and to individual components (PButton, PHeading, etc.). It is required for Declarative Shadow DOM rendering.

**Configure `process.browser` in Vite configs for SSR React.** For Next.js, React Router and Remix with Vite, you need `define: { 'process.browser': JSON.stringify(!isSsrBuild) }` in `vite.config.ts` — otherwise server-side code leaks into the client bundle.

**In v4, disable the lightningcss `light-dark()` polyfill** with `exclude: Features.LightDark` (Vite 8+) or `lightningCssFeatures: { exclude: ['light-dark'] }` (Next.js Turbopack). The polyfill is broken and breaks colors.

**In v4 you need a manual CSS rule for FOUC prevention.** Add to the global stylesheet: `:not(:defined) { visibility: hidden; }` (Vanilla/React/Astro), `:not(:defined,[data-ssr]) { visibility: hidden; }` (Next.js/React Router). v3 handles this automatically with `getInitialStyles()`.

**Deprecated components → use the modern equivalent.** If the user mentions components like `p-flex`, `p-grid`, `p-headline`, `p-marque`, `p-button-group`, `p-content-wrapper`, `p-checkbox-wrapper`, `p-radio-button-wrapper`, `p-select-wrapper`, `p-text-field-wrapper`, `p-textarea-wrapper`, `p-fieldset-wrapper`, `p-display` (v4), `p-link-social`, `p-link-tile-model-signature` (v4), they are DEPRECATED or REMOVED. See `references/v3-vs-v4.md` for the complete mapping to their equivalents. ALWAYS generate code with the modern components — mention deprecated ones only if the user is migrating old code.

**PDS components are Web Components with Shadow DOM.** You cannot style them with CSS selectors from the outside (`.my-button p-button { color: red }` does not work). Use the component props or the documented CSS custom properties (e.g. `--p-modal-pt`, `--p-flyout-width`). Tailwind classes apply only to the outer HTML wrapper, not to the inside of the component.

**Porsche Next font.** PDS automatically includes the Porsche Next font via the partials (`getFontLinks()` / stylesheet import). Do not import alternative Google Fonts — it would break the typographic consistency of the design language.

**Do not hardcode Porsche colors.** The palette is proprietary to the brand. Do not copy hex values from screenshots or from porsche.com — ALWAYS use PDS tokens via CSS variables (`var(--p-color-primary)`) or Tailwind utilities (`bg-surface`, `text-primary`). The color system changes between v3 and v4.

## Quick reference — most common components

This mini-table covers 90% of use cases. For the full catalog see `references/components-catalog.md`.

| What you want to do | v3 (React) | v4 (React) | Vanilla HTML |
|---|---|---|---|
| Primary button | `<PButton>Label</PButton>` | `<PButton>Label</PButton>` | `<p-button>Label</p-button>` |
| Secondary button | `<PButton variant="secondary">` | `<PButton variant="secondary">` | `<p-button variant="secondary">` |
| Large heading | `<PHeading size="x-large">` | `<PHeading size="xl">` (v4 uses sm/md/lg/xl/2xl) | `<p-heading size="xl">` |
| Display/hero text | `<PDisplay size="large">` | ❌ removed → use `<PHeading size="5xl">` | `<p-heading size="5xl">` |
| Paragraph | `<PText>Content</PText>` | `<PText>Content</PText>` | `<p-text>...</p-text>` |
| Inline link | `<PLinkPure href="...">` | `<PLinkPure href="...">` | `<p-link-pure href="...">` |
| CTA link | `<PLink href="..." variant="primary">` | `<PLink href="..." variant="primary">` | `<p-link href="..." variant="primary">` |
| Text input | `<PTextFieldWrapper>` + `<input>` | `<PInputText label="..." name="...">` | `<p-input-text label="..." name="...">` |
| Checkbox | `<PCheckboxWrapper>` + `<input>` | `<PCheckbox label="..." name="...">` | `<p-checkbox label="..." name="...">` |
| Select | `<PSelectWrapper>` + `<select>` | `<PSelect>` + `<PSelectOption>` | `<p-select>` + `<p-select-option>` |
| Grid | `<PGrid>` + `<PGridItem>` | ❌ removed → `<div class="grid grid-cols-3">` | same |
| Flex | `<PFlex>` + `<PFlexItem>` | ❌ removed → `<div class="flex">` | same |
| Wordmark logo | `<PWordmark />` | `<PWordmark />` | `<p-wordmark></p-wordmark>` |
| Modal | `<PModal heading="..." open={open}>` | `<PModal open={open}>` + `<PHeading slot="header">` | `<p-modal open>` + `<p-heading slot="header">` |
| Toast | `toastManager.addMessage(...)` | same | same |
| Icons | `<PIcon name="arrow-right" color="primary">` | `<PIcon name="arrow-right" color="primary">` | `<p-icon name="arrow-right">` |

## Quick reference — most used PDS Tailwind utilities

```
# Spacing (use gap-*, p-*, m-* with these tokens):
  fluid-xs, fluid-sm, fluid-md, fluid-lg, fluid-xl, fluid-2xl       (responsive clamp())
  static-2xs, static-xs, static-sm, static-md, static-lg, static-xl, static-2xl  (fixed in px)
  Example: gap-fluid-md, p-static-lg, m-fluid-xl

# Background & colors (use bg-*, text-*, border-*):
  canvas, surface, frosted, frosted-soft, backdrop                   (background)
  primary, contrast-high, contrast-medium, contrast-low              (foreground)
  info, success, warning, error                                       (semantic)
  focus                                                                (a11y)
  Example: bg-surface, text-primary, border-contrast-low

# Typography:
  prose-heading-sm / md / lg / xl / 2xl / 3xl / 4xl / 5xl             (headings)
  prose-text-2xs / xs / sm / md / lg / xl                             (body text)
  Example: className="prose-heading-xl" for a large title

# Border radius:
  rounded-sm, rounded-md, rounded-lg, rounded-xl, rounded-2xl         (design tokens)

# Grid layout (v4 recommends standard CSS grid):
  grid-template, col-extended, col-wide, col-basic, col-narrow         (Porsche Grid utilities)
```

The `references/tailwind-pds-utilities.md` file contains the extended reference with examples.

## Documentation updates

The snapshot in `references/` was captured on **2026-04-04** from the official documentation at `https://designsystem.porsche.com/v3/` and `https://designsystem.porsche.com/v4/`. If the user reports that something is not working and you suspect the API has changed, run `scripts/check-updates.sh` to check the current version on the npm registry, or do a direct `web_fetch` on one of the official pages to compare.

## Official resources

- Docs v4 (current): `https://designsystem.porsche.com/v4/`
- Docs v3 (stable): `https://designsystem.porsche.com/v3/`
- GitHub repo: `https://github.com/porsche-design-system/porsche-design-system`
- Examples & templates: `https://github.com/porsche-design-system/examples`
- npm — Vanilla JS: `@porsche-design-system/components-js`
- npm — React: `@porsche-design-system/components-react`
- npm — React SSR (Next.js/Remix/React Router): `@porsche-design-system/components-react/ssr`
- Migration guide v3→v4: `https://designsystem.porsche.com/v4/news/migration-guide/porsche-design-system/`
