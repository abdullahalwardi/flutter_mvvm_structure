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
          if (options.method != 'GET' && options.data == null ||
              options.data is Map<String, dynamic> &&
                  (options.data as Map<String, dynamic>).isEmpty) {
            if (options.queryParameters.isEmpty) {
              return handler.reject(
                DioError(
                  requestOptions: options,
                  error: "No data found",
                  type: DioErrorType.cancel,
                ),
              );
            } else {
              return handler.next(options);
            }
          } else {
            return handler.next(options);
          }
        },
        onError: (DioError e, handler) async {
          if (e.response?.statusCode == 401) {
            authenticationNotifier.logout();
            router.pushReplacement(RoutesDocument.home);
          }
             switch (e.type) {
            case DioErrorType.badCertificate:
              Utils.showErrorSnackBar("حدث خطأ ما");
              break;
            case DioErrorType.badResponse:
              Utils.showErrorSnackBar("حدث خطا ما");
              break;
            case DioErrorType.cancel:
              debugPrint(e.message);
              break;
            case DioErrorType.connectionError:
              Utils.showErrorSnackBar("حدث خطأ في الاتصال");
              break;
            case DioErrorType.connectionTimeout:
              Utils.showErrorSnackBar("حدث خطأ في الاتصال");
              break;
            case DioErrorType.receiveTimeout:
              Utils.showErrorSnackBar("حدث خطأ في الاتصال");
              break;
            case DioErrorType.sendTimeout:
              Utils.showErrorSnackBar("حدث خطأ في الاتصال");
              break;
            case DioErrorType.unknown:
            if(e.response != null){
              if (e.response!.data is String) {
                final data = e.response!.data as String;
                Utils.showErrorSnackBar(data);
              } else if (e.response!.data is Map<String, dynamic>) {
                final data = e.response!.data as Map<String, dynamic>;
                if (data['message'] != null) {
                  Utils.showErrorSnackBar(data['message']);
                }else{
                Utils.showErrorSnackBar("حدث خطأ ما");
              }
              }else{
                Utils.showErrorSnackBar("حدث خطأ ما");
              }
            }else{
              Utils.showErrorSnackBar("حدث خطأ ما");
            }
              
              break;
          }
          handler.next(e);
        },
        onResponse: (response, handler) {
          if (response.data is Map<String, dynamic>) {
            final data = response.data as Map<String, dynamic>;
            if (data['data'] == null ||
                data['message'] == null ||
                data['statusCode'] == null) {
              data['data'] ??= {}; // Set result to an empty object if it's null
              data["message"] ??= response.statusMessage;
              data["statusCode"] ??= response.statusCode;
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
          } else if (response.data is List<dynamic>) {
            final data = response.data as List<dynamic>;
            final modifiedResponse = Response(
              requestOptions: response.requestOptions,
              data: {
                "data": data,
                "message": response.statusMessage,
                "statusCode": response.statusCode
              },
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
        },
      ),
    );

  if (kDebugMode) dio.interceptors.add(AwesomeDioInterceptor());

  return dio;
}
