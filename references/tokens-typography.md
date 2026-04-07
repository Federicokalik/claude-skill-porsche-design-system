# Tokens: Typography

The PDS type system revolves around **a single font family** (Porsche Next) and a set of Tailwind utility classes (`.prose-display-*`, `.prose-heading-*`, `.prose-text-*`) that combine font-size + line-height + letter-spacing consistent with the design language. Using these classes, you no longer need to worry about `leading-*`, `tracking-*`, `text-*` separately.

## Porsche Next: the proprietary font

PDS automatically includes **Porsche Next**, the brand's proprietary font. It is loaded from `cdn.ui.porsche.com` in two main weights: **regular** (400) and **semi-bold** (600). In v4 all headings use `regular` by default (in v3 they used `semi-bold`).

⚠️ **Porsche Next is a proprietary asset**. You cannot use it outside a Porsche-compatible context. See `licensing.md` for alternatives (Inter, Manrope, General Sans).

### How it is loaded

- **v4**: included automatically via the `@porsche-design-system/components-{js|react}` stylesheet import.
- **v3**: loaded via the `getFontFaceStyles()` partial + preload via `getFontLinks()`.

Do not import alternative Google Fonts or other font families in parallel — they would create FOUT and break typographic consistency.

## Fluid vs static typography

As with spacing, PDS offers:

- **Fluid prose classes** (`prose-display-*`, `prose-heading-*`, `prose-text-*`): scale with the viewport via `clamp()`. **Use these by default.**
- **Fixed font-size values** via standard Tailwind utilities (`text-lg`, `text-xl`, etc.): for special cases where you want an exact value that does not scale.

General rule: **always use the `prose-*` classes** unless you have a specific reason for a static font-size.

## Heading classes (v4)

For titles, large or small. The `prose-heading-*` family covers ALL title sizes in v4 — from small `sm` to giant hero `5xl`. Note that in v4 the `3xl`/`4xl`/`5xl` values are what in v3 were called `prose-display-sm/md/lg`.

| v4 class | Use | v3 equivalent |
|---|---|---|
| `.prose-heading-sm` | Small title, card title, form section | `.prose-heading-sm` |
| `.prose-heading-md` | Medium title, large card | `.prose-heading-md` |
| `.prose-heading-lg` | Section title | `.prose-heading-lg` |
| `.prose-heading-xl` | Important title, page | `.prose-heading-xl` |
| `.prose-heading-2xl` | Large page title | `.prose-heading-2xl` |
| `.prose-heading-3xl` | Small hero | `.prose-display-sm` |
| `.prose-heading-4xl` | Medium hero | `.prose-display-md` |
| `.prose-heading-5xl` | Giant hero, landing | `.prose-display-lg` |

The chosen HTML tag (`<h1>`, `<h2>`, `<h3>`, etc.) is **independent of the visual size**. The semantic hierarchy is decided by you for SEO/accessibility reasons:

```html
<!-- A visually small <h1> (for a page without a hero) -->
<h1 class="prose-heading-md">Dashboard</h1>

<!-- A visually giant <h2> (inside a hero section) -->
<h2 class="prose-heading-5xl">The new 911</h2>

<!-- A <p> used as a "decorative title" without H semantic value -->
<p class="prose-heading-xl">Iconic experience</p>
```

## Display classes (v3 only)

In v3 there were `prose-display-sm`, `prose-display-md`, `prose-display-lg` as "off-scale" typographic levels for heroes and emotional moments. **They were removed in v4** and absorbed into the `prose-heading-*` family as `3xl`, `4xl`, `5xl`.

| v3 class | v4 equivalent |
|---|---|
| `.prose-display-sm` | `.prose-heading-3xl` |
| `.prose-display-md` | `.prose-heading-4xl` |
| `.prose-display-lg` | `.prose-heading-5xl` |

If the user passes you v3 code with `prose-display-*`, replace it before migrating to v4.

## Text classes (paragraphs, body, captions)

For running text, paragraphs, labels, captions. Same family in v3 and v4.

| Class | Typical use | Notes |
|---|---|---|
| `.prose-text-2xs` | Disclaimer, fine print, legal | Use **only** for disclaimers. Not for normal informational content. |
| `.prose-text-xs` | Caption, metadata, secondary label | |
| `.prose-text-sm` | **Default for body text.** This is the standard size for paragraphs. | |
| `.prose-text-md` | Introduction, highlighted description | Pairs with medium heading. |
| `.prose-text-lg` | Subtitle under a large heading | Pairs with heading-xl/2xl. |
| `.prose-text-xl` | Subtitle under a display/hero | Pairs with heading-3xl/4xl/5xl. |

### Heading + text pairing rule

Pair a `prose-heading-*` with a `prose-text-*` **one or two steps smaller** to maintain visual hierarchy:

| Heading | Recommended text |
|---|---|
| `prose-heading-5xl` (hero) | `prose-text-xl` or `prose-text-lg` |
| `prose-heading-4xl` | `prose-text-lg` |
| `prose-heading-3xl` | `prose-text-lg` or `prose-text-md` |
| `prose-heading-2xl` | `prose-text-md` |
| `prose-heading-xl` | `prose-text-md` or `prose-text-sm` |
| `prose-heading-lg` | `prose-text-sm` |
| `prose-heading-md` | `prose-text-sm` |
| `prose-heading-sm` | `prose-text-xs` |

## Usage with PDS components (`size` prop)

The `<PHeading>` / `<p-heading>` and `<PText>` / `<p-text>` components have a `size` prop that corresponds to the suffixes of the prose classes:

```tsx
// v4 — use short-form (sm, md, lg, xl, 2xl, 3xl, 4xl, 5xl)
<PHeading size="4xl" tag="h1">Hero title</PHeading>
<PText size="lg">Subtitle</PText>
<PText size="sm">Body text</PText>
```

```tsx
// v3 — uses deprecated long-form (small, medium, large, x-large, xx-large)
// Still valid in v3 but deprecated in v4, will be removed in v5
<PHeading size="x-large" tag="h1">Title</PHeading>
<PText size="medium">Text</PText>
```

**Deprecated value mapping v3 → v4 on components**:

| `PHeading size` v3 | `PHeading size` v4 |
|---|---|
| `small` | `sm` |
| `medium` | `md` |
| `large` | `lg` |
| `x-large` | `xl` |
| `xx-large` | `2xl` |

| `PText size` v3 | `PText size` v4 |
|---|---|
| `xx-small` | `2xs` |
| `x-small` | `xs` |
| `small` | `sm` |
| `medium` | `md` |
| `large` | `lg` |
| `x-large` | `xl` |

Long-form values still work in v4 but emit deprecation warnings. Always use short-form for new code.

## Weight

In v4 all headings use `font-weight: 400` (regular) by default. To render a heading in semi-bold, use the `weight` prop:

```tsx
// v4
<PHeading size="xl" weight="semibold">Semibold heading</PHeading>
<PText size="md" weight="semibold">Semibold body</PText>

// Deprecated values (still valid but warning):
// weight="regular" → weight="normal"
// weight="semi-bold" → weight="semibold"
```

Do not use weights like 100, 200, 300, 700, 800, 900 — Porsche Next is distributed **only in regular (400) and semi-bold (600)**.

## Practical examples

### Hero section with fluid typography

```tsx
<section className="p-fluid-2xl grid gap-fluid-md justify-items-center text-center bg-surface">
  <PText size="sm" color="contrast-medium" className="uppercase tracking-wide">
    Iconic experience
  </PText>
  <PHeading size="5xl" tag="h1">
    The new Porsche 911
  </PHeading>
  <PText size="xl" className="max-w-2xl">
    Timeless design meets the technology of the future.
  </PText>
  <PButton>Discover more</PButton>
</section>
```

### Card with heading + paragraph

```tsx
<article className="p-fluid-md bg-surface rounded-lg">
  <PHeading size="lg" tag="h3" className="mb-static-sm">
    Card title
  </PHeading>
  <PText size="sm" color="contrast-high">
    Brief card description with default-sized text and high-contrast color.
  </PText>
</article>
```

### Form with label and helper text

```tsx
<div className="flex flex-col gap-static-xs">
  <PInputText label="Email" name="email" description="We will use this email to send you the quote." />
  <PText size="2xs" color="contrast-medium">
    We process your data in compliance with GDPR.
  </PText>
</div>
```

### Long-form article

```tsx
<article className="max-w-2xl mx-auto p-fluid-lg flex flex-col gap-fluid-md">
  <header className="flex flex-col gap-fluid-sm">
    <PText size="xs" color="contrast-medium">March 12, 2026 · 5 min read</PText>
    <PHeading size="3xl" tag="h1">Main article title</PHeading>
    <PText size="lg" color="contrast-high">
      Subtitle or standfirst summarizing the article in two or three lines.
    </PText>
  </header>

  <PText size="sm">
    First paragraph of the article body. Use prose-text-sm as the default for body text.
  </PText>

  <PHeading size="xl" tag="h2">First section</PHeading>
  <PText size="sm">Content of the first section...</PText>

  <PHeading size="lg" tag="h3">Subsection</PHeading>
  <PText size="sm">Content of the subsection...</PText>
</article>
```

## Standard Tailwind utilities available (font, leading, text)

Besides the `prose-*` classes, the PDS theme also customizes the standard Tailwind variables so that the `font-*`, `leading-*`, `text-*` utilities have values aligned with the design system. So you can still use:

- `font-porsche-next` — explicitly force Porsche Next (usually not needed, it is already the default)
- `leading-tight`, `leading-normal`, `leading-loose` — PDS-calibrated line-heights
- `text-xs`, `text-sm`, `text-base`, `text-lg`, `text-xl`, `text-2xl`, etc. — font-sizes (static, not fluid)

But **in general prefer `prose-*`** which combines font-size + leading + tracking consistently.

## Sources

- Typography Tailwind v4: `https://designsystem.porsche.com/v4/tailwindcss/typography/examples/`
- Typography Tailwind v3: `https://designsystem.porsche.com/v3/tailwindcss/typography/examples/`
- Font tokens v4: `https://designsystem.porsche.com/v4/tokens/font/`
- Styles Typography v3 (guidelines): `https://designsystem.porsche.com/v3/styles/typography/`
