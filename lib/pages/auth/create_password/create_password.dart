import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dentocoreauth/pages/homepage/MyHomePage.dart';
import 'package:dentocoreauth/utils/app_constant.dart';
import 'package:dentocoreauth/utils/mycolor.dart';

import '../../../Utills/Utills.dart';
import '../../../controllers/create_password_controller.dart';

class CreatePassword extends StatefulWidget {

  var _val="";
  var _uid="";

  CreatePassword(String val,String uid){
    this._val=val;
    this._uid=uid;
  }

  @override
  State<CreatePassword> createState() => _CreatePasswordState(_val,_uid);
}

class _CreatePasswordState extends State<CreatePassword> {

  var my_mobile = "";
  var _uid="";
  _CreatePasswordState(String mob,String uid){
    this.my_mobile=mob;
    this._uid=uid;
  }

  var util = Utills();
  var isPasswordClicked = false;
  var isConPasswordClicked = false;
  var isVisible = true;
  var isVisibleTow = true;

  @override
  void dispose() {
    super.dispose();
    create_pass_controller.dispose();
  }

  CreatePasswordController create_pass_controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
          setState(() {
            isPasswordClicked = false;
            isConPasswordClicked = false;
          });

        },
        behavior: HitTestBehavior.opaque,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    height: 210,

                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: Container(
                              // color: Colors.purple,
                              child: InkWell(
                                onTap: () {},
                                child: Image.asset(
                                  'assets/newImages/applogo.png',
                                  height: 200,
                                  width: 200,
                                ),
                              ),
                            ),
                          ),
                          // Align(
                          //     alignment: Alignment.topLeft,
                          //     child: Padding(
                          //       padding: EdgeInsets.only(top:10),
                          //       child: Bounceable(
                          //           onTap: () {
                          //             Get.back();
                          //           },
                          //         child: Align(
                          //           alignment: Alignment.centerLeft,
                          //           child: Container(
                          //             width: 70,
                          //             height: 40,
                          //             decoration: BoxDecoration(
                          //               color: Colors.white,
                          //               borderRadius: BorderRadius.only(
                          //                   topRight: Radius.circular(30),
                          //                   bottomRight: Radius.circular(30)),
                          //               boxShadow: [
                          //                 BoxShadow(
                          //                   color: Colors.grey.withOpacity(0.5),
                          //                   spreadRadius: 1,
                          //                   blurRadius: 2,
                          //                   offset: Offset(0,
                          //                       3), // changes position of shadow
                          //                 ),
                          //               ],
                          //             ),
                          //             child: Container(
                          //               decoration: BoxDecoration(
                          //                   borderRadius: BorderRadius.only(
                          //                       topRight: Radius.circular(30),
                          //                       bottomRight:
                          //                       Radius.circular(30)),
                          //                   gradient: AppConstant.BUTTON_COLOR),
                          //               child: Image.asset(
                          //                 'assets/images/back_icon.png',
                          //                 width: 10,
                          //                 height: 10,
                          //               ),
                          //             ),
                          //           ),
                          //         ),
                          //
                          //
                          //       ),
                          //     )),
                          // Flexible(
                          //   child: Align(
                          //     alignment: Alignment.center,
                          //     child: Image.asset(
                          //       "assets/images/app_logo.png",
                          //       height: 200,
                          //       width: 200,
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ),
                  // SizedBox(
                  //   height: AppConstant.APP_NORMAL_PADDING,
                  // ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 10.00, right: 10.00, top: 0.00),
                    child: Text(
                      AppConstant.TEXT_HEAD_CREATE_PASSWORD,
                      style: GoogleFonts.openSans(
                          textStyle: Theme.of(context).textTheme.displayLarge,
                          fontSize: AppConstant.LARGE_SIZE,
                          fontWeight: FontWeight.w600,
                          fontStyle: FontStyle.normal,
                          color: MyColor.APP_TITLE_COLOR),
                    ),
                  ),
                  SizedBox(
                    height: AppConstant.LARGE_SIZE,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Padding(
                                padding:
                                const EdgeInsets.only(left: 8.0, top: 8.00),
                                child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(AppConstant.TEXT_PASSWORD,
                                        style: GoogleFonts.nunitoSans(
                                            textStyle: Theme.of(context)
                                                .textTheme
                                                .displayLarge,
                                            fontSize: AppConstant.MEDIUM_SIZE,
                                            fontWeight: FontWeight.w600,
                                            fontStyle: FontStyle.normal,
                                            color: MyColor.LOGIN_TEXT_MOBILE_COLOR))),
                              ),
                              SizedBox(
                                height: AppConstant.SMALL_TEXT_SIZE,
                              ),
                              Padding(
                                padding: EdgeInsets.all(
                                  AppConstant.APP_NORMAL_PADDING,
                                ),
                                child: Container(

                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                          AppConstant.APP_NORMAL_PADDING),
                                      border: Border.all(
                                          color: Colors.grey, width: 1.0)),
                                  child: Column(
                                    children: [
                                      Container(
                                        height:60,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Center(
                                            child: TextField(
                                              onTap: (){
                                                setState(() {
                                                  isPasswordClicked=true;
                                                  isConPasswordClicked=false;
                                                });

                                              },
                                              controller: create_pass_controller
                                                  .create_password,
                                              decoration:
                                               InputDecoration(
                                                hintStyle: TextStyle(color: MyColor.LOGIN_TEXT_HINT_PASSWORD_COLOR),
                                                  hintText: AppConstant
                                                      .HINT_TEXT_PASS,
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
                                              TextInputType.visiblePassword,
                                            ),
                                          ),
                                        ),
                                      ),
                                      // Visibility(
                                      //   visible: isPasswordClicked == true
                                      //       ? true
                                      //       : false,
                                      //   child: SizedBox(
                                      //     width: double.infinity,
                                      //     height: 2,
                                      //     child: Container(
                                      //       color: Color(0xFF54E28D),
                                      //     ),
                                      //   ),
                                      // )
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                const EdgeInsets.only(left: 8.0, top: 8.00),
                                child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(AppConstant.TEXT_CON_PASSWORD,
                                        style: GoogleFonts.nunitoSans(
                                            textStyle: Theme.of(context)
                                                .textTheme
                                                .displayLarge,
                                            fontSize: AppConstant.MEDIUM_SIZE,
                                            fontWeight: FontWeight.w600,
                                            fontStyle: FontStyle.normal,
                                            color: MyColor.LOGIN_TEXT_MOBILE_COLOR))),
                              ),
                              SizedBox(
                                height: AppConstant.SMALL_TEXT_SIZE,
                              ),
                              Padding(
                                padding: EdgeInsets.all(
                                  AppConstant.APP_NORMAL_PADDING,
                                ),
                                child: Container(

                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                          AppConstant.APP_NORMAL_PADDING),
                                      border: Border.all(
                                          color: Colors.grey, width: 1.0)),
                                  child: Column(
                                    children: [
                                      Container(
                                        height:60,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Center(
                                            child: TextField(
                                              onTap: (){
                                                setState(() {
                                                  isConPasswordClicked=true;
                                                  isPasswordClicked=false;
                                                });
                                              },
                                              controller: create_pass_controller
                                                  .con_create_password,
                                              decoration:
                                               InputDecoration(
                                                hintStyle: TextStyle(
                                                  color: MyColor.LOGIN_TEXT_HINT_PASSWORD_COLOR
                                                ),
                                                  hintText: AppConstant
                                                      .HINT_TEXT_CON_PASSWORD,
                                                  suffixIcon: IconButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        isVisibleTow = !isVisibleTow;
                                                      });
                                                    },
                                                    icon: Icon(isVisibleTow
                                                        ? Icons.visibility_off
                                                        : Icons.remove_red_eye),
                                                    color:
                                                    isVisibleTow ? Colors.grey : Colors.grey,
                                                  )
                                              ),
                                              obscureText: isVisibleTow,
                                              keyboardType:
                                              TextInputType.visiblePassword,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Visibility(
                                        visible: isConPasswordClicked == true
                                            ? true
                                            : false,
                                        child: SizedBox(
                                          width: double.infinity,
                                          height: 2,
                                          child: Container(
                                            color: Color(0xFF54E28D),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    right: AppConstant.APP_LARGE_PADDING),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Container(),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: AppConstant.APP_EXTRA_LARGE_PADDING,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(24.00),
                          child: InkWell(
                            onTap: () {
                              //  Get.to(Signup_Screen());
                            },
                            child: Bounceable(
                              onTap: () {
                                var res =
                                create_pass_controller.create_pw(my_mobile,_uid);
                                res.then((value) => {

                                //   if (value!.status == true)
                                //     {
                                //       util.showSnackBar("Alert",
                                //           value.message.toString(), true),
                                //       Get.offAll(MyHomePage()),
                                //     }
                                 }
                                );
                                ;
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: MyColor.primarycolor,
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
                                  //gradient: AppConstant.BUTTON_COLOR,

                                  borderRadius: BorderRadius.circular(20),
                                ),
                                margin: EdgeInsets.all(8.00),
                                height: 44,
                                width: 289,
                                child: Center(
                                  child: Text(
                                    AppConstant.SUBMIT,
                                    style: GoogleFonts.nunitoSans(
                                        textStyle: Theme.of(context)
                                            .textTheme
                                            .displayLarge,
                                        fontSize: AppConstant.MEDIUM_SIZE,
                                        fontWeight: FontWeight.w700,
                                        fontStyle: FontStyle.normal,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),

                      ],
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
