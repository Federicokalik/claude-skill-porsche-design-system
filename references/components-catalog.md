# PDS Component Catalog

Complete list of Porsche Design System components with v3/v4 status, Vanilla tag, React import, and a short usage description. For ready-to-use snippets see `components-snippets.md`. For the API details (props, events, slots) of each component, consult the official configurator: `https://designsystem.porsche.com/v4/components/<name>/configurator/`.

**Legend:**
- ✅ Available and recommended
- 🧪 Experimental (API may change)
- 🤡 Deprecated (still working but will be removed)
- 🚫 Removed in this version
- N/A Never existed in this version

## Action & Navigation

| Component | v3 | v4 | Vanilla tag | React import | Usage |
|---|---|---|---|---|---|
| **Button** | ✅ | ✅ | `<p-button>` | `PButton` | Primary/secondary CTAs, form actions. Variants: `primary`, `secondary`, `tertiary` (v3), `critical`. |
| **Button Pure** | ✅ | ✅ | `<p-button-pure>` | `PButtonPure` | Text button without background, for inline or secondary actions. Supports an icon. |
| **Button Tile** | ✅ | ✅ | `<p-button-tile>` | `PButtonTile` | Clickable card with background image + label + CTA. Used in showcases. |
| **Button Group** | 🤡 | 🚫 | `<p-button-group>` | `PButtonGroup` | Group of side-by-side buttons. In v4 replaced by `<div role="group" class="flex flex-wrap gap-fluid-sm max-xs:flex-col">`. |
| **Link** | ✅ | ✅ | `<p-link>` | `PLink` | Link styled as a CTA (with background). Variants: `primary`, `secondary`, ~~`ghost`~~ (removed v4), ~~`tertiary`~~ (removed v4). |
| **Link Pure** | ✅ | ✅ | `<p-link-pure>` | `PLinkPure` | Inline text link, equivalent to a PDS-styled `<a>`. |
| **Link Social** | 🤡 | 🚫 | `<p-link-social>` | `PLinkSocial` | Social network link (Facebook, Instagram, etc.). In v4 replaced by `<PLink icon="logo-facebook">`. |
| **Link Tile** | ✅ | ✅ | `<p-link-tile>` | `PLinkTile` | Clickable card (link) with background image + title + description. |
| **Link Tile Model Signature** | ✅ | 🚫 | `<p-link-tile-model-signature>` | `PLinkTileModelSignature` | Tile specific to Porsche car models. In v4 use `<PLinkTile>`. |
| **Link Tile Product** | 🧪 | 🧪 | `<p-link-tile-product>` | `PLinkTileProduct` | Tile for products with aspect-ratio (e.g. `1/1`, `3/4`, `9/16`, `16/9`). Experimental. |
| **Pagination** | ✅ | ✅ | `<p-pagination>` | `PPagination` | Pagination for long lists. Event `update` (was `pageChange` in v3). |
| **Tabs** | ✅ | ✅ | `<p-tabs>` | `PTabs` | Tab navigation with associated content. |
| **Tabs Bar** | ✅ | ✅ | `<p-tabs-bar>` | `PTabsBar` | Only the tab bar, without content management. Useful for navigation bars. |
| **Stepper Horizontal** | ✅ | ✅ | `<p-stepper-horizontal>` | `PStepperHorizontal` | Step-by-step navigation (e.g. checkout, wizard). |
| **Drilldown** | 🧪 | 🧪 | `<p-drilldown>` | `PDrilldown` | Hierarchical mobile-friendly drilldown menu. Experimental. |

## Forms

| Component | v3 | v4 | Vanilla tag | React import | Usage |
|---|---|---|---|---|---|
| **Checkbox** | ✅ | ✅ | `<p-checkbox>` | `PCheckbox` | Single checkbox with integrated label. In v3 you used `p-checkbox-wrapper` + `<input>`. |
| **Checkbox Wrapper** | 🤡 | 🚫 | `<p-checkbox-wrapper>` | `PCheckboxWrapper` | Legacy v3 wrapper. In v4 replaced by `<PCheckbox>`. |
| **Radio Group** | ✅ | ✅ | `<p-radio-group>` + `<p-radio-group-option>` | `PRadioGroup` + `PRadioGroupOption` | Set of radio buttons with a common label. In v3 you used `p-radio-button-wrapper`. |
| **Radio Button Wrapper** | 🤡 | 🚫 | `<p-radio-button-wrapper>` | `PRadioButtonWrapper` | v3 legacy. |
| **Switch** | ✅ | ✅ | `<p-switch>` | `PSwitch` | On/off toggle. Event `update` (was `switchChange` v3). |
| **Select** | ✅ | ✅ | `<p-select>` + `<p-select-option>` (+ `<p-optgroup>`) | `PSelect` + `PSelectOption` | Single-select dropdown with integrated label. Event `change` (was `update` v3). |
| **Select Wrapper** | 🤡 | 🚫 | `<p-select-wrapper>` | `PSelectWrapper` | Legacy v3 that wrapped `<select>`. |
| **Multi Select** | ✅ | ✅ | `<p-multi-select>` + `<p-multi-select-option>` | `PMultiSelect` + `PMultiSelectOption` | Multi-select dropdown with selected chips/tags. |
| **Segmented Control** | ✅ | ✅ | `<p-segmented-control>` + `<p-segmented-control-item>` | `PSegmentedControl` + `PSegmentedControlItem` | iOS-style switcher for mutually exclusive choices. Event `change`. |
| **Input Text** | ✅ | ✅ | `<p-input-text>` | `PInputText` | Input type="text". Replaces `p-text-field-wrapper` v3. |
| **Input Email** | ✅ | ✅ | `<p-input-email>` | `PInputEmail` | Input type="email". |
| **Input Password** | ✅ | ✅ | `<p-input-password>` | `PInputPassword` | Input type="password" with visibility toggle. |
| **Input Number** | ✅ | ✅ | `<p-input-number>` | `PInputNumber` | Input type="number". |
| **Input Date** | ✅ | ✅ | `<p-input-date>` | `PInputDate` | Input type="date". |
| **Input Time** | ✅ | ✅ | `<p-input-time>` | `PInputTime` | Input type="time". |
| **Input Month** | ✅ | ✅ | `<p-input-month>` | `PInputMonth` | Input type="month". |
| **Input Week** | ✅ | ✅ | `<p-input-week>` | `PInputWeek` | Input type="week". |
| **Input Tel** | ✅ | ✅ | `<p-input-tel>` | `PInputTel` | Input type="tel" for phone numbers. |
| **Input Url** | ✅ | ✅ | `<p-input-url>` | `PInputUrl` | Input type="url". |
| **Input Search** | ✅ | ✅ | `<p-input-search>` | `PInputSearch` | Input type="search" with integrated magnifying glass icon. |
| **Text Field Wrapper** | 🤡 | 🚫 | `<p-text-field-wrapper>` | `PTextFieldWrapper` | Legacy v3, replaced by the individual `p-input-*`. |
| **Textarea** | ✅ | ✅ | `<p-textarea>` | `PTextarea` | Multi-line text area with integrated label. |
| **Textarea Wrapper** | 🤡 | 🚫 | `<p-textarea-wrapper>` | `PTextareaWrapper` | Legacy v3. |
| **Fieldset** | ✅ | ✅ | `<p-fieldset>` | `PFieldset` | Groups form fields with a semantic legend. |
| **Fieldset Wrapper** | 🤡 | 🚫 | `<p-fieldset-wrapper>` | `PFieldsetWrapper` | Legacy v3. |
| **Pin Code** | ✅ | ✅ | `<p-pin-code>` | `PPinCode` | Input for OTP / PIN code (e.g. 4-6 separated digits). Event `change`. |

## Feedback & Notifications

| Component | v3 | v4 | Vanilla tag | React import | Usage |
|---|---|---|---|---|---|
| **Banner** | ✅ | ✅ | `<p-banner>` | `PBanner` | Full-width notification at the top of the page. Supports heading + description. State: `info`, `success`, `warning`, `error`. |
| **Inline Notification** | ✅ | ✅ | `<p-inline-notification>` | `PInlineNotification` | Inline notification inside a page/section. Same states as Banner. |
| **Toast** | ✅ | ✅ | `<p-toast>` | `PToast` | Transient popup toast. Managed via `toastManager.addMessage({ text, state })`. State: `info`, `success`, `warning`, `error`. |
| **Spinner** | ✅ | ✅ | `<p-spinner>` | `PSpinner` | Circular loading indicator. Sizes: `sm`, `md`, `lg` (v4), or `small`/`medium`/`large` (v3). |

## Overlay & Dialog

| Component | v3 | v4 | Vanilla tag | React import | Usage |
|---|---|---|---|---|---|
| **Modal** | ✅ | ✅ | `<p-modal>` | `PModal` | Modal dialog with overlay. Prop `open`. In v4: use `slot="header"` instead of the `heading` prop. Event `dismiss` (was `close` v3). |
| **Flyout** | ✅ | ✅ | `<p-flyout>` | `PFlyout` | Side panel (drawer). Position `start`/`end`. CSS var `--p-flyout-width`. |
| **Sheet** | ✅ | ✅ | `<p-sheet>` | `PSheet` | Modal sheet from the bottom (mobile-friendly). |
| **Popover** | ✅ | ✅ | `<p-popover>` | `PPopover` | Contextual popover with a trigger (e.g. rich tooltip). |

## Content Display

| Component | v3 | v4 | Vanilla tag | React import | Usage |
|---|---|---|---|---|---|
| **Heading** | ✅ | ✅ | `<p-heading>` | `PHeading` | Semantic titles with PDS sizes. Supports `h1-h6` tags. |
| **Display** | ✅ | 🤡 | `<p-display>` | `PDisplay` | Giant hero text. **Deprecated in v4**, use `<PHeading size="3xl|4xl|5xl">`. |
| **Headline** | 🤡 | 🚫 | `<p-headline>` | `PHeadline` | Legacy v3, replaced by `<PHeading>`. |
| **Text** | ✅ | ✅ | `<p-text>` | `PText` | Paragraph / body text. Supports size and color. |
| **Text List** | ✅ | ✅ | `<p-text-list>` + `<p-text-list-item>` | `PTextList` + `PTextListItem` | Ordered/unordered list with PDS styles. Prop `type`: `unordered`, `numbered`, `alphabetically`. |
| **Icon** | ✅ | ✅ | `<p-icon>` | `PIcon` | Icons from the Porsche icon library (see the icon list: `https://brand.porsche.com/d/c57AXjojQojN/icon-library`). Prop `name`, `size`, `color`. |
| **Tag** | ✅ | ✅ | `<p-tag>` | `PTag` | Static chip / badge. In v4: prop `variant` (`primary`, `secondary`, `success`, `warning`, `error`, `info`). In v3 it was the `color` prop. |
| **Tag Dismissible** | ✅ | ✅ | `<p-tag-dismissible>` | `PTagDismissible` | Removable chip with an X. |
| **Accordion** | ✅ | ✅ | `<p-accordion>` | `PAccordion` | Expand/collapse panel. In v4: use `slot="summary"` instead of the `heading` prop. Event `update` (was `accordionChange`). |
| **Divider** | ✅ | ✅ | `<p-divider>` | `PDivider` | Horizontal/vertical separator. Prop `direction` (was `orientation` v3). |
| **Carousel** | ✅ | ✅ | `<p-carousel>` | `PCarousel` | Slider/carousel with optional pagination. Event `update` (was `carouselChange`). |
| **Scroller** | ✅ | ✅ | `<p-scroller>` | `PScroller` | Horizontal scroll with gradient edges and arrow controls. |

## Data Display

| Component | v3 | v4 | Vanilla tag | React import | Usage |
|---|---|---|---|---|---|
| **Table** | ✅ | ✅ | `<p-table>` + `<p-table-head>` + `<p-table-head-row>` + `<p-table-head-cell>` + `<p-table-body>` + `<p-table-row>` + `<p-table-cell>` | `PTable` + subcomponents | Data table with sorting and responsive. Event `update` (was `sortingChange`). |

## Brand Assets

⚠️ **These components contain proprietary brand elements. Do not use them in non-Porsche projects.** See `licensing.md`.

| Component | v3 | v4 | Vanilla tag | React import | Usage |
|---|---|---|---|---|---|
| **Wordmark** | ✅ | ✅ | `<p-wordmark>` | `PWordmark` | PORSCHE text logo. **Only for Porsche projects.** |
| **Crest** | ✅ | ✅ | `<p-crest>` | `PCrest` | Porsche crest/logo with horse. **Only for Porsche projects.** |
| **Model Signature** | ✅ | ✅ | `<p-model-signature>` | `PModelSignature` | Graphic model signature (911, Taycan, Cayenne, etc.). **Only for Porsche projects.** |
| **Flag** | ✅ | ✅ | `<p-flag>` | `PFlag` | Flag with Porsche crest. **Only for Porsche projects.** |
| **Marque** | 🤡 | 🚫 | `<p-marque>` | `PMarque` | Legacy v3, replaced by `<PWordmark>` or `<PCrest>`. |

## Layout (deprecated / removed)

In PDS v4 layout components have **all been removed** in favor of native CSS/Tailwind utilities. This was a deliberate team choice not to duplicate functionality already offered by Tailwind.

| v3 component | v4 status | Replacement |
|---|---|---|
| `<p-flex>` + `<p-flex-item>` | 🚫 | `<div class="flex gap-fluid-md">` |
| `<p-grid>` + `<p-grid-item size="4">` | 🚫 | `<div class="grid grid-cols-3 gap-fluid-md">` |
| `<p-content-wrapper>` | 🚫 | `<div class="grid-template">` + `<div class="col-extended">` (Porsche Grid utilities) |

The **Porsche Grid** as a concept still exists, but implemented as Tailwind utility classes (`grid-template`, `col-extended`, `col-wide`, `col-basic`, `col-narrow`) rather than JS components. See `tailwind-pds-utilities.md` for details.

## Experimental (🧪)

Experimental components are working but their API may change in future releases without breaking-change warnings. Use them knowingly.

- **Canvas** (`<p-canvas>` / `PCanvas`) — Generic canvas area for custom content, v4.
- **Drilldown** (`<p-drilldown>` / `PDrilldown`) — Hierarchical mobile drilldown menu.
- **Link Tile Product** (`<p-link-tile-product>` / `PLinkTileProduct`) — Tile for products with aspect-ratio.

## Summary by usage category

### "I want to build a form"
→ `PFieldset` + `PInputText`/`PInputEmail`/etc. + `PSelect` / `PMultiSelect` / `PRadioGroup` / `PCheckbox` / `PSwitch` / `PTextarea` + `PButton`

### "I want to build a landing page"
→ `PHeading` (size 4xl/5xl) + `PText` (size lg/xl) + `PLink` or `PButton` + `PWordmark` (only for Porsche) + optionally `PLinkTile` for showcases

### "I want to build a dashboard"
→ `PTabs` + `PTable` + `PButton` + `PTag` + `PInlineNotification` + `PSegmentedControl` + `PPagination`

### "I want to build a checkout / wizard"
→ `PStepperHorizontal` + `PFieldset` + inputs + `PButton` primary/secondary + `PModal` (confirmation) + `PToast` (success message)

### "I want to build a navbar / header"
→ `PWordmark` (Porsche only) + `PTabsBar` or `PLinkPure` + `PButton` (CTA) + optionally `PFlyout` for mobile nav

### "I want to display an error/success message"
→ `PBanner` (full page) / `PInlineNotification` (section) / `PToast` (transient)

## Sources

- Full component list v4: `https://designsystem.porsche.com/v4/components/introduction/`
- Full component list v3: `https://designsystem.porsche.com/v3/components/introduction/`
- Interactive configurators: `https://designsystem.porsche.com/v4/components/<name>/configurator/`
