import 'package:app/data/models/authentication_model.dart';
import 'package:app/data/providers/authentication_provider.dart';
import 'package:app/data/services/clients/auth_client.dart';

import '../services/clients/_clients.dart';

part 'login_provider.g.dart';

@riverpod
class Login extends _$Login with AsyncXNotifierMixin<AuthenticationModel> {
  @override
  Future<AsyncX<AuthenticationModel>> build() => idle();

  @useResult
  RunXCallback<AuthenticationModel> run(dynamic data) => handle(() async{
    final response = await ref.read(authClientProvider).login(data);
    final result = response.data;
    await ref
            .read(authenticationProvider.notifier)
            .update((state) => result);
        return result;
  });

}
