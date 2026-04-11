---
name: generate-tests
description: Automatically generates unit and widget tests for any feature, including Cursor-generated features, ensuring architecture compliance, localization coverage, and optional Figma fidelity checks. Use when the user asks to add or update tests for `lib/src/<feature>/` and related `lib/data/providers/` code.
---

# Generate Tests

## Purpose
Automatically generate consistent, runnable unit and widget tests for a feature module while enforcing architecture boundaries, localization usage, and optional Figma fidelity checks.

Required layered flow:

`UI -> Provider -> Repository -> Client (lib/data/services/clients) -> HTTP`

## Instructions
1. Identify the feature UI under `lib/src/<feature>/` and the providers it uses under `lib/data/providers/`.
2. Create corresponding test files under `test/features/<feature>/`:
   - `<feature>_provider_test.dart` (unit tests for notifier logic; name after the main provider under test)
   - `<feature>_page_test.dart` (widget test for the entry `*Page`)
3. Unit tests (`<feature>_provider_test.dart`):
   - Test initial state.
   - Test loading, success, and error states.
   - Mock all repository (and thus client) calls using `mockito`.
   - Ensure API models are not leaked to UI-facing state/assertions.
4. Widget tests (`<feature>_page_test.dart`):
   - Verify the page renders correctly.
   - Verify existence of key widgets (buttons, text fields, and primary controls).
   - Verify localized text presence through localization output (`context.l10n.*`-backed strings), not hardcoded UI text.
   - Simulate interactions where possible (tap, input, submit, navigation intent).
5. Include setup for Figma fidelity checks (optional):
   - Verify layout matches expected structure.
   - Verify colors, typography, and spacing follow theme/design tokens.
6. Ensure tests are isolated and do not make real API calls.
7. Ensure tests run with `flutter test` without manual modifications.

## Output Paths
For each target feature:
- `test/features/<feature>/<feature>_provider_test.dart` (or match domain file e.g. `authentication_provider_test.dart`)
- `test/features/<feature>/<feature>_page_test.dart` (e.g. `login_page_test.dart` for `lib/src/login/login_page.dart`)

## Mandatory Rules
- Keep tests isolated; never make real API calls.
- Mock repository dependencies with `mockito`.
- Verify provider/notifier state transitions: initial, loading, success, error.
- Ensure UI tests validate localized text usage (`context.l10n.*` outputs), not hardcoded copies.
- Prevent API model leakage into UI-facing assertions; assert feature/view state only.
- Keep widget tests focused on rendering + interactions, not business logic internals.
- Ensure tests run with `flutter test` without manual edits.

## Implementation Workflow
1. Identify target feature path in `lib/src/<feature>/` and related `lib/data/providers/*.dart`.
2. Inspect existing tests/patterns in `test/features/` and mirror naming/style.
3. Create/update provider unit tests:
   - Build notifier with mocked repository dependencies.
   - Test initial state.
   - Test loading state before async completion.
   - Test success state after mocked success response.
   - Test error state after mocked failure/exception.
   - Verify repository calls and interaction counts.
   - Assert exposed state uses feature-facing models only.
4. Create/update `test/features/<feature>/<feature>_page_test.dart`:
   - Pump feature page with required providers/router wrappers.
   - Verify primary widgets exist (buttons, text fields, key containers).
   - Verify localized strings are rendered through app localization setup.
   - Simulate key user interactions (tap, enter text, submit) and assert resulting UI/state changes.
5. Optional Figma fidelity checks (when design constraints are requested):
   - Assert expected layout structure/hierarchy exists.
   - Assert themed colors/typography/spacing usage (tokens/theme values, not hardcoded values).
6. Run and stabilize tests:
   - `flutter test test/features/<feature>/`
   - If needed, run `flutter test` for full-suite compatibility.

## Provider unit test template expectations
- **Setup**: `setUp`, mocks, fake/stub responses, provider container initialization.
- **Initial**: state matches default expected value.
- **Loading**: state enters loading immediately after action trigger.
- **Success**: data/state reflects transformed domain/feature model.
- **Error**: state contains normalized error representation.
- **Isolation**: no network/disk side effects.

## Page widget test template expectations
- **Bootstrapping**: wrap with `MaterialApp`/router + localization delegates + providers.
- **Rendering**: page builds without exceptions.
- **Key elements**: required controls appear and are interactable.
- **Localization**: asserts for localized outputs from l10n resources.
- **Interaction**: user gestures produce expected UI updates/navigation intents.

## Figma Fidelity Checks (Optional)
Use only when visual fidelity is part of acceptance criteria.

- Validate component hierarchy/section ordering.
- Validate typography style usage from theme tokens.
- Validate color usage via theme/design tokens.
- Validate spacing/layout constraints using expected paddings/sized boxes/flex behavior.

## Validation Checklist
- [ ] Feature module identified in `lib/src/<feature>/` and providers in `lib/data/providers/`
- [ ] Test files exist under `test/features/<feature>/` with required names
- [ ] Provider tests cover initial/loading/success/error
- [ ] Dependencies mocked with `mockito`
- [ ] No real API calls
- [ ] No API models asserted in UI layer tests
- [ ] Page/widget tests cover render + key widgets + localization + interactions
- [ ] Optional Figma/token checks added when requested
- [ ] `flutter test` passes for affected scope
