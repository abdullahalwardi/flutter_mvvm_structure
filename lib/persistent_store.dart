import 'package:app/data/shared_preference/share_preference.dart';
import 'package:riverpod/riverpod.dart';
class PersistentStateNotifier<T> extends StateNotifier<T> {
  final ObjectSharedPreference<T> preference;

  PersistentStateNotifier(super.state, {required this.preference}) {
    final data = preference.maybeData() ?? state;
    if (data != null) super.state = data;
  }

  @override
  set state(T value) {
    super.state = value;
    preference.setData(value);
  }
}
