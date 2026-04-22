# build-ui

Generate UI from a design without Swagger/API integration: layout, `AppTheme`, localization, and dumb widgets.

**Rule files:** `.cursor/rules/ui-feature-layout.mdc`, `.cursor/rules/ui-polish.mdc`, `.cursor/rules/routing.mdc`, `.cursor/rules/auth-feature.mdc`

## Output layout

- Do **not** use `presentation/screens/`, `presentation/widgets/`, or `viewmodels/` subfolders.
- Each user-facing flow gets its own flat feature folder:
  - `lib/src/<feature>/<feature>_page.dart`
  - `lib/src/<feature>/components/` — feature-local building blocks

**Auth pages:** use the existing flat `lib/src/auth/` folder. Do **not** create `lib/src/login/`, `lib/src/otp_verification/`, or `lib/src/create_account/`.

Real auth pages: `signin_page.dart`, `signup_page.dart`, `verify_page.dart`, `forget_password_page.dart`, `reset_password_page.dart`, `use_forget_password_page.dart`, `change_email_page.dart`, `change_phone_page.dart`.

## State (no API yet)

- Use Riverpod codegen in `lib/data/providers/<domain>_provider.dart` — not a `viewmodels/` folder.
- Add TODO comments for repository/API wiring.

## Routing

- Add routes in `lib/router/app_router.dart` via `RoutesDocument`.
- Route names must describe **the screen** — not a specific parent flow.
- Existing route names (use, don't duplicate): `signin`, `signup`, `verify`, `forgetPassword`, `resetPassword`, `useForgetPassword`, `changeEmail`, `changePhone`, `home`, `account`, `posts`, `search`, `notifications`, `inbox`, `cart`, `wallet`, etc.
- For reusable flows, pass typed `GoRouterState.extra`.

## Theme and l10n

- Only `AppTheme` tokens from `lib/theme/app_theme.dart` — extend the file with new semantic tokens when needed.
- All user-facing strings via `context.l10n.*`; add missing keys to `lib/l10n/app_en.arb`, `app_ar.arb`, `app_ku.arb`.
- Layout direction follows **app locale only** — no per-widget `Directionality` based on text.

## Loading placeholders

- Full-screen / section loading: use skeletons from `lib/utils/widgets/skeletons/` or named placeholders from `lib/utils/widgets/place_holders/`.
- Not `CircularProgressIndicator` for full-screen loads.

## Quality bar

- No hardcoded `TextStyle`, `Color`, or route strings in UI.
- No API/repository calls from widgets.
- Enums in `lib/data/models/enums.dart`.
- Monetary values formatted with `splitMoney(...)`.
- No raw IDs displayed in UI.
- Check `assets/svg/` before using Flutter's `Icons` library.
