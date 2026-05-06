// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'authentication_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(Authentication)
final authenticationProvider = AuthenticationProvider._();

final class AuthenticationProvider
    extends $NotifierProvider<Authentication, AuthenticationModel?> {
  AuthenticationProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authenticationProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authenticationHash();

  @$internal
  @override
  Authentication create() => Authentication();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AuthenticationModel? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AuthenticationModel?>(value),
    );
  }
}

String _$authenticationHash() => r'07009931839e1dfcc7f9535bfb81e51a5ba20c75';

abstract class _$Authentication extends $Notifier<AuthenticationModel?> {
  AuthenticationModel? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AuthenticationModel?, AuthenticationModel?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AuthenticationModel?, AuthenticationModel?>,
              AuthenticationModel?,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
