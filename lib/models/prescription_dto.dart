// To parse this JSON data, do
//
//     final prescriptionDto = prescriptionDtoFromJson(jsonString);

import 'dart:convert';

PrescriptionDto prescriptionDtoFromJson(String str) => PrescriptionDto.fromJson(json.decode(str));

String prescriptionDtoToJson(PrescriptionDto data) => json.encode(data.toJson());

class PrescriptionDto {
  bool status;
  PrescriptionBody body;

  PrescriptionDto({
    required this.status,
    required this.body,
  });

  factory PrescriptionDto.fromJson(Map<String, dynamic> json) => PrescriptionDto(
    status: json["status"],
    body: PrescriptionBody.fromJson(json["body"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "body": body.toJson(),
  };
}

class PrescriptionBody {
  String? id;
  String? userId;
  DateTime? date;
  String? timeSlotId;
  String? description;
  String? status;
  String? nextVisitedDate;
  String? nextVisitedTime;
  String? timeSlotData;
  List<Next>? next;
  List<Prescription>? prescription;
  List<dynamic>? appointmentImages;

  PrescriptionBody({
    this.id,
     this.userId,
     this.date,
     this.timeSlotId,
     this.description,
     this.status,
     this.nextVisitedDate,
     this.nextVisitedTime,
     this.timeSlotData,
     this.next,
     this.prescription,
     this.appointmentImages,
  });

  factory PrescriptionBody.fromJson(Map<String, dynamic> json) => PrescriptionBody(
    id: json["id"],
    userId: json["user_id"],
    date: DateTime.parse(json["date"]),
    timeSlotId: json["time_slot_id"],
    description: json["description"],
    status: json["status"],
    nextVisitedDate: json["next_visited_date"],
    nextVisitedTime: json["next_visited_time"],
    timeSlotData: json["time_slot_data"],
    next: List<Next>.from(json["next"].map((x) => Next.fromJson(x))),
    prescription: List<Prescription>.from(json["prescription"].map((x) => Prescription.fromJson(x))),
    appointmentImages: List<dynamic>.from(json["appointment_images"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "date": "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
    "time_slot_id": timeSlotId,
    "description": description,
    "status": status,
    "next_visited_date": nextVisitedDate,
    "next_visited_time": nextVisitedTime,
    "time_slot_data": timeSlotData,
    "next": List<dynamic>.from(next!.map((x) => x.toJson())),
    "prescription": List<dynamic>.from(prescription!.map((x) => x.toJson())),
    "appointment_images": List<dynamic>.from(appointmentImages!.map((x) => x)),
  };
}

class Next {
  String? id;
  String? appointmentId;
  DateTime? date;
  String? timeSlotId;
  String? file;
  String? remark;

  Next({
     this.id,
     this.appointmentId,
     this.date,
     this.timeSlotId,
     this.file,
     this.remark,
  });

  factory Next.fromJson(Map<String, dynamic> json) => Next(
    id: json["id"],
    appointmentId: json["appointment_id"],
    date: DateTime.parse(json["date"]),
    timeSlotId: json["time_slot_id"],
    file: json["file"],
    remark: json["remark"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "appointment_id": appointmentId,
    "date": "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
    "time_slot_id": timeSlotId,
    "file": file,
    "remark": remark,
  };
}

class Prescription {
  String id;
  String appointmentId;
  String medicine;
  String dose;
  String time;

  Prescription({
    required this.id,
    required this.appointmentId,
    required this.medicine,
    required this.dose,
    required this.time,
  });

  factory Prescription.fromJson(Map<String, dynamic> json) => Prescription(
    id: json["id"],
    appointmentId: json["appointment_id"],
    medicine: json["medicine"],
    dose: json["dose"],
    time: json["time"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "appointment_id": appointmentId,
    "medicine": medicine,
    "dose": dose,
    "time": time,
  };
}
