// import 'dart:convert';
//
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// class AppoinmentDetailPages extends GetxController {
//
//   var userid ;
//   Future<AppoinmentDetail?> getAppoinmentDetail () async {
//     try {
//       final url = "https://work.dbvertex.com/dentist1/api/appointment_get/$userid";
//
//       var response = await http.get(Uri.parse(url)); // await lagaya yaha
//
//       print("Abhi:-get user id for call api time : ${userid}");
//       print("Abhi:-get user id for call api url : ${url}");
//       print("Abhi:- response  : ${response.body}");
//
//
//       if (response.statusCode == 200 || response.statusCode == 201) {
//         final jsonData = AppoinmentDetail.fromJson(
//             Map<String, dynamic>.from(jsonDecode(response.body)));
//         return jsonData;
//       } else {
//         print("Server error: ${response.statusCode}");
//       }
//
//     } catch (e) {
//       print("Error: $e");
//     }
//     return null;
//   }
// }
//
// class AppoinmentDetail {
//   bool? status;
//   List<Body>? body;
//
//   AppoinmentDetail({this.status, this.body});
//
//   AppoinmentDetail.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
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
//     if (this.body != null) {
//       data['body'] = this.body!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class Body {
//   String? id;
//   String? userId;
//   String? date;
//   String? timeSlotId;
//   String? description;
//   String? status;
//   String? nextVisitedDate;
//   String? nextVisitedTime;
//   String? imageId;
//   List<String>? appointmentImages;
//   TimeSlotData? timeSlotData;
//   ServiceData? serviceData;
//
//   Body(
//       {this.id,
//         this.userId,
//         this.date,
//         this.timeSlotId,
//         this.description,
//         this.status,
//         this.nextVisitedDate,
//         this.nextVisitedTime,
//         this.imageId,
//         this.appointmentImages,
//         this.timeSlotData,
//         this.serviceData});
//
//   Body.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     userId = json['user_id'];
//     date = json['date'];
//     timeSlotId = json['time_slot_id'];
//     description = json['description'];
//     status = json['status'];
//     nextVisitedDate = json['next_visited_date'];
//     nextVisitedTime = json['next_visited_time'];
//     imageId = json['image_id'];
//     appointmentImages = json['appointment_images'].cast<String>();
//     timeSlotData = json['time_slot_data'] != null
//         ? new TimeSlotData.fromJson(json['time_slot_data'])
//         : null;
//     serviceData = json['service_data'] != null
//         ? new ServiceData.fromJson(json['service_data'])
//         : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['user_id'] = this.userId;
//     data['date'] = this.date;
//     data['time_slot_id'] = this.timeSlotId;
//     data['description'] = this.description;
//     data['status'] = this.status;
//     data['next_visited_date'] = this.nextVisitedDate;
//     data['next_visited_time'] = this.nextVisitedTime;
//     data['image_id'] = this.imageId;
//     data['appointment_images'] = this.appointmentImages;
//     if (this.timeSlotData != null) {
//       data['time_slot_data'] = this.timeSlotData!.toJson();
//     }
//     if (this.serviceData != null) {
//       data['service_data'] = this.serviceData!.toJson();
//     }
//     return data;
//   }
// }
//
// class TimeSlotData {
//   String? timeSlot;
//
//   TimeSlotData({this.timeSlot});
//
//   TimeSlotData.fromJson(Map<String, dynamic> json) {
//     timeSlot = json['time_slot'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['time_slot'] = this.timeSlot;
//     return data;
//   }
// }
//
// class ServiceData {
//   String? image;
//   String? title;
//
//   ServiceData({this.image, this.title});
//
//   ServiceData.fromJson(Map<String, dynamic> json) {
//     image = json['image'];
//     title = json['title'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['image'] = this.image;
//     data['title'] = this.title;
//     return data;
//   }
// }

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../utils/app_constant.dart';

class AppoinmentDetailPages extends GetxController {
  var isLoading = true.obs;
  var appointmentDetail = Rxn<AppoinmentDetail>();

  Future<AppoinmentDetail?> getAppoinmentDetail(String userId) async {
    if (userId.isEmpty) {
      print("Error: userId is empty or null");
      Get.snackbar("Error", "User ID is required to fetch appointments",
          backgroundColor: Colors.red, colorText: Colors.white);
      isLoading.value = false;
      return null;
    }

    try {
      isLoading.value = true;
      final url = "${AppConstant.BASE_URL}/api/appointment_get/$userId";
      print("Calling API: $url with userId: $userId");

      var response = await http.get(
        Uri.parse(url),
        headers: {"x-api-key": "dentist@123"},
      );

      print("API Response Status: ${response.statusCode}");
      print("API Response Body: ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        final jsonData = AppoinmentDetail.fromJson(
          Map<String, dynamic>.from(jsonDecode(response.body)),
        );
        appointmentDetail.value = jsonData;
        print("Appointment Details Loaded: ${jsonData.body?.length} items");
        return jsonData;
      } else {
        print("Server error: ${response.statusCode}");
        Get.snackbar("Error", "Failed to load appointments: ${response.statusCode}",
            backgroundColor: Colors.red, colorText: Colors.white);
        return null;
      }
    } catch (e) {
      print("Exception in getAppoinmentDetail: $e");
      Get.snackbar("Error", "Something went wrong: $e",
          backgroundColor: Colors.red, colorText: Colors.white);
      return null;
    } finally {
      isLoading.value = false;
    }
  }
}

class AppoinmentDetail {
  bool? status;
  List<Body>? body;

  AppoinmentDetail({this.status, this.body});

  AppoinmentDetail.fromJson(Map<String, dynamic> json) {
    status = json['status'];
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
    if (this.body != null) {
      data['body'] = this.body!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Body {
  String? id;
  String? userId;
  String? date;
  String? timeSlotId;
  String? timeSlottime;
  String? description;
  String? status;
  String? nextVisitedDate;
  String? nextVisitedTime;
  String? imageId;
  List<String>? appointmentImages;
  TimeSlotData? timeSlotData;
  ServiceData? serviceData;
  List<Prescriptions>? prescriptions;

  Body(
      {this.id,
        this.userId,
        this.date,
        this.timeSlotId,
        this.timeSlottime,
        this.description,
        this.status,
        this.nextVisitedDate,
        this.nextVisitedTime,
        this.imageId,
        this.appointmentImages,
        this.timeSlotData,
        this.serviceData,
        this.prescriptions});

  Body.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    date = json['date'];
    timeSlotId = json['time_slot_id'];
    timeSlottime = json['time_slot'];
    description = json['description'];
    status = json['status'];
    nextVisitedDate = json['next_visited_date'];
    nextVisitedTime = json['next_visited_time'];
    imageId = json['image_id'];
    appointmentImages = json['appointment_images'].cast<String>();
    timeSlotData = json['time_slot_data'] != null
        ? new TimeSlotData.fromJson(json['time_slot_data'])
        : null;
    serviceData = json['service_data'] != null
        ? new ServiceData.fromJson(json['service_data'])
        : null;
    if (json['prescriptions'] != null) {
      prescriptions = <Prescriptions>[];
      json['prescriptions'].forEach((v) {
        prescriptions!.add(new Prescriptions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['date'] = this.date;
    data['time_slot_id'] = this.timeSlotId;
    data['time_slot'] = this.timeSlottime;
    data['description'] = this.description;
    data['status'] = this.status;
    data['next_visited_date'] = this.nextVisitedDate;
    data['next_visited_time'] = this.nextVisitedTime;
    data['image_id'] = this.imageId;
    data['appointment_images'] = this.appointmentImages;
    if (this.timeSlotData != null) {
      data['time_slot_data'] = this.timeSlotData!.toJson();
    }
    if (this.serviceData != null) {
      data['service_data'] = this.serviceData!.toJson();
    }
    if (this.prescriptions != null) {
      data['prescriptions'] =
          this.prescriptions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TimeSlotData {
  String? timeSlot;

  TimeSlotData({this.timeSlot});

  TimeSlotData.fromJson(Map<String, dynamic> json) {
    timeSlot = json['time_slot'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['time_slot'] = this.timeSlot;
    return data;
  }
}

class ServiceData {
  String? image;
  String? title;

  ServiceData({this.image, this.title});

  ServiceData.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    data['title'] = this.title;
    return data;
  }
}

class Prescriptions {
  String? id;
  String? appointmentId;
  String? medicine;
  String? dose;
  String? time;

  Prescriptions(
      {this.id, this.appointmentId, this.medicine, this.dose, this.time});

  Prescriptions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    appointmentId = json['appointment_id'];
    medicine = json['medicine'];
    dose = json['dose'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['appointment_id'] = this.appointmentId;
    data['medicine'] = this.medicine;
    data['dose'] = this.dose;
    data['time'] = this.time;
    return data;
  }
}

// class AppoinmentDetail {
//   bool? status;
//   List<Body>? body;
//
//   AppoinmentDetail({this.status, this.body});
//
//   AppoinmentDetail.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     if (json['body'] != null) {
//       body = <Body>[];
//       json['body'].forEach((v) {
//         body!.add(Body.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = {};
//     data['status'] = status;
//     if (body != null) {
//       data['body'] = body!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class Body {
//   String? id;
//   String? userId;
//   String? date;
//   String? timeSlotId;
//   String? description;
//   String? status;
//   String? nextVisitedDate;
//   String? nextVisitedTime;
//   String? imageId;
//   List<String>? appointmentImages;
//   TimeSlotData? timeSlotData;
//   ServiceData? serviceData;
//
//   Body({
//     this.id,
//     this.userId,
//     this.date,
//     this.timeSlotId,
//     this.description,
//     this.status,
//     this.nextVisitedDate,
//     this.nextVisitedTime,
//     this.imageId,
//     this.appointmentImages,
//     this.timeSlotData,
//     this.serviceData,
//   });
//
//   Body.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     userId = json['user_id'];
//     date = json['date'];
//     timeSlotId = json['time_slot_id'];
//     description = json['description'];
//     status = json['status'];
//     nextVisitedDate = json['next_visited_date'];
//     nextVisitedTime = json['next_visited_time'];
//     imageId = json['image_id'];
//     appointmentImages = json['appointment_images']?.cast<String>();
//     timeSlotData = json['time_slot_data'] != null
//         ? TimeSlotData.fromJson(json['time_slot_data'])
//         : null;
//     serviceData = json['service_data'] != null
//         ? ServiceData.fromJson(json['service_data'])
//         : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = {};
//     data['id'] = id;
//     data['user_id'] = userId;
//     data['date'] = date;
//     data['time_slot_id'] = timeSlotId;
//     data['description'] = description;
//     data['status'] = status;
//     data['next_visited_date'] = nextVisitedDate;
//     data['next_visited_time'] = nextVisitedTime;
//     data['image_id'] = imageId;
//     data['appointment_images'] = appointmentImages;
//     if (timeSlotData != null) {
//       data['time_slot_data'] = timeSlotData!.toJson();
//     }
//     if (serviceData != null) {
//       data['service_data'] = serviceData!.toJson();
//     }
//     return data;
//   }
// }
//
// class TimeSlotData {
//   String? timeSlot;
//
//   TimeSlotData({this.timeSlot});
//
//   TimeSlotData.fromJson(Map<String, dynamic> json) {
//     timeSlot = json['time_slot'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = {};
//     data['time_slot'] = timeSlot;
//     return data;
//   }
// }
//
// class ServiceData {
//   String? image;
//   String? title;
//
//   ServiceData({this.image, this.title});
//
//   ServiceData.fromJson(Map<String, dynamic> json) {
//     image = json['image'];
//     title = json['title'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = {};
//     data['image'] = image;
//     data['title'] = title;
//     return data;
//   }
// }