# build-ui

Generate UI from design **without** Swagger/API integration: layout, `AppTheme`, localization, and dumb widgets.

## Output layout (this repo)

- **Do not** use `lib/src/**/presentation/screens/` or `presentation/widgets/`.
- Put each **user-facing flow** in its own feature folder (flat layout):

  - `lib/src/<feature>/<feature>_page.dart`
  - `lib/src/<feature>/components/` for feature-local building blocks

- **Auth-related:** do not place shared OTP or create-account screens under `lib/src/login/`. Use `lib/src/otp_verification/` and `lib/src/create_account/` (see `Rule-Auth-Flow-Feature-Folders.mdc`).

## State (no API)

- Use Riverpod codegen in `lib/data/providers/` (same domain file, e.g. `authentication_provider.dart`), not a parallel `viewmodels/` folder.
- Mock phases only; **TODO** for repository/API.

## Routing

- Add routes in `lib/router/app_router.dart` via `RoutesDocument`.
- Names must reflect the **screen** (e.g. `otpVerification`, `createAccount`), not a single parent flow (`loginOtp`).
- Reusable flows: typed `GoRouterState.extra` (see `lib/router/otp_verification_route_args.dart`).

## Theme and l10n

- Only `AppTheme` tokens; extend `app_theme.dart` when needed.
- All strings via `context.l10n.*` and ARB updates.
- Layout direction follows **app locale** only.

## Quality bar

- No hardcoded colors/`TextStyle` in UI.
- No API/repository calls from widgets.
- Enums in `lib/data/models/enums.dart` when shared.
