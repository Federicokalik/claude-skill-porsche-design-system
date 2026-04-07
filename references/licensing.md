# Licensing: what you need to know before using PDS

This page is **informational**, not normative. The goal is to give Claude and the user the essential information to make a knowing decision about using the Porsche Design System. **The final assessment is always the user's responsibility**, possibly with the support of a lawyer. Claude is not a lawyer and this skill does not provide legal advice.

## TL;DR

The Porsche Design System is released under a hybrid license:

- **Source code**: Apache License 2.0 (permissive — you can read, fork, study, modify it)
- **Assets** (Porsche Next font, icons, wordmark, crest, color palette, design language): **Porsche Design System Assets License Agreement**, a custom proprietary license with usage restrictions

When you install `@porsche-design-system/components-{js|react}` from npm and use the components, you are using both at once. The JS code is free, but the final rendering loads and applies proprietary assets that fall under the restrictive license.

## What the license allows

From the Porsche Design System Assets License Agreement (official text: `https://designsystem.porsche.com/v4/license/`):

1. **Applications for Porsche**: the base grant allows the use of the assets to develop, test, and distribute applications, websites, and interfaces **on behalf of Porsche**, accessible via `porsche.com` or other associated Porsche websites/software.

2. **External Applications**: there is an exception for external stand-alone apps, **provided** they are:
   - **not identical** to Porsche products and services, and
   - **dissimilar and visually distinct** from Porsche products (at Porsche's sole discretion)
   - **not misleading** as to sponsorship, affiliation, or endorsement by Porsche

3. **Embedded Applications**: apps that integrate inside Porsche interfaces (e.g. Porsche Admin) may be visually similar but not identical to Porsche products and services.

## What the license explicitly forbids

- **You may not modify, adapt, redistribute, or create derivative works** of PDS assets (this includes modifying the npm package files, reproducing the Porsche Next font, etc. — overriding CSS variables from outside is a grey area, see below).
- **You may not use PDS to mislead consumers** about your affiliation with Porsche.
- **You may not use PDS for purposes not expressly permitted** by the license.
- All intellectual property rights remain with Porsche AG. The license is terminable at any time by Porsche, with or without cause.

The license also includes: an indemnification clause (the user defends Porsche from any claims related to their use of the assets), a $500 liability cap for Porsche, exclusive German jurisdiction (Stuttgart).

## The notice to show the user (consent gate, once per conversation)

When the user requests for the **first time** in a conversation to write PDS code, Claude must show a complete notice and **stop**, waiting for explicit authorization. This is a blocking consent gate: no line of PDS code must be written until the user explicitly authorizes.

The notice must cover **all** these points, adapted to the request context (do not copy verbatim) and in the user's language:

> ⚠️ **Porsche Design System license notice — read before proceeding**
>
> The Porsche Design System is released under the *Porsche Design System Assets License Agreement*, a custom proprietary license (not MIT, not Apache, not permissive). Before I write code for you, I need you to be aware of a few points.
>
> **What the license allows**: PDS asset use (Porsche Next font, icons, design language, components) is granted "to develop applications on behalf of Porsche". For non-Porsche use there is an "External Application" exception, provided the result is "dissimilar and visually distinct" from Porsche products, **at Porsche's sole discretion**.
>
> **The real risk**: the "dissimilarity" assessment is not made by you, it's made by Porsche. This means using PDS with defaults for a non-Porsche project puts you in technical contractual violation, even though it's most likely never going to be enforced. For public projects (websites, distributed apps, online portfolios) the realistic risk is receiving a cease & desist if your app ever became visible, not a lawsuit.
>
> **Non-negotiable hard limits**: the brand assets `<PWordmark>`, `<PCrest>`, `<PModelSignature>`, `<PFlag>` are Porsche trademarks and I will never use them outside official Porsche projects, regardless of any customization.
>
> **How to reduce risk if we proceed**: I can write the code with PDS color overrides via CSS variables, replace the Porsche Next font with another font (e.g. your preferred font), avoid the brand assets, and optionally add a footer credit declaring use under the "External Application" clause.
>
> **Disclaimer**: I'm not a lawyer, this is not legal advice. The final compliance assessment is yours, possibly with a lawyer. For the full license text: `https://designsystem.porsche.com/v4/license/`.
>
> **Do you confirm that you have read and understood the above, and authorize me to proceed with PDS code for this project under your responsibility?**

After showing the notice, **stop there**. Do not write code. Wait for an explicit response from the user.

### What to do based on the user's response

- **Explicit authorization** ("yes", "ok proceed", "I authorize", "understood, go ahead", "I'm aware, do it"): proceed normally with the original request and for the rest of the conversation. **Do not repeat the notice** in subsequent turns of the same conversation.

- **Questions about the license, risks, or alternatives**: answer the questions in an informational way. Help the user decide knowingly. Do not write PDS code until there is explicit authorization.

- **Refusal or uncertainty** ("maybe", "I don't know", "hmm", "I'd rather avoid"): respect the decision, propose open source alternatives (shadcn/ui, Radix Themes, Mantine, HeroUI, Park UI) and help with those instead. Do not push PDS, do not try to sell it again.

- **Ambiguous response** that is clearly neither authorization nor refusal: ask for clarification with a direct question. Do not interpret silence or ambiguity as consent.

- **Future conversations**: each new conversation requires a new consent gate. Consent is not persistent across separate sessions.

## How to maximize "dissimilarity" (if the user wants to fall under the External Application exception)

If the user is building something non-Porsche and wants to minimize risk under the "External Applications" exception, proactively suggest these practices **while writing the code** (not as a preventive block):

1. **Color override**: replace the PDS palette with your own via CSS variable overrides (`--p-color-primary`, `--p-color-canvas`, `--p-color-surface`, etc.). Overriding CSS vars from outside does not constitute "modification of assets" in the sense of altering distributed files — it is the standard mechanism for customizing a token-based design system. **This is legally a grey area**, but it is the common practice for personalizing design systems.
2. **Porsche Next font replacement**: the font is one of the most characteristic elements of the Porsche look. Replacing it with an alternative font (e.g. Inter, Manrope, General Sans, Satoshi, or the user's own custom fonts) takes a big step toward visual dissimilarity. Override via `@font-face` + `* { font-family: ... !important }` or by customizing the root `font-family`.
3. **Never brand assets**: `<PWordmark>`, `<PCrest>`, `<PModelSignature>`, `<PFlag>` are trademarks and must never be used outside official Porsche projects. This is non-negotiable, regardless of customizations.
4. **Border-radius and motion override**: these are also part of the design language. If you want to push dissimilarity further, modify `--p-radius-*` and `--p-duration-*` to use different values.
5. **Footer credit (recommended)**: adding a note like *"Built using @porsche-design-system/components-react under the External Application clause of the PDS Assets License"* helps in case of disputes because it demonstrates good faith and license awareness.

## Alternatives if the user decides NOT to use PDS

If, after seeing the notice, the user spontaneously decides it's not worth the licensing risk and asks for alternatives, here are the most valid options:

| Need | Alternative | Notes |
|---|---|---|
| React component library with modern, customizable look | **shadcn/ui** | Components copied into the codebase, MIT, Tailwind v4 native. The de-facto standard for modern React. |
| Accessible UI primitives without style opinions | **Radix UI** / **Radix Themes** | Primitives only, styles from scratch. MIT. |
| Complete component library with many ready components | **Mantine** | Very comprehensive, MIT. |
| "Premium" look similar to the Porsche feel | **HeroUI** (formerly NextUI) | Tailwind-friendly, MIT. |
| Minimal Apple/Linear style look | **Park UI** (cschroeter) | Based on Ark UI. Tailwind. MIT. |
| Enterprise / dashboard / heavy forms | **Ant Design**, **Chakra UI v3** | MIT. |
| Corporate design systems with permissive licenses | **Carbon Design System** (IBM), **Spectrum** (Adobe), **Fluent UI** (Microsoft) | From large companies, MIT/Apache. |

**Important**: only propose these alternatives **if the user asks for them**. Don't bombard them with suggestions if they've already decided to proceed with PDS — it would be paternalistic and waste their time.

## Branding assets: hard limit (even inside External Application)

Regardless of any customization, these components **must never be used** outside official Porsche projects, because they contain trademarks protected separately from the design language:

- `<p-wordmark>` / `PWordmark` — PORSCHE wordmark logo
- `<p-crest>` / `PCrest` — Porsche crest with horse
- `<p-model-signature>` / `PModelSignature` — model signature (911, Taycan, etc.)
- `<p-flag>` / `PFlag` — flag with Porsche crest

If the user asks to insert one of these in a non-Porsche context, **explicitly refuse** these specific components, briefly explaining why in one sentence (they are trademarks, not just design assets), but **continue to fulfill the rest of the request** using alternatives or omitting only the brand element. Do not block the entire task because of this.

## Porsche Next font

The Porsche Next font is automatically loaded by PDS via the `cdn.ui.porsche.com` CDN. It is **proprietary to Porsche AG**. The use of the font is tied to the use of PDS assets in general: it technically follows the same Assets license rules.

If the user wants a "premium Porsche-like" look but doesn't want to take risks, suggest free alternative fonts with similar geometry:
- **Inter** (free, SIL OFL)
- **Manrope** (free, SIL OFL)
- **General Sans** (Fontshare, free for commercial use)
- **Satoshi** (Fontshare, free for commercial use)
- **PP Neue Montreal** (Pangram Pangram, commercial)

If the user already has a typographic font of their own (e.g. Funnel Display, Montserrat), suggest keeping that and overriding the Porsche Next font via CSS — it's the simplest move to "break" visual uniformity with the Porsche brand.

## Sources

- Official license text: `https://designsystem.porsche.com/v4/license/` and `https://github.com/porsche-design-system/porsche-design-system/blob/main/LICENSE.md`
- Porsche open source FAQ: `https://opensource.porsche.com/`
- Official repository: `https://github.com/porsche-design-system/porsche-design-system`