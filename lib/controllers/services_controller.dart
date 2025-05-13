import 'dart:convert';

import 'package:get/get.dart';
import '../models/video_model.dart' as myVideomodel;
import 'package:http/http.dart' as http;

class Servicescontroller extends GetxController {
Future<getgalleryimagess?> getImages() async {
  final url = "https://work.dbvertex.com/dentist1/api/image";

  try {
    var response = await http.get(Uri.parse(url));
    print("Abhi:-get images response status:-${response.statusCode}");
    print("Abhi:-get images response body:-${response.body}");

    if (response.statusCode == 201) {
      var data = jsonDecode(response.body);
      print("Abhi:-decoded JSON data:-${jsonEncode(data)}"); // Log the decoded JSON
      return getgalleryimagess.fromJson(data);
    } else {
      print("Abhi:-get images failed with status:-${response.statusCode}");
      return null;
    }
  } catch (e) {
    print("Abhi:-exception in getImages:-$e");
    return null;
  }
}
}

class getgalleryimagess {
  bool? status;
  String? message;
  List<Body>? body;

  getgalleryimagess({this.status, this.message, this.body});

  getgalleryimagess.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['body'] != null) {
      body = <Body>[];
      json['body'].forEach((v) {
        body!.add(new Body.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.body != null) {
      data['body'] = this.body!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Body {
  String? id;
  String? title;
  String? image;

  Body({this.id, this.title, this.image});

  Body.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['image'] = this.image;
    return data;
  }
}
