import 'dart:convert';

import 'package:app/data/providers/authentication_provider.dart';
import 'package:app/utils/constants/api_document.dart';
import 'package:app/data/client/interceptors/authenticator.dart';
import 'package:app/router/app_router.dart';
import 'package:app/utils/snackbar.dart';
import 'package:awesome_dio_interceptor/awesome_dio_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

part 'dio_module.g.dart';

final dioProvider = Provider<Dio>((ref) => _dio(
    ref.read(authenticationProvider.notifier), ref.read(goRouterProvider)));

Dio _dio(
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
        onRequest: (options, handler) =>
          options.method != 'GET' && (options.data == null || options.data is Map<String, dynamic> && options.data.isEmpty) && options.queryParameters.isEmpty
              ? handler.reject(DioError(
                  requestOptions: options,
                  error: "No data found",
                  type: DioErrorType.cancel,
                ))
              : handler.next(options),
      onError: (e, handler) async {
        if (e.response?.statusCode == 401) {
          authenticationNotifier.logout();
          router.pushReplacement(RoutesDocument.home);
        }
          switch (e.type) {
    case DioErrorType.badCertificate:
      Utils.showErrorSnackBar("حدث خطأ ما");
      break;
    case DioErrorType.badResponse:
      debugPrint(e.error.toString());
              String message = "حدث خطأ ما";
              if (e.error is FormatException) {
                message = e.error
                    .toString()
                    .replaceRange(0, 54, "")
                    .replaceAll("^", "")
                    .replaceAll("\n", "");
              } else if (e.response?.data is String) {
                message = e.response?.data;
              } else {
                message = e.response?.data['message'] ?? message;
              }
              Utils.showErrorSnackBar(e.response?.data ?? "حدث خطأ ما");
      break;
    case DioErrorType.cancel:
      debugPrint(e.message);
      break;
    case DioErrorType.connectionError:
    case DioErrorType.connectionTimeout:
    case DioErrorType.receiveTimeout:
    case DioErrorType.sendTimeout:
      Utils.showErrorSnackBar("حدث خطأ في الاتصال");
      break;
    case DioErrorType.unknown:
      String message = "حدث خطأ ما";
      if (e.error is FormatException) {
        message = e.error.toString().replaceRange(0, 54, "").replaceAll("^", "");
      } else {
        final data = e.response?.data;
        if (data is Map<String, dynamic>) {
          message = data['message'] ?? message;
        } else if (data is String) {
          message = json.decode(json.encode(data));
        }
      }
      final parsedResponse = Response(
        requestOptions: e.requestOptions,
        data: {
          "data": {},
          "message": message,
          "statusCode": 400,
        },
        statusMessage: e.message,
      );
      Utils.showErrorSnackBar(message);
      handler.reject(
        DioError(
          requestOptions: e.requestOptions,
          response: parsedResponse,
          error: message,
          type: DioErrorType.unknown,
        ),
      );
      return; // add this line to prevent calling handler.next(e)
  }
  handler.next(e);
      },
        onResponse: (response, handler) {
        dynamic data = response.data;
        if (response.data is List<dynamic>) {
          data = {
            "data": response.data,
            "message": response.statusMessage,
            "statusCode": response.statusCode
          };
        } else if (data is Map<String, dynamic> &&
            (data['data'] == null ||
                data['message'] == null ||
                data['statusCode'] == null)) {
          data['data'] ??= {}; // Set result to an empty object if it's null
          data["message"] ??= response.statusMessage;
          data["statusCode"] ??= response.statusCode;
        }else if (response.data is String) {
            data = {
              "data": {},
              "message": response.data,
              "statusCode": response.statusCode
            };
          }
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
      },
      ),
    );

  if (kDebugMode) dio.interceptors.add(AwesomeDioInterceptor());

  return dio;
}
