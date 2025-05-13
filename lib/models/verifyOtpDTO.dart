// To parse this JSON data, do
//
//     final verifyOtpDto = verifyOtpDtoFromJson(jsonString);

import 'dart:convert';

VerifyOtpDto verifyOtpDtoFromJson(String str) => VerifyOtpDto.fromJson(json.decode(str));

String verifyOtpDtoToJson(VerifyOtpDto data) => json.encode(data.toJson());

class VerifyOtpDto {
  bool status;
  Data data;
  String message;

  VerifyOtpDto({
    required this.status,
    required this.data,
    required this.message,
  });

  factory VerifyOtpDto.fromJson(Map<String, dynamic> json) => VerifyOtpDto(
    status: json["status"],
    data: Data.fromJson(json["data"]),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data.toJson(),
    "message": message,
  };
}

class Data {
  String id;
  String name;
  String email;
  String mobile;
  String password;
  String address;
  String otp;
  String userVerified;
  String? profileImages;
  String token;
  DateTime? createdAt;
  DateTime? updatedAt;

  Data({
    required this.id,
    required this.name,
    required this.email,
    required this.mobile,
    required this.password,
    required this.address,
    required this.otp,
    required this.userVerified,
    required this.profileImages,
    required this.token,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    mobile: json["mobile"],
    password: json["password"],
    address: json["address"],
    otp: json["otp"],
    userVerified: json["user_verified"],
    profileImages: json["profile_images"],
    token: json["token"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
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
    "profile_images": profileImages??"null",
    "token": token,
    "created_at": createdAt!.toIso8601String()??"null",
    "updated_at": updatedAt!.toIso8601String()??"null",
  };
}
