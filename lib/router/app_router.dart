import 'package:app/src/auth/authentication_provider.dart';
import 'package:app/src/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod/riverpod.dart';

// GoRouter configuration
final goRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
          debugLogDiagnostics: true,
          initialLocation: RoutesDocument.home,
          routes: [
            GoRoute(
              path: RoutesDocument.home,
              builder: (context, state) => const HomePage(),
            ),
          
          
          
          ],
            redirect: (BuildContext context, GoRouterState state) {
            if (ref.read(authenticationProvider.notifier).isNotSignedIn()) {
              return RoutesDocument.home;
            } else {
              return null;
            }
          },
          // errorBuilder: (context, state) => ErrorScreen(state.error),
        );
});

class RoutesDocument {
  const RoutesDocument._();
  static const String home = '/home';
}