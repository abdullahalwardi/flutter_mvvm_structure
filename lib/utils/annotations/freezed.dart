import 'package:freezed_annotation/freezed_annotation.dart';

const freezedResponse = Freezed(
  toJson: true,
  fromJson: true,
);

const freezedResponseGeneric = Freezed(
  toJson: false,
  fromJson: true,
  genericArgumentFactories: true,
);

const freezedUnionResponse = Freezed(
  toJson: false,
  fromJson: true,
  unionKey: "type",
  unionValueCase: FreezedUnionCase.pascal,
  fallbackUnion: null,
);

const freezedRequest = Freezed(
  toJson: true,
  fromJson: false,
);

const freezedUnionRequest = Freezed(
  toJson: true,
  fromJson: false,
  unionKey: "type",
  unionValueCase: FreezedUnionCase.pascal,
  fallbackUnion: null,
);
