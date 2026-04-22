---
name: create-feature-module
description: Create a new feature module in lib/src using the existing layered Riverpod architecture. Use when the user asks to add a new feature folder, scaffold pages and components, or wire providers while preserving layered flow and existing naming conventions.
---

# Create Feature Module

## Goal
Scaffold a new feature under `lib/src/<feature_name>/` that matches this project's pattern.

Architecture rule file: `.cursor/rules/architecture-layering.mdc`  
Feature layout rule file: `.cursor/rules/ui-feature-layout.mdc`

## Canonical data flow
```
UI (lib/src/<feature>/) -> Provider (lib/data/providers/<domain>_provider.dart)
  -> [default] Client (lib/data/services/clients/<domain>_client.dart)
  -> [when repo exists] Repository -> Client
```

Providers call Retrofit clients **directly by default**. Add a repository only when the domain already has one, or when multi-client orchestration, non-trivial mapping, or a local cache layer is required.

## Mandatory architecture rules
- Follow layered flow: `UI -> Provider -> (Repository?) -> Client -> HTTP` — never skip.
- Business logic lives in `lib/data/providers/` (Riverpod codegen), not in UI.
- UI is presentational only: `ref.watch` for state, `ref.read(...notifier)` for actions.
- Never call repositories or clients directly from pages or components.
- No new abstraction layers (no usecases, controllers, managers).
- Reuse existing client/provider files before creating new ones.
- Map API models to UI-facing types in the provider (default) or repository (when present) — never pass raw `lib/data/models/` types to widgets.
- Use centralised routing: add routes to `RoutesDocument` in `lib/router/app_router.dart`.

## Implementation workflow

1. **Pick a reference feature** that matches the same surface type. Real examples:
   - `lib/src/auth/signin_page.dart` — a single-page auth flow.
   - `lib/src/posts/` — page + `components/` folder.
   - `lib/src/account/` — page + `components/` folder.
   Mirror naming, imports, and folder layout exactly.

2. **Check existing data layer.** Does a matching `<domain>_client.dart` / `<domain>_provider.dart` already exist? Extend rather than duplicate.

3. **Create the feature directory:**
   ```
   lib/src/<feature_name>/
     <feature_name>_page.dart   # widget class *Page
     components/                # feature-local UI; add files as needed
   ```

4. **Add or extend `lib/data/providers/<domain>_provider.dart`:**
   - Use `@riverpod` + `part '*.g.dart'`.
   - Call `ref.read(<domain>ClientProvider)` directly (or the repository if one exists).
   - One domain file; multiple `@riverpod` classes in the same file is fine.

5. **Add or extend `lib/data/services/clients/<domain>_client.dart`** if the endpoint is new.

6. **Add models** in `lib/data/models/` (Freezed) for new API shapes.

7. **Register the route** in `RoutesDocument` + `GoRouter` inside `lib/router/app_router.dart`.

8. **Run code generation** after any annotation change:
   ```
   dart run build_runner build --delete-conflicting-outputs
   ```

9. **Validate** — no layer violations, no lints in edited files.

## File skeletons

### `lib/src/<feature>/<feature>_page.dart`
```dart
import 'package:elixir/common_lib.dart';

class FeaturePage extends ConsumerWidget {
  const FeaturePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ref.watch(featureProvider) — read state
    // ref.read(featureProvider.notifier).doAction() — trigger actions
    return const Scaffold();
  }
}
```

### `lib/data/providers/<domain>_provider.dart` (new notifier)
```dart
import 'package:elixir/common_lib.dart';
import 'package:elixir/data/services/clients/<domain>_client.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part '<domain>_provider.g.dart';

@riverpod
class FeatureNotifier extends _$FeatureNotifier {
  @override
  AsyncValue<FeatureState> build() => const AsyncData(FeatureState.initial());

  Future<void> load() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref.read(<domain>ClientProvider).fetchSomething().data,
    );
  }
}
```

## Naming conventions
- `snake_case` file names; entry files end with `_page.dart`.
- Widget class: `PascalCase` + `Page` suffix.
- Provider files in `lib/data/providers/`: end with `_provider.dart`.
- Client files in `lib/data/services/clients/`: end with `_client.dart`.

## Completion checklist
- [ ] Feature created under `lib/src/<feature_name>/` with flat layout (no `presentation/`, `screens/`, `viewmodels/`)
- [ ] Entry page at `lib/src/<feature_name>/..._page.dart` with `*Page` widget
- [ ] `components/` folder exists for feature-local UI
- [ ] Provider added/updated in `lib/data/providers/` with codegen
- [ ] No direct UI-to-client/datasource calls
- [ ] Route registered in `RoutesDocument` + `GoRouter`
- [ ] No duplicated logic or parallel implementations
- [ ] Code generation run if annotations changed
- [ ] Lints clean for edited files
