# Setup: React + Vite + Porsche Design System

This is the guide for a standalone React SPA (Vite + optional React Router, no SSR). If you are using React Router with SSR see `setup-react-router.md`. If you are using Next.js see `setup-nextjs.md`.

## Stack dependencies

**v3**: `vite@7 react@19 tailwindcss@4 @porsche-design-system/components-react@3`
**v4**: `vite@8 react@19 tailwindcss@4 @porsche-design-system/components-react@4`

## v4 — Complete setup

### 1. Create the project

```bash
npm create vite@latest my-app -- --template react-ts
cd my-app
npm install
```

### 2. Install PDS and Tailwind

```bash
npm install @porsche-design-system/components-react
npm install tailwindcss @tailwindcss/vite
```

### 3. Wrap with `PorscheDesignSystemProvider`

```tsx
// src/main.tsx
import { StrictMode } from 'react';
import { createRoot } from 'react-dom/client';
import { PorscheDesignSystemProvider } from '@porsche-design-system/components-react';
import App from './App.tsx';
import './index.css';

createRoot(document.getElementById('root')!).render(
  <StrictMode>
    <PorscheDesignSystemProvider>
      <App />
    </PorscheDesignSystemProvider>
  </StrictMode>
);
```

### 4. Set up the global CSS

```css
/* src/index.css */
@import '@porsche-design-system/components-react';
@import 'tailwindcss';
@import '@porsche-design-system/components-react/tailwindcss';

/* FOUC prevention (v4) */
:not(:defined) {
  visibility: hidden;
}
```

### 5. Configure `vite.config.ts`

```ts
// vite.config.ts
import { defineConfig } from 'vite';
import react from '@vitejs/plugin-react';
import tailwindcss from '@tailwindcss/vite';
import { Features } from 'lightningcss';
import {
  getComponentChunkLinks,
  getFontLinks,
  getIconLinks,
  getMetaTagsAndIconLinks,
} from '@porsche-design-system/components-react/partials';

// Plugin to inject the PDS partials into the <head>
const transformIndexHtmlPlugin = () => ({
  name: 'pds-html-transform',
  transformIndexHtml(html: string) {
    const headPartials = [
      getFontLinks(),
      getIconLinks(),
      getComponentChunkLinks(),
      getMetaTagsAndIconLinks({ appTitle: 'My App' }),
    ].join('');
    return html.replace(/<\/head>/, `${headPartials}$&`);
  },
});

export default defineConfig({
  plugins: [react(), transformIndexHtmlPlugin(), tailwindcss()],
  css: {
    transformer: 'lightningcss',
    lightningcss: {
      // Fix lightningcss bug with light-dark()
      exclude: Features.LightDark,
    },
  },
});
```

### 6. Apply the color scheme

```html
<!-- index.html -->
<!doctype html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>My App</title>
  </head>
  <body class="scheme-light-dark">
    <div id="root"></div>
    <script type="module" src="/src/main.tsx"></script>
  </body>
</html>
```

### 7. Use the components

```tsx
// src/App.tsx
import { PButton, PHeading, PText, PWordmark } from '@porsche-design-system/components-react';

export default function App() {
  return (
    <main className="grid justify-items-center gap-fluid-md m-static-lg p-fluid-lg bg-surface rounded-lg">
      <PWordmark />
      <PHeading size="xl" tag="h1">Welcome</PHeading>
      <PText size="md">Built with Porsche Design System v4.</PText>
      <PButton onClick={() => alert('Hello')}>Get started</PButton>
    </main>
  );
}
```

---

## v3 — Complete setup

### 1. Create the project

```bash
npm create vite@latest my-app -- --template react-ts
cd my-app
npm install
```

### 2. Install PDS and Tailwind

```bash
npm install @porsche-design-system/components-react
npm install tailwindcss @tailwindcss/vite
```

### 3. Wrap with `PorscheDesignSystemProvider` (v3 — with theme prop)

```tsx
// src/main.tsx
import { StrictMode } from 'react';
import { createRoot } from 'react-dom/client';
import { PorscheDesignSystemProvider } from '@porsche-design-system/components-react';
import App from './App.tsx';
import './index.css';

createRoot(document.getElementById('root')!).render(
  <StrictMode>
    {/* v3: theme can be "light" | "dark" | "auto" */}
    <PorscheDesignSystemProvider theme="auto">
      <App />
    </PorscheDesignSystemProvider>
  </StrictMode>
);
```

### 4. Set up the CSS (v3 — the PDS stylesheet import is not needed)

```css
/* src/index.css */
@import 'tailwindcss';
@import '@porsche-design-system/components-react/tailwindcss';
```

### 5. Configure `vite.config.ts` with all v3 partials

```ts
// vite.config.ts
import { defineConfig } from 'vite';
import react from '@vitejs/plugin-react';
import tailwindcss from '@tailwindcss/vite';
import {
  getComponentChunkLinks,
  getFontFaceStyles,
  getFontLinks,
  getIconLinks,
  getInitialStyles,
  getMetaTagsAndIconLinks,
} from '@porsche-design-system/components-react/partials';

const transformIndexHtmlPlugin = () => ({
  name: 'pds-html-transform',
  transformIndexHtml(html: string) {
    const headPartials = [
      // v3: getInitialStyles() is REQUIRED (prevents FOUC, not removed as in v4)
      getInitialStyles(),
      // v3: manual font face styles
      getFontFaceStyles(),
      getFontLinks(),
      getComponentChunkLinks(),
      getIconLinks(),
      getMetaTagsAndIconLinks({ appTitle: 'My App' }),
    ].join('');
    return html.replace(/<\/head>/, `${headPartials}$&`);
  },
});

export default defineConfig({
  plugins: [react(), transformIndexHtmlPlugin(), tailwindcss()],
});
```

### 6. Use the components (v3 — different props)

```tsx
// src/App.tsx
import { PButton, PHeading, PText, PWordmark } from '@porsche-design-system/components-react';

export default function App() {
  return (
    <main className="grid justify-items-center gap-fluid-md m-static-lg p-fluid-lg bg-surface rounded-lg">
      <PWordmark />
      {/* v3: size uses long form values: small, medium, large, x-large, xx-large */}
      <PHeading size="x-large" tag="h1">Welcome</PHeading>
      <PText size="medium">Built with Porsche Design System v3.</PText>
      <PButton onClick={() => alert('Hello')}>Get started</PButton>
    </main>
  );
}
```

---

## React + Vite troubleshooting

**TypeScript error on `transformIndexHtml`** → it is a false positive from the type mismatch between Vite and PDS types. Add `// @ts-expect-error` above the plugin line or the type `(html: string) => string`.

**Wrong colors in dark mode (v4)** → verify the lightningcss fix. It is the most common cause.

**Warning "PButton is not defined"** → make sure the `PorscheDesignSystemProvider` actually wraps `<App />` in `main.tsx`, not just a subtree.

**The partials are not injected into the HTML** → verify that the `transformIndexHtmlPlugin` is present in the `plugins` array of `vite.config.ts`. The order of the plugins does not matter for this.

**The Porsche Next font does not load** → open the browser's Network tab and look for `cdn.ui.porsche.com/porsche-design-system/fonts/...`. If you do not see the request, the partials have not been injected. If you see it but it returns 404 or a CORS error, check that there are no CSP headers blocking `cdn.ui.porsche.com`.

**Slow HMR / components "flickering" in dev** → it happens because every HMR reinitializes Stencil. In production it is not visible. It is not a bug.
