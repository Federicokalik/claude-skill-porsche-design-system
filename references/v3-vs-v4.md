# v3 vs v4: API differences and migration guide

This page summarizes the key differences between Porsche Design System v3 and v4. v4 is the current release, v3 is stable and still widely used. The Porsche team maintains both.

## Package versions

| Aspect | v3 | v4 |
|---|---|---|
| Vanilla JS package | `@porsche-design-system/components-js@3` | `@porsche-design-system/components-js@4` |
| React package | `@porsche-design-system/components-react@3` | `@porsche-design-system/components-react@4` |
| Compatible Vite | Vite 7 | Vite 8+ (requires lightningcss fix) |
| Compatible Astro | Astro 5 | Astro 6 |
| Tailwind CSS | v4 | v4 |
| React | 19 | 19 |
| Next.js | 15 | 15 |

## 🛠️ Setup & global styles

### What changes the most

**v3** used JavaScript partials (`getInitialStyles()`, `getFontFaceStyles()`) to inject base styles, font-face and anti-FOUC. Color tokens were CSS variables defined by the components themselves, theming via HTML attribute or React prop.

**v4** requires a **mandatory global CSS import**. Without this import, components do NOT render correctly because all CSS variables come from there. On the other hand, the `getInitialStyles()` and `getFontFaceStyles()` partials have been **removed**.

### v3 — JavaScript partials in the HEAD

```ts
// Vanilla JS / Astro / React Vite — vite.config.ts
import {
  getInitialStyles,
  getFontFaceStyles,
  getFontLinks,
  getComponentChunkLinks,
  getIconLinks,
  getMetaTagsAndIconLinks,
} from '@porsche-design-system/components-js/partials'; // or /components-react/partials

// ... inject into <head>
```

### v4 — stylesheet import in the global CSS

```css
/* src/global.css */
@import '@porsche-design-system/components-js'; /* or /components-react */

/* Manual FOUC prevention (required in v4): */
:not(:defined) {
  visibility: hidden;
}

/* For Next.js / React Router with SSR: */
:not(:defined,[data-ssr]) {
  visibility: hidden;
}
```

The `getFontLinks()`, `getComponentChunkLinks()`, `getIconLinks()`, `getMetaTagsAndIconLinks()` partials **still exist in v4** and are recommended for preload performance, but are no longer required for basic functionality.

### Partials removed in v4

- `getInitialStyles()` → replaced by the CSS import + `:not(:defined)` rule
- `getFontFaceStyles()` → included in the stylesheet import
- `getFontFaceStylesheet()` → included in the stylesheet import
- `getBrowserSupportFallbackScript()` → moved to the separate repo `@porsche-design-system/fallbacks`
- `getCookiesFallbackScript()` → same
- `getDSRPonyfill()` → no longer required

## 🎨 Theming (the biggest change)

### v3 — theming via prop/attribute

```tsx
// React v3
<PorscheDesignSystemProvider theme="dark">
  <App />
</PorscheDesignSystemProvider>

// Per-component theme
<PButton theme="dark">Label</PButton>
<PButton theme="auto">Label</PButton> // follows OS preference
```

```html
<!-- Vanilla v3 -->
<p-button theme="dark">Label</p-button>
```

### v4 — theming via CSS `color-scheme` and utility class

v4 uses the CSS `light-dark()` function and the `color-scheme` property. The utility classes are: `.scheme-light`, `.scheme-dark`, `.scheme-light-dark` (the latter follows the system).

```tsx
// React v4 — NO more theme prop
<PorscheDesignSystemProvider>
  <App />
</PorscheDesignSystemProvider>

// Theme applied via className on body or on a container
```

```html
<!-- v4: global theme via class on body -->
<body class="scheme-light-dark">
  <p-button>Label</p-button>
</body>

<!-- Local override on a subtree -->
<div class="scheme-dark">
  <p-button>Dark button</p-button>
  <div class="scheme-light">
    <p-button>Light button in dark subtree</p-button>
  </div>
</div>
```

### Migration map theme → color-scheme class

```html
<!-- v3 → v4 -->
<p-button theme="light">    → <p-button class="scheme-light">
<p-button theme="dark">     → <p-button class="scheme-dark">
<p-button theme="auto">     → <p-button class="scheme-light-dark">
```

## ⚙️ Lightning CSS fix (v4 only, Vite 8+)

Vite 8+ uses lightningcss for CSS processing. Lightningcss includes a polyfill for `light-dark()` that is **broken** and breaks PDS colors. It must be disabled.

```ts
// vite.config.ts (React, React Router, Astro with Vite)
import { Features } from 'lightningcss';
import { defineConfig } from 'vite';

export default defineConfig({
  css: {
    transformer: 'lightningcss',
    lightningcss: {
      exclude: Features.LightDark,
    },
  },
});
```

```ts
// next.config.ts (Next.js with Turbopack)
const nextConfig: NextConfig = {
  experimental: {
    useLightningcss: true,
    lightningCssFeatures: {
      exclude: ['light-dark'],
    },
  },
};
```

## 🧱 Removed or changed components

### Removed in v4 (already deprecated in v3)

These components **no longer exist in v4**. If the user passes you v3 code with these components, replace them before migrating.

| Removed v3 component | v4 replacement |
|---|---|
| `p-checkbox-wrapper` + `<input type="checkbox">` | `p-checkbox label="..." name="...">` |
| `p-radio-button-wrapper` + `<input type="radio">` | `p-radio-group` + `p-radio-group-option` |
| `p-fieldset-wrapper` | `p-fieldset` |
| `p-select-wrapper` + `<select>` | `p-select` + `p-select-option` (+ `p-optgroup`) |
| `p-text-field-wrapper` + `<input type="text">` | `p-input-text`, `p-input-email`, `p-input-date`, `p-input-time`, `p-input-number`, `p-input-password`, `p-input-search`, `p-input-tel`, `p-input-url`, `p-input-week`, `p-input-month` |
| `p-textarea-wrapper` + `<textarea>` | `p-textarea` |
| `p-content-wrapper` | CSS grid with `grid-template` + `col-extended` classes (Porsche Grid in Tailwind) |
| `p-flex` / `p-flex-item` | CSS flex: `<div class="flex">` |
| `p-grid` / `p-grid-item` | CSS grid: `<div class="grid grid-cols-3">` |
| `p-headline` | `p-heading` |
| `p-link-social` | `p-link` with prop `icon="logo-facebook"` etc. |
| `p-marque` | `p-wordmark` (preferred) or `p-crest` |
| `p-button-group` | `<div role="group" class="flex flex-wrap gap-fluid-sm max-xs:flex-col">` |

### Deprecated in v4 (will be removed in v5)

They still work in v4 but emit warnings. **Use the new values for new code.**

| Component | What is deprecated | New value |
|---|---|---|
| `p-display` | **Entire component** | `p-heading` with `size="3xl"` (small), `4xl` (medium), `5xl` (large) |
| `p-text` | Size values `xx-small`, `x-small`, `small`, `medium`, `large`, `x-large` | `2xs`, `xs`, `sm`, `md`, `lg`, `xl` |
| `p-text` | Weight values `regular`, `semi-bold` | `normal`, `semibold` |
| `p-heading` | Size values `small`, `medium`, `large`, `x-large`, `xx-large` | `sm`, `md`, `lg`, `xl`, `2xl` |
| `p-heading` | Weight values `regular`, `semi-bold` | `normal`, `semibold` |
| `p-icon` | Size values from `xx-small` to `xx-large` | `2xs`, `xs`, `sm`, `md`, `lg`, `xl`, `2xl` |
| `p-spinner` / `p-flag` | Size values `small`, `medium`, `large` | `sm`, `md`, `lg` |
| `p-button-pure` / `p-link-pure` | Size values from `xx-small` to `x-large` | `2xs`, `xs`, `sm`, `md`, `lg`, `xl` |
| `p-accordion` | Props `heading`, `heading-tag`, `size` | `slot="summary"` with `p-heading` inside |

### Breaking changes on props/events (v4)

| Component | Change |
|---|---|
| `p-button`, `p-link` | Removed `variant="ghost"` → use `variant="secondary"` |
| `p-button`, `p-link` | Removed `variant="tertiary"` → use `variant="secondary"` |
| `p-tag` | Removed `color` prop → use `variant="primary\|secondary\|success\|warning\|error\|info"` |
| `p-tag-dismissible` | Removed `color` prop |
| `p-text`, `p-icon` | Color values `notification-success\|warning\|error\|info` → `success\|warning\|error\|info` |
| `p-text`, `p-icon` | Color values `brand`, `default`, `neutral-contrast-*` → `primary`, `contrast-*` |
| `p-divider` | Prop `orientation` → `direction` |
| `p-divider` | Color values `neutral-contrast-*` → `contrast-*` |
| `p-flyout` | CSS var `--p-flyout-max-width` removed → use `--p-flyout-width` with `min()`/`max()`/`clamp()` |
| `p-flyout`, `p-switch`, `p-button-pure`, `p-link-pure`, `p-display`, `p-heading`, `p-text` | Align values `left\|right` → `start\|end` |
| `p-carousel` | Prop `gradient-color` → `gradient="true"` |
| `p-carousel` | Default of `trim-space`, `pagination`, `rewind` changed from `true` to `false` |
| `p-button-tile`, `p-link-tile` | Default of `gradient` changed from `true` to `false` |
| `p-button-tile`, `p-link-tile` | Prop `background="light\|dark\|auto"` → `class="scheme-light\|scheme-dark\|scheme-light-dark"` |
| `p-link-tile-model-signature` | **Removed** → use `p-link-tile` |
| `p-link-tile-product` | Aspect ratio `3:4\|9:16` → `3/4\|9/16` |
| `p-modal` | Prop `heading` → use `<p-heading slot="header">` |
| `p-modal` | Slot `heading` → slot `header` |
| `p-modal` | Event `close` → `dismiss` |
| `p-modal` | Prop `disableCloseButton` → `dismissButton="false"` |
| `p-modal` | Class `.stretch-to-full-modal-width` removed → use CSS vars `--ref-p-modal-pt`, `--ref-p-modal-px`, `--ref-p-modal-pb` |
| `p-banner` | Slot `title` → slot `heading` |
| `p-banner` | Prop `persistent` → `dismissButton="false"` |
| `p-banner` | Prop `width` removed (use the Porsche Grid) |
| `p-banner`, `p-inline-notification`, `p-toast` | Value `state="neutral"` → `state="info"` |
| `p-inline-notification` | Prop `persistent` → `dismissButton="false"` |
| `p-accordion` | Prop `tag` → `heading-tag` |
| `p-accordion` | Event `accordionChange` → `update` |
| `p-carousel` | Event `carouselChange` → `update` |
| `p-checkbox`, `p-multi-select`, `p-pin-code`, `p-select` | Event `update` → `change` |
| `p-segmented-control` | Events `segmentedControlChange` and `update` → `change` |
| `p-switch` | Event `switchChange` → `update` |
| `p-tabs`, `p-tabs-bar` | Event `tabChange` → `update` |
| `p-table` | Event `sortingChange` → `update` |
| `p-pagination` | Event `pageChange` → `update` |
| `p-pagination` | Props `allyLabel*` → `intl` |
| `p-stepper-horizontal` | Event `stepChange` → `update` |

### Slotted anchor styles removed (v4)

In v4, the automatic styling of `<a>` tags slotted inside components like `p-accordion`, `p-banner`, `p-carousel`, `p-heading`, `p-inline-notification`, `p-switch`, `p-table`, `p-tabs`, `p-text`, `p-text-list` has been **removed**. If you want a link inside these components, use `<p-link-pure>` or manually apply styles via Tailwind:

```html
<!-- v4: link inside p-accordion with manual Tailwind styling -->
<p-accordion heading="Some heading">
  <a
    class="text-current underline rounded-lg transition-colors -mx-static-xs px-static-xs outline-focus outline-offset-2 focus-visible:outline hover:backdrop-blur-frosted hover:bg-frosted-strong"
    href="https://example.com"
  >
    Link label
  </a>
</p-accordion>

<!-- Or, simpler: -->
<p-accordion heading="Some heading">
  <p-link-pure href="https://example.com" icon="none">Link label</p-link-pure>
</p-accordion>
```

## 📣 v4-exclusive new features

- **New Porsche design language** applied to all components (recalibrated border-radius, motion, spacing)
- **New color palette** based on `light-dark()` and `color-scheme`
- **Redesigned form elements and buttons**
- **Dialog elements** with redesigned footer
- **All headings use regular font-weight** (in v3 they were semi-bold)
- **CSS variables exposed** for all tokens, accessible from the outside (e.g. `var(--p-color-primary)`, `var(--p-spacing-fluid-md)`)
- **New Tokens system** (previously "Styles") with `blur`, `border`, `breakpoint`, `color`, `font`, `gradient`, `motion`, `shadow`, `spacing`
- **New Stylesheets system** with `css-variables`, `color-scheme`, `font-face`, `normalize`
- **Admin Panel template** added (in addition to the Landing Page already present in v3)
- **Official styling alternatives**: SCSS, Emotion, Vanilla Extract (in addition to Tailwind CSS)
- **Optional Legacy Border-Radius import** for compatibility with My Porsche App:
  ```css
  @import '@porsche-design-system/components-{js|react}/legacy-radius.css';
  ```

## Summary: checklist to migrate v3 → v4

1. Update the package: `npm install @porsche-design-system/components-{js|react}@4`
2. Replace `getInitialStyles() + getFontFaceStyles()` with `@import '@porsche-design-system/components-{js|react}';` in the global CSS
3. Add `:not(:defined) { visibility: hidden; }` (or `:not(:defined,[data-ssr])` for SSR) to the global CSS
4. Remove the `theme` prop from `PorscheDesignSystemProvider` and from individual components
5. Add `class="scheme-light-dark"` to the `<body>` (or another chosen scheme)
6. Configure lightningcss `exclude: Features.LightDark` in vite.config.ts
7. Replace removed components (`p-flex`, `p-grid`, `p-headline`, `p-marque`, `p-display`, various wrappers) with v4 equivalents
8. Update deprecated prop values (size, color, weight, align)
9. Update event handlers (update → change, *Change → update)
10. Test theming and FOUC on the first page loaded

For the complete guide see `https://designsystem.porsche.com/v4/news/migration-guide/porsche-design-system/`.
