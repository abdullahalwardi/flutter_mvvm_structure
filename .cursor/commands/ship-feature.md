# ship-feature

Build a complete feature end-to-end: API integration → providers → UI → localization → tests.

**Skills:** `.cursor/skills/create-feature-module/SKILL.md`, `.cursor/skills/integrate-api-feature/SKILL.md`, `.cursor/skills/generate-tests/SKILL.md`  
**Rule files:** `.cursor/rules/architecture-layering.mdc`, `.cursor/rules/ui-feature-layout.mdc`, `.cursor/rules/ui-polish.mdc`, `.cursor/rules/routing.mdc`, `.cursor/rules/code-hygiene.mdc`

## 0. Input parsing

Accept:
- `swagger:` — endpoint URL or controller name
- `figma:` — Figma file/node URL
- `notes:` — optional context

From Swagger: extract endpoints, request/response schemas, required fields.  
From Figma: extract screens, flow sequence, UI states (loading, error, empty, success).

Build an internal mapping: UI actions → API calls → provider state.  
If mismatch detected between Figma flow and API structure: mark for reconciliation in the provider or repository layer (never change UI to match API — always adapt in data layer).

## 1. Feature scaffolding

Use **feature-builder** to create `lib/src/<feature>/` (flat: `<feature>_page.dart` + `components/`).

**Auth pages:** must go inside the existing `lib/src/auth/` folder — do not create `lib/src/login/`, `lib/src/otp_verification/`, or `lib/src/create_account/`.

Add or extend `lib/data/providers/<domain>_provider.dart` (domain = Swagger controller snake_case).

## 2. Data layer

Use **data-layer-engineer** to:
1. Add/extend Retrofit client in `lib/data/services/clients/<domain>_client.dart`.
2. Add/update models in `lib/data/models/` (Freezed).
3. Update provider in `lib/data/providers/<domain>_provider.dart`:
   - **Default:** call client directly.
   - **When domain has a repository** (posts, user, attachment, notifications): call repository.
4. If a repository is involved, update `lib/data/repositories/<domain>_repository.dart` with mapping and error normalisation.

## 3. UI ↔ API reconciliation (critical)

If Figma flow ≠ API structure:
- Do NOT change UI to match API.
- Adapt in `lib/data/providers/` or repository layer.
- Transform API models → UI-ready state.
- Combine/split API calls in the provider if needed to match UX flow.

## 4. Provider logic

Implement in `lib/data/providers/` (Riverpod codegen):
- Handle: `AsyncLoading`, `AsyncData`, `AsyncError`.
- Expose immutable state to UI.

## 5. UI implementation

### Layout (Figma mode)
- Match Figma layout structure, spacing, hierarchy exactly.
- Use `AppTheme` tokens from `lib/theme/app_theme.dart`.
- Break UI into components under `lib/src/<feature>/components/`.
- Implement all UI states: loading (skeleton from `lib/utils/widgets/skeletons/` or `lib/utils/widgets/place_holders/`), error, empty, success.
- No `CircularProgressIndicator` for full-screen / section loads.

### Localization
- All user-facing text uses `context.l10n.*` keys.
- Add missing keys to `lib/l10n/app_en.arb`, `app_ar.arb`, `app_ku.arb`.
- No hardcoded strings.

### Theme
- All colors and text styles from `AppTheme`.
- Extend `lib/theme/app_theme.dart` with new semantic tokens if needed.
- Hardcode only as absolute last resort with `// TODO: move to AppTheme`.

### Data display rules
- No raw IDs in UI — use human-readable fields.
- Monetary values: use `splitMoney(...)`.
- Directionality: app locale only; never infer from text.
- Enums: define in `lib/data/models/enums.dart`.
- Icons: check `assets/svg/` before `Icons.*`.

## 6. Routing

- Add route constant to `RoutesDocument` in `lib/router/app_router.dart`.
- Name describes the screen (e.g. `wallet`, `deleteAccount`, `getVerifiedDocumentType`).
- Use existing constants when available — do not duplicate.
- For reusable screens, use typed `GoRouterState.extra`.

## 7. Integration

Connect UI → providers → data layer. Ensure no layer violations.

## 8. Validation

Use **architecture-guardian** to verify:
- No skipped layers.
- No API models in UI.
- No direct client or datasource calls from UI.
- Provider calls client directly (default) or repository (when applicable).

## 9. Cleanup

Use **refactor-agent** to remove duplication, align naming, ensure consistency.

## 10. Tests

Run `/call-skill generate-tests feature=<feature_name>` to scaffold:
- `test/<feature>_provider_test.dart`
- `test/<feature>_page_test.dart`

---

**Priority rule:** UI/UX (Figma) has priority over API structure. All mismatches resolved in `lib/data/providers/` or repository. Architecture must never be violated.
