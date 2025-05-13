// To parse this JSON data, do
//
//     final notificationDetailsResDto = notificationDetailsResDtoFromJson(jsonString);

import 'dart:convert';

NotificationDetailsResDto notificationDetailsResDtoFromJson(String str) => NotificationDetailsResDto.fromJson(json.decode(str));

String notificationDetailsResDtoToJson(NotificationDetailsResDto data) => json.encode(data.toJson());

class NotificationDetailsResDto {
  bool status;
  NotificationDetailsBody body;

  NotificationDetailsResDto({
    required this.status,
    required this.body,
  });

  factory NotificationDetailsResDto.fromJson(Map<String, dynamic> json) => NotificationDetailsResDto(
    status: json["status"],
    body: NotificationDetailsBody.fromJson(json["body"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "body": body.toJson(),
  };
}

class NotificationDetailsBody {
  String id;
  String userId;
  DateTime date;
  String timeSlotId;
  String description;
  String status;
  DateTime nextVisitedDate;
  String nextVisitedTime;
  String timeSlotData;
  String nextVisitedTimeslot;
  List<Prescription> prescription;
  List<String> appointmentImages;

  NotificationDetailsBody({
    required this.id,
    required this.userId,
    required this.date,
    required this.timeSlotId,
    required this.description,
    required this.status,
    required this.nextVisitedDate,
    required this.nextVisitedTime,
    required this.timeSlotData,
    required this.nextVisitedTimeslot,
    required this.prescription,
    required this.appointmentImages,
  });

  factory NotificationDetailsBody.fromJson(Map<String, dynamic> json) => NotificationDetailsBody(
    id: json["id"],
    userId: json["user_id"],
    date: DateTime.parse(json["date"]),
    timeSlotId: json["time_slot_id"],
    description: json["description"],
    status: json["status"],
    nextVisitedDate: DateTime.parse(json["next_visited_date"]),
    nextVisitedTime: json["next_visited_time"],
    timeSlotData: json["time_slot_data"],
    nextVisitedTimeslot: json["next_visited_timeslot"],
    prescription: List<Prescription>.from(json["prescription"].map((x) => Prescription.fromJson(x))),
    appointmentImages: List<String>.from(json["appointment_images"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
    "time_slot_id": timeSlotId,
    "description": description,
    "status": status,
    "next_visited_date": "${nextVisitedDate.year.toString().padLeft(4, '0')}-${nextVisitedDate.month.toString().padLeft(2, '0')}-${nextVisitedDate.day.toString().padLeft(2, '0')}",
    "next_visited_time": nextVisitedTime,
    "time_slot_data": timeSlotData,
    "next_visited_timeslot": nextVisitedTimeslot,
    "prescription": List<dynamic>.from(prescription.map((x) => x.toJson())),
    "appointment_images": List<dynamic>.from(appointmentImages.map((x) => x)),
  };
}

class Prescription {
  String id;
  String appointmentId;
  String medicine;
  String dose;
  String time;
  String nextVisitedDate;
  String nextVisitedTime;

  Prescription({
    required this.id,
    required this.appointmentId,
    required this.medicine,
    required this.dose,
    required this.time,
    required this.nextVisitedDate,
    required this.nextVisitedTime,
  });

  factory Prescription.fromJson(Map<String, dynamic> json) => Prescription(
    id: json["id"],
    appointmentId: json["appointment_id"],
    medicine: json["medicine"],
    dose: json["dose"],
    time: json["time"],
    nextVisitedDate: json["next_visited_date"],
    nextVisitedTime: json["next_visited_time"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "appointment_id": appointmentId,
    "medicine": medicine,
    "dose": dose,
    "time": time,
    "next_visited_date": nextVisitedDate,
    "next_visited_time": nextVisitedTime,
  };
}
