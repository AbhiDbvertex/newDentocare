import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:get/get.dart';
import 'package:dentocoreauth/pages/auth/otp/otp.dart';
import 'package:dentocoreauth/utils/app_constant.dart';
import 'package:dentocoreauth/utils/mycolor.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Utills/Utills.dart';
import '../../controllers/change_password_controller.dart';
import '../../controllers/otp_controller.dart';
import '../../utils/component_screen.dart';

class ChangePassword extends StatefulWidget {
  var isOtpsent = false;
  var _uid = "";

  ChangePassword(bool sent,String uid) {
    this.isOtpsent = sent;
    this._uid=uid;
  }

  @override
  State<ChangePassword> createState() => _ChangePasswordState(isOtpsent,_uid);
}

class _ChangePasswordState extends State<ChangePassword> {
  var isOtpsent = false;
  var _uid = "";
  _ChangePasswordState(bool sent,String uid) {
    this.isOtpsent = sent;
    this._uid=uid;
  }

  final ChangePasswordController changePasswordController = Get.find();
  OtpController otpController = Get.find();
  var user_data = [];

  var load_status = false;
  var usertoken = "";
  var util = Utills();
  var uid = "0";
  var useremail = "";
  var isVisible = true;
  var isVisibletow = true;
  void getUserData(key) async {
    final sp = await SharedPreferences.getInstance();
    setState(() {
      user_data = sp.getStringList(key)!;
      load_status = true;
      useremail = user_data[2].toString();
      //  util.showSnackBar("Alert", useremail.toString(), true);
      if (isOtpsent == false) {
        //Get.to(Otp(useremail.toString(), "change_password"));
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserData("user_data");
  }


  @override
  void dispose() {
    super.dispose();
    changePasswordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // Container(
                  //   child: Center(
                  //     child: Column(
                  //       mainAxisAlignment: MainAxisAlignment.start,
                  //       children: [
                  //         Row(
                  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //           crossAxisAlignment: CrossAxisAlignment.center,
                  //           children: [
                  //             Visibility(
                  //               visible: true,
                  //               maintainSize: true,
                  //               maintainState: true,
                  //               maintainSemantics: true,
                  //               maintainAnimation: true,
                  //               child: Container(
                  //                 width: MediaQuery.of(context).size.width / 3,
                  //                 alignment: Alignment.centerLeft,
                  //                 child: Padding(
                  //                   padding: EdgeInsets.only(top: 10),
                  //                   child: Bounceable(
                  //                     onTap: () {
                  //                       Get.back();
                  //                     },
                  //                     child: Container(
                  //                       width: 70,
                  //                       height: 40,
                  //                       decoration: BoxDecoration(
                  //                         color: Colors.white,
                  //                         borderRadius: BorderRadius.only(
                  //                             topRight: Radius.circular(30),
                  //                             bottomRight: Radius.circular(30)),
                  //                         boxShadow: [
                  //                           BoxShadow(
                  //                             color:
                  //                                 Colors.grey.withOpacity(0.5),
                  //                             spreadRadius: 1,
                  //                             blurRadius: 2,
                  //                             offset: Offset(0,
                  //                                 3), // changes position of shadow
                  //                           ),
                  //                         ],
                  //                       ),
                  //                       child: Container(
                  //                         decoration: BoxDecoration(
                  //                             borderRadius: BorderRadius.only(
                  //                                 topRight: Radius.circular(30),
                  //                                 bottomRight:
                  //                                     Radius.circular(30)),
                  //                             gradient:
                  //                                 AppConstant.BUTTON_COLOR),
                  //                         child: Image.asset(
                  //                           'assets/images/back_icon.png',
                  //                           width: 10,
                  //                           height: 10,
                  //                         ),
                  //                       ),
                  //                     ),
                  //                   ),
                  //                 ),
                  //               ),
                  //             ),
                  //             Flexible(
                  //               child: Container(
                  //                 alignment: Alignment.centerLeft,
                  //                 width: MediaQuery.of(context).size.width ,
                  //                 child: Padding(
                  //                   padding: const EdgeInsets.only(top: 15.0),
                  //                   child: Container(
                  //                     height: 40,
                  //                     child: AppConstant.HEADLINE_TEXT(
                  //                         AppConstant.TITLE_TEXT_CHANGE_PASSWORD,
                  //                         context),
                  //                   ),
                  //                 ),
                  //               ),
                  //             ),
                  //
                  //           ],
                  //         ),
                  //         SizedBox(
                  //           height: 8,
                  //         ),
                  //         SizedBox(
                  //           child: Container(
                  //             height: 2,
                  //             decoration:
                  //                 BoxDecoration(color: Colors.grey, boxShadow: [
                  //               BoxShadow(
                  //                 offset: Offset(2, 4),
                  //                 color: Colors.black.withOpacity(
                  //                   0.3,
                  //                 ),
                  //                 blurRadius: 3,
                  //               ),
                  //             ]),
                  //           ),
                  //         )
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  // SizedBox(height: AppConstant.APP_EXTRA_LARGE_PADDING),
                  // Text(
                  //   AppConstant.TEXT_HEAD_CHANGE_PW,
                  //   style: TextStyle(
                  //       fontSize: AppConstant.MEDIUM_SIZE,
                  //       fontWeight: FontWeight.bold),
                  // ),
                  CustomAppBar(title: 'Change password'),
                  Container(
                    padding: EdgeInsets.all(AppConstant.LARGE_SIZE),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                AppConstant.TEXT_NEW_PASSWORD,
                                style: TextStyle(
                                    fontSize: AppConstant.MEDIUM_SIZE,
                                    fontWeight: FontWeight.normal),
                              )),
                        ),
                        SizedBox(
                          height: AppConstant.SMALL_TEXT_SIZE,
                        ),
                        Padding(
                          padding: EdgeInsets.all(
                            AppConstant.APP_NORMAL_PADDING,
                          ),
                          child: Container(
                            height: 60,
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey,
                                    offset: const Offset(
                                      5.0,
                                      5.0,
                                    ),
                                    blurRadius: 10.0,
                                    spreadRadius: 2.0,
                                  ), //BoxShadow
                                  BoxShadow(
                                    color: Colors.white,
                                    offset: const Offset(0.0, 0.0),
                                    blurRadius: 0.0,
                                    spreadRadius: 0.0,
                                  ), //
                                  // BoxShadow
                                ],
                                borderRadius: BorderRadius.circular(
                                    AppConstant.APP_NORMAL_PADDING),
                                border:
                                    Border.all(color: Colors.grey, width: 1.0)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: TextField(
                                    controller:
                                        changePasswordController.new_pass,
                                    decoration: InputDecoration(
                                        hintText: AppConstant.HINT_TEXT_PASS,
                                        suffixIcon: IconButton(
                                        onPressed: () {
                                setState(() {
                                isVisible = !isVisible;
                                });
                                },
                                  icon: Icon(isVisible
                                      ? Icons.visibility_off
                                      : Icons.remove_red_eye),
                                  color:
                                  isVisible ? Colors.grey : Colors.grey,
                                )
                                    ),
                                    obscureText: isVisible,
                                    keyboardType:
                                        TextInputType.visiblePassword
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: AppConstant.LARGE_SIZE,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                AppConstant.TEXT_CON_NEW_PASSWORD,
                                style: TextStyle(
                                    fontSize: AppConstant.MEDIUM_SIZE,
                                    fontWeight: FontWeight.normal),
                              )),
                        ),
                        SizedBox(
                          height: AppConstant.SMALL_TEXT_SIZE,
                        ),
                        Padding(
                          padding: EdgeInsets.all(
                            AppConstant.APP_NORMAL_PADDING,
                          ),
                          child: Container(
                            height: 60,
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey,
                                    offset: const Offset(
                                      5.0,
                                      5.0,
                                    ),
                                    blurRadius: 10.0,
                                    spreadRadius: 2.0,
                                  ), //BoxShadow
                                  BoxShadow(
                                    color: Colors.white,
                                    offset: const Offset(0.0, 0.0),
                                    blurRadius: 0.0,
                                    spreadRadius: 0.0,
                                  ), //
                                  // BoxShadow
                                ],
                                borderRadius: BorderRadius.circular(
                                    AppConstant.APP_NORMAL_PADDING),
                                border:
                                    Border.all(color: Colors.grey, width: 1.0)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: TextField(
                                  controller:
                                      changePasswordController.re_new_pass,
                                  decoration:InputDecoration(
                                      hintText: AppConstant
                                          .HINT_TEXT_NEW_CON_PASSWORD,
                                      suffixIcon: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            isVisibletow = !isVisibletow;
                                          });
                                        },
                                        icon: Icon(isVisibletow
                                            ? Icons.visibility_off
                                            : Icons.remove_red_eye),
                                        color:
                                        isVisibletow ? Colors.grey : Colors.grey,
                                      ),
                                  ),
                                  obscureText: isVisibletow,
                                  keyboardType: TextInputType.visiblePassword,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: AppConstant.APP_EXTRA_LARGE_PADDING,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: AppConstant.LARGE_SIZE,
                        right: AppConstant.LARGE_SIZE,
                        bottom: AppConstant.LARGE_SIZE),
                    child: Bounceable(
                      onTap: () {
                        if (FocusManager.instance.primaryFocus!.hasFocus) {
                          FocusManager.instance.primaryFocus?.unfocus();
                        }
                        if (useremail.isEmpty || useremail == "") {
                          util.showSnackBar(
                              "Alert", "Couldn't fetch email!", false);
                        } else {
                          changePasswordController.create_pw(useremail,_uid);
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          boxShadow:  [
                            BoxShadow(
                              color: Colors.grey,
                              offset: const Offset(
                                5.0,
                                5.0,
                              ),
                              blurRadius: 10.0,
                              spreadRadius: 2.0,
                            ), //BoxShadow
                            BoxShadow(
                              color: Colors.white,
                              offset: const Offset(0.0, 0.0),
                              blurRadius: 0.0,
                              spreadRadius: 0.0,
                            ), //
                            // BoxShadow
                          ],
                          color: MyColor.primarycolor,
                         // gradient: AppConstant.BUTTON_COLOR,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        margin: EdgeInsets.all(8.00),
                        height: 44,
                        width: 289,
                        child: Center(
                          child: Text(
                            AppConstant.SUBMIT,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: AppConstant.MEDIUM_SIZE,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
