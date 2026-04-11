---
name: create-viewmodel
description: Add or extend Riverpod state in lib/data/providers (this project's ViewModel layer). Use when scaffolding page flow state, repository-backed actions, or codegen providers—without putting providers under lib/src.
---

# Create provider (ViewModel layer)

## Goal
In this codebase, **auto-generated Riverpod providers under `lib/data/providers/` are the ViewModel layer**. Do not create `lib/src/<feature>/viewmodels/`.

Required flow:

`UI -> Provider (lib/data/providers/<controller>_provider.dart) -> Repository -> Client -> HTTP`

## Mandatory Rules
- Use `@riverpod` + code generation like existing domain files (e.g. `authentication_provider.dart` with session + flow + API login notifiers in one file).
- Keep business logic and async orchestration in the notifier/provider, not in widgets.
- Expose immutable state (or the project's AsyncX/idle-loading patterns).
- Do not call Retrofit clients or datasources directly from the provider; call the repository only.
- Do not embed UI types (BuildContext, ThemeData) or widget-specific logic in providers.
- Name files `*_provider.dart` and colocate related state classes in the same file when small.

## Implementation Workflow
1. Inspect an existing provider in `lib/data/providers/` and mirror style, imports, and codegen parts.
2. Create or update `lib/data/providers/<swagger_controller_snake>_provider.dart` (not under `lib/src/`); add notifiers to that domain file instead of new per-UI provider files.
3. Define immutable state (or reuse project async state mixins).
4. Implement notifier methods: set loading, call repository, map to success/error state.
5. From feature pages in `lib/src/<feature>/`, import `package:someriq/data/providers/...` and use `ref.watch` / `ref.read`.
6. Run code generation after annotation changes:
   - `dart run build_runner build --delete-conflicting-outputs`
7. Validate lints and architecture compliance.

## Validation Checklist
- [ ] Provider lives in `lib/data/providers/` with codegen
- [ ] Business logic is in the notifier, not in UI
- [ ] State exposed to UI is immutable / project-standard async
- [ ] Loading/success/error handled per project patterns
- [ ] No UI types or widget logic in provider
- [ ] Repository is the only data boundary (no direct client/datasource)
- [ ] Code generation run when required
- [ ] Lints clean for changed files
