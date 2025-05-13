// To parse this JSON data, do
//
//     final chatResponseDto = chatResponseDtoFromJson(jsonString);

import 'dart:convert';

ChatResponseDto chatResponseDtoFromJson(String str) => ChatResponseDto.fromJson(json.decode(str));

String chatResponseDtoToJson(ChatResponseDto data) => json.encode(data.toJson());

class ChatResponseDto {
  bool status;
  List<chatBODY> data;

  ChatResponseDto({
    required this.status,
    required this.data,
  });

  factory ChatResponseDto.fromJson(Map<String, dynamic> json) => ChatResponseDto(
    status: json["status"],
    data: List<chatBODY>.from(json["data"].map((x) => chatBODY.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class chatBODY {
  String id;
  String senderId;
  String receiverId;
  DateTime created;
  String message;

  chatBODY({
    required this.id,
    required this.senderId,
    required this.receiverId,
    required this.created,
    required this.message,
  });

  factory chatBODY.fromJson(Map<String, dynamic> json) => chatBODY(
    id: json["id"],
    senderId: json["sender_id"],
    receiverId: json["receiver_id"],
    created: DateTime.parse(json["created"]),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "sender_id": senderId,
    "receiver_id": receiverId,
    "created": created.toIso8601String(),
    "message": message,
  };
}
