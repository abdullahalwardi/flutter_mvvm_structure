import 'package:app/data/models/phone_number.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

class PhoneNumberConvertor implements JsonConverter<PhoneNumber, String> {
  const PhoneNumberConvertor();

  @override
  PhoneNumber fromJson(String json) {
    return phoneNumberFromString(json)!;
  }

  @override
  String toJson(PhoneNumber object) {
    return object.completeNumber;
  }
}

// Handle iraqi number and global and null numbers
class NullablePhoneNumberConvertor
    implements JsonConverter<PhoneNumber?, String?> {
  const NullablePhoneNumberConvertor();

  @override
  PhoneNumber? fromJson(String? json) {
    if (json == null || json.isEmpty) return null;

    if (json.startsWith(iraqiPhoneNumberStarter)) {
      return iraqiPhoneNumber.copyWith(
        number: json.replaceRange(0, 1, ""),
      );
    }

    return phoneNumberFromString(json);
  }

  @override
  String? toJson(PhoneNumber? object) {
    return object?.completeNumber;
  }
}
