---
name: debug-data-flow
description: Traces and debugs data flow across layered architecture boundaries. Use when data is incorrect in UI, provider state looks wrong, mapping issues are suspected, or errors are swallowed between UI, lib/data/providers, Repository, and Client layers.
---

# Debug Data Flow

## Goal

Find where bad data or broken state first appears in this path:

`UI -> Provider (lib/data/providers) -> Repository -> Client (lib/data/services/clients)`

Then suggest the smallest fix that preserves architecture boundaries.

## Workflow

Copy this checklist and work top to bottom:

```markdown
Debug Progress:
- [ ] 1) Reproduce and define expected vs actual behavior
- [ ] 2) Trace UI inputs and provider/notifier method calls
- [ ] 3) Inspect provider state transitions
- [ ] 4) Trace Repository request/response handling
- [ ] 5) Verify Client/API payload and error mapping
- [ ] 6) Validate API model -> feature model mapping
- [ ] 7) Pinpoint first incorrect value/state origin
- [ ] 8) Propose minimal architecture-safe fix
```

## Step-by-Step

### 1) Reproduce the issue

- Record exact trigger path and user action sequence.
- Write one-line expected result and one-line actual result.
- Avoid fixing anything until origin is identified.

### 2) Trace from UI to provider

- Confirm UI only triggers provider notifier actions.
- Verify arguments passed from UI are complete and valid.
- Flag any business logic in widgets as architecture violation.

### 3) Check provider state transitions

- Follow state lifecycle (`loading`, `data`, `error`, or equivalent).
- Validate transition order and edge cases (empty data, retries, refresh).
- Confirm state mutation happens only in notifiers under `lib/data/providers/`.

### 4) Trace Repository behavior

- Ensure provider calls Repository, not Client/DataSource directly.
- Check repository normalization: mapping, null/default handling, error shaping.
- Verify no UI-specific types or imports leak into Repository.

### 5) Verify Client and API boundaries

- Confirm Retrofit client performs API transport only (no business logic).
- Validate request params, response contract, and status/error mapping.
- Ensure low-level failures are converted into predictable repository-level errors.

### 6) Validate model mapping

- Compare API model fields with feature model fields one-by-one.
- Check conversions (types, enum/string mapping, dates, nullability, defaults).
- Confirm UI consumes feature models only, never raw API models.

### 7) Identify first bad value

- Mark the earliest layer where the value/state becomes incorrect.
- Distinguish source issue vs transformation issue:
  - Source issue: wrong data returned by API/client.
  - Transformation issue: correct input but bad mapping/state update.

### 8) Suggest minimal fix

- Prefer a one-layer fix at the true origin point.
- Do not add new layers or parallel implementations.
- Reuse existing repository/client/provider patterns before creating new code.

## Guardrails

- Keep flow strict: `UI -> Provider (lib/data/providers) -> Repository -> Client (lib/data/services/clients)`.
- No direct `UI -> Repository/Client` calls.
- No direct `Provider -> DataSource` calls.
- No business logic in UI widgets.
- Keep logs at boundaries: API call, mapping/error conversion, state transition.

## Output Format

Use this response structure:

```markdown
## Data Flow Findings
- Issue: <short issue statement>
- First bad layer: <UI|Provider|Repository|Client>
- Root cause: <source vs transformation + brief detail>

## Evidence
- Trigger path: <user action flow>
- Expected vs actual: <1 line each>
- State transitions observed: <sequence>
- Mapping check: <fields verified and mismatch>

## Minimal Fix
- Change location: <file/layer>
- Fix: <smallest architecture-safe adjustment>
- Why here: <why this is origin layer>

## Validation
- [ ] Re-run scenario
- [ ] Confirm corrected UI output
- [ ] Confirm provider transitions are correct
- [ ] Confirm error path still works
```

## When to Use

Use this skill when:

- UI shows incorrect values but API appears correct.
- Provider state gets stuck, skips, or regresses unexpectedly.
- Repository mapping may be dropping or mis-converting fields.
- Errors disappear, become generic, or surface at the wrong layer.
