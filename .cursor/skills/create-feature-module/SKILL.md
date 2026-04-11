---
name: create-feature-module
description: Create a new feature module in lib/src using the existing layered Riverpod architecture. Use when the user asks to add a new feature folder, scaffold pages and components, or wire providers while preserving layered flow and existing naming conventions.
---

# Create Feature Module

## Goal
Scaffold a new feature under `lib/src/<feature_name>/` that matches this project's pattern:

- `<feature_name>_page.dart` at the feature root (flat layout; no `presentation/` or `screens/` subfolders)
- `components/` for feature-only reusable UI (not `widgets/` at feature level—shared widgets stay under `lib/utils/widgets/`)

**State and “ViewModel” logic** live in `lib/data/providers/` as Riverpod codegen providers (e.g. `<controller>_provider.dart`). Do **not** add `lib/src/<feature_name>/viewmodels/`.

Optional:
- Feature-specific UI/domain models under `lib/src/<feature_name>/models/` only when needed and not duplicating `lib/data/models/`.

## Mandatory Architecture Rules
- Follow layered flow only: `UI -> Provider -> Repository -> Client (lib/data/services/clients) -> HTTP` (and datasources when needed).
- Keep business logic in `lib/data/providers/` (annotated + generated), not in UI.
- Keep UI presentational only (render state + trigger provider notifier methods).
- Do not call repositories/clients/datasources directly from pages or components.
- Do not create new layers (no usecases/controllers/managers).
- Reuse existing repository/client/data models before creating new ones.
- Do not use API models directly in UI; map to feature-facing models in repository (or provider when unavoidable).
- Use centralized routing pattern (no hardcoded magic route strings in UI).

## Implementation Workflow
1. Inspect an existing feature that matches the **same kind of surface** (e.g. `lib/src/login/` for login entry only; `lib/src/otp_verification/` for shared OTP; not “everything under login”). Mirror naming, imports, and folder layout for **that** feature.
2. Check if a matching repository/client already exists in `lib/data/`; extend instead of duplicating.
3. Create the feature directory:
   - `lib/src/<feature_name>/<feature_name>_page.dart` (or domain-specific page name, e.g. `login_page.dart`)
   - `lib/src/<feature_name>/components/` (add components as needed; `.gitkeep` ok when empty)
4. Add or extend **`lib/data/providers/<swagger_controller_snake>_provider.dart`** (one domain file; multiple `@riverpod` classes allowed). Wire **`lib/data/repositories/<same>_repository.dart`** and **`lib/data/services/clients/<same>_client.dart`** per Swagger controller naming—do not add a new provider file per UI page.
5. Page is a thin entry: watches providers, dispatches notifier methods, composes components.
6. Add `models/` under the feature only if UI needs a dedicated mapped type.
7. Reuse existing components/patterns where possible; avoid parallel implementations.
8. Run code generation when annotations are used:
   - `dart run build_runner build --delete-conflicting-outputs`
9. Validate no layering violations and no lints in edited files.

## File Skeleton Guidance

### `lib/data/providers/<feature>_…_provider.dart`
- Use Riverpod annotation + `part '*.g.dart'` like existing providers.
- Expose immutable state (or project Async patterns).
- Call repository only; never Retrofit clients or datasources directly.

### `lib/src/<feature>/<feature>_page.dart`
- No business logic; no direct API/data access.
- Public widget class named `*Page` (e.g. `LoginPage`).
- Read state from `ref.watch` / `ref.listen`; call `ref.read(...notifier)` for actions.

### `lib/src/<feature>/models/` (optional)
- Freezed or plain immutable types when the UI needs a non-API shape; prefer mapping in repository.

## Naming and Consistency
- snake_case file names; entry route files end with `_page.dart`; widget class `*Page`.
- Provider files end with `_provider.dart` in `lib/data/providers/`.
- Match existing logging and error normalization at boundaries.

## Completion Checklist
- [ ] Feature created under `lib/src/<feature_name>/` with flat layout (no `presentation/`, `screens/`, `viewmodels/`)
- [ ] Entry page at `lib/src/<feature_name>/..._page.dart` with `*Page` widget
- [ ] `components/` exists for feature-local UI building blocks
- [ ] Providers added/updated under `lib/data/providers/` with codegen
- [ ] No direct UI-to-repository/client/datasource calls
- [ ] No duplicated logic or parallel implementations
- [ ] Code generation run if needed
- [ ] Lints checked for edited files
