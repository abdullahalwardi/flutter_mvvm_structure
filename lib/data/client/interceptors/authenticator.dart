import 'package:app/src/auth/authentication_provider.dart';
import 'package:dio/dio.dart';

class Authenticator extends Interceptor {
  final AuthenticationNotifier _authenticationNotifier;

  Authenticator(
    this._authenticationNotifier,
  );

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final isSignedIn = _authenticationNotifier.isSignedIn();
    final isNotSignedIn = _authenticationNotifier.isNotSignedIn();
    final token = _authenticationNotifier.token;

    if (isSignedIn) options.headers["Authorization"] = "Bearer $token";
    if (isNotSignedIn) _authenticationNotifier.logout();

    super.onRequest(options, handler);
  }
}
