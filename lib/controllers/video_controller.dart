import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:dentocoreauth/data/repository/auth_repository/video_repo.dart';
import '../models/video_model.dart' as myVideomodel;
import '../Utills/Utills.dart';
import '../models/video_model.dart';
import 'package:http/http.dart' as http;
class VideoController extends GetxController {
  final VideoRepository videoRepository;



  VideoController({required this.videoRepository});

  var util = Utills();

  RxList<VideoBody?> _getlist = <VideoBody?>[].obs;
RxBool isLoading=true.obs;
  RxList<VideoBody?> get getlist => _getlist;

  Future<myVideomodel.VideoDto?> getVideos() async {
    debugPrint("njtest" + "called");
    util.startLoading();
    var res = await videoRepository.getVideoList();

    isLoading(true);

    if (res.statusCode == 200 || res.statusCode == 201) {
      util.stopLoading();
      isLoading(false);
      debugPrint("200");

      var response = myVideomodel.videoDtoFromJson(res.bodyString!);
      if (response.status == true) {
        _getlist.value = response.body;
        debugPrint("njtest" + "nn${getlist[0]!.title!.toString()}");
        return myVideomodel.videoDtoFromJson(res.body);
      } else {
        util.showSnackBar("Alert", "failed to get list", false);
      }
    } else if (res.statusCode == 400) {
      debugPrint("400");
      debugPrint("400");
      util.stopLoading();
      isLoading(false);
      util.showSnackBar("Alert", "Something went wrong!", false);
    }else{
      debugPrint("njtest" + "500");
      util.stopLoading();
      isLoading(false);
      util.showSnackBar("Alert", "Something went wrong!", false);
    }
  }

  // Future<getgalleryimagess?> getImages() async {
  //   final url = "https://work.dbvertex.com/dentist1/api/image";
  //
  //   try {
  //     var response = await http.get(Uri.parse(url));
  //     print("Abhi:-get images response status:-${response.statusCode}");
  //     print("Abhi:-get images response body:-${response.body}");
  //
  //     if (response.statusCode == 201) {
  //       var data = jsonDecode(response.body);
  //       print("Abhi:-decoded JSON data:-${jsonEncode(data)}"); // Log the decoded JSON
  //       return getgalleryimagess.fromJson(data);
  //     } else {
  //       print("Abhi:-get images failed with status:-${response.statusCode}");
  //       return null;
  //     }
  //   } catch (e) {
  //     print("Abhi:-exception in getImages:-$e");
  //     return null;
  //   }
  // }

   Future<getgalleryImagesfunction?> getGalleryImages () async {

    final url = "https://work.dbvertex.com/dentist1/api/gallery";

    try{
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200 || response.statusCode == 201) {
        print("Abhi:- print response getGalleryImages: ${response.body}");
        var data = jsonDecode(response.body);
        return getgalleryImagesfunction.fromJson(data);
      } else{
        print("Abhi:- getgalleryImagesfunction elase print");
        return null ;
      }
    }catch(e){
      print("Abhi:- print getgalleryImagesfunction error : $e");
      return null;
    }
   }
}

class getgalleryImagesfunction {
  bool? status;
  String? message;
  List<Body>? body;

  getgalleryImagesfunction({this.status, this.message, this.body});

  getgalleryImagesfunction.fromJson(Map<String, dynamic> json) {
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


// class getgalleryimagess {
//   bool? status;
//   String? message;
//   List<Body>? body;
//
//   getgalleryimagess({this.status, this.message, this.body});
//
//   getgalleryimagess.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     message = json['message'];
//     if (json['body'] != null) {
//       body = <Body>[];
//       json['body'].forEach((v) {
//         body!.add(new Body.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['status'] = this.status;
//     data['message'] = this.message;
//     if (this.body != null) {
//       data['body'] = this.body!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class Body {
//   String? id;
//   String? title;
//   String? image;
//
//   Body({this.id, this.title, this.image});
//
//   Body.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     title = json['title'];
//     image = json['image'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['title'] = this.title;
//     data['image'] = this.image;
//     return data;
//   }
// }