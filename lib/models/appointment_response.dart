// To parse this JSON data, do
//
//     final appointmentDto = appointmentDtoFromJson(jsonString);

import 'dart:convert';

AppointmentDto appointmentDtoFromJson(String str) => AppointmentDto.fromJson(json.decode(str));

String appointmentDtoToJson(AppointmentDto data) => json.encode(data.toJson());

class AppointmentDto {
  bool status;
  List<AppointmentBody> body;

  AppointmentDto({
    required this.status,
    required this.body,
  });

  factory AppointmentDto.fromJson(Map<String, dynamic> json) => AppointmentDto(
    status: json["status"],
    body: List<AppointmentBody>.from(json["body"].map((x) => AppointmentBody.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "body": List<dynamic>.from(body.map((x) => x.toJson())),
  };
}

class AppointmentBody {
  String id;
  String userId;
  DateTime date;
  String timeSlotId;
  String description;
  String status;
  List<String> appointmentImages;
  TimeSlotData timeSlotData;

  AppointmentBody({
    required this.id,
    required this.userId,
    required this.date,
    required this.timeSlotId,
    required this.description,
    required this.status,
    required this.appointmentImages,
    required this.timeSlotData,
  });

  factory AppointmentBody.fromJson(Map<String, dynamic> json) => AppointmentBody(
    id: json["id"],
    userId: json["user_id"],
    date: DateTime.parse(json["date"]),
    timeSlotId: json["time_slot_id"],
    description: json["description"],
    status: json["status"],
    appointmentImages: List<String>.from(json["appointment_images"].map((x) => x)),
    timeSlotData: TimeSlotData.fromJson(json["time_slot_data"]?? '') ,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
    "time_slot_id": timeSlotId,
    "description": description,
    "status": status,
    "appointment_images": List<dynamic>.from(appointmentImages.map((x) => x)),
    "time_slot_data": timeSlotData.toJson(),
  };
}

class TimeSlotData {
  String timeSlot;

  TimeSlotData({
    required this.timeSlot,
  });

  factory TimeSlotData.fromJson(Map<String, dynamic> json) => TimeSlotData(
    timeSlot: json["time_slot"],
  );

  Map<String, dynamic> toJson() => {
    "time_slot": timeSlot,
  };
}
