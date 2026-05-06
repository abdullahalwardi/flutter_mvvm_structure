// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_client.dart';

// dart format off

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers,unused_element,unnecessary_string_interpolations,unused_element_parameter,avoid_unused_constructor_parameters,unreachable_from_main

class _AuthClient implements AuthClient {
  _AuthClient(this._dio, {this.baseUrl, this.errorLogger});

  final Dio _dio;

  String? baseUrl;

  final ParseErrorLogger? errorLogger;

  @override
  Future<HttpResponse<AuthenticationModel>> login(dynamic data) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = data;
    final _options = _setStreamType<HttpResponse<AuthenticationModel>>(
      Options(method: 'POST', headers: _headers, extra: _extra)
          .compose(
            _dio.options,
            '/login',
            queryParameters: queryParameters,
            data: _data,
          )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late AuthenticationModel _value;
    try {
      _value = AuthenticationModel.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options, response: _result);
      rethrow;
    }
    final httpResponse = HttpResponse(_value, _result);
    return httpResponse;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }

  String _combineBaseUrls(String dioBaseUrl, String? baseUrl) {
    if (baseUrl == null || baseUrl.trim().isEmpty) {
      return dioBaseUrl;
    }

    final url = Uri.parse(baseUrl);

    if (url.isAbsolute) {
      return url.toString();
    }

    return Uri.parse(dioBaseUrl).resolveUri(url).toString();
  }
}

// dart format on

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(authClient)
final authClientProvider = AuthClientProvider._();

final class AuthClientProvider
    extends $FunctionalProvider<AuthClient, AuthClient, AuthClient>
    with $Provider<AuthClient> {
  AuthClientProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authClientProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authClientHash();

  @$internal
  @override
  $ProviderElement<AuthClient> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AuthClient create(Ref ref) {
    return authClient(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AuthClient value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AuthClient>(value),
    );
  }
}

String _$authClientHash() => r'1daaf336715f59636dea9668787b3bcfc922a1cb';
