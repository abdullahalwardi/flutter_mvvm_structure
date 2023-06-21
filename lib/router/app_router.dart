import 'package:app/src/home/home_page.dart';
import 'package:go_router/go_router.dart';

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