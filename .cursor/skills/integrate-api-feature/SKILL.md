---
name: integrate-api-feature
description: Integrate a Swagger controller endpoint using Retrofit clients in lib/data/services/clients, repositories, providers in lib/data/providers, and UI. Use when wiring endpoints without breaking UI -> Provider -> Repository -> Client boundaries.
---

# Integrate API Feature

## Goal
Implement or extend an endpoint integration while enforcing:

`UI -> Provider (lib/data/providers/<controller>_provider.dart) -> Repository -> Client (lib/data/services/clients/<controller>_client.dart) -> HTTP`

## Mandatory Rules
- Do not skip layers.
- Do not call clients directly from UI.
- Do not call clients directly from providers; call the matching repository only.
- Add or extend Retrofit clients in `lib/data/services/clients/<controller_snake>_client.dart` (one client per Swagger controller name).
- Add/update API request/response models in `lib/data/models/` using Freezed when needed.
- Add/update repositories in `lib/data/repositories/<controller_snake>_repository.dart`.
- Map API models to feature models before exposing data to UI.
- UI must consume provider state only.
- Prefer **one provider file per controller domain** with multiple `@riverpod` types inside; avoid per-page provider files.

## Implementation Workflow
1. Identify the Swagger controller name → derive `<controller_snake>` for file names (`Authentication` → `authentication_*`).
2. Add or extend methods on `lib/data/services/clients/<controller_snake>_client.dart`.
3. Add/update API models in `lib/data/models/` (Freezed if needed).
4. Add/update `lib/data/repositories/<controller_snake>_repository.dart`:
   - Call client methods.
   - Normalize errors.
   - Map API models -> feature models.
5. Update `lib/data/providers/<controller_snake>_provider.dart` to call repository methods only.
6. Expose clean state via Riverpod (`loading` / `data` / `error` or project-equivalent).
7. Update UI under `lib/src/<feature>/` to watch providers and call notifier methods only.
8. Run code generation when annotations/models/providers/clients change.
9. Validate layering and lint status for all edited files.

## Mapping Guidance
- Never pass raw API DTOs into widgets.
- Prefer mapping in repository; map in provider only if repository mapping is not feasible.
- Keep feature models aligned with UI needs, not API payload shape.

## Validation Checklist
- [ ] Client method(s) in `lib/data/services/clients/<controller_snake>_client.dart`
- [ ] API models added/updated in `lib/data/models/` (Freezed if needed)
- [ ] Repository added/updated in `lib/data/repositories/<controller_snake>_repository.dart`
- [ ] API models mapped to feature models before UI
- [ ] Provider calls repository only
- [ ] UI reads provider state only
- [ ] No UI/provider direct client calls
- [ ] Codegen run where required
- [ ] Lints checked and clean for changed files
