import 'package:app/constants/api_document.dart';
import 'package:app/data/client/interceptors/authenticator.dart';
import 'package:app/src/auth/authentication_provider.dart';
import 'package:awesome_dio_interceptor/awesome_dio_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dioProvider = Provider<Dio>(
    (ref) => _dioProvider(ref.read(authenticationProvider.notifier)));

  Dio _dioProvider(AuthenticationNotifier authenticationNotifier) {
  final dio = Dio();
  dio
    ..options.baseUrl = ApiDocument.baseUrl
    ..options.connectTimeout = const Duration(seconds: 120)
    ..options.receiveTimeout = const Duration(seconds: 120)
    ..options.contentType = 'application/json; charset=utf-8'
    ..options.headers = {
      "accept": "text/plain",
      "Content-Type": "application/json"
    }
    ..interceptors.add(Authenticator(authenticationNotifier))
    ..interceptors
        .add(InterceptorsWrapper(onError: (DioError e, handler) async {
      if (e.response?.statusCode == 401) {
        authenticationNotifier.logout();
      }
      handler.next(e);
    }));

    if (kDebugMode) dio.interceptors.add(AwesomeDioInterceptor());

  return dio;
}
