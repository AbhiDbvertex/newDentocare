import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dentocoreauth/utils/app_constant.dart';
import 'package:dentocoreauth/utils/mycolor.dart';
import '../../../controllers/forgot_password_controller.dart';

import '../../../Utills/Utills.dart';
import '../login/login.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  var isMobile = true;
  var isOtp = false;
  var isPassword = false;
  var util = Utills();
  var controller_one = TextEditingController();
  var controller_two = TextEditingController();
  var countryCode = "+91";

  //var service = AuthService();

  @override
  void initState() {
    super.initState();
  }

  ForgotPasswordController forgotPasswordController = Get.find();

  var isPhoneClicked = false;


  @override
  void dispose() {
    super.dispose();
    forgotPasswordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BackButtonArrow(backFunction: true, hint: "Dashboard"),
      body: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
          setState(() {
            isPhoneClicked = false;
          });
        },
        behavior: HitTestBehavior.opaque,
        child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 60),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    height: AppConstant.APP_NORMAL_PADDING,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 10.0, right: 10.00, top: 20.00),
                    child: Text(AppConstant.FORGOT_PASSWORD_HEAD,
                        style: GoogleFonts.openSans(
                            textStyle: Theme.of(context).textTheme.displayLarge,
                            fontSize: 25,
                            fontWeight: FontWeight.w600,
                            fontStyle: FontStyle.normal,
                            color: Colors.black)),
                  ),
                  SizedBox(
                    height: 45,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Please enter your email address to\nrequest a password reset",style: TextStyle(color: Colors.grey),),
                      SizedBox(
                        height: AppConstant.SMALL_TEXT_SIZE,
                      ), SizedBox(
                        height: 15,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                AppConstant.APP_NORMAL_PADDING),
                            border:
                                Border.all(color: Colors.grey, width: 1.0)),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 40,
                                child: Center(
                                    child: TextFormField(
                                  onTap: () {
                                    setState(() {
                                      isPhoneClicked = true;
                                    });
                                  },
                                  controller:
                                      forgotPasswordController.email,
                                  inputFormatters: [],
                                  decoration: InputDecoration.collapsed(
                                      hintStyle: TextStyle(
                                          color: MyColor
                                              .LOGIN_TEXT_HINT_PASSWORD_COLOR),
                                      hintText: AppConstant.HINT_TEXT_EMAIL,
                                      border: InputBorder.none,
                                      floatingLabelAlignment:
                                          FloatingLabelAlignment.start),
                                  keyboardType: TextInputType.emailAddress,
                                  onChanged: (phone) {},
                                  textAlignVertical:
                                      TextAlignVertical.center,
                                )),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 19,
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 24.00, right: 24, bottom: 24),
                    child: InkWell(
                      onTap: () {
                        //  Get.to(Signup_Screen());
                      },
                      child: Bounceable(
                        onTap: () {
                          //  Get.to(HomeScreen());
                          if (forgotPasswordController.email.text.isEmpty ||
                              forgotPasswordController.email.text.length < 10) {
                            util.showSnackBar(
                                "Alert", "Please fill valid email address.", false);
                            print("Abhi:- not send otp");
                          } else {
                            forgotPasswordController.forgotPassword();
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
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
                              borderRadius: BorderRadius.circular(20),
                            ),
                            margin: EdgeInsets.all(8.00),
                            height: 50,
                            width: 289,
                            child: Center(
                              child: Text(
                                "Send new password",
                                style: GoogleFonts.nunitoSans(
                                    textStyle: Theme.of(context)
                                        .textTheme
                                        .displayLarge,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w600,
                                    fontStyle: FontStyle.normal,
                                    color: Colors.white),
                              ),
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
