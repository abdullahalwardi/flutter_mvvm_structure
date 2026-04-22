---
name: create-viewmodel
description: Add or extend Riverpod state in lib/data/providers (this project's ViewModel layer). Use when scaffolding page flow state, client-backed actions, or codegen providers—without putting providers under lib/src.
---

# Create provider (ViewModel layer)

## Goal
In this codebase **auto-generated Riverpod providers under `lib/data/providers/` are the ViewModel layer**. Do not create `lib/src/<feature>/viewmodels/`.

Architecture rule file: `.cursor/rules/architecture-layering.mdc`

## Canonical flow
```
UI -> Provider (lib/data/providers/<domain>_provider.dart)
   -> [default]  Client (lib/data/services/clients/<domain>_client.dart)
   -> [when repo exists]  Repository -> Client
```

## Mandatory rules
- Use `@riverpod` + code generation like existing domain files (e.g. `auth_provider.dart`).
- Keep business logic and async orchestration in notifiers, not in widgets.
- Expose immutable state (or `AsyncValue` patterns).
- **Default:** call the Retrofit client directly (`ref.read(<domain>ClientProvider)`).
- **When a repository exists for the domain:** call the repository, not the client directly.
  - Domains with repositories: `posts`, `user` (note: `user_repoistory.dart` is the on-disk typo), `attachment`, `notifications`.
- Do not embed UI types (`BuildContext`, `ThemeData`) in providers.
- Name files `*_provider.dart`; colocate related state classes/notifiers in the same file.

## Implementation workflow

1. Inspect an existing domain provider in `lib/data/providers/` and mirror its style, imports, and codegen parts. Good references:
   - `auth_provider.dart` — multi-method notifier calling a client directly.
   - `authentication_provider.dart` — persisted session using `NullableObjectPreferenceProvider`.
   - `posts_provider.dart` — paginated provider using a repository.

2. Add or update `lib/data/providers/<domain>_provider.dart` (not under `lib/src/`). Add notifiers to the existing domain file rather than creating new per-UI provider files.

3. Define immutable state or reuse `AsyncValue`.

4. Implement notifier methods: set loading, call client/repository, handle success/error.

5. From feature pages in `lib/src/<feature>/`, import `package:elixir/data/providers/...` and use `ref.watch` / `ref.read`.

6. Run code generation after annotation changes:
   ```
   dart run build_runner build --delete-conflicting-outputs
   ```

7. Validate lints and architecture compliance.

## Example — provider calling a client directly
```dart
import 'package:elixir/common_lib.dart';
import 'package:elixir/data/services/clients/<domain>_client.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part '<domain>_provider.g.dart';

@riverpod
class SomeFeatureNotifier extends _$SomeFeatureNotifier {
  @override
  AsyncValue<List<FeatureItem>> build() => const AsyncData([]);

  Future<void> load() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () async {
        final data = await ref.read(<domain>ClientProvider).getItems().data;
        return data ?? [];
      },
    );
  }
}
```

## Validation checklist
- [ ] Provider lives in `lib/data/providers/` with codegen
- [ ] Business logic is in the notifier, not in UI
- [ ] State exposed to UI is immutable / `AsyncValue`
- [ ] Loading/success/error handled per project patterns
- [ ] No UI types or widget logic in provider
- [ ] Data boundary: client directly (default) or repository when one exists for the domain
- [ ] Code generation run when required
- [ ] Lints clean for changed files
