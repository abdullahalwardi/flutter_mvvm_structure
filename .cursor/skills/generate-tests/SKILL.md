---
name: generate-tests
description: Generate unit and widget tests for any feature, ensuring architecture compliance and localization coverage. Use when the user asks to add or update tests for lib/src/<feature>/ and related lib/data/providers/ code.
---

# Generate Tests

## Goal
Write or extend tests for a feature's provider notifiers and page widgets. Place all test files in the flat `test/` directory at the project root.

Architecture rule file: `.cursor/rules/architecture-layering.mdc`

## Test file layout

This project currently has a flat `test/` directory. Follow this convention:

```
test/
  <feature>_provider_test.dart     # notifier / state tests
  <feature>_page_test.dart         # widget / page tests
```

Real existing test files for reference:
- `test/message_parser_test.dart`
- `test/widget_test.dart`

Do **not** create `test/features/<feature>/` subdirectories — keep tests flat at `test/`.

## Provider / notifier tests (`<feature>_provider_test.dart`)

### What to cover
- Initial state is correct (`build()` returns expected value).
- Each public notifier method transitions state correctly (loading → data, loading → error).
- Error paths are surfaced as `AsyncError`, not swallowed.
- Mocks for clients (or repositories when the domain has one).

### Skeleton
```dart
import 'package:elixir/data/providers/<domain>_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class Mock<Domain>Client extends Mock implements <Domain>Client {}

void main() {
  late ProviderContainer container;
  late Mock<Domain>Client mockClient;

  setUp(() {
    mockClient = Mock<Domain>Client();
    container = ProviderContainer(
      overrides: [
        <domain>ClientProvider.overrideWithValue(mockClient),
      ],
    );
  });

  tearDown(() => container.dispose());

  group('<FeatureNotifier>', () {
    test('initial state is AsyncData([])', () {
      final state = container.read(<featureNotifier>Provider);
      expect(state, const AsyncData([]));
    });

    test('load() sets AsyncLoading then AsyncData', () async {
      when(() => mockClient.fetchSomething())
          .thenAnswer((_) async => FutureApiResponse(data: []));

      final notifier = container.read(<featureNotifier>Provider.notifier);
      await notifier.load();

      expect(container.read(<featureNotifier>Provider), isA<AsyncData>());
    });

    test('load() surfaces AsyncError when client throws', () async {
      when(() => mockClient.fetchSomething()).thenThrow(Exception('network'));

      final notifier = container.read(<featureNotifier>Provider.notifier);
      await notifier.load();

      expect(container.read(<featureNotifier>Provider), isA<AsyncError>());
    });
  });
}
```

## Widget / page tests (`<feature>_page_test.dart`)

### What to cover
- Critical UI elements render (primary CTA, title, key list items).
- Loading state shows a skeleton/placeholder (not `CircularProgressIndicator` for full-screen).
- Error state shows an error widget.
- All user-facing text comes from localization (no hardcoded strings in widgets; verify via `find.text(l10n.someKey)`).
- Key user interactions trigger the expected notifier method.

### Skeleton
```dart
import 'package:elixir/data/providers/<domain>_provider.dart';
import 'package:elixir/src/<feature>/<feature>_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

Widget makeTestable(List<Override> overrides) {
  return ProviderScope(
    overrides: overrides,
    child: const MaterialApp(home: <Feature>Page()),
  );
}

void main() {
  testWidgets('shows skeleton while loading', (tester) async {
    await tester.pumpWidget(
      makeTestable([
        <featureNotifier>Provider.overrideWith(
          (_) => const AsyncLoading(),
        ),
      ]),
    );
    expect(find.byType(SkeletonWidget), findsWidgets);
  });

  testWidgets('shows data when AsyncData', (tester) async {
    await tester.pumpWidget(
      makeTestable([
        <featureNotifier>Provider.overrideWith(
          (_) => AsyncData([/* sample items */]),
        ),
      ]),
    );
    await tester.pump();
    expect(find.byType(<Feature>Page), findsOneWidget);
  });
}
```

## Localization checks
- All user-facing text must use `context.l10n.*` keys — never hardcoded strings.
- In tests, verify text via localisation: instantiate the `AppLocalizations` delegate and assert `find.text(l10n.someKey)`.

## Architecture compliance in tests
- Tests mock at the **client layer** (default) or **repository layer** (when a repository exists for the domain).
- Never mock at the Dio/HTTP level in unit tests — mock the Retrofit client interface.
- Provider overrides in widget tests must use the same `*Provider` identifiers as the real app.

## Running tests
```
flutter test
```

## Completion checklist
- [ ] `test/<feature>_provider_test.dart` created/updated
- [ ] `test/<feature>_page_test.dart` created/updated
- [ ] Initial state covered
- [ ] Loading/success/error state transitions covered
- [ ] Key UI elements and interactions covered
- [ ] No hardcoded UI strings — localization verified
- [ ] Mocks at correct layer (client or repository)
- [ ] All tests pass with `flutter test`
