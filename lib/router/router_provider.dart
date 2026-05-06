import 'package:app/router/router_configuration.dart';
import 'package:app/router/router_refresh_notifier.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'router_provider.g.dart';

/// Root router; stable instance — auth/onboarding deltas go through [refreshListenable].
@Riverpod(keepAlive: true)
GoRouter router(Ref ref) {
  final refreshListenable = RouterRefreshNotifier(ref);
  ref.onDispose(refreshListenable.dispose);

  return configureRootRouter(
    ref,
    refreshListenable: refreshListenable,
  );
}
