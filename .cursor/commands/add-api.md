# add-api

Integrate a new API endpoint into an existing feature.

**Skill:** `.cursor/skills/integrate-api-feature/SKILL.md`

## Steps

1. Add or extend the Retrofit client method in `lib/data/services/clients/<domain>_client.dart`.
2. Add/update API models in `lib/data/models/` (Freezed).
3. Update `lib/data/providers/<domain>_provider.dart`:
   - Default: call the client directly.
   - If domain has a repository (posts, user, attachment, notifications): call the repository instead.
4. If a repository is involved, update `lib/data/repositories/<domain>_repository.dart` with mapping and error normalisation.
5. Map API models to UI-facing state — never expose raw API DTOs to widgets.
6. Run code generation: `dart run build_runner build --delete-conflicting-outputs`.
7. Update UI in `lib/src/<feature>/` to consume the new provider state.
8. Use architecture-guardian to validate no layer violations.
