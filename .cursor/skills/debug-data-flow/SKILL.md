---
name: debug-data-flow
description: Traces and debugs data flow across layered architecture boundaries. Use when data is incorrect in UI, provider state looks wrong, mapping issues are suspected, or errors are swallowed between UI, lib/data/providers, and Client layers.
---

# Debug Data Flow

## Goal
Find where bad data or broken state first appears in the data flow, then suggest the smallest fix that preserves architecture boundaries.

Architecture rule file: `.cursor/rules/architecture-layering.mdc`

## Data flow to trace

**With repository (posts, user, attachment, notifications domains):**
```
UI -> Provider -> Repository -> Client -> HTTP
```

**Without repository (all other domains — the common case):**
```
UI -> Provider -> Client -> HTTP
```

Identify which path applies before starting — look for a matching `*_repository.dart` in `lib/data/repositories/`.

## Debug checklist
```
- [ ] 1) Reproduce and define expected vs actual behaviour
- [ ] 2) Trace UI inputs and provider/notifier method calls
- [ ] 3) Inspect provider state transitions
- [ ] 4) Trace Client request / response (skip Repository step if domain has no repository)
- [ ] 5) Validate API model -> UI state mapping
- [ ] 6) Pinpoint the first incorrect value / state
- [ ] 7) Propose minimal architecture-safe fix
```

## Step-by-step

### 1) Reproduce the issue
- Record exact trigger path and user action sequence.
- Write one-line expected result and one-line actual result.
- Do not fix anything until the origin is identified.

### 2) Trace from UI to provider
- Confirm UI only triggers notifier actions (`ref.read(...notifier).method()`).
- Verify arguments passed from UI are complete and valid.
- Flag any business logic in widgets as a violation (see `ui-feature-layout.mdc`).

### 3) Check provider state transitions
- Follow state lifecycle (`AsyncLoading`, `AsyncData`, `AsyncError`, or equivalent).
- Validate transition order and edge cases (empty data, retries, refresh).
- Confirm state mutation happens only in notifiers under `lib/data/providers/`.

### 4) Trace Client (and Repository if applicable)

**No repository:** provider calls client → check `ref.read(<domain>ClientProvider)` call directly.

**With repository:** confirm provider calls repository (not client); then check repository → client chain.

- Verify request params, response contract, and status/error mapping.
- Ensure low-level failures are converted into predictable state before reaching the provider.

### 5) Validate model mapping
- Compare API model fields with UI state fields one-by-one.
- Check type conversions, enum/string mapping, date formatting, nullability, and defaults.
- Confirm UI receives only UI-friendly types, never raw API DTOs.

### 6) Identify first bad value
- Mark the earliest layer where the value/state becomes incorrect.
- Distinguish source issue (wrong data from API) vs transformation issue (bad mapping/state update).

### 7) Suggest minimal fix
- Prefer a one-layer fix at the true origin point.
- Do not add workarounds at a different layer than the root cause.
- Do not introduce new abstraction layers.
- Verify the fix does not break adjacent state or flows.

## Common patterns and their origin layers

| Symptom | Likely origin |
|---|---|
| `AsyncError` in provider, no UI error shown | Provider catch block swallowing the error |
| Stale data after action | `ref.invalidate` or `ref.refresh` missing after mutation |
| Wrong field value in UI | Mapping in provider (or repository) — check field name alignment with API model |
| Null where data expected | Nullable API field not handled in mapping |
| UI triggers action but nothing happens | Notifier method not called, or state assignment missing |
| API returns 200 but provider stays loading | `AsyncValue.guard` missing, or `.data` not awaited |
