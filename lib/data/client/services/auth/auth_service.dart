import 'package:app/utils/constants/api_document.dart';
import 'package:app/data/client/services/callback.dart';
import 'package:app/di/modules/dio_module.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/retrofit.dart';


part 'auth_service.g.dart';

@RestApi(baseUrl: '${ApiDocument.baseUrl}/Auth')
abstract class AuthBaseService {
  factory AuthBaseService(Dio dio, {String baseUrl}) = _AuthBaseService;
  @POST('/login')
  FutureApiResponse<dynamic> login({
    @Body() required var body,
  });
}

final authServiceProvider = Provider<AuthBaseService>((ref) {
  final dio = ref.watch(dioProvider);
 
  return AuthBaseService(dio);
});
