// To parse this JSON data, do
//
//     final normalDto = normalDtoFromJson(jsonString);

import 'dart:convert';

NormalDto normalDtoFromJson(String str) => NormalDto.fromJson(json.decode(str));

String normalDtoToJson(NormalDto data) => json.encode(data.toJson());

class NormalDto {
  bool status;
  String message;

  NormalDto({
    required this.status,
    required this.message,
  });

  factory NormalDto.fromJson(Map<String, dynamic> json) => NormalDto(
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
  };
}
