#!/usr/bin/env bash
# check-updates.sh — check current Porsche Design System versions on the npm registry
#
# Usage: ./check-updates.sh
#
# Compares the "latest" and "next" versions of:
# - @porsche-design-system/components-js
# - @porsche-design-system/components-react
# - @porsche-design-system/components-angular
# - @porsche-design-system/components-vue
#
# Against this skill's snapshot (v3 and v4).
#
# Useful to check whether this skill's offline documentation is still up to date
# or whether the Porsche team has released a new major version (v5?) to document.

set -euo pipefail

SKILL_V3="3.x"
SKILL_V4="4.x"
SKILL_DATE="2026-04-04"

PACKAGES=(
  "@porsche-design-system/components-js"
  "@porsche-design-system/components-react"
  "@porsche-design-system/components-angular"
  "@porsche-design-system/components-vue"
)

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  Porsche Design System — version check"
echo "  Skill snapshot date: ${SKILL_DATE}"
echo "  Skill documents: v${SKILL_V3} (stable) and v${SKILL_V4} (latest)"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Check that npm is installed
if ! command -v npm &> /dev/null; then
  echo "❌ npm not found. Install Node.js before running this script."
  exit 1
fi

HAS_NEW_MAJOR=0

for pkg in "${PACKAGES[@]}"; do
  echo "📦 ${pkg}"

  # Latest version
  LATEST=$(npm view "$pkg" version 2>/dev/null || echo "ERROR")
  if [ "$LATEST" = "ERROR" ]; then
    echo "   ⚠️  Unable to fetch version (network or npm registry down?)"
    echo ""
    continue
  fi
  echo "   latest: ${LATEST}"

  # Next version (beta / pre-release) if it exists
  NEXT=$(npm view "$pkg" dist-tags.next 2>/dev/null || echo "")
  if [ -n "$NEXT" ] && [ "$NEXT" != "undefined" ]; then
    echo "   next:   ${NEXT}  (pre-release)"
  fi

  # Extract numeric major version
  MAJOR="${LATEST%%.*}"

  if [ "$MAJOR" -gt 4 ]; then
    echo "   🚨 NEW MAJOR VERSION: v${MAJOR} is not yet documented in this skill!"
    echo "       Update the skill by reading the migration guide:"
    echo "       https://designsystem.porsche.com/v${MAJOR}/news/migration-guide/porsche-design-system/"
    HAS_NEW_MAJOR=1
  elif [ "$MAJOR" = "4" ]; then
    echo "   ✅ v4 documented in the skill (references/v3-vs-v4.md)"
  elif [ "$MAJOR" = "3" ]; then
    echo "   ✅ v3 documented in the skill"
  else
    echo "   ⚠️  Unexpected version (v${MAJOR})"
  fi

  echo ""
done

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
if [ "$HAS_NEW_MAJOR" -eq 1 ]; then
  echo "⚠️  WARNING: a major version has been released that is not yet documented."
  echo "   Suggested actions:"
  echo "   1. Read the official migration guide"
  echo "   2. Update references/v3-vs-v4.md → rename/extend to v3-vs-v4-vs-vN"
  echo "   3. Add setup-* files for the new version if the API has changed"
  echo "   4. Update the quick reference tables in SKILL.md"
  exit 2
else
  echo "✅ The skill is aligned with the latest versions on the npm registry."
  echo "   Last check: $(date +%Y-%m-%d)"
fi
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
