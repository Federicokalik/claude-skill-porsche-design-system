---
name: porsche-design-system
description: >-
  Build web interfaces using the Porsche Design System (PDS), a web-components
  design system with Tailwind CSS theme integration. Use whenever the user mentions
  "Porsche Design System", "PDS", "Porsche style", "Porsche look", or PDS components
  (PButton, PHeading, PWordmark, p-button, p-heading, etc.), or asks to build UI
  with Porsche's design language, color tokens, spacing, or theming. Covers Astro,
  React Vite, Next.js App Router, React Router, and Vanilla JS/HTML, supporting
  BOTH v3 and v4 with major API differences. All snippets use Tailwind CSS v4 with
  the PDS theme. PDS has restrictive licensing — on the first PDS request of a
  conversation, show a complete license notice and STOP, waiting for explicit user
  authorization before writing any code. This is a consent gate, not a passive
  disclaimer. Do not repeat the notice once authorization is given.
---

# Porsche Design System (PDS) skill

This skill provides setup, code snippets, design tokens, and patterns for building web interfaces using the Porsche Design System. PDS is based on **Web Components** (Stencil.js under the hood) with framework-specific wrappers for React, Vue, Angular, and direct bindings for Vanilla JS / HTML / Astro.

The skill supports **two versions in parallel** — v3 and v4 — because they have significantly different APIs and the Porsche team maintains both (v4 is the current release, v3 is stable and still widely used).

## ⚠️ License consent gate (BLOCKING — explicit authorization required)

PDS is not a generic UI library with a permissive MIT license — it is released under the **Porsche Design System Assets License Agreement**, which places real restrictions on use outside Porsche contexts. **Before writing ANY PDS code** in a conversation, you must show a complete notice and **stop**, waiting for explicit authorization from the user. This is not an informational disclaimer: it is a consent gate. The user must understand what they are consenting to before you proceed, and must say so explicitly.

### Mandatory behavior

1. **On the first PDS request of the conversation**: full stop, do not write a single line of code. Show the complete notice (see below) and end the turn with a direct question that requires an affirmative response. Do not proceed until the user gives explicit authorization.

2. **What counts as explicit authorization**: a direct affirmative response such as "yes proceed", "ok", "I authorize", "understood, go ahead", "I'm aware, do it". **Do not** treat as implicit authorization the fact that the user formulated the original request, nor ambiguous messages like "interesting" or "ok" if they aren't clearly in response to the consent question.

3. **What to do if the user asks questions instead of authorizing**: answer the questions about the license, the risks, the alternatives — you're there to help them decide knowingly. But do not write PDS code until there is explicit authorization.

4. **What to do if the user refuses or seems uncertain**: respect the decision, propose open source alternatives (shadcn/ui, Radix Themes, Mantine, HeroUI, Park UI, etc.), and help them with those instead. Do not push PDS.

5. **Once authorization is given**: proceed normally for the rest of the conversation. **Do not repeat the notice** in subsequent turns of the same conversation — the consent is valid for the entire session. Do not ask "are you sure?" before every PDS snippet.

6. **Separate conversations**: each new conversation requires a new consent gate. Consent is not persistent across sessions.

### The notice to show (adapt to context, do not copy verbatim)

It must cover **all of these points**, in the user's language (English if they write in English, Italian if they write in Italian, etc.):

1. **What the license is**: the Porsche Design System is released under the *Porsche Design System Assets License Agreement*, a custom proprietary license (not MIT, not Apache, not permissive).

2. **What it allows by default**: asset use is granted "to develop applications on behalf of Porsche". For non-Porsche use there is an "External Application" exception that requires the result to be "dissimilar and visually distinct" from Porsche products, **at Porsche's sole discretion**.

3. **The real risk**: the "dissimilarity" assessment is not made by the user, it's made by Porsche. This means using PDS with defaults (Porsche Next font, color palette, design language) for a non-Porsche project is technically a contractual violation even if it's never enforced. For public projects (websites, distributed apps, online portfolios) there is a non-zero risk of cease & desist.

4. **What is always forbidden**: brand assets (`<PWordmark>`, `<PCrest>`, `<PModelSignature>`, `<PFlag>`) are trademarks and must never be used outside official Porsche projects, regardless of any customization. This is a hard limit.

5. **How to reduce risk if proceeding**: override PDS colors via CSS variables, replace the Porsche Next font with another font, no brand assets, optionally a footer credit declaring use under the "External Application" clause. See `references/licensing.md` for details.

6. **Responsibility disclaimer**: Claude is not a lawyer, this is not legal advice. The final compliance assessment is the user's responsibility, possibly with the support of a lawyer. For the full license text: `https://designsystem.porsche.com/v4/license/`.

7. **Explicit consent question**: close with something like *"Do you confirm that you have read and understood the above, and authorize me to proceed with PDS code for this project under your responsibility?"* — it must clearly be a question that requires a yes/no answer, not a passive disclaimer.

For the full license text, the detailed analysis of restrictions, and suggestions on how to maximize "dissimilarity" (color overrides, font replacement, avoiding brand assets), see `references/licensing.md`.

## Which version to use?

Ask the user which package version they have installed or want to install. As a general rule:

- **v4** (package `@4`) is the current release, with new design language, color system based on CSS `light-dark()` and `color-scheme`, mandatory stylesheet import, and removal of several deprecated components. Use v4 for **new projects**.
- **v3** (package `@3`) is still widely used, has different APIs (theming via `theme="light|dark|auto"` attribute, `PorscheDesignSystemProvider` with theme prop, mandatory `getInitialStyles()` partial, etc.). Use v3 if the user is **already working on an existing v3 project**.

If the user does not specify, **default to v4** (it is the active, team-recommended release).

The key differences between v3 and v4 are documented in `references/v3-vs-v4.md` — ALWAYS read it before generating code if the project mixes references from both versions, or if the user hands you v3 code to migrate to v4.

## Skill structure

```
porsche-design-system/
├── SKILL.md                      # (this file) triggers, workflow, quick reference
├── references/
│   ├── licensing.md              # License, consent gate template, alternatives
│   ├── v3-vs-v4.md               # Key differences between v3 and v4, migration guide
│   ├── setup-astro.md            # Full Astro + Tailwind setup (v3 and v4)
│   ├── setup-react-vite.md       # React/Vite + Tailwind setup (v3 and v4)
│   ├── setup-nextjs.md           # Next.js App Router + Tailwind setup (v3 and v4)
│   ├── setup-react-router.md     # React Router + Tailwind setup (v3 and v4)
│   ├── setup-vanilla.md          # Vanilla JS / HTML / plain Astro setup (v3 and v4)
│   ├── tokens-colors.md          # Color tokens, color-scheme, semantic colors, theming
│   ├── tokens-spacing.md         # Fluid & static spacing, gap, padding, margin
│   ├── tokens-typography.md      # Font face, prose-*, heading sizes, text sizes
│   ├── components-catalog.md     # PDS v3/v4 component list, when to use what
│   ├── components-snippets.md    # Ready-to-paste snippets for the most used components
│   ├── patterns-layout.md        # Layout patterns: hero, card grid, form, header, footer
│   └── tailwind-pds-utilities.md # PDS-specific Tailwind utilities (bg-surface, gap-fluid-md, prose-*, etc.)
└── scripts/
    └── check-updates.sh          # Script to verify the current version via npm registry
```

## Recommended workflow

Follow these steps when the user asks you to do something with PDS:

**Step 1 — License consent gate.** If this is the first PDS request of the conversation, show the complete notice described in "⚠️ License consent gate" above and **stop** there. Wait for explicit user authorization before proceeding to the next steps. If consent was already given in a previous turn of the same conversation, skip this step and go directly to step 2. Do not repeat the notice.

**Step 2 — Identify the target framework.** Astro? Astro + React islands? Next.js App Router? React with Vite? React Router? Vanilla HTML? Load the corresponding `references/setup-<framework>.md` file.

**Step 3 — Identify the version.** v3 or v4? If not specified, ask or default to v4. Each setup file has separate sections for v3 and v4.

**Step 4 — Apply setup.** Follow the reference file guide exactly, including: package installation, Provider wrap, global stylesheet import (v4) or partials (v3), Tailwind theme import, lightning CSS polyfill (v4 with Vite 8+).

**Step 5 — Use components and tokens.** For every snippet you generate, use PDS design tokens — spacing, colors, prose classes — via PDS Tailwind utilities (e.g. `gap-fluid-md`, `bg-surface`, `prose-heading-lg`, `text-primary`). Don't hardcode custom colors or pixel spacing if an equivalent token exists. Load `references/tokens-*.md` and `references/tailwind-pds-utilities.md` for the full list.

**Step 6 — Build components.** For complex UI draw from patterns in `references/patterns-layout.md` and snippets in `references/components-snippets.md`. Always prefer native PDS components over custom versions when an equivalent exists (e.g. `PButton` instead of a styled `<button>`).

## Ironclad rules (non-negotiable)

These rules protect output quality and consistency with the Porsche design language. Do not skip any of these.

**Tailwind CSS is mandatory.** All snippets in this skill use Tailwind v4 with the PDS theme (`@import '@porsche-design-system/components-{js|react}/tailwindcss'`). Do not write custom CSS if an equivalent PDS Tailwind utility exists. If the user explicitly asks not to use Tailwind, warn them they are giving up an important part of the PDS ecosystem and ask for confirmation before proceeding with only Web Components + plain CSS.

**Theme is always `auto` (v3) or `scheme-light-dark` (v4).** Unless the user explicitly asks for light-only or dark-only, always set the theme to follow the user's system preference. In v3 this means `<PorscheDesignSystemProvider theme="auto">` or `theme="auto"` attribute on components. In v4 it means adding `class="scheme-light-dark"` on the `<body>`.

**In Next.js / React Router / Remix ALWAYS use the `/ssr` sub-package.** All imports must come from `@porsche-design-system/components-react/ssr`, not from `@porsche-design-system/components-react`. This applies both to the Provider and to individual components (PButton, PHeading, etc.). It is necessary for Declarative Shadow DOM rendering.

**Configure `process.browser` in Vite configs for SSR React.** For Next.js, React Router, and Remix with Vite, you need `define: { 'process.browser': JSON.stringify(!isSsrBuild) }` in `vite.config.ts` — otherwise server-side code leaks into the client bundle.

**In v4, disable lightningcss `light-dark()` polyfill** with `exclude: Features.LightDark` (Vite 8+) or `lightningCssFeatures: { exclude: ['light-dark'] }` (Next.js Turbopack). The polyfill is broken and breaks colors.

**In v4, a manual CSS rule for FOUC prevention is required.** Add to the global stylesheet: `:not(:defined) { visibility: hidden; }` (Vanilla/React/Astro), `:not(:defined,[data-ssr]) { visibility: hidden; }` (Next.js/React Router). v3 handles this automatically with `getInitialStyles()`.

**Deprecated components → use the modern equivalent.** If the user mentions components like `p-flex`, `p-grid`, `p-headline`, `p-marque`, `p-button-group`, `p-content-wrapper`, `p-checkbox-wrapper`, `p-radio-button-wrapper`, `p-select-wrapper`, `p-text-field-wrapper`, `p-textarea-wrapper`, `p-fieldset-wrapper`, `p-display` (v4), `p-link-social`, `p-link-tile-model-signature` (v4), they are DEPRECATED or REMOVED. See `references/v3-vs-v4.md` for the complete mapping to modern equivalents. ALWAYS generate code with modern components — only mention deprecated ones if the user is migrating old code.

**PDS components are Web Components with Shadow DOM.** You can't style them with CSS selectors from outside (`.my-button p-button { color: red }` doesn't work). Use the component props or the documented CSS custom properties (e.g. `--p-modal-pt`, `--p-flyout-width`). Tailwind classes only apply to the outer HTML wrapper, not to component internals.

**Porsche Next font.** PDS automatically includes the Porsche Next font via partials (`getFontLinks()` / stylesheet import). Don't import alternative Google Fonts — it would break the typographic consistency of the design language.

**Don't hardcode Porsche colors.** The palette is brand-proprietary. Don't copy hex values from screenshots or from porsche.com — ALWAYS use PDS tokens via CSS variables (`var(--p-color-primary)`) or Tailwind utilities (`bg-surface`, `text-primary`). The color system changes between v3 and v4.

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
  static-2xs, static-xs, static-sm, static-md, static-lg, static-xl, static-2xl  (fixed px)
  Example: gap-fluid-md, p-static-lg, m-fluid-xl

# Background & colors (use bg-*, text-*, border-*):
  canvas, surface, frosted, frosted-soft, backdrop                   (background)
  primary, contrast-high, contrast-medium, contrast-low              (foreground)
  info, success, warning, error                                       (semantic)
  focus                                                                (a11y)
  Example: bg-surface, text-primary, border-contrast-low

# Typography:
  prose-heading-sm / md / lg / xl / 2xl / 3xl / 4xl / 5xl             (headings)
  prose-text-2xs / xs / sm / md / lg / xl                             (text body)
  Example: className="prose-heading-xl" for a large title

# Border radius:
  rounded-sm, rounded-md, rounded-lg, rounded-xl, rounded-2xl         (design tokens)

# Grid layout (v4 recommends standard CSS grid):
  grid-template, col-extended, col-wide, col-basic, col-narrow         (Porsche Grid utilities)
```

The `references/tailwind-pds-utilities.md` file contains the extended reference with examples.

## Documentation updates

The snapshot in `references/` was captured on **2026-04-04** from the official documentation at `https://designsystem.porsche.com/v3/` and `https://designsystem.porsche.com/v4/`. If the user reports that something is not working and you suspect the API has changed, run `scripts/check-updates.sh` to verify the current version on the npm registry, or do a direct `web_fetch` on one of the official pages to compare.

## Official resources

- v4 docs (current): `https://designsystem.porsche.com/v4/`
- v3 docs (stable): `https://designsystem.porsche.com/v3/`
- GitHub repo: `https://github.com/porsche-design-system/porsche-design-system`
- Examples & templates: `https://github.com/porsche-design-system/examples`
- npm — Vanilla JS: `@porsche-design-system/components-js`
- npm — React: `@porsche-design-system/components-react`
- npm — React SSR (Next.js/Remix/React Router): `@porsche-design-system/components-react/ssr`
- Migration guide v3→v4: `https://designsystem.porsche.com/v4/news/migration-guide/porsche-design-system/`