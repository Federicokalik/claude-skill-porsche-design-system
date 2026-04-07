# Setup: Astro + Porsche Design System

Astro uses PDS via the **Vanilla JS** package (`@porsche-design-system/components-js`) because the components are native web components that work directly in HTML. If the Astro project also uses React islands, the setup is the same: you import `@porsche-design-system/components-js` for the Astro HTML, and `@porsche-design-system/components-react` inside the React islands (but you can also use the `<p-*>` web components inside `.tsx` files if marked as custom elements).

## Stack dependencies

**v3**: `astro@5 @porsche-design-system/components-js@3 tailwindcss@4`
**v4**: `astro@6 @porsche-design-system/components-js@4 tailwindcss@4`

## v4 — Complete setup

### 1. Create the project

```bash
npm create astro@latest my-app
# ✔ Where should we create your new project?: "./my-app"
# ✔ How would you like to start your new project?: "A basic, helpful starter project"
# ✔ Install dependencies?: "Yes"
# ✔ Initialize a new git repository?: "Yes"

cd my-app
```

### 2. Install PDS

```bash
npm install @porsche-design-system/components-js
npm install tailwindcss @tailwindcss/vite
```

### 3. Create the global CSS

```css
/* src/styles/global.css */
@import '@porsche-design-system/components-js';
@import 'tailwindcss';
@import '@porsche-design-system/components-js/tailwindcss';

/* Manual FOUC prevention (required in v4) */
:not(:defined) {
  visibility: hidden;
}
```

### 4. Configure `astro.config.mjs`

```js
// astro.config.mjs
// @ts-check
import { defineConfig } from 'astro/config';
import tailwindcss from '@tailwindcss/vite';
import { Features } from 'lightningcss';

export default defineConfig({
  vite: {
    plugins: [tailwindcss()],
    css: {
      transformer: 'lightningcss',
      lightningcss: {
        // Fix for lightningcss bug with light-dark()
        exclude: Features.LightDark,
      },
    },
  },
});
```

### 5. Configure the main Layout

```astro
---
// src/layouts/Layout.astro
import '../styles/global.css';
import {
  getComponentChunkLinks,
  getFontLinks,
  getIconLinks,
  getLoaderScript,
  getMetaTagsAndIconLinks,
} from '@porsche-design-system/components-js/partials';
---

<!doctype html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width" />
    <meta name="generator" content={Astro.generator} />
    <title>My App</title>

    <!-- preload Porsche Next font (reduces FOUT) -->
    <Fragment set:html={getFontLinks()} />
    <!-- preload icons -->
    <Fragment set:html={getIconLinks()} />
    <!-- preload component core chunk -->
    <Fragment set:html={getComponentChunkLinks()} />
    <!-- favicon, apple touch icons, android touch icons -->
    <Fragment set:html={getMetaTagsAndIconLinks({ appTitle: 'My App' })} />
  </head>
  <body class="scheme-light-dark">
    <slot />
    <!-- The loader script goes AT THE BOTTOM of the body -->
    <Fragment set:html={getLoaderScript()} />
  </body>
</html>
```

### 6. Use the components

```astro
---
// src/pages/index.astro
import Layout from '../layouts/Layout.astro';
---

<Layout>
  <main class="grid justify-items-center gap-fluid-md m-static-lg p-fluid-lg bg-surface rounded-lg">
    <p-wordmark></p-wordmark>
    <h1 class="prose-heading-4xl">Welcome</h1>
    <p-text size="md">This is a landing page built with Porsche Design System.</p-text>
    <p-button>Get started</p-button>
  </main>
</Layout>
```

### 7. (Optional) Astro + Vue for reactivity

If you want to use PDS components with Vue reactivity inside Astro:

```bash
npx astro add vue
```

```js
// astro.config.mjs
import vue from '@astrojs/vue';
import tailwindcss from '@tailwindcss/vite';
import { defineConfig } from 'astro/config';
import { Features } from 'lightningcss';

export default defineConfig({
  integrations: [
    vue({
      template: {
        compilerOptions: {
          // Treat p-* tags as custom elements, not Vue components
          isCustomElement: (tag) => tag.startsWith('p-'),
        },
      },
    }),
  ],
  vite: {
    plugins: [tailwindcss()],
    css: {
      transformer: 'lightningcss',
      lightningcss: { exclude: Features.LightDark },
    },
  },
});
```

---

## v3 — Complete setup

### 1. Create the project

```bash
npm create astro@latest my-app
cd my-app
```

### 2. Install PDS

```bash
npm install @porsche-design-system/components-js
npm install tailwindcss @tailwindcss/vite
```

### 3. Configure `astro.config.mjs`

```js
// astro.config.mjs
// @ts-check
import { defineConfig } from 'astro/config';
import tailwindcss from '@tailwindcss/vite';

export default defineConfig({
  vite: {
    // @ts-expect-error: types mismatch between Astro and the Tailwind plugin
    plugins: [tailwindcss()],
  },
});
```

### 4. Create the global CSS

```css
/* src/styles/global.css */
@import 'tailwindcss';
@import '@porsche-design-system/components-js/tailwindcss';
```

### 5. Configure the main Layout (v3 partials)

```astro
---
// src/layouts/Layout.astro
import '../styles/global.css';
import {
  getInitialStyles,
  getFontFaceStyles,
  getFontLinks,
  getComponentChunkLinks,
  getIconLinks,
  getLoaderScript,
  getMetaTagsAndIconLinks,
} from '@porsche-design-system/components-js/partials';
---

<!doctype html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width" />
    <meta name="generator" content={Astro.generator} />
    <title>My App</title>

    <!-- Pre-hydration component visibility (REQUIRED in v3) -->
    <Fragment set:html={getInitialStyles()} />
    <!-- Porsche Next font face (reduces FOUT) -->
    <Fragment set:html={getFontFaceStyles()} />
    <!-- Preload font -->
    <Fragment set:html={getFontLinks()} />
    <!-- Preload core chunk -->
    <Fragment set:html={getComponentChunkLinks()} />
    <!-- Preload icons -->
    <Fragment set:html={getIconLinks()} />
    <!-- Favicon + icon links -->
    <Fragment set:html={getMetaTagsAndIconLinks({ appTitle: 'My App' })} />
  </head>
  <body>
    <slot />
    <Fragment set:html={getLoaderScript()} />
  </body>
</html>
```

### 6. Use the components (v3 — theme via prop)

```astro
---
// src/pages/index.astro
import Layout from '../layouts/Layout.astro';
---

<Layout>
  <main class="grid justify-items-center gap-fluid-md m-static-lg p-fluid-lg bg-surface rounded-lg">
    <!-- v3: theme="auto" to follow OS preference -->
    <p-wordmark theme="auto"></p-wordmark>
    <h1 class="prose-display-md">Welcome</h1>
    <p-text theme="auto" size="medium">A landing page built with PDS v3.</p-text>
    <p-button theme="auto">Get started</p-button>
  </main>
</Layout>
```

**NOTE**: in v3 the theme is passed as an attribute to EVERY component, or set globally through `document.documentElement.setAttribute('data-theme', 'auto')` via a client-side `<script>`. In v4 it is much cleaner with the `scheme-light-dark` class on the body.

---

## Astro troubleshooting

**Error "Unknown custom element: p-button"** → Astro does not recognize `p-*` elements by default. This is not a problem because they are native web components and work anyway in the browser. If you see warnings at build-time, ignore them — they do not block the output.

**FOUC visible at the first render** (components that "jump") → verify that the global CSS is imported before everything and that the `:not(:defined) { visibility: hidden; }` rule is present in v4, or that `getInitialStyles()` is in the head in v3.

**Porsche Next font does not load** → verify that the `getFontLinks()` + `getLoaderScript()` partials are both present in the layout. The loader script downloads the font faces at runtime.

**Wrong colors in dark mode (v4)** → it is almost always the lightningcss bug. Verify you added `exclude: Features.LightDark` in the `vite.config` inside `astro.config.mjs`.

**Duplicated components if you navigate between Astro pages** → make sure that `getLoaderScript()` is called ONCE in the shared layout, not in every page.

## How to integrate React islands with PDS inside Astro

If you have `.astro` + React islands in `.tsx`:

```bash
npm install @porsche-design-system/components-react
npx astro add react
```

In the island's `.tsx` you can use both `<p-button>` (web component) and `<PButton>` (React wrapper), but **use the React wrapper** for typed props and React-style event handlers:

```tsx
// src/components/Counter.tsx
import { PButton, PText } from '@porsche-design-system/components-react';
import { useState } from 'react';

export default function Counter() {
  const [count, setCount] = useState(0);
  return (
    <div className="flex flex-col gap-fluid-sm">
      <PText size="md">Counter: {count}</PText>
      <PButton onClick={() => setCount(c => c + 1)}>Increment</PButton>
    </div>
  );
}
```

```astro
---
// src/pages/counter.astro
import Layout from '../layouts/Layout.astro';
import Counter from '../components/Counter.tsx';
---
<Layout>
  <Counter client:load />
</Layout>
```

**Important**: in this scenario the `PorscheDesignSystemProvider` **is NOT needed** because the vanilla package already loaded by the `.astro` layout initializes everything. The React islands only use the `components-react` wrappers as ergonomic alternatives.
