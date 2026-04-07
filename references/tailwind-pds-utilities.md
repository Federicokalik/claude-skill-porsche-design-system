# Tailwind + PDS: utility reference

When you import `@porsche-design-system/components-{js|react}/tailwindcss` in your global CSS, the Tailwind theme is **extended AND partially overridden** with PDS design-tokens values. This cheatsheet lists all the PDS-specific utilities and highlights the differences from standard Tailwind.

## How to activate it

```css
/* global.css (any framework) */
@import 'tailwindcss';
@import '@porsche-design-system/components-react/tailwindcss';
/* or with components-js for Vanilla/Astro: */
/* @import '@porsche-design-system/components-js/tailwindcss'; */
```

From that moment on, you have access to all standard Tailwind utilities **plus** the PDS utilities listed below.

## Colors

### Background

```
bg-canvas              → var(--p-color-canvas)
bg-surface             → var(--p-color-surface)
bg-frosted             → var(--p-color-frosted)
bg-frosted-soft        → var(--p-color-frosted-soft)
bg-backdrop            → var(--p-color-backdrop)

bg-primary             → var(--p-color-primary)

bg-info                → var(--p-color-info)
bg-info-medium         → var(--p-color-info-medium)
bg-info-low            → var(--p-color-info-low)
bg-info-frosted        → var(--p-color-info-frosted)
bg-info-frosted-soft   → var(--p-color-info-frosted-soft)

bg-success             → var(--p-color-success)
bg-success-frosted     → var(--p-color-success-frosted)
bg-warning             → var(--p-color-warning)
bg-warning-frosted     → var(--p-color-warning-frosted)
bg-error               → var(--p-color-error)
bg-error-frosted       → var(--p-color-error-frosted)
```

### Text color

```
text-primary           → var(--p-color-primary)
text-contrast-higher   → var(--p-color-contrast-higher)
text-contrast-high     → var(--p-color-contrast-high)
text-contrast-medium   → var(--p-color-contrast-medium)
text-contrast-low      → var(--p-color-contrast-low)    /* DO NOT use for informational text */
text-contrast-lower    → var(--p-color-contrast-lower)  /* DO NOT use for informational text */

text-info              → var(--p-color-info)
text-success           → var(--p-color-success)
text-warning           → var(--p-color-warning)
text-error             → var(--p-color-error)
```

### Border color

```
border-contrast-low    → var(--p-color-contrast-low)
border-contrast-medium → var(--p-color-contrast-medium)
border-contrast-high   → var(--p-color-contrast-high)
border-primary         → var(--p-color-primary)
border-info            → var(--p-color-info)
border-success         → var(--p-color-success)
border-warning         → var(--p-color-warning)
border-error           → var(--p-color-error)
border-focus           → var(--p-color-focus)
```

### Outline color

```
outline-focus          → var(--p-color-focus)
```

Typically used in combination with `focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2`.

## Color scheme utility classes

They are not strictly Tailwind classes, but PDS makes them available through the global stylesheet.

```
.scheme-light          → color-scheme: light (forces light mode on the whole subtree)
.scheme-dark           → color-scheme: dark (forces dark mode)
.scheme-light-dark     → color-scheme: light dark (follows OS preference)
```

Apply to `<body>` or any container to theme the subtree.

## Spacing

### Fluid spacing (responsive, scales with the viewport)

```
*-fluid-xs        → clamp(4px, 0.25vw + 3px, 8px)     (~8px desktop)
*-fluid-sm        → clamp(8px, 0.5vw + 6px, 16px)     (~16px desktop)
*-fluid-md        → clamp(16px, 1.25vw + 12px, 36px)  (~36px desktop)
*-fluid-lg        → clamp(32px, 2.75vw + 23px, 76px)  (~76px desktop)
*-fluid-xl        → clamp(48px, 3vw + 38px, 96px)     (~96px desktop)
*-fluid-2xl       → clamp(80px, 7.5vw + 56px, 200px)  (~200px desktop)
```

The `*` is to be replaced with the property prefix:
- **Gap**: `gap-fluid-md`, `gap-x-fluid-sm`, `gap-y-fluid-lg`
- **Padding**: `p-fluid-md`, `px-fluid-lg`, `py-fluid-xl`, `pt-fluid-sm`, `pb-fluid-sm`, `pl-fluid-md`, `pr-fluid-md`
- **Margin**: `m-fluid-md`, `mx-fluid-auto`, `my-fluid-lg`, `mt-fluid-sm`, etc. + negative variants `-mt-fluid-sm`
- **Top/left/right/bottom**: `top-fluid-md`, `right-fluid-sm`, etc.
- **Inset**: `inset-fluid-md`, `inset-x-fluid-sm`

### Static spacing (fixed pixels)

```
*-static-2xs     → 1px
*-static-xs      → 4px
*-static-sm      → 8px
*-static-md      → 16px
*-static-lg      → 32px
*-static-xl      → 48px
*-static-2xl     → 80px
```

Same prefixes: `p-static-md`, `gap-static-sm`, `mt-static-xs`, etc.

## Typography (prose-*)

Custom `@utility` classes that combine font-size + line-height + letter-spacing.

### Heading (titles)

```
.prose-heading-sm       /* H small, card title */
.prose-heading-md       /* H medium */
.prose-heading-lg       /* H large, section */
.prose-heading-xl       /* H x-large, page */
.prose-heading-2xl      /* H 2x-large */
.prose-heading-3xl      /* Display small (was prose-display-sm in v3) */
.prose-heading-4xl      /* Display medium (was prose-display-md in v3) */
.prose-heading-5xl      /* Display large, hero (was prose-display-lg in v3) */
```

### Text (body, paragraphs)

```
.prose-text-2xs         /* Disclaimer, legal */
.prose-text-xs          /* Caption, metadata */
.prose-text-sm          /* Body default */
.prose-text-md          /* Intro, description */
.prose-text-lg          /* Subtitle */
.prose-text-xl          /* Hero subtitle */
```

### Display (v3 only, deprecated in v4)

```
.prose-display-sm       /* v3 only → in v4: prose-heading-3xl */
.prose-display-md       /* v3 only → in v4: prose-heading-4xl */
.prose-display-lg       /* v3 only → in v4: prose-heading-5xl */
```

## Border radius

PDS defines a set of border-radius as CSS variables (`--p-radius-sm`, `--p-radius-md`, etc.). The standard Tailwind utilities `rounded-sm`, `rounded-md`, `rounded-lg`, `rounded-xl`, `rounded-2xl`, `rounded-full` work and respect these tokens.

```
rounded-sm       → var(--p-radius-sm)
rounded-md       → var(--p-radius-md)
rounded-lg       → var(--p-radius-lg)     /* most used radius for cards */
rounded-xl       → var(--p-radius-xl)
rounded-2xl      → var(--p-radius-2xl)
rounded-full     → 9999px (unchanged)
```

For legacy My Porsche App, there is an optional import that forces the old version's radii:

```css
@import '@porsche-design-system/components-react/legacy-radius.css';
```

## Shadow

PDS has its own shadow tokens. The `shadow-sm`, `shadow-md`, `shadow-lg`, `shadow-xl` utilities are remapped to the PDS values.

```
shadow-sm        → var(--p-shadow-sm)
shadow-md        → var(--p-shadow-md)
shadow-lg        → var(--p-shadow-lg)
shadow-xl        → var(--p-shadow-xl)
```

## Blur

For glassmorphism and frosted effects.

```
backdrop-blur-frosted       → var(--p-blur-frosted)   /* light blur, for hover states */
backdrop-blur-frosted-strong → var(--p-blur-frosted-strong)  /* stronger blur */
```

Use in combination with `bg-frosted` or `bg-frosted-soft`:

```html
<div class="bg-frosted backdrop-blur-frosted rounded-lg p-fluid-md">
  Glass card
</div>
```

## Breakpoints

**Important**: PDS **replaces** the Tailwind default breakpoints (which are `sm:640px`, `md:768px`, `lg:1024px`, `xl:1280px`, `2xl:1536px`) with these values:

```
base  →   0px     (default mobile-first)
xs    → 480px     (large mobile)
sm    → 760px     (tablet portrait)
md    → 1000px    (tablet landscape / small desktop)
lg    → 1300px    (desktop)
xl    → 1760px    (large desktop)
```

When you write `md:grid-cols-2`, the `md` breakpoint in PDS is **1000px**, not 768px as in standard Tailwind. Keep this in mind if you copy snippets from Tailwind UI / shadcn / other projects.

## Motion (durations & easings)

```
duration-sm      → var(--p-duration-sm)
duration-md      → var(--p-duration-md)
duration-lg      → var(--p-duration-lg)

ease-in-out      → var(--p-ease-in-out)
ease-in          → var(--p-ease-in)
ease-out         → var(--p-ease-out)
```

Example:

```html
<button class="transition-colors duration-md ease-in-out hover:bg-frosted-soft">
  Hover me
</button>
```

## Grid (Porsche Grid utilities)

PDS includes a 12-column grid system inspired by the brand's "Porsche Grid". The main utilities are:

```
.grid-template    /* Applies the 12-col grid with PDS gutter */

/* Classes for column span based on the "range" */
.col-extended     /* Takes the full available width */
.col-wide         /* Wide (≈10/12 on desktop) */
.col-basic        /* Basic (≈8/12 on desktop) */
.col-narrow       /* Narrow (≈6/12 on desktop) */
```

Example:

```html
<section class="grid-template">
  <div class="col-extended bg-surface p-fluid-md">
    Full-width content inside the PDS grid
  </div>
</section>

<section class="grid-template">
  <div class="col-basic">
    8/12 content (text, article)
  </div>
</section>
```

Alternatively you can directly use the standard Tailwind CSS Grid utilities (`grid grid-cols-12 gap-fluid-md` + `col-span-*`) — both approaches work.

## Skeleton (loading placeholder)

```
.skeleton         /* Applies PDS skeleton animation as background */
```

Example:

```html
<div class="skeleton h-8 w-48 rounded-md"></div>
```

## Focus utility

```
outline-focus                    → outline-color: var(--p-color-focus)
focus-visible:outline            → standard PDS outline on focus-visible
focus-visible:outline-offset-2   → visible offset for focus ring
```

Typical combination for a custom interactive element:

```html
<div
  role="button"
  tabindex="0"
  class="rounded-lg p-static-md transition-colors outline-focus focus-visible:outline focus-visible:outline-offset-2 hover:bg-frosted-soft"
>
  Custom clickable
</div>
```

## Cheatsheet: "I want X, I use Y"

| I want... | PDS class |
|---|---|
| Page background | `bg-canvas` |
| Card / modal background | `bg-surface` |
| Transparent glass background | `bg-frosted backdrop-blur-frosted` |
| Overlay behind modal | `bg-backdrop` |
| Main text / title | `text-primary` |
| Standard body text | `text-contrast-high` |
| Label / metadata | `text-contrast-medium` |
| Error text | `text-error` |
| Success text | `text-success` |
| Horizontal page padding | `px-fluid-md` or `px-fluid-lg` |
| Vertical section padding | `py-fluid-2xl` |
| Gap between form fields | `gap-fluid-sm` |
| Gap between cards in a grid | `gap-fluid-md` |
| Icon+text gap | `gap-static-xs` or `gap-static-sm` |
| Card border | `border border-contrast-low` |
| Card hover shadow | `hover:shadow-lg transition-shadow duration-md` |
| Rounded card | `rounded-lg` |
| Centered container | `max-w-7xl mx-auto px-fluid-md` |
| Accessible focus ring | `focus-visible:outline outline-focus outline-offset-2` |
| Forced dark theme | `scheme-dark` on the wrapper |
| Theme following OS | `scheme-light-dark` on the body |

## What NOT to do

❌ **Do not use standard Tailwind colors** (`bg-blue-500`, `text-gray-700`) — they bypass the design system and break cromatic consistency between light/dark.

❌ **Do not hardcode spacing in px** (`p-[17px]`, `gap-[23px]`) — it breaks the fluid scale and visual rhythm.

❌ **Do not use `font-xs` or `text-base`** for body text — use `prose-text-sm` which has calibrated line-height and letter-spacing.

❌ **Do not use `rounded-3xl` or custom radii** — PDS tokens cover all needed cases.

❌ **Do not use `contrast-low` for informational text** — it does not meet WCAG. Use it only for borders and decorations.

❌ **Do not apply Tailwind styles to the internals of PDS components** — they are Shadow DOM. Your classes only affect the outer wrapper.
