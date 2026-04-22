---
name: normalize-theme-usage
description: Refactors UI to replace hardcoded styles with AppTheme tokens and extends theme if needed. Use when the user asks to clean up inline TextStyle or Color literals, enforce theme consistency, or add missing semantic tokens to app_theme.dart.
---

# Normalize Theme Usage

## Goal
Scan a feature's UI files for hardcoded `TextStyle` and `Color` literals, replace them with `AppTheme` tokens, and extend `app_theme.dart` with new semantic tokens when no close match exists.

## Mandatory architecture rules
Rule files: `.cursor/rules/ui-polish.mdc`, `.cursor/rules/code-hygiene.mdc`

- All colors and text styles in UI must come from `AppTheme` tokens in `lib/theme/app_theme.dart`.
- Do not create inline `TextStyle(...)` or `Color(0x...)` in widget files.
- Do not modify repository, service, or datasource files — this skill is UI-layer only.
- Naming of new tokens must be semantic (describe intent, not value): prefer `AppTheme.subtitleSecondary` over `AppTheme.grey500`.

## Implementation Workflow

### 1. Scan for Hardcoded Styles
- Search the target feature under `lib/src/<feature>/` (`*_page.dart` at feature root and `components/`) for:
  - `TextStyle(` literals
  - `Color(` literals (including `Color(0x...)`, `Colors.*` not from theme)
  - Hardcoded `fontSize`, `fontWeight`, `color` inside inline `TextStyle`
- List every occurrence with file path and line number.

### 2. Map to Existing AppTheme Tokens
- Open `app_theme.dart` and review all current tokens.
- For each hardcoded value, attempt to map to the closest existing token:
  - Same or visually equivalent color → use existing token
  - Same or equivalent text style (size, weight, color combination) → use existing token
- Document any values that have no existing match.

### 3. Extend AppTheme if Needed
- For unmatched values, add a new semantic token to `app_theme.dart`:
  - Name must reflect design intent (e.g., `cardSubtitleColor`, `sectionHeaderStyle`)
  - Place token in the appropriate section (colors, text styles, etc.)
  - Do not duplicate existing tokens — consolidate where semantically valid
- If in doubt whether to add a token, prefer adding over hardcoding.

### 4. Replace Hardcoded Usages
- Replace every identified hardcoded value with its mapped or newly created `AppTheme` token.
- Ensure the replacement is consistent across all files in the feature.
- Do not change layout, spacing, or logic — only style references.

### 5. Last Resort: Annotated Hardcode
- If a value cannot reasonably be tokenized (one-off design exception), keep the hardcode but add:
  ```dart
  // TODO: move to AppTheme once design token is confirmed
  ```
- This must be rare and intentional, not a default.

### 6. Verify and Lint
- Run `dart analyze` on modified files.
- Confirm no inline `TextStyle` or `Color` literals remain without justification.
- Confirm `app_theme.dart` compiles and all new tokens are used.

## Token Naming Conventions
- Colors: `<context><Role>Color` — e.g., `cardBorderColor`, `inputLabelColor`
- Text styles: `<context><Role>Style` — e.g., `sectionTitleStyle`, `captionMutedStyle`
- Avoid value-based names: no `grey400`, `font14Bold`, `rgba255`

## Completion Checklist
- [ ] All hardcoded `TextStyle` literals identified
- [ ] All hardcoded `Color` literals identified
- [ ] Each value mapped to existing `AppTheme` token where possible
- [ ] New semantic tokens added to `app_theme.dart` for unmatched values
- [ ] All usages replaced consistently across the feature page file(s) and `components/`
- [ ] No remaining inline styles without a `// TODO` annotation
- [ ] `dart analyze` passes on all modified files
- [ ] New tokens follow semantic naming convention
