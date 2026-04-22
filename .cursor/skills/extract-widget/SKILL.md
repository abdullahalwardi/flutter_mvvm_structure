---
name: extract-widget
description: Extract reusable presentational UI from existing feature pages into the feature components folder. Use when the user asks to refactor duplicated UI into components, reduce page complexity, or move repeated UI patterns into lib/src/<feature>/components/.
---

# Extract Widget / Component

## Goal
Refactor repeated UI patterns from an existing feature **page** into reusable widgets inside that feature's **`components/`** folder, while keeping business logic out of UI.

## Mandatory architecture rules
Rule file: `.cursor/rules/ui-feature-layout.mdc`

- Keep layered flow intact: `UI -> Provider -> (Repository?) -> Client`.
- Extracted components must be **presentational only**.
- Do not add business logic in feature components.
- Do not call clients, repositories, or datasources from feature components.
- Pass all required data and callbacks via constructor parameters.
- Do not introduce state unless it is strictly UI-related (e.g. local visual toggles/animations).
- Keep styles and spacing consistent with `lib/theme/app_theme.dart` tokens.
- **Reuse existing shared widgets under `lib/utils/widgets/`** before creating feature-local components.

## Implementation Workflow
1. Inspect the target page and identify repeated UI blocks or repeated visual patterns.
2. Check whether an equivalent component already exists in the same feature `components/` folder; reuse/extend it if possible.
3. Create or update Dart files under `lib/src/<feature>/components/` only when no suitable shared widget exists.
4. Move only presentational markup into the component:
   - Layout structure
   - Styling
   - Display formatting that is purely visual
5. Keep behavior external:
   - Pass data in through final constructor parameters
   - Pass actions as callbacks from parent page/component
6. If local state is needed, keep it minimal and UI-only; avoid domain/business decisions in component state.
7. Replace repeated page sections with the extracted component usage.
8. Verify theme consistency (colors, text styles, spacing, radius) by using existing theme tokens/patterns already used in that feature.
9. Run lints and ensure no architecture violations were introduced.

## Extraction Heuristics
- Extract when a pattern appears 2+ times in a page or across components in the same feature.
- Prefer a focused component with a clear name over an overly generic abstraction.
- Avoid premature extraction for one-off UI unless it significantly improves readability.

## Naming
- Feature-local files live under `components/` (not `widgets/` at feature level).
- Real examples: `lib/src/posts/components/`, `lib/src/account/components/`, `lib/src/settings/components/`.
- Use names that describe presentation intent (e.g. `PostCoverPreviewCard`, `ProfileInfoCard`).

## Completion Checklist
- [ ] Duplicated UI identified and consolidated
- [ ] New/updated component lives under `lib/src/<feature>/components/`
- [ ] Component is presentational-only (no business logic)
- [ ] No repository/client/datasource calls from the component
- [ ] Theme tokens used consistently
- [ ] Parent page updated to use the component
- [ ] Lints checked for edited files
