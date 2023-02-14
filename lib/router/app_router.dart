import 'package:app/src/home/home_page.dart';
import 'package:go_router/go_router.dart';

// GoRouter configuration
class AppRouter extends GoRouter {
  AppRouter()
      : super(
          debugLogDiagnostics: true,
          initialLocation: "/",
          routes: [
            GoRoute(
              path: '/',
              builder: (context, state) => const HomePage(),
            ),
          ],

          // redirect: (BuildContext context, GoRouterState state) {
          //   if (AuthState.of(context).isSignedIn) {
          //     return '/signin';
          //   } else {
          //     return null;
          //   }
          // },
          
          // errorBuilder: (context, state) => ErrorScreen(state.error),
        );
}
