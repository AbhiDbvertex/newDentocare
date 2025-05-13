// import 'dart:async';
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bounceable/flutter_bounceable.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:dentocoreauth/pages/change_pasword/change_password.dart';
// import 'package:dentocoreauth/pages/homepage/MyHomePage.dart';
// import 'package:dentocoreauth/utils/app_constant.dart';
// import 'package:dentocoreauth/utils/mycolor.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// import '../../../Utills/Utills.dart';
// import '../../../controllers/otp_controller.dart';
// import '../create_password/create_password.dart';
// import '../login/login.dart';
//
// class Otp extends StatefulWidget {
//   var my_mobile = "";
//   var _from = "";
//
//   Otp(String mobile, String from, {super.key}) {
//     my_mobile = mobile;
//     this._from = from;
//   }
//
//   @override
//   State<Otp> createState() => _OtpState(my_mobile, _from);
// }
//
//
//
// class _OtpState extends State<Otp> {
//   var _from = "";
//   var _my_mobile = "";
//   var codesent = false;
//   var total_chance = 0;
//   var count = 60;
//
//   _OtpState(String my_mobile, String from) {
//     this._my_mobile = my_mobile;
//     this._from = from;
//   }
//
//   // final Otp_controller = Get.put(VerifyOtpController());
//   OtpController otpController = Get.find();
//
//   var util = Utills();
//   var isOtpClicked = false;
//
//   void saveUserData(key, value) async {
//     final sp = await SharedPreferences.getInstance();
//     setState(() {
//       sp.setStringList(key, value);
//     });
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//     otpController.dispose();
//     if (EasyLoading.isShow == true) {
//       EasyLoading.dismiss();
//     }
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     if (_from == "change_password") {
//       debugPrint("resendotp" + "${this._my_mobile}");
//       otpController.resendOtp(this._my_mobile);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: BackButtonArrow(backFunction: true,),
//       body: GestureDetector(
//         onTap: () {
//           FocusManager.instance.primaryFocus?.unfocus();
//           setState(() {
//             isOtpClicked = false;
//           });
//         },
//         behavior: HitTestBehavior.opaque,
//         child: SingleChildScrollView(
//           child: Container(
//             child: Column(
//               // mainAxisAlignment: MainAxisAlignment.spaceAround,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//
//                 SizedBox(
//                   height: 70,
//                 ),
//                 Center(
//                   child: Text(
//                     "Verification Code",
//                     style: GoogleFonts.openSans(
//                         textStyle: Theme.of(context).textTheme.displayLarge,
//                         fontSize: 25,
//                         fontWeight: FontWeight.w600,
//                         fontStyle: FontStyle.normal,
//                         color: MyColor.APP_TITLE_COLOR),
//                   ),
//                 ),
//                 SizedBox(
//                   height: AppConstant.LARGE_SIZE,
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(left: 13.0),
//                   child: Text(
//                     "Please type the verification code sent to\nabc@gmail.com",
//                     style: GoogleFonts.openSans(
//                         textStyle:
//                             Theme.of(context).textTheme.displayLarge,
//                         fontSize: AppConstant.SMALL_SIZE,
//                         // fontWeight: FontWeight.w600,
//                         fontStyle: FontStyle.normal,
//                         color: Colors.grey),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Column(
//                     children: [
//                       Padding(
//                         padding:
//                             const EdgeInsets.only(left: 8.0, top: 8.00),
//                         child: Align(
//                             alignment: Alignment.centerLeft,
//                             child: Text(AppConstant.TEXT_OTP_HEAD,
//                                 style: GoogleFonts.nunitoSans(
//                                     textStyle: Theme.of(context)
//                                         .textTheme
//                                         .displayLarge,
//                                     fontSize: AppConstant.MEDIUM_SIZE,
//                                     fontWeight: FontWeight.w600,
//                                     fontStyle: FontStyle.normal,
//                                     color: MyColor
//                                         .SIGNUP_TEXT_HEAD_COMMON_COLOR))),
//                       ),
//                       SizedBox(
//                         height: AppConstant.SMALL_TEXT_SIZE,
//                       ),
//                       Padding(
//                         padding: EdgeInsets.all(
//                           AppConstant.APP_NORMAL_PADDING,
//                         ),
//                         child: Container(
//                           decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(
//                                   AppConstant.APP_NORMAL_PADDING),
//                               border: Border.all(
//                                   color: Colors.grey, width: 1.0)),
//                           child: Column(
//                             children: [
//                               Container(
//                                 height: 60,
//                                 child: Padding(
//                                   padding: const EdgeInsets.all(8.0),
//                                   child: Center(
//                                     child: TextField(
//                                       onTap: () {
//                                         setState(() {
//                                           isOtpClicked = true;
//                                         });
//                                       },
//                                       controller: otpController.otp_otp,
//                                       decoration: new InputDecoration
//                                               .collapsed(
//                                           hintText:
//                                               AppConstant.HINT_TEXT_OTP,
//                                           hintStyle: TextStyle(
//                                               color: MyColor
//                                                   .LOGIN_TEXT_HINT_PASSWORD_COLOR)),
//                                       keyboardType:
//                                           TextInputType.number,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               Visibility(
//                                 visible:
//                                     isOtpClicked == true ? true : false,
//                                 child: SizedBox(
//                                   width: double.infinity,
//                                   height: 2,
//                                   child: Container(
//                                     color: Color(0xFF54E28D),
//                                   ),
//                                 ),
//                               )
//                             ],
//                           ),
//                         ),
//                       ),
//                       //resend otp
//                       Visibility(
//                       //  visible: codesent == false ? true : false,
//                         child: Padding(
//                           padding: const EdgeInsets.only(
//                               right: 16.0, top: 16.0),
//                           child: Align(
//                             alignment: Alignment.centerRight,
//                             child: Bounceable(
//                                 onTap: () {} /*{
//                                   if (_my_mobile.isEmpty ||
//                                       _my_mobile == "") {
//                                     util.showSnackBar(
//                                         "Alert",
//                                         "No mobile Number found.",
//                                         false);
//                                   } else {
//                                     otpController.resendOtp(_my_mobile);
//                                     // getotp(_my_mobile);
//                                     //hit new otp api again
//                                     setState(() {
//                                       total_chance++;
//                                       if (total_chance == 4 ||
//                                           total_chance > 4) {
//                                         codesent = false;
//                                         util.showSnackBar(
//                                             "Alert",
//                                             "You have reached maximum attempts.",
//                                             false);
//                                       } else {
//                                         codesent = true;
//                                         // otpController.getOtpagain(_my_mobile);
//                                       }
//                                     });
//                                     if (codesent == true) {
//                                       Timer.periodic(
//                                           Duration(seconds: 1),
//                                           (timer) {
//                                         setState(() {
//                                           count--;
//                                           if (count == 0) {
//                                             count = 60;
//                                             timer.cancel();
//                                             codesent = false;
//                                           }
//                                         });
//                                       });
//                                     }
//                                   }
//                                 },*/
//                                 ,child: Text(
//                                   "Resend OTP",
//                                   style: TextStyle(
//                                       fontWeight: FontWeight.bold),
//                                 )),
//                           ),
//                         ),
//                       ),
//                       Visibility(
//                        // visible: codesent == true ? true : false,
//                         child: Padding(
//                             padding: const EdgeInsets.only(
//                                 right: 16.0, top: 16.0),
//                             child: Align(
//                                 alignment: Alignment.centerRight,
//                                 child: Text(
//                                     "Please wait: /*{count.toString()}*/"))),
//                       ),
//                       Padding(
//                         padding: EdgeInsets.only(
//                             right: AppConstant.APP_LARGE_PADDING),
//                         child: Align(
//                           alignment: Alignment.centerLeft,
//                           child: Container(),
//                         ),
//                       ),
//                       SizedBox(
//                         height: AppConstant.APP_EXTRA_LARGE_PADDING,
//                       ),
//                     ],
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(24.00),
//                   child: InkWell(
//                     onTap: () {
//                       //  Get.to(Signup_Screen());
//                     },
//                     child: Bounceable(
//                       onTap: () async {} {
//                         if (_my_mobile.isEmpty || _my_mobile == "") {
//                           util.showSnackBar(
//                               "Alert", AppConstant.FETCH_MOBILE, false);
//                         } else if (otpController.otp_otp.text.isEmpty) {
//                           util.showSnackBar(
//                               "Alert", "Please enter valid otp!", false);
//                         } else {
//                           otpController
//                               .verifyOtp(_my_mobile,
//                                   otpController.otp_otp.text.toString())
//                               .then((value) => {
//                                     debugPrint("verifyotp"),
//                                     debugPrint(
//                                         value?.message.toString()),
//                                     if (value!.status == true)
//                                       {
//                                         util.showSuccessProcess(),
//                                         saveUserData("user_data", [
//                                           value!.data.id.toString(),
//                                           value!.data.name.toString(),
//                                           value!.data.email.toString(),
//                                           value!.data.mobile.toString(),
//                                           value!.data.password
//                                               .toString(),
//                                           value!.data.address
//                                               .toString(),
//                                           value!.data.profileImages
//                                               .toString(),
//                                           value!.data.otp.toString(),
//                                           value!.data.token.toString(),
//                                           value!.data.userVerified
//                                               .toString(),
//                                           value!.data.createdAt
//                                               .toString(),
//                                           value!.status.toString(),
//                                         ]),
//                                         if (_from == "registration")
//                                           {
//
//                                             AppConstant.save_data(
//                                                 "token", value!.data.id.toString()),
//                                             AppConstant.save_data("isFirst", "yes"),
//                                             Get.offAll(MyHomePage())
//                                           }
//                                         else if (_from ==
//                                             "forget_password")
//                                           {
//                                             // var output = _my_mobile
//                                             //     .trim()
//                                             //     .substring(
//                                             //
//                                             //
//                                             //     _my_mobile.trim().length - 10);
//                                             Get.to(CreatePassword(
//                                                 _my_mobile,value!.data.id.toString()))
//                                           }
//                                         else if (_from == "login")
//                                           {
//                                             AppConstant.save_data(
//                                                 "token", value!.data.id.toString()),
//                                             AppConstant.save_data("isFirst", "yes"),
//                                             Get.offAll(MyHomePage()),
//                                           }
//                                         else if (_from ==
//                                             "change_password")
//                                           {
//                                             Get.to(
//                                                 ChangePassword(true,value!.data.id.toString())),
//                                           }
//                                       }
//                                   });
//                         }
//                       },
//                       child: Container(
//                         decoration: BoxDecoration(
//                             boxShadow:  [
//                               BoxShadow(
//                                 color: Colors.grey,
//                                 offset: const Offset(
//                                   5.0,
//                                   5.0,
//                                 ),
//                                 blurRadius: 10.0,
//                                 spreadRadius: 2.0,
//                               ), //BoxShadow
//                               BoxShadow(
//                                 color: Colors.white,
//                                 offset: const Offset(0.0, 0.0),
//                                 blurRadius: 0.0,
//                                 spreadRadius: 0.0,
//                               ), //
//                               // BoxShadow
//                             ],
//                             color: MyColor.primarycolor,
//                             borderRadius: BorderRadius.circular(20),
//                         ),
//                         margin: EdgeInsets.all(8.00),
//                         height: 50,
//                         width: 289,
//                         child: Center(
//                           child: Text(
//                             AppConstant.SUBMIT,
//                             style: GoogleFonts.nunitoSans(
//                                 textStyle: Theme.of(context)
//                                     .textTheme
//                                     .displayLarge,
//                                 fontSize: AppConstant.MEDIUM_SIZE,
//                                 fontWeight: FontWeight.w700,
//                                 fontStyle: FontStyle.normal,
//                                 color: Colors.white),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dentocoreauth/pages/change_pasword/change_password.dart';
import 'package:dentocoreauth/pages/homepage/MyHomePage.dart';
import 'package:dentocoreauth/utils/app_constant.dart';
import 'package:dentocoreauth/utils/mycolor.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Utills/Utills.dart';
import '../../../controllers/otp_controller.dart';
import '../create_password/create_password.dart';
import '../login/login.dart';

class Otp extends StatefulWidget {
  final String my_mobile;
  final String from;

  Otp(this.my_mobile, this.from, {super.key});

  @override
  State<Otp> createState() => _OtpState(my_mobile, from);
}

class _OtpState extends State<Otp> {
  final String _from;
  final String _my_mobile;
  var codesent = false;
  var total_chance = 0;
  var count = 60;

  _OtpState(this._my_mobile, this._from);

  OtpController otpController = Get.find();
  var util = Utills();
  var isOtpClicked = false;

  void saveUserData(String key, List<String> value) async {
    final sp = await SharedPreferences.getInstance();
    await sp.setStringList(key, value); // Async call ko await karo
    debugPrint("User data saved: $value");
  }

  @override
  void dispose() {
    otpController.dispose();
    if (EasyLoading.isShow) {
      EasyLoading.dismiss();
    }
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    if (_from == "change_password") {
      debugPrint("resendotp" + _my_mobile);
      otpController.resendOtp(_my_mobile);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BackButtonArrow(backFunction: true),
      body: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
          setState(() {
            isOtpClicked = false;
          });
        },
        behavior: HitTestBehavior.opaque,
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 70),
                Center(
                  child: Text(
                    "Verification Code",
                    style: GoogleFonts.openSans(
                      textStyle: Theme.of(context).textTheme.displayLarge,
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                      color: MyColor.APP_TITLE_COLOR,
                    ),
                  ),
                ),
                SizedBox(height: AppConstant.LARGE_SIZE),
                Padding(
                  padding: const EdgeInsets.only(left: 13.0),
                  child: Text(
                    "Please type the verification code sent to\n$_my_mobile",
                    style: GoogleFonts.openSans(
                      textStyle: Theme.of(context).textTheme.displayLarge,
                      fontSize: AppConstant.SMALL_SIZE,
                      color: Colors.grey,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0, top: 8.00),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            AppConstant.TEXT_OTP_HEAD,
                            style: GoogleFonts.nunitoSans(
                              textStyle: Theme.of(context).textTheme.displayLarge,
                              fontSize: AppConstant.MEDIUM_SIZE,
                              fontWeight: FontWeight.w600,
                              color: MyColor.SIGNUP_TEXT_HEAD_COMMON_COLOR,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: AppConstant.SMALL_TEXT_SIZE),
                      Padding(
                        padding: EdgeInsets.all(AppConstant.APP_NORMAL_PADDING),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(AppConstant.APP_NORMAL_PADDING),
                            border: Border.all(color: Colors.grey, width: 1.0),
                          ),
                          child: Column(
                            children: [
                              Container(
                                height: 60,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(
                                    child: TextField(
                                      onTap: () {
                                        setState(() {
                                          isOtpClicked = true;
                                        });
                                      },
                                      controller: otpController.otp_otp,
                                      decoration: InputDecoration.collapsed(
                                        hintText: AppConstant.HINT_TEXT_OTP,
                                        hintStyle: TextStyle(
                                          color: MyColor.LOGIN_TEXT_HINT_PASSWORD_COLOR,
                                        ),
                                      ),
                                      keyboardType: TextInputType.number,
                                    ),
                                  ),
                                ),
                              ),
                              Visibility(
                                visible: isOtpClicked,
                                child: SizedBox(
                                  width: double.infinity,
                                  height: 2,
                                  child: Container(color: Color(0xFF54E28D)),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: AppConstant.APP_EXTRA_LARGE_PADDING),
                    ],
                  ),
                ),
                //resend otp
                      Visibility(
                      //  visible: codesent == false ? true : false,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              right: 16.0, top: 16.0),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Bounceable(
                                onTap: ()  {
                                  if (_my_mobile.isEmpty ||
                                      _my_mobile == "") {
                                    util.showSnackBar(
                                        "Alert",
                                        "No mobile Number found.",
                                        false);
                                  } else {
                                    otpController.resendOtp(_my_mobile);
                                    // getotp(_my_mobile);
                                    //hit new otp api again
                                    setState(() {
                                      total_chance++;
                                      if (total_chance == 4 ||
                                          total_chance > 4) {
                                        codesent = false;
                                        util.showSnackBar(
                                            "Alert",
                                            "You have reached maximum attempts.",
                                            false);
                                      } else {
                                        codesent = true;
                                        // otpController.getOtpagain(_my_mobile);
                                      }
                                    });
                                    if (codesent == true) {
                                      Timer.periodic(
                                          Duration(seconds: 1),
                                          (timer) {
                                        setState(() {
                                          count--;
                                          if (count == 0) {
                                            count = 60;
                                            timer.cancel();
                                            codesent = false;
                                          }
                                        });
                                      });
                                    }
                                  }
                                },
                                child: Text(
                                  "Resend OTP",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold),
                                )),
                          ),
                        ),
                      ),
                Padding(
                  padding: const EdgeInsets.all(24.00),
                  child: Bounceable(
                    onTap: () async {
                      if (_my_mobile.isEmpty) {
                        util.showSnackBar("Alert", AppConstant.FETCH_MOBILE, false);
                        return;
                      }
                      if (otpController.otp_otp.text.isEmpty) {
                        util.showSnackBar("Alert", "Please enter valid OTP!", false);
                        return;
                      }

                      util.startLoading();
                      try {
                        final value = await otpController.verifyOtp(
                          _my_mobile,
                          otpController.otp_otp.text,
                        );
                        debugPrint("verifyotp response: ${value?.toString()}");

                        if (value != null && value.status == true) {
                          util.showSuccessProcess();
                          saveUserData("user_data", [
                            value.data.id.toString(),
                            value.data.name.toString(),
                            value.data.email.toString(),
                            value.data.mobile.toString(),
                            value.data.password.toString(),
                            value.data.address.toString(),
                            value.data.profileImages.toString(),
                            value.data.otp.toString(),
                            value.data.token.toString(),
                            value.data.userVerified.toString(),
                            value.data.createdAt.toString(),
                            value.status.toString(),
                          ]);

                          if (_from == "registration") {
                            AppConstant.save_data("token", value.data.id.toString());
                            AppConstant.save_data("isFirst", "yes");
                            Get.offAll(() => MyHomePage());
                          } else if (_from == "forget_password") {
                            Get.to(() => CreatePassword(_my_mobile, value.data.id.toString()));
                          } else if (_from == "login") {
                            AppConstant.save_data("token", value.data.id.toString());
                            AppConstant.save_data("isFirst", "yes");
                            Get.offAll(() => MyHomePage());
                          } else if (_from == "change_password") {
                            Get.to(() => ChangePassword(true, value.data.id.toString()));
                          }
                        } else {
                          util.showSnackBar("Alert", "OTP verification failed", false);
                          debugPrint("OTP failed: ${value?.message}");
                        }
                      } catch (e) {
                        debugPrint("OTP verification error: $e");
                        util.showSnackBar("Error", "Something went wrong: $e", false);
                      } finally {
                        util.stopLoading();
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            offset: const Offset(5.0, 5.0),
                            blurRadius: 10.0,
                            spreadRadius: 2.0,
                          ),
                          BoxShadow(
                            color: Colors.white,
                            offset: const Offset(0.0, 0.0),
                            blurRadius: 0.0,
                            spreadRadius: 0.0,
                          ),
                        ],
                        color: MyColor.primarycolor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      margin: EdgeInsets.all(8.00),
                      height: 50,
                      width: 289,
                      child: Center(
                        child: Text(
                          AppConstant.SUBMIT,
                          style: GoogleFonts.nunitoSans(
                            textStyle: Theme.of(context).textTheme.displayLarge,
                            fontSize: AppConstant.MEDIUM_SIZE,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BackButtonArrow extends StatelessWidget implements PreferredSizeWidget {
  final bool backFunction;

  const BackButtonArrow({super.key, required this.backFunction});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        onPressed: () {
          if (backFunction) {
            Get.back();
          }
        },
        icon: Icon(Icons.arrow_back_ios),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}