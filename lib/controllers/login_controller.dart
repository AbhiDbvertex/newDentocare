import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:dentocoreauth/data/repository/auth_repository/auth_repository.dart';
import 'package:dentocoreauth/models/auth_model/signup_dto.dart';
import 'package:dentocoreauth/pages/auth/otp/otp.dart';
import 'dart:convert';
import '../models/auth_model/signup_dto.dart' as logindto;
import '../models/loginErrorDTO.dart' as loginerror;
import '../Utills/Utills.dart';
import '../models/loginErrorDTO.dart';

class LoginController extends GetxController {
  final AuthRepository authRepository;

  LoginController({required this.authRepository});

  //var service = AuthService();
    var util = Utills();
    var log_email = TextEditingController();
    var log_password = TextEditingController();
    var isLoading = false.obs;
    var isRemember = false.obs;
    var countryCode = "+91".obs;
    // String input = log_email.text.trim();
    // bool isEmail = input.contains('@');

  bool check() {
    if (log_email.text.isEmpty /*|| !EmailValidator.validate(log_email.text)*/) {
      util.showSnackBar(
          "Alert", "Please enter your valid email or number address!", false);
      return false;
    } else if (log_password.text.isEmpty) {
      util.showSnackBar("Alert", "Please enter your valid password!", false);
      return false;
    } else {
      return true;
    }
  }

  Future<SignUpDto?> loginByGoogle(String name, String email) async {
    util.startLoading();
    debugPrint("debuggoogle"+"Api called");

    var res =
        await authRepository.loginByGoogle({"email": email, "name": name});

    if (res.statusCode == 201 || res.statusCode == 200) {
      debugPrint("debuggoogle" + "200");
      util.showFailProcess();

      var temp = jsonDecode(res.bodyString!);


      if (temp['message'].toString() == "otp not verified") {
        debugPrint("debuggoogle" + "otp not verified");
        util.showSnackBar("Alert", "${temp['message'].toString()}", true);
        // Get.to(Otp(log_email.text, "login"));
      } else {
        debugPrint("debuggoogle" + "else");
        debugPrint("debuggoogle" + "${res.bodyString!}");

        // util.showSnackBar("Alert", "success", true);
        //goto home
        log_email.text = "";
        log_password.text = "";
        return logindto.signUpDtoFromJson(res.bodyString!);
      }

      log_email.text = "";
      log_password.text = "";
      return null;
    } else if (res.statusCode == 400) {
      util.showFailProcess();
      debugPrint("debuggoogle" + "400");
      var temp = jsonDecode(res.bodyString!);
      debugPrint("logresponse" + temp.toString());
      var error = loginerror.loginerrorDtoFromJson(res.bodyString!);

      if (error.status == 400) {
        util.showSnackBar("Alert", error.messages.error.toString(), false);
      } else {
        util.showSnackBar("Alert", "Something went wrong!", false);
      }
    } else {
      debugPrint("debuggoogle" + "failed");
      util.showFailProcess();
      debugPrint("logindebug" + "someting wnt wrong");
      return null;
    }
  }

  /*Future<SignUpDto?> login() async {
    if (check() == false) {
      return null;
    }

    debugPrint("logindebug" + "called");
    util.startLoading();

    String input = log_email.text.trim();
    bool isEmail = input.contains('@');

    var res = await authRepository.login({
      "email": isEmail ? input : "",
      "mobile": isEmail ? "" : input,
      "password": log_password.text.toString(),
    });

    if (res.statusCode == 201 || res.statusCode == 200) {
      debugPrint("logindebug" + "200");
      util.showFailProcess();

      var temp = jsonDecode(res.bodyString!);

      if (temp['message'].toString() == "OTP not verified. Please verify using the OTP sent to your email.") {
        util.showSnackBar("Alert", "${temp['message'].toString()}", true);
        Get.to(Otp(log_email.text, "login"));
      } else {
        log_email.text = "";
        log_password.text = "";
        return logindto.signUpDtoFromJson(res.bodyString!);
      }

      log_email.text = "";
      log_password.text = "";
      return null;
    } else if (res.statusCode == 400) {
      util.showFailProcess();
      debugPrint("logindebug" + "400");
      print("");
      var temp = jsonDecode(res.bodyString!);
      debugPrint("logresponse" + temp.toString());
      var error = loginerror.loginerrorDtoFromJson(res.bodyString!);

      if (error.status == 400) {
        util.showSnackBar("Alert", error.messages.error.toString(), false);
      } else {
        util.showSnackBar("Alert", "${error.messages.error.toString()}", false);
      }
    } else {
      util.showFailProcess();
      debugPrint("logindebug" + "someting wnt wrong");
      util.showSnackBar("Alert ", "${error.messages.error.toString()}", false);
      return null;
    }
  }*/
  Future<SignUpDto?> login() async {
    if (check() == false) return null;

    debugPrint("logindebug called");
    util.startLoading();

    String input = log_email.text.trim();
    bool isEmail = input.contains('@');

    var res = await authRepository.login({
      "email": isEmail ? input : "",
      "mobile": isEmail ? "" : input,
      "password": log_password.text.toString(),
    });

    util.showFailProcess(); // sab case me chalega

    if (res.statusCode == 200 || res.statusCode == 201) {
      debugPrint("logindebug 200");
      var temp = jsonDecode(res.bodyString!);

      if (temp['message'].toString() == "OTP not verified. Please verify using the OTP sent to your email.") {
        util.showSnackBar("Alert", temp['message'].toString(), true);
        Get.to(Otp(log_email.text, "login"));
      } else {
        log_email.text = "";
        log_password.text = "";
        return logindto.signUpDtoFromJson(res.bodyString!);
      }
    } else {
      debugPrint("logindebug ${res.statusCode}");
      var temp = jsonDecode(res.bodyString!);
      debugPrint("logresponse $temp");

      // Yahan se bas direct API ka message dikhayenge
      String msg = temp['messages']?['error']?.toString() ?? "Unknown error";
      util.showSnackBar("Alert", msg, false);
    }

    log_email.text = "";
    log_password.text = "";
    return null;
  }


}
