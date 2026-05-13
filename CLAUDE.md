# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project

Flutter app (package name: `app`, see [pubspec.yaml](pubspec.yaml)). Layered architecture: **UI (`lib/src/`) → Riverpod provider (`lib/data/providers/`) → Retrofit client (`lib/data/services/clients/`)**. There is intentionally no repository layer — provider → client is the only correct data path. The structure is documented in detail in [STRUCTURE_DIAGRAM.md](STRUCTURE_DIAGRAM.md), though note the diagram still shows a `data/repositories/` folder that has since been removed (see "Forbidden patterns" in [.cursor/rules/architecture-layering.mdc](.cursor/rules/architecture-layering.mdc)).

## Commands

```bash
flutter pub get                                                      # install deps
dart run build_runner build --delete-conflicting-outputs             # regen Freezed / Retrofit / Riverpod / go_router code
dart run custom_lint                                                 # project-specific lints (Riverpod, etc.)
flutter analyze                                                      # static analysis
flutter test                                                         # all tests
flutter test test/widget_test.dart                                   # single test file
flutter test --name "test name substring"                            # single test by name
flutter run                                                          # run app (uses default device)
```

Run `build_runner` after **any** change to `@freezed`, `@RestApi`, `@riverpod`, or `@TypedGoRoute` annotations — the generated `*.g.dart` / `*.freezed.dart` files are gitignored from the analyzer (see [analysis_options.yaml](analysis_options.yaml)) but required at compile time. `build.yaml` orders generators as **freezed → json_serializable → retrofit_generator**.

Helper scripts live in [bin/](bin/): [bin/run.sh](bin/run.sh) is just the build_runner one-liner, [bin/rename.sh](bin/rename.sh) renames the app bundle/display name.

Localization is configured by [l10n.yaml](l10n.yaml) — ARB files in `lib/l10n/`, generated into `lib/l10n/app_localizations.dart`. Untranslated strings are written to `untranslated_messages.txt` on each build.

## Architecture: data flow

```
UI (lib/src/<feature>/)
 └─> Provider (lib/data/providers/<domain>_provider.dart)
      ├─> Retrofit Client (lib/data/services/clients/<domain>_client.dart)
      └─> [when needed] Datasources (lib/data/shared_preference/, isar, hubs)
```

Providers call Retrofit clients directly. Multi-step orchestration (e.g. upload-then-post, refresh-dependent-provider, cache-then-fetch) lives **inside the provider file**, not in a separate orchestration layer.

### Naming maps to Swagger controllers

For each Swagger controller, one snake_case base name produces matching files in two layers:

| Layer | Path | Example |
|---|---|---|
| Retrofit client | `lib/data/services/clients/<name>_client.dart` | `auth_client.dart` |
| Riverpod provider | `lib/data/providers/<name>_provider.dart` | `auth_provider.dart` |

Multiple `@riverpod` classes per domain file is the norm — do **not** split into one provider file per UI page.

### Layer rules (from [.cursor/rules/architecture-layering.mdc](.cursor/rules/architecture-layering.mdc))

- **Provider** (`lib/data/providers/`): `@riverpod` codegen only, no hand-written providers. May read other providers for orchestration. Must not import from `lib/src/` (no `BuildContext` in pure data flow). Exposes immutable state; mutations only via notifier methods.
- **Retrofit client** (`lib/data/services/clients/`): stateless typed HTTP only. Shared Dio module and interceptors live in `lib/data/services/http/` and `lib/data/services/interceptors/`. Do **not** create a parallel `lib/data/clients/` folder.
- **Datasources**: low-level persistence/transport, no transformations, no UI awareness.

### Forbidden

- UI calling a Retrofit client or datasource directly.
- Reintroducing `lib/data/repositories/` (deleted on purpose).
- New abstraction folders: no `usecases/`, `controllers/`, `managers/`, `viewmodels/`, `repositories/` anywhere.
- Providers under `lib/src/<feature>/` — providers live only in `lib/data/providers/`.

### `lib/data/models/` in UI

Existing UI imports raw API models from `lib/data/models/` widely and that's grandfathered in. **New features** must map API models to feature-facing types inside the provider; feature-facing types may live in `lib/src/<feature>/models/`. Never add an alias/wrapper that just re-exports an API model. Prefer extending the API model with computed getters over creating a parallel feature model.

## Architecture: features (UI layer)

Each user-facing surface gets one **flat** folder under `lib/src/<feature>/`:

```
lib/src/<feature>/
  <feature>_page.dart      # entry route widget — class *Page
  components/              # feature-local presentational widgets only
  models/                  # optional — only for UI-specific shapes
```

Forbidden under a feature: `presentation/`, `screens/`, `viewmodels/`, `widgets/` (use `components/`), and provider files.

The **auth feature is a single flat folder** (`lib/src/auth/` — `signin_page.dart`, `signup_page.dart`, `verify_page.dart`, `forget_password_page.dart`, etc.). Do not split it into `login/`, `otp_verification/`, or `create_account/`. Auth state is split across [lib/data/providers/authentication_provider.dart](lib/data/providers/authentication_provider.dart) (persisted session, `isSignedIn()`, `logout()`) and [lib/data/providers/auth_provider.dart](lib/data/providers/auth_provider.dart) (login / register / verify / forgot-password actions).

Cross-feature shared widgets live in `lib/utils/widgets/`, not inside a feature folder.

### Pages vs components

- **`*_page.dart` (entry route widget)**: wires UI to Riverpod state via `ref.watch` / `ref.read(...notifier)`. No business logic, no API calls, no repository or client calls.
- **`components/`**: dumb and presentational — data in via constructor, events out via callbacks. No `ref` unless genuinely needed for very local UI state.

## Architecture: routing

All typed route declarations live in [lib/router/routes/app_routes.dart](lib/router/routes/app_routes.dart) (`@TypedGoRoute`, `@TypedStatefulShellRoute`). The generated `$appRoutes` list is consumed by the root `GoRouter` in [lib/router/app_router.dart](lib/router/app_router.dart).

- **No raw path strings** in widgets/providers/services. Always navigate via the generated typed route classes.
- **From a widget:** `const SigninRoute().push<void>(context)` / `.go(context)` / `.pushReplacement(context)`.
- **From a provider/notifier:** `ref.read(routerProvider).go(const SigninRoute().location)` (canonical example: logout in `authentication_provider.dart`). For typed-extra pushes that need a `BuildContext`, resolve via `ref.read(routerProvider).routerDelegate.navigatorKey.currentContext`.
- **Auth / role / onboarding redirects:** never call `context.go` from a redirect callback — mutate Riverpod state (`authenticationProvider`, `firstLaunchProvider`) and let `routerListenableProvider` notify the router.
- **Typed extras:** complex non-URL data goes through classes in `lib/router/extras/`. Never pass `Map<String, dynamic>` as `extra`.
- **Stateful shells:** customer/store bottom tabs use `StatefulShellRoute.indexedStack` (`CustomerShellRoute` / `StoreShellRoute`). Tab pages are branches inside those shells; switch tabs with `navigationShell.goBranch(index)`.
- Top-level routes must set `static final GlobalKey<NavigatorState> $parentNavigatorKey = rootNavigatorKey;` so they push onto the root navigator above the shell.

## Code conventions

These rules come from [.cursor/rules/code-hygiene.mdc](.cursor/rules/code-hygiene.mdc) and are project-specific gotchas worth knowing up-front:

- **Extend before creating.** Search for existing clients/providers in the relevant domain before adding a new file. Mirror the structure of the closest existing file in that layer — do not invent new naming mid-project.
- **Naming → layer.** Entry route widget: `*Page` / `*_page.dart`. Retrofit client: `*Client` / `*_client.dart`. Provider file: `*_provider.dart`. Freezed model: `*Model` / `*_model.dart`. Avoid ambiguous names like `Manager`, `Handler`, `Helper`, `Controller`.
- **Feature isolation.** Files under `lib/src/` must not import from another feature. Cross-feature logic goes in `lib/data/` or `lib/utils/`.
- **Shared enums** all live in `lib/data/models/enums.dart`. Do not define enums inside feature folders, viewmodels, or services.
- **No `print`.** Use the logger in `lib/logger/` at boundaries (API entry/exit, navigation events, unhandled errors). `debugPrint()` only for temporary local debugging.
- **No internal IDs in the UI.** Map DB/API IDs to human-readable fields in the provider.
- **Money formatting** uses `splitMoney(...)` from the services layer — never display raw currency numbers.
- **Directionality** follows the app locale (`MaterialApp.locale`) only. Never infer text direction from string content or wrap with `Directionality` based on language.
- **Theme tokens:** all colors and text styles come from [lib/theme/app_theme.dart](lib/theme/app_theme.dart). No hardcoded `TextStyle(...)`, `Color(0x...)`, or `Colors.*` in widget files. Token names are semantic (`successBackground`, `sectionTitleStyle`), not value-based.
- **SVG first:** check `assets/svg/` for an asset before reaching for Flutter's `Icons`.
- **`TextEditingController.text =` is a trap.** When the new value comes from external state (sliders, providers, listeners, timers, async results), use the `setTextSafely(...)` extension from [lib/utils/extensions.dart](lib/utils/extensions.dart). Direct `.text =` leaves stale selection offsets and crashes on Android with `IndexOutOfBoundsException: invalid selection start` when the new text is shorter than the cached cursor position. The only acceptable raw `.text =` is initialization inside `useTextEditingController(text: ...)` or one-shot user-driven mutations on a known-empty, unfocused field.
- **Loading UI:** for full-screen / section first-paint, use skeletons from `lib/utils/widgets/skeletons/` or named placeholders from `lib/utils/widgets/place_holders/` (mirror the real layout). Do **not** use a centered `CircularProgressIndicator` for page loads. Inline spinners inside a button or OTP row are fine.

## Linter config

[analysis_options.yaml](analysis_options.yaml) enforces `prefer_single_quotes` and `require_trailing_commas`. Generated files (`*.g.dart`, `*.freezed.dart`) are excluded. `use_build_context_synchronously`, `depend_on_referenced_packages`, `invalid_annotation_target`, `unused_element`, and `deprecated_member_use` are intentionally silenced — do not re-enable without checking with the maintainer.

A `custom_lint.log` lives at the repo root from a previous run; `dart run custom_lint` regenerates it.

## More detailed rules

The full canonical rule set lives in [.cursor/rules/](.cursor/rules/) (these are Cursor `.mdc` files, but the content applies regardless of editor):

- [architecture-layering.mdc](.cursor/rules/architecture-layering.mdc) — data flow, layer boundaries, mapping policy.
- [code-hygiene.mdc](.cursor/rules/code-hygiene.mdc) — naming, isolation, codegen, logging, theme, controllers.
- [routing.mdc](.cursor/rules/routing.mdc) — typed routes, navigation, redirects, shells.
- [ui-feature-layout.mdc](.cursor/rules/ui-feature-layout.mdc) — flat feature folders, page vs component behaviour.
- [ui-polish.mdc](.cursor/rules/ui-polish.mdc) — skeletons, bidirectional layout, theme tokens.
- [auth-feature.mdc](.cursor/rules/auth-feature.mdc) — the auth folder is intentionally flat.
