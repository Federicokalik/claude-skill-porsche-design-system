# Layout Patterns

Complete, ready-to-adapt layout patterns for common page types. Each pattern includes the full React v4 structure and notes on the parts that typically need to be customized.

For official patterns (Header, Footer, Forms, Notifications, AI Tag) PDS has a dedicated section at `https://designsystem.porsche.com/v4/patterns/` that uses Tailwind CSS with the PDS theme — these examples are inspired by that format.

## 1. Hero section

Classic hero with a large heading, subtitle, and two CTAs. Fluid spacing to adapt from mobile to desktop.

```tsx
import { PButton, PHeading, PText } from '@porsche-design-system/components-react';

export default function Hero() {
  return (
    <section className="relative min-h-[90vh] flex items-center justify-center p-fluid-2xl bg-canvas">
      {/* Background image/video */}
      <img
        src="/hero-bg.jpg"
        alt=""
        className="absolute inset-0 w-full h-full object-cover -z-10"
      />
      {/* Overlay gradient for legibility */}
      <div className="absolute inset-0 bg-gradient-to-t from-backdrop to-transparent -z-10" />

      {/* Content */}
      <div className="max-w-4xl flex flex-col items-center text-center gap-fluid-md scheme-dark">
        <PText size="sm" className="uppercase tracking-wide">
          New collection
        </PText>
        <PHeading size="5xl" tag="h1">
          The iconic silhouette,
          <br />
          reinvented.
        </PHeading>
        <PText size="xl" className="max-w-2xl">
          Timeless design meets the technology of the future. Discover the new generation.
        </PText>
        <div className="flex flex-wrap gap-static-md justify-center pt-fluid-sm">
          <PButton>Discover more</PButton>
          <PButton variant="secondary">Request a quote</PButton>
        </div>
      </div>
    </section>
  );
}
```

**Typical customizations**:
- Change `min-h-[90vh]` to `min-h-screen` for a fullscreen hero, or `min-h-[60vh]` for a shorter hero.
- Remove the `scheme-dark` if the background is light.
- For a hero without a background image, use `bg-surface` and remove the `<img>` wrapper + overlay.

---

## 2. Card grid showcase

Responsive grid of cards with heading + description + CTA. PDS breakpoints: 1 col mobile, 2 col tablet, 3 col desktop.

```tsx
import { PButton, PHeading, PText } from '@porsche-design-system/components-react';

type Product = {
  id: string;
  title: string;
  description: string;
  image: string;
  href: string;
};

export default function ProductGrid({ products }: { products: Product[] }) {
  return (
    <section className="py-fluid-2xl px-fluid-md bg-canvas">
      <div className="max-w-7xl mx-auto flex flex-col gap-fluid-lg">
        <header className="flex flex-col gap-fluid-sm text-center">
          <PHeading size="3xl" tag="h2">Our models</PHeading>
          <PText size="lg" color="contrast-medium" className="max-w-2xl mx-auto">
            A car for every driving style.
          </PText>
        </header>

        <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-fluid-md">
          {products.map((p) => (
            <article
              key={p.id}
              className="flex flex-col gap-fluid-sm p-fluid-md bg-surface rounded-lg hover:shadow-lg transition-shadow"
            >
              <img
                src={p.image}
                alt={p.title}
                className="w-full aspect-[4/3] object-cover rounded-md"
              />
              <PHeading size="lg" tag="h3">{p.title}</PHeading>
              <PText size="sm" color="contrast-high" className="flex-1">
                {p.description}
              </PText>
              <div className="pt-static-sm">
                <PButton href={p.href} variant="secondary">
                  Discover
                </PButton>
              </div>
            </article>
          ))}
        </div>
      </div>
    </section>
  );
}
```

**Notes**: if you want the whole card to be clickable (not just the button), replace `<article>` with `<PLinkTile href={p.href}>`, which is PDS's dedicated component. The version above uses a normal div for more layout control.

---

## 3. Two-column feature section

Classic 50/50 layout with image on the left and content on the right (reversible).

```tsx
import { PButton, PHeading, PText } from '@porsche-design-system/components-react';

export default function FeatureSection({ reverse = false }: { reverse?: boolean }) {
  return (
    <section className="py-fluid-2xl px-fluid-md">
      <div
        className={`max-w-7xl mx-auto grid grid-cols-1 lg:grid-cols-2 gap-fluid-xl items-center ${
          reverse ? 'lg:[&>*:first-child]:order-2' : ''
        }`}
      >
        <div className="aspect-[4/3] rounded-lg overflow-hidden">
          <img src="/feature.jpg" alt="" className="w-full h-full object-cover" />
        </div>

        <div className="flex flex-col gap-fluid-md">
          <PText size="sm" color="contrast-medium" className="uppercase tracking-wide">
            Technology
          </PText>
          <PHeading size="2xl" tag="h2">
            Performance without compromise
          </PHeading>
          <PText size="md">
            An engine optimized for efficiency and power delivery. Tested on the track, perfected
            for the road.
          </PText>
          <ul className="flex flex-col gap-static-sm pt-static-sm">
            <li className="flex items-start gap-static-sm">
              <PIcon name="check" color="success" className="mt-1" />
              <PText size="sm">0-100 km/h in 2.8 seconds</PText>
            </li>
            <li className="flex items-start gap-static-sm">
              <PIcon name="check" color="success" className="mt-1" />
              <PText size="sm">Top speed 330 km/h</PText>
            </li>
            <li className="flex items-start gap-static-sm">
              <PIcon name="check" color="success" className="mt-1" />
              <PText size="sm">Combined consumption 10.8 l/100km</PText>
            </li>
          </ul>
          <div className="pt-fluid-sm">
            <PButton>Discover the specs</PButton>
          </div>
        </div>
      </div>
    </section>
  );
}
```

---

## 4. Header / Navigation bar

Responsive header with logo on the left, nav links in the center, CTA on the right. Includes mobile toggle with PFlyout.

```tsx
'use client';

import {
  PButton,
  PFlyout,
  PLinkPure,
  PWordmark,
} from '@porsche-design-system/components-react';
import { useState } from 'react';

const navItems = [
  { label: 'Models', href: '/models' },
  { label: 'Technology', href: '/technology' },
  { label: 'Experience', href: '/experience' },
  { label: 'Contact', href: '/contact' },
];

export default function Header() {
  const [menuOpen, setMenuOpen] = useState(false);

  return (
    <header className="sticky top-0 z-50 bg-canvas/80 backdrop-blur-md border-b border-contrast-low">
      <div className="max-w-7xl mx-auto flex items-center justify-between px-fluid-md py-static-md">
        {/* Logo */}
        <a href="/" aria-label="Home">
          <PWordmark size="small" />
        </a>

        {/* Desktop nav */}
        <nav className="hidden lg:flex items-center gap-fluid-md">
          {navItems.map((item) => (
            <PLinkPure key={item.href} href={item.href}>
              {item.label}
            </PLinkPure>
          ))}
        </nav>

        {/* Desktop CTA */}
        <div className="hidden lg:flex items-center gap-static-md">
          <PButton variant="secondary" href="/account">
            My account
          </PButton>
          <PButton href="/configurator">
            Configure
          </PButton>
        </div>

        {/* Mobile toggle */}
        <PButton
          className="lg:hidden"
          icon="menu-lines"
          hideLabel
          variant="secondary"
          onClick={() => setMenuOpen(true)}
        >
          Menu
        </PButton>
      </div>

      {/* Mobile menu */}
      <PFlyout
        open={menuOpen}
        onDismiss={() => setMenuOpen(false)}
        position="end"
      >
        <nav className="flex flex-col gap-fluid-sm">
          {navItems.map((item) => (
            <PLinkPure key={item.href} href={item.href} size="lg">
              {item.label}
            </PLinkPure>
          ))}
          <div className="flex flex-col gap-static-md pt-fluid-md border-t border-contrast-low">
            <PButton variant="secondary" href="/account">My account</PButton>
            <PButton href="/configurator">Configure</PButton>
          </div>
        </nav>
      </PFlyout>
    </header>
  );
}
```

**Notes**:
- `<PWordmark>` should only be used for Porsche projects. For other contexts, replace it with a custom logo (e.g. `<img src="/logo.svg" alt="Brand" className="h-8" />`).
- The blur + opacity (`bg-canvas/80 backdrop-blur-md`) creates the frosted glass effect typical of Porsche.
- For the mobile toggle use `icon="menu-lines"` (not `menu`, which does not exist).

---

## 5. Footer

Multi-column footer with link groups and disclaimer.

```tsx
import { PLinkPure, PText, PWordmark } from '@porsche-design-system/components-react';

export default function Footer() {
  return (
    <footer className="bg-surface">
      <div className="max-w-7xl mx-auto px-fluid-md py-fluid-xl">
        <div className="grid grid-cols-2 md:grid-cols-4 gap-fluid-lg mb-fluid-xl">
          {/* Column 1 */}
          <div className="flex flex-col gap-fluid-sm">
            <PText size="xs" weight="semibold" className="uppercase tracking-wide">Models</PText>
            <ul className="flex flex-col gap-static-sm">
              <li><PLinkPure href="/911" size="sm">911</PLinkPure></li>
              <li><PLinkPure href="/taycan" size="sm">Taycan</PLinkPure></li>
              <li><PLinkPure href="/cayenne" size="sm">Cayenne</PLinkPure></li>
              <li><PLinkPure href="/macan" size="sm">Macan</PLinkPure></li>
            </ul>
          </div>

          {/* Column 2 */}
          <div className="flex flex-col gap-fluid-sm">
            <PText size="xs" weight="semibold" className="uppercase tracking-wide">Services</PText>
            <ul className="flex flex-col gap-static-sm">
              <li><PLinkPure href="/financing" size="sm">Financing</PLinkPure></li>
              <li><PLinkPure href="/insurance" size="sm">Insurance</PLinkPure></li>
              <li><PLinkPure href="/warranty" size="sm">Warranty</PLinkPure></li>
              <li><PLinkPure href="/support" size="sm">Support</PLinkPure></li>
            </ul>
          </div>

          {/* Column 3 */}
          <div className="flex flex-col gap-fluid-sm">
            <PText size="xs" weight="semibold" className="uppercase tracking-wide">Company</PText>
            <ul className="flex flex-col gap-static-sm">
              <li><PLinkPure href="/about" size="sm">About us</PLinkPure></li>
              <li><PLinkPure href="/careers" size="sm">Careers</PLinkPure></li>
              <li><PLinkPure href="/news" size="sm">News</PLinkPure></li>
              <li><PLinkPure href="/contact" size="sm">Contact</PLinkPure></li>
            </ul>
          </div>

          {/* Column 4 */}
          <div className="flex flex-col gap-fluid-sm">
            <PText size="xs" weight="semibold" className="uppercase tracking-wide">Follow us</PText>
            <ul className="flex flex-col gap-static-sm">
              <li><PLinkPure href="https://facebook.com/..." icon="logo-facebook" target="_blank" size="sm">Facebook</PLinkPure></li>
              <li><PLinkPure href="https://instagram.com/..." icon="logo-instagram" target="_blank" size="sm">Instagram</PLinkPure></li>
              <li><PLinkPure href="https://youtube.com/..." icon="logo-youtube" target="_blank" size="sm">YouTube</PLinkPure></li>
              <li><PLinkPure href="https://linkedin.com/..." icon="logo-linkedin" target="_blank" size="sm">LinkedIn</PLinkPure></li>
            </ul>
          </div>
        </div>

        <div className="border-t border-contrast-low pt-fluid-md flex flex-col md:flex-row items-start md:items-center justify-between gap-fluid-sm">
          <PWordmark size="small" />
          <div className="flex flex-wrap gap-fluid-sm">
            <PLinkPure href="/privacy" size="xs">Privacy</PLinkPure>
            <PLinkPure href="/terms" size="xs">Terms of use</PLinkPure>
            <PLinkPure href="/cookie" size="xs">Cookie</PLinkPure>
            <PLinkPure href="/legal" size="xs">Legal notes</PLinkPure>
          </div>
          <PText size="2xs" color="contrast-medium">
            © 2026 All rights reserved
          </PText>
        </div>
      </div>
    </footer>
  );
}
```

---

## 6. Complete contact form (2 columns)

Contact form with company info on the left and fields on the right.

```tsx
'use client';

import {
  PButton,
  PCheckbox,
  PFieldset,
  PHeading,
  PIcon,
  PInputEmail,
  PInputTel,
  PInputText,
  PSelect,
  PSelectOption,
  PText,
  PTextarea,
} from '@porsche-design-system/components-react';
import { FormEvent, useState } from 'react';

export default function ContactPage() {
  const [submitting, setSubmitting] = useState(false);

  async function handleSubmit(e: FormEvent<HTMLFormElement>) {
    e.preventDefault();
    setSubmitting(true);
    // ... submit logic
    setSubmitting(false);
  }

  return (
    <section className="py-fluid-2xl px-fluid-md bg-canvas">
      <div className="max-w-6xl mx-auto grid grid-cols-1 lg:grid-cols-2 gap-fluid-xl">
        {/* Info column */}
        <div className="flex flex-col gap-fluid-md">
          <PHeading size="3xl" tag="h1">Contact us</PHeading>
          <PText size="lg" color="contrast-high">
            We are here to answer your questions. Fill out the form and we will get back to you within 24 hours.
          </PText>

          <div className="flex flex-col gap-fluid-sm pt-fluid-md">
            <div className="flex items-start gap-static-md">
              <PIcon name="map" size="md" color="primary" />
              <div className="flex flex-col gap-static-2xs">
                <PText size="sm" weight="semibold">Headquarters</PText>
                <PText size="sm" color="contrast-medium">
                  Via Roma 1<br />
                  00100 Rome, Italy
                </PText>
              </div>
            </div>

            <div className="flex items-start gap-static-md">
              <PIcon name="phone" size="md" color="primary" />
              <div className="flex flex-col gap-static-2xs">
                <PText size="sm" weight="semibold">Phone</PText>
                <PText size="sm" color="contrast-medium">+39 06 1234 5678</PText>
              </div>
            </div>

            <div className="flex items-start gap-static-md">
              <PIcon name="mail" size="md" color="primary" />
              <div className="flex flex-col gap-static-2xs">
                <PText size="sm" weight="semibold">Email</PText>
                <PText size="sm" color="contrast-medium">info@example.com</PText>
              </div>
            </div>
          </div>
        </div>

        {/* Form column */}
        <form onSubmit={handleSubmit} className="flex flex-col gap-fluid-md p-fluid-md bg-surface rounded-lg">
          <PFieldset label="Your details">
            <div className="flex flex-col gap-fluid-sm">
              <div className="grid grid-cols-1 sm:grid-cols-2 gap-fluid-sm">
                <PInputText label="First name" name="firstName" required />
                <PInputText label="Last name" name="lastName" required />
              </div>
              <PInputEmail label="Email" name="email" required />
              <PInputTel label="Phone" name="phone" />
            </div>
          </PFieldset>

          <PFieldset label="Your request">
            <div className="flex flex-col gap-fluid-sm">
              <PSelect label="Subject" name="subject" required>
                <PSelectOption value="">Select...</PSelectOption>
                <PSelectOption value="info">General information</PSelectOption>
                <PSelectOption value="quote">Quote request</PSelectOption>
                <PSelectOption value="support">Technical support</PSelectOption>
                <PSelectOption value="other">Other</PSelectOption>
              </PSelect>

              <PTextarea
                label="Message"
                name="message"
                rows={6}
                description="Tell us what you need"
                required
              />
            </div>
          </PFieldset>

          <PCheckbox
            label="I accept the processing of personal data as per the privacy policy"
            name="privacy"
            required
          />

          <div className="flex gap-static-md pt-static-sm">
            <PButton type="submit" loading={submitting}>Send request</PButton>
            <PButton type="reset" variant="secondary">Reset</PButton>
          </div>
        </form>
      </div>
    </section>
  );
}
```

---

## 7. Pricing table

Three plans side-by-side with a featured middle one.

```tsx
import { PButton, PHeading, PIcon, PText } from '@porsche-design-system/components-react';

const plans = [
  {
    name: 'Base',
    price: '€ 79,900',
    features: ['3.0L engine', 'Fabric interior', '19" wheels', '2-year support'],
    featured: false,
  },
  {
    name: 'Sport',
    price: '€ 99,900',
    features: ['3.8L turbo engine', 'Leather interior', '20" wheels', 'Sport Chrono', '3-year support'],
    featured: true,
  },
  {
    name: 'Turbo S',
    price: '€ 149,900',
    features: ['3.8L biturbo engine', 'Full leather interior', '21" wheels', 'Sport Chrono Plus', 'PDCC', '5-year support'],
    featured: false,
  },
];

export default function PricingTable() {
  return (
    <section className="py-fluid-2xl px-fluid-md bg-canvas">
      <div className="max-w-6xl mx-auto flex flex-col gap-fluid-lg">
        <header className="text-center flex flex-col gap-fluid-sm">
          <PHeading size="3xl" tag="h2">Choose your configuration</PHeading>
          <PText size="lg" color="contrast-medium">
            Three trim levels for every need
          </PText>
        </header>

        <div className="grid grid-cols-1 md:grid-cols-3 gap-fluid-md">
          {plans.map((plan) => (
            <article
              key={plan.name}
              className={`flex flex-col gap-fluid-md p-fluid-lg rounded-lg ${
                plan.featured
                  ? 'bg-surface border-2 border-primary scheme-dark'
                  : 'bg-surface'
              }`}
            >
              {plan.featured && (
                <PText size="xs" color="primary" className="uppercase tracking-wide">
                  Most popular
                </PText>
              )}
              <PHeading size="xl" tag="h3">{plan.name}</PHeading>
              <PText size="3xl" weight="semibold" className="prose-heading-3xl">
                {plan.price}
              </PText>
              <ul className="flex flex-col gap-static-sm flex-1">
                {plan.features.map((feature) => (
                  <li key={feature} className="flex items-start gap-static-sm">
                    <PIcon name="check" color="success" className="mt-1 shrink-0" />
                    <PText size="sm">{feature}</PText>
                  </li>
                ))}
              </ul>
              <PButton variant={plan.featured ? 'primary' : 'secondary'}>
                Configure {plan.name}
              </PButton>
            </article>
          ))}
        </div>
      </div>
    </section>
  );
}
```

---

## 8. Dashboard layout (sidebar + main content)

Typical SaaS layout with sticky sidebar and scrollable main area.

```tsx
import { PButton, PHeading, PIcon, PLinkPure, PText, PWordmark } from '@porsche-design-system/components-react';

export default function DashboardLayout({ children }: { children: React.ReactNode }) {
  return (
    <div className="min-h-screen flex bg-canvas">
      {/* Sidebar */}
      <aside className="hidden lg:flex lg:w-64 flex-col bg-surface border-r border-contrast-low">
        <div className="p-fluid-md border-b border-contrast-low">
          <PWordmark size="small" />
        </div>
        <nav className="flex-1 p-fluid-sm">
          <ul className="flex flex-col gap-static-xs">
            {[
              { label: 'Dashboard', icon: 'home', href: '/dashboard' },
              { label: 'Orders', icon: 'list', href: '/dashboard/orders' },
              { label: 'Customers', icon: 'user', href: '/dashboard/customers' },
              { label: 'Analytics', icon: 'chart', href: '/dashboard/analytics' },
              { label: 'Settings', icon: 'configurate', href: '/dashboard/settings' },
            ].map((item) => (
              <li key={item.href}>
                <a
                  href={item.href}
                  className="flex items-center gap-static-sm p-static-md rounded-md hover:bg-frosted-soft transition-colors"
                >
                  <PIcon name={item.icon} size="sm" />
                  <PText size="sm">{item.label}</PText>
                </a>
              </li>
            ))}
          </ul>
        </nav>
        <div className="p-fluid-sm border-t border-contrast-low">
          <PButton variant="secondary" icon="logout" className="w-full">Logout</PButton>
        </div>
      </aside>

      {/* Main content */}
      <main className="flex-1 p-fluid-md max-w-[1400px]">
        {children}
      </main>
    </div>
  );
}
```

---

## 9. Empty state

Pattern for empty pages (no data, search without results, etc.).

```tsx
import { PButton, PHeading, PIcon, PText } from '@porsche-design-system/components-react';

export default function EmptyState() {
  return (
    <div className="flex flex-col items-center justify-center gap-fluid-md p-fluid-2xl text-center">
      <PIcon name="information" size="2xl" color="contrast-low" />
      <PHeading size="lg" tag="h2">No results</PHeading>
      <PText size="sm" color="contrast-medium" className="max-w-md">
        We couldn't find anything with these search criteria. Try changing the filters.
      </PText>
      <div className="flex gap-static-md pt-fluid-sm">
        <PButton variant="secondary">Clear filters</PButton>
        <PButton>New search</PButton>
      </div>
    </div>
  );
}
```

---

## Principles common to all patterns

1. **Fluid spacing between large sections**: `py-fluid-2xl` for hero/showcase sections, `py-fluid-xl` for standard sections.
2. **Max-width container**: `max-w-7xl` (1280px) or `max-w-6xl` (1152px) + `mx-auto` to center + `px-fluid-md` for horizontal padding.
3. **Responsive mobile-first grid**: always start from `grid-cols-1` and add breakpoints (`sm:grid-cols-2`, `lg:grid-cols-3`).
4. **Alternating backgrounds**: alternate `bg-canvas` and `bg-surface` between sections to create visual rhythm.
5. **Heading hierarchy**: H1 only for the page's main title, H2 for sections, H3 for cards/sub-sections.
6. **CTA hierarchy**: max 1 primary button visible at a time in the viewport (does the main action), secondary for alternative actions.
7. **Text limited in width**: `max-w-2xl` for long body text (improves legibility).
8. **Frosted glass effect**: `bg-canvas/80 backdrop-blur-md` for sticky headers, transparent sidebars, overlays.
