import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/notification_details_res.dart' as notificationDetailsDTO;
import '../Utills/Utills.dart';
import 'package:dentocoreauth/data/repository/auth_repository/notification_repo.dart';
import '../models/notificationDTO.dart' as myNotificationDTO;
import '../models/notificationDTO.dart';

class NotificationController extends GetxController {
  final NotificationRepository notificationRepository;

  NotificationController({required this.notificationRepository});

  var util = Utills();

  RxBool _isLoading = false.obs;

  RxBool get isloading => _isLoading;

  RxBool _isVisble = false.obs;

  RxBool get isVisibile => _isVisble;


  RxInt _noOfMsg=0.obs;

  RxInt get noOfMsg=>_noOfMsg;

  RxList<NotificationBody?> _getlist = <NotificationBody>[].obs;

  RxList<notificationDetailsDTO.Prescription?> _getdeails = <notificationDetailsDTO.Prescription?>[].obs;

  RxList<NotificationBody?> get getlist => _getlist;

  RxList<notificationDetailsDTO.Prescription?> get getdetails => _getdeails;

  var user_data = [];
  var load_status = true;
  var userid = "";

  void setDot(bool val) {
    _isVisble.value = val;
  }

  void getUserData(key) async {
    final sp = await SharedPreferences.getInstance();
    user_data = sp.getStringList(key)?? [];
    userid = user_data?[0].toString() ?? "";
    getNotifications(userid);
  }

  @override
  void onInit() {
    getUserData("user_data");
  }

  Future<myNotificationDTO.NotificationDto?> getNotifications(
      String uid) async {
    var res = await notificationRepository.getNotification(uid);
    debugPrint("nj_notification" + "called");
    util.startLoading();
    _isLoading(true);
    if (res.statusCode == 200 || res.statusCode == 201) {
      util.stopLoading();
      debugPrint("nj_notification" + "200");
      debugPrint("Abhi:- nj_notification" + "notification --> ${res.body}");
      final response = jsonDecode(res.bodyString!);
      if (response["status"] == false) {
        debugPrint("nj_notification" + "false");
        util.stopLoading();
        _getlist.value.clear();
        _getlist.refresh();
        _noOfMsg.value=0;
        _isLoading(false);
      } else {
        util.stopLoading();
        debugPrint("nj_notification" + "true");
        _isLoading(false);
      }
      var myres = myNotificationDTO.notificationDtoFromJson(res.bodyString!);
      _getlist.value.clear();
      _getlist.value = myres.body;
      _noOfMsg.value=0;
      _noOfMsg.value=_getlist.value.length;
      _getlist.refresh();
      update();
      debugPrint("nj_notification" + _isLoading.toString());
      _isLoading(false);
      debugPrint("nj_notification" + "before".toString());

      // return myNotificationDTO.notificationDtoFromJson(res.body);
      return myNotificationDTO.notificationDtoFromJson(res.body);
    } else if (res.statusCode == 400) {
      util.stopLoading();
      _isLoading(false);
      debugPrint("nj_notification" + _isLoading.toString());
    //  util.showSnackBar("Alert", "error", false);
      return null;
    }else{
      util.stopLoading();
      _isLoading(false);
      debugPrint("nj_notification" + _isLoading.toString());
     // util.showSnackBar("Alert", "error", false);
      return null;
    }
  }

  Future<notificationDetailsDTO.NotificationDetailsResDto?> getNotificationsDetails(
      String uid) async {
    var res = await notificationRepository.getNotificationDetails(uid);
    debugPrint("nj_notification_details" + "called");
    util.startLoading();
    _isLoading(true);
    if (res.statusCode == 200 || res.statusCode == 201) {
      util.stopLoading();
      debugPrint("nj_notification_details" + "200");
      final response = jsonDecode(res.bodyString!);
      if (response["status"] == false) {
        debugPrint("nj_notification_details" + "false");
        _isLoading(false);
      } else {
        debugPrint("nj_notification_details" + "true");
      }
      var myres = notificationDetailsDTO.notificationDetailsResDtoFromJson(res.bodyString!);
      _getdeails.value = myres.body.prescription;
      _getdeails.refresh();
      update();
      debugPrint("nj_notification_details" + _isLoading.toString());
      _isLoading(false);
      debugPrint("nj_notification_details" + "before".toString());

      return myres;
    } else if (res.statusCode == 400) {
      util.stopLoading();
      _isLoading(false);
      debugPrint("nj_notification_details" + _isLoading.toString());
      util.showSnackBar("Alert", "error", false);
      return null;
    }
  }





}
