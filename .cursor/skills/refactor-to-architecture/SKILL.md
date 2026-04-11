---
name: refactor-to-architecture
description: Refactor existing code to strictly match the project's architecture rules and layered flow. Use when the user asks to refactor, clean up layering, move logic between UI/providers/repository/service, remove parallel implementations, or enforce architecture compliance.
---

# Refactor To Architecture

## Goal
Refactor existing code so it strictly follows project architecture and naming/structure conventions.

Required flow:

`UI -> Provider (lib/data/providers/<controller>_provider.dart) -> Repository -> Client (lib/data/services/clients/<controller>_client.dart) -> HTTP` (plus datasources when local storage applies)

## Mandatory Rules
- Enforce proper layering and never skip layers.
- Move business logic out of UI and into `lib/data/providers/` (Riverpod codegen).
- Move API calls out of providers and into repository/service layer (providers call repository only).
- Keep repository as the boundary for mapping and error normalization.
- Do not use API models directly in UI; map to feature models first.
- Ensure features do not directly depend on each other.
- Remove duplicate or parallel implementations; extend existing logic first.
- Align file naming and structure: flat `lib/src/<feature>/` (`*_page.dart` + `components/`); providers only in `lib/data/providers/`.
- Do not introduce new abstractions or layers (no usecases/controllers/managers).

## Refactor Workflow
1. Identify architecture violations in changed scope:
   - UI containing business logic or side effects
   - Provider calling clients or datasources directly
   - UI using API DTOs/models directly
   - Feature-to-feature dependency leaks
   - Duplicate implementations of the same responsibility
   - `viewmodels/` or `presentation/` under `lib/src/<feature>/`
2. Inspect existing patterns in `lib/data/providers/` and feature folders; mirror them exactly.
3. Refactor UI layer:
   - Keep pages and components presentational only
   - Replace direct logic with notifier methods and provider state reads
4. Refactor provider layer:
   - Keep business/state orchestration in `lib/data/providers/`
   - Delegate all data access to repository only
5. Refactor repository layer:
   - Centralize client/datasource coordination
   - Map API models to feature models
   - Normalize errors before exposing to providers
6. Refactor client/datasource boundaries:
   - Keep Retrofit clients stateless and API-focused
   - Keep datasources low-level with no UI awareness
7. Remove duplicated paths and keep one canonical implementation.
8. Run code generation when annotations or generated models/providers are affected.
9. Verify architecture and lint cleanliness in all edited files.

## Decision Rules
- Reuse before create: extend existing repository/service/provider when possible.
- If shared logic is needed across features, move it to allowed shared layers (`lib/data/` or `lib/utils/`) rather than cross-feature imports.
- Prefer new or extended files in `lib/data/providers/` over feature-local viewmodel folders.
- Preserve existing router-based navigation patterns; avoid route magic strings in UI.

## Validation Checklist
- [ ] UI is presentational-only (no business logic, no API calls)
- [ ] Providers contain orchestration and call repository only
- [ ] Repository handles client calls, mapping, and error normalization
- [ ] Clients/datasources remain stateless/low-level
- [ ] API models are not consumed directly by UI
- [ ] No direct feature-to-feature dependency
- [ ] No duplicate or parallel implementation left
- [ ] `lib/src/<feature>/` uses flat layout + `components/` + `*_page.dart`; providers in `lib/data/providers/`
- [ ] No new abstraction layers introduced
- [ ] Codegen run if required
- [ ] Lints checked and clean for changed files
