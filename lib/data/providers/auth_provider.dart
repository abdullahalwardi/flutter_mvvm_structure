import 'package:app/data/models/authentication_model.dart';
import 'package:app/data/providers/authentication_provider.dart';
import 'package:app/data/services/clients/auth_client.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_provider.g.dart';

/// Auth HTTP actions (`authClientProvider`); session persistence stays in
/// [authenticationProvider].
@riverpod
class Login extends _$Login {
  @override
  Future<AuthenticationModel?> build() async => null;

  Future<void> run(dynamic data) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final response = await ref.read(authClientProvider).login(data);
      final result = response.data;
      await ref
          .read(authenticationProvider.notifier)
          .update((state) => result);
      return result;
    });
  }
}
