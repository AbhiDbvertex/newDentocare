// import 'dart:convert';
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bounceable/flutter_bounceable.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:flutter_html/flutter_html.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
// import 'package:dentocoreauth/models/prescription_dto.dart';
// import 'package:dentocoreauth/pages/homepage/MyHomePage.dart';
// import 'package:dentocoreauth/utils/app_constant.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
// import '../../Utills/Utills.dart';
// import '../../controllers/notification_controller.dart';
// import '../../controllers/user_controller.dart';
//
// import 'package:dentocoreauth/pages/prescription/prescription.dart'
//     as myprescription;
//
// import '../../utils/component_screen.dart';
// import '../prescription/prescription.dart';
//
// class MyNotification extends StatefulWidget {
//   const MyNotification({Key? key}) : super(key: key);
//
//   @override
//   State<MyNotification> createState() => _NotificationState();
// }
//
// class _NotificationState extends State<MyNotification> {
//   _NotificationState() {}
//   final NotificationController notificationController = Get.find();
//   final UserController userController = Get.find();
//
//   // _notificationController.setDot(false);
//   var util = Utills();
//   var notification_list = [];
//   var postid = "";
//   var allPostList = [];
//   var tempPostList = [];
//   var userid = "";
//   var user_data = [];
//   var isLoading = false;
//
// //_notificationController.setDot(false);
//   var load_status = false;
//
//   formate(String time) {
//     var cdata = time.toString().substring(0, 10);
//     var now = DateTime.now();
//     print(DateFormat().format(now));
//     var today = DateFormat('yyyy-MM-dd').format(now);
//
//     final _today = today.replaceAll(RegExp('-'), '').trim();
//     final _pdate = cdata.replaceAll(RegExp('-'), '').trim();
//     var myIntToday = int.parse(_today);
//     var myIntPdate = int.parse(_pdate);
//     if (myIntToday - 1 == myIntPdate) {
//       return "Yesterday";
//     }
//     if (today.trim() == cdata.trim()) {
//       return "Today";
//     } else {
//       return cdata.trim().toString();
//     }
//   }
//
//   void getUserData(key) async {
//     final sp = await SharedPreferences.getInstance();
//     setState(() {
//       user_data = sp.getStringList(key)!;
//       load_status = true;
//       userid = user_data[0].toString();
//       // util.showSnackBar("Alert",   user_data[0].toString(), true);
//       userController.getAppointmentlist(userid).then(
//           (value) => {util.stopLoading(), userController.getlist.refresh()});
//
//       notificationController
//           .getNotifications(userid)
//           .then((value) => setState(() {
//                 // util.showSnackBar("Alert",   "called", true);
//                 util.stopLoading();
//                 notificationController.getlist.refresh();
//                 debugPrint("njdata" + value!.body[0].id.toString());
//                 //notification_list = value!.body;
//               }));
//       if (EasyLoading.isShow) {
//         EasyLoading.dismiss();
//       }
//     });
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//
//     notificationController.dispose();
//
//     if (EasyLoading.isShow) {
//       EasyLoading.dismiss();
//     }
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     getUserData("user_data");
//     //_notificationController.setDot(false);
//
//     Future.delayed(Duration(milliseconds: 2000), () {
//       notificationController.setDot(false);
//       if (EasyLoading.isShow) {
//         EasyLoading.dismiss();
//       }
//     });
//   }
//
//   doFormating(String status) {
//     switch (status) {
//       case "0":
//         {}
//         ;
//         break;
//       case "1":
//         {}
//         ;
//         break;
//       case "2":
//         {}
//         ;
//         break;
//       case "3":
//         {
//           return RichText(
//             text: TextSpan(
//               text: 'Hello ',
//               children: <TextSpan>[
//                 TextSpan(
//                     text: 'bold',
//                     style: TextStyle(fontWeight: FontWeight.bold)),
//                 TextSpan(text: ' world!'),
//               ],
//             ),
//           );
//         }
//         ;
//         break;
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // appBar: CustomAppBar(title: 'Service'),
//       body: Obx(() => SafeArea(
//             child: notificationController.isloading.value == true
//                 ? Center(
//                     child: CircularProgressIndicator(),
//                   )
//                 : notificationController.getlist.length == 0
//                     ? Center(
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Image.asset("assets/newImages/notificationIcon.png",scale: 2,),
//                             SizedBox(
//                               height: 12,
//                             ),
//                             Text("No notifications found!",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600),),
//                             SizedBox(
//                               height: 10,
//                             ),
//                             MaterialButton(
//                               onPressed: () {
//                                 Get.back();
//                               },
//                               child: Container(
//                                 width: 100,
//                                 height: 40,
//                                 decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(30),
//                                     border: Border.all(color: Colors.white),
//                                     color: Colors.blue),
//                                 child: Center(
//                                   child: Text(
//                                     "Back",
//                                     style: TextStyle(),
//                                   ),
//                                 ),
//                               ),
//                             )
//                           ],
//                         ),
//                       )
//                     : SingleChildScrollView(
//                         child: Container(
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.spaceAround,
//                             children: [
//                               // Container(
//                               //   child: Center(
//                               //     child: Column(
//                               //       mainAxisAlignment: MainAxisAlignment.start,
//                               //       children: [
//                               //         Row(
//                               //           mainAxisAlignment:
//                               //               MainAxisAlignment.spaceBetween,
//                               //           crossAxisAlignment:
//                               //               CrossAxisAlignment.center,
//                               //           children: [
//                               //             Visibility(
//                               //               visible: true,
//                               //               maintainSize: true,
//                               //               maintainState: true,
//                               //               maintainSemantics: true,
//                               //               maintainAnimation: true,
//                               //               child: Container(
//                               //                 width: MediaQuery.of(context)
//                               //                         .size
//                               //                         .width /
//                               //                     3,
//                               //                 alignment: Alignment.centerLeft,
//                               //                 child: Padding(
//                               //                   padding:
//                               //                       EdgeInsets.only(top: 10),
//                               //                   child: Bounceable(
//                               //                     onTap: () {
//                               //                       //  Get.offAll(MyHomePage());//
//                               //                       backToHome(context);
//                               //                     },
//                               //                     child: Container(
//                               //                       width: 70,
//                               //                       height: 40,
//                               //                       decoration: BoxDecoration(
//                               //                         color: Colors.white,
//                               //                         borderRadius:
//                               //                             BorderRadius.only(
//                               //                                 topRight: Radius
//                               //                                     .circular(30),
//                               //                                 bottomRight:
//                               //                                     Radius
//                               //                                         .circular(
//                               //                                             30)),
//                               //                         boxShadow: [
//                               //                           BoxShadow(
//                               //                             color: Colors.grey
//                               //                                 .withOpacity(0.5),
//                               //                             spreadRadius: 1,
//                               //                             blurRadius: 2,
//                               //                             offset: Offset(0,
//                               //                                 3), // changes position of shadow
//                               //                           ),
//                               //                         ],
//                               //                       ),
//                               //                       child: Container(
//                               //                         decoration: BoxDecoration(
//                               //                             borderRadius:
//                               //                                 BorderRadius.only(
//                               //                                     topRight: Radius
//                               //                                         .circular(
//                               //                                             30),
//                               //                                     bottomRight:
//                               //                                         Radius.circular(
//                               //                                             30)),
//                               //                             gradient: AppConstant
//                               //                                 .BUTTON_COLOR),
//                               //                         child: Image.asset(
//                               //                           'assets/images/back_icon.png',
//                               //                           width: 10,
//                               //                           height: 10,
//                               //                         ),
//                               //                       ),
//                               //                     ),
//                               //                   ),
//                               //                 ),
//                               //               ),
//                               //             ),
//                               //             Container(
//                               //               alignment: Alignment.center,
//                               //               width: MediaQuery.of(context)
//                               //                       .size
//                               //                       .width /
//                               //                   3,
//                               //               child: Padding(
//                               //                 padding: const EdgeInsets.only(
//                               //                     top: 15.0),
//                               //                 child: Container(
//                               //                   height: 40,
//                               //                   child: AppConstant.HEADLINE_TEXT(
//                               //                       AppConstant
//                               //                           .TITLE_TEXT_NOTIFICATION,
//                               //                       context),
//                               //                 ),
//                               //               ),
//                               //             ),
//                               //             Visibility(
//                               //               visible: false,
//                               //               maintainAnimation: true,
//                               //               maintainSemantics: true,
//                               //               maintainState: true,
//                               //               maintainSize: true,
//                               //               child: Container(
//                               //                 width: MediaQuery.of(context)
//                               //                         .size
//                               //                         .width /
//                               //                     3,
//                               //                 alignment: Alignment.centerRight,
//                               //                 child: Padding(
//                               //                     padding: EdgeInsets.only(
//                               //                         top: 0, right: 10),
//                               //                     child: Icon(
//                               //                         Icons.notifications)),
//                               //               ),
//                               //             )
//                               //           ],
//                               //         ),
//                               //         SizedBox(
//                               //           height: 8,
//                               //         ),
//                               //         SizedBox(
//                               //           child: Container(
//                               //             height: 2,
//                               //             decoration: BoxDecoration(
//                               //                 color: Colors.grey,
//                               //                 boxShadow: [
//                               //                   BoxShadow(
//                               //                     offset: Offset(2, 4),
//                               //                     color:
//                               //                         Colors.black.withOpacity(
//                               //                       0.3,
//                               //                     ),
//                               //                     blurRadius: 3,
//                               //                   ),
//                               //                 ]),
//                               //           ),
//                               //         )
//                               //       ],
//                               //     ),
//                               //   ),
//                               // ),
//                               // SizedBox(
//                               //   height: AppConstant.APP_EXTRA_LARGE_PADDING,
//                               // ),
//                               // InkWell(
//                               //   onTap: () {},
//                               //   child: Text(
//                               //     AppConstant.TEXT_HEAD_NOTIFICATION,
//                               //     style: TextStyle(
//                               //         fontSize: AppConstant.MEDIUM_SIZE,
//                               //         fontWeight: FontWeight.bold),
//                               //   ),
//                               // ),
//                               CustomAppBar(title: 'Notification'),
//                               SizedBox(
//                                 height: AppConstant.APP_EXTRA_LARGE_PADDING,
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.all(10.0),
//                                 child: SingleChildScrollView(
//                                   child: Container(
//                                     height: MediaQuery.of(context).size.height -
//                                         200,
//                                     child: ListView.builder(
//                                       key: UniqueKey(),
//                                       physics: AlwaysScrollableScrollPhysics(),
//                                       itemBuilder: (c, i) {
//                                         return Center(
//                                           child: Padding(
//                                             padding: const EdgeInsets.only(
//                                                 bottom: 8.0),
//                                             child: InkWell(
//                                               onTap: () {
//                                                 //  userController.getPrescction("${notificationController.getlist[i]!.appointmentId}");
//
//                                                 if (notificationController
//                                                         .getlist[i]!.message
//                                                         .contains("Visited") ||
//                                                     notificationController
//                                                         .getlist[i]!.message
//                                                         .contains(
//                                                             "Revisited")) {
//                                                   //  util.showSnackBar("Alert",   "${notificationController.getlist[i]!.appointmentId}", true);
//
//                                                   userController
//                                                       .getPrescction(
//                                                           userController
//                                                               .getlist[i]!.id)
//                                                       .then((value) => {
//                                                             Future.delayed(
//                                                                 Duration(
//                                                                     milliseconds:
//                                                                         500),
//                                                                 () {
//                                                               debugPrint(
//                                                                   "called");
//                                                               Get.to(MyPrescription(
//                                                                   userController
//                                                                       .getlist[
//                                                                           i]!
//                                                                       .appointmentImages,true));
//
//                                                               debugPrint("presceiptiondata" +
//                                                                   userController
//                                                                       .getlist[
//                                                                           0]!
//                                                                       .appointmentImages
//                                                                       .toString());
//                                                             })
//                                                           });
//
//                                                   // notificationController
//                                                   //     .getNotificationsDetails(
//                                                   //         "${notificationController.getlist[i]!.appointmentId}")
//                                                   //     .then((value) => {
//                                                   //           debugPrint(
//                                                   //               "nishantdeatils" +
//                                                   //                   "${value!.body!.appointmentImages[0].toString()}"),
//                                                   //           userController
//                                                   //               .getAppointmentlist(
//                                                   //                   userid)
//                                                   //               .then(
//                                                   //                   (myvalue) => {
//                                                   //                         userController
//                                                   //                             .getlist
//                                                   //                             .refresh(),
//                                                   //                         Future.delayed(
//                                                   //                             Duration(milliseconds: 500),
//                                                   //                             () {
//                                                   //                           Get.to(MyPrescription(value!
//                                                   //                               .body
//                                                   //                               .appointmentImages));
//                                                   //                         }),
//                                                   //                       })
//                                                   //         });
//                                                 } else {
//                                                   // Get.offAll(MyHomePage());
//                                                   backToHome(context);
//                                                 }
//
//                                                 // util.showSnackBar("Alert", "${notificationController.getlist[i]!.appointmentId}", false);
//                                               },
//                                               child: Container(
//                                                 padding:
//                                                     EdgeInsets.only(bottom: 1),
//                                                 margin:
//                                                     EdgeInsets.only(bottom: 10),
//                                                 decoration: BoxDecoration(
//                                                     borderRadius:
//                                                         BorderRadius.circular(
//                                                             20),
//                                                     gradient: AppConstant
//                                                         .Notification_gradient),
//                                                 child: Column(
//                                                   mainAxisAlignment:
//                                                       MainAxisAlignment.center,
//                                                   crossAxisAlignment:
//                                                       CrossAxisAlignment.start,
//                                                   children: [
//                                                     Row(
//                                                       mainAxisAlignment:
//                                                           MainAxisAlignment
//                                                               .start,
//                                                       children: [
//                                                         Padding(
//                                                           padding:
//                                                               const EdgeInsets
//                                                                       .only(
//                                                                   top: 10.0,
//                                                                   left: 8),
//                                                           child: CircleAvatar(
//                                                             radius: 24,
//                                                             backgroundImage:
//                                                                 AssetImage(
//                                                                     'assets/images/logo_new.jpg'),backgroundColor: Colors.white,
//                                                           ),
//                                                         ),
//                                                         Padding(
//                                                             padding:
//                                                                 const EdgeInsets.only(
//                                                                     left: 16.0),
//                                                             child: Obx(() =>
//                                                                 notificationController
//                                                                         .getlist[
//                                                                             i]!
//                                                                         .message
//                                                                         .contains(
//                                                                             "Accepted")
//                                                                     ? RichText(
//                                                                         text:
//                                                                             TextSpan(
//                                                                           children: <
//                                                                               TextSpan>[
//                                                                             TextSpan(
//                                                                                 text: 'Appointment. ID',
//                                                                                 style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.black)),
//                                                                             TextSpan(
//                                                                                 text: ' - #${notificationController.getlist[i]!.appointmentId.toString()} is ',
//                                                                                 style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.black)),
//                                                                             TextSpan(
//                                                                                 text: ' Accepted!',
//                                                                                 style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.green)),
//                                                                           ],
//                                                                         ),
//                                                                       )
//                                                                     : notificationController
//                                                                     .getlist[i]!
//                                                                     .message
//                                                                     .contains("Reshedule")?RichText(
//                                                                   text:
//                                                                   TextSpan(
//                                                                     children: <
//                                                                         TextSpan>[
//                                                                       TextSpan(
//                                                                           text: 'Appointment. ID',
//                                                                           style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.black)),
//                                                                       TextSpan(
//                                                                           text: ' - #${notificationController.getlist[i]!.appointmentId.toString()} is ',
//                                                                           style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.black)),
//                                                                       TextSpan(
//                                                                           text: ' Resheduled!',
//                                                                           style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.orange)),
//                                                                     ],
//                                                                   ),
//                                                                 ):notificationController
//                                                                             .getlist[i]!
//                                                                             .message
//                                                                             .contains("Rejected")
//                                                                         ? RichText(
//                                                                             text:
//                                                                                 TextSpan(
//                                                                               children: <TextSpan>[
//                                                                                 TextSpan(text: 'Appointment. ID', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.black)),
//                                                                                 TextSpan(text: ' - #${notificationController.getlist[i]!.appointmentId.toString()} is ', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400, color: Colors.black)),
//                                                                                 TextSpan(text: ' Rejected!', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.red)),
//                                                                               ],
//                                                                             ),
//                                                                           )
//                                                                         : notificationController.getlist[i]!.message.contains("Pendding")
//                                                                             ? RichText(
//                                                                                 text: TextSpan(
//                                                                                   children: <TextSpan>[
//                                                                                     TextSpan(text: 'Appointment. ID', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.black)),
//                                                                                     TextSpan(text: ' id - #${notificationController.getlist[i]!.appointmentId.toString()} is ', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400, color: Colors.black)),
//                                                                                     TextSpan(text: ' Pendding!', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.yellow)),
//                                                                                   ],
//                                                                                 ),
//                                                                               )
//                                                                             : notificationController.getlist[i]!.message.contains("Revisited")
//                                                                                 ? RichText(
//                                                                                     text: TextSpan(
//                                                                                       children: <TextSpan>[
//                                                                                         TextSpan(text: 'Appointment. ID', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.black)),
//                                                                                         TextSpan(text: ' id - #${notificationController.getlist[i]!.appointmentId.toString()} is ', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400, color: Colors.black)),
//                                                                                         TextSpan(text: ' Revisited!', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.orange)),
//                                                                                       ],
//                                                                                     ),
//                                                                                   )
//                                                                                 : RichText(
//                                                                                     text: TextSpan(
//                                                                                       children: <TextSpan>[
//                                                                                         TextSpan(text: 'Appointment. ID', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.black)),
//                                                                                         TextSpan(text: ' - #${notificationController.getlist[i]!.appointmentId.toString()} is ', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400, color: Colors.black)),
//                                                                                         TextSpan(text: ' Visited!', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.white)),
//                                                                                       ],
//                                                                                     ),
//                                                                                   ))),
//                                                       ],
//                                                     ),
//                                                     Row(
//                                                       crossAxisAlignment:
//                                                           CrossAxisAlignment
//                                                               .start,
//                                                       mainAxisAlignment:
//                                                           MainAxisAlignment.end,
//                                                       children: [
//                                                         Padding(
//                                                           padding:
//                                                               const EdgeInsets
//                                                                       .only(
//                                                                   right: 14.0,
//                                                                   bottom: 2),
//                                                           child: Text(
//                                                             formate(
//                                                                 "${notificationController.getlist[i]!.createdAt}"
//                                                                     .substring(
//                                                                         0, 11)),
//                                                             style: TextStyle(
//                                                               fontSize: 15,
//                                                               color:
//                                                                   Colors.white,
//                                                               fontWeight:
//                                                                   FontWeight
//                                                                       .w600,
//                                                             ),
//                                                           ),
//                                                         ),
//                                                       ],
//                                                     )
//                                                   ],
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                         );
//                                       },
//                                       itemCount:
//                                           notificationController.getlist.length,
//                                     ),
//                                   ),
//                                 ),
//                               )
//                             ],
//                           ),
//                         ),
//                       ),
//           )),
//     );
//   }
//
//   void backToHome(BuildContext context) {
//     Navigator.pushReplacement(
//         context, MaterialPageRoute(builder: (context) => MyHomePage()));
//   }
// }
//
// class NotificationClassItem {
//   String post_id;
//   String title;
//   String created;
//   String notification;
//
//   NotificationClassItem(
//       {required this.post_id,
//       required this.title,
//       required this.created,
//       required this.notification});
// }
  ///  currect the code
// import 'dart:convert';
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bounceable/flutter_bounceable.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:flutter_html/flutter_html.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
// import 'package:dentocoreauth/models/prescription_dto.dart';
// import 'package:dentocoreauth/pages/homepage/MyHomePage.dart';
// import 'package:dentocoreauth/utils/app_constant.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
// import '../../Utills/Utills.dart';
// import '../../controllers/notification_controller.dart';
// import '../../controllers/user_controller.dart';
//
// import 'package:dentocoreauth/pages/prescription/prescription.dart'
// as myprescription;
//
// import '../../utils/component_screen.dart';
// import '../prescription/prescription.dart';
//
// class MyNotification extends StatefulWidget {
//   const MyNotification({Key? key}) : super(key: key);
//
//   @override
//   State<MyNotification> createState() => _NotificationState();
// }
//
// class _NotificationState extends State<MyNotification> {
//   _NotificationState() {}
//   final NotificationController notificationController = Get.find();
//   final UserController userController = Get.find();
//
//   // _notificationController.setDot(false);
//   var util = Utills();
//   var notification_list = [];
//   var postid = "";
//   var allPostList = [];
//   var tempPostList = [];
//   var userid = "";
//   var user_data = [];
//   var isLoading = false;
//
// //_notificationController.setDot(false);
//   var load_status = false;
//
//   formate(String time) {
//     var cdata = time.toString().substring(0, 10);
//     var now = DateTime.now();
//     print(DateFormat().format(now));
//     var today = DateFormat('yyyy-MM-dd').format(now);
//
//     final _today = today.replaceAll(RegExp('-'), '').trim();
//     final _pdate = cdata.replaceAll(RegExp('-'), '').trim();
//     var myIntToday = int.parse(_today);
//     var myIntPdate = int.parse(_pdate);
//     if (myIntToday - 1 == myIntPdate) {
//       return "Yesterday";
//     }
//     if (today.trim() == cdata.trim()) {
//       return "Today";
//     } else {
//       return cdata.trim().toString();
//     }
//   }
//
//   void getUserData(key) async {
//     final sp = await SharedPreferences.getInstance();
//     setState(() {
//       user_data = sp.getStringList(key)!;
//       load_status = true;
//       userid = user_data[0].toString();
//       // util.showSnackBar("Alert",   user_data[0].toString(), true);
//       userController.getAppointmentlist(userid).then(
//               (value) => {util.stopLoading(), userController.getlist.refresh()});
//
//       notificationController
//           .getNotifications(userid)
//           .then((value) => setState(() {
//         // util.showSnackBar("Alert",   "called", true);
//         util.stopLoading();
//         notificationController.getlist.refresh();
//         debugPrint("njdata" + value!.body[0].id.toString());
//         //notification_list = value!.body;
//       }));
//       if (EasyLoading.isShow) {
//         EasyLoading.dismiss();
//       }
//     });
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//
//     notificationController.dispose();
//
//     if (EasyLoading.isShow) {
//       EasyLoading.dismiss();
//     }
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     getUserData("user_data");
//     //_notificationController.setDot(false);
//     print("Abhi:- print get notification : ${notificationController.getlist[0]?.title}");
//     Future.delayed(Duration(milliseconds: 2000), () {
//       notificationController.setDot(false);
//       if (EasyLoading.isShow) {
//         EasyLoading.dismiss();
//       }
//     });
//   }
//
//   doFormating(String status) {
//     switch (status) {
//       case "0":
//         {}
//         ;
//         break;
//       case "1":
//         {}
//         ;
//         break;
//       case "2":
//         {}
//         ;
//         break;
//       case "3":
//         {
//           return RichText(
//             text: TextSpan(
//               text: 'Hello ',
//               children: <TextSpan>[
//                 TextSpan(
//                     text: 'bold',
//                     style: TextStyle(fontWeight: FontWeight.bold)),
//                 TextSpan(text: ' world!'),
//               ],
//             ),
//           );
//         }
//         ;
//         break;
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//
//     return Scaffold(
//       // appBar: CustomAppBar(title: 'Service'),
//       body: Obx(() => SafeArea(
//         child: notificationController.isloading.value == true
//             ? Center(
//           child: CircularProgressIndicator(),
//         )
//             : notificationController.getlist.length == 0
//             ? Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Image.asset("assets/newImages/notificationIcon.png",scale: 2,),
//               SizedBox(
//                 height: 12,
//               ),
//               Text("No notifications found!",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600),),
//               SizedBox(
//                 height: 10,
//               ),
//               MaterialButton(
//                 onPressed: () {
//                   Get.back();
//                 },
//                 child: Container(
//                   width: 100,
//                   height: 40,
//                   decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(30),
//                       border: Border.all(color: Colors.white),
//                       color: Colors.blue),
//                   child: Center(
//                     child: Text(
//                       "Back",
//                       style: TextStyle(),
//                     ),
//                   ),
//                 ),
//               )
//             ],
//           ),
//         )
//             : SingleChildScrollView(
//           child: Container(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 CustomAppBar(title: 'Notification'),
//                 SizedBox(
//                   height: AppConstant.APP_EXTRA_LARGE_PADDING,
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(10.0),
//                   child: SingleChildScrollView(
//                     child: Container(
//                       height: MediaQuery.of(context).size.height -
//                           200,
//                       child: ListView.builder(
//                         key: UniqueKey(),
//                         physics: AlwaysScrollableScrollPhysics(),
//                         itemBuilder: (c, i) {
//                           return Center(
//                             child: Padding(
//                               padding: const EdgeInsets.only(
//                                   bottom: 8.0),
//                               child: InkWell(
//                                 onTap: () {
//                                   //  userController.getPrescction("${notificationController.getlist[i]!.appointmentId}");
//
//                                   if (notificationController
//                                       .getlist[i]!.message
//                                       .contains("Visited") ||
//                                       notificationController
//                                           .getlist[i]!.message
//                                           .contains(
//                                           "Revisited")) {
//                                     //  util.showSnackBar("Alert",   "${notificationController.getlist[i]!.appointmentId}", true);
//
//                                     userController
//                                         .getPrescction(
//                                         userController
//                                             .getlist[i]!.id)
//                                         .then((value) => {
//                                       Future.delayed(
//                                           Duration(
//                                               milliseconds:
//                                               500),
//                                               () {
//                                             debugPrint(
//                                                 "called");
//                                             Get.to(MyPrescription(
//                                                 userController
//                                                     .getlist[
//                                                 i]!
//                                                     .appointmentImages,true));
//
//                                             debugPrint("presceiptiondata" +
//                                                 userController
//                                                     .getlist[
//                                                 0]!
//                                                     .appointmentImages
//                                                     .toString());
//                                           })
//                                     });
//
//                                     // notificationController
//                                     //     .getNotificationsDetails(
//                                     //         "${notificationController.getlist[i]!.appointmentId}")
//                                     //     .then((value) => {
//                                     //           debugPrint(
//                                     //               "nishantdeatils" +
//                                     //                   "${value!.body!.appointmentImages[0].toString()}"),
//                                     //           userController
//                                     //               .getAppointmentlist(
//                                     //                   userid)
//                                     //               .then(
//                                     //                   (myvalue) => {
//                                     //                         userController
//                                     //                             .getlist
//                                     //                             .refresh(),
//                                     //                         Future.delayed(
//                                     //                             Duration(milliseconds: 500),
//                                     //                             () {
//                                     //                           Get.to(MyPrescription(value!
//                                     //                               .body
//                                     //                               .appointmentImages));
//                                     //                         }),
//                                     //                       })
//                                     //         });
//                                   } else {
//                                     // Get.offAll(MyHomePage());
//                                     backToHome(context);
//                                   }
//
//                                   // util.showSnackBar("Alert", "${notificationController.getlist[i]!.appointmentId}", false);
//                                 },
//                                 child: Container(
//                                   padding:
//                                   EdgeInsets.only(bottom: 1),
//                                   margin:
//                                   EdgeInsets.only(bottom: 10),
//                                   decoration: BoxDecoration(
//                                       borderRadius:
//                                       BorderRadius.circular(
//                                           20),
//                                       gradient: AppConstant
//                                           .Notification_gradient),
//                                   child: Column(
//                                     mainAxisAlignment:
//                                     MainAxisAlignment.center,
//                                     crossAxisAlignment:
//                                     CrossAxisAlignment.start,
//                                     children: [
//                                       Row(
//                                         mainAxisAlignment:
//                                         MainAxisAlignment
//                                             .start,
//                                         children: [
//                                           Padding(
//                                             padding:
//                                             const EdgeInsets
//                                                 .only(
//                                                 top: 10.0,
//                                                 left: 8),
//                                             child: CircleAvatar(
//                                               radius: 24,
//                                               backgroundImage:
//                                               AssetImage(
//                                                   'assets/images/logo_new.jpg'),backgroundColor: Colors.white,
//                                             ),
//                                           ),
//                                           Padding(
//                                               padding:
//                                               const EdgeInsets.only(
//                                                   left: 16.0),
//                                               child: Obx(() =>
//                                               notificationController.getlist[i]!.message
//                                                   .contains(
//                                                   "Accepted")
//                                                   ? Column(
//                                                     children: [
//                                                       RichText(
//                                                         text: TextSpan(
//                                                       children: <
//                                                           TextSpan>[
//                                                         TextSpan(
//                                                             // text: 'Appointment. ID',
//                                                             // text: "You Appointment is Accepted ${/*notificationController.getlist[i]?.title ?? ""*/}",
//                                                             text: "You Appointment is Accepted",
//                                                             style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black)),
//
//                                                         TextSpan(
//                                                             text: 'Accepted!',
//                                                             style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.green)),
//                                                       ],
//                                                         ),
//                                                       ),
//                                                       Text(
//                                                           ' - #${notificationController.getlist[i]!.appointmentId.toString()} is ',
//                                                           style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black)),
//                                                     ],
//                                                   )
//                                                   : notificationController
//                                                   .getlist[i]!
//                                                   .message
//                                                   .contains("Reshedule")?RichText(
//                                                 text:
//                                                 TextSpan(
//                                                   children: <
//                                                       TextSpan>[
//                                                     TextSpan(
//                                                         // text: 'Appointment. ID',
//                                                         text: "Abhi ${notificationController.getlist[i]?.title ?? ""}",
//                                                         style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.black)),
//                                                     TextSpan(
//                                                         text: ' - #${notificationController.getlist[i]!.appointmentId.toString()} is ',
//                                                         style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.black)),
//                                                     TextSpan(
//                                                         text: ' Resheduled!',
//                                                         style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.orange)),
//                                                   ],
//                                                 ),
//                                               ):notificationController
//                                                   .getlist[i]!
//                                                   .message
//                                                   .contains("Rejected")
//                                                   ? Column(
//                                                 mainAxisAlignment: MainAxisAlignment.start,
//                                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                                     children: [
//                                                       // RichText(
//                                                       //   text: TextSpan(
//                                                       //     children: <TextSpan>[
//                                                       //   TextSpan(text: 'You Appointment Rejected' /*text: "Abhi ${notificationController.getlist[i]?.title ?? ""}"*/, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.black)),
//                                                       // //  TextSpan(text: ' - #${notificationController.getlist[i]!.appointmentId.toString()} is ', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400, color: Colors.black)),
//                                                       //   TextSpan(text: ' Rejected!', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.red)),
//                                                       // ],
//                                                       //   ),
//                                                       // ),
//                                                       Row(
//                                                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                                         children: [
//                                                           Text("You Appointment is Rejected ",overflow: TextOverflow.ellipsis,),
//                                                           Text("Rejected!",style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.red)),
//
//                                                         ],
//                                                       ),
//                                                       Text('Appointment. ID - #${notificationController.getlist[i]!.appointmentId.toString()} is ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.black)),
//                                                     ],
//                                                   )
//                                                   : notificationController.getlist[i]!.message.contains("Pendding")
//                                                   ? RichText(
//                                                 text: TextSpan(
//                                                   children: <TextSpan>[
//                                                     TextSpan(text: 'You Appointment is pending'/* text: "Abhi ${notificationController.getlist[i]?.title ??""}*/, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.black)),
//                                                     TextSpan(text: ' id - #${notificationController.getlist[i]!.appointmentId.toString()} is ', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400, color: Colors.black)),
//                                                     TextSpan(text: ' Pendding!', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.yellow)),
//                                                   ],
//                                                 ),
//                                               )
//                                                   : notificationController.getlist[i]!.message.contains("Revisited")
//                                                   ? RichText(
//                                                 text: TextSpan(
//                                                   children: <TextSpan>[
//                                                     TextSpan(/*text: 'Appointment. ID',*/  text: "Abhi ${notificationController.getlist[i]?.title ?? ""}", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.black)),
//                                                     TextSpan(text: ' id - #${notificationController.getlist[i]!.appointmentId.toString()} is ', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400, color: Colors.black)),
//                                                     TextSpan(text: ' Revisited!', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.orange)),
//                                                   ],
//                                                 ),
//                                               )
//                                                   : RichText(
//                                                 text: TextSpan(
//                                                   children: <TextSpan>[
//                                                     TextSpan(/*text: 'Appointment. ID',*/ text: "${notificationController.getlist[i]?.title ?? ""}", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.black)),
//                                                     TextSpan(text: ' - #${notificationController.getlist[i]!.appointmentId.toString()} is ', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400, color: Colors.black)),
//                                                     TextSpan(text: ' Visited!', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.white)),
//                                                   ],
//                                                 ),
//                                               ))),
//                                         ],
//                                       ),
//                                       Row(
//                                         crossAxisAlignment:
//                                         CrossAxisAlignment
//                                             .start,
//                                         mainAxisAlignment:
//                                         MainAxisAlignment.end,
//                                         children: [
//                                           Padding(
//                                             padding:
//                                             const EdgeInsets
//                                                 .only(
//                                                 right: 14.0,
//                                                 bottom: 2),
//                                             child: Text(
//                                               formate(
//                                                   "${notificationController.getlist[i]!.createdAt}"
//                                                       .substring(
//                                                       0, 11)),
//                                               style: TextStyle(
//                                                 fontSize: 15,
//                                                 color:
//                                                 Colors.white,
//                                                 fontWeight:
//                                                 FontWeight
//                                                     .w600,
//                                               ),
//                                             ),
//                                           ),
//                                         ],
//                                       )
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           );
//                         },
//                         itemCount:
//                         notificationController.getlist.length,
//                       ),
//                     ),
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ),
//       )),
//     );
//   }
//
//   void backToHome(BuildContext context) {
//     Navigator.pushReplacement(
//         context, MaterialPageRoute(builder: (context) => MyHomePage()));
//   }
// }
//
// class NotificationClassItem {
//   String post_id;
//   String title;
//   String created;
//   String notification;
//
//   NotificationClassItem(
//       {required this.post_id,
//         required this.title,
//         required this.created,
//         required this.notification});
// }

  /// currect code
// import 'dart:convert';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bounceable/flutter_bounceable.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:flutter_html/flutter_html.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
// import 'package:dentocoreauth/models/prescription_dto.dart';
// import 'package:dentocoreauth/pages/homepage/MyHomePage.dart';
// import 'package:dentocoreauth/utils/app_constant.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
// import '../../Utills/Utills.dart';
// import '../../controllers/notification_controller.dart';
// import '../../controllers/user_controller.dart';
//
// import 'package:dentocoreauth/pages/prescription/prescription.dart' as myprescription;
//
// import '../../utils/component_screen.dart';
// import '../prescription/prescription.dart';
// import 'notification_details.dart';
//
// class MyNotification extends StatefulWidget {
//   const MyNotification({Key? key}) : super(key: key);
//
//   @override
//   State<MyNotification> createState() => _NotificationState();
// }
//
// class _NotificationState extends State<MyNotification> {
//   _NotificationState() {}
//   final NotificationController notificationController = Get.find();
//   final UserController userController = Get.find();
//
//   var util = Utills();
//   var notification_list = [];
//   var postid = "";
//   var allPostList = [];
//   var tempPostList = [];
//   var userid = "";
//   var user_data = [];
//   var isLoading = false;
//
//   var load_status = false;
//
//   String formate(String time) {
//     var cdata = time.toString().substring(0, 10);
//     var now = DateTime.now();
//     var today = DateFormat('yyyy-MM-dd').format(now);
//
//     final _today = today.replaceAll(RegExp('-'), '').trim();
//     final _pdate = cdata.replaceAll(RegExp('-'), '').trim();
//     var myIntToday = int.parse(_today);
//     var myIntPdate = int.parse(_pdate);
//     if (myIntToday - 1 == myIntPdate) {
//       return "Yesterday";
//     }
//     if (today.trim() == cdata.trim()) {
//       return "Today";
//     } else {
//       return cdata.trim().toString();
//     }
//   }
//
//   void getUserData(key) async {
//     final sp = await SharedPreferences.getInstance();
//     setState(() {
//       user_data = sp.getStringList(key)!;
//       load_status = true;
//       userid = user_data[0].toString();
//       userController.getAppointmentlist(userid).then(
//               (value) => {util.stopLoading(), userController.getlist.refresh()});
//
//       notificationController.getNotifications(userid).then((value) => setState(() {
//         util.stopLoading();
//         notificationController.getlist.refresh();
//         debugPrint("njdata" + value!.body[0].id.toString());
//       }));
//       if (EasyLoading.isShow) {
//         EasyLoading.dismiss();
//       }
//     });
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//     notificationController.dispose();
//     if (EasyLoading.isShow) {
//       EasyLoading.dismiss();
//     }
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     getUserData("user_data");
//     print("Abhi:- print get notification : ${notificationController.getlist[0]?.title}");
//     Future.delayed(Duration(milliseconds: 2000), () {
//       notificationController.setDot(false);
//       if (EasyLoading.isShow) {
//         EasyLoading.dismiss();
//       }
//     });
//   }
//
//   doFormating(String status) {
//     switch (status) {
//       case "0":
//         {}
//         break;
//       case "1":
//         {}
//         break;
//       case "2":
//         {}
//         break;
//       case "3":
//         {
//           return RichText(
//             text: TextSpan(
//               text: 'Hello ',
//               children: <TextSpan>[
//                 TextSpan(text: 'bold', style: TextStyle(fontWeight: FontWeight.bold)),
//                 TextSpan(text: ' world!'),
//               ],
//             ),
//           );
//         }
//         break;
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Obx(() => SafeArea(
//           child: notificationController.isloading.value == true
//               ? Center(child: CircularProgressIndicator())
//               : notificationController.getlist.length == 0
//               ? Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Image.asset("assets/newImages/notificationIcon.png", scale: 2),
//                 SizedBox(height: 12),
//                 Text(
//                   "No notifications found!",
//                   style: TextStyle(
//                       color: Colors.black, fontWeight: FontWeight.w600),
//                 ),
//                 SizedBox(height: 10),
//                 MaterialButton(
//                   onPressed: () {
//                     Get.back();
//                   },
//                   child: Container(
//                     width: 100,
//                     height: 40,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(30),
//                       border: Border.all(color: Colors.white),
//                       color: Colors.blue,
//                     ),
//                     child: Center(
//                       child: Text(
//                         "Back",
//                         style: TextStyle(color: Colors.white),
//                       ),
//                     ),
//                   ),
//                 )
//               ],
//             ),
//           )
//               : SingleChildScrollView(
//             child: Container(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: [
//                   CustomAppBar(title: 'Notification'),
//                   SizedBox(height: AppConstant.APP_EXTRA_LARGE_PADDING),
//                   Padding(
//                     padding: const EdgeInsets.all(10.0),
//                     child: SingleChildScrollView(
//                       child: Container(
//                         height: MediaQuery.of(context).size.height - 200,
//                         child: ListView.builder(
//                           itemCount: notificationController.getlist.length,
//                           key: UniqueKey(),
//                           physics: AlwaysScrollableScrollPhysics(),
//                           itemBuilder: (c, i) {
//                             return Center(
//                               child: Padding(
//                                 padding: const EdgeInsets.only(bottom: 8.0),
//                                 child: InkWell(
//                                   onTap: () {
//                                     Get.to(NotificationDetails(appointmentId: notificationController.getlist[i]?.appointmentId,
//                                       images: notificationController.getlist[i]?.image,
//                                     massage: notificationController.getlist[i]?.message,
//                                       titel: notificationController.getlist[i]?.title,
//                                     ));
//                                     // if (notificationController
//                                     //     .getlist[i]!.message
//                                     //     .contains("Visited") ||
//                                     //     notificationController
//                                     //         .getlist[i]!.message
//                                     //         .contains("Revisited")) {
//                                     //   userController
//                                     //       .getPrescction(
//                                     //       userController.getlist[i]!.id)
//                                     //       .then((value) => {
//                                     //     Future.delayed(
//                                     //         Duration(
//                                     //             milliseconds: 500),
//                                     //             () {
//                                     //           debugPrint("called");
//                                     //           Get.to(MyPrescription(
//                                     //               userController
//                                     //                   .getlist[i]!
//                                     //                   .appointmentImages,
//                                     //               true));
//                                     //           debugPrint("presceiptiondata" +
//                                     //               userController
//                                     //                   .getlist[0]!
//                                     //                   .appointmentImages
//                                     //                   .toString());
//                                     //         })
//                                     //   });
//                                     // } else {
//                                     //   backToHome(context);
//                                     // }
//
//                                   },
//                                   child: Container(
//                                     padding: EdgeInsets.symmetric(
//                                         vertical: 10, horizontal: 12),
//                                     margin: EdgeInsets.only(bottom: 10),
//                                     decoration: BoxDecoration(
//                                       borderRadius:
//                                       BorderRadius.circular(20),
//                                       gradient:
//                                       AppConstant.Notification_gradient,
//                                     ),
//                                     child: Column(
//                                         mainAxisAlignment:
//                                         MainAxisAlignment.center,
//                                         crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                         children: [
//                                         Row(
//                                         mainAxisAlignment:
//                                         MainAxisAlignment.start,
//                                         crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                         children: [
//                                     Padding(
//                                     padding: const EdgeInsets.only(
//                                         top: 4.0, left: 4),
//                                     child: CircleAvatar(
//                                       radius: 24,
//                                       backgroundImage: AssetImage(
//                                           'assets/images/logo_new.jpg'),
//                                       backgroundColor: Colors.white,
//                                     ),
//                                   ),
//                                   SizedBox(width: 12),
//                                   Expanded(
//                                       child: Obx(() => notificationController
//                                           .getlist[i]!
//                                           .message
//                                           .contains("Accepted")
//                                           ? Column(
//                                         crossAxisAlignment:
//                                         CrossAxisAlignment
//                                             .start,
//                                         children: [
//                                           Row(
//                                             mainAxisAlignment:
//                                             MainAxisAlignment
//                                                 .spaceBetween,
//                                             children: [
//                                               Expanded(
//                                                 child: Text(
//                                                   "You Appointment is Accepted",
//                                                   overflow: TextOverflow
//                                                       .ellipsis,
//                                                   style: TextStyle(
//                                                       fontSize: 15,
//                                                       fontWeight:
//                                                       FontWeight.w400,
//                                                       color: Colors.black),
//                                                 ),
//                                               ),
//                                               Text(
//                                                 "Accepted!",
//                                                 style: TextStyle(
//                                                     fontSize: 15,
//                                                     fontWeight:
//                                                     FontWeight.w400,
//                                                     color: Colors.green),
//                                               ),
//                                             ],
//                                           ),
//                                           Text(
//                                             'Appointmend Id - #${notificationController.getlist[i]!.appointmentId.toString()}',
//                                             style: TextStyle(
//                                                 fontSize: 15,
//                                                 fontWeight:
//                                                 FontWeight.w400,
//                                                 color: Colors.black),
//                                             overflow:
//                                             TextOverflow.ellipsis,
//                                           ),
//                                         ],
//                                       )
//                                           : notificationController
//                                           .getlist[i]!
//                                           .message
//                                           .contains("Reshedule")
//                                           ? Column(
//                                         crossAxisAlignment:
//                                         CrossAxisAlignment
//                                             .start,
//                                         children: [
//                                           Row(
//                                             mainAxisAlignment:
//                                             MainAxisAlignment
//                                                 .spaceBetween,
//                                             children: [
//                                               Expanded(
//                                                 child: Text(
//                                                   "${notificationController.getlist[i]?.title ?? ""}",
//                                                   overflow: TextOverflow
//                                                       .ellipsis,
//                                                   style: TextStyle(
//                                                       fontSize: 15,
//                                                       fontWeight:
//                                                       FontWeight
//                                                           .w400,
//                                                       color: Colors
//                                                           .black),
//                                                 ),
//                                               ),
//                                               Text(
//                                                 "Rescheduled!",
//                                                 style: TextStyle(
//                                                     fontSize: 15,
//                                                     fontWeight:
//                                                     FontWeight
//                                                         .w400,
//                                                     color: Colors
//                                                         .orange),
//                                               ),
//                                             ],
//                                           ),
//                                           Text(
//                                             'Appointmend Id - #${notificationController.getlist[i]!.appointmentId.toString()}',
//                                             style: TextStyle(
//                                                 fontSize: 15,
//                                                 fontWeight:
//                                                 FontWeight.w400,
//                                                 color: Colors.black),
//                                             overflow: TextOverflow
//                                                 .ellipsis,
//                                           ),
//                                         ],
//                                       )
//                                           : notificationController
//                                           .getlist[i]!
//                                           .message
//                                           .contains("Rejected")
//                                           ? Column(
//                                         crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                         children: [
//                                           Row(
//                                             mainAxisAlignment:
//                                             MainAxisAlignment.spaceBetween,
//                                             children: [
//                                               Expanded(
//                                                 child: Text(
//                                                   "You Appointment is Rejected",
//                                                   overflow: TextOverflow
//                                                       .ellipsis,
//                                                   style: TextStyle(
//                                                       fontSize: 15,
//                                                       fontWeight: FontWeight.w400,
//                                                       color: Colors.black),
//                                                 ),
//                                               ),
//                                               Text(
//                                                 "Rejected!",
//                                                 style: TextStyle(
//                                                     fontSize: 15,
//                                                     fontWeight: FontWeight.w400,
//                                                     color: Colors.red),
//                                               ),
//                                             ],
//                                           ),
//                                           Text(
//                                             'Appointmend Id - #${notificationController.getlist[i]!.appointmentId.toString()}',
//                                             style: TextStyle(
//                                                 fontSize: 15,
//                                                 fontWeight: FontWeight.w400,
//                                                 color: Colors.black),
//                                             overflow: TextOverflow.ellipsis,
//                                           ),
//                                         ],
//                                       )
//                                           : notificationController
//                                           .getlist[i]!
//                                           .message
//                                           .contains("Pendding")
//                                           ? Column(
//                                         crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                         children: [
//                                           Row(
//                                             mainAxisAlignment:
//                                             MainAxisAlignment.spaceBetween,
//                                             children: [
//                                               Expanded(
//                                                 child: Text(
//                                                   "You Appointment is Pending",
//                                                   overflow: TextOverflow
//                                                       .ellipsis,
//                                                   style: TextStyle(
//                                                       fontSize: 15,
//                                                       fontWeight:
//                                                       FontWeight.w400,
//                                                       color: Colors.black),
//                                                 ),
//                                               ),
//                                               Text(
//                                                 "Pending!",
//                                                 style: TextStyle(
//                                                     fontSize: 15,
//                                                     fontWeight:
//                                                     FontWeight.w400,
//                                                     color: Colors.yellow),
//                                                 overflow: TextOverflow
//                                                     .ellipsis,
//                                               ),
//                                             ],
//                                           ),
//                                           Text(
//                                             'Appointmend Id - #${notificationController.getlist[i]!.appointmentId.toString()}',
//                                             style: TextStyle(
//                                                 fontSize: 15,
//                                                 fontWeight: FontWeight.w400,
//                                                 color: Colors.black),
//                                             overflow: TextOverflow
//                                                 .ellipsis,
//                                           ),
//                                         ],
//                                       )
//                                           : notificationController
//                                           .getlist[i]!
//                                           .message
//                                           .contains("Revisited")
//                                           ? Column(
//                                         crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                         children: [
//                                           Row(
//                                             mainAxisAlignment:
//                                             MainAxisAlignment.spaceBetween,
//                                             children: [
//                                               Expanded(
//                                                 child: Text(
//                                                   "${notificationController.getlist[i]?.title ?? ""}",
//                                                   overflow: TextOverflow
//                                                       .ellipsis,
//                                                   style: TextStyle(
//                                                       fontSize: 15,
//                                                       fontWeight: FontWeight.w400,
//                                                       color: Colors.black),
//                                                 ),
//                                               ),
//                                               Text(
//                                                 "Revisited!",
//                                                 style: TextStyle(
//                                                     fontSize: 15,
//                                                     fontWeight: FontWeight.w400,
//                                                     color: Colors.orange),
//                                                 overflow: TextOverflow
//                                                     .ellipsis,
//                                               ),
//                                             ],
//                                           ),
//                                           Text(
//                                             'Appointmend Id - #${notificationController.getlist[i]!.appointmentId.toString()}',
//                                             style: TextStyle(
//                                                 fontSize: 15,
//                                                 fontWeight: FontWeight.w400,
//                                                 color: Colors.black),
//                                             overflow: TextOverflow.ellipsis,
//                                           ),
//                                         ],
//                                       )
//                                           : Column(
//                                         crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                         children: [
//                                           Row(
//                                             mainAxisAlignment:
//                                             MainAxisAlignment.spaceBetween,
//                                             children: [
//                                               Expanded(
//                                                 child: Text(
//                                                   "${notificationController.getlist[i]?.title ?? ""}",
//                                                   overflow: TextOverflow
//                                                       .ellipsis,
//                                                   style: TextStyle(
//                                                       fontSize: 15,
//                                                       fontWeight: FontWeight.w400,
//                                                       color: Colors.black),
//                                                 ),
//                                               ),
//                                               Text(
//                                                 "Visited!",
//                                                 style: TextStyle(
//                                                     fontSize: 15,
//                                                     fontWeight: FontWeight.w400,
//                                                     color: Colors.white),
//                                                 overflow: TextOverflow
//                                                     .ellipsis,
//                                               ),
//                                             ],
//                                           ),
//                                           Text(
//                                             'Appointmend Id  - #${notificationController.getlist[i]!.appointmentId.toString()}',
//                                             style: TextStyle(
//                                                 fontSize: 15,
//                                                 fontWeight: FontWeight.w400,
//                                                 color: Colors.black),
//                                             overflow: TextOverflow.ellipsis,
//                                           ),
//                                         ],
//                                       ))),
//                                // ),
//                                 ],
//                               ),
//                               Row(
//                                 crossAxisAlignment:
//                                 CrossAxisAlignment.start,
//                                 mainAxisAlignment:
//                                 MainAxisAlignment.end,
//                                 children: [
//                                   Padding(
//                                     padding: const EdgeInsets.only(
//                                         right: 14.0, bottom: 2),
//                                     child: Text(
//                                       formate(
//                                           "${notificationController.getlist[i]!.createdAt}"
//                                               .substring(0, 11)),
//                                       style: TextStyle(
//                                         fontSize: 14,
//                                         color: Colors.white,
//                                         fontWeight: FontWeight.w600,
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               ],
//                             ),
//                             ),
//                             ),
//                             ),
//                             );
//                           },
//
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           )),
//       ),
//     );
//   }
//
//   void backToHome(BuildContext context) {
//     Navigator.pushReplacement(
//         context, MaterialPageRoute(builder: (context) => MyHomePage()));
//   }
// }
///

import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:dentocoreauth/models/prescription_dto.dart';
import 'package:dentocoreauth/pages/homepage/MyHomePage.dart';
import 'package:dentocoreauth/utils/app_constant.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../Utills/Utills.dart';
import '../../controllers/notification_controller.dart';
import '../../controllers/user_controller.dart';

import 'package:dentocoreauth/pages/prescription/prescription.dart' as myprescription;

import '../../utils/component_screen.dart';
import '../prescription/prescription.dart';
import 'notification_details.dart';

class MyNotification extends StatefulWidget {
  const MyNotification({Key? key}) : super(key: key);

  @override
  State<MyNotification> createState() => _NotificationState();
}

class _NotificationState extends State<MyNotification> {
  _NotificationState() {}
  final NotificationController notificationController = Get.find();
  final UserController userController = Get.find();

  var util = Utills();
  var notification_list = [];
  var postid = "";
  var allPostList = [];
  var tempPostList = [];
  var userid = "";
  var user_data = [];
  var isLoading = false;

  var load_status = false;

  String formate(String time) {
    var cdata = time.toString().substring(0, 10);
    var now = DateTime.now();
    var today = DateFormat('yyyy-MM-dd').format(now);

    final _today = today.replaceAll(RegExp('-'), '').trim();
    final _pdate = cdata.replaceAll(RegExp('-'), '').trim();
    var myIntToday = int.parse(_today);
    var myIntPdate = int.parse(_pdate);
    if (myIntToday - 1 == myIntPdate) {
      return "Yesterday";
    }
    if (today.trim() == cdata.trim()) {
      return "Today";
    } else {
      return cdata.trim().toString();
    }
  }

  void getUserData(key) async {
    final sp = await SharedPreferences.getInstance();
    setState(() {
      user_data = sp.getStringList(key)!;
      load_status = true;
      userid = user_data[0].toString();
      userController.getAppointmentlist(userid).then(
              (value) => {util.stopLoading(), userController.getlist.refresh()});

      notificationController.getNotifications(userid).then((value) => setState(() {
        util.stopLoading();
        notificationController.getlist.refresh();
        debugPrint("njdata" + value!.body[0].id.toString());
      }));
      if (EasyLoading.isShow) {
        EasyLoading.dismiss();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    notificationController.dispose();
    if (EasyLoading.isShow) {
      EasyLoading.dismiss();
    }
  }

  @override
  void initState() {
    super.initState();
    getUserData("user_data");
    print("Abhi:- print get notification : ${notificationController.getlist[0]?.title}");
    Future.delayed(Duration(milliseconds: 2000), () {
      notificationController.setDot(false);
      if (EasyLoading.isShow) {
        EasyLoading.dismiss();
      }
    });
  }

  doFormating(String status) {
    switch (status) {
      case "0":
        {}
        break;
      case "1":
        {}
        break;
      case "2":
        {}
        break;
      case "3":
        {
          return RichText(
            text: TextSpan(
              text: 'Hello ',
              children: <TextSpan>[
                TextSpan(text: 'bold', style: TextStyle(fontWeight: FontWeight.bold)),
                TextSpan(text: ' world!'),
              ],
            ),
          );
        }
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => SafeArea(
          child: notificationController.isloading.value == true
              ? Center(child: CircularProgressIndicator())
              : notificationController.getlist.length == 0
              ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/newImages/notificationIcon.png", scale: 2),
                // Image.asset("assets/newImages/notificationIcon.png", scale: 2),
                SizedBox(height: 12),
                Text(
                  "No notifications found!",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 10),
                MaterialButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: Container(
                    width: 100,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: Colors.white),
                      color: Colors.blue,
                    ),
                    child: Center(
                      child: Text(
                        "Back",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
              : SingleChildScrollView(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CustomAppBar(title: 'Notification'),
                  SizedBox(height: AppConstant.APP_EXTRA_LARGE_PADDING),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: SingleChildScrollView(
                      child: Container(
                        height: MediaQuery.of(context).size.height - 200,
                        child: ListView.builder(
                          itemCount: notificationController.getlist.length,
                          key: UniqueKey(),
                          physics: AlwaysScrollableScrollPhysics(),
                          itemBuilder: (c, i) {
                            return Center(
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: InkWell(
                                  onTap: () {
                                    if (
                                    notificationController
                                        .getlist[i]!.message
                                        .contains("Visited") ||
                                        notificationController
                                            .getlist[i]!.message
                                            .contains("Revisited")) {
                                      userController
                                          .getPrescction(
                                          userController.getlist[i]!.id)
                                          .then((value) => {
                                        Future.delayed(
                                            Duration(
                                                milliseconds: 500),
                                                () {
                                              debugPrint("called");
                                              // Get.to(MyPrescription(
                                              //     userController
                                              //         .getlist[i]!
                                              //         .appointmentImages,
                                              //     true));
                                              debugPrint("presceiptiondata" +
                                                  userController
                                                      .getlist[0]!
                                                      .appointmentImages
                                                      .toString());
                                            })
                                      }
                                      );
                                    } else if (notificationController.getlist[i]?.title?.isNotEmpty ?? false) {
                                      Get.to(NotificationDetails(
                                        appointmentId: notificationController.getlist[i]?.appointmentId,
                                        images: notificationController.getlist[i]?.image,
                                        massage: notificationController.getlist[i]?.message,
                                        titel: notificationController.getlist[i]?.title,
                                      ));
                                    } else {
                                      backToHome(context);
                                    }
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 12),
                                    margin: EdgeInsets.only(bottom: 10),
                                    decoration: BoxDecoration(
                                      borderRadius:
                                      BorderRadius.circular(20),
                                      gradient:
                                      AppConstant.Notification_gradient,
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.start,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 4.0, left: 4),
                                              child: CircleAvatar(
                                                radius: 24,
                                                backgroundImage: AssetImage(
                                                    // 'assets/images/logo_new.jpg'
                                                    'assets/newImages/appiconlogos.png'
                                                ),
                                                backgroundColor: Colors.white,
                                              ),
                                            ),
                                            SizedBox(width: 12),
                                            Expanded(
                                                child: Obx(() => notificationController
                                                    .getlist[i]!
                                                    .message
                                                    .contains("Accepted")
                                                    ? Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment
                                                      .start,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                      children: [
                                                        Expanded(
                                                          child: Text(
                                                            "You Appointment is Accepted",
                                                            overflow: TextOverflow
                                                                .ellipsis,
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                FontWeight.w400,
                                                                color: Colors.black),
                                                          ),
                                                        ),
                                                        Text(
                                                          "Accepted!",
                                                          style: TextStyle(
                                                              fontSize: 15,
                                                              fontWeight:
                                                              FontWeight.w400,
                                                              color: Colors.green),
                                                        ),
                                                      ],
                                                    ),
                                                    Text(
                                                      'Appointmend Id - #${notificationController.getlist[i]!.appointmentId.toString()}',
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          fontWeight:
                                                          FontWeight.w400,
                                                          color: Colors.black),
                                                      overflow:
                                                      TextOverflow.ellipsis,
                                                    ),
                                                  ],
                                                )
                                                    : notificationController
                                                    .getlist[i]!
                                                    .message
                                                    // .contains("Reshedule")
                                                    .contains("Rescheduled")
                                                    ? Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment
                                                      .start,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                      children: [
                                                        Expanded(
                                                          child: Text(
                                                            "${notificationController.getlist[i]?.title ?? ""}",
                                                            overflow: TextOverflow
                                                                .ellipsis,
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                FontWeight
                                                                    .w400,
                                                                color: Colors
                                                                    .black),
                                                          ),
                                                        ),
                                                        Text(
                                                          "Rescheduled!",
                                                          style: TextStyle(
                                                              fontSize: 15,
                                                              fontWeight:
                                                              FontWeight
                                                                  .w400,
                                                              color: Colors
                                                                  .blueAccent),
                                                        ),
                                                      ],
                                                    ),
                                                    Text(
                                                      // 'Appointmend Id - #${notificationController.getlist[i]!.appointmentId.toString()}',
                                                      '${notificationController.getlist[i]?.message ?? ""}',
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          fontWeight:
                                                          FontWeight.w400,
                                                          color: Colors.black),
                                                      overflow: TextOverflow
                                                          .ellipsis,
                                                    ),
                                                  ],
                                                )
                                                    : notificationController
                                                    .getlist[i]!
                                                    .message
                                                    .contains("Rejected")
                                                    ? Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Expanded(
                                                          child: Text(
                                                            "You Appointment is Rejected",
                                                            overflow: TextOverflow
                                                                .ellipsis,
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight: FontWeight.w400,
                                                                color: Colors.black),
                                                          ),
                                                        ),
                                                        Text(
                                                          "Rejected!",
                                                          style: TextStyle(
                                                              fontSize: 15,
                                                              fontWeight: FontWeight.w400,
                                                              color: Colors.red),
                                                        ),
                                                      ],
                                                    ),
                                                    Text(
                                                      'Appointmend Id - #${notificationController.getlist[i]!.appointmentId.toString()}',
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          fontWeight: FontWeight.w400,
                                                          color: Colors.black),
                                                      overflow: TextOverflow.ellipsis,
                                                    ),
                                                  ],
                                                )
                                                    : notificationController
                                                    .getlist[i]!
                                                    .message
                                                    .contains("Pendding")
                                                    ? Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Expanded(
                                                          child: Text(
                                                            "You Appointment is Pending",
                                                            overflow: TextOverflow
                                                                .ellipsis,
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                FontWeight.w400,
                                                                color: Colors.black),
                                                          ),
                                                        ),
                                                        Text(
                                                          "Pending!",
                                                          style: TextStyle(
                                                              fontSize: 15,
                                                              fontWeight:
                                                              FontWeight.w400,
                                                              color: Colors.yellow),
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                      ],
                                                    ),
                                                    Text(
                                                      'Appointmend Id - #${notificationController.getlist[i]!.appointmentId.toString()}',
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          fontWeight: FontWeight.w400,
                                                          color: Colors.black),
                                                      overflow: TextOverflow
                                                          .ellipsis,
                                                    ),
                                                  ],
                                                )
                                                    : notificationController
                                                    .getlist[i]!
                                                    .message
                                                    .contains("Revisited")
                                                    ? Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Expanded(
                                                          child: Text(
                                                            "${notificationController.getlist[i]?.title ?? ""}",
                                                            overflow: TextOverflow
                                                                .ellipsis,
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight: FontWeight.w400,
                                                                color: Colors.black),
                                                          ),
                                                        ),
                                                        Text(
                                                          "Revisited!",
                                                          style: TextStyle(
                                                              fontSize: 15,
                                                              fontWeight: FontWeight.w400,
                                                              color: Colors.orange),
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                      ],
                                                    ),
                                                    Text(
                                                      // 'Appointmend Id - #${notificationController.getlist[i]!.appointmentId.toString()}',
                                                      '${notificationController.getlist[i]?.message ?? ""}',
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          fontWeight: FontWeight.w400,
                                                          color: Colors.black),
                                                      overflow: TextOverflow.ellipsis,
                                                    ),
                                                  ],
                                                )
                                                    : Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Expanded(
                                                          child: Text(
                                                            "${notificationController.getlist[i]?.title ?? ""}",
                                                            overflow: TextOverflow
                                                                .ellipsis,
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight: FontWeight.w400,
                                                                color: Colors.black),
                                                          ),
                                                        ),
                                                     notificationController
                                                .getlist[i]!
                                                .message
                                                .contains("Visited")
                                                ?   Text(
                                                          "Visited!",
                                                          style: TextStyle(
                                                              fontSize: 15,
                                                              fontWeight: FontWeight.w400,
                                                              color: Colors.white),
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ) : SizedBox(),
                                                      ],
                                                    ),
                                                    Text(
                                                      // 'Appointmend Id  - #${notificationController.getlist[i]!.appointmentId.toString()}',
                                                      '${notificationController.getlist[i]?.message ?? ""}',
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          fontWeight: FontWeight.w400,
                                                          color: Colors.black),
                                                      overflow: TextOverflow.ellipsis,
                                                    ),
                                                  ],
                                                ))),
                                            // ),
                                          ],
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                          MainAxisAlignment.end,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 14.0, bottom: 2),
                                              child: Text(
                                                formate(
                                                    "${notificationController.getlist[i]!.createdAt}"
                                                        .substring(0, 11)),
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },

                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )),
      ),
    );
  }

  void backToHome(BuildContext context) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => MyHomePage()));
  }
}