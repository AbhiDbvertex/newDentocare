// To parse this JSON data, do
//
//     final signUpDto = signUpDtoFromJson(jsonString);

import 'dart:convert';

SignUpDto signUpDtoFromJson(String str) => SignUpDto.fromJson(json.decode(str));

String signUpDtoToJson(SignUpDto data) => json.encode(data.toJson());

class SignUpDto {
  String message;
  Data data;

  SignUpDto({
    required this.message,
    required this.data,
  });

  factory SignUpDto.fromJson(Map<String, dynamic> json) => SignUpDto(
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": data.toJson(),
      };
}

class Data {
  String id;
  String name;
  String email;
  String? mobile;
  String? password;
  String? address;
  DateTime createdAt;
  DateTime updatedAt;
  String? profile_images;
  String ?image;

  Data({
    required this.id,
    required this.name,
    required this.email,
     this.mobile,
     this.password,
     this.address,
    required this.createdAt,
    required this.updatedAt,
    this.profile_images,
    this.image
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
      id: json["id"],
      name: json["name"],
      email: json["email"],
      mobile: json["mobile"],
      password: json["password"],
      address: json["address"],
      createdAt: DateTime.parse(json["created_at"]),
      updatedAt: DateTime.parse(json["updated_at"]),
      profile_images: json["profile_images"],
      image:json['image']

  );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "mobile": mobile,
        "password": password,
        "address": address,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "profile_images":profile_images,
        "image":image,
      };
}
