import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:dentocoreauth/pages/homepage/MyHomePage.dart';
import 'package:dentocoreauth/utils/app_constant.dart';

import '../Utills/Utills.dart';
import '../data/repository/auth_repository/auth_repository.dart';

class CreatePasswordController extends GetxController {
  final AuthRepository authRepository;

  CreatePasswordController({required this.authRepository});

  var create_password = TextEditingController();
  var con_create_password = TextEditingController();

  var util = Utills();

  bool validation() {
    if (create_password.text.isEmpty || create_password.text.length < 6) {
      util.showSnackBar("Alert", AppConstant.ERROR_NEW_PASSWORD, false);
      return false;
    } else if (con_create_password.text.isEmpty ||
        con_create_password.text.length < 6) {
      util.showSnackBar("Alert", AppConstant.ERROR_CONFIRM_NEW_PASSWORD, false);
      return false;
    } else if (create_password.text.toString().toLowerCase().trim() !=
        con_create_password.text.toString().toLowerCase().trim()) {
      util.showSnackBar("Alert", AppConstant.ERROR_PASSWORD_MATCH, false);
      return false;
    } else {
      return true;
    }
  }

  Future<void> create_pw(String mob,String userid) async {
    if (validation() == true) {
      util.startLoading();
      var res = await authRepository.createPassword(
          mob, create_password.text, con_create_password.text);

      if (res.statusCode == 200 || res.statusCode == 201) {
        util.stopLoading();
        util.showSnackBar("Alert", "Password changed successfully!", true);
        AppConstant.save_data("token", "${userid}");
        AppConstant.save_data("isFirst", "yes");
        Get.offAll(MyHomePage());
      } else if (res.statusCode == 400) {
        util.stopLoading();
        util.showSnackBar("Alert", "something went wrong!!", false);
      }
    }
  }
}
