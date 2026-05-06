// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Auth HTTP actions (`authClientProvider`); session persistence stays in
/// [authenticationProvider].

@ProviderFor(Login)
final loginProvider = LoginProvider._();

/// Auth HTTP actions (`authClientProvider`); session persistence stays in
/// [authenticationProvider].
final class LoginProvider
    extends $AsyncNotifierProvider<Login, AuthenticationModel?> {
  /// Auth HTTP actions (`authClientProvider`); session persistence stays in
  /// [authenticationProvider].
  LoginProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'loginProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$loginHash();

  @$internal
  @override
  Login create() => Login();
}

String _$loginHash() => r'e9a4437d1c14cf4f560d884ee08a901171603f6e';

/// Auth HTTP actions (`authClientProvider`); session persistence stays in
/// [authenticationProvider].

abstract class _$Login extends $AsyncNotifier<AuthenticationModel?> {
  FutureOr<AuthenticationModel?> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<AsyncValue<AuthenticationModel?>, AuthenticationModel?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<AuthenticationModel?>,
                AuthenticationModel?
              >,
              AsyncValue<AuthenticationModel?>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
