import 'package:app/src/home/home_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final Provider<GoRouter> routerProvider = Provider((ref) => router);

// GoRouter configuration
final router = GoRouter(
          debugLogDiagnostics: true,
          initialLocation: RoutesDocument.home,
          routes: [
            GoRoute(
              path: RoutesDocument.home,
              builder: (context, state) => const HomePage(),
            ),
          ],
        );

class RoutesDocument {
  const RoutesDocument._();
  static const String home = '/home';
}