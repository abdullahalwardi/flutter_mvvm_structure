import 'package:app/data/shared_preference/shared_preference.dart';

class EnumPreference<T extends Enum> extends ObjectSharedPreference<T> {
  final List<T> values;

  const EnumPreference(
    super.sharedPreference, {
    required super.key,
    required this.values,
  });

  @override
  T? maybeData() {
    final value = sharedPreference.getString(key);
    if (value == null) return null;

    return values.firstWhere(
      (element) => element.name.toLowerCase() == value.toLowerCase(),
      orElse: () => values.first,
    );
  }

  @override
  Future<void> setData(Enum value) async {
    await sharedPreference.setString(key, value.name.toLowerCase());
  }

  Future<void> setString(String valueName) async {
    await sharedPreference.setString(key, valueName);
  }
}

class DefaultEnumPreference<T extends Enum> extends EnumPreference<T> {
  final T defaultValue;

  const DefaultEnumPreference(
    super.sharedPreference, {
    required super.key,
    required super.values,
    required this.defaultValue,
  });

  @override
  T maybeData() {
    final value = sharedPreference.getString(key);
    if (value == null) return defaultValue;

    return values.firstWhere(
      (element) => element.name.toLowerCase() == value.toLowerCase(),
      orElse: () => values.first,
    );
  }
}
