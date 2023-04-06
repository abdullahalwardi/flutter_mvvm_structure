import 'package:app/utils/constants/api_document.dart';
import 'package:app/data/client/interceptors/authenticator.dart';
import 'package:app/router/app_router.dart';
import 'package:app/src/auth/authentication_provider.dart';
import 'package:app/utils/snackbar.dart';
import 'package:awesome_dio_interceptor/awesome_dio_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final dioProvider = Provider<Dio>((ref) => _dioProvider(
    ref.read(authenticationProvider.notifier), ref.read(goRouterProvider)));

Dio _dioProvider(
    AuthenticationNotifier authenticationNotifier, GoRouter router) {
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
    ..interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          if (options.method != 'GET' && options.data == null) {
            return;
          } else {
            return handler.next(options);
          }
        },
        onError: (DioError e, handler) async {
          if (e.response?.statusCode == 401) {
            authenticationNotifier.logout();
            router.pushReplacement(RoutesDocument.home);
            final message = e.response!.data['message'];
            Utils.showErrorSnackBar(message);
          }
          handler.next(e);
        },
        onResponse: (response, handler) {
          if (response.data is Map<String, dynamic>) {
            final data = response.data as Map<String, dynamic>;
            if (data['result'] == null) {
              data['result'] = {}; // Set result to an empty object if it's null
              final modifiedResponse = Response(
                requestOptions: response.requestOptions,
                data: data,
                headers: response.headers,
                isRedirect: response.isRedirect,
                redirects: response.redirects,
                extra: response.extra,
                statusCode: response.statusCode,
                statusMessage: response.statusMessage,
              );
              return handler.next(modifiedResponse);
            } else {
              return handler.next(response);
            }
          }
        },
      ),
    );

  if (kDebugMode) dio.interceptors.add(AwesomeDioInterceptor());

  return dio;
}
