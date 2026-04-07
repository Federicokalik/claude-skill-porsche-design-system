# Setup: Next.js (App Router) + Porsche Design System

Next.js requires the **SSR** sub-package of PDS React: `@porsche-design-system/components-react/ssr`. It is a specialized build that renders different markup on the server (Declarative Shadow DOM) compared to the client. **All component imports** must come from `/ssr`, including the Provider and individual components (PButton, PHeading, etc.).

## Stack dependencies

**v3**: `next@15 react@19 tailwindcss@4 @porsche-design-system/components-react@3`
**v4**: `next@15 react@19 tailwindcss@4 @porsche-design-system/components-react@4`

## v4 — Complete setup

### 1. Create the project

```bash
npx create-next-app@latest
# ✔ What is your project named? "my-app"
# ✔ Would you like to use TypeScript? "Yes"
# ✔ Would you like to use ESLint? "Yes"
# ✔ Would you like to use Tailwind CSS? "Yes"
# ✔ Would you like your code inside a `src/` directory? "No"
# ✔ Would you like to use App Router? (recommended) "Yes"
# ✔ Would you like to use Turbopack for `next dev`? "No"
# ✔ Would you like to customize the import alias (`@/*` by default)? "No"

cd my-app
```

### 2. Install PDS

```bash
npm install @porsche-design-system/components-react
```

### 3. Set up the global CSS

```css
/* app/globals.css */
@import '@porsche-design-system/components-react';
@import 'tailwindcss';
@import '@porsche-design-system/components-react/tailwindcss';

/* FOUC prevention for SSR: excludes elements with data-ssr attribute */
:not(:defined,[data-ssr]) {
  visibility: hidden;
}
```

### 4. Configure the Root Layout (all imports from `/ssr`!)

```tsx
// app/layout.tsx
import { PorscheDesignSystemProvider } from '@porsche-design-system/components-react/ssr';
import {
  getComponentChunkLinks,
  getFontLinks,
  getIconLinks,
  getMetaTagsAndIconLinks,
} from '@porsche-design-system/components-react/partials';
import './globals.css';

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  return (
    <html lang="en">
      <head>
        {/* Partials injected as JSX elements */}
        {getFontLinks({ format: 'jsx' })}
        {getComponentChunkLinks({ format: 'jsx' })}
        {getIconLinks({ format: 'jsx' })}
        {getMetaTagsAndIconLinks({ appTitle: 'My App', format: 'jsx' })}
      </head>
      <body className="scheme-light-dark">
        <PorscheDesignSystemProvider>{children}</PorscheDesignSystemProvider>
      </body>
    </html>
  );
}
```

### 5. Configure `next.config.ts` for the lightningcss fix (only if using Turbopack)

If you use the Turbopack bundler with CSS lightningcss:

```ts
// next.config.ts
import type { NextConfig } from 'next';

const nextConfig: NextConfig = {
  experimental: {
    useLightningcss: true,
    lightningCssFeatures: {
      // Fix lightningcss bug with light-dark()
      exclude: ['light-dark'],
    },
  },
};

export default nextConfig;
```

If you do not use Turbopack (default in Next 15 if you answer "No" in the wizard), this step is not needed.

### 6. Use the components (ALWAYS import from `/ssr`)

```tsx
// app/page.tsx
import {
  PButton,
  PHeading,
  PText,
  PWordmark,
} from '@porsche-design-system/components-react/ssr'; // ← ALWAYS /ssr

export default function Home() {
  return (
    <main className="grid justify-items-center gap-fluid-md m-static-lg p-fluid-lg bg-surface rounded-lg">
      <PWordmark />
      <PHeading size="xl" tag="h1">
        Welcome
      </PHeading>
      <PText size="md">Next.js 15 + Porsche Design System v4.</PText>
      <PButton>Get started</PButton>
    </main>
  );
}
```

### 7. Client components with event handlers

For components that have `onClick`, `onChange`, etc., mark the file as a client component:

```tsx
// app/components/InteractiveButton.tsx
'use client';

import { PButton } from '@porsche-design-system/components-react/ssr';
import { useState } from 'react';

export default function InteractiveButton() {
  const [count, setCount] = useState(0);
  return (
    <PButton onClick={() => setCount(c => c + 1)}>
      Clicked {count} times
    </PButton>
  );
}
```

---

## v3 — Complete setup

### 1. Create the project

```bash
npx create-next-app@latest
cd my-app
```

### 2. Install PDS

```bash
npm install @porsche-design-system/components-react
```

### 3. Set up the global CSS (v3 — only Tailwind + PDS theme)

```css
/* app/globals.css */
@import 'tailwindcss';
@import '@porsche-design-system/components-react/tailwindcss';
```

### 4. Configure the Root Layout (v3 — with getInitialStyles and getFontFaceStyles)

```tsx
// app/layout.tsx
import { PorscheDesignSystemProvider } from '@porsche-design-system/components-react/ssr';
import {
  getComponentChunkLinks,
  getFontFaceStyles,
  getFontLinks,
  getIconLinks,
  getInitialStyles,
  getMetaTagsAndIconLinks,
} from '@porsche-design-system/components-react/partials';
import './globals.css';

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  return (
    <html lang="en">
      <head>
        {/* v3: getInitialStyles REQUIRED */}
        {getInitialStyles({ format: 'jsx' })}
        {/* v3: getFontFaceStyles is not included automatically */}
        {getFontFaceStyles({ format: 'jsx' })}
        {getFontLinks({ format: 'jsx' })}
        {getComponentChunkLinks({ format: 'jsx' })}
        {getIconLinks({ format: 'jsx' })}
        {getMetaTagsAndIconLinks({ appTitle: 'My App', format: 'jsx' })}
      </head>
      <body>
        {/* v3: theme prop on the Provider */}
        <PorscheDesignSystemProvider theme="auto">
          {children}
        </PorscheDesignSystemProvider>
      </body>
    </html>
  );
}
```

### 5. Use the components (v3 — different props)

```tsx
// app/page.tsx
import {
  PButton,
  PHeading,
  PText,
  PWordmark,
} from '@porsche-design-system/components-react/ssr';

export default function Home() {
  return (
    <main className="grid justify-items-center gap-fluid-md m-static-lg p-fluid-lg bg-surface rounded-lg">
      <PWordmark />
      {/* v3: size uses long form values */}
      <PHeading size="x-large" tag="h1">
        Welcome
      </PHeading>
      <PText size="medium">Next.js 15 + PDS v3.</PText>
      <PButton>Get started</PButton>
    </main>
  );
}
```

---

## Next.js-specific gotchas

**Error "Cannot find module '@porsche-design-system/components-react/ssr'"** → you probably installed a version that is too old. The `/ssr` sub-package exists from 3.x. Check `package.json`: you must have at least `"@porsche-design-system/components-react": "^3.0.0"`.

**Hydration mismatch warning** → almost always caused by a wrong import. All PDS component imports in Next.js must come from `/ssr`, never from `@porsche-design-system/components-react` alone. Do a find-replace in your codebase:
- `from '@porsche-design-system/components-react'` → `from '@porsche-design-system/components-react/ssr'`

**Components do not render server-side** → they are rendered via Declarative Shadow DOM, which is supported by Chrome 111+, Firefox 123+, Safari 16.4+. If you test on older browsers you might only see empty components until client-side hydration.

**FOUC visible before hydration (v4)** → verify that the CSS rule `:not(:defined,[data-ssr]) { visibility: hidden; }` is present in `globals.css`. The version without `[data-ssr]` also hides SSR-rendered components (which already have valid markup), causing a flash.

**Error "Text content does not match" in dev mode** → happens with React i18n when the server renders a different language than the client. Not related to PDS.

**`onClick`, `onChange`, event handlers do not work** → add `'use client'` at the top of the file. Components with state or handlers are client components.

**Turbopack build fails with CSS light-dark() error** → see step 5 for the fix `lightningCssFeatures: { exclude: ['light-dark'] }` in `next.config.ts`.

**Pages Router → App Router migration** → PDS supports both, but the official documentation only covers App Router. If the user has Pages Router, recommend migrating or adapt the setup to `_app.tsx` + `_document.tsx` (the Provider goes in `_app.tsx`, the partials go in the `<Head>` of `_document.tsx`).
