# Licensing: when you can (and cannot) use the Porsche Design System

## TL;DR

The Porsche Design System **is NOT an open source UI library like Radix, shadcn, Mantine**. It is a proprietary design system of Porsche AG released under a hybrid license:

- **Source code**: Apache License 2.0 (you can read it, fork it, study it)
- **Assets (compiled components, Porsche Next font, icons, wordmark, crest, color palette, design language)**: restrictive license defined in the "Porsche Design System Assets License Agreement"

The license **does permit** using PDS for non-Porsche projects (including outside the automotive industry), but under one crucial constraint: the result must be **"dissimilar and visually distinct from Porsche products and services"**, at Porsche's sole discretion. This means the _sector_ of your project is not the limit — the _visual outcome_ is.

## What the license allows

From the Porsche Design System Assets License Agreement (official text at `designsystem.porsche.com/v4/license/` and `https://github.com/porsche-design-system/porsche-design-system/blob/main/LICENSE.md`):

> "Porsche grants you a limited, worldwide, royalty-free, non-assignable, non-transferable, non-sublicensable, and non-exclusive license to use the Porsche Design System Assets solely to develop, test, and distribute software applications, websites, and interfaces **on behalf of Porsche** that are available via https://porsche.com or any associated websites or other Porsche software ('Applications')."
>
> "You may not use the Porsche Design System Assets (i) to develop, test, or distribute an external, stand-alone Application ('External Application') **unless** such External Application is **not identical to and is dissimilar and visually distinct from Porsche products and services**, as determined by Porsche in its sole discretion, (ii) to mislead consumers as to Porsche's sponsorship of, affiliation with, or endorsement of you, your organization, or your Application, and (iii) for any purpose not expressly permitted by this License Agreement."

Breaking this down, there are two permitted use cases:

1. **Applications on behalf of Porsche**: projects commissioned by or for Porsche, its subsidiaries, or official partners, published on `porsche.com` or associated sites.

2. **External Applications**: standalone apps/sites/interfaces that are NOT for Porsche, permitted **as long as**:
   - The application is **not identical** to existing Porsche products and services.
   - The application is **dissimilar and visually distinct** from Porsche products and services (Porsche's discretion).
   - The application **does not mislead** consumers about sponsorship, affiliation, or endorsement by Porsche.

Note: the license does **not** restrict the industry or sector. A law firm site, a SaaS dashboard, a food e-commerce, a fitness app — all can legitimately use PDS **provided** the final visual result does not look like a Porsche product.

## What the license explicitly prohibits

- **You may not modify, adapt, redistribute, or create derivative works** of PDS assets.
- **You may not use PDS to mislead** consumers about your affiliation with Porsche.
- **You may not use PDS for purposes not expressly permitted** by the license.
- All intellectual property rights (copyright, trademarks, trade secrets) remain with Porsche AG.
- **You may not reproduce Porsche brand assets** (wordmark, crest, model signature, flag) in a non-Porsche context — these identify the brand and their use outside a Porsche context is always a violation.

## The "dissimilar and visually distinct" constraint: what it means in practice

This is the actual constraint. Porsche judges it at its sole discretion, but based on public documentation and common practices with similar brand design systems, here are the practical rules of thumb:

**What helps create distinction**:
- **Do not use Porsche brand components**: `<p-wordmark>`, `<p-crest>`, `<p-model-signature>`, `<p-flag>`. These are brand identifiers — their presence makes the application "visually similar" to Porsche by definition.
- **Customize the dominant color palette**: PDS is neutral at its core (white/black/gray), but if you use the characteristic red `#D5001C` (Porsche's signature brand color) as the primary, you get close to the brand look. Override it with a custom color via CSS variables.
- **Replace the Porsche Next font**: it is the most recognizable element of the design language. Using it in a non-Porsche context strengthens the visual association. Use an alternative geometric sans-serif (Inter, Manrope, General Sans, PP Neue Montreal).
- **Do not use photographic/visual imagery typical of Porsche**: automotive photography in mountain/coastal settings, dealership interiors, etc.
- **Add your own brand elements**: logo, your own typography for titles, distinctive colors, your imagery. The more "your brand" surfaces, the more the result is distinct from Porsche.

**What creates similarity (to avoid)**:
- Using PDS "straight out of the box" with default colors + Porsche Next + photographic layouts similar to porsche.com.
- Combining PDS components with car / automotive / premium automotive imagery without your own strong brand identity.
- Replicating specific layouts from porsche.com (e.g. the classic Porsche hero with a car + black/white title + CTA in the center).

## Decision tree: how to proceed

### ✅ Porsche project (or official partner)

Proceed normally, using all components including brand assets (`<p-wordmark>`, `<p-crest>`, etc.).

### ✅ Non-Porsche project — USE PDS with visual distinction

You can use it. Recommended guidelines:
1. **Do not import** `<p-wordmark>`, `<p-crest>`, `<p-model-signature>`, `<p-flag>`.
2. **Customize the primary colors** via CSS variables if you want a visual identity different from the PDS default palette:
   ```css
   :root {
     --p-color-primary: hsl(220 70% 40%); /* your brand color */
   }
   ```
3. **Optionally replace the font**: PDS includes Porsche Next automatically, but you can override it with `font-family` on body and let PDS components inherit (note: this works on text inside components, but the internal styles remain those of PDS).
4. **Add your own imagery and logo**: do not copy layouts from porsche.com.
5. **Document the choice**: in the project's README, briefly note that PDS is used as a technical foundation, that the result is "dissimilar and visually distinct" from Porsche products, and provide the link to the official license.

This is a perfectly legitimate use. Many companies use PDS as a technical base for internal applications, SaaS, dashboards, B2B sites, precisely because it offers solid components, accessibility, theming, and performance.

### ⚠️ Non-Porsche project where you want the "Porsche aesthetic"

This is where you need to stop. If the goal is precisely to look like Porsche (to capitalize on the premium aesthetic, attract a car audience, communicate "luxury/performance" via the brand), then you are violating the "dissimilar and visually distinct" clause even if you don't put `<p-wordmark>` explicitly.

In this case, two alternatives:
1. **Clearly differentiate your visual identity** (your colors, your font, your imagery) so the final result does not read as "Porsche".
2. **Use a different design system** with a similar premium look but without brand ties: Radix UI + custom styling, shadcn/ui, Mantine, HeroUI, Park UI, or commissioned custom design.

### ❌ Direct competitor to Porsche or automotive brand close to Porsche

If the project is a site/app for a direct competitor (another premium sports car manufacturer, a tuner that sells competitor packages, a service that positions itself as a Porsche alternative), the use is problematic regardless of visual distinction, because the combination "automotive context + PDS technology" creates consumer confusion about the affiliation. Avoid and use a different design system.

## Recommended alternatives (if you prefer not to deal with the constraint)

If you want maximum freedom without having to worry about visual distinction from Porsche, use an open source design system with a permissive license:

| Need | Alternative | Notes |
|---|---|---|
| React component library with a modern, customizable look | **shadcn/ui** | Not an npm lib, components are copied into your codebase. MIT. Native Tailwind v4. |
| UI primitives without style opinions | **Radix UI** | Accessible primitives only, styles from scratch. MIT. |
| Complete component library | **Mantine** | Lots of ready-to-use components. MIT. |
| "Premium feel" component library | **HeroUI** (formerly NextUI) | Modern look, Tailwind-friendly. MIT. |
| Minimal Apple/Linear look | **Park UI** (by cschroeter) | Based on Ark UI. Tailwind. MIT. |
| Enterprise / complex | **Ant Design** or **Chakra UI v3** | For dashboards, CRUD, heavy forms. MIT. |
| Similar to PDS in structure but generic | **Open UI**, **Lion** (ING), **Carbon Design System** (IBM), **Spectrum** (Adobe), **Fluent UI** (Microsoft) | Enterprise design systems with permissive licenses. |

## Porsche Next font: special case

The **Porsche Next** font (automatically loaded by PDS via `getFontLinks()` or the v4 stylesheet import) is **proprietary to Porsche AG** and distributed via the Porsche CDN (`cdn.ui.porsche.com`). Use of the font is technically possible in an External Application permitted by the license, **but** since the font is one of the most recognizable elements of the Porsche brand identity, its use in a non-Porsche context increases the "similarity" risk.

**Practical recommendation**: in non-Porsche projects, override the font with a similar geometric sans-serif. Alternatives:
- **Inter** (free, SIL OFL)
- **Manrope** (free, SIL OFL)
- **General Sans** (Fontshare, free for commercial use)
- **Satoshi** (Fontshare, free for commercial use)
- **PP Neue Montreal** (Pangram Pangram, commercial)

To override in a PDS project:

```css
/* global.css — after the PDS stylesheet import */
@import '@porsche-design-system/components-react';
@import 'tailwindcss';
@import '@porsche-design-system/components-react/tailwindcss';
@import url('https://fonts.googleapis.com/css2?family=Inter:wght@400;600&display=swap');

:root {
  --p-font-family: 'Inter', system-ui, sans-serif;
}

body {
  font-family: var(--p-font-family);
}
```

Note: overriding `--p-font-family` does not affect the internals of PDS components (they live in Shadow DOM), but it applies to all text outside the components and the slots. In practice, the result is a "mix" — PDS components keep Porsche Next internally, the rest of the UI uses your font. If you want full visual distinction, use the font override as one of several distinction elements.

## Brand assets always off-limits outside the Porsche context

Even within an External Application permitted by the license, these assets **should never be used** because they are the brand's primary identifiers:

- `<p-wordmark>` / `PWordmark` — PORSCHE text logo
- `<p-crest>` / `PCrest` — Porsche crest/logo
- `<p-model-signature>` / `PModelSignature` — graphic signature of models (911, Taycan, Cayenne, etc.)
- `<p-link-tile-model-signature>` (v3) — link tile with model signature
- `<p-flag>` / `PFlag` — Porsche flag with crest

If the user asks to insert one of these in a non-Porsche context, refuse and explain why: these components identify the brand, using them outside a Porsche context is a license violation regardless of the rest of the design.

## Sources

- Full license text: `https://designsystem.porsche.com/v4/license/` and `https://github.com/porsche-design-system/porsche-design-system/blob/main/LICENSE.md`
- Porsche Open Source legal FAQ: `https://opensource.porsche.com/`
- Official repository: `https://github.com/porsche-design-system/porsche-design-system`
