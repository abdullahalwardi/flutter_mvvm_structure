import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'provider.g.dart';

@riverpod
SharedPreferences sharedPreferences(Ref ref) =>
    throw UnimplementedError();

extension SharedPreferencesRefX on Ref {
  SharedPreferences get sharedPreferences => read(sharedPreferencesProvider);
}
