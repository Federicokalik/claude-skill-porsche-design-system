# Porsche Design System — Claude Skill (unofficial)

A [Claude skill](https://docs.claude.com/en/docs/agents-and-tools/agent-skills/overview) that teaches Claude how to correctly build web interfaces with the [Porsche Design System (PDS)](https://designsystem.porsche.com/) — covering setup, tokens, components, layout patterns, and licensing rules.

> **Unofficial community project.** This skill is **not affiliated with, endorsed by, or sponsored by Dr. Ing. h.c. F. Porsche AG**. "Porsche", "Porsche Design System", "Porsche Next", and related marks are trademarks of Porsche AG. The official Porsche Design System and its license are available at [designsystem.porsche.com](https://designsystem.porsche.com/).

Built and maintained by [Federico Calicchia](https://calicchia.design) — freelance web designer and developer (Italy).

## What this skill does

When loaded into Claude (via Claude Code, the Claude API with skills enabled, or any compatible client), this skill gives Claude deep, up-to-date knowledge of:

- **Setup for 5 stacks**: Astro, React (Vite), Next.js (App Router), React Router v7, and Vanilla JS / HTML — with v3 and v4 covered separately where APIs differ.
- **Design tokens**: colors (including the v4 `light-dark()` / `color-scheme` system), fluid/static spacing, typography with `prose-*` classes, shadows, motion, blur, border radius.
- **Tailwind CSS v4 integration** with the official PDS theme (`@porsche-design-system/components-*/tailwindcss`).
- **Component catalog** with v3/v4 status (✅ stable, 🤡 deprecated, 🚫 removed, 🧪 experimental) and ready-to-paste snippets in React and Vanilla HTML.
- **Layout patterns**: hero sections, card grids, two-column features, headers with mobile flyout, footers, contact forms, pricing tables, dashboard layouts, empty states.
- **Migration guide v3 → v4**, including breaking changes on props, events, deprecated components, and the lightningcss polyfill fix required for Vite 8+.
- **Licensing rules**: when you can use PDS in non-Porsche projects, how to stay "dissimilar and visually distinct", and which components (wordmark, crest, model signature, flag) are always off-limits outside a Porsche context.

## Why this skill exists

PDS is one of the best-engineered open design systems out there — accessible web components, solid theming, Tailwind integration, versioned APIs. But:

- The docs are split across v3 and v4, with non-trivial API differences.
- The license is hybrid (Apache 2.0 for source + restrictive for brand assets) and often misunderstood.
- LLMs trained on generic web data confuse v3 and v4 props, get theming wrong, or hallucinate component names.

This skill condenses the PDS documentation, migration guides, and licensing into a format Claude can reason over directly, producing correct code on the first try instead of outdated or invented snippets.

## Installation

### Claude Code

Clone the repo and drop the `porsche-design-system/` folder into Claude Code's skills directory. Refer to the [Claude Code skills documentation](https://docs.claude.com/en/docs/claude-code/skills) for the current path.

### Claude API / other clients

Zip the `porsche-design-system/` folder into a `.skill` bundle (it's just a standard zip):

```bash
zip -r porsche-design-system.skill porsche-design-system/
```

Then upload via your client's skill-management interface.

### Manual / read-only

If you don't use skills at all, the markdown files are readable on their own. Browse `porsche-design-system/SKILL.md` as the entry point and follow the references into the `references/` folder.

## Structure

```
porsche-design-system/
├── SKILL.md                          # Entry point: triggers, workflow, quick reference
├── references/
│   ├── licensing.md                  # Full license analysis + decision tree
│   ├── v3-vs-v4.md                   # Migration guide and breaking changes
│   ├── setup-astro.md                # Astro + Tailwind + PDS (v3 and v4)
│   ├── setup-react-vite.md           # React/Vite + Tailwind + PDS
│   ├── setup-nextjs.md               # Next.js App Router + PDS SSR
│   ├── setup-react-router.md         # React Router v7 + PDS SSR
│   ├── setup-vanilla.md              # Vanilla JS / HTML / CDN / WordPress
│   ├── tokens-colors.md              # Color tokens, color-scheme, semantic colors
│   ├── tokens-spacing.md             # Fluid & static spacing, breakpoints
│   ├── tokens-typography.md          # Porsche Next font, prose-* classes, sizes
│   ├── tailwind-pds-utilities.md     # Full Tailwind + PDS utility reference
│   ├── components-catalog.md         # Component list with v3/v4 status
│   ├── components-snippets.md        # Ready-to-paste React + Vanilla snippets
│   └── patterns-layout.md            # 9 complete layout patterns
└── scripts/
    └── check-updates.sh              # Checks PDS versions on npm registry
```

## Licensing

**This skill (the markdown documentation, prose, snippets, and shell script) is released under the MIT License** — see [LICENSE](./LICENSE).

**The Porsche Design System itself is NOT covered by this repository's MIT license.** PDS has a hybrid license:

- **Source code**: Apache License 2.0
- **Brand assets** (Porsche Next font, icons, wordmark, crest, color palette, motion, design language): restrictive license defined in the [Porsche Design System Assets License Agreement](https://designsystem.porsche.com/v4/license/)

Key points about using PDS itself (summarized — always read the full official license before shipping production code):

- ✅ **Porsche projects**: use freely, including brand assets.
- ✅ **Non-Porsche projects in any industry**: permitted, provided the result is _"dissimilar and visually distinct from Porsche products and services"_ at Porsche's sole discretion.
- ❌ **Porsche brand components** (`<p-wordmark>`, `<p-crest>`, `<p-model-signature>`, `<p-flag>`): never use outside a Porsche context.
- ❌ **Direct Porsche competitors**: avoid regardless of visual distinction.
- ❌ **Projects explicitly imitating the Porsche aesthetic**: violates the visual-distinction clause.

For full details see [`porsche-design-system/references/licensing.md`](./porsche-design-system/references/licensing.md) or the [official license text](https://designsystem.porsche.com/v4/license/).

## Contributing

Issues, suggestions, and pull requests are welcome. Particularly useful contributions:

- Corrections to API details (props, events, slots) if PDS releases breaking changes
- New layout patterns or component snippets
- Translations of the skill content to other languages
- Fixes to outdated documentation after new PDS releases (run `porsche-design-system/scripts/check-updates.sh` to check against the current npm registry version)

## About the author

I'm **Federico Calicchia**, freelance web designer and developer based in Ceccano (Frosinone), Italy. Through [Calicchia Design](https://calicchia.design) I help Italian SMEs build marketing sites, e-commerce, web apps, and custom WordPress solutions.

If you find this skill useful and want to build something with PDS (or any modern web stack — Astro, Next.js, React, Hono, PostgreSQL), feel free to reach out through [calicchia.design](https://calicchia.design).

## Related resources

- [Porsche Design System — Official documentation](https://designsystem.porsche.com/)
- [Porsche Design System — GitHub repository](https://github.com/porsche-design-system/porsche-design-system)
- [Porsche Design System — Examples](https://github.com/porsche-design-system/examples)
- [Porsche Open Source Platform](https://opensource.porsche.com/)
- [Claude Skills documentation](https://docs.claude.com/en/docs/agents-and-tools/agent-skills/overview)

---

Made with care by [Calicchia Design](https://calicchia.design) · Ceccano (FR), Italy
