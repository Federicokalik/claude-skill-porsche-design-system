# Tokens: Spacing

The PDS spacing system has two distinct token families: **fluid** (responsive, scales with the viewport via `clamp()`) and **static** (fixed pixels, they do not scale). This is perhaps the part of PDS with the highest ROI: using `gap-fluid-md` instead of `gap-4` (or a custom gap) automatically gives you spacing that adapts from mobile to desktop without media queries.

The system is practically identical between v3 and v4. **Always use these tokens instead of arbitrary pixel values** — including margin, padding, gap, top/bottom/left/right offsets.

## General rule: fluid vs static

**Fluid**: use for **spacing between sections or large content**, where you want the spacing to adapt to the viewport. Examples: gap between cards in a grid, padding of a hero, margin between sections of a landing page.

**Static**: use for **spacing inside components or where the pixel value matters**. Examples: internal button padding, gap between icon and label, border width, minimal offsets.

Rule of thumb: if the value is **< 32px**, almost always static. If it is **≥ 32px**, almost always fluid (unless you want a fixed non-responsive layout).

## Fluid tokens

| JS/SCSS token | CSS variable | Tailwind utility | Value (clamp) | Desktop equivalent |
|---|---|---|---|---|
| `spacingFluidXs` | `--p-spacing-fluid-xs` | `*-fluid-xs` | `clamp(4px, 0.25vw + 3px, 8px)` | ~8px |
| `spacingFluidSm` | `--p-spacing-fluid-sm` | `*-fluid-sm` | `clamp(8px, 0.5vw + 6px, 16px)` | ~16px |
| `spacingFluidMd` | `--p-spacing-fluid-md` | `*-fluid-md` | `clamp(16px, 1.25vw + 12px, 36px)` | ~36px |
| `spacingFluidLg` | `--p-spacing-fluid-lg` | `*-fluid-lg` | `clamp(32px, 2.75vw + 23px, 76px)` | ~76px |
| `spacingFluidXl` | `--p-spacing-fluid-xl` | `*-fluid-xl` | `clamp(48px, 3vw + 38px, 96px)` | ~96px |
| `spacingFluid2Xl` | `--p-spacing-fluid-2xl` | `*-fluid-2xl` | `clamp(80px, 7.5vw + 56px, 200px)` | ~200px |

The `*` in the Tailwind utility is the prefix for the property: `gap-fluid-md`, `p-fluid-md`, `pt-fluid-md`, `m-fluid-md`, `mx-fluid-md`, etc. It works like normal Tailwind modifiers.

## Static tokens

| JS/SCSS token | CSS variable | Tailwind utility | Fixed value |
|---|---|---|---|
| `spacingStatic2Xs` | `--p-spacing-static-2xs` | `*-static-2xs` | `1px` |
| `spacingStaticXs` | `--p-spacing-static-xs` | `*-static-xs` | `4px` |
| `spacingStaticSm` | `--p-spacing-static-sm` | `*-static-sm` | `8px` |
| `spacingStaticMd` | `--p-spacing-static-md` | `*-static-md` | `16px` |
| `spacingStaticLg` | `--p-spacing-static-lg` | `*-static-lg` | `32px` |
| `spacingStaticXl` | `--p-spacing-static-xl` | `*-static-xl` | `48px` |
| `spacingStatic2Xl` | `--p-spacing-static-2xl` | `*-static-2xl` | `80px` |

## Practical usage examples

### Hero section with fluid spacing

```tsx
<section className="p-fluid-xl grid gap-fluid-lg justify-items-center bg-surface">
  <PHeading size="5xl" tag="h1">Hero title</PHeading>
  <PText size="lg" className="max-w-2xl text-center">
    Descriptive subtitle with spacing that adapts from mobile to desktop.
  </PText>
  <div className="flex gap-fluid-sm flex-wrap justify-center">
    <PButton>Primary CTA</PButton>
    <PButton variant="secondary">Secondary CTA</PButton>
  </div>
</section>
```

### Card with mixed spacing (fluid outside, static inside)

```tsx
<article className="p-fluid-md bg-surface rounded-lg">
  {/* Fluid outer padding: scales from mobile to desktop */}
  <div className="flex flex-col gap-static-md">
    {/* Static inner gap: always 16px between elements */}
    <PHeading size="lg" tag="h3">Card title</PHeading>
    <PText size="md">Card description.</PText>
    <div className="flex items-center gap-static-sm">
      {/* Inner gap between icon and label: always 8px */}
      <PIcon name="arrow-right" />
      <PText size="sm">Read more</PText>
    </div>
  </div>
</article>
```

### Responsive card grid

```tsx
<div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-fluid-md p-fluid-lg">
  <Card />
  <Card />
  <Card />
</div>
```

### Form with consistent spacing

```tsx
<form className="flex flex-col gap-fluid-sm max-w-xl">
  <PInputText label="First name" name="firstName" />
  <PInputText label="Last name" name="lastName" />
  <PInputEmail label="Email" name="email" />
  <PTextarea label="Message" name="message" rows={5} />
  <div className="flex gap-static-md pt-fluid-sm">
    <PButton type="submit">Submit</PButton>
    <PButton type="reset" variant="secondary">Reset</PButton>
  </div>
</form>
```

## Spacing in custom CSS

You can use the spacing tokens in hand-written CSS for your own components:

```css
.my-section {
  padding: var(--p-spacing-fluid-lg) var(--p-spacing-fluid-md);
  gap: var(--p-spacing-fluid-md);
}

.my-card__content {
  padding: var(--p-spacing-static-lg);
}

.my-icon-text {
  display: inline-flex;
  align-items: center;
  gap: var(--p-spacing-static-xs);
}
```

## Cheatsheet: which token for what

| Situation | Recommended token |
|---|---|
| Space between icon and text (e.g. `<PIcon>Label`) | `static-xs` (4px) or `static-sm` (8px) |
| Internal button padding | handled by PDS, do not touch |
| Card padding | `fluid-md` (16-36px) |
| Margin between paragraphs | `static-md` (16px) or `fluid-sm` (8-16px) |
| Form field gap | `fluid-sm` (8-16px) |
| Margin between page sections | `fluid-lg` (32-76px) or `fluid-xl` (48-96px) |
| Hero padding | `fluid-xl` (48-96px) or `fluid-2xl` (80-200px) |
| Margin between cards in a grid | `fluid-md` (16-36px) |
| Divider offset | `fluid-sm` (8-16px) |
| Border width | use Tailwind `border` (1px) or `static-2xs` (1px) |
| Custom internal button padding | `static-sm` / `static-md` |

## Breakpoints (context for responsive choices)

From the PDS tokens/breakpoint page:

| Name | Min value | Typical use |
|---|---|---|
| `base` | `0` | Mobile first (default) |
| `xs` | `480px` | Large mobile |
| `sm` | `760px` | Tablet portrait |
| `md` | `1000px` | Tablet landscape / small desktop |
| `lg` | `1300px` | Desktop |
| `xl` | `1760px` | Large desktop |

These breakpoints are available in Tailwind with the `xs:`, `sm:`, `md:`, `lg:`, `xl:` syntax directly (PDS extends the Tailwind theme with these values).

**Note**: these are NOT the same default Tailwind breakpoints (which are `sm:640px`, `md:768px`, `lg:1024px`, `xl:1280px`, `2xl:1536px`). When you import `@porsche-design-system/components-{js|react}/tailwindcss`, the PDS breakpoints **replace** the Tailwind defaults.

```tsx
// Example: responsive grid with PDS breakpoints
<div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-fluid-md">
  {/* 1 col up to 760px, 2 col up to 1300px, 3 col up to 1760px, 4 col beyond */}
</div>
```
