# Setup: React Router (v7, with SSR) + Porsche Design System

React Router v7 (formerly Remix) uses the PDS SSR sub-package, similar to Next.js. It requires `process.browser` configuration in `vite.config.ts` to distinguish server and client bundles.

## Stack dependencies

**v3**: `@react-router/dev @react-router/node react@19 tailwindcss@4 @porsche-design-system/components-react@3`
**v4**: same stack but `components-react@4` + lightningcss fix

## v4 — Complete setup

### 1. Create the project

```bash
npx create-react-router@latest
# ✔ Where should we create your new project? "./my-app"
# ✔ Initialize a new git repository? "Yes"
# ✔ Install dependencies with npm? "Yes"

cd my-app
```

### 2. Install PDS and Tailwind

```bash
npm install @porsche-design-system/components-react
npm install tailwindcss @tailwindcss/vite
```

### 3. Configure `vite.config.ts`

```ts
// vite.config.ts
import { reactRouter } from '@react-router/dev/vite';
import tailwindcss from '@tailwindcss/vite';
import { defineConfig } from 'vite';
import tsconfigPaths from 'vite-tsconfig-paths';
import { Features } from 'lightningcss';

export default defineConfig(({ isSsrBuild }) => ({
  define: {
    // Required for the PDS /ssr sub-package
    'process.browser': JSON.stringify(!isSsrBuild),
  },
  plugins: [tailwindcss(), reactRouter(), tsconfigPaths()],
  css: {
    transformer: 'lightningcss',
    lightningcss: {
      // Fix lightningcss bug with light-dark()
      exclude: Features.LightDark,
    },
  },
}));
```

### 4. Set up the global CSS

```css
/* app/app.css */
@import '@porsche-design-system/components-react';
@import 'tailwindcss';
@import '@porsche-design-system/components-react/tailwindcss';

/* FOUC prevention for SSR */
:not(:defined,[data-ssr]) {
  visibility: hidden;
}
```

### 5. Configure `app/root.tsx` with Provider and partials

```tsx
// app/root.tsx
import {
  Links,
  Meta,
  Outlet,
  Scripts,
  ScrollRestoration,
  useRouteLoaderData,
} from 'react-router';
import { PorscheDesignSystemProvider } from '@porsche-design-system/components-react/ssr';
import {
  getComponentChunkLinks,
  getFontLinks,
  getIconLinks,
  getMetaTagsAndIconLinks,
} from '@porsche-design-system/components-react/partials';
import './app.css';

export async function loader() {
  return {
    headPartials: (
      <>
        {getFontLinks({ format: 'jsx' })}
        {getComponentChunkLinks({ format: 'jsx' })}
        {getIconLinks({ format: 'jsx' })}
        {getMetaTagsAndIconLinks({ appTitle: 'My App', format: 'jsx' })}
      </>
    ),
  };
}

export function Layout({ children }: { children: React.ReactNode }) {
  const data = useRouteLoaderData<typeof loader>('root');
  return (
    <html lang="en">
      <head>
        <meta charSet="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <Meta />
        <Links />
        {data?.headPartials}
      </head>
      <body className="scheme-light-dark">
        {children}
        <ScrollRestoration />
        <Scripts />
      </body>
    </html>
  );
}

export default function App() {
  return (
    <PorscheDesignSystemProvider>
      <Outlet />
    </PorscheDesignSystemProvider>
  );
}
```

### 6. Use the components in routes (ALWAYS /ssr)

```tsx
// app/routes/home.tsx
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
        React Router 7 + PDS v4
      </PHeading>
      <PText size="md">Server-side rendered with Declarative Shadow DOM.</PText>
      <PButton>Get started</PButton>
    </main>
  );
}
```

---

## v3 — Complete setup

The v3 setup is similar but with additional partials (`getInitialStyles`, `getFontFaceStyles`) and the theme on the Provider.

### 1-2. Project and install

```bash
npx create-react-router@latest my-app
cd my-app
npm install @porsche-design-system/components-react
npm install tailwindcss @tailwindcss/vite
```

### 3. `vite.config.ts` v3 (without lightningcss fix)

```ts
// vite.config.ts
import { reactRouter } from '@react-router/dev/vite';
import tailwindcss from '@tailwindcss/vite';
import { defineConfig } from 'vite';
import tsconfigPaths from 'vite-tsconfig-paths';

export default defineConfig(({ isSsrBuild }) => ({
  define: {
    'process.browser': JSON.stringify(!isSsrBuild),
  },
  plugins: [tailwindcss(), reactRouter(), tsconfigPaths()],
}));
```

### 4. v3 CSS

```css
/* app/app.css */
@import 'tailwindcss';
@import '@porsche-design-system/components-react/tailwindcss';
```

### 5. `app/root.tsx` v3

```tsx
// app/root.tsx
import {
  Links,
  Meta,
  Outlet,
  Scripts,
  ScrollRestoration,
  useRouteLoaderData,
} from 'react-router';
import { PorscheDesignSystemProvider } from '@porsche-design-system/components-react/ssr';
import {
  getComponentChunkLinks,
  getFontFaceStyles,
  getFontLinks,
  getIconLinks,
  getInitialStyles,
  getMetaTagsAndIconLinks,
} from '@porsche-design-system/components-react/partials';
import './app.css';

export async function loader() {
  return {
    headPartials: (
      <>
        {/* v3: getInitialStyles REQUIRED */}
        {getInitialStyles({ format: 'jsx' })}
        {getFontFaceStyles({ format: 'jsx' })}
        {getFontLinks({ format: 'jsx' })}
        {getComponentChunkLinks({ format: 'jsx' })}
        {getIconLinks({ format: 'jsx' })}
        {getMetaTagsAndIconLinks({ appTitle: 'My App', format: 'jsx' })}
      </>
    ),
  };
}

export function Layout({ children }: { children: React.ReactNode }) {
  const data = useRouteLoaderData<typeof loader>('root');
  return (
    <html lang="en">
      <head>
        <meta charSet="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <Meta />
        <Links />
        {data?.headPartials}
      </head>
      <body>
        {children}
        <ScrollRestoration />
        <Scripts />
      </body>
    </html>
  );
}

export default function App() {
  return (
    <PorscheDesignSystemProvider theme="auto">
      <Outlet />
    </PorscheDesignSystemProvider>
  );
}
```

## React Router troubleshooting

**Error "process is not defined"** → the `define` in `vite.config.ts` is missing. The `/ssr` sub-package checks `process.browser` at runtime to distinguish server and client; without the define, the variable is not substituted at build time.

**Dead code not eliminated → server code ends up in the client bundle** → make sure the production build has tree-shaking enabled (default in Vite production build) and that the define is EXACTLY `JSON.stringify(!isSsrBuild)` — not `!isSsrBuild` alone, the stringification is required.

**Hydration error on PButton and other components** → all imports must be from `/ssr`. Search the codebase:
```bash
grep -rn "from '@porsche-design-system/components-react'" app/
```
If you find any import without `/ssr`, fix it.

**The partial loader returns strings instead of JSX in root.tsx** → use `format: 'jsx'` in the partials. Without that parameter they return an HTML string that React does not render correctly as an element.

**TypeScript error on `useRouteLoaderData<typeof loader>('root')`** → make sure `loader` is exported as a named export and that the return type has `headPartials: ReactElement`. React Router generates types from the route file.
