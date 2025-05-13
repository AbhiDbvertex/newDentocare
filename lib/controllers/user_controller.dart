import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dentocoreauth/data/repository/auth_repository/user_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/bannerDTO.dart' as MybannerDTO;

import '../models/chat_read_status.dart' as ReadStatusDTO;
import '../models/appointment_response.dart' as myAppResponse;
import '../models/prescription_dto.dart' as myPrescription;
import '../Utills/Utills.dart';
import '../models/appointment_response.dart';
import '../models/bannerDTO.dart';
import '../models/prescription_dto.dart';
import '../utils/app_constant.dart';

class UserController extends GetxController {
  final UserRepositry userRepositry;

  UserController({required this.userRepositry});

  RxList<AppointmentBody?> _getlist = <AppointmentBody?>[].obs;

  var _getPrescription = PrescriptionBody().obs;

  PrescriptionBody get getPrescription => _getPrescription.value;

  RxString _getimage = "".obs;
  RxString _gettitle = "".obs;
// New list to store banner items
  RxList<BannerItem> _bannerItems = <BannerItem>[].obs;

  // Getter for banner items
  RxList<BannerItem> get bannerItems => _bannerItems;


  var _chatdata = ReadStatusDTO.ChatStatusData().obs;

  Rx<ReadStatusDTO.ChatStatusData> get chatdata => _chatdata;

  var _isLoading = false.obs;

  var listlen = 0.obs;

  get isLoading => _isLoading;

  RxString get getimage => _getimage;

  RxString get gettitle => _gettitle;

  RxBool _readStatus = false.obs;

  RxBool get readStatus => _readStatus;

  var user_data = [];
  var load_status = false;
  var userid = "";

  var listOfGradinetColor = [
    AppConstant.paitent_1_bg,
    AppConstant.paitent_2_bg,
    AppConstant.paitent_3_bg,
    AppConstant.paitent_4_bg,
    AppConstant.paitent_5_bg,
  ];


  @override
  void onClose() {

  }

  @override
  void dispose() {

  }

  @override
  void onInit() {
    getBanner();

  } // void getUserData(key) async {
  //   final sp = await SharedPreferences.getInstance();
  //   user_data = sp.getStringList(key)!;
  //   userid = user_data[0].toString();
  //   Future.delayed(Duration(milliseconds: 500), () {
  //     getAppointmentlist("${userid}}");
  //   });
  // }

  RxList<AppointmentBody?> get getlist => _getlist;

  var util = Utills();

  Future<myAppResponse.AppointmentDto?> getAppointmentlist(String uid) async {
    util.startLoading();
    var res = await userRepositry.getAppointmentList(uid);
    print("Abhi:-userId $uid");
    if (res.statusCode == 200 || res.statusCode == 201) {
      util.stopLoading();

      debugPrint("appointment_data1" + res.body.toString());

      var temp = myAppResponse.appointmentDtoFromJson(res.bodyString!);
      debugPrint("appointment_data1" + "code run");

      if (temp.status == false) {
        debugPrint("datadebug" + "false");
        _isLoading.value = false;
        _getlist.value.clear();
        _getlist.refresh();
      //  update();
      } else {
        debugPrint("datadebug" + "true");
        _isLoading.value = true;

        _getlist.value.clear();
        _getlist.assignAll(temp.body);
       // _getlist.value = temp.body;
        debugPrint("datadebug" + "${_getlist.value.first!.status}");
        _getlist.refresh();
        update();
        listlen.value = temp.body.length;
        if (listlen.value > listOfGradinetColor.length) {
          for (int i = 0; i < listlen.value; i++) {
            listOfGradinetColor.add(listOfGradinetColor[i]);
          }
        }

        //util.showSnackBar("Alert", _getlist.length.toString(), true);

        //var jsonResponse = jsonDecode(res.body!);

        return temp;
      }
      var tempdata = jsonDecode(res.bodyString!);
      debugPrint("datadebug" + tempdata['status'].toString());
      // util.showSnackBar("Alert", tempdata['status'].toString(), true);

      _getlist.value.clear();
      _getlist.value = temp.body;
      _getlist.refresh();
      update();
      listlen.value = temp.body.length;
      if (listlen.value > listOfGradinetColor.length) {
        for (int i = 0; i < listlen.value; i++) {
          listOfGradinetColor.add(listOfGradinetColor[i]);
        }
      }

      //util.showSnackBar("Alert", _getlist.length.toString(), true);

      //var jsonResponse = jsonDecode(res.body!);

      return temp;
    } else if (res.statusCode == 400) {
      util.stopLoading();
      // util.showSnackBar("Alert", "error", false);
    } else {
      util.stopLoading();
    }
  }

  Future<void> UpdateRescheduled(String appointment_id, String confirm) async {
    util.startLoading();
    debugPrint("resheduled"+"called");
    var res = await userRepositry.updateRescheduled(
        {"appointment_id": appointment_id, "reshedule_status": confirm});
    if (res.statusCode == 200 || res.statusCode == 201) {
      util.stopLoading();

      debugPrint("resheduled"+"200");
      util.showSnackBar("Alert", "Updated, Please pull down to refresh list", true);

    } else {
      util.stopLoading();
      debugPrint("resheduled"+"failed");
    }
  }

  Future<myPrescription.PrescriptionDto?> getPrescction(String uid) async {
    util.startLoading();
    var res = await userRepositry.getPrescriptionList(uid);
    if (res.statusCode == 200 || res.statusCode == 201) {
      util.stopLoading();

      debugPrint("appointment_data1" + res.body.toString());

      var temp = myPrescription.prescriptionDtoFromJson(res.bodyString!);
      if (temp.body.next == '[]') {
        debugPrint("appointment_data1" + "next empty");
      }
      debugPrint("appointment_data1" + "code run");

      _getPrescription(temp!.body!);
      _getPrescription.refresh();
      update();

      //util.showSnackBar("Alert", _getlist.length.toString(), true);

      //var jsonResponse = jsonDecode(res.body!);

      return temp;
    } else if (res.statusCode == 400) {
      util.stopLoading();
      //util.showSnackBar("Alert", "error", false);
    }
  }

  Future<BannerDto?> getBanner() async {
    var res = await userRepositry.getBanner();
    if (res.statusCode == 200) {
      var temp = MybannerDTO.bannerDtoFromJson(res.bodyString!!);
      _getimage.value = temp!.body.image;
      _gettitle.value = temp!.body.title;

      return temp;
    } else if (res.statusCode == 400) {
      //util.showSnackBar("Alert", "error", false);
    }
  }
  // var getHomeimage = <Widget>[].obs;


  Future<BannerHomeDto?> getHomeBanner() async {
    var res = await userRepositry.getHomeBanner();
    if (res.statusCode == 200) {
      var temp = BannerHomeDto.fromJson(jsonDecode(res.bodyString!));
      _bannerItems.assignAll(temp.body); // Store all banner items
      _bannerItems.refresh();
      update();
      return temp;
    } else if (res.statusCode == 400) {
      // Handle error
      util.showSnackBar("Error", "Failed to fetch banners", false);
    }
    return null;
  }

  Future<ReadStatusDTO.ChatReadStatusDto?> getChatStatus(String uid) async {
    var res = await userRepositry.getChatStatus(uid);
    if (res.statusCode == 200) {
      var temp = ReadStatusDTO.chatReadStatusDtoFromJson(res.bodyString!!);
      _chatdata.value = temp.data;
      if (temp.data.readStatus.toString() == "1") {
        _readStatus.value = true;
      } else if ((temp.data.readStatus.toString() == "0")) {
        _readStatus.value = false;
      }
      _readStatus.refresh();
      _chatdata.refresh();
      debugPrint("chatstatus" + _chatdata.value.readStatus.toString());
      return temp;
    } else if (res.statusCode == 400) {
      //util.showSnackBar("Alert", "error", false);
    }
  }



}

// banner_home_dto.dart
class BannerHomeDto {
  final bool status;
  final List<BannerItem> body;

  BannerHomeDto({required this.status, required this.body});

  factory BannerHomeDto.fromJson(Map<String, dynamic> json) => BannerHomeDto(
    status: json['status'],
    body: List<BannerItem>.from(
        json['body'].map((x) => BannerItem.fromJson(x))),
  );
}

class BannerItem {
  final String title;
  final String image;

  BannerItem({required this.title, required this.image});

  factory BannerItem.fromJson(Map<String, dynamic> json) => BannerItem(
    title: json['title'],
    image: json['image'],
  );
}
