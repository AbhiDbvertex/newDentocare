import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:get/get.dart';
import 'package:get/get.dart';
import 'package:dentocoreauth/Utills/Utills.dart';
import 'package:dentocoreauth/utils/app_constant.dart';
import 'package:http/http.dart' as http;

import '../../utils/component_screen.dart';

class About extends StatefulWidget {
  var index = 0;

  About(int ind) {
    this.index = ind;
  }

  @override
  State<About> createState() => _AboutState(this.index);
}

class _AboutState extends State<About> {
  var index = 0;

  _AboutState(int ind) {
    this.index = ind;
  }

  var pageis = 2;
  var msg = "";
  var status = false;

  var listdata = [];


  @override
  void dispose() {


    if (EasyLoading.isShow) {
      EasyLoading.dismiss();
    }
  }

  @override
  void initState() {
    super.initState();
    pageis = index;
    getHtmlData(pageis);
    debugPrint("myindex" + index.toString());
  }

  Future getHtmlData(int page) async {
  //  EasyLoading.show(status: 'loading...');

    var endpoint = "";
    switch (pageis) {
      case 3:
        endpoint = "termscondition";
        break;
      case 1:
        endpoint = "aboutus";
        break;
      default:
        endpoint = "privacypolicy";
        break;
    }
    http.Response res;
    res = await http.get(
      Uri.parse(AppConstant.BASE_URL + "/api/$endpoint/1"),headers: <String,String>{"x-api-key":"dentist@123"}
    );

    debugPrint("setting" + AppConstant.BASE_URL + "/api/$endpoint/1");
    setState(() {
      if (res.statusCode == 200 || res.statusCode == 201) {
        EasyLoading.dismiss();
        print("mydatahtml" + "200");

        final temp = jsonDecode(res.body);
        //listdata = jsonDecode(res.body);
        temp['body']['aboutus'].toString();
        //print("mydatahtml"+ listdata[0]["id"].toString());
        final util = Utills();
        if (pageis == 2) {
          msg = temp['body']['privacypolicy'].toString();
        } else if (pageis == 1) {
          msg = temp['body']['aboutus'].toString();
        } else if (pageis == 3) {
          msg = temp['body']['termscondition'].toString();
        }
      } else {
        print("mydatahtml" + "failed");
        EasyLoading.dismiss();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Faild to get data."),
            backgroundColor: Colors.red,
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CustomAppBar(
                        title: index == 2 ? "Privacy Policy" : index == 1 ? "About Us" : "T&C",
                      ),
                      // AppConstant.HEADLINE_TEXT(
                      //     index == 2
                      //         ? "Privacy Policy"
                      //         : index == 1
                      //         ? "About US"
                      //         : "T&C",
                      //     context),


                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   crossAxisAlignment: CrossAxisAlignment.center,
                      //   children: [
                      //     Visibility(
                      //       visible: true,
                      //       maintainSize: true,
                      //       maintainState: true,
                      //       maintainSemantics: true,
                      //       maintainAnimation: true,
                      //       child: Container(
                      //         width: MediaQuery.of(context).size.width / 3,
                      //         alignment: Alignment.centerLeft,
                      //         child: Padding(
                      //           padding: EdgeInsets.only(top: 10),
                      //           child: Bounceable(
                      //             onTap: () {
                      //               Get.back();
                      //             },
                      //             child: Container(
                      //               width: 70,
                      //               height: 40,
                      //               decoration: BoxDecoration(
                      //                 color: Colors.white,
                      //                 borderRadius: BorderRadius.only(
                      //                     topRight: Radius.circular(30),
                      //                     bottomRight: Radius.circular(30)),
                      //                 boxShadow: [
                      //                   BoxShadow(
                      //                     color: Colors.grey.withOpacity(0.5),
                      //                     spreadRadius: 1,
                      //                     blurRadius: 2,
                      //                     offset: Offset(0,
                      //                         3), // changes position of shadow
                      //                   ),
                      //                 ],
                      //               ),
                      //               child: Container(
                      //                 decoration: BoxDecoration(
                      //                     borderRadius: BorderRadius.only(
                      //                         topRight: Radius.circular(30),
                      //                         bottomRight: Radius.circular(30)),
                      //                     gradient: AppConstant.BUTTON_COLOR),
                      //                 child: Image.asset(
                      //                   'assets/images/back_icon.png',
                      //                   width: 10,
                      //                   height: 10,
                      //                 ),
                      //               ),
                      //             ),
                      //           ),
                      //         ),
                      //       ),
                      //     ),
                      //     Container(
                      //       alignment: Alignment.center,
                      //       width: MediaQuery.of(context).size.width * 0.4,
                      //       child: Padding(
                      //         padding: const EdgeInsets.only(top: 15.0),
                      //         child: Container(
                      //             height: 30,
                      //             child: Center(
                      //               child: AppConstant.HEADLINE_TEXT(
                      //                   index == 2
                      //                       ? "Privacy Policy"
                      //                       : index == 1
                      //                           ? "About US"
                      //                           : "T&C",
                      //                   context),
                      //             )),
                      //       ),
                      //     ),
                      //     Flexible(
                      //       child: Visibility(
                      //         visible: false,
                      //         maintainAnimation: true,
                      //         maintainSemantics: true,
                      //         maintainState: true,
                      //         maintainSize: true,
                      //         child: Container(
                      //           width: MediaQuery.of(context).size.width / 3,
                      //           alignment: Alignment.centerRight,
                      //           child: Padding(
                      //               padding: EdgeInsets.only(top: 0, right: 10),
                      //               child: Icon(Icons.notifications)),
                      //         ),
                      //       ),
                      //     )
                      //   ],
                      // ),
                      // SizedBox(
                      //   height: 8,
                      // ),
                      // SizedBox(
                      //   child: Container(
                      //     height: 2,
                      //     decoration:
                      //         BoxDecoration(color: Colors.grey, boxShadow: [
                      //       BoxShadow(
                      //         offset: Offset(2, 4),
                      //         color: Colors.black.withOpacity(
                      //           0.3,
                      //         ),
                      //         blurRadius: 3,
                      //       ),
                      //     ]),
                      //   ),
                      // )
                    ],
                  ),
                ),
              ),
              // SizedBox(
              //   height: AppConstant.APP_EXTRA_LARGE_PADDING,
              // ),
              Center(
                child: Container(
                  padding: EdgeInsets.all(AppConstant.LARGE_SIZE),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                          alignment: Alignment.center,
                          child: index == 0
                              ? Image.asset("assets/images/abt_us.png")
                              : index == 1
                                  ? Image.asset("assets/images/tandc.png")
                                  : /*Container(
                                    height: 200,alignment: Alignment.center,
                                    decoration: BoxDecoration(   color: Colors.blue, image: DecorationImage(image: AssetImage("assets/newImages/applogo.png"),fit: BoxFit.cover),),
                                    *//*child: Image.asset(
                                        // "assets/images/demologo.png",
                                                                'assets/newImages/applogo.png',
                                        width: 200,
                                        height: 200,
                                      ),*//*
                                  )*/
                          Container(
                            height: 250,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              // color: Colors.blue,
                              image: DecorationImage(
                                image: AssetImage("assets/newImages/applogo.png",),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),


                      ),
                      // SizedBox(
                      //   height: AppConstant.SMALL_TEXT_SIZE,
                      // ),
                      Flex(
                        direction: Axis.vertical,
                        children:[ Container(
                          width: 800,
                          child: Html(data: msg),
                        ),]
                      ),
                      SizedBox(
                        height: AppConstant.LARGE_SIZE,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
