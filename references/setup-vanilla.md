# Setup: Vanilla JS / pure HTML / Astro without framework + Porsche Design System

This guide covers the cases where you do NOT use a JS framework:
- **Vanilla JS with Vite** (`npm create vite@latest -- --template vanilla-ts` project)
- **Pure HTML** (single static page, served via nginx, Apache, CDN, GitHub Pages)
- **Astro without islands** (you use Astro only as a static generator, no React/Vue)
- **WordPress / Webflow / any CMS** that lets you add custom `<script>` and `<link>` tags in the head

In all these cases you use the **`@porsche-design-system/components-js`** package (not the React wrapper).

## Stack dependencies

**v3**: `vite@7 tailwindcss@4 @porsche-design-system/components-js@3`
**v4**: `vite@8 tailwindcss@4 @porsche-design-system/components-js@4`

## v4 — Complete setup (Vanilla JS + Vite)

### 1. Create the project

```bash
npm create vite@latest my-app -- --template vanilla-ts
cd my-app
npm install
```

### 2. Install PDS and Tailwind

```bash
npm install @porsche-design-system/components-js
npm install tailwindcss @tailwindcss/vite
```

### 3. Configure `vite.config.ts`

```ts
// vite.config.ts
import { defineConfig } from 'vite';
import tailwindcss from '@tailwindcss/vite';
import { Features } from 'lightningcss';
import {
  getLoaderScript,
  getComponentChunkLinks,
  getFontLinks,
  getIconLinks,
  getMetaTagsAndIconLinks,
} from '@porsche-design-system/components-js/partials';

const transformIndexHtmlPlugin = () => ({
  name: 'pds-html-transform',
  transformIndexHtml(html: string) {
    const headPartials = [
      getFontLinks(),
      getIconLinks(),
      getComponentChunkLinks(),
      getMetaTagsAndIconLinks({ appTitle: 'My App' }),
    ].join('');

    const bodyPartials = [getLoaderScript()].join('');

    return html
      .replace(/<\/head>/, `${headPartials}$&`)
      .replace(/<\/body>/, `${bodyPartials}$&`);
  },
});

export default defineConfig({
  plugins: [transformIndexHtmlPlugin(), tailwindcss()],
  css: {
    transformer: 'lightningcss',
    lightningcss: {
      // Fix lightningcss bug with light-dark()
      exclude: Features.LightDark,
    },
  },
});
```

### 4. Set up the global CSS

```css
/* src/style.css */
@import '@porsche-design-system/components-js';
@import 'tailwindcss';
@import '@porsche-design-system/components-js/tailwindcss';

/* Manual FOUC prevention (v4) */
:not(:defined) {
  visibility: hidden;
}
```

### 5. Edit `index.html`

```html
<!doctype html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>My App</title>
    <!-- the partials are injected here by the Vite plugin -->
  </head>
  <body class="scheme-light-dark">
    <div id="app"></div>
    <script type="module" src="/src/main.ts"></script>
    <!-- loader script injected here by the Vite plugin -->
  </body>
</html>
```

### 6. Use the components in main.ts

```ts
// src/main.ts
import './style.css';

document.querySelector<HTMLDivElement>('#app')!.innerHTML = `
  <main class="grid justify-items-center gap-fluid-md m-static-lg p-fluid-lg bg-surface rounded-lg">
    <p-wordmark></p-wordmark>
    <h1 class="prose-heading-4xl">Welcome</h1>
    <p-text size="md">Vanilla JS + Porsche Design System v4.</p-text>
    <p-button id="cta">Get started</p-button>
  </main>
`;

// Native event listener on the web components
document.querySelector('#cta')!.addEventListener('click', () => {
  alert('Hello!');
});
```

### 7. Wait for components to be ready (optional)

If you want to interact programmatically with PDS components (e.g. read/set props, add listeners), wait for initialization with `componentsReady()`:

```ts
import { componentsReady } from '@porsche-design-system/components-js';

async function init() {
  await componentsReady();
  // Now all p-* components in the DOM are initialized
  const button = document.querySelector('p-button');
  button?.addEventListener('click', () => console.log('Clicked'));
}

init();
```

---

## Pure HTML (no bundler) — via CDN

For a static page or legacy project, you can include PDS directly from the Porsche CDN without npm. It is useful for **rapid prototypes, one-shot pages, WordPress embeds, or when you do not control the build**.

### v4 — inline CDN

```html
<!doctype html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>My Page</title>

    <!-- Porsche Next font (preload) -->
    <link rel="preload" href="https://cdn.ui.porsche.com/porsche-design-system/fonts/porsche-next-latin-regular.woff2" as="font" type="font/woff2" crossorigin>
    <link rel="preload" href="https://cdn.ui.porsche.com/porsche-design-system/fonts/porsche-next-latin-semi-bold.woff2" as="font" type="font/woff2" crossorigin>

    <!-- Global PDS stylesheet (colors, font-face, normalize) -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@porsche-design-system/components-js@4/index.css">

    <style>
      /* FOUC prevention */
      :not(:defined) { visibility: hidden; }
    </style>
  </head>
  <body class="scheme-light-dark">
    <main style="padding: 2rem; display: grid; justify-items: center; gap: 1rem;">
      <p-wordmark></p-wordmark>
      <p-heading size="4xl" tag="h1">Hello Porsche</p-heading>
      <p-text size="md">Static HTML page with PDS via CDN.</p-text>
      <p-button>Get started</p-button>
    </main>

    <!-- Loader script: registers the custom elements and downloads the core chunk from the CDN -->
    <script>
      var porscheDesignSystem;
      (function() {
        var script = document.createElement('script');
        script.src = 'https://cdn.ui.porsche.com/porsche-design-system/components/porsche-design-system.v4.x.x.js';
        script.crossOrigin = '';
        document.body.appendChild(script);
      })();
    </script>
  </body>
</html>
```

**Critical note on the CDN loader**: the exact path of the loader script changes with every minor/patch release (`porsche-design-system.v4.0.1.2455cdfb4dfcc42e5299.js` etc.). The recommended way is to use the `getLoaderScript()` partial that generates it dynamically based on the version installed via npm. If you cannot use npm, **grab the updated loader script from the official documentation page** `https://designsystem.porsche.com/v4/partials/loader-script/` (copy-paste the auto-generated snippet) or from the sample `https://github.com/porsche-design-system/porsche-design-system/tree/main/packages/components-js/projects/sample`.

### v3 — inline CDN

Same pattern but:
- The global PDS stylesheet **does not exist in v3** (the `@porsche-design-system/components-js` import with global styles is a v4 feature). In v3 you must use the JS partials.
- The loader script points to `porsche-design-system.v3.x.x.js`.
- Theming uses the `theme="auto"` attribute on components, not `class="scheme-light-dark"` on the body.

For v3 without a bundler, the manual setup is much more complex and you should use Vite instead (steps 1-7 above with the v3 differences documented in `v3-vs-v4.md`).

---

## Pure Astro (without React/Vue islands)

If you use Astro as a pure static site generator, without client-side frameworks, follow **`setup-astro.md`** but skip the steps related to React/Vue islands. The package to use is always `@porsche-design-system/components-js`.

The advantage of Astro vs Vanilla+Vite: you get **multi-page routing and Astro templating** for free, and the CSS/JS stays minimal because Astro by default does not include React/Vue in the final bundle.

---

## WordPress / Webflow / CMS with custom HTML head

To integrate PDS in a CMS that lets you insert `<script>` and `<link>` in the head but you do not control the build:

### v4 via CDN in WordPress (through header.php or the "Insert Headers and Footers" plugin)

In the WordPress theme header, add before `</head>`:

```html
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@porsche-design-system/components-js@4/index.css">
<style>:not(:defined) { visibility: hidden; }</style>
```

Add a class to the body via the `body_class` filter in `functions.php`:

```php
add_filter('body_class', function($classes) {
    $classes[] = 'scheme-light-dark';
    return $classes;
});
```

Before `</body>` (via footer.php or a plugin), add the loader script copied from `https://designsystem.porsche.com/v4/partials/loader-script/`.

Then in posts, pages, widgets, Gutenberg blocks you can directly use `<p-button>`, `<p-heading>`, etc. in any HTML editor.

### CMS limitations

- **No type safety** on component props — you have to remember the correct values from memory or consult `components-catalog.md`.
- **No tree-shaking** — you download all PDS chunks from the CDN.
- **Worse performance** compared to a Vite bundle — components load at runtime on-demand.
- **No SSR** — components are client-side only. Use CSS `visibility: hidden` to hide the initial flash.
- **Font loaded from the Porsche CDN** — verify that your site's CSP allows `cdn.ui.porsche.com`.

---

## Vanilla troubleshooting

**`p-button` renders as raw HTML** → the loader script was not loaded or errored out. Open DevTools Network tab, look for requests to `cdn.ui.porsche.com/porsche-design-system/components/` and verify they return 200.

**No styles applied** ("naked" components) → in v4 the `@porsche-design-system/components-js` CSS import is missing or the file is not linked in the HTML. In v3, `getInitialStyles()` is missing from the head.

**TypeScript complains about unknown `<p-button>` in template strings** → TS does not know about custom elements by default. Create `src/pds-jsx.d.ts`:

```ts
import type { JSX } from '@porsche-design-system/components-js/jsx-runtime';

declare global {
  namespace JSX {
    interface IntrinsicElements extends JSX.IntrinsicElements {}
  }
}
```

Or more simply, declare module-wide in `tsconfig.json` with `"skipLibCheck": true` and use `as any` for the rare problematic cases.

**The loader script requires two requests** → normal. The loader is a small bootstrap (~5kb) that then loads the core chunk (~30kb) and finally the chunks of individual components on-demand. To reduce the number of requests, use `getComponentChunkLinks({ components: ['button', 'heading', 'text'] })` for specific preloading.

**CSP (Content Security Policy) blocks loading** → you must allow these origins in the CSP:
```
script-src 'self' 'unsafe-inline' https://cdn.ui.porsche.com;
style-src 'self' 'unsafe-inline' https://cdn.ui.porsche.com;
font-src 'self' https://cdn.ui.porsche.com;
img-src 'self' data: https://cdn.ui.porsche.com;
connect-src 'self' https://cdn.ui.porsche.com;
```

If you want to avoid `'unsafe-inline'` for scripts, use the `getLoaderScript({ format: 'sha256' })` partial that returns the SHA-256 hash to insert in the CSP.
