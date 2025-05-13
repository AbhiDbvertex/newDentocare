// To parse this JSON data, do
//
//     final chatReadStatusDto = chatReadStatusDtoFromJson(jsonString);

import 'dart:convert';

ChatReadStatusDto chatReadStatusDtoFromJson(String str) => ChatReadStatusDto.fromJson(json.decode(str));

String chatReadStatusDtoToJson(ChatReadStatusDto data) => json.encode(data.toJson());

class ChatReadStatusDto {
  bool status;
  ChatStatusData data;

  ChatReadStatusDto({
    required this.status,
    required this.data,
  });

  factory ChatReadStatusDto.fromJson(Map<String, dynamic> json) => ChatReadStatusDto(
    status: json["status"] ?? false, // Null handling for boolean
    data: json["data"] != null ? ChatStatusData.fromJson(json["data"]) : ChatStatusData(), // Null check for data
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data.toJson(),
  };
}


// class ChatReadStatusDto {
//   bool status;
//   ChatStatusData data;
//
//   ChatReadStatusDto({
//     required this.status,
//     required this.data,
//   });
//
//   factory ChatReadStatusDto.fromJson(Map<String, dynamic> json) => ChatReadStatusDto(
//     status: json["status"],
//     data: ChatStatusData.fromJson(json["data"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "status": status,
//     "data": data.toJson(),
//   };
// }

class ChatStatusData {
  String? id;
  String? senderId;
  String? receiverId;
  String? message;
  DateTime? created;
  String? contentType;
  String? deliveredStatus;
  String? readStatus;
  DateTime? chatCreated;
  dynamic? time;

  ChatStatusData({
     this.id,
     this.senderId,
     this.receiverId,
     this.message,
     this.created,
     this.contentType,
     this.deliveredStatus,
     this.readStatus,
     this.chatCreated,
     this.time,
  });

  factory ChatStatusData.fromJson(Map<String, dynamic> json) => ChatStatusData(
    id: json["id"],
    senderId: json["sender_id"],
    receiverId: json["receiver_id"],
    message: json["message"],
    created: DateTime.parse(json["created"]),
    contentType: json["content_type"],
    deliveredStatus: json["delivered_status"],
    readStatus: json["read_status"],
    chatCreated: DateTime.parse(json["chat_created"]),
    time: json["time"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "sender_id": senderId,
    "receiver_id": receiverId,
    "message": message,
    "created": created!.toIso8601String(),
    "content_type": contentType,
    "delivered_status": deliveredStatus,
    "read_status": readStatus,
    "chat_created": chatCreated!.toIso8601String(),
    "time": time,
  };
}
