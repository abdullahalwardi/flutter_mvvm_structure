import 'package:app/data/client/services/auth/auth_service.dart';
import 'package:app/data/client/services/callback.dart';
import 'package:riverpod/riverpod.dart';

final loginProvider = FutureProvider.autoDispose<ApiResponse<dynamic>>(
  (ref) async {
    final loginRequest = ref.watch(loginRequestStateProvider);
    final authService = ref.read(authServiceProvider);
    return await authService.login(body: loginRequest);
  },
);

final loginRequestStateProvider = StateProvider.autoDispose<dynamic>(
    (ref) => "");

