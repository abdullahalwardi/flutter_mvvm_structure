import 'package:app/data/shared_preference/share_preference.dart';

class StringPreference extends ObjectSharedPreference<String> {
  const StringPreference(super.sharedPreference, {required super.key});

  @override
  String? maybeData() {
    return sharedPreference.getString(key);
  }

  @override
  Future<void> setData(String value) async {
    await sharedPreference.setString(key, value);
  }
}
