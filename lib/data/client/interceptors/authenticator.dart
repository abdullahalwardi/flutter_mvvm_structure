import 'package:app/src/auth/authentication_provider.dart';
import 'package:dio/dio.dart';

class Authenticator extends Interceptor {
  final AuthenticationNotifier _authenticationNotifier;

  Authenticator(
    this._authenticationNotifier,
  );

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final String? token =
        _authenticationNotifier.preference.maybeData()?.token;

    if (token != null) options.headers["Authorization"] = "Bearer $token";

    super.onRequest(options, handler);
  }
}
