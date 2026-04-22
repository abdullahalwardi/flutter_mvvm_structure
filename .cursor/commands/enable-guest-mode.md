# enable-guest-mode

Description:
Add guest mode support to a feature or entire project, allowing partial access without authentication while protecting restricted features.

Instructions:

1. AUTH STATE MODEL

* Create or extend AuthState:

  * isAuthenticated
  * isGuest

2. ACCESS CONTROL LAYER

* Define access rules per feature:

  * guest-accessible
  * auth-required

3. ROUTING GUARDS

* If user is guest and tries to access protected screen:

  * redirect to `RoutesDocument.signin` (never hardcode `/signin` string in UI)
  * or show auth-required UI (see `lib/utils/widgets/dialogs/signin_warning_dialog.dart` for an existing example)

4. UI BEHAVIOR

* Guest-accessible features:

  * work normally with mock or limited data
* Auth-required features:

  * show locked state OR redirect

5. PROVIDER HANDLING

* Inject AuthState into relevant `lib/data/providers/` notifiers (via `ref.read`)
* Add guards:
  if (!authState.isAuthenticated) → block action

6. CTA STRATEGY

* Show prompts like:

  * "Login to continue"
  * "Create account to unlock feature"

7. DATA RULES

* Do not call protected APIs in guest mode
* Use fallback/mock data if needed

8. NAVIGATION

* Allow free navigation for public features
* Restrict navigation for private ones

9. CLEAN ARCHITECTURE

* Do not mix auth logic inside UI widgets
* Keep it in:

  * Providers (`lib/data/providers/`) — notifier guards using `ref.read(authenticationProvider)`
  * GoRouter redirect callbacks in `lib/router/app_router.dart`

10. TESTING

* Test both:

  * guest flow
  * authenticated flow
