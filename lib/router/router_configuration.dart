import 'package:app/data/providers/authentication_provider.dart';
import 'package:app/router/route_keys.dart';
import 'package:app/router/routes/app_routes.dart';
import 'package:app/utils/extensions.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

GoRouter configureRootRouter(
  Ref ref, {
  required Listenable refreshListenable,
}) {
  return GoRouter(
    navigatorKey: rootNavigatorKey,
    debugLogDiagnostics: kDebugMode,
    initialLocation: const HomeRoute().location,
    refreshListenable: refreshListenable,
    routes: $appRoutes,
    redirect: (BuildContext context, GoRouterState state) {
      final isSignedIn = ref.read(authenticationProvider.notifier).isSignedIn();
      final signingIn =
          state.matchedLocation == const SignInRoute().location ||
              state.uri.path == const SignInRoute().location;

      if (!isSignedIn) {
        if (!signingIn) {
          return const SignInRoute().location;
        }
        return null;
      }

      if (signingIn) {
        return const HomeRoute().location;
      }
      return null;
    },
    errorBuilder: (BuildContext context, GoRouterState state) {
      return Scaffold(
        body: Center(
          child: Text(
            '${context.l10n.defaultErrorMessage}${state.error != null ? ': $state.error' : ''}',
            textAlign: TextAlign.center,
          ),
        ),
      );
    },
  );
}
