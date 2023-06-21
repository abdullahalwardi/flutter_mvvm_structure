import 'package:app/data/client/http/dio_module.dart';
import 'package:app/data/client/services/callback.dart';
import 'package:app/utils/constants/api_document.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_service.g.dart';


@RestApi(baseUrl: '${ApiDocument.baseUrl}/Auth')
abstract class AuthBaseService {
  factory AuthBaseService(Dio dio, {String baseUrl}) = _AuthBaseService;


  
  @POST('/login')
  FutureApiResponse<dynamic> login(  
    {
    @Body() required var body,
  });
}

final authServiceProvider = Provider<AuthBaseService>((ref) {
 
  return AuthBaseService(ref.dio);
});
