---
name: integrate-api-feature
description: Integrate a Swagger controller endpoint using Retrofit clients in lib/data/services/clients, providers in lib/data/providers, and UI. Use when wiring new endpoints without breaking UI -> Provider -> (Repository?) -> Client boundaries.
---

# Integrate API Feature

## Goal
Wire a new Swagger endpoint into the project from client to UI, respecting the project's layered architecture.

Architecture rule file: `.cursor/rules/architecture-layering.mdc`

## Canonical flow
```
UI (lib/src/<feature>/) -> Provider (lib/data/providers/<domain>_provider.dart)
  -> [default]  Client (lib/data/services/clients/<domain>_client.dart)
  -> [when repo exists]  Repository (lib/data/repositories/<domain>_repository.dart) -> Client
```

**Providers call Retrofit clients directly by default.** Add a repository step only when the domain already has one, or when you need non-trivial mapping, multi-client orchestration, or a local cache.

## Mandatory rules
- Never skip layers.
- Never call clients from UI.
- Never call clients from providers when a repository exists for that domain.
- Add/extend Retrofit clients in `lib/data/services/clients/<domain_snake>_client.dart` — one client per Swagger controller.
- Add/update API request/response models in `lib/data/models/` using Freezed.
- Prefer **one provider file per controller domain** with multiple `@riverpod` notifiers; avoid per-page provider files.
- Map API models to UI-facing state in the provider (default) or repository (when present). Never expose raw API DTOs to widgets.
- UI consumes provider state only.

## Implementation workflow

### 1. Identify the Swagger controller
Derive `<domain_snake>` from the controller name (`Authentication` → `authentication`).

### 2. Add or extend the Retrofit client
`lib/data/services/clients/<domain_snake>_client.dart`
```dart
@RestApi()
abstract class FeatureClient {
  factory FeatureClient(Dio dio, {String baseUrl}) = _FeatureClient;

  @GET('/endpoint')
  Future<FutureApiResponse<ResponseModel>> fetchSomething();
}
```

### 3. Add or update API models
`lib/data/models/<name>_model.dart` — use Freezed + json_serializable:
```dart
@freezed
class ResponseModel with _$ResponseModel {
  const factory ResponseModel({required String id, required String title}) = _ResponseModel;
  factory ResponseModel.fromJson(Map<String, dynamic> json) => _$ResponseModelFromJson(json);
}
```

### 4. Provider — default path (no repository)
`lib/data/providers/<domain_snake>_provider.dart`
```dart
@riverpod
class FeatureNotifier extends _$FeatureNotifier {
  @override
  AsyncValue<List<UiItem>> build() => const AsyncData([]);

  Future<void> load() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final raw = await ref.read(featureClientProvider).fetchSomething().data;
      return raw?.map((e) => UiItem.fromModel(e)).toList() ?? [];
    });
  }
}
```

### 4b. Repository path (only when domain already has a repository, or when justified)
- Add/update `lib/data/repositories/<domain_snake>_repository.dart`:
  - Call client methods.
  - Normalise errors.
  - Map API models → feature models.
- Provider calls repository, not the client.

### 5. Update UI
`lib/src/<feature>/<feature>_page.dart` — watch provider, call notifier methods.

### 6. Run code generation
```
dart run build_runner build --delete-conflicting-outputs
```

### 7. Validate
No layer violations; no lints in edited files.

## Mapping guidance
- Never pass raw API DTOs into widgets.
- Keep feature models aligned with UI needs, not API payload shape.
- Prefer mapping in the provider for simple transformations; use a repository when mapping is complex or reused across multiple providers.

## Validation checklist
- [ ] Client method(s) added/extended in `lib/data/services/clients/<domain_snake>_client.dart`
- [ ] API models added/updated in `lib/data/models/` (Freezed)
- [ ] Provider updated in `lib/data/providers/<domain_snake>_provider.dart`
- [ ] Repository updated only if domain already has one or is explicitly justified
- [ ] API models mapped to UI-facing types before reaching UI
- [ ] Provider calls client directly (or repository when applicable) — never the reverse
- [ ] UI reads provider state only
- [ ] Codegen run where annotations changed
- [ ] Lints clean for changed files
