import 'package:app/data/services/clients/_clients.dart';
import 'package:app/data/models/authentication_model.dart';
import 'package:app/data/services/clients/callback.dart';
import 'package:app/utils/constants/api_document.dart';

part 'auth_client.g.dart';

@RestApi(baseUrl: '${ApiDocument.baseUrl}/User')
abstract class AuthClient {
  factory AuthClient(Dio dio, {String baseUrl}) = _AuthClient;

  @POST('/login')
  FutureApiResponse<AuthenticationModel> login(@Body() dynamic data);
}

@riverpod
AuthClient authClient(AuthClientRef ref) => AuthClient(ref.dio);