// import 'dart:convert';
//
// import 'package:email_validator/email_validator.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:get/get.dart';
// import 'package:dentocoreauth/models/auth_model/signup_dto.dart';
// import 'package:http/http.dart' as http;
// import 'package:dentocoreauth/pages/auth/otp/otp.dart';
// import '../Utills/Utills.dart';
// import '../data/repository/auth_repository/auth_repository.dart';
// import '../models/auth_model/signup_dto.dart' as signupdto;
//
// class SignupController extends GetxController {
//   final AuthRepository authRepository;
//
//   SignupController({required this.authRepository});
//
//   var util = Utills();
//
//   var isLoading = false.obs;
//   var countryCode = "+91".obs;
//
//   var name = TextEditingController();
//   var email = TextEditingController();
//   var phone = TextEditingController();
//   var password = TextEditingController();
//   var address = TextEditingController();
//
//   bool check() {
//      if (name.text.isEmpty) {
//     util.showSnackBar("Alert", "Please enter your name", false);
//     return false;
//     }
//     if (email.text.isEmpty || !EmailValidator.validate(email.text)) {
//       util.showSnackBar("Alert", "Please enter your email address", false);
//       return false;
//     } else if (phone.text.isEmpty || phone.text.length < 10) {
//       util.showSnackBar("Alert", "Please enter your mobile number", false);
//       return false;
//     } else if (password.text.isEmpty || password.text.length < 8) {
//       util.showSnackBar("Alert", "Password length should be greater than 7 characters", false);
//       return false;
//     } else if (address.text.isEmpty ) {
//       util.showSnackBar("Alert", "Please enter your address", false);
//       return false;
//     } else {
//       debugPrint("debugsignup:"
//           "${name.text.toString()}"
//           "${email.text.toString()}"
//           "${address.text.toString()}"
//           "${phone.text.toString()}"
//           "${password.text.toString()}");
//       return true;
//     }
//   }
//
//   Future<SignUpDto?> signUp() async {
//     if (check() == false) {
//       return null;
//     }
//     util.startLoading();
//     debugPrint("signup"+"called");
//     var res = await authRepository.Signup(
//         name.text.toString(),
//         email.text.toString(),
//         address.text.toString(),
//         phone.text.toString(),
//         password.text.toString());
//
//     if (res.statusCode == 201 || res.statusCode == 200) {
//       debugPrint("signup"+"200");
//       util.showFailProcess();
//
//       var temp = await jsonDecode(res.bodyString!);
//       print("Abhi :- ${res.body}");
//       debugPrint("signup"+temp.toString());
//         if (temp['message'].toString() == "User created successfully.") {
//         //  util.showSnackBar("Alert", "${temp['message'].toString()}", true);
//           util.showSnackBar("Alert", "Otp sent to registered email.", true);
//           Get.to(Otp(email.text.toString(), "registration"));
//         } else {
//           util.showSnackBar("Alert", "${temp['message'].toString()}", true);
//         }
//
//       //util.showSnackBar("Alert", res.bodyString.toString(), true);
//       // var response = signUpDtoFromJson(res.bodyString!);
//       // debugPrint("Signup_ressponse1" + res.bodyString.toString());
//       // return response;
//     } else if (res.statusCode == 400) {
//       util.showFailProcess();
//       debugPrint("signup"+"400");
//       var temp = jsonDecode(res.bodyString!);
//
//       if (temp['messages']['error'].toString().isNotEmpty) {
//         util.showFailProcess();
//         util.showSnackBar("Alert", temp['messages']['error'].toString(), false);
//         return null;
//       }else{
//         util.showSnackBar("Alert", "failed:${res.statusCode.toString()}", false);
//         return null;
//       }
//     }else{
//       util.showFailProcess();
//       debugPrint("signup"+"called");
//     }
//   }
// }

          ///  upar vala code sahi hai

// import 'dart:convert';
//
// import 'package:email_validator/email_validator.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:get/get.dart';
// import 'package:dentocoreauth/models/auth_model/signup_dto.dart';
// import 'package:http/http.dart' as http;
// import 'package:dentocoreauth/pages/auth/otp/otp.dart';
// import '../Utills/Utills.dart';
// import '../data/repository/auth_repository/auth_repository.dart';
// import '../models/auth_model/signup_dto.dart' as signupdto;
//
// class SignupController extends GetxController {
//   final AuthRepository authRepository;
//
//   SignupController({required this.authRepository});
//
//   var util = Utills();
//
//   var isLoading = false.obs;
//   var countryCode = "+91".obs;
//
//   var name = TextEditingController();
//   var email = TextEditingController();
//   var phone = TextEditingController();
//   var password = TextEditingController();
//   var address = TextEditingController();
//   var confirmPassword = TextEditingController();
//
//   bool check() {
//     if (name.text.isEmpty) {
//       util.showSnackBar("Alert", "Please enter your name", false);
//       return false;
//     }
//     if (email.text.isEmpty || !EmailValidator.validate(email.text)) {
//       util.showSnackBar("Alert", "Please enter your email address", false);
//       return false;
//     }
//     if (phone.text.isEmpty || phone.text.length < 10) {
//       util.showSnackBar("Alert", "Please enter your mobile number", false);
//       return false;
//     }
//     if (password.text.isEmpty || password.text.length < 6) {
//       util.showSnackBar("Alert", "Password length should be greater than 6 characters", false);
//       return false;
//     }
//     if (confirmPassword.text.isEmpty) {
//       util.showSnackBar("Alert", "Please enter your confirm password", false);
//       return false;
//     }
//     if (confirmPassword.text != password.text) {
//       util.showSnackBar("Alert", "Confirm password does not match the password", false);
//       return false;
//     }
//     if (address.text.isEmpty) {
//       util.showSnackBar("Alert", "Please enter your address", false);
//       return false;
//     }
//     debugPrint("debugsignup:"
//         "${name.text.toString()}"
//         "${email.text.toString()}"
//         "${address.text.toString()}"
//         "${phone.text.toString()}"
//         "${password.text.toString()}"
//         "${confirmPassword.text.toString()}");
//     return true;
//   }
//
//   Future<SignUpDto?> signUp() async {
//     if (check() == false) {
//       return null;
//     }
//     util.startLoading();
//     debugPrint("signup"+"called");
//     var res = await authRepository.Signup(
//         name.text.toString(),
//         email.text.toString(),
//         address.text.toString(),
//         phone.text.toString(),
//         password.text.toString());
//
//     if (res.statusCode == 201 || res.statusCode == 200) {
//       debugPrint("signup"+"200");
//       util.showFailProcess();
//
//       var temp = await jsonDecode(res.bodyString!);
//       print("Abhi :- ${res.body}");
//       debugPrint("signup"+temp.toString());
//       if (temp['message'].toString() == "User created successfully.") {
//         //  util.showSnackBar("Alert", "${temp['message'].toString()}", true);
//         util.showSnackBar("Alert", "Otp sent to registered email.", true);
//         Get.to(Otp(email.text.toString(), "registration"));
//       } else {
//         util.showSnackBar("Alert", "${temp['message'].toString()}", true);
//       }
//
//       //util.showSnackBar("Alert", res.bodyString.toString(), true);
//       // var response = signUpDtoFromJson(res.bodyString!);
//       // debugPrint("Signup_ressponse1" + res.bodyString.toString());
//       // return response;
//     } else if (res.statusCode == 400) {
//       util.showFailProcess();
//       debugPrint("signup"+"400");
//       var temp = jsonDecode(res.bodyString!);
//
//       if (temp['messages']['error'].toString().isNotEmpty) {
//         util.showFailProcess();
//         util.showSnackBar("Alert", temp['messages']['error'].toString(), false);
//         return null;
//       }else{
//         util.showSnackBar("Alert", "failed:${res.statusCode.toString()}", false);
//         return null;
//       }
//     }else{
//       util.showFailProcess();
//       debugPrint("signup"+"called");
//     }
//   }
// }

import 'dart:convert';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:dentocoreauth/models/auth_model/signup_dto.dart';
import 'package:http/http.dart' as http;
import 'package:dentocoreauth/pages/auth/otp/otp.dart';
import '../Utills/Utills.dart';
import '../data/repository/auth_repository/auth_repository.dart';
import '../models/auth_model/signup_dto.dart' as signupdto;

class SignupController extends GetxController {
  final AuthRepository authRepository;

  SignupController({required this.authRepository});

  var util = Utills();

  var isLoading = false.obs;
  var countryCode = "+91".obs;

  var name = TextEditingController();
  var email = TextEditingController();
  var phone = TextEditingController();
  var password = TextEditingController();
  var address = TextEditingController();
  var confirmPassword = TextEditingController();
  var dob = TextEditingController();

  bool check() {
    if (name.text.isEmpty) {
      util.showSnackBar("Alert", "Please enter your name", false);
      return false;
    }
    if (email.text.isEmpty || !EmailValidator.validate(email.text)) {
      util.showSnackBar("Alert", "Please enter your email address", false);
      return false;
    }
    if (phone.text.isEmpty || phone.text.length < 10) {
      util.showSnackBar("Alert", "Please enter your mobile number", false);
      return false;
    }
    if (dob.text.isEmpty) {
      util.showSnackBar("Alert", "Please select your date of birth", false);
      return false;
    }
    // Validate age (must be at least 18 years old)
    try {
      final dobParts = dob.text.split('-');
      // final dobDate = DateTime(
      //     int.parse(dobParts[2]), int.parse(dobParts[1]), int.parse(dobParts[0]));
      final dobDate = DateTime(
        int.parse(dobParts[0]), // year
        int.parse(dobParts[1]), // month
        int.parse(dobParts[2]), // day
      );
      print("Abhi:- print date : ${dobDate}");
      final now = DateTime.now();
      final age = now.year - dobDate.year - ((now.month > dobDate.month || (now.month == dobDate.month && now.day >= dobDate.day)) ? 0 : 1);
      if (age < 18) {
        util.showSnackBar("Alert", "You must be at least 18 years old", false);
        return false;
      }
    } catch (e) {
      util.showSnackBar("Alert", "Invalid date of birth format", false);
      return false;
    }
    if (password.text.isEmpty || password.text.length < 8) {
      util.showSnackBar("Alert", "Password length should be greater than 7 characters", false);
      return false;
    }
    if (confirmPassword.text.isEmpty) {
      util.showSnackBar("Alert", "Please enter your confirm password", false);
      return false;
    }
    if (confirmPassword.text != password.text) {
      util.showSnackBar("Alert", "Confirm password does not match the password", false);
      return false;
    }
    if (address.text.isEmpty) {
      util.showSnackBar("Alert", "Please enter your address", false);
      return false;
    }
    debugPrint("debugsignup:"
        "${name.text.toString()}"
        "${email.text.toString()}"
        "${address.text.toString()}"
        "${phone.text.toString()}"
        "${password.text.toString()}"
        "${confirmPassword.text.toString()}"
        "${dob.text.toString()}");
    return true;
  }

  Future<SignUpDto?> signUp() async {
    if (check() == false) {
      return null;
    }
    util.startLoading();
    debugPrint("signup" + "called");
    debugPrint("Abhi:- signup" + "Name : ${name.text}, email : ${email.text}, address ${address.text}");
    var res = await authRepository.Signup(
        name.text.toString(),
        email.text.toString(),
        address.text.toString(),
        phone.text.toString(),
        password.text.toString(),
        dob.text.toString());

    if (res.statusCode == 201 || res.statusCode == 200) {
      debugPrint("signup" + "200");
      util.showFailProcess();

      var temp = await jsonDecode(res.bodyString!);
      print("Abhi :- ${res.body}");
      debugPrint("signup" + temp.toString());
      if (temp['message'].toString() == "User created successfully.") {
        //  util.showSnackBar("Alert", "${temp['message'].toString()}", true);
        util.showSnackBar("Alert", "Otp sent to registered email.", true);
        Get.to(Otp(email.text.toString(), "registration"));
      } else {
        util.showSnackBar("Alert", "${temp['message'].toString()}", true);
      }

      //util.showSnackBar("Alert", res.bodyString.toString(), true);
      // var response = signUpDtoFromJson(res.bodyString!);
      // debugPrint("Signup_ressponse1" + res.bodyString.toString());
      // return response;
    } else if (res.statusCode == 400) {
      util.showFailProcess();
      debugPrint("signup" + "400");
      var temp = jsonDecode(res.bodyString!);

      if (temp['messages']['error'].toString().isNotEmpty) {
        util.showFailProcess();
        util.showSnackBar("Alert", temp['messages']['error'].toString(), false);
        return null;
      } else {
        util.showSnackBar("Alert", "failed:${res.statusCode.toString()}", false);
        return null;
      }
    } else {
      util.showFailProcess();
      debugPrint("signup" + "called");
    }
  }
}