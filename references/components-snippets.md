# Component Snippets

Ready-to-paste snippets for the most requested PDS components, in React (v4, importing from `@porsche-design-system/components-react` or `/ssr` for Next.js/React Router) and Vanilla HTML. All snippets use the PDS Tailwind utilities (`gap-fluid-*`, `bg-surface`, `prose-*`, etc.).

For each component you will find:
1. **React v4**
2. **Vanilla HTML** (also usable in Astro)
3. **Notes** on when to use it, variants, common mistakes

## Button (PButton)

### React v4

```tsx
import { PButton } from '@porsche-design-system/components-react';

// Primary CTA (default)
<PButton onClick={() => handleSubmit()}>Submit</PButton>

// Secondary CTA
<PButton variant="secondary">Cancel</PButton>

// With icon
<PButton icon="arrow-right">Discover more</PButton>

// Icon-only (no visible label)
<PButton icon="arrow-right" hideLabel>Navigate</PButton>

// Loading state
<PButton loading>Sending...</PButton>

// Disabled
<PButton disabled>Not available</PButton>

// Critical action (delete, destructive)
<PButton variant="primary" type="button" aria-label="Delete item">
  Delete
</PButton>

// Submit form
<PButton type="submit">Save changes</PButton>
```

### Vanilla HTML

```html
<p-button>Submit</p-button>
<p-button variant="secondary">Cancel</p-button>
<p-button icon="arrow-right">Discover more</p-button>
<p-button icon="arrow-right" hide-label="true">Navigate</p-button>
<p-button loading="true">Sending...</p-button>
<p-button disabled>Not available</p-button>
```

**Notes**: in v4 the values `variant="ghost"` and `variant="tertiary"` have been removed → use `variant="secondary"`. Boolean attributes in Vanilla HTML must be passed as a string (`hide-label="true"`, `loading="true"`).

---

## Heading (PHeading)

### React v4

```tsx
import { PHeading } from '@porsche-design-system/components-react';

// Hero title
<PHeading size="5xl" tag="h1">The new 911</PHeading>

// Page title
<PHeading size="2xl" tag="h1">Dashboard</PHeading>

// Section heading
<PHeading size="xl" tag="h2">Your orders</PHeading>

// Card heading
<PHeading size="lg" tag="h3">Card title</PHeading>

// Small heading (e.g. form section)
<PHeading size="sm" tag="h4">Personal details</PHeading>

// Semibold (override of the default regular)
<PHeading size="xl" tag="h2" weight="semibold">Strong title</PHeading>
```

### Vanilla HTML

```html
<p-heading size="5xl" tag="h1">The new 911</p-heading>
<p-heading size="2xl" tag="h1">Dashboard</p-heading>
<p-heading size="xl" tag="h2">Your orders</p-heading>
<p-heading size="lg" tag="h3">Card title</p-heading>
```

**Notes**: `tag` decides the semantic HTML tag (for SEO/a11y), `size` decides the visual size. They are independent — you can have a small `<h1>` or a giant `<p-heading>` with `tag="h3"`. In v4 use short-form (`sm`, `md`, `lg`, `xl`, `2xl`, `3xl`, `4xl`, `5xl`), not long-form (`small`, `x-large`, etc. are deprecated).

---

## Text (PText)

```tsx
import { PText } from '@porsche-design-system/components-react';

// Body default
<PText size="sm">Normal paragraph text.</PText>

// Emphasized intro
<PText size="lg">Descriptive page subtitle.</PText>

// Caption / metadata
<PText size="xs" color="contrast-medium">Last updated: yesterday</PText>

// Disclaimer
<PText size="2xs" color="contrast-medium">
  This service is subject to terms of use.
</PText>

// Semantic color
<PText color="error">Required field</PText>
<PText color="success">Data saved successfully</PText>
<PText color="warning">Warning: irreversible action</PText>

// Align
<PText align="center">Centered text</PText>
```

```html
<p-text size="sm">Normal paragraph text.</p-text>
<p-text size="xs" color="contrast-medium">Metadata</p-text>
<p-text color="error">Error</p-text>
```

---

## Complete form

### React v4

```tsx
'use client'; // only for Next.js if this is a client component

import {
  PButton,
  PFieldset,
  PInputEmail,
  PInputText,
  PTextarea,
  PCheckbox,
} from '@porsche-design-system/components-react';
import { useState, FormEvent } from 'react';

export default function ContactForm() {
  const [submitting, setSubmitting] = useState(false);

  async function handleSubmit(e: FormEvent) {
    e.preventDefault();
    setSubmitting(true);
    // ... submit logic
    setSubmitting(false);
  }

  return (
    <form onSubmit={handleSubmit} className="flex flex-col gap-fluid-md max-w-xl">
      <PFieldset label="Personal details">
        <div className="flex flex-col gap-fluid-sm">
          <PInputText
            label="First name"
            name="firstName"
            required
          />
          <PInputText
            label="Last name"
            name="lastName"
            required
          />
          <PInputEmail
            label="Email"
            name="email"
            description="We will contact you at this email"
            required
          />
        </div>
      </PFieldset>

      <PFieldset label="Message">
        <PTextarea
          label="Your message"
          name="message"
          rows={5}
          required
        />
      </PFieldset>

      <PCheckbox
        label="I accept the processing of personal data"
        name="privacy"
        required
      />

      <div className="flex gap-static-md pt-fluid-sm">
        <PButton type="submit" loading={submitting}>
          Send message
        </PButton>
        <PButton type="reset" variant="secondary">
          Reset
        </PButton>
      </div>
    </form>
  );
}
```

### Vanilla HTML

```html
<form id="contact-form" class="flex flex-col gap-fluid-md max-w-xl">
  <p-fieldset label="Personal details">
    <div class="flex flex-col gap-fluid-sm">
      <p-input-text label="First name" name="firstName" required></p-input-text>
      <p-input-text label="Last name" name="lastName" required></p-input-text>
      <p-input-email
        label="Email"
        name="email"
        description="We will contact you at this email"
        required
      ></p-input-email>
    </div>
  </p-fieldset>

  <p-fieldset label="Message">
    <p-textarea label="Your message" name="message" rows="5" required></p-textarea>
  </p-fieldset>

  <p-checkbox label="I accept the processing of personal data" name="privacy" required></p-checkbox>

  <div class="flex gap-static-md pt-fluid-sm">
    <p-button type="submit">Send message</p-button>
    <p-button type="reset" variant="secondary">Reset</p-button>
  </div>
</form>

<script>
  document.getElementById('contact-form').addEventListener('submit', async (e) => {
    e.preventDefault();
    const submitButton = e.target.querySelector('p-button[type="submit"]');
    submitButton.setAttribute('loading', 'true');
    // ... submit logic
    submitButton.removeAttribute('loading');
  });
</script>
```

---

## Select and MultiSelect

```tsx
import { PSelect, PSelectOption, PMultiSelect, PMultiSelectOption } from '@porsche-design-system/components-react';

// Single select
<PSelect
  label="Model"
  name="model"
  required
  onChange={(e) => console.log(e.detail.value)}
>
  <PSelectOption value="911">911</PSelectOption>
  <PSelectOption value="taycan">Taycan</PSelectOption>
  <PSelectOption value="cayenne">Cayenne</PSelectOption>
  <PSelectOption value="macan">Macan</PSelectOption>
  <PSelectOption value="panamera">Panamera</PSelectOption>
</PSelect>

// Multi select
<PMultiSelect
  label="Options"
  name="options"
  onChange={(e) => console.log(e.detail.value)} // array of selected values
>
  <PMultiSelectOption value="leather">Leather</PMultiSelectOption>
  <PMultiSelectOption value="sport-chrono">Sport Chrono</PMultiSelectOption>
  <PMultiSelectOption value="pasm">PASM</PMultiSelectOption>
</PMultiSelect>
```

**Notes**: in v3 the event handlers were `onUpdate`. In v4 use `onChange` (event `change`).

---

## Radio Group

```tsx
import { PRadioGroup, PRadioGroupOption } from '@porsche-design-system/components-react';

<PRadioGroup
  label="Fuel"
  name="fuel"
  value="electric"
  onChange={(e) => console.log(e.detail.value)}
>
  <PRadioGroupOption value="petrol">Petrol</PRadioGroupOption>
  <PRadioGroupOption value="diesel">Diesel</PRadioGroupOption>
  <PRadioGroupOption value="hybrid">Hybrid</PRadioGroupOption>
  <PRadioGroupOption value="electric">Electric</PRadioGroupOption>
</PRadioGroup>
```

```html
<p-radio-group label="Fuel" name="fuel" value="electric">
  <p-radio-group-option value="petrol">Petrol</p-radio-group-option>
  <p-radio-group-option value="diesel">Diesel</p-radio-group-option>
  <p-radio-group-option value="hybrid">Hybrid</p-radio-group-option>
  <p-radio-group-option value="electric">Electric</p-radio-group-option>
</p-radio-group>
```

---

## Modal

```tsx
'use client';

import { PModal, PButton, PHeading, PText } from '@porsche-design-system/components-react';
import { useState } from 'react';

export default function ConfirmDialog() {
  const [open, setOpen] = useState(false);

  return (
    <>
      <PButton onClick={() => setOpen(true)}>Open modal</PButton>

      <PModal
        open={open}
        onDismiss={() => setOpen(false)}
        aria={{ 'aria-label': 'Confirm action' }}
      >
        {/* v4: use slot="header" for the title, not the heading prop */}
        <PHeading slot="header" size="lg" tag="h2">
          Confirm deletion
        </PHeading>

        <PText size="sm">
          Are you sure you want to delete this item? This action cannot be undone.
        </PText>

        <div slot="footer" className="flex gap-static-md justify-end">
          <PButton variant="secondary" onClick={() => setOpen(false)}>
            Cancel
          </PButton>
          <PButton onClick={() => { handleDelete(); setOpen(false); }}>
            Delete
          </PButton>
        </div>
      </PModal>
    </>
  );
}
```

```html
<p-button id="open-modal">Open modal</p-button>

<p-modal id="my-modal">
  <p-heading slot="header" size="lg" tag="h2">Confirm deletion</p-heading>
  <p-text size="sm">Are you sure you want to delete this item?</p-text>
  <div slot="footer" class="flex gap-static-md justify-end">
    <p-button variant="secondary" id="cancel">Cancel</p-button>
    <p-button id="confirm">Delete</p-button>
  </div>
</p-modal>

<script>
  const modal = document.getElementById('my-modal');
  document.getElementById('open-modal').addEventListener('click', () => {
    modal.setAttribute('open', 'true');
  });
  document.getElementById('cancel').addEventListener('click', () => {
    modal.removeAttribute('open');
  });
  modal.addEventListener('dismiss', () => {
    modal.removeAttribute('open');
  });
</script>
```

**v4 notes**: event `dismiss` (was `close` in v3). Prop `heading` and slot `heading` **removed** in v4, use slot `header` with `<PHeading>` inside.

---

## Accordion

```tsx
import { PAccordion, PText, PHeading } from '@porsche-design-system/components-react';

// v4: use slot="summary" for custom title
<PAccordion>
  <PHeading slot="summary" tag="h3" size="sm">Frequently asked question 1</PHeading>
  <PText size="sm">Answer to the first question. It can contain long text.</PText>
</PAccordion>

<PAccordion open>
  <PHeading slot="summary" tag="h3" size="sm">Already open question</PHeading>
  <PText size="sm">This FAQ is open by default thanks to the `open` prop.</PText>
</PAccordion>
```

```html
<p-accordion>
  <p-heading slot="summary" tag="h3" size="sm">Frequently asked question 1</p-heading>
  <p-text size="sm">Answer to the first question.</p-text>
</p-accordion>
```

**Notes**: in v4 the `heading` prop and the `heading` slot are **deprecated** in favor of `slot="summary"` with a `<PHeading>` inside. This provides more typographic flexibility.

---

## Banner / InlineNotification / Toast

```tsx
import { PBanner, PInlineNotification, PText } from '@porsche-design-system/components-react';

// Full-width banner (e.g. at the top of the page)
<PBanner state="info" dismissButton>
  <PHeading slot="heading" tag="h2" size="sm">Important info</PHeading>
  <PText slot="description">
    We have updated the terms of service. Read the changelog.
  </PText>
</PBanner>

// Inline notification (inside a section)
<PInlineNotification state="success" dismissButton>
  <PHeading slot="heading" tag="h3" size="sm">Saved</PHeading>
  <PText slot="description">
    Your changes have been saved successfully.
  </PText>
</PInlineNotification>

// State: info | success | warning | error (in v3 "neutral" was used instead of "info")
<PInlineNotification state="error">
  <PHeading slot="heading" tag="h3" size="sm">Error</PHeading>
  <PText slot="description">Unable to complete the operation. Try again.</PText>
</PInlineNotification>
```

### Toast

```tsx
import { PToast, toastManager } from '@porsche-design-system/components-react';

// The toast manager must be initialized once (e.g. at the root of your app)
// Then you can call addMessage from anywhere:

function handleSave() {
  toastManager.addMessage({
    text: 'Changes saved',
    state: 'success',
  });
}

// In your layout/root you must have the <PToast /> component
<PToast />
```

---

## Table

```tsx
import {
  PTable,
  PTableHead,
  PTableHeadRow,
  PTableHeadCell,
  PTableBody,
  PTableRow,
  PTableCell,
} from '@porsche-design-system/components-react';

<PTable caption="Recent orders">
  <PTableHead>
    <PTableHeadRow>
      <PTableHeadCell>ID</PTableHeadCell>
      <PTableHeadCell>Customer</PTableHeadCell>
      <PTableHeadCell>Date</PTableHeadCell>
      <PTableHeadCell align="end">Total</PTableHeadCell>
      <PTableHeadCell>Status</PTableHeadCell>
    </PTableHeadRow>
  </PTableHead>
  <PTableBody>
    {orders.map((order) => (
      <PTableRow key={order.id}>
        <PTableCell>{order.id}</PTableCell>
        <PTableCell>{order.customer}</PTableCell>
        <PTableCell>{order.date}</PTableCell>
        <PTableCell align="end">€ {order.total}</PTableCell>
        <PTableCell>
          <PTag variant={order.status === 'paid' ? 'success' : 'warning'}>
            {order.status}
          </PTag>
        </PTableCell>
      </PTableRow>
    ))}
  </PTableBody>
</PTable>
```

---

## Tabs

```tsx
import { PTabs, PTabsItem, PHeading, PText } from '@porsche-design-system/components-react';

<PTabs activeTabIndex={0} onUpdate={(e) => console.log(e.detail.activeTabIndex)}>
  <PTabsItem label="Details">
    <PHeading size="lg" tag="h2">Details</PHeading>
    <PText>Content of the first tab.</PText>
  </PTabsItem>
  <PTabsItem label="Specifications">
    <PHeading size="lg" tag="h2">Technical specifications</PHeading>
    <PText>Content of the second tab.</PText>
  </PTabsItem>
  <PTabsItem label="Reviews">
    <PHeading size="lg" tag="h2">Reviews</PHeading>
    <PText>Content of the third tab.</PText>
  </PTabsItem>
</PTabs>
```

---

## Card pattern (composition with multiple components)

PDS does not have a dedicated "Card" component — the standard pattern is a `<div>` with `bg-surface` + padding + content:

```tsx
<article className="p-fluid-md bg-surface rounded-lg flex flex-col gap-fluid-sm">
  <PHeading size="lg" tag="h3">Card title</PHeading>
  <PText size="sm" color="contrast-high">
    Brief description of the card content. It can be on two or three lines.
  </PText>
  <div className="flex gap-static-sm pt-static-sm">
    <PButton variant="secondary">Details</PButton>
    <PButton>Action</PButton>
  </div>
</article>
```

If instead you want a card with a background image and a CTA, use **`<PLinkTile>`** or **`<PButtonTile>`**, which are dedicated components.

```tsx
<PLinkTile
  href="/models/911"
  label="Discover the 911"
  description="The icon by definition"
  aspectRatio="16/9"
  size="medium"
  weight="semi-bold"
>
  <img src="/images/911.jpg" alt="Porsche 911" />
</PLinkTile>
```

---

## Spinner / loading state

```tsx
import { PSpinner, PText } from '@porsche-design-system/components-react';

<div className="flex items-center gap-static-md">
  <PSpinner size="md" />
  <PText size="sm">Loading...</PText>
</div>

// Full page loader
<div className="fixed inset-0 flex flex-col items-center justify-center gap-fluid-md bg-backdrop">
  <PSpinner size="lg" />
  <PText>Loading</PText>
</div>
```

---

## Icon

```tsx
import { PIcon } from '@porsche-design-system/components-react';

// Simple icon
<PIcon name="arrow-right" />

// With size and color
<PIcon name="check" size="lg" color="success" />

// Icon that inherits color from the parent
<PText color="error" className="flex items-center gap-static-xs">
  <PIcon name="warning" color="inherit" />
  Validation error
</PText>
```

Full list of available icons: `https://brand.porsche.com/d/c57AXjojQojN/icon-library`

**Notes**: in v4 with `color="inherit"` you can directly use `color: CSS-value` on the parent, with no more need for the `filter: hue-rotate(...)` hacks of v3.

---

## Pin Code (OTP)

```tsx
'use client';

import { PPinCode } from '@porsche-design-system/components-react';
import { useState } from 'react';

export default function OtpInput() {
  const [code, setCode] = useState('');

  return (
    <PPinCode
      label="Enter the OTP code"
      description="We sent you a code via SMS"
      length={6}
      value={code}
      onChange={(e) => setCode(e.detail.value)}
    />
  );
}
```

---

## Carousel

```tsx
import { PCarousel } from '@porsche-design-system/components-react';

<PCarousel
  heading="Our models"
  slidesPerPage={3}
  pagination // in v4 the default is false
  rewind // in v4 the default is false
>
  <div>
    <img src="/models/911.jpg" alt="911" />
    <PHeading size="md" tag="h3">911</PHeading>
  </div>
  <div>
    <img src="/models/taycan.jpg" alt="Taycan" />
    <PHeading size="md" tag="h3">Taycan</PHeading>
  </div>
  <div>
    <img src="/models/cayenne.jpg" alt="Cayenne" />
    <PHeading size="md" tag="h3">Cayenne</PHeading>
  </div>
</PCarousel>
```

**v4 notes**: the defaults of `pagination`, `rewind`, `trim-space` are now `false`. If you want v3-like behavior, pass them explicitly to `true`.

---

## Flyout (mobile drawer)

```tsx
'use client';

import { PFlyout, PButton, PHeading, PText } from '@porsche-design-system/components-react';
import { useState } from 'react';

export default function MobileMenu() {
  const [open, setOpen] = useState(false);

  return (
    <>
      <PButton onClick={() => setOpen(true)} icon="menu-lines">Menu</PButton>

      <PFlyout
        open={open}
        onDismiss={() => setOpen(false)}
        position="end"  // "start" opens from the left, "end" from the right
      >
        <PHeading slot="header" tag="h2" size="lg">Menu</PHeading>
        <nav className="flex flex-col gap-fluid-sm">
          <PLinkPure href="/">Home</PLinkPure>
          <PLinkPure href="/models">Models</PLinkPure>
          <PLinkPure href="/contact">Contact</PLinkPure>
        </nav>
      </PFlyout>
    </>
  );
}
```

**v4 notes**: positions `left`/`right` are deprecated → use `start`/`end`. The CSS var `--p-flyout-max-width` has been removed → use `--p-flyout-width` with `min()`/`max()`/`clamp()`: `style={{ '--p-flyout-width': 'min(800px, 90vw)' } as React.CSSProperties}`.
