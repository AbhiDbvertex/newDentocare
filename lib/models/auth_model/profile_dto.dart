// To parse this JSON data, do
//
//     final profileDto = profileDtoFromJson(jsonString);

import 'dart:convert';

ProfileDto profileDtoFromJson(String str) => ProfileDto.fromJson(json.decode(str));

String profileDtoToJson(ProfileDto data) => json.encode(data.toJson());

class ProfileDto {
  bool status;
  String message;
  Body body;

  ProfileDto({
    required this.status,
    required this.message,
    required this.body,
  });

  factory ProfileDto.fromJson(Map<String, dynamic> json) => ProfileDto(
    status: json["status"],
    message: json["message"],
    body: Body.fromJson(json["body"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "body": body.toJson(),
  };
}

class Body {
  String id;
  String name;
  String email;
  String? mobile;
  String? password;
  String? address;
  String otp;
  String userVerified;
  String token;
  DateTime createdAt;
  DateTime updatedAt;
  String image;

  Body({
    required this.id,
    required this.name,
    required this.email,
     this.mobile,
     this.password,
     this.address,
    required this.otp,
    required this.userVerified,
    required this.token,
    required this.createdAt,
    required this.updatedAt,
    required this.image
  });

  factory Body.fromJson(Map<String, dynamic> json) => Body(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    mobile: json["mobile"],
    password: json["password"],
    address: json["address"],
    otp: json["otp"],
    userVerified: json["user_verified"],
    token: json["token"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "mobile": mobile,
    "password": password,
    "address": address,
    "otp": otp,
    "user_verified": userVerified,
    "token": token,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "image": image,
  };
}
