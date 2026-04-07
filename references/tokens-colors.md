# Tokens: Colors

The PDS color system is the part that changed the most between v3 and v4. Here is the complete reference for both versions, with token names, actual HSL values, Tailwind/CSS var equivalents, and when to use what.

## Usage principles

1. **Never hardcode hex or rgb colors in the code.** Always use PDS tokens via Tailwind utilities (`bg-surface`, `text-primary`) or CSS custom properties (`var(--p-color-primary)` in v4).
2. **Colors always follow the theme.** In PDS there are no "fixed" colors in the traditional sense — every color has two values (light and dark) and automatically adapts to the active color-scheme.
3. **The palette is proprietary to the Porsche brand.** Do not try to extract hex values from screenshots to reproduce them in other design systems — it is a license violation. If you need a similar look outside Porsche contexts, use alternatives like Radix Colors, Open Props, etc.

## v4 — Color tokens (current system)

v4 uses the CSS `light-dark()` function and the `color-scheme` property. Each token has a single name and two values: one for light mode, one for dark mode. The choice between the two is automatic based on the `color-scheme` active on the body or on an ancestor (`.scheme-light`, `.scheme-dark`, `.scheme-light-dark`).

### Background

Used for surfaces, backgrounds, backdrops. All background tokens:

| JS/SCSS token | CSS variable | Tailwind utility | Description |
|---|---|---|---|
| `colorCanvas` | `--p-color-canvas` | `bg-canvas` | The main "sheet" — white in light, near-black in dark. Light: `#fff` · Dark: `hsl(225 66.7% 1.2%)` |
| `colorSurface` | `--p-color-surface` | `bg-surface` | Background of cards, modals, sheets — light gray in light, dark gray in dark. Light: `hsl(240 10% 95%)` · Dark: `hsl(240 2% 10%)` |
| `colorFrosted` | `--p-color-frosted` | `bg-frosted` | Semi-transparent background with blur — used behind glass effects. Light: `hsl(240 5% 70% / 0.148)` · Dark: `hsl(240 2% 43% / 0.228)` |
| `colorFrostedSoft` | `--p-color-frosted-soft` | `bg-frosted-soft` | Frosted variant for subtle `:hover` states. Light: `hsl(234 9.8% 60% / 0.06)` · Dark: `hsl(240 3.7% 26.5% / 0.154)` |
| `colorBackdrop` | `--p-color-backdrop` | `bg-backdrop` | Dark overlay behind modal/flyout. Light and Dark: `hsl(240 5.3% 14.9% / 0.5)` |

### Foreground (text and content)

Used for text, icons, informational borders. Ordered from strongest to lightest:

| Token | CSS variable | Tailwind | Usage |
|---|---|---|---|
| `colorPrimary` | `--p-color-primary` | `text-primary` / `bg-primary` | Main text, primary CTA. Light: `hsl(225 66.7% 1.2%)` (near black) · Dark: `hsl(225 100% 99%)` (near white) |
| `colorContrastHigher` | `--p-color-contrast-higher` | `text-contrast-higher` | High contrast text (≈80% opacity). For secondary titles, alt headings. |
| `colorContrastHigh` | `--p-color-contrast-high` | `text-contrast-high` | Standard text (≈70% opacity). For body text, normal paragraphs. |
| `colorContrastMedium` | `--p-color-contrast-medium` | `text-contrast-medium` | Secondary text (≈60% opacity). For labels, captions, metadata. |
| `colorContrastLow` | `--p-color-contrast-low` | `text-contrast-low` | Decorative elements (≈50% opacity). **NOT accessibility-compliant** — do not use for informational text! Use for borders, dividers. |
| `colorContrastLower` | `--p-color-contrast-lower` | `text-contrast-lower` | Very subtle decorative elements (≈30% opacity). Same caveat: not for text. |

**Critical rule**: `contrast-low` and `contrast-lower` are **decorative** and do NOT comply with WCAG. Do not put them on text that has to be read. If you need disabled text, use `contrast-medium` with `opacity-50` on the wrapper, or look at the `:disabled` states of native PDS components.

### Semantic (feedback, notifications, states)

| Token | CSS variable | Tailwind | Light color |
|---|---|---|---|
| `colorInfo` | `--p-color-info` | `text-info` / `bg-info` | Blue (`hsl(228 83.2% 51%)`) |
| `colorInfoMedium` | `--p-color-info-medium` | `text-info-medium` | Blue 60% |
| `colorInfoLow` | `--p-color-info-low` | `text-info-low` | Blue 18% |
| `colorInfoFrosted` | `--p-color-info-frosted` | `bg-info-frosted` | For semi-transparent background with blur |
| `colorInfoFrostedSoft` | `--p-color-info-frosted-soft` | `bg-info-frosted-soft` | Hover variant |
| `colorSuccess` | `--p-color-success` | `text-success` / `bg-success` | Green (`hsl(115 77.5% 27.8%)`) |
| `colorSuccessMedium` | `--p-color-success-medium` | — | Green 60% |
| `colorSuccessLow` | `--p-color-success-low` | — | Green 18% |
| `colorSuccessFrosted` | `--p-color-success-frosted` | `bg-success-frosted` | — |
| `colorSuccessFrostedSoft` | `--p-color-success-frosted-soft` | — | — |
| `colorWarning` | `--p-color-warning` | `text-warning` / `bg-warning` | Orange (`hsl(28 97.7% 34.1%)`) |
| `colorWarningMedium` | `--p-color-warning-medium` | — | Orange 60% |
| `colorWarningLow` | `--p-color-warning-low` | — | Orange 18% |
| `colorWarningFrosted` | `--p-color-warning-frosted` | `bg-warning-frosted` | — |
| `colorWarningFrostedSoft` | `--p-color-warning-frosted-soft` | — | — |
| `colorError` | `--p-color-error` | `text-error` / `bg-error` | Red (`hsl(357 78% 41%)`) |
| `colorErrorMedium` | `--p-color-error-medium` | — | Red 60% |
| `colorErrorLow` | `--p-color-error-low` | — | Red 18% |
| `colorErrorFrosted` | `--p-color-error-frosted` | `bg-error-frosted` | — |
| `colorErrorFrostedSoft` | `--p-color-error-frosted-soft` | — | — |

### A11y (accessibility)

| Token | CSS variable | Tailwind | Usage |
|---|---|---|---|
| `colorFocus` | `--p-color-focus` | `outline-focus` / `border-focus` | Outline for the `:focus-visible` state. Fixed `#1A44EA` (the same in light and dark). |

### Color-scheme utility classes

Apply these classes to the `<body>` or to an ancestor to change the theme of the entire subtree:

- `.scheme-light` — forces light mode, ignores OS preference.
- `.scheme-dark` — forces dark mode, ignores OS preference.
- `.scheme-light-dark` — follows OS preference (recommended for user-facing apps).

You can nest different themes:

```html
<body class="scheme-light-dark">
  <!-- everything follows the OS -->
  <div class="scheme-dark">
    <!-- this subtree is always dark -->
    <p-heading>Dark section</p-heading>
    <div class="scheme-light">
      <!-- this nested subtree is always light -->
      <p-heading>Light island</p-heading>
    </div>
  </div>
</body>
```

### How to use in custom CSS (outside PDS components)

You can use the PDS CSS variables also in hand-written CSS for things that are not PDS components:

```css
/* My custom card component */
.my-card {
  background-color: var(--p-color-surface);
  color: var(--p-color-primary);
  border: 1px solid var(--p-color-contrast-low);
  padding: var(--p-spacing-fluid-md);
  border-radius: var(--p-radius-lg);
}

.my-card:hover {
  background-color: var(--p-color-frosted-soft);
}

.my-card__error {
  color: var(--p-color-error);
  background: var(--p-color-error-frosted);
}
```

---

## v3 — Theme tokens (legacy system)

v3 has a different structure: each color has **two separate tokens**, one for light and one for dark, and the choice is made via the `theme` prop on components or via a global HTML attribute.

### v3 naming structure

```
themeLight{Scope}{Variant}
themeDark{Scope}{Variant}
```

E.g. `themeLightPrimary` + `themeDarkPrimary`, `themeLightBackgroundSurface` + `themeDarkBackgroundSurface`.

### Complete v3 → v4 mapping

If you are migrating from v3 to v4, use this mapping to find the new name:

| v3 (light/dark) | v4 (unified) |
|---|---|
| `themeLightPrimary` / `themeDarkPrimary` | `colorPrimary` |
| `themeLightBackgroundBase` / `themeDarkBackgroundBase` | `colorCanvas` |
| `themeLightBackgroundSurface` / `themeDarkBackgroundSurface` | `colorSurface` |
| `themeLightBackgroundShading` / `themeDarkBackgroundShading` | `colorBackdrop` |
| `themeLightBackgroundFrosted` / `themeDarkBackgroundFrosted` | `colorFrosted` |
| `themeLightContrastLow` / `themeDarkContrastLow` | `colorContrastLow` |
| `themeLightContrastMedium` / `themeDarkContrastMedium` | `colorContrastMedium` |
| `themeLightContrastHigh` / `themeDarkContrastHigh` | `colorContrastHigh` |
| `themeLightNotificationSuccess` / `themeDarkNotificationSuccess` | `colorSuccess` |
| `themeLightNotificationSuccessSoft` / `themeDarkNotificationSuccessSoft` | `colorSuccessFrosted` |
| `themeLightNotificationWarning` / `themeDarkNotificationWarning` | `colorWarning` |
| `themeLightNotificationWarningSoft` / `themeDarkNotificationWarningSoft` | `colorWarningFrosted` |
| `themeLightNotificationError` / `themeDarkNotificationError` | `colorError` |
| `themeLightNotificationErrorSoft` / `themeDarkNotificationErrorSoft` | `colorErrorFrosted` |
| `themeLightNotificationInfo` / `themeDarkNotificationInfo` | `colorInfo` |
| `themeLightNotificationInfoSoft` / `themeDarkNotificationInfoSoft` | `colorInfoFrosted` |
| `themeLightStateHover` / `themeDarkStateHover` | Removed, use `colorFrostedSoft` for hover |
| `themeLightStateActive` / `themeDarkStateActive` | Removed, handled by components |
| `themeLightStateFocus` / `themeDarkStateFocus` | `colorFocus` |
| `themeLightStateDisabled` / `themeDarkStateDisabled` | Removed, use `colorContrastLow` or manual opacity |

### v3 Tailwind classes

In v3, the PDS Tailwind utilities support **fixed variants** that bypass the active theme:

```html
<!-- Dynamic: follows the active theme (default) -->
<div class="text-primary bg-surface">...</div>

<!-- Forced to light -->
<div class="text-primary-light bg-surface-light">...</div>

<!-- Forced to dark -->
<div class="text-primary-dark bg-surface-dark">...</div>
```

To enable global theme switching in v3, add the `.dark` or `.auto` class to the `<html>`:

```html
<!-- Light (default) -->
<html>

<!-- Forced dark -->
<html class="dark">

<!-- Auto (follows OS) -->
<html class="auto">
```

In v4 this convention has been replaced by `.scheme-light`, `.scheme-dark`, `.scheme-light-dark`.

### v3 — usage in components

```tsx
// v3: theme as a prop on every component, or on the Provider
<PorscheDesignSystemProvider theme="auto">
  <PButton theme="auto">Button</PButton>
  <PText theme="auto" color="contrast-high">Text</PText>
</PorscheDesignSystemProvider>
```

v4 equivalent:

```tsx
// v4: no theme prop, handled via global CSS class
<PorscheDesignSystemProvider>
  <PButton>Button</PButton>
  <PText color="contrast-high">Text</PText>
</PorscheDesignSystemProvider>
// with <body class="scheme-light-dark">
```

## Cheatsheet: when to use what

| Scenario | Recommended token |
|---|---|
| Main page, "infinite" background | `canvas` (bg-canvas) |
| Raised cards, modals, panels | `surface` (bg-surface) |
| Main H1-H2 title | `primary` (text-primary) |
| Standard body text | `contrast-high` (text-contrast-high) |
| Label / caption / secondary | `contrast-medium` (text-contrast-medium) |
| Divider, decorative borders | `contrast-low` (border-contrast-low) — **not for text** |
| Glassmorphism / blur background | `frosted` (bg-frosted) + `backdrop-blur` |
| Modal overlay | `backdrop` (bg-backdrop) |
| CTA link | `primary` |
| Success text (valid, OK) | `success` (text-success) |
| Warning text | `warning` (text-warning) |
| Error text (form validation) | `error` (text-error) |
| Info text (tooltip, hint) | `info` (text-info) |
| Accessible focus ring | `focus` (outline-focus) |
