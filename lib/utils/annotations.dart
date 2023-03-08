
// DON'T EDIT THIS FILE

import 'package:app/services/convertors/nullable_date_time_convertor.dart';
import 'package:app/services/convertors/nullable_phone_number_convertor.dart';
import 'package:app/services/convertors/nullable_string_convertor.dart';
import 'package:app/services/convertors/nullable_uri_convertor.dart';
import 'package:app/services/convertors/xfile_multipart_convertor.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

const List<JsonConverter> apiConvertors = [
  NullableStringConvertor(),
  NullableUriConvertor(),
  NullableDateTimeConvertor(),
  NullablePhoneNumberConvertor(),
  PhoneNumberConvertor(),
  XFileMultipartConvertor(),
];

/// annotate request [Body] like edit and create
const JsonSerializable jsonSerializableRequest = JsonSerializable(
  createFactory: false,
  explicitToJson: true,
  converters: apiConvertors,
);

/// annotate [Body] like read, edit, create response
const JsonSerializable jsonSerializableResponse = JsonSerializable(
  createToJson: false,
  explicitToJson: true,
  converters: apiConvertors,
);

const JsonSerializable jsonSerializable = JsonSerializable(
  createToJson: true,
  createFactory: true,
  explicitToJson: true,
  converters: apiConvertors,
);
const Freezed freezedSerializable = Freezed(
  toJson: true,
  fromJson: true,
);

const Freezed freezedRequest = Freezed(toJson: true, fromJson: false);

const Freezed freezedResponse = Freezed(fromJson: true, toJson: false);
