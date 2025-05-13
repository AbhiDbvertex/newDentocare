import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:dentocoreauth/pages/auth/forgot_password/forgot_password.dart';
import 'package:dentocoreauth/utils/app_constant.dart';
import 'package:uuid/uuid.dart';

class ApiClient extends GetConnect implements GetxService {
  final String appBaseUrl;
  late Map<String, String> _mainHeaders;

  final uuid = Uuid();

  ApiClient({required this.appBaseUrl}) {
    baseUrl = appBaseUrl;
    timeout = Duration(seconds: 10);
    // _mainHeaders = {"x-api-key": "dentist@123",};
    _mainHeaders = {"x-api-key": "dentist@123", // Tumhara API key,
       };
  }

  //login
  Future<Response> login(
    String url,
    Map body,
  ) async {
    // String input = body["mobile"].text.trim();
    // bool isEmail = input.contains('@');
    final fcm = AppConstant.getString("fcm");
    FormData formData = FormData({
      "email": body["email"].toString(),
      "mobile": body["mobile"].toString(),
      "password": body["password"].toString(),
      "fcm_token": fcm
      // "fcm_token": 'cZ9fEyq-QVu50L14GYzQqL:APA91bHJneSSnKSG2bnI65Q-LwOEvMwB5W8-8MAXjy5oBhQ_DqACAhxrFrKsfxZgkO2uMEMYwF3OrLpqTQvpiOkc8VoRa22rvdjKw-F5kWNsEgQMKyXTkIw'
    });

    // debugPrint("fcmget" + fcm);

    try {
      var res = await post(url, formData, headers: _mainHeaders);
      return res;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> loginByGoogle(
    String url,
    Map body,
  ) async {
    final fcm = AppConstant.getString("fcm");
    FormData formData = FormData({
      "email": body["email"].toString(),
      "name": body["name"].toString(),
      "fcm_token": fcm
    });

    debugPrint("fcmget" + fcm!);

    try {
      var res = await post(url, formData, headers: _mainHeaders);
      return res;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> resendOtp(String url, String email) async {
    try {
      FormData formData = new FormData({"email": email.toString()});
      var res = post(url, formData, headers: _mainHeaders);
      return res;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  //signup

  // Future<Response> signUp(String url, String name, String email, String address,
  //     String mobile, String password) async {
  //   try {
  //     //debugPrint("njtest"+body.toString());
  //     final fcm = AppConstant.getString("fcm");
  //     print("Abhi:- print reaponse ${fcm ?? "no token"}");
  //     FormData formData = FormData({
  //       'name': name,
  //       'email': email,
  //       'address': address,
  //       'mobile': mobile,
  //       'password': password,
  //       "fcm_token": fcm ?? ""
  //     });
  //     debugPrint("fcmget" + fcm!);
  //     var res = await post(url, formData, headers: _mainHeaders);
  //     print("Abhi:-response ${res.body}");
  //     return res;
  //   } catch (e) {
  //     debugPrint("signup_error" + e.toString());
  //     return Response(statusCode: 1, statusText: e.toString());
  //   }
  // }

  Future<Response> signUp(String url, String name, String email, String address, String mobile, String password ,dynamic dob) async {
    try {
      final fcm = AppConstant.getString("fcm");
      print("Abhi:- print reaponse ${fcm ?? 'null'}"); // Null check ke saath print
      print("Abhi:- print signup response $name");
      print("Abhi:- print signup response $email");
      print("Abhi:- print signup response $address");
      print("Abhi:- print signup response $mobile");
      print("Abhi:- print signup response $password");
      print("Abhi:- print signup response $fcm");
      // print("Abhi:- print signup response $password");
      FormData formData = FormData({
        'name': name,
        'email': email,
        'address': address,
        'mobile': mobile,
        'password': password,
        'dob':dob,
        "fcm_token": fcm ?? "" // Agar null hai toh empty string bhej
      });
      debugPrint("fcmget" + (fcm ?? "null")); // Bang operator hata diya
      var res = await post(url, formData, headers: _mainHeaders);
      print("Abhi:- Headers: $_mainHeaders");
      print("Abhi:-response ${res.body}");
      return res;
    } catch (e) {
      debugPrint("signup_error" + e.toString());
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> uploadProfile(List<File> file, String name) async {
    var mymap = <String, MultipartFile>{};
    for (int i = 0; i < file.length; i++) {
      mymap.update(
          "img${i}",
          (value) =>
              MultipartFile(file[i].path, filename: "image${i}:" + uuid.v1()));
    }
    mymap.update("name", (value) => MultipartFile(name, filename: name));

    try {
      var res = await post("api/profile_update", mymap, headers: _mainHeaders);
      return res;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

//postinwork and dental authentication process flow

//login->data->home page(if not verified then)->sent otp->otppage->verify->data->home page
//signup->otpsent->otppage->verify->data->homepage(user may left before verification)
//forgot password->otp sent->otppage->verify->create password->data->home page

//resend otp

//verify otp

  Future<Response> verifyOtp(String url, String email, String otp) async {
    FormData formData = new FormData({"email": email, "otp": otp});

    try {
      var res = post(url, formData, headers: _mainHeaders);
      return res;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> forgotPassword(String url, String email) async {
    FormData formData = new FormData({"email": email});

    try {
      var res = post(url, formData, headers: _mainHeaders);
      return res;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> createPassword(String url, String email, String password,
      String confirm_password) async {
    FormData formData = new FormData({
      "email": email,
      "password": password,
      "confirmpassword": confirm_password
    });

    try {
      var res = post(url, formData, headers: _mainHeaders);
      return res;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> getProfile(String url) async {
    try {
      var res = get(url, headers: <String, String>{"x-api-key": "dentist@123"});
      return res;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> getnotification(String url) async {
    try {
      var res = get(url, headers: _mainHeaders);
      return res;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> getPaymentHistory(String url) async {
    try {
      var res = get(url, headers: <String, String>{"x-api-key": "dentist@123"});
      return res;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> getnotificationDetails(String url) async {
    try {
      var res = get(url, headers: <String, String>{"x-api-key": "dentist@123"});
      return res;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> getchat(String url) async {
    try {
      var res = get(url, headers: _mainHeaders);
      return res;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> sendChat(String url, Map body) async {

    String _formatTime(DateTime dateTime) {
      return DateFormat('yyyy-mm-dd hh:mm:ss').format(dateTime);
    }
    DateTime dateTime=DateTime.now();
    var t=_formatTime(dateTime);
    debugPrint("ctime=$t");

    try {
      FormData formData = FormData({
        "sender_id": body["sender_id"].toString(),
        "receiver_id": body['receiver_id'].toString(),
        "message": body['message'].toString(),
        "time":t,
        "image":body['image']==null?"":body['image'],
      });
      var res = post(url, formData,
          headers: <String, String>{"x-api-key": "dentist@123"});
      return res;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> updateChatStatus(String url, Map body) async {
    try {
      FormData formData = FormData({
        "user_id": body["user_id"].toString(),
      });
      var res = post(url, formData, headers: _mainHeaders);
      return res;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> getVideoLists(String url) async {
    try {
      var res = get(url,headers: _mainHeaders);
      return res;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> updateProfile(String url, Map body) async {
    try {
      FormData formData = FormData({
        "name": body["name"].toString(),
        "email": body['email'].toString(),
        "mobile": body['mobile'].toString(),
        "id": body['id'].toString()
      });
      var res = post(url, formData, headers: _mainHeaders);
      return res;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> updateProfileImage(String url, Map body) async {
    try {
      debugPrint("imagedebug" + body.toString());
      FormData formData = FormData({
        "id": body['id'].toString(),
        'photo': body['photo'] != null
            ? base64Encode(body['photo']!.readAsBytesSync())
            : ''
      });
      var res = post(url, formData, headers: _mainHeaders);
      return res;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> updateRescheduled(String url, Map body) async {
    try {
      debugPrint("Rescheduled" + body.toString());
      FormData formData = FormData({
        "appointment_id": body['appointment_id'].toString(),
        'reshedule_status': body['reshedule_status'].toString()
      });
      debugPrint("reshedulednew"+"${body['appointment_id'].toString()}  ${body['reshedule_status']}");
      var res = post(url, formData, headers: _mainHeaders);
      return res;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> getBanner(String url) async {
    try {
      var res = get(url,headers:<String,String>{"x-api-key":"dentist@123"});
      return res;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }



  Future<Response> getChatStatus(String url) async {
    try {
      var res = get(url, headers: _mainHeaders);
      return res;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> getAppointmentList(String url) async {
    try {
      var res = get(url, headers: _mainHeaders);
      return res;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> getPrescriptionList(
    String url,
  ) async {
    try {
      var res = get(url, headers: _mainHeaders);
      return res;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }
}
