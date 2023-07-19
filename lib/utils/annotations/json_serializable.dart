import 'package:freezed_annotation/freezed_annotation.dart';

/// Api field rename
const filedRename = FieldRename.none;

/// Api any model
const jsonSerializable = JsonSerializable(
  fieldRename: filedRename,
  createFactory: true,
  createToJson: true,
  explicitToJson: true,
);

/// Api response model
const jsonSerializableResponse = JsonSerializable(
  fieldRename: filedRename,
  createFactory: true,
  createToJson: true,
  explicitToJson: false,
);

/// Api request model
const jsonSerializableRequest = JsonSerializable(
  fieldRename: filedRename,
  createFactory: false,
  createToJson: true,
  explicitToJson: true,
);

/// Api generic model with <T>
const jsonSerializableResponseGeneric = Freezed(
  toJson: false,
  fromJson: true,
  genericArgumentFactories: true,
);

const jsonEnum = JsonEnum(
  fieldRename: FieldRename.pascal,
  alwaysCreate: true,
);
