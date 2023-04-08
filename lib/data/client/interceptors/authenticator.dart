import 'package:app/data/providers/authentication_provider.dart';
import 'package:dio/dio.dart';

class Authenticator extends Interceptor {
  final AuthenticationNotifier _authenticationNotifier;

  Authenticator(
    this._authenticationNotifier,
  );

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final isSignedIn = _authenticationNotifier.isSignedIn();
    final token = _authenticationNotifier.token;

    if (isSignedIn) options.headers["Authorization"] = "Bearer $token";

    super.onRequest(options, handler);
  }
}
