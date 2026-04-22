---
name: refactor-to-architecture
description: Refactor existing code to strictly match the project's architecture rules and layered flow. Use when the user asks to refactor, clean up layering, move logic between UI/providers/client, remove parallel implementations, or enforce architecture compliance.
---

# Refactor To Architecture

## Goal
Refactor existing code so it strictly follows project architecture and naming/structure conventions without changing behaviour.

Architecture rule file: `.cursor/rules/architecture-layering.mdc`  
Feature layout rule file: `.cursor/rules/ui-feature-layout.mdc`

## Canonical flow
```
UI (lib/src/<feature>/) -> Provider (lib/data/providers/<domain>_provider.dart)
  -> [default]  Client (lib/data/services/clients/<domain>_client.dart)
  -> [when repo exists]  Repository -> Client
```

## What counts as a violation (and what does not)

### Real violations — must fix
| Violation | Why it breaks architecture |
|---|---|
| UI calling a Retrofit client or datasource directly | Skips provider layer |
| UI importing `lib/data/models/` types into widget files | API model leaks into UI |
| Provider calling a datasource directly (when a repository exists for that domain) | Skips repository layer |
| Provider bypassing an existing repository to call a client directly (only for domains with a repo: posts, user, attachment, notifications) | Inconsistent layer usage |
| `viewmodels/`, `presentation/`, `screens/` folders under `lib/src/<feature>/` | Violates flat feature layout |
| Feature importing from another feature folder | Breaks feature isolation |
| Parallel implementations of the same logic | Creates drift |

### Not violations — these are correct patterns
| Pattern | Why it is fine |
|---|---|
| Provider calls a Retrofit client directly (for domains without a repository) | This is the default path |
| Multiple `@riverpod` notifiers in one `*_provider.dart` file | Endorsed by architecture |
| Feature-local `models/` folder under `lib/src/<feature>/` | Allowed for UI-specific shapes |

## Refactor workflow

1. **Identify violations** in the changed scope using the table above.
2. **Inspect existing correct patterns** in `lib/data/providers/` and feature folders; mirror them exactly.
3. **Refactor UI layer:** keep pages and components presentational; replace direct logic with notifier method calls and provider state reads.
4. **Refactor provider layer:** keep orchestration and state in `lib/data/providers/`; call client (default) or repository (when applicable).
5. **Refactor client/datasource boundaries:** keep Retrofit clients stateless and API-focused; datasources low-level.
6. **Remove duplicate paths** and keep one canonical implementation.
7. **Run code generation** when annotations or generated providers/models are affected.
8. **Verify** architecture and lint cleanliness in all edited files.

## Decision rules
- Extend before create: reuse existing client/provider when possible.
- Shared logic across features → move to `lib/data/` or `lib/utils/`, not cross-feature imports.
- Preserve existing router-based navigation patterns; avoid route magic strings in UI.

## Validation checklist
- [ ] UI is presentational-only (no business logic, no API calls, no raw API model imports)
- [ ] Providers contain orchestration and call client (default) or repository (when domain has one)
- [ ] Clients/datasources remain stateless/low-level
- [ ] API models are not consumed directly by UI
- [ ] No direct feature-to-feature dependency
- [ ] No duplicate or parallel implementation remaining
- [ ] `lib/src/<feature>/` uses flat layout + `components/` + `*_page.dart`; providers in `lib/data/providers/`
- [ ] No new abstraction layers introduced
- [ ] Codegen run if required
- [ ] Lints clean for changed files
