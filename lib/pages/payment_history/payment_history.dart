// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bounceable/flutter_bounceable.dart';
// import 'package:get/get.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// import '../../controllers/payment_controller.dart';
// import '../../utils/app_constant.dart';
//
// class PaymentHistory extends StatefulWidget {
//   const PaymentHistory({Key? key}) : super(key: key);
//
//   @override
//   State<PaymentHistory> createState() => _PaymentHistoryState();
// }
//
// class _PaymentHistoryState extends State<PaymentHistory> {
//   var user_data = [];
//   var load_status = false;
//   var userid = "";
//   final PaymentController paymentController = Get.find();
//
//   void getUserData(key) async {
//     final sp = await SharedPreferences.getInstance();
//     setState(() {
//       user_data = sp.getStringList(key)!;
//       load_status = true;
//       userid = user_data[0].toString();
//       paymentController.getPaymentHistory(userid);
//       //  util.showSnackBar("Alert", userid.toString(), true);
//     });
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     paymentController.nodata.value=false;
//     getUserData("user_data");
//   }
//
//
//   @override
//   void dispose() {
//     super.dispose();
//     paymentController.dispose();
//
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Container(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Container(
//                 child: Center(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           Visibility(
//                             visible: true,
//                             maintainSize: true,
//                             maintainState: true,
//                             maintainSemantics: true,
//                             maintainAnimation: true,
//                             child: Container(
//                               width: MediaQuery.of(context).size.width / 3,
//                               alignment: Alignment.centerLeft,
//                               child: Padding(
//                                 padding: EdgeInsets.only(top: 10),
//                                 child: Bounceable(
//                                   onTap: () {
//                                     Get.back();
//                                   },
//                                   child: Container(
//                                     width: 70,
//                                     height: 40,
//                                     decoration: BoxDecoration(
//                                       color: Colors.white,
//                                       borderRadius: BorderRadius.only(
//                                           topRight: Radius.circular(30),
//                                           bottomRight: Radius.circular(30)),
//                                       boxShadow: [
//                                         BoxShadow(
//                                           color: Colors.grey.withOpacity(0.5),
//                                           spreadRadius: 1,
//                                           blurRadius: 2,
//                                           offset: Offset(0,
//                                               3), // changes position of shadow
//                                         ),
//                                       ],
//                                     ),
//                                     child: Container(
//                                       decoration: BoxDecoration(
//                                           borderRadius: BorderRadius.only(
//                                               topRight: Radius.circular(30),
//                                               bottomRight: Radius.circular(30)),
//                                           gradient: AppConstant.BUTTON_COLOR),
//                                       child: Image.asset(
//                                         'assets/images/back_icon.png',
//                                         width: 10,
//                                         height: 10,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                           Container(
//                             alignment: Alignment.center,
//                             width: MediaQuery.of(context).size.width / 3,
//                             child: Padding(
//                               padding: const EdgeInsets.only(top: 15.0),
//                               child: Container(
//                                   height: 40,
//                                   child: FittedBox(
//                                     child: AppConstant.HEADLINE_TEXT(
//                                         AppConstant.TITLE_TEXT_PAY_HISTORY,
//                                         context),
//                                   )),
//                             ),
//                           ),
//                           Visibility(
//                             visible: false,
//                             maintainAnimation: true,
//                             maintainSemantics: true,
//                             maintainState: true,
//                             maintainSize: true,
//                             child: Container(
//                               width: MediaQuery.of(context).size.width / 3,
//                               alignment: Alignment.centerRight,
//                               child: Padding(
//                                   padding: EdgeInsets.only(top: 0, right: 10),
//                                   child: Icon(Icons.notifications)),
//                             ),
//                           ),
//                         ],
//                       ),
//                       SizedBox(
//                         height: 8,
//                       ),
//                       SizedBox(
//                         child: Container(
//                           height: 2,
//                           decoration:
//                               BoxDecoration(color: Colors.grey, boxShadow: [
//                             BoxShadow(
//                               offset: Offset(2, 4),
//                               color: Colors.black.withOpacity(
//                                 0.3,
//                               ),
//                               blurRadius: 3,
//                             ),
//                           ]),
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//               ),
//               SizedBox(height: 20),
//               Flexible(
//                 child: Column(
//                   children: [
//                     Flexible(
//                       child: Obx(() => paymentController.nodata == true
//                           ? Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Image.asset(
//                                   "assets/images/no_doc.png",
//                                   scale: 5,
//                                 ),
//                                 SizedBox(
//                                   height: 20,
//                                 ),
//                                 Center(
//                                   child: Text("No data found!!"),
//                                 ),
//                               ],
//                             )
//                           : ListView.builder(
//                               itemBuilder: (c, i) {
//                                 return Center(
//                                   child: paymentController.getHistory.length ==
//                                           0
//                                       ? Center(
//                                           child: Text("No payment history!"),
//                                         )
//                                       : Container(
//                                           height: 76,
//                                           width: 358,
//                                           margin: EdgeInsets.all(10),
//                                           decoration: BoxDecoration(
//                                               borderRadius:
//                                                   BorderRadius.circular(30),
//                                               gradient: AppConstant
//                                                   .SETTING_BUTTON_COLOR),
//                                           child: Column(
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.spaceEvenly,
//                                             crossAxisAlignment:
//                                                 CrossAxisAlignment.start,
//                                             children: [
//                                               Row(
//                                                 mainAxisAlignment:
//                                                     MainAxisAlignment.start,
//                                                 children: [
//                                                   Padding(
//                                                     padding:
//                                                         const EdgeInsets.only(
//                                                             left: 16.0),
//                                                     child: Text(
//                                                       "Transaction Id - ",
//                                                       style: AppConstant
//                                                           .Lextendnew(context,
//                                                               Colors.black, 15),
//                                                     ),
//                                                   ),
//                                                   Text(
//                                                     "${paymentController.getHistory[i]!.razarpayPaymentId.toString()}",
//                                                     style:
//                                                         AppConstant.Lextendnew(
//                                                             context,
//                                                             Color(0xFF999898),
//                                                             15),
//                                                     overflow: TextOverflow.ellipsis,
//                                                     maxLines: 1,
//                                                   ),
//                                                 ],
//                                               ),
//                                               Row(
//                                                 mainAxisAlignment:
//                                                     MainAxisAlignment.start,
//                                                 crossAxisAlignment:
//                                                     CrossAxisAlignment.end,
//                                                 children: [
//                                                   Padding(
//                                                     padding:
//                                                         const EdgeInsets.only(
//                                                             left: 16.0),
//                                                     child: Text("Paid",
//                                                         style: AppConstant
//                                                             .Lextendnew(
//                                                                 context,
//                                                                 Colors.black,
//                                                                 15)),
//                                                   ),
//                                                   SizedBox(
//                                                     width: 8,
//                                                   ),
//                                                   Text(
//                                                     "${paymentController.getHistory[i]!.amount} RS",
//                                                     style:
//                                                         AppConstant.Lextendnew(
//                                                             context,
//                                                             Color(0xFF01BE2A),
//                                                             15),
//                                                   ),
//                                                   Expanded(child: Container()),
//                                                   Padding(
//                                                     padding:
//                                                         const EdgeInsets.only(
//                                                             right: 16.0),
//                                                     child: Text(
//                                                       "${paymentController.getHistory[i]!.created}"
//                                                           .toString()
//                                                           .substring(0, 11),
//                                                       style: AppConstant
//                                                           .Lextendnew(
//                                                               context,
//                                                               Color(0xFF7E6666),
//                                                               8),
//                                                     ),
//                                                   )
//                                                 ],
//                                               )
//                                             ],
//                                           ),
//                                         ),
//                                 );
//                               },
//                               itemCount: paymentController.getHistory.length,
//                             )),
//                     ),
//                   ],
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//

import 'dart:convert';
import 'dart:math';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:dentocoreauth/Utills/Utills.dart';
import 'package:dentocoreauth/pages/homepage/MyHomePage.dart';

import 'package:dentocoreauth/utils/app_constant.dart';
import 'package:dentocoreauth/utils/mycolor.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../controllers/payment_controller.dart';
import '../../utils/component_screen.dart';
import 'package:intl/intl.dart';

class PaymentHistory extends StatefulWidget {
  const PaymentHistory({Key? key}) : super(key: key);

  @override
  State<PaymentHistory> createState() => _PaymentHistoryState();
}

class PaymentModel {
  String _paymentID;
  String _orderID;
  String _signature;

  PaymentModel(this._paymentID, this._orderID, this._signature);

  String get paymentID => _paymentID;

  set paymentID(String value) => _paymentID = value;

  String get orderID => _orderID;

  set orderID(String value) => _orderID = value;

  String get signature => _signature;

  set signature(String value) => _signature = value;
}

class _PaymentHistoryState extends State<PaymentHistory> {
  var user_data = [];
  var load_status = false;
  var userid = "";
  final PaymentController paymentController = Get.find();

  void getUserData(key) async {
    final sp = await SharedPreferences.getInstance();
    setState(() {
      user_data = sp.getStringList(key)!;
      load_status = true;
      userid = user_data[0].toString();
      paymentController.getPaymentHistory(userid);
      //  util.showSnackBar("Alert", userid.toString(), true);
    });
  }

  @override
  void initState() {
    super.initState();
    paymentController.nodata.value = false;
    getUserData("user_data");
  }

  @override
  void dispose() {
    super.dispose();
    paymentController.dispose();
  }

  final List<Color> containerColors = [
    Colors.blue[200]!,
    Colors.green[200]!,
    Colors.red[200]!,
    Colors.yellow[200]!,
    Colors.purple[200]!,
    Colors.orange[200]!,
    Colors.pink[200]!,
  ];

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery
        .of(context)
        .size
        .height;
    final width = MediaQuery
        .of(context)
        .size
        .width;
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
            statusBarColor: MyColor.primarycolor,
            statusBarIconBrightness: Brightness.light,
            statusBarBrightness: Brightness.light,
            systemNavigationBarColor: Colors.transparent),
        child: Scaffold(
          body: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CustomAppBar(title: 'Payment History'),
                Flexible(
                  child: Obx(
                        () =>
                    paymentController.nodata == true
                        ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/images/no_doc.png",
                          scale: 5,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: Text("No data found!!"),
                        ),
                      ],
                    )
                        : ListView.builder(
                      // shrinkWrap: true,
                      // physics: BouncingScrollPhysics(),
                      itemCount: paymentController.getHistory.length,
                      // Added itemCount for demonstration
                      itemBuilder: (context, index) {
                        final Time = DateFormat('hh:mm aa').format(
                            paymentController.getHistory[index]!.created);
                        final Date = DateFormat('dd MMM').format(
                            paymentController.getHistory[index]!.created);
                        return Center(
                          child: /*paymentController.getHistory.length ==
                              0 ? Center(
                            child: Text("No payment history!"),
                          )
                              :*/ Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: height * 0.01,
                              ),
                              Divider(),
                              Row(
                                children: [
                                  Container(
                                    height: height * 0.05,
                                    width: width * 0.24,
                                    decoration: BoxDecoration(
                                      color: containerColors[
                                      index % containerColors.length],
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(20),
                                          bottomRight: Radius.circular(20)),
                                    ),
                                    child: Center(
                                        child: Text(
                                          "${Date}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              color: Colors.white),
                                        )),
                                  ),
                                  SizedBox(width: 16), // Added spacing
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Text("Transaction Id"),
                                            Text(
                                              "${paymentController
                                                  .getHistory[index]!
                                                  .razarpayPaymentId
                                                  .toString()}",
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight:
                                                  FontWeight.w600,
                                                  color: Colors.grey),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                            width: 16), // Added spacing
                                        Padding(
                                          padding:
                                          const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                            children: [
                                              RichText(
                                                text: TextSpan(
                                                  children: [
                                                    TextSpan(
                                                        text: "Paid ",
                                                        style: TextStyle(
                                                            color: Colors
                                                                .black,
                                                            fontWeight:
                                                            FontWeight
                                                                .w400)),
                                                    TextSpan(
                                                        text: "${paymentController
                                                            .getHistory[index]!
                                                            .amount} RS",
                                                        style: TextStyle(
                                                            color: Colors
                                                                .green,
                                                            fontWeight:
                                                            FontWeight
                                                                .w600)),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(height: 2,),
                                              Text(
                                                "${Time /*paymentController.getHistory[index]!.created*/}",
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight:
                                                    FontWeight.w600,
                                                    color: Colors.grey),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
