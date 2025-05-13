import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
// import 'package:dentocoreauth/pages/homepage/MyHomePage.dart';
// import 'package:dentocoreauth/utils/app_constant.dart';
import '../Utills/Utills.dart';
import '../data/repository/auth_repository/auth_repository.dart';
import '../models/normal_dto.dart';
import '../models/verifyOtpDTO.dart' as VerifyOTPDTO;
import '../models/verifyOtpDTO.dart';

class OtpController extends GetxController {
  final AuthRepository authRepository;

  OtpController({required this.authRepository});

  final util = Utills();
  var result = [];

  var codesent = false;
  var total_chance = 0;
  var count = 10;

  var otp_otp = TextEditingController();

  bool validation() {
    if (otp_otp.text.isEmpty) {
      util.showSnackBar("Alert", "Please enter your otp", false);
      return false;
    } else {
      return true;
    }
  }

  /*getOtpagain(String mobile) async {
    print("fromlogin:" + "called");
    util.startLoading();
    var res = await http.post(
        Uri.parse(AppConstant.BASE_URL + AppConstant.POST_RESENDOTP),
        body: <String, String>{"mobile": mobile});
    if (res.statusCode == 200) {
      print("fromlogin:" + "200");
      EasyLoading.dismiss();
      util.showSnackBar("Alert", "Otp sent to registered number.", true);

      var body = res.body;
      var decoded = jsonDecode(body);

      if (decoded['status'] == true) {
        util.showSnackBar("Alert", "Otp sent to registered number.", true);
      } else {
        util.showSnackBar("Alert", "Something went wrong!", false);
      }
    } else {
      print("fromlogin:" + "failed");
      EasyLoading.dismiss();
      util.showSnackBar("Alert", "Something went wrong!", false);
    }
  }*/

  Future<VerifyOtpDto?> verifyOtp(String email, String otp) async {
    if (validation() == false) {
      return null;
    }
    util.startLoading();
    var res = await authRepository.verifyOtp(email, otp);
    debugPrint(
        "verifyotp" + res.bodyString! + "\n" + res.statusCode.toString());
    if (res.statusCode == 201 || res.statusCode == 200) {
      util.showFailProcess();

      var temp = jsonDecode(res.bodyString!);

      debugPrint("verifyotp ${res.statusCode}");

      if (temp['status'] == true) {
        otp_otp.text="";
        util.showSnackBar("Alert", temp['message'].toString(), true);
        return VerifyOTPDTO.verifyOtpDtoFromJson(res.bodyString!);
      }
    } else if (res.statusCode == 400) {
      util.showFailProcess();
      var temp = jsonDecode(res.bodyString!);
      if (temp['messages'].toString().isNotEmpty) {
        util.showSnackBar(
            "Alert", temp['messages']['message'].toString(), false);
      }
      return null;
    } else {
      util.showFailProcess();
      util.showSnackBar(
          "Alert", "Something went wrong.\nPlease try again later", false);
      return null;
    }
  }

  Future<void> resendOtp(String email) async {
    if (email.toString().isEmpty) {
      util.showSnackBar("Alert", "Please fill valid email address.", false);
      return null;
    }
    debugPrint("resendotp Abhi:-1" + "${email}");
    util.startLoading();
    var result = await authRepository.resendOtp(email);
    debugPrint("resendotp Abhi:-2" + result.bodyString.toString());
    debugPrint("resendotp Abhi:-2" + result.body.toString());
    if (result.statusCode == 200 || result.statusCode == 201) {
      debugPrint("resendotp:-Abhi:-3" + "${email}");
      util.showFailProcess();
      var temp = jsonDecode(result.bodyString!);
      if (temp['message'].toString() == "Otp Sent successfully.") {
        util.showSnackBar("Alert", temp['message'].toString(), true);
      }
    } else if (result.statusCode == 400) {
      util.showFailProcess();
      var temp = jsonDecode(result.bodyString!);
      if (temp['messages'].toString().isNotEmpty) {
        util.showSnackBar("Alert", temp['messages'].toString(), false);
      }
    } else {
      util.showFailProcess();
      util.showSnackBar(
          "Alert", "something went wrong.Please try again", false);
    }
  }

/*Future<void> verifyOtpp(String mobile, String otp) async {
    util.startLoading();
    var res = await http.post(
        Uri.parse(AppConstant.BASE_URL + AppConstant.POST_VERIFY),
        body: <String, String>{"mobile": mobile, "otp": otp});
    if (res.statusCode == 200) {
      EasyLoading.dismiss();
      util.showSnackBar("Alert", "Verification completed!.", true);

      var body = res.body;
      var decoded = jsonDecode(body);

      if (decoded['status'] == true) {
        //  var response = otpVerificationFromJson(body);
        // return response;
      } else {
        util.showSnackBar("Alert", "Something went wrong!", false);
        return null;
      }
    } else {
      EasyLoading.dismiss();
      util.showSnackBar("Alert", "Something went wrong!", false);
      return null;
    }
  }*/
}
