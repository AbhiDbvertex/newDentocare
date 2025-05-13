// import 'dart:convert';
//
// NotificationDto notificationDtoFromJson(String str) => NotificationDto.fromJson(json.decode(str));
//
// String notificationDtoToJson(NotificationDto data) => json.encode(data.toJson());
//
// class NotificationDto {
//   bool status;
//   List<NotificationBody> body;
//
//   NotificationDto({
//     required this.status,
//     required this.body,
//   });
//
//   factory NotificationDto.fromJson(Map<String, dynamic> json) => NotificationDto(
//     status: json["status"],
//     body: List<NotificationBody>.from(json["body"].map((x) => NotificationBody.fromJson(x))),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "status": status,
//     "body": List<dynamic>.from(body.map((x) => x.toJson())),
//   };
// }
//
// class NotificationBody {
//   String id;
//   String userId;
//   String appointmentId;
//   String title;
//   String message;
//   DateTime createdAt;
//   String? updatedAt;
//
//   NotificationBody({
//     required this.id,
//     required this.userId,
//     required this.appointmentId,
//     required this.message,
//     required this.createdAt,
//     required this.title,
//     this.updatedAt,
//   });
//
//   factory NotificationBody.fromJson(Map<String, dynamic> json) => NotificationBody(
//     id: json["id"]??"",
//     userId: json["user_id"]??"",
//     title: json["title"]??"",
//     appointmentId: json["appointment_id"]??"",
//     message: json["message"]??"",
//     createdAt: DateTime.parse(json["created_at"]),
//     updatedAt: json["updated_at"]??"",
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "user_id": userId,
//     "title": title,
//     "appointment_id": appointmentId,
//     "message": message,
//     "created_at": createdAt.toIso8601String(),
//     "updated_at": updatedAt,
//   };
// }

import 'dart:convert';

NotificationDto notificationDtoFromJson(String str) => NotificationDto.fromJson(json.decode(str));

String notificationDtoToJson(NotificationDto data) => json.encode(data.toJson());

class NotificationDto {
  bool status;
  List<NotificationBody> body;

  NotificationDto({
    required this.status,
    required this.body,
  });

  factory NotificationDto.fromJson(Map<String, dynamic> json) => NotificationDto(
    status: json["status"],
    body: List<NotificationBody>.from(json["body"].map((x) => NotificationBody.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "body": List<dynamic>.from(body.map((x) => x.toJson())),
  };
}

class NotificationBody {
  String id;
  String userId;
  String appointmentId;
  String title;
  String message;
  String image;
  DateTime createdAt;
  String? updatedAt;

  NotificationBody({
    required this.id,
    required this.userId,
    required this.appointmentId,
    required this.title,
    required this.message,
    required this.image,
    required this.createdAt,
    this.updatedAt,
  });

  factory NotificationBody.fromJson(Map<String, dynamic> json) => NotificationBody(
    id: json["id"],
    userId: json["user_id"],
    appointmentId: json["appointment_id"],
    title: json["title"] ?? "", // Default to empty string if null
    message: json["message"] ?? "", // Default to empty string if null
    image: json["image"] ?? "", // Default to empty string if null
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "appointment_id": appointmentId,
    "title": title,
    "message": message,
    "image": image,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt,
  };
}