import 'package:app/data/services/local_services.dart';
import 'package:app/src/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final Provider<GoRouter> routerProvider = Provider((ref) => router);

final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _shellNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'shell');

// GoRouter configuration
final router = GoRouter(
  debugLogDiagnostics: true,
  initialLocation: RoutesDocument.home,
  navigatorKey: _rootNavigatorKey,
  routes: [
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: RoutesDocument.home,
      builder: (context, state) => const HomePage(),
    ),
    // ShellRoute(
    //   navigatorKey: _shellNavigatorKey,
    //   builder: (BuildContext context, GoRouterState state, Widget child) {
    //     return PharmacyEntryPoint(child: child);
    //   },
    //   routes: <RouteBase>[
    //     GoRoute(
    //       parentNavigatorKey: _shellNavigatorKey,
    //         path: RoutesDocument.pharmacyHome,
    //         builder: (context, state) => const PharmacyHomePage(),
    //         routes: [
    //           GoRoute(
    //             path: RoutesDocument().productDetails(':id'),
    //             builder: (context, state) => ProductDetailsPage(
    //               id: Uri.decodeComponent(state.pathParameters['id']!),
    //             ),
    //           ),
    //         ]),
    //     GoRoute(
    //       path: RoutesDocument.pharmacyOrders,
    //       builder: (context, state) => const PharmacyOrdersPage(),
    //       parentNavigatorKey: _shellNavigatorKey,
    //     ),
    //     GoRoute(
    //       path: RoutesDocument.pharmacyCart,
    //       builder: (context, state) => const PharmacyCartPage(),
    //       parentNavigatorKey: _shellNavigatorKey,
    //     ),
    //     GoRoute(
    //       path: RoutesDocument.pharmacyAccount,
    //       builder: (context, state) => const PharmacyAccountPage(),
    //       parentNavigatorKey: _shellNavigatorKey,
    //     ),
    //   ],
    // ),
  ],
);

class RoutesDocument {
  const RoutesDocument._();
  static const String home = '/';
  static const String login = '/login';

  // // Product
  // static String productDetails(String id) => 'product-details/$id';
}

  // final encodedItemId = getEncodedComponent(item.id);
  // context.push(
  //     "${RoutesDocument.pharmacyHome}/${RoutesDocument.productDetails(encodedItemId)}");
