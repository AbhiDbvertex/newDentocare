import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

// import '../Utills/Utills.dart';
import '../data/repository/auth_repository/auth_repository.dart';
import '../pages/homepage/MyHomePage.dart';
import '../utills/Utills.dart';
import '../utils/app_constant.dart';

class ChangePasswordController extends GetxController {
  final AuthRepository authRepository;

  ChangePasswordController({required this.authRepository});

  final new_pass = TextEditingController();
  final re_new_pass = TextEditingController();
  final util = Utills();

  bool validation() {
    if (new_pass.text.isEmpty || new_pass.text.length < 8) {
      util.showSnackBar("Alert", "Please enter valid password", false);
      return false;
    } else if (re_new_pass.text.isEmpty || re_new_pass.text.length < 8) {
      util.showSnackBar("Alert", "Please enter valid re-password", false);
      return false;
    } else if (new_pass.text != re_new_pass.text) {
      util.showSnackBar("Alert", "Password not matched!", false);
      return false;
    } else {
      return true;
    }
  }

  Future<void> create_pw(String mob, String uid) async {
    if (validation() == true) {
      util.startLoading();
      var res = await authRepository.createPassword(
          mob, new_pass.text, re_new_pass.text);

      if (res.statusCode == 200 || res.statusCode == 201) {
        util.stopLoading();
        util.showSnackBar("Alert", "Password Changed", true);
        new_pass.text = "";
        re_new_pass.text = "";
        AppConstant.save_data("token", uid);
        AppConstant.save_data("isFirst", "yes");
        Get.offAll(MyHomePage());
      } else if (res.statusCode == 400) {
        util.stopLoading();
        util.showSnackBar("Alert", "something went wrong!!", false);
      }
    }
  }
}
