import 'package:app/data/providers/authentication_provider.dart';
import 'package:dio/dio.dart';

class Authenticator extends Interceptor {
  final Authentication authentication;
  Authenticator(
     
       this.authentication,
     
  );

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final isSignedIn = authentication.isSignedIn();
    final token = authentication.build()?.token;

    if (isSignedIn) options.headers["Authorization"] = "Bearer $token";

    super.onRequest(options, handler);
  }
}
