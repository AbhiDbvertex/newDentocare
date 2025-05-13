import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:dentocoreauth/pages/auth/otp/otp.dart';

import '../Utills/Utills.dart';
import '../data/repository/auth_repository/auth_repository.dart';

class ForgotPasswordController extends GetxController {
  final AuthRepository authRepository;

  ForgotPasswordController({required this.authRepository});

  final email = TextEditingController();
  final util = Utills();

  Future<void> forgotPassword() async {
    debugPrint("forgetcalled");
    if (email.text.isEmpty) {
      util.showSnackBar("Alert", "Email field is empty!", false);
      return null;
    }
    util.startLoading();
    var res = await authRepository.forgotPassword(email.text.toString());

    if (res.statusCode == 200 || res.statusCode == 201) {
      print("Abhi:- forgot password resend otp response ${res.body}");
      util.showFailProcess();
      var temp = jsonDecode(res.bodyString!!);
      if (temp['message'] == "Otp Sent successfully.") {
        util.showSnackBar("Alert", temp['message'], true);
        Get.to(Otp(email.text, "forget_password"));
      }
    } else if (res.statusCode == 400) {
      util.showFailProcess();
      var temp = jsonDecode(res.bodyString!!);
      if (temp['messages']['error'].toString().isNotEmpty) {
        util.showSnackBar("Alert", temp['messages']['error'].toString(), false);
      }
    } else {
      util.showFailProcess();
    }
  }
}
