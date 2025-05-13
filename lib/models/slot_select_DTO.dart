// To parse this JSON data, do
//
//     final slotSelectDto = slotSelectDtoFromJson(jsonString);

import 'dart:convert';

SlotSelectDto slotSelectDtoFromJson(String str) => SlotSelectDto.fromJson(json.decode(str));

String slotSelectDtoToJson(SlotSelectDto data) => json.encode(data.toJson());

class SlotSelectDto {
  bool status;
  List<SlotBody> body;

  SlotSelectDto({
    required this.status,
    required this.body,
  });

  factory SlotSelectDto.fromJson(Map<String, dynamic> json) => SlotSelectDto(
    status: json["status"],
    body: List<SlotBody>.from(json["body"].map((x) => SlotBody.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "body": List<dynamic>.from(body.map((x) => x.toJson())),
  };
}

class SlotBody {
  String id;
  String timeSlot;

  SlotBody({
    required this.id,
    required this.timeSlot,
  });

  factory SlotBody.fromJson(Map<String, dynamic> json) => SlotBody(
    id: json["id"],
    timeSlot: json["time_slot"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "time_slot": timeSlot,
  };
}
