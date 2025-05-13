import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Utills {
  click() {
    showSnackBar("Alert", "clicked", true);
  }

  showSnackBar(String title, String msg, bool isSuccess, {Duration? duration=null,bool? isDismisable=true,SnackPosition? position=SnackPosition.BOTTOM,Duration? dur}) {
    Get.snackbar(
      title,
      msg,
      snackPosition: position,
      backgroundColor: isSuccess == true ? Colors.blue : Colors.red,
      borderRadius: 20,
      margin: EdgeInsets.all(15),
      colorText: Colors.white,
      duration: dur==null?Duration(seconds: 2):dur,
      isDismissible: isDismisable,
      forwardAnimationCurve: Curves.easeOutBack,snackStyle: SnackStyle.FLOATING,
    );
  }

  startLoading() {
    EasyLoading.show(status: 'loading...');
  }

  showSuccessProcess() {
    EasyLoading.dismiss();
  }

  showFailProcess() {
    EasyLoading.dismiss();
  }


  void stopLoading() {
    EasyLoading.dismiss();
  }

  void setData(String key, dynamic value) => GetStorage().write(key, value);

  dynamic getData(String key) => GetStorage().read(key);

  void clearData() async => GetStorage().erase();

}

// EasyLoading.show(status: 'loading...');
//
// EasyLoading.showProgress(0.3, status: 'downloading...');
//
// EasyLoading.showSuccess('Great Success!');
//
// EasyLoading.showError('Failed with Error');
//
// EasyLoading.showInfo('Useful Information.');
//
// EasyLoading.showToast('Toast');
//
// EasyLoading.dismiss();
