// To parse this JSON data, do
//
//     final loginerrorDto = loginerrorDtoFromJson(jsonString);

import 'dart:convert';

LoginerrorDto loginerrorDtoFromJson(String str) => LoginerrorDto.fromJson(json.decode(str));

String loginerrorDtoToJson(LoginerrorDto data) => json.encode(data.toJson());

class LoginerrorDto {
  int status;
  int error;
  Messages messages;

  LoginerrorDto({
    required this.status,
    required this.error,
    required this.messages,
  });

  factory LoginerrorDto.fromJson(Map<String, dynamic> json) => LoginerrorDto(
    status: json["status"],
    error: json["error"],
    messages: Messages.fromJson(json["messages"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "error": error,
    "messages": messages.toJson(),
  };
}

class Messages {
  String error;

  Messages({
    required this.error,
  });

  factory Messages.fromJson(Map<String, dynamic> json) => Messages(
    error: json["error"],
  );

  Map<String, dynamic> toJson() => {
    "error": error,
  };
}
