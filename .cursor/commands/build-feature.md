# build-feature

Build a complete feature from API to UI following project architecture.

**Skills:** `.cursor/skills/create-feature-module/SKILL.md`, `.cursor/skills/integrate-api-feature/SKILL.md`

## Steps

1. Use **feature-builder** to scaffold `lib/src/<feature>/` (flat: `<feature>_page.dart` + `components/`).
2. Use **data-layer-engineer** to:
   - Add Retrofit client in `lib/data/services/clients/<domain>_client.dart`.
   - Define models in `lib/data/models/` (Freezed).
   - Update `lib/data/providers/<domain>_provider.dart` — call client directly by default; use repository only if one already exists for the domain.
3. Connect UI to the provider (`ref.watch` / `ref.read(...notifier)`).
4. Ensure proper state handling (loading, success, error) — loading uses skeleton placeholders from `lib/utils/widgets/skeletons/` or `lib/utils/widgets/place_holders/`.
5. Register route in `RoutesDocument` + `GoRouter` in `lib/router/app_router.dart`.
6. Run code generation: `dart run build_runner build --delete-conflicting-outputs`.
7. Use **architecture-guardian** to validate structure.
8. Use **refactor-agent** to clean and align code.
