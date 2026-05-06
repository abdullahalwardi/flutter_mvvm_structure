import 'package:app/data/models/authentication_model.dart';
import 'package:app/data/providers/authentication_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Notifies GoRouter only when routing inputs change (avoid rebuilding [GoRouter]).
final class RouterRefreshNotifier extends ChangeNotifier {
  RouterRefreshNotifier(this.ref) {
    _authSub = ref.listen(
      authenticationProvider,
      (_, _) => notifyListeners(),
    );
  }

  final Ref ref;
  late final ProviderSubscription<AuthenticationModel?> _authSub;

  @override
  void dispose() {
    _authSub.close();
    super.dispose();
  }
}
