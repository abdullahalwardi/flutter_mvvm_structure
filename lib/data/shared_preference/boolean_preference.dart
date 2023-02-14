import 'package:app/data/shared_preference/shared_preference.dart';

class BooleanPreference extends ObjectSharedPreference<bool> {
  const BooleanPreference(super.sharedPreference, {required super.key});

  @override
  bool? maybeData() {
    return sharedPreference.getBool(key);
  }

  @override
  Future<void> setData(bool value) async {
    await sharedPreference.setBool(key, value);
  }
}
