// To parse this JSON data, do
//
//     final bannerDto = bannerDtoFromJson(jsonString);

import 'dart:convert';

BannerDto bannerDtoFromJson(String str) => BannerDto.fromJson(json.decode(str));

String bannerDtoToJson(BannerDto data) => json.encode(data.toJson());

class BannerDto {
  bool status;
  Body body;

  BannerDto({
    required this.status,
    required this.body,
  });

  factory BannerDto.fromJson(Map<String, dynamic> json) => BannerDto(
    status: json["status"],
    body: Body.fromJson(json["body"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "body": body.toJson(),
  };
}

class Body {
  String id;
  String title;
  String image;
  DateTime createdAt;
  String? updatedAt;

  Body({
    required this.id,
    required this.title,
    required this.image,
    required this.createdAt,
     this.updatedAt,
  });

  factory Body.fromJson(Map<String, dynamic> json) => Body(
    id: json["id"],
    title: json["title"],
    image: json["image"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "image": image,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt,
  };
}
