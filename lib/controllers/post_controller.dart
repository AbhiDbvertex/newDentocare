
//
// import 'dart:convert';
// import 'dart:io';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'package:http_parser/http_parser.dart';
// import 'package:path/path.dart' as path;
// import '../../utils/app_constant.dart';
// import '../Utills/Utills.dart';
//
// class PostController extends GetxController {
//   final date = TextEditingController();
//   final time = TextEditingController();
//   final problem = TextEditingController();
//
//   var time_slot_id = "";
//   var seletecd_time_slot = "".obs;
//   var selectedImageIds = <String>[].obs;
//   var uploadedImages = <File>[].obs;
//   DateTime? selectedDay;
//
//   final util = Utills();
//
//   bool validation() {
//     if (problem.text.isEmpty) {
//       Get.snackbar("Alert", "Apni problem describe karein!",
//           backgroundColor: Colors.red, colorText: Colors.white);
//       return false;
//     } else if (time_slot_id.isEmpty) {
//       Get.snackbar("Alert", "Time slot select karein!",
//           backgroundColor: Colors.red, colorText: Colors.white);
//       return false;
//     } else if (selectedDay == null) {
//       Get.snackbar("Alert", "Date select karein!",
//           backgroundColor: Colors.red, colorText: Colors.white);
//       return false;
//     } else if (selectedImageIds.isEmpty) {
//       Get.snackbar("Alert", "Kam se kam ek disease select karein!",
//           backgroundColor: Colors.red, colorText: Colors.white);
//       return false;
//     }
//     return true;
//   }
//
//   Future<bool?> postData(String userId) async {
//     if (!validation()) {
//       return false;
//     }
//
//     try {
//       util.startLoading(); // Loading start
//       var request = http.MultipartRequest(
//         'POST',
//         Uri.parse("${AppConstant.BASE_URL}/api/appointment"),
//       );
//
//       // Headers
//       request.headers.addAll({
//         "x-api-key": "dentist@123",
//       });
//
//       // Fields
//       request.fields['date'] =
//       "${selectedDay!.year}-${selectedDay!.month.toString().padLeft(2, '0')}-${selectedDay!.day.toString().padLeft(2, '0')}";
//       request.fields['user_id'] = userId;
//       request.fields['time_slot_id'] = time_slot_id;
//       request.fields['description'] = problem.text;
//       request.fields['image_id'] = selectedImageIds.join(',');
//
//       // Images ko base64 string ke roop mein alag-alag fields mein add karo
//       if (uploadedImages.isNotEmpty) {
//         for (var i = 0; i < uploadedImages.length; i++) {
//           var file = uploadedImages[i];
//           if (await file.exists()) {
//             var fileSize = await file.length();
//             if (fileSize > 5 * 1024 * 1024) {
//               Get.snackbar("Error", "Image ${path.basename(file.path)} bhot badi hai (>5MB)");
//               return false;
//             }
//             // File ko base64 string mein convert karo
//             List<int> imageBytes = await file.readAsBytes();
//             String base64Image = base64Encode(imageBytes);
//             // Har image ke liye alag images[] field add karo
//             request.fields['images[$i]'] = base64Image;
//             print("Base64 Image Added: ${path.basename(file.path)} at index $i");
//           } else {
//             Get.snackbar("Error", "Image ${path.basename(file.path)} exist nahi karti");
//             return false;
//           }
//         }
//       }
//
//       // Log request details
//       print("Request Headers: ${request.headers}");
//       print("Request Fields: ${request.fields}");
//
//       // Request bhejo
//       var response = await request.send();
//       var responseBody = await response.stream.bytesToString();
//       print("API Status: ${response.statusCode}");
//       print("API Response: $responseBody");
//
//       // Response parse karo
//       try {
//         var jsonResponse = jsonDecode(responseBody);
//         bool isSuccess = jsonResponse['status'] == true;
//
//         if (response.statusCode == 200 || response.statusCode == 201) {
//           if (isSuccess) {
//             // Check for image upload confirmation
//             if (jsonResponse['body'] != null && jsonResponse['body'][0]['appointment_images'] != null) {
//               print("Uploaded Images: ${jsonResponse['body'][0]['appointment_images']}");
//               Get.snackbar(
//                 "Success",
//                 "Appointment aur images upload ho gaye! Total images: ${jsonResponse['body'][0]['appointment_images'].length}",
//                 backgroundColor: Colors.green,
//                 colorText: Colors.white,
//                 duration: Duration(seconds: 3),
//               );
//             } else {
//               Get.snackbar(
//                 "Warning",
//                 "Appointment book but images does not upload!",
//                 backgroundColor: Colors.yellow,
//                 colorText: Colors.black,
//                 duration: Duration(seconds: 3),
//               );
//             }
//
//             // Clear fields
//             date.clear();
//             time.clear();
//             problem.clear();
//             selectedDay = null;
//             seletecd_time_slot.value = "";
//             time_slot_id = "";
//             selectedImageIds.clear();
//             uploadedImages.clear();
//             await Future.delayed(Duration(milliseconds: 500));
//             Get.back();
//             return isSuccess;
//           } else {
//             Get.snackbar(
//               "Warning",
//               "Appointment does not book: ${jsonResponse['message'] ?? 'Unknown error'}",
//               backgroundColor: Colors.blue,
//               colorText: Colors.white,
//               duration: Duration(seconds: 3),
//             );
//             return false;
//           }
//         } else {
//           Get.snackbar(
//             "Error",
//             "Appointment does not book: $responseBody",
//             backgroundColor: Colors.red,
//             colorText: Colors.white,
//             duration: Duration(seconds: 3),
//           );
//           return false;
//         }
//       } catch (e) {
//         Get.snackbar(
//           "Error",
//           "Response does not pass: $responseBody",
//           backgroundColor: Colors.red,
//           colorText: Colors.white,
//           duration: Duration(seconds: 3),
//         );
//         return false;
//       }
//     } catch (e) {
//       Get.snackbar(
//         "Error",
//         "error: $e",
//         backgroundColor: Colors.red,
//         colorText: Colors.white,
//         duration: Duration(seconds: 3),
//       );
//       return false;
//     } finally {
//       util.stopLoading();
//     }
//   }
// }
//
    /// upar vala code puri tara se sahi hai

import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart' as path;
import '../../utils/app_constant.dart';
import '../Utills/Utills.dart';

class PostController extends GetxController {
  final date = TextEditingController();
  final time = TextEditingController();
  final problem = TextEditingController();

  var time_slot_id = "";
  var seletecd_time_slot = "".obs;
  var selectedImageIds = <String>[].obs;
  var uploadedImages = <File>[].obs;
  DateTime? selectedDay;

  final util = Utills();

  bool validation() {
    if (problem.text.isEmpty) {
      Get.snackbar("Alert", "Please describe your problem",
          backgroundColor: Colors.red, colorText: Colors.white,snackPosition: SnackPosition.BOTTOM);
      return false;
    } else if (time_slot_id.isEmpty) {
      Get.snackbar("Alert", "Please select a time slot!",
          backgroundColor: Colors.red, colorText: Colors.white,snackPosition: SnackPosition.BOTTOM);
      return false;
    } else if (selectedDay == null) {
      Get.snackbar("Alert", "Please select a date!",
          backgroundColor: Colors.red, colorText: Colors.white,snackPosition: SnackPosition.BOTTOM);
      return false;
    } else if (selectedImageIds.isEmpty) {
      Get.snackbar("Alert", "Please select at least one disease!",
          backgroundColor: Colors.red, colorText: Colors.white,snackPosition: SnackPosition.BOTTOM);
      return false;
    }
    return true;
  }

  Future<bool?> postData(String userId) async {
    if (!validation()) {
      return false;
    }

    try {
      util.startLoading(); // Loading start
      var request = http.MultipartRequest(
        'POST',
        Uri.parse("${AppConstant.BASE_URL}/api/appointment"),
      );

      // Headers
      request.headers.addAll({
        "x-api-key": "dentist@123",
      });

      // Fields
      request.fields['date'] =
      "${selectedDay!.year}-${selectedDay!.month.toString().padLeft(2, '0')}-${selectedDay!.day.toString().padLeft(2, '0')}";
      request.fields['user_id'] = userId;
      request.fields['time_slot_id'] = time_slot_id;
      request.fields['description'] = problem.text;
      request.fields['image_id'] = selectedImageIds.join(',');

      // Images ko base64 string ke roop mein alag-alag fields mein add karo
      if (uploadedImages.isNotEmpty) {
        for (var i = 0; i < uploadedImages.length; i++) {
          var file = uploadedImages[i];
          if (await file.exists()) {
            var fileSize = await file.length();
            if (fileSize > 5 * 1024 * 1024) {
              Get.snackbar("Error", "Image ${path.basename(file.path)} bhot badi hai (>5MB)");
              return false;
            }
            // File ko base64 string mein convert karo
            List<int> imageBytes = await file.readAsBytes();
            String base64Image = base64Encode(imageBytes);
            // Har image ke liye alag images[] field add karo
            request.fields['images[$i]'] = base64Image;
            print("Base64 Image Added: ${path.basename(file.path)} at index $i");
          } else {
            Get.snackbar("Error", "Image ${path.basename(file.path)} exist nahi karti");
            return false;
          }
        }
      }

      // Log request details
      print("Request Headers: ${request.headers}");
      print("Request Fields: ${request.fields}");

      // Request bhejo
      var response = await request.send();
      var responseBody = await response.stream.bytesToString();
      print("API Status: ${response.statusCode}");
      print("API Response: $responseBody");

      // Response parse karo
      try {
        var jsonResponse = jsonDecode(responseBody);
        bool isSuccess = jsonResponse['status'] == true;

        if (response.statusCode == 200 || response.statusCode == 201) {
          if (isSuccess) {
            // Check for image upload confirmation
            if (jsonResponse['body'] != null && jsonResponse['body'][0]['appointment_images'] != null) {
              print("Uploaded Images: ${jsonResponse['body'][0]['appointment_images']}");
              Get.snackbar(
                "Success",
                "Appointment aur images upload ho gaye! Total images: ${jsonResponse['body'][0]['appointment_images'].length}",
                backgroundColor: Colors.green,
                colorText: Colors.white,
                  snackPosition: SnackPosition.BOTTOM,
                duration: Duration(seconds: 3),
              );
              Get.snackbar("Alert", "Appointment book successful",
                  backgroundColor: Colors.red, colorText: Colors.white,snackPosition: SnackPosition.BOTTOM);
              Get.back();
            }

            // Clear fields
            date.clear();
            time.clear();
            problem.clear();
            selectedDay = null;
            seletecd_time_slot.value = "";
            time_slot_id = "";
            selectedImageIds.clear();
            uploadedImages.clear();
            await Future.delayed(Duration(milliseconds: 500));
            Get.back();
            return isSuccess;
          } else {
            Get.snackbar(
              "Warning",
              "Appointment does not book: ${jsonResponse['message'] ?? 'Unknown error'}",
              backgroundColor: Colors.blue,
              colorText: Colors.white,
              duration: Duration(seconds: 3),
            );
            return false;
          }
        } else {
          Get.snackbar(
            "Error",
            "Appointment does not book: $responseBody",
            backgroundColor: Colors.red,
            colorText: Colors.white,
            duration: Duration(seconds: 3),
          );
          return false;
        }
      } catch (e) {
        Get.snackbar(
          "Error",
          "Response does not pass: $responseBody",
          backgroundColor: Colors.red,
          colorText: Colors.white,
          duration: Duration(seconds: 3),
        );
        return false;
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        "error: $e",
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: Duration(seconds: 3),
      );
      return false;
    } finally {
      util.stopLoading();
    }
  }
}






// import 'dart:convert';
// import 'dart:io';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'package:http_parser/http_parser.dart';
// import 'package:path/path.dart' as path;
// import '../../utils/app_constant.dart';
// import '../Utills/Utills.dart';
//
// class PostController extends GetxController {
//   final date = TextEditingController();
//   final time = TextEditingController();
//   final problem = TextEditingController();
//
//   var time_slot_id = "";
//   var seletecd_time_slot = "".obs;
//   var selectedImageIds = <String>[].obs;
//   var uploadedImages = <File>[].obs;
//   DateTime? selectedDay;
//
//   final util = Utills();
//
//   bool validation() {
//     print("Validation Started");
//     print("Problem Text: ${problem.text}");
//     if (problem.text.isEmpty) {
//       print("Problem is empty");
//       Get.snackbar("Alert", "Please describe your problem!",
//           backgroundColor: Colors.red, colorText: Colors.white,snackPosition: SnackPosition.BOTTOM,);
//       return false;
//     }
//     print("Time Slot ID: $time_slot_id");
//     if (time_slot_id.isEmpty) {
//       print("Time slot is empty");
//       Get.snackbar("Alert", "Please select a time slot!",
//           backgroundColor: Colors.red, colorText: Colors.white,snackPosition: SnackPosition.BOTTOM,);
//       return false;
//     }
//     print("Selected Day: $selectedDay");
//     if (selectedDay == null) {
//       print("Date is null");
//       Get.snackbar("Alert", "Please select a date!",
//           backgroundColor: Colors.red, colorText: Colors.white,snackPosition: SnackPosition.BOTTOM,);
//       return false;
//     }
//     print("Selected Image IDs: $selectedImageIds");
//     if (selectedImageIds.isEmpty) {
//       print("No disease selected");
//       Get.snackbar("Alert", "Please select at least one disease!",
//           backgroundColor: Colors.red, colorText: Colors.white,snackPosition: SnackPosition.BOTTOM,);
//       return false;
//     }
//     print("Uploaded Images: ${uploadedImages.length}");
//     if (uploadedImages.isEmpty) {
//       print("No images uploaded");
//       Get.snackbar("Alert", "Please upload at least one image!",
//           backgroundColor: Colors.red, colorText: Colors.white,snackPosition: SnackPosition.BOTTOM,);
//       return false;
//     }
//     print("Validation Passed");
//     return true;
//   }
//
//   Future<bool?> postData(String userId) async {
//     if (!validation()) {
//       return false;
//     }
//
//     try {
//       util.startLoading(); // Loading start
//       var request = http.MultipartRequest(
//         'POST',
//         Uri.parse("${AppConstant.BASE_URL}/api/appointment"),
//       );
//
//       // Headers
//       request.headers.addAll({
//         "x-api-key": "dentist@123",
//       });
//
//       // Fields
//       request.fields['date'] =
//       "${selectedDay!.year}-${selectedDay!.month.toString().padLeft(2, '0')}-${selectedDay!.day.toString().padLeft(2, '0')}";
//       request.fields['user_id'] = userId;
//       request.fields['time_slot_id'] = time_slot_id;
//       request.fields['description'] = problem.text;
//       request.fields['image_id'] = selectedImageIds.join(',');
//
//       // Images ko base64 string ke roop mein alag-alag fields mein add karo
//       if (uploadedImages.isNotEmpty) {
//         for (var i = 0; i < uploadedImages.length; i++) {
//           var file = uploadedImages[i];
//           if (await file.exists()) {
//             var fileSize = await file.length();
//             if (fileSize > 5 * 1024 * 1024) {
//               Get.snackbar("Error", "Image ${path.basename(file.path)} is too large (>5MB)");
//               return false;
//             }
//             // File ko base64 string mein convert karo
//             List<int> imageBytes = await file.readAsBytes();
//             String base64Image = base64Encode(imageBytes);
//             // Har image ke liye alag images[] field add karo
//             request.fields['images[$i]'] = base64Image;
//             print("Base64 Image Added: ${path.basename(file.path)} at index $i");
//           } else {
//             Get.snackbar("Error", "Image ${path.basename(file.path)} does not exist");
//             return false;
//           }
//         }
//       }
//
//       // Log request details
//       print("Request Headers: ${request.headers}");
//       print("Request Fields: ${request.fields}");
//
//       // Request bhejo
//       var response = await request.send();
//       var responseBody = await response.stream.bytesToString();
//       print("API Status: ${response.statusCode}");
//       print("API Response: $responseBody");
//
//       // Response parse karo
//       try {
//         var jsonResponse = jsonDecode(responseBody);
//         bool isSuccess = jsonResponse['status'] == true;
//
//         if (response.statusCode == 200 || response.statusCode == 201) {
//           if (isSuccess) {
//             // Check for image upload confirmation
//             if (jsonResponse['body'] != null && jsonResponse['body'][0]['appointment_images'] != null) {
//               print("Uploaded Images: ${jsonResponse['body'][0]['appointment_images']}");
//               Get.snackbar(
//                 "Success",
//                 "Appointment and images uploaded successfully! Total images: ${jsonResponse['body'][0]['appointment_images'].length}",
//                 backgroundColor: Colors.green,
//                 colorText: Colors.white,
//                 duration: Duration(seconds: 3),
//               );
//             } else {
//               Get.snackbar(
//                 "Warning",
//                 "Appointment booked but images not uploaded!",
//                 backgroundColor: Colors.yellow,
//                 colorText: Colors.black,
//                 duration: Duration(seconds: 3),
//               );
//             }
//
//             // Clear fields
//             date.clear();
//             time.clear();
//             problem.clear();
//             selectedDay = null;
//             seletecd_time_slot.value = "";
//             time_slot_id = "";
//             selectedImageIds.clear();
//             uploadedImages.clear();
//             await Future.delayed(Duration(milliseconds: 500));
//             Get.back();
//             return isSuccess;
//           } else {
//             Get.snackbar(
//               "Warning",
//               "Appointment not booked: ${jsonResponse['message'] ?? 'Unknown error'}",
//               backgroundColor: Colors.blue,
//               colorText: Colors.white,
//               duration: Duration(seconds: 3),
//             );
//             return false;
//           }
//         } else {
//           Get.snackbar(
//             "Error",
//             "Appointment not booked: $responseBody",
//             backgroundColor: Colors.red,
//             colorText: Colors.white,
//             duration: Duration(seconds: 3),
//           );
//           return false;
//         }
//       } catch (e) {
//         Get.snackbar(
//           "Error",
//           "Response parsing failed: $responseBody",
//           backgroundColor: Colors.red,
//           colorText: Colors.white,
//           duration: Duration(seconds: 3),
//         );
//         return false;
//       }
//     } catch (e) {
//       Get.snackbar(
//         "Error",
//         "Something went wrong: $e",
//         backgroundColor: Colors.red,
//         colorText: Colors.white,
//         duration: Duration(seconds: 3),
//       );
//       return false;
//     } finally {
//       util.stopLoading();
//     }
//   }
// }