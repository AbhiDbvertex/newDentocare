//
// import 'dart:async';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:get/get.dart';
// import 'package:get/get_navigation/get_navigation.dart';
// import 'package:dentocoreauth/Utills/Utills.dart';
// import 'package:dentocoreauth/controllers/notification_controller.dart';
// import 'package:dentocoreauth/controllers/profile_controller.dart';
// import 'package:dentocoreauth/controllers/user_controller.dart';
// import 'package:dentocoreauth/pages/notification/notification.dart';
// import 'package:dentocoreauth/utils/GetXNetworkManager.dart';
// import 'package:dentocoreauth/utils/mycolor.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:url_launcher/url_launcher.dart';
// import '../../models/appointment_response.dart';
// import '../../utils/app_constant.dart';
// import '../Services/Services.dart';
// import '../appointment_list/appointment_list.dart';
// import '../book_appointment/book_appointment.dart';
// import '../contact_us/contact_us.dart';
// import '../payment/payment.dart';
// import '../payment_history/payment_history.dart';
// import '../reached_location/reached_location.dart';
// import '../setting/settings.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart' as myloader;
//
// import '../video/video.dart';
//
// class Dashboard extends StatefulWidget {
//   const Dashboard({Key? key}) : super(key: key);
//
//   @override
//   State<Dashboard> createState() => _DashboardState();
// }
//
// class _DashboardState extends State<Dashboard> {
//   var user_data = [];
//   var load_status = false;
//   var userid = "";
//   var user_name = "";
//   var show_menu = false;
//   var util = Utills();
//   final NotificationController _notificationController = Get.find();
//   var isNewNotification = false;
//   Timer? timer;
//   String? isFirst;
//
//   final statusMaps = {
//     "0": "Pending",
//     "1": "Rejected",
//     "2": "Visited",
//     "3": "Accepted",
//     "4": "Revisited",
//     "5": "Rescheduled",
//     "6": "Pending",
//   };
//   final _networkManager = Get.find<GetXNetworkManager>();
//   final UserController userController = Get.find();
//   final ProfileController profileController = Get.find();
//   final NotificationController notificationController = Get.find();
//   var listOfGradinetColor = [
//     AppConstant.paitent_1_bg,
//     AppConstant.paitent_2_bg,
//     AppConstant.paitent_3_bg,
//     AppConstant.paitent_4_bg,
//     AppConstant.paitent_5_bg,
//   ];
//
//   final listOfStatus = [
//     "Pending",
//     "Rejected",
//     "Visited",
//     "Accepted",
//     "Revisited",
//     "Rescheduled",
//     "Pending",
//   ];
//
//   getNotifty() {
//     Get.defaultDialog(
//         radius: 20,
//         contentPadding: EdgeInsets.all(20),
//         title: "Alert",
//         content: Container(
//           width: MediaQuery.of(context).size.width,
//           height: 100,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Center(
//                 child: Text("content"),
//               ),
//               SizedBox(height: 10),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   MaterialButton(
//                     onPressed: () {
//                       Get.back();
//                     },
//                     child: Text("Cancel"),
//                     color: Colors.red,
//                   ),
//                   SizedBox(
//                     width: 10,
//                   ),
//                   MaterialButton(
//                     onPressed: () {
//                       Get.back();
//                     },
//                     child: Text("Ok"),
//                     color: Colors.red,
//                   ),
//                 ],
//               )
//             ],
//           ),
//         ));
//   }
//
//   Future<String> apiCallLogic() async {
//     //print("Api Called ${++counter} time(s)");
//     await userController
//         .getAppointmentlist(userid)
//         .then((value) => userController.getlist.refresh());
//     return Future.value("Hello World");
//   }
//   int _current = 0;
//   final CarouselSliderController _controller = CarouselSliderController();
//   void getUserData(key) async {
//     final sp = await SharedPreferences.getInstance();
//     setState(() {
//       debugPrint("dashboardcalled");
//       user_data = sp.getStringList(key)!;
//       load_status = true;
//       userid = user_data[0].toString();
//       user_name = user_data[1].toString();
//       // util.showSnackBar("Alert", userid, true);
//       if (userid.isNotEmpty) {
//         userController
//             .getAppointmentlist(userid)
//             .then((value) => userController.getlist.refresh());
//         setState(() {
//           notificationController
//               .getNotifications(userid)
//               .then((value) => notificationController.getlist.refresh());
//         });
//
//         profileController
//             .getProfile(userid)
//             .then((value) => profileController.image.value = value!.body.image);
//       }
//       checkStatus();
//     });
//   }
//
//   checkStatus() {
//     if (timer != null) {
//       if (timer!.isActive) {
//         timer!.cancel();
//       }
//     }
//     timer = new Timer.periodic(Duration(seconds: 2), (timer) {
//       userController.getChatStatus(userid).then((value) => {
//         debugPrint("apicalled"),
//       });
//     });
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//     timer!.cancel();
//
//     if (EasyLoading.isShow) {
//       EasyLoading.dismiss();
//     }
//   }
//
//   void _pickFile() async {
//     // opens storage to pick files and the picked file or files
//     // are assigned into result and if no file is chosen result is null.
//     // you can also toggle "allowMultiple" true or false depending on your need
//     final result = await FilePicker.platform.pickFiles(allowMultiple: false);
//
//     // if no file is picked
//     if (result == null) return;
//
//     // we will log the name, size and path of the
//     // first picked file (if multiple are selected)
//     print(result.files.first.name);
//     print(result.files.first.size);
//     print(result.files.first.path);
//   }
//
//   Dialog resheduledDialog(BuildContext context, String appointment_id,
//       AppointmentBody? appointmentBody) {
//     return Dialog(
//       shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(12.0)), //this right here
//       child: Container(
//         child: FittedBox(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               Padding(
//                 padding: EdgeInsets.all(12.0),
//                 child: Text(
//                   'Reschedule',
//                   style: TextStyle(
//                       color: Colors.red,
//                       fontWeight: FontWeight.w700,
//                       fontSize: 18),
//                 ),
//               ),
//               Padding(
//                 padding: EdgeInsets.all(12.0),
//                 child: Text(
//                   'Appointment has been rescheduled.\nNew date : ${appointmentBody!.date.toString().substring(0, 10)}\nNew time : ${appointmentBody!.timeSlotData.timeSlot}',
//                   style: TextStyle(color: Colors.black, fontSize: 14),
//                 ),
//               ),
//
//               Padding(
//                 padding: EdgeInsets.only(top: 12.0),
//                 child: Text(
//                   'Do you agree?',
//                   style: TextStyle(color: Colors.black, fontSize: 14),
//                 ),
//               ),
//               // Are you agree?
//               Padding(padding: EdgeInsets.only(top: 10.0)),
//               TextButton(
//                   onPressed: () {
//                     // Navigator.of(context).pop();
//                   },
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       MaterialButton(
//                         onPressed: () {
//                           Navigator.of(context).pop();
//                           debugPrint("Rescheduled" + "${appointment_id}");
//                           userController.UpdateRescheduled(appointment_id, "1")
//                               .then((value) => {
//                             debugPrint("njtest" + "called"),
//                             setState(() {
//                               userController
//                                   .getAppointmentlist(userid)
//                                   .then((value) => {
//                                 userController.getlist
//                                     .refresh(),
//                                 userController.update(),
//                               });
//                             }),
//                             setState(() {
//                               userController
//                                   .getAppointmentlist(userid)
//                                   .then((value) => {
//                                 userController.getlist
//                                     .refresh(),
//                                 userController.update(),
//                               });
//                             }),
//                           });
//                         },
//                         child: Text(
//                           "Confirm",
//                           style: TextStyle(color: Colors.white),
//                         ),
//                         color: Colors.blue,
//                       ),
//                       SizedBox(
//                         width: 10,
//                       ),
//                       MaterialButton(
//                         onPressed: () {
//                           Navigator.of(context).pop();
//                           debugPrint("resheduled" + "${appointment_id}");
//                           userController.UpdateRescheduled(appointment_id, "0")
//                               .then((value) => {
//                             debugPrint("njtest" + "called"),
//                             setState(() {
//                               userController
//                                   .getAppointmentlist(userid)
//                                   .then((value) => {
//                                 userController.getlist
//                                     .refresh(),
//                                 userController.update(),
//                               });
//                             }),
//                             setState(() {
//                               userController
//                                   .getAppointmentlist(userid)
//                                   .then((value) => {
//                                 userController.getlist
//                                     .refresh(),
//                                 userController.update(),
//                               });
//                             }),
//                           });
//                         },
//                         child: Text(
//                           "Cancel",
//                           style: TextStyle(color: Colors.white),
//                         ),
//                         color: Colors.blue,
//                       ),
//                     ],
//                   ))
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Dialog errorDialog(BuildContext context) {
//     final height = MediaQuery.of(context).size.height;
//     final width = MediaQuery.of(context).size.width;
//     return Dialog(
//         shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(12.0)), //this right here
//         child: Container(
//           height: 466.0,
//           width: 320.0,
//           decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: <Widget>[
//               Stack(
//                 children :[ Container(
//                   height: 65,
//                   width: MediaQuery.of(context).size.width,
//                   decoration: BoxDecoration(
//                       borderRadius: BorderRadius.only(
//                           topLeft: Radius.circular(13),
//                           topRight: Radius.circular(13)),
//                       gradient: LinearGradient(
//                         begin: Alignment.centerLeft,
//                         end: Alignment.centerRight,
//                         colors: [Color(0xff97e0f7), Color(0xff97a1dd)],
//                       )),
//                   child:/* Row(
//                     // mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     children: [
//                       Center(
//                         child: Text(
//                           'Tips',
//                           style: TextStyle(
//                               color: Colors.white,
//                               fontWeight: FontWeight.w700,
//                               fontSize: 18),
//                         ),
//                       ),
//                       Align(
//                           alignment: Alignment.centerRight,
//                           child: Icon(Icons.close_rounded))
//                     ],
//                   ),*/
//                   Row(
//                     children: [
//                       Expanded(
//                         child: Center(
//                           child: Text(
//                             'Tips',
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontWeight: FontWeight.w700,
//                               fontSize: 18,
//                             ),
//                           ),
//                         ),
//                       ),
//                       InkWell(
//                         onTap: (){
//                           Get.back();
//                         },
//                         child: Align(
//                           alignment: Alignment.topRight,
//                           child: Icon(Icons.close_rounded,size: 28,),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 ],
//               ),
//               Padding(
//                 padding: EdgeInsets.all(12.0),
//                 child: FittedBox(
//                   child: Text(
//                       "${userController.gettitle ?? "Brush your teeth properly"}",
//                       style: TextStyle(
//                         fontSize: 20,
//                         color: Color.fromRGBO(0, 0, 0, 1),
//                         fontWeight: FontWeight.w400,
//                       )),
//                 ),
//               ),
//               Obx(
//                     () => Container(
//                   margin: EdgeInsets.symmetric(horizontal: 16),
//                   height: height*0.40 /*256*/,
//                   width: width*0.9,
//                   decoration: BoxDecoration(
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.grey,
//                         offset: const Offset(
//                           5.0,
//                           5.0,
//                         ),
//                         blurRadius: 10.0,
//                         spreadRadius: 2.0,
//                       ), //BoxShadow
//                       BoxShadow(
//                         color: Colors.white,
//                         offset: const Offset(0.0, 0.0),
//                         blurRadius: 0.0,
//                         spreadRadius: 0.0,
//                       ), //
//                       // BoxShadow
//                     ],
//                     image: DecorationImage(
//                         fit: BoxFit.fill,
//                         image: NetworkImage(userController.getimage.value)),
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                 ),
//                 /*Obx(() {
//                   return userController.getimage.value.isNotEmpty
//                       ? CachedNetworkImage(
//                     imageUrl: userController.getimage.value,
//                     height: height * 0.23,
//                     // width: double.infinity,
//                     fit: BoxFit.fill,
//                     placeholder: (context, url) => Container(
//                         height: height * 0.23,
//                         child: Center(child: CircularProgressIndicator())),
//                     errorWidget: (context, url, error) => Container(
//                         height: height * 0.23, child: Icon(Icons.error)),
//                   )
//                       : Container(
//                     height: height * 0.23,
//                     width: double.infinity,
//                     color: Colors.grey[300],
//                     child: Icon(Icons.broken_image, size: 40, color: Colors.grey),
//                   );
//                 }),*/
//               ),
//               // Padding(padding: EdgeInsets.only(top: 20.0)),
//               // TextButton(
//               //     onPressed: () {
//               //       Navigator.of(context).pop();
//               //     },
//               //     child: Row(
//               //       mainAxisAlignment: MainAxisAlignment.center,
//               //       children: [
//               //         InkWell(
//               //           onTap: () {
//               //             Get.back();
//               //           },
//               //           child: Container(
//               //             width: 58,
//               //             height: 29,
//               //             decoration: BoxDecoration(
//               //                 borderRadius: BorderRadius.circular(30),
//               //                 gradient: LinearGradient(
//               //                   begin: Alignment.centerLeft,
//               //                   end: Alignment.centerRight,
//               //                   colors: [Color(0xff97e8fa), Color(0xff9786d2)],
//               //                 )),
//               //             child: Center(
//               //               child: Text("OK",
//               //                   style: TextStyle(
//               //                     color: Colors.white,
//               //                     fontSize: 15,
//               //                     fontWeight: FontWeight.w600,
//               //                   )),
//               //             ),
//               //           ),
//               //         ),
//               //         SizedBox(
//               //           width: 10,
//               //         ),
//               //       ],
//               //     ))
//             ],
//           ),
//         ));
//   }
//
//   getBanner() {}
//
//   @override
//   void initState() {
//     super.initState();
//
//     getUserData("user_data");
//     userController.getHomeBanner();
//     userController.getBanner().then((value) => {
//       debugPrint("njdebug" + value!.body!.image.toString()),
//       isFirst = AppConstant.getString("isFirst"),
//       if (isFirst == "yes")
//         {
//           AppConstant.save_data("isFirst", "no"),
//           showDialog(
//               context: context,
//               builder: (BuildContext context) => errorDialog(context)),
//         }
//     });
//
//     Future.delayed(Duration(milliseconds: 1000), () {
//       if (myloader.EasyLoading.isShow) {
//         myloader.EasyLoading.dismiss();
//       }
//     });
//   }
//
//   Dialog changePassDialog(BuildContext context) {
//     return Dialog(
//         shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(12.0)), //this right here
//         child: Container(
//           height: 200.0,
//           width: 200.0,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: <Widget>[
//               Padding(
//                 padding: EdgeInsets.all(12.0),
//                 child: Text(
//                   'Exit',
//                   style: TextStyle(
//                       color: Colors.black,
//                       fontWeight: FontWeight.w700,
//                       fontSize: 18),
//                 ),
//               ),
//               Padding(
//                 padding: EdgeInsets.all(12.0),
//                 child: Center(
//                   child: Text(
//                     'D?',
//                     style: TextStyle(color: Colors.black, fontSize: 14),
//                   ),
//                 ),
//               ),
//               Padding(padding: EdgeInsets.only(top: 20.0)),
//               TextButton(
//                   onPressed: () {
//                     Navigator.of(context).pop();
//                   },
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       MaterialButton(
//                         onPressed: () {
//                           Navigator.of(context).pop();
//                         },
//                         child: Text("Ok"),
//                         color: Colors.blue,
//                       ),
//                       SizedBox(
//                         width: 10,
//                       ),
//                       MaterialButton(
//                         onPressed: () {
//                           Get.back();
//                         },
//                         child: Text("Cancel"),
//                         color: Colors.blue,
//                       ),
//                     ],
//                   ))
//             ],
//           ),
//         ));
//   }
//
//   Future<SnackBar> askBack() async {
//     return await util.showSnackBar("Alert", "double click to exit!", false);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final height = MediaQuery.of(context).size.height;
//     final width = MediaQuery.of(context).size.width;
//     return GetBuilder<GetXNetworkManager>(builder: (builder) {
//       if (_networkManager.connectionType == 0)
//         return Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Image.asset("assets/images/noint.jpeg"),
//               SizedBox(
//                 height: 10,
//               ),
//               Text(
//                 "No Active Network Found!!",
//                 style: TextStyle(fontWeight: FontWeight.bold),
//               ),
//             ],
//           ),
//         );
//       return Scaffold(
//         // floatingActionButton: Wrap(
//         //   //will break to another line on overflow
//         //   direction: Axis.vertical,
//         //   //use vertical to show  on vertical axis
//         //   children: <Widget>[
//         //     Visibility(
//         //       visible: show_menu,
//         //       child: Stack(
//         //         children: [
//         //           Stack(
//         //             children: [
//         //               Stack(
//         //                 children: [
//         //                   InkWell(
//         //                     onTap: () async {
//         //                       final number = "+919894742511";
//         //                       final message = "Hello Doc!!";
//         //                       var url = 'https://wa.me/$number?text=$message';
//         //                       if (await canLaunch(url)) {
//         //                         await launch(url);
//         //                       }
//         //                     },
//         //                     child: AnimatedContainer(
//         //                       decoration: BoxDecoration(
//         //                           shape: BoxShape.circle,
//         //                           gradient: LinearGradient(
//         //                               begin: Alignment.topRight,
//         //                               end: Alignment.bottomRight,
//         //                               colors: [
//         //                                 Color.fromRGBO(151, 232, 243, 1),
//         //                                 Color.fromRGBO(0, 217, 246, 1)
//         //                               ])),
//         //                       margin: EdgeInsets.all(10),
//         //                       width: 37,
//         //                       height: 38,
//         //                       duration: Duration(seconds: 1),
//         //                       curve: Curves.bounceInOut,
//         //                       child: Image.asset("assets/images/whats_app.png"),
//         //                     ),
//         //                   )
//         //                 ],
//         //               )
//         //             ],
//         //           )
//         //         ],
//         //       ),
//         //     ), // /button first
//         //     Visibility(
//         //       visible: show_menu,
//         //       child: Stack(
//         //         children: [
//         //           Stack(
//         //             children: [
//         //               Stack(
//         //                 children: [
//         //                   InkWell(
//         //                     onTap: () {
//         //                       launch("tel://+919894742511");
//         //                     },
//         //                     child: Container(
//         //                       decoration: BoxDecoration(
//         //                           shape: BoxShape.circle,
//         //                           gradient: LinearGradient(
//         //                               begin: Alignment.topRight,
//         //                               end: Alignment.bottomRight,
//         //                               colors: [
//         //                                 Color.fromRGBO(151, 232, 243, 1),
//         //                                 Color.fromRGBO(0, 217, 246, 1)
//         //                               ])),
//         //                       margin: EdgeInsets.all(10),
//         //                       width: 37,
//         //                       height: 38,
//         //                       child:
//         //                           Image.asset("assets/images/phone_call.png"),
//         //                     ),
//         //                   ),
//         //                 ],
//         //               )
//         //             ],
//         //           )
//         //         ],
//         //       ),
//         //     ), // button second
//         //     InkWell(
//         //       onTap: () {
//         //         setState(() {
//         //           show_menu = !show_menu;
//         //         });
//         //       },
//         //       child: Stack(
//         //         children: [
//         //           Stack(
//         //             children: [
//         //               Stack(
//         //                 children: [
//         //                   Container(
//         //                     decoration: BoxDecoration(
//         //                         shape: BoxShape.circle,
//         //                         gradient: LinearGradient(
//         //                             begin: Alignment.topRight,
//         //                             end: Alignment.bottomRight,
//         //                             colors: [
//         //                               Color.fromRGBO(151, 232, 243, 1),
//         //                               Color.fromRGBO(0, 217, 246, 1)
//         //                             ])),
//         //                     margin: EdgeInsets.all(10),
//         //                     width: 37,
//         //                     height: 38,
//         //                     child:
//         //                         show_menu ? Icon(Icons.close) : Icon(Icons.add),
//         //                   )
//         //                 ],
//         //               )
//         //             ],
//         //           )
//         //         ],
//         //       ),
//         //     ), // button third
//         //
//         //     // Add more buttons here
//         //   ],
//         // ),
//         body: /* AnnotatedRegion<SystemUiOverlayStyle>(
//           value: SystemUiOverlayStyle(
//               statusBarColor: Colors.blueAccent,
//               statusBarIconBrightness: Brightness.light,
//               statusBarBrightness: Brightness.light,
//               systemNavigationBarColor: Colors.blueAccent),
//           child:*/
//         Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             // SizedBox(
//             //   height: 10,
//             // ),
//             Container(
//               height: height * 0.09,
//               width: double.infinity,
//               decoration: BoxDecoration(
//                   color: MyColor.primarycolor,
//                   borderRadius: BorderRadiusDirectional.only(
//                       bottomEnd: Radius.circular(25),
//                       bottomStart: Radius.circular(25))),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Obx(() => InkWell(
//                     onTap: () {
//                       //  Get.to(Setting("from_home"));
//                     },
//                     child: Container(
//                       margin: EdgeInsets.symmetric(horizontal: 10),
//                       child: CircleAvatar(
//                         radius: 30,
//                         child: Padding(
//                           padding: const EdgeInsets.all(2.0),
//                           child: ClipOval(
//                               child: profileController.image.value != null
//                                   ? CachedNetworkImage(
//                                 imageUrl:
//                                 profileController.image.value,
//                                 width: 100,
//                                 height: 100,
//                                 fit: BoxFit.cover,
//                                 placeholder: (context, url) =>
//                                 new CircularProgressIndicator(),
//                                 errorWidget: (context, url, error) =>
//                                 new Image.asset(
//                                     "assets/images/user.png"),
//                               )
//                                   : Image.asset(
//                                   "assets/images/user_image.png")),
//                         ),
//                       ),
//                     ),
//                   )),
//                   SizedBox(width: 8),
//                   Expanded(
//                     child: Text(
//                       "Hi, ${user_name}".capitalizeFirst!,
//                       style: TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.w500,
//                         color: Colors.white, // White text for contrast
//                       ),
//                     ),
//                   ),
//                   InkWell(
//                     onTap: () {
//                       Get.to(MyNotification());
//                     },
//                     child: Padding(
//                       padding: EdgeInsets.only(right: 10),
//                       child: Icon(
//                         Icons.notifications_none,
//                         color: Colors.white,
//                         size: 30,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(
//               height: 15,
//             ),
//             Text(
//               "Welcome to DentoCare".capitalizeFirst!,
//               style: TextStyle(
//                 fontSize: 22,
//                 fontWeight: FontWeight.w600,
//                 color: Colors.red, // White text for contrast
//               ),
//             ),
//             SizedBox(
//               height: height * 0.03,
//             ),
//             //  userid.isEmpty ?  SizedBox() : Column(
//             //   children: [
//             //     Row(
//             //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             //       children: [
//             //         DashboardComponentContainer(
//             //           onTab: () {
//             //             Get.to(Video(backarrow: true,));
//             //           },
//             //           backgroundImage: "assets/newImages/homegallery.png",
//             //           titleText: 'Gallery',
//             //           imageIcon: 'assets/newImages/homegallery1.png',
//             //         ),
//             //         DashboardComponentContainer(
//             //           onTab: () {Get.to(Services());},
//             //           backgroundImage: "assets/newImages/ourservices.png",
//             //           titleText: 'Our Services',
//             //           imageIcon: 'assets/newImages/ourservices1.png',
//             //         ),
//             //         // userid.isEmpty ? SizedBox() : DashboardComponentContainer(
//             //         //   onTab: () {
//             //         //     // Get.to(Payment());
//             //         //     // Get.to(PaymentHistory());
//             //         //   },
//             //         //   backgroundImage: "assets/newImages/paymenthistory.png",
//             //         //   titleText: 'Payment',
//             //         //   imageIcon: 'assets/newImages/paymenthistory1.png',
//             //         // )  ,
//             //       ],
//             //     ),
//             //     SizedBox(
//             //       height: height * 0.02,
//             //     ),
//             //     Row(
//             //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             //       children: [
//             //         DashboardComponentContainer(
//             //           onTab: () {Get.to(ContactUS());},
//             //           backgroundImage: "assets/newImages/contactus.png",
//             //           titleText: 'Contact\nUs',
//             //           imageIcon: 'assets/newImages/contactus1.png',
//             //         ),
//             //         // DashboardComponentContainer(
//             //         //   onTab: () {
//             //         //     // Get.to(AppointmentList());
//             //         //     Get.to(BookAppointment());
//             //         //   },
//             //         //   backgroundImage: "assets/newImages/myappointment.png",
//             //         //   titleText: 'Book\nAppointment',
//             //         //   imageIcon: 'assets/newImages/myappointment1.png',
//             //         // ),
//             //         DashboardComponentContainer(
//             //           onTab: () {},
//             //           backgroundImage: "assets/newImages/reachus.png",
//             //           titleText: 'Reach Us',
//             //           imageIcon: 'assets/newImages/reachus1.png',
//             //         ),
//             //       ],
//             //     ),
//             //   ],
//             // ),
//             Row(
//               // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               mainAxisAlignment: userid.isEmpty
//                   ? MainAxisAlignment.center
//                   : MainAxisAlignment.spaceEvenly,
//               children: [
//                 DashboardComponentContainer(
//                   onTab: () {
//                     Get.to(Video(
//                       backarrow: true,
//                     ));
//                   },
//                   backgroundImage: "assets/newImages/homegallery.png",
//                   titleText: 'Gallery',
//                   imageIcon: 'assets/newImages/homegallery1.png',
//                 ),
//                 DashboardComponentContainer(
//                   onTab: () {
//                     Get.to(Services());
//                   },
//                   backgroundImage: "assets/newImages/ourservices.png",
//                   titleText: 'Our\nServices',
//                   imageIcon: 'assets/newImages/ourservices1.png',
//                 ),
//                 userid.isEmpty
//                     ? SizedBox()
//                     : DashboardComponentContainer(
//                   onTab: () {
//                     Get.to(Payment());
//                     // Get.to(PaymentHistory());
//                   },
//                   backgroundImage: "assets/newImages/paymenthistory.png",
//                   titleText: 'Payment',
//                   imageIcon: 'assets/newImages/paymenthistory1.png',
//                 ),
//               ],
//             ),
//             SizedBox(
//               height: height * 0.01,
//             ),
//             Row(
//               //  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               mainAxisAlignment: userid.isEmpty
//                   ? MainAxisAlignment.center
//                   : MainAxisAlignment.spaceEvenly,
//               children: [
//                 DashboardComponentContainer(
//                   onTab: () {
//                     Get.to(ContactUS());
//                   },
//                   backgroundImage: "assets/newImages/contactus.png",
//                   titleText: 'Contact\nUs',
//                   imageIcon: 'assets/newImages/contactus1.png',
//                 ),
//                 userid.isEmpty
//                     ? SizedBox()
//                     : DashboardComponentContainer(
//                   onTab: () {
//                     // Get.to(AppointmentList());
//                     Get.to(BookAppointment());
//                   },
//                   backgroundImage: "assets/newImages/myappointment.png",
//                   titleText: 'Book\nAppointment',
//                   imageIcon: 'assets/newImages/myappointment1.png',
//                 ),
//                 DashboardComponentContainer(
//                   onTab: () {
//                     ReachedLocation.openGoogleMapsRoute();
//                   },
//                   backgroundImage: "assets/newImages/reachus.png",
//                   titleText: 'Reach Us',
//                   imageIcon: 'assets/newImages/reachus1.png',
//                 ),
//               ],
//             ),
//             SizedBox(
//               height: height * 0.0,
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 5.0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     "Dentocare Tips",
//                     style: TextStyle(
//                         color: Colors.red,
//                         fontSize: 17,
//                         fontWeight: FontWeight.w600),
//                   ),
//                   Visibility(
//                     child: Stack(
//                       children: [
//                         Stack(
//                           children: [
//                             Stack(
//                               children: [
//                                 InkWell(
//                                     onTap: () async {
//                                       final number = "+918010201080";
//                                       final message = "Hello Doc!!";
//                                       var url =
//                                           'https://wa.me/$number?text=$message';
//                                       if (await canLaunch(url)) {
//                                         await launch(url);
//                                       }
//                                     },
//                                     child: Image.asset(
//                                       "assets/newImages/whatsapplogo.png",fit: BoxFit.cover,scale: 2,) /* AnimatedContainer(
//                                     decoration: BoxDecoration(
//                                         shape: BoxShape.circle,
//                                         gradient: LinearGradient(
//                                             begin: Alignment.topRight,
//                                             end: Alignment.bottomRight,
//                                             colors: [
//                                               Color.fromRGBO(151, 232, 243, 1),
//                                               Color.fromRGBO(0, 217, 246, 1)
//                                             ])),
//                                     margin: EdgeInsets.all(10),
//                                     width: 45,
//                                     height: 45,
//                                     duration: Duration(seconds: 1),
//                                     curve: Curves.bounceInOut,
//                                     child: Image.asset(
//                                         "assets/newImages/whatsapplogo.png",fit: BoxFit.cover,),
//
//                                     // NetworkImage(userController.getimage.value)
//                                   ),*/
//                                 )
//                               ],
//                             )
//                           ],
//                         )
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             ///             new comment
//
//             /*Obx(() {
//               // Check if banner items are loading or empty
//               if (userController.isLoading.value && userController.bannerItems.isEmpty) {
//                 return Center(child: CircularProgressIndicator());
//               }
//               if (userController.bannerItems.isEmpty) {
//                 return Center(child: Text('No banners available'));
//               }
//
//               // Create image sliders from banner items
//               final List<Widget> imageSliders = userController.bannerItems
//                   .asMap()
//                   .entries
//                   .map((entry) {
//                 final item = entry.value;
//                 return Container(
//                   margin: EdgeInsets.all(5.0),
//                   child: ClipRRect(
//                     borderRadius: BorderRadius.all(Radius.circular(5.0)),
//                     child: Stack(
//                       children: <Widget>[
//                         Image.network(
//                           item.image,
//                           fit: BoxFit.cover,
//                           width: 1000.0,
//                           errorBuilder: (context, error, stackTrace) => Icon(Icons.error),
//                         ),
//                         Positioned(
//                           bottom: 0.0,
//                           left: 0.0,
//                           right: 0.0,
//                           child: Container(
//                             decoration: BoxDecoration(
//                               gradient: LinearGradient(
//                                 colors: [
//                                   Color.fromARGB(200, 0, 0, 0),
//                                   Color.fromARGB(0, 0, 0, 0),
//                                 ],
//                                 begin: Alignment.bottomCenter,
//                                 end: Alignment.topCenter,
//                               ),
//                             ),
//                             padding: EdgeInsets.symmetric(
//                                 vertical: 10.0, horizontal: 20.0),
//                             child: Text(
//                               item.title, // Use banner title
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 20.0,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               })
//                   .toList();
//               return Column(
//                 children: [
//                   Stack(
//                     children:[ Expanded(
//                       child: CarouselSlider(
//                         items: imageSliders,
//                         carouselController: _controller,
//                         options: CarouselOptions(
//                           autoPlay: true,
//                           enlargeCenterPage: true,
//                           aspectRatio: 2.0,
//                           onPageChanged: (index, reason) {
//                             setState(() {
//                               _current = index;
//                             });
//                           },
//                         ),
//                       ),
//                     ),
//                     ],),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: userController.bannerItems.asMap().entries.map((entry) {
//                       return GestureDetector(
//                         onTap: () => _controller.animateToPage(entry.key),
//                         child: Container(
//                           width: 11.0,
//                           height: 11.0,
//                           margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
//                           decoration: BoxDecoration(
//                             shape: BoxShape.circle,
//                             color: (Theme.of(context).brightness == Brightness.dark
//                                 ? Colors.white
//                                 : Colors.black)
//                                 .withOpacity(_current == entry.key ? 0.9 : 0.4),
//                           ),
//                         ),
//                       );
//                     }).toList(),
//                   ),
//                 ],
//               );
//             })*/
//             Obx(() {
//               // Assuming userController is a GetX controller
//               final userController = Get.find<UserController>();
//
//               // Check if banner items are loading or empty
//               if (userController.isLoading.value && userController.bannerItems.isEmpty) {
//                 return const Center(child: CircularProgressIndicator());
//               }
//               if (userController.bannerItems.isEmpty) {
//                 return const Center(child: Text('No banners available'));
//               }
//
//               // Create image sliders from banner items
//               final List<Widget> imageSliders = userController.bannerItems
//                   .asMap()
//                   .entries
//                   .map((entry) {
//                 final item = entry.value;
//                 return Container(
//                   margin: const EdgeInsets.all(5.0),
//                   child: ClipRRect(
//                     borderRadius: const BorderRadius.all(Radius.circular(5.0)),
//                     child: Stack(
//                       children: <Widget>[
//                         CachedNetworkImage(
//                           imageUrl: item.image ?? '',
//                           fit: BoxFit.cover,
//                           width: 1000.0,
//                           placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
//                           errorWidget: (context, url, error) => const Icon(Icons.error),
//                         ),
//                         Positioned(
//                           bottom: 0.0,
//                           left: 0.0,
//                           right: 0.0,
//                           child: Container(
//                             decoration: const BoxDecoration(
//                               gradient: LinearGradient(
//                                 colors: [
//                                   Color.fromARGB(200, 0, 0, 0),
//                                   Color.fromARGB(0, 0, 0, 0),
//                                 ],
//                                 begin: Alignment.bottomCenter,
//                                 end: Alignment.topCenter,
//                               ),
//                             ),
//                             padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
//                             child: Text(
//                               item.title ?? 'No Title',
//                               style: const TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 20.0,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               }).toList();
//
//               return Column(
//                 children: [
//                   CarouselSlider(
//                     items: imageSliders,
//                     carouselController: _controller,
//                     options: CarouselOptions(
//                       autoPlay: true,
//                       enlargeCenterPage: true,
//                       aspectRatio: 2.0,
//                       onPageChanged: (index, reason) {
//                         setState(() {
//                           _current = index;
//                         });
//                       },
//                     ),
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: userController.bannerItems.asMap().entries.map((entry) {
//                       return GestureDetector(
//                         onTap: () => _controller.animateToPage(entry.key),
//                         child: Container(
//                           width: 11.0,
//                           height: 11.0,
//                           margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
//                           decoration: BoxDecoration(
//                             shape: BoxShape.circle,
//                             color: (Theme.of(context).brightness == Brightness.dark
//                                 ? Colors.white
//                                 : Colors.black)
//                                 .withOpacity(_current == entry.key ? 0.9 : 0.4),
//                           ),
//                         ),
//                       );
//                     }).toList(),
//                   ),
//                 ],
//               );
//             })
//           ],
//         ),
//       );
//     });
//   }
//
//   getFormatedDate(int i) {
//     // return Jiffy.parse(userController.getlist[i]!.date).yMMMMd;
//   }
// }
//
// class DashboardComponentContainer extends StatelessWidget {
//   final VoidCallback onTab;
//   final String backgroundImage;
//   final String titleText;
//   final String imageIcon;
//
//   const DashboardComponentContainer({
//     Key? key,
//     required this.onTab,
//     required this.backgroundImage,
//     required this.titleText,
//     required this.imageIcon,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final height = MediaQuery.of(context).size.height;
//     final width = MediaQuery.of(context).size.width;
//
//     return GestureDetector(
//       onTap: onTab,
//       child: Container(
//         height: height * 0.156,
//         width: width * 0.32,
//         child: Stack(
//           children: [
//             // Background image with BoxFit.contain to prevent cropping
//             Image.asset(
//               backgroundImage,
//               height: height * 0.156,
//               width: width * 0.4,
//               // Adjusted to match container width
//               fit: BoxFit.contain,
//               // Changed from BoxFit.cover to BoxFit.contain
//               errorBuilder: (context, error, stackTrace) => Container(
//                 color: Colors.grey,
//                 child: const Center(child: Icon(Icons.error)),
//               ),
//             ),
//             // Title text
//             Positioned(
//               top: height * 0.02,
//               left: 13,
//               child: Text(
//                 titleText,
//                 style: const TextStyle(
//                   color: Colors.white,
//                   fontSize: 15,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//             ),
//             // Overlay image
//             Positioned(
//               top: height * 0.11,
//               bottom: height * 0.02,
//               left: height * 0.07,
//               right: height * 0.0,
//               child: Image.asset(
//                 imageIcon,
//                 height: height * 0.024,
//                 fit: BoxFit.contain,
//                 errorBuilder: (context, error, stackTrace) => const Icon(
//                   Icons.broken_image,
//                   size: 24,
//                   color: Colors.white,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

/*
import 'dart:async';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:dentocoreauth/Utills/Utills.dart';
import 'package:dentocoreauth/controllers/notification_controller.dart';
import 'package:dentocoreauth/controllers/profile_controller.dart';
import 'package:dentocoreauth/controllers/user_controller.dart';
import 'package:dentocoreauth/pages/notification/notification.dart';
import 'package:dentocoreauth/utils/GetXNetworkManager.dart';
import 'package:dentocoreauth/utils/mycolor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../models/appointment_response.dart';
import '../../utils/app_constant.dart';
import '../Services/Services.dart';
import '../appointment_list/appointment_list.dart';
import '../book_appointment/book_appointment.dart';
import '../contact_us/contact_us.dart';
import '../payment/payment.dart';
import '../payment_history/payment_history.dart';
import '../reached_location/reached_location.dart';
import '../setting/settings.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart' as myloader;
import '../video/video.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  var user_data = [];
  var load_status = false;
  var userid = "";
  var user_name = "";
  var show_menu = false;
  var util = Utills();
  final NotificationController _notificationController = Get.find();
  var isNewNotification = false;
  Timer? timer;
  String? isFirst;

  final statusMaps = {
    "0": "Pending",
    "1": "Rejected",
    "2": "Visited",
    "3": "Accepted",
    "4": "Revisited",
    "5": "Rescheduled",
    "6": "Pending",
  };
  final _networkManager = Get.find<GetXNetworkManager>();
  final UserController userController = Get.find();
  final ProfileController profileController = Get.find();
  final NotificationController notificationController = Get.find();
  var listOfGradinetColor = [
    AppConstant.paitent_1_bg,
    AppConstant.paitent_2_bg,
    AppConstant.paitent_3_bg,
    AppConstant.paitent_4_bg,
    AppConstant.paitent_5_bg,
  ];

  final listOfStatus = [
    "Pending",
    "Rejected",
    "Visited",
    "Accepted",
    "Revisited",
    "Rescheduled",
    "Pending",
  ];

  getNotifty() {
    Get.defaultDialog(
        radius: 20,
        contentPadding: EdgeInsets.all(20),
        title: "Alert",
        content: Container(
          width: MediaQuery.of(context).size.width,
          height: 100,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Text("content"),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MaterialButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: Text("Cancel"),
                    color: Colors.red,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  MaterialButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: Text("Ok"),
                    color: Colors.red,
                  ),
                ],
              )
            ],
          ),
        ));
  }

  Future<String> apiCallLogic() async {
    await userController
        .getAppointmentlist(userid)
        .then((value) => userController.getlist.refresh());
    return Future.value("Hello World");
  }

  int _current = 0;
  final CarouselSliderController _controller = CarouselSliderController();

  void getUserData(key) async {
    final sp = await SharedPreferences.getInstance();
    setState(() {
      debugPrint("dashboardcalled");
      user_data = sp.getStringList(key)!;
      load_status = true;
      userid = user_data[0].toString();
      user_name = user_data[1].toString();
      if (userid.isNotEmpty) {
        userController
            .getAppointmentlist(userid)
            .then((value) => userController.getlist.refresh());
        setState(() {
          notificationController
              .getNotifications(userid)
              .then((value) => notificationController.getlist.refresh());
        });

        profileController
            .getProfile(userid)
            .then((value) => profileController.image.value = value!.body.image);
      }
      checkStatus();
    });
  }

  checkStatus() {
    if (timer != null) {
      if (timer!.isActive) {
        timer!.cancel();
      }
    }
    timer = new Timer.periodic(Duration(seconds: 2), (timer) {
      userController.getChatStatus(userid).then((value) => {
        debugPrint("apicalled"),
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    timer!.cancel();

    if (EasyLoading.isShow) {
      EasyLoading.dismiss();
    }
  }

  void _pickFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);
    if (result == null) return;
    print(result.files.first.name);
    print(result.files.first.size);
    print(result.files.first.path);
  }

  Dialog resheduledDialog(BuildContext context, String appointment_id,
      AppointmentBody? appointmentBody) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0)),
      child: Container(
        child: FittedBox(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(12.0),
                child: Text(
                  'Reschedule',
                  style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.w700,
                      fontSize: 18),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(12.0),
                child: Text(
                  'Appointment has been rescheduled.\nNew date : ${appointmentBody!.date.toString().substring(0, 10)}\nNew time : ${appointmentBody!.timeSlotData.timeSlot}',
                  style: TextStyle(color: Colors.black, fontSize: 14),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 12.0),
                child: Text(
                  'Do you agree?',
                  style: TextStyle(color: Colors.black, fontSize: 14),
                ),
              ),
              Padding(padding: EdgeInsets.only(top: 10.0)),
              TextButton(
                  onPressed: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MaterialButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          debugPrint("Rescheduled" + "${appointment_id}");
                          userController.UpdateRescheduled(appointment_id, "1")
                              .then((value) => {
                            debugPrint("njtest" + "called"),
                            setState(() {
                              userController
                                  .getAppointmentlist(userid)
                                  .then((value) => {
                                userController.getlist
                                    .refresh(),
                                userController.update(),
                              });
                            }),
                            setState(() {
                              userController
                                  .getAppointmentlist(userid)
                                  .then((value) => {
                                userController.getlist
                                    .refresh(),
                                userController.update(),
                              });
                            }),
                          });
                        },
                        child: Text(
                          "Confirm",
                          style: TextStyle(color: Colors.white),
                        ),
                        color: Colors.blue,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      MaterialButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          debugPrint("resheduled" + "${appointment_id}");
                          userController.UpdateRescheduled(appointment_id, "0")
                              .then((value) => {
                            debugPrint("njtest" + "called"),
                            setState(() {
                              userController
                                  .getAppointmentlist(userid)
                                  .then((value) => {
                                userController.getlist
                                    .refresh(),
                                userController.update(),
                              });
                            }),
                            setState(() {
                              userController
                                  .getAppointmentlist(userid)
                                  .then((value) => {
                                userController.getlist
                                    .refresh(),
                                userController.update(),
                              });
                            }),
                          });
                        },
                        child: Text(
                          "Cancel",
                          style: TextStyle(color: Colors.white),
                        ),
                        color: Colors.blue,
                      ),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }

  Dialog errorDialog(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Dialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0)),
        child: Container(
          height: 466.0,
          width: 320.0,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Stack(
                children: [
                  Container(
                    height: 65,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(13),
                            topRight: Radius.circular(13)),
                        gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [Color(0xff97e0f7), Color(0xff97a1dd)],
                        )),
                    child: Row(
                      children: [
                        Expanded(
                          child: Center(
                            child: Text(
                              'Tips',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: Align(
                            alignment: Alignment.topRight,
                            child: Icon(
                              Icons.close_rounded,
                              size: 28,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.all(12.0),
                child: FittedBox(
                  child: Text(
                      "${userController.gettitle ?? "Brush your teeth properly"}",
                      style: TextStyle(
                        fontSize: 20,
                        color: Color.fromRGBO(0, 0, 0, 1),
                        fontWeight: FontWeight.w400,
                      )),
                ),
              ),
              Obx(
                    () => Container(
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  height: height * 0.40,
                  width: width * 0.9,
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
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        image: NetworkImage(userController.getimage.value)),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  getBanner() {}

  @override
  void initState() {
    super.initState();
    getUserData("user_data");
    userController.getHomeBanner();
    userController.getBanner().then((value) => {
      debugPrint("njdebug" + value!.body!.image.toString()),
      isFirst = AppConstant.getString("isFirst"),
      if (isFirst == "yes")
        {
          AppConstant.save_data("isFirst", "no"),
          showDialog(
              context: context,
              builder: (BuildContext context) => errorDialog(context)),
        }
    });

    Future.delayed(Duration(milliseconds: 1000), () {
      if (myloader.EasyLoading.isShow) {
        myloader.EasyLoading.dismiss();
      }
    });
  }

  Dialog changePassDialog(BuildContext context) {
    return Dialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0)),
        child: Container(
          height: 200.0,
          width: 200.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(12.0),
                child: Text(
                  'Exit',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      fontSize: 18),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(12.0),
                child: Center(
                  child: Text(
                    'D?',
                    style: TextStyle(color: Colors.black, fontSize: 14),
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.only(top: 20.0)),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MaterialButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text("Ok"),
                        color: Colors.blue,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      MaterialButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: Text("Cancel"),
                        color: Colors.blue,
                      ),
                    ],
                  ))
            ],
          ),
        ));
  }

  Future<SnackBar> askBack() async {
    return await util.showSnackBar("Alert", "double click to exit!", false);
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return GetBuilder<GetXNetworkManager>(builder: (builder) {
      if (_networkManager.connectionType == 0)
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/images/noint.jpeg"),
              SizedBox(
                height: 10,
              ),
              Text(
                "No Active Network Found!!",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        );
      return Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: height * 0.09,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: MyColor.primarycolor,
                  borderRadius: BorderRadiusDirectional.only(
                      bottomEnd: Radius.circular(25),
                      bottomStart: Radius.circular(25))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Obx(() => InkWell(
                    onTap: () {},
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      child: CircleAvatar(
                        radius: 30,
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: ClipOval(
                              child: profileController.image.value != null
                                  ? CachedNetworkImage(
                                imageUrl:
                                profileController.image.value,
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                                placeholder: (context, url) =>
                                new CircularProgressIndicator(),
                                errorWidget: (context, url, error) =>
                                new Image.asset(
                                    "assets/images/user.png"),
                              )
                                  : Image.asset(
                                  "assets/images/user_image.png")),
                        ),
                      ),
                    ),
                  )),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      "Hi, ${user_name}".capitalizeFirst!,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(MyNotification());
                    },
                    child: Padding(
                      padding: EdgeInsets.only(right: 10),
                      child: Icon(
                        Icons.notifications_none,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              "Welcome to DentoCare".capitalizeFirst!,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: Colors.red,
              ),
            ),
            SizedBox(
              height: height * 0.02,
            ),
            Row(
              mainAxisAlignment: userid.isEmpty
                  ? MainAxisAlignment.center
                  : MainAxisAlignment.spaceEvenly,
              children: [
                DashboardComponentContainer(
                  onTab: () {
                    Get.to(Video(
                      backarrow: true,
                    ));
                  },
                  backgroundImage: "assets/newImages/homegallery.png",
                  titleText: 'Gallery',
                  imageIcon: 'assets/newImages/homegallery1.png',
                ),
                DashboardComponentContainer(
                  onTab: () {
                    Get.to(Services());
                  },
                  backgroundImage: "assets/newImages/ourservices.png",
                  titleText: 'Our\nServices',
                  imageIcon: 'assets/newImages/ourservices1.png',
                ),
                userid.isEmpty
                    ? SizedBox()
                    : DashboardComponentContainer(
                  onTab: () {
                    Get.to(Payment());
                  },
                  backgroundImage: "assets/newImages/paymenthistory.png",
                  titleText: 'Payment',
                  imageIcon: 'assets/newImages/paymenthistory1.png',
                ),
              ],
            ),
            SizedBox(
              height: height * 0.01,
            ),
            Row(
              mainAxisAlignment: userid.isEmpty
                  ? MainAxisAlignment.center
                  : MainAxisAlignment.spaceEvenly,
              children: [
                DashboardComponentContainer(
                  onTab: () {
                    Get.to(ContactUS());
                  },
                  backgroundImage: "assets/newImages/contactus.png",
                  titleText: 'Contact\nUs',
                  imageIcon: 'assets/newImages/contactus1.png',
                ),
                userid.isEmpty
                    ? SizedBox()
                    : DashboardComponentContainer(
                  onTab: () {
                    Get.to(BookAppointment());
                  },
                  backgroundImage: "assets/newImages/myappointment.png",
                  titleText: 'Book\nAppointment',
                  imageIcon: 'assets/newImages/myappointment1.png',
                ),
                DashboardComponentContainer(
                  onTab: () {
                    ReachedLocation.openGoogleMapsRoute();
                  },
                  backgroundImage: "assets/newImages/reachus.png",
                  titleText: 'Reach Us',
                  imageIcon: 'assets/newImages/reachus1.png',
                ),
              ],
            ),
            SizedBox(
              height: height * 0.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Dentocare Tips",
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: 17,
                        fontWeight: FontWeight.w600),
                  ),
                  Visibility(
                    child: Stack(
                      children: [
                        Stack(
                          children: [
                            Stack(
                              children: [
                                InkWell(
                                    onTap: () async {
                                      final number = "+918010201080";
                                      final message = "Hello Doc!!";
                                      var url =
                                          'https://wa.me/$number?text=$message';
                                      if (await canLaunch(url)) {
                                        await launch(url);
                                      }
                                    },
                                    child: Image.asset(
                                      "assets/newImages/whatsapplogo.png",
                                      fit: BoxFit.cover,
                                      scale: 2,
                                    ))
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Obx(() {
              final userController = Get.find<UserController>();
              if (userController.isLoading.value &&
                  userController.bannerItems.isEmpty) {
                return const Center(child: CircularProgressIndicator());
              }
              if (userController.bannerItems.isEmpty) {
                return const Center(child: Text('No banners available'));
              }
              final List<Widget> imageSliders = userController.bannerItems
                  .asMap()
                  .entries
                  .map((entry) {
                final item = entry.value;
                return Container(
                  margin: const EdgeInsets.all(5.0),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                    child: Stack(
                      children: <Widget>[
                        CachedNetworkImage(
                          imageUrl: item.image ?? '',
                          fit: BoxFit.cover,
                          width: 1000.0,
                          placeholder: (context, url) =>
                          const Center(child: CircularProgressIndicator()),
                          errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                        ),
                        Positioned(
                          bottom: 0.0,
                          left: 0.0,
                          right: 0.0,
                          child: Container(
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Color.fromARGB(200, 0, 0, 0),
                                  Color.fromARGB(0, 0, 0, 0),
                                ],
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                              ),
                            ),
                            padding: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 20.0),
                            child: Text(
                              item.title ?? 'No Title',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList();

              return Column(
                children: [
                  CarouselSlider(
                    items: imageSliders,
                    carouselController: _controller,
                    options: CarouselOptions(
                      autoPlay: true,
                      enlargeCenterPage: true,
                      aspectRatio: 2.0,
                      onPageChanged: (index, reason) {
                        setState(() {
                          _current = index;
                        });
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:
                    userController.bannerItems.asMap().entries.map((entry) {
                      return GestureDetector(
                        onTap: () => _controller.animateToPage(entry.key),
                        child: Container(
                          width: 11.0,
                          height: 11.0,
                          margin: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 4.0),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: (Theme.of(context).brightness ==
                                Brightness.dark
                                ? Colors.white
                                : Colors.black).withOpacity(
                                _current == entry.key ? 0.9 : 0.4),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              );
            })
          ],
        ),
      );
    });
  }

  getFormatedDate(int i) {}
}

class DashboardComponentContainer extends StatelessWidget {
  final VoidCallback onTab;
  final String backgroundImage;
  final String titleText;
  final String imageIcon;

  const DashboardComponentContainer({
    Key? key,
    required this.onTab,
    required this.backgroundImage,
    required this.titleText,
    required this.imageIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: onTab,
      child: Container(
        height: height * 0.156,
        width: width * 0.32,
        decoration: BoxDecoration(),
        child: Stack(
          children: [
            // Background image with BoxFit.contain to prevent cropping
            Image.asset(
              backgroundImage,
              height: height * 0.2,
              width: width * 0.30,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                color: Colors.grey,
                child: const Center(child: Icon(Icons.error)),
              ),
            ),
            // Title text centered with responsive font size
            Padding(
              padding: EdgeInsets.only(top: height * 0.01, left: height*0.01, right: 8),
              child: Text(
                titleText,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: width * 0.045, // Responsive font size
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            // Overlay image centered at the bottom
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: EdgeInsets.only(bottom: height * 0.02,right: height * 0.02),
                child: Image.asset(
                  imageIcon,
                  height: height * 0.024,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) => const Icon(
                    Icons.broken_image,
                    size: 24,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}*/

                   ///       currect code change only loading problem fix
// import 'dart:async';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:get/get.dart';
// import 'package:get/get_navigation/get_navigation.dart';
// import 'package:dentocoreauth/Utills/Utills.dart';
// import 'package:dentocoreauth/controllers/notification_controller.dart';
// import 'package:dentocoreauth/controllers/profile_controller.dart';
// import 'package:dentocoreauth/controllers/user_controller.dart';
// import 'package:dentocoreauth/pages/notification/notification.dart';
// import 'package:dentocoreauth/utils/GetXNetworkManager.dart';
// import 'package:dentocoreauth/utils/mycolor.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:url_launcher/url_launcher.dart';
// import '../../models/appointment_response.dart';
// import '../../utils/app_constant.dart';
// import '../Services/Services.dart';
// import '../appointment_list/appointment_list.dart';
// import '../book_appointment/book_appointment.dart';
// import '../contact_us/contact_us.dart';
// import '../payment/payment.dart';
// import '../payment_history/payment_history.dart';
// import '../reached_location/reached_location.dart';
// import '../setting/settings.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart' as myloader;
// import '../video/video.dart';
//
// class Dashboard extends StatefulWidget {
//   const Dashboard({Key? key}) : super(key: key);
//
//   @override
//   State<Dashboard> createState() => _DashboardState();
// }
//
// class _DashboardState extends State<Dashboard> {
//   var user_data = [];
//   var load_status = false;
//   var userid = "";
//   // var user_name = "";
//   // RxString user_name = "".obs;
//   var show_menu = false;
//   var util = Utills();
//   final NotificationController _notificationController = Get.find();
//   var isNewNotification = false;
//   Timer? timer;
//   String? isFirst;
//
//   final statusMaps = {
//     "0": "Pending",
//     "1": "Rejected",
//     "2": "Visited",
//     "3": "Accepted",
//     "4": "Revisited",
//     "5": "Rescheduled",
//     "6": "Pending",
//   };
//   final _networkManager = Get.find<GetXNetworkManager>();
//   final UserController userController = Get.find();
//   final ProfileController profileController = Get.find();
//   final NotificationController notificationController = Get.find();
//   var listOfGradinetColor = [
//     AppConstant.paitent_1_bg,
//     AppConstant.paitent_2_bg,
//     AppConstant.paitent_3_bg,
//     AppConstant.paitent_4_bg,
//     AppConstant.paitent_5_bg,
//   ];
//
//   final listOfStatus = [
//     "Pending",
//     "Rejected",
//     "Visited",
//     "Accepted",
//     "Revisited",
//     "Rescheduled",
//     "Pending",
//   ];
//
//   getNotifty() {
//     Get.defaultDialog(
//         radius: 20,
//         contentPadding: EdgeInsets.all(20),
//         title: "Alert",
//         content: Container(
//           width: MediaQuery.of(context).size.width,
//           height: 100,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Center(
//                 child: Text("content"),
//               ),
//               SizedBox(height: 10),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   MaterialButton(
//                     onPressed: () {
//                       Get.back();
//                     },
//                     child: Text("Cancel"),
//                     color: Colors.red,
//                   ),
//                   SizedBox(
//                     width: 10,
//                   ),
//                   MaterialButton(
//                     onPressed: () {
//                       Get.back();
//                     },
//                     child: Text("Ok"),
//                     color: Colors.red,
//                   ),
//                 ],
//               )
//             ],
//           ),
//         ));
//   }
//
//   Future<String> apiCallLogic() async {
//     await userController
//         .getAppointmentlist(userid)
//         .then((value) => userController.getlist.refresh());
//     return Future.value("Hello World");
//   }
//
//   int _current = 0;
//   final CarouselSliderController _controller = CarouselSliderController();
//
//   // void getUserData(key) async {
//   //   final sp = await SharedPreferences.getInstance();
//   //   setState(() {
//   //     debugPrint("dashboardcalled");
//   //     user_data = sp.getStringList(key)!;
//   //     load_status = true;
//   //     userid = user_data[0].toString();
//   //     profileController.user_name = user_data[1].obs;
//   //     if (userid.isNotEmpty) {
//   //       userController
//   //           .getAppointmentlist(userid)
//   //           .then((value) => userController.getlist.refresh());
//   //       setState(() {
//   //         notificationController
//   //             .getNotifications(userid)
//   //             .then((value) => notificationController.getlist.refresh());
//   //       });
//   //
//   //       profileController
//   //           .getProfile(userid)
//   //           .then((value) => profileController.image.value = value!.body.image);
//   //     }
//   //     checkStatus();
//   //   });
//   // }
//   void getUserData(String key) async {
//     final sp = await SharedPreferences.getInstance();
//     final userData = sp.getStringList(key);
//     if (userData != null && userData.isNotEmpty) {
//       setState(() {
//         debugPrint("dashboardcalled");
//         user_data = userData;
//         load_status = true;
//         userid = user_data[0].toString();
//         // Server se latest data fetch karo taaki SharedPreferences sync rahe
//         profileController.getProfile(userid).then((value) {
//           if (value != null) {
//             print("Abhi:- getedit profile data ${value.message.toString()}");
//             print("Abhi:- getedit profile data body: ${value.body}");
//             // Update UI fields with latest data from getProfile
//             profileController.user_name.value = value.body.name ?? user_data[1];
//             //profileController._image.value = value.body.image ?? user_data[6];
//             profileController.name_profile.text = value.body.name ?? user_data[1];
//             profileController.email_profile.text = value.body.email ?? user_data[2];
//             profileController.contact_profile.text = value.body.mobile ?? user_data[3];
//           } else {
//             util.showSnackBar("Alert", "Failed to fetch latest profile", false);
//           }
//           // Refresh appointments and notifications
//           if (userid.isNotEmpty) {
//             userController
//                 .getAppointmentlist(userid)
//                 .then((value) => userController.getlist.refresh());
//             notificationController
//                 .getNotifications(userid)
//                 .then((value) => notificationController.getlist.refresh());
//           }
//           checkStatus();
//         });
//       });
//     } else {
//       util.showSnackBar("Alert", "User data not found", false);
//       setState(() {
//         load_status = false;
//       });
//     }
//   }
//
//   checkStatus() {
//     if (timer != null) {
//       if (timer!.isActive) {
//         timer!.cancel();
//       }
//     }
//     timer = new Timer.periodic(Duration(seconds: 2), (timer) {
//       userController.getChatStatus(userid).then((value) => {
//         debugPrint("apicalled"),
//       });
//     });
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//     timer!.cancel();
//
//     if (EasyLoading.isShow) {
//       EasyLoading.dismiss();
//     }
//     // EasyLoading.dismiss();
//   }
//
//   void _pickFile() async {
//     final result = await FilePicker.platform.pickFiles(allowMultiple: false);
//     if (result == null) return;
//     print(result.files.first.name);
//     print(result.files.first.size);
//     print(result.files.first.path);
//   }
//
//   Dialog resheduledDialog(BuildContext context, String appointment_id,
//       AppointmentBody? appointmentBody) {
//     return Dialog(
//       shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(12.0)),
//       child: Container(
//         child: FittedBox(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               Padding(
//                 padding: EdgeInsets.all(12.0),
//                 child: Text(
//                   'Reschedule',
//                   style: TextStyle(
//                       color: Colors.red,
//                       fontWeight: FontWeight.w700,
//                       fontSize: 18),
//                 ),
//               ),
//               Padding(
//                 padding: EdgeInsets.all(12.0),
//                 child: Text(
//                   'Appointment has been rescheduled.\nNew date : ${appointmentBody!.date.toString().substring(0, 10)}\nNew time : ${appointmentBody!.timeSlotData.timeSlot}',
//                   style: TextStyle(color: Colors.black, fontSize: 14),
//                 ),
//               ),
//               Padding(
//                 padding: EdgeInsets.only(top: 12.0),
//                 child: Text(
//                   'Do you agree?',
//                   style: TextStyle(color: Colors.black, fontSize: 14),
//                 ),
//               ),
//               Padding(padding: EdgeInsets.only(top: 10.0)),
//               TextButton(
//                   onPressed: () {},
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       MaterialButton(
//                         onPressed: () {
//                           Navigator.of(context).pop();
//                           debugPrint("Rescheduled" + "${appointment_id}");
//                           userController.UpdateRescheduled(appointment_id, "1")
//                               .then((value) => {
//                             debugPrint("njtest" + "called"),
//                             setState(() {
//                               userController
//                                   .getAppointmentlist(userid)
//                                   .then((value) => {
//                                 userController.getlist
//                                     .refresh(),
//                                 userController.update(),
//                               });
//                             }),
//                             setState(() {
//                               userController
//                                   .getAppointmentlist(userid)
//                                   .then((value) => {
//                                 userController.getlist
//                                     .refresh(),
//                                 userController.update(),
//                               });
//                             }),
//                           });
//                         },
//                         child: Text(
//                           "Confirm",
//                           style: TextStyle(color: Colors.white),
//                         ),
//                         color: Colors.blue,
//                       ),
//                       SizedBox(
//                         width: 10,
//                       ),
//                       MaterialButton(
//                         onPressed: () {
//                           Navigator.of(context).pop();
//                           debugPrint("resheduled" + "${appointment_id}");
//                           userController.UpdateRescheduled(appointment_id, "0")
//                               .then((value) => {
//                             debugPrint("njtest" + "called"),
//                             setState(() {
//                               userController
//                                   .getAppointmentlist(userid)
//                                   .then((value) => {
//                                 userController.getlist
//                                     .refresh(),
//                                 userController.update(),
//                               });
//                             }),
//                             setState(() {
//                               userController
//                                   .getAppointmentlist(userid)
//                                   .then((value) => {
//                                 userController.getlist
//                                     .refresh(),
//                                 userController.update(),
//                               });
//                             }),
//                           });
//                         },
//                         child: Text(
//                           "Cancel",
//                           style: TextStyle(color: Colors.white),
//                         ),
//                         color: Colors.blue,
//                       ),
//                     ],
//                   ))
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   /*Dialog errorDialog(BuildContext context) {
//     final height = MediaQuery.of(context).size.height;
//     final width = MediaQuery.of(context).size.width;
//     return Dialog(
//         shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(12.0)),
//         child: Container(
//           height: 466.0,
//           width: 320.0,
//           decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: <Widget>[
//               Stack(
//                 children: [
//                   Container(
//                     height: 65,
//                     width: MediaQuery.of(context).size.width,
//                     decoration: BoxDecoration(
//                         borderRadius: BorderRadius.only(
//                             topLeft: Radius.circular(13),
//                             topRight: Radius.circular(13)),
//                         gradient: LinearGradient(
//                           begin: Alignment.centerLeft,
//                           end: Alignment.centerRight,
//                           colors: [Color(0xff97e0f7), Color(0xff97a1dd)],
//                         )),
//                     child: Row(
//                       children: [
//                         Expanded(
//                           child: Center(
//                             child: Text(
//                               'Tips',
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 fontWeight: FontWeight.w700,
//                                 fontSize: 18,
//                               ),
//                             ),
//                           ),
//                         ),
//                         InkWell(
//                           onTap: () {
//                             Get.back();
//                           },
//                           child: Align(
//                             alignment: Alignment.topRight,
//                             child: Icon(
//                               Icons.close_rounded,
//                               size: 28,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//               Padding(
//                 padding: EdgeInsets.all(12.0),
//                 child: FittedBox(
//                   child: Text(
//                       "${userController.gettitle ?? "Brush your teeth properly"}",
//                       style: TextStyle(
//                         fontSize: 20,
//                         color: Color.fromRGBO(0, 0, 0, 1),
//                         fontWeight: FontWeight.w400,
//                       )),
//                 ),
//               ),
//               Obx(
//                     () => Container(
//                   margin: EdgeInsets.symmetric(horizontal: 16),
//                   height: height * 0.40,
//                   width: width * 0.9,
//                   decoration: BoxDecoration(
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.grey,
//                         offset: const Offset(5.0, 5.0),
//                         blurRadius: 10.0,
//                         spreadRadius: 2.0,
//                       ),
//                       BoxShadow(
//                         color: Colors.white,
//                         offset: const Offset(0.0, 0.0),
//                         blurRadius: 0.0,
//                         spreadRadius: 0.0,
//                       ),
//                     ],
//                     image: DecorationImage(
//                         fit: BoxFit.fill,
//                         image: NetworkImage(userController.getimage.value)),
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ));
//   }*/
//
//   Dialog errorDialog(BuildContext context) {
//     final height = MediaQuery.of(context).size.height;
//     final width = MediaQuery.of(context).size.width;
//
//     return Dialog(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(12.0),
//       ),
//       child: Container(
//         height: height * 0.6, // Responsive height
//         width: width * 0.85, // Responsive width
//         decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: <Widget>[
//             Stack(
//               children: [
//                 Container(
//                   height: height * 0.08,
//                   width: double.infinity,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.only(
//                       topLeft: Radius.circular(13),
//                       topRight: Radius.circular(13),
//                     ),
//                     gradient: LinearGradient(
//                       begin: Alignment.centerLeft,
//                       end: Alignment.centerRight,
//                       colors: [Color(0xff97e0f7), Color(0xff97a1dd)],
//                     ),
//                   ),
//                   child: Row(
//                     children: [
//                       Expanded(
//                         child: Center(
//                           child: Text(
//                             'Tips',
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontWeight: FontWeight.w700,
//                               fontSize: width * 0.05, // Responsive font size
//                             ),
//                           ),
//                         ),
//                       ),
//                       InkWell(
//                         onTap: () {
//                           Get.back();
//                         },
//                         child: Align(
//                           alignment: Alignment.topRight,
//                           child: Icon(
//                             Icons.close_rounded,
//                             size: width * 0.07,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//             Padding(
//               padding: EdgeInsets.all(width * 0.03),
//               child: FittedBox(
//                 child: Text(
//                   "${userController.gettitle ?? "Brush your teeth properly"}",
//                   style: TextStyle(
//                     fontSize: width * 0.05,
//                     color: Color.fromRGBO(0, 0, 0, 1),
//                     fontWeight: FontWeight.w400,
//                   ),
//                 ),
//               ),
//             ),
//             Obx(
//                   () => Container(
//                 margin: EdgeInsets.symmetric(horizontal: width * 0.04),
//                 height: height * 0.40,
//                 width: width * 0.75,
//                 decoration: BoxDecoration(
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.grey,
//                       offset: const Offset(5.0, 5.0),
//                       blurRadius: 10.0,
//                       spreadRadius: 2.0,
//                     ),
//                     BoxShadow(
//                       color: Colors.white,
//                       offset: const Offset(0.0, 0.0),
//                       blurRadius: 0.0,
//                       spreadRadius: 0.0,
//                     ),
//                   ],
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.circular(20),
//                   child: CachedNetworkImage(
//                     imageUrl: userController.getimage.value,
//                     fit: BoxFit.cover,
//                     placeholder: (context, url) => Center(
//                       child: CircularProgressIndicator(),
//                     ),
//                     errorWidget: (context, url, error) => Image.asset(
//                       "assets/images/placeholder.png", // Placeholder image
//                       fit: BoxFit.cover,
//                     ),
//                     // Enable caching for faster loading
//                     memCacheHeight: (height * 0.40).toInt(),
//                     memCacheWidth: (width * 0.75).toInt(),
//                     fadeInDuration: Duration(milliseconds: 500),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//   getBanner() {}
//
//   @override
//   void initState() {
//     super.initState();
//     getUserData("user_data");
//     userController.getHomeBanner();
//     userController.getBanner().then((value) => {
//       debugPrint("njdebug" + value!.body!.image.toString()),
//       isFirst = AppConstant.getString("isFirst"),
//       if (isFirst == "yes")
//         {
//           AppConstant.save_data("isFirst", "no"),
//           showDialog(
//               context: context,
//               builder: (BuildContext context) => errorDialog(context)),
//         }
//     });
//
//     Future.delayed(Duration(milliseconds: 1000), () {
//       if (myloader.EasyLoading.isShow) {
//         myloader.EasyLoading.dismiss();
//       }
//     });
//   }
//
//   Dialog changePassDialog(BuildContext context) {
//     return Dialog(
//         shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(12.0)),
//         child: Container(
//           height: 200.0,
//           width: 200.0,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: <Widget>[
//               Padding(
//                 padding: EdgeInsets.all(12.0),
//                 child: Text(
//                   'Exit',
//                   style: TextStyle(
//                       color: Colors.black,
//                       fontWeight: FontWeight.w700,
//                       fontSize: 18),
//                 ),
//               ),
//               Padding(
//                 padding: EdgeInsets.all(12.0),
//                 child: Center(
//                   child: Text(
//                     'D?',
//                     style: TextStyle(color: Colors.black, fontSize: 14),
//                   ),
//                 ),
//               ),
//               Padding(padding: EdgeInsets.only(top: 20.0)),
//               TextButton(
//                   onPressed: () {
//                     Navigator.of(context).pop();
//                   },
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       MaterialButton(
//                         onPressed: () {
//                           Navigator.of(context).pop();
//                         },
//                         child: Text("Ok"),
//                         color: Colors.blue,
//                       ),
//                       SizedBox(
//                         width: 10,
//                       ),
//                       MaterialButton(
//                         onPressed: () {
//                           Get.back();
//                         },
//                         child: Text("Cancel"),
//                         color: Colors.blue,
//                       ),
//                     ],
//                   ))
//             ],
//           ),
//         ));
//   }
//
//   Future<SnackBar> askBack() async {
//     return await util.showSnackBar("Alert", "double click to exit!", false);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final height = MediaQuery.of(context).size.height;
//     final width = MediaQuery.of(context).size.width;
//     return GetBuilder<GetXNetworkManager>(builder: (builder) {
//       if (_networkManager.connectionType == 0)
//         return Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Image.asset("assets/images/noint.jpeg"),
//               SizedBox(
//                 height: 10,
//               ),
//               Text(
//                 "No Active Network Found!!",
//                 style: TextStyle(fontWeight: FontWeight.bold),
//               ),
//             ],
//           ),
//         );
//       return Scaffold(
//         body: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             Container(
//               height: height * 0.09,
//               width: double.infinity,
//               decoration: BoxDecoration(
//                   color: MyColor.primarycolor,
//                   borderRadius: BorderRadiusDirectional.only(
//                       bottomEnd: Radius.circular(25),
//                       bottomStart: Radius.circular(25))),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Obx(() => InkWell(
//                     onTap: () {},
//                     child: Container(
//                       margin: EdgeInsets.symmetric(horizontal: 10),
//                       child: CircleAvatar(
//                         radius: 30,
//                         child: Padding(
//                           padding: const EdgeInsets.all(2.0),
//                           child: ClipOval(
//                               child: profileController.image.value != null
//                                   ? CachedNetworkImage(
//                                 imageUrl:
//                                 profileController.image.value,
//                                 width: 100,
//                                 height: 100,
//                                 fit: BoxFit.cover,
//                                 placeholder: (context, url) =>
//                                 new CircularProgressIndicator(),
//                                 errorWidget: (context, url, error) =>
//                                 new Image.asset(
//                                     "assets/images/user.png"),
//                               )
//                                   : Image.asset(
//                                   "assets/images/user_image.png")),
//                         ),
//                       ),
//                     ),
//                   )),
//                   SizedBox(width: 8),
//                   Obx(()=>
//                      Expanded(
//                       child: Text(
//                         "Hi, ${profileController.user_name}".capitalizeFirst!,
//                         style: TextStyle(
//                           fontSize: 20,
//                           fontWeight: FontWeight.w500,
//                           color: Colors.white,
//                         ),
//                       ),
//                     ),
//                   ),
//                   InkWell(
//                     onTap: () {
//                       Get.to(MyNotification());
//                     },
//                     child: Padding(
//                       padding: EdgeInsets.only(right: 10),
//                       child: Icon(
//                         Icons.notifications_none,
//                         color: Colors.white,
//                         size: 30,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(
//               height: 15,
//             ),
//             // Center(
//             //   child: Text(
//             //     "Welcome to Pearlline multispeciality dentocare".capitalizeFirst!,
//             //     style: TextStyle(
//             //       fontSize: 20,
//             //       fontWeight: FontWeight.w600,
//             //       color: Colors.red,
//             //     ),
//             //   ),
//             // ),
//             Center(
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Text(
//                     "Welcome to Pearlline",
//                     style: TextStyle(
//                       fontSize: 22,
//                       fontWeight: FontWeight.w600,
//                       color: Colors.red,
//                     ),
//                     textAlign: TextAlign.center,
//                   ),
//                   SizedBox(height: 8), // gap between the two lines
//                   Text(
//                     "multispeciality dentocare",
//                     style: TextStyle(
//                       fontSize: 22,
//                       fontWeight: FontWeight.w600,
//                       color: Colors.red,
//                     ),
//                     textAlign: TextAlign.center,
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(
//               height: height * 0.02,
//             ),
//            /* Row(
//               mainAxisAlignment: userid.isEmpty
//                   ? MainAxisAlignment.center
//                   : MainAxisAlignment.spaceEvenly,
//               children: [
//                 DashboardComponentContainer(
//                   onTab: () {
//                     Get.to(Video(
//                       backarrow: true,
//                     ));
//                   },
//                   backgroundImage: "assets/newImages/homegallery.png",
//                   titleText: 'Gallery',
//                   imageIcon: 'assets/newImages/homegallery1.png',
//                 ),
//                 userid.isEmpty
//                     ? SizedBox(width: width * 0.02,) :SizedBox(),
//                 DashboardComponentContainer(
//                   onTab: () {
//                     Get.to(Services());
//                   },
//                   backgroundImage: "assets/newImages/ourservices.png",
//                   titleText: 'Our\nServices',
//                   imageIcon: 'assets/newImages/ourservices1.png',
//                 ),
//                 userid.isEmpty
//                     ? SizedBox()
//                     : DashboardComponentContainer(
//                   onTab: () {
//                     Get.to(Payment());
//                   },
//                   backgroundImage: "assets/newImages/paymenthistory.png",
//                   titleText: 'Payment',
//                   imageIcon: 'assets/newImages/paymenthistory1.png',
//                 ),
//               ],
//             ),*/
//             Row(
//               mainAxisAlignment: userid.isEmpty
//                   ? MainAxisAlignment.center
//                   : MainAxisAlignment.spaceEvenly,
//               children: [
//                 DashboardComponentContainer(
//                   onTab: () {
//                     Get.to(Video(
//                       backarrow: true,
//                     ));
//                   },
//                   backgroundImage: "assets/newImages/homegallery.png",
//                   titleText: 'Gallery',
//                   imageIcon: 'assets/newImages/homegallery1.png',
//                 ),
//
//                 if (userid.isEmpty)
//                   SizedBox(width: width * 0.03),
//
//                 DashboardComponentContainer(
//                   onTab: () {
//                     Get.to(Services());
//                   },
//                   backgroundImage: "assets/newImages/ourservices.png",
//                   titleText: 'Our\nServices',
//                   imageIcon: 'assets/newImages/ourservices1.png',
//                 ),
//
//                 if (userid.isNotEmpty)
//                   DashboardComponentContainer(
//                     onTab: () {
//                       Get.to(Payment());
//                     },
//                     backgroundImage: "assets/newImages/paymenthistory.png",
//                     titleText: 'Payment',
//                     imageIcon: 'assets/newImages/paymenthistory1.png',
//                   ),
//               ],
//             ),
//
//             SizedBox(
//               height: height * 0.01,
//             ),
//             Row(
//               mainAxisAlignment: userid.isEmpty
//                   ? MainAxisAlignment.center
//                   : MainAxisAlignment.spaceEvenly,
//               children: [
//                 DashboardComponentContainer(
//                   onTab: () {
//                     Get.to(ContactUS());
//                   },
//                   backgroundImage: "assets/newImages/contactus.png",
//                   titleText: 'Contact Us',
//                   imageIcon: 'assets/newImages/contactus1.png',
//                 ),
//                 userid.isEmpty
//                     ? SizedBox(width: width * 0.03,)
//                     : DashboardComponentContainer(
//                   onTab: () {
//                     Get.to(BookAppointment());
//                   },
//                   backgroundImage: "assets/newImages/myappointment.png",
//                   titleText: 'Book\nAppointment',
//                   imageIcon: 'assets/newImages/myappointment1.png',
//                 ),
//                 // SizedBox(
//                 //   height: width * 0.01,
//                 // ),
//                 DashboardComponentContainer(
//                   onTab: () {
//                     ReachedLocation.openGoogleMapsRoute();
//                   },
//                   backgroundImage: "assets/newImages/reachus.png",
//                   titleText: 'Reach Us',
//                   imageIcon: 'assets/newImages/reachus1.png',
//                 ),
//               ],
//             ),
//             SizedBox(
//               height: height * 0.0,
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 5.0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     "Dental care tips",
//                     style: TextStyle(
//                         color: Colors.red,
//                         fontSize: 17,
//                         fontWeight: FontWeight.w600),
//                   ),
//                   Visibility(
//                     child: Stack(
//                       children: [
//                         Stack(
//                           children: [
//                             Stack(
//                               children: [
//                                 InkWell(
//                                     onTap: () async {
//                                       final number = "+918010201080";
//                                       final message = "Hello Doc!!";
//                                       var url =
//                                           'https://wa.me/$number?text=$message';
//                                       if (await canLaunch(url)) {
//                                         await launch(url);
//                                       }
//                                     },
//                                     child: Image.asset(
//                                       "assets/newImages/whatsapplogo.png",
//                                       fit: BoxFit.cover,
//                                       scale: 2,
//                                     ))
//                               ],
//                             )
//                           ],
//                         )
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Obx(() {
//               final userController = Get.find<UserController>();
//               if (userController.isLoading.value &&
//                   userController.bannerItems.isEmpty) {
//                 return const Center(child: CircularProgressIndicator());
//               }
//               if (userController.bannerItems.isEmpty) {
//                 return const Center(child: Text('No banners available'));
//               }
//               final List<Widget> imageSliders = userController.bannerItems
//                   .asMap()
//                   .entries
//                   .map((entry) {
//                 final item = entry.value;
//                 return Container(
//                   margin: const EdgeInsets.all(5.0),
//                   child: ClipRRect(
//                     borderRadius: const BorderRadius.all(Radius.circular(5.0)),
//                     child: Stack(
//                       children: <Widget>[
//                         CachedNetworkImage(
//                           imageUrl: item.image ?? '',
//                           fit: BoxFit.cover,
//                           width: 1000.0,
//                           placeholder: (context, url) =>
//                           const Center(child: CircularProgressIndicator()),
//                           errorWidget: (context, url, error) =>
//                           const Icon(Icons.error),
//                         ),
//                         Positioned(
//                           bottom: 0.0,
//                           left: 0.0,
//                           right: 0.0,
//                           child: Container(
//                             decoration: const BoxDecoration(
//                               gradient: LinearGradient(
//                                 colors: [
//                                   Color.fromARGB(200, 0, 0, 0),
//                                   Color.fromARGB(0, 0, 0, 0),
//                                 ],
//                                 begin: Alignment.bottomCenter,
//                                 end: Alignment.topCenter,
//                               ),
//                             ),
//                             padding: const EdgeInsets.symmetric(
//                                 vertical: 10.0, horizontal: 20.0),
//                             child: Text(
//                               item.title ?? 'No Title',
//                               style: const TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 20.0,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               }).toList();
//
//               return Column(
//                 children: [
//                   CarouselSlider(
//                     items: imageSliders,
//                     carouselController: _controller,
//                     options: CarouselOptions(
//                       autoPlay: true,
//                       enlargeCenterPage: true,
//                       aspectRatio: 2.0,
//                       onPageChanged: (index, reason) {
//                         setState(() {
//                           _current = index;
//                         });
//                       },
//                     ),
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children:
//                     userController.bannerItems.asMap().entries.map((entry) {
//                       return GestureDetector(
//                         onTap: () => _controller.animateToPage(entry.key),
//                         child: Container(
//                           width: 11.0,
//                           height: 11.0,
//                           margin: const EdgeInsets.symmetric(
//                               vertical: 8.0, horizontal: 4.0),
//                           decoration: BoxDecoration(
//                             shape: BoxShape.circle,
//                             color: (Theme.of(context).brightness ==
//                                 Brightness.dark
//                                 ? Colors.white
//                                 : Colors.black).withOpacity(
//                                 _current == entry.key ? 0.9 : 0.4),
//                           ),
//                         ),
//                       );
//                     }).toList(),
//                   ),
//                 ],
//               );
//             })
//           ],
//         ),
//       );
//     });
//   }
//
//   getFormatedDate(int i) {}
// }
//
// class DashboardComponentContainer extends StatelessWidget {
//   final VoidCallback onTab;
//   final String backgroundImage;
//   final String titleText;
//   final String imageIcon;
//
//   const DashboardComponentContainer({
//     Key? key,
//     required this.onTab,
//     required this.backgroundImage,
//     required this.titleText,
//     required this.imageIcon,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final height = MediaQuery.of(context).size.height;
//     final width = MediaQuery.of(context).size.width;
//
//     return GestureDetector(
//       onTap: onTab,
//       child: Container(
//         height: height * 0.156,
//         width: width * 0.29,
//         decoration: BoxDecoration(),
//         child: Stack(
//           children: [
//             // Background image with BoxFit.contain to prevent cropping
//             Container(
//               // color: Colors.red,
//               child: Image.asset(
//                 backgroundImage,
//                 height: height * 0.156,
//                 width: width * 0.32,
//                 fit: BoxFit.fill, // Changed to BoxFit.contain to prevent cropping
//                 errorBuilder: (context, error, stackTrace) => Container(
//                   color: Colors.grey,
//                   child: const Center(child: Icon(Icons.error)),
//                 ),
//               ),
//             ),
//             // Title text with responsive font size
//             Padding(
//               padding: EdgeInsets.only(top: height * 0.02, left: height * 0.01, right: 8),
//               child: Text(
//                 titleText,
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: width * 0.040, // Responsive font size
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//             ),
//             // Overlay image at the bottom-right
//             Align(
//               alignment: Alignment.bottomRight,
//               child: Padding(
//                 padding: EdgeInsets.only(bottom: height * 0.02, right: height * 0.02),
//                 child: Image.asset(
//                   imageIcon,
//                   height: height * 0.024,
//                   fit: BoxFit.contain,
//                   errorBuilder: (context, error, stackTrace) => const Icon(
//                     Icons.broken_image,
//                     size: 24,
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
///

import 'dart:async';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:dentocoreauth/Utills/Utills.dart';
import 'package:dentocoreauth/controllers/notification_controller.dart';
import 'package:dentocoreauth/controllers/profile_controller.dart';
import 'package:dentocoreauth/controllers/user_controller.dart';
import 'package:dentocoreauth/pages/notification/notification.dart';
import 'package:dentocoreauth/utils/GetXNetworkManager.dart';
import 'package:dentocoreauth/utils/mycolor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../models/appointment_response.dart';
import '../../utils/app_constant.dart';
import '../Services/Services.dart';
import '../appointment_list/appointment_list.dart';
import '../book_appointment/book_appointment.dart';
import '../contact_us/contact_us.dart';
import '../payment/payment.dart';
import '../payment_history/payment_history.dart';
import '../reached_location/reached_location.dart';
import '../setting/settings.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart' as myloader;
import '../video/video.dart';
import '../video/view_photos_screen.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  var user_data = [];
  var load_status = false;
  var userid = "";
  var show_menu = false;
  var util = Utills();
  final NotificationController _notificationController = Get.find();
  var isNewNotification = false;
  Timer? timer;
  String? isFirst;

  final statusMaps = {
    "0": "Pending",
    "1": "Rejected",
    "2": "Visited",
    "3": "Accepted",
    "4": "Revisited",
    "5": "Rescheduled",
    "6": "Pending",
  };
  final _networkManager = Get.find<GetXNetworkManager>();
  final UserController userController = Get.find();
  final ProfileController profileController = Get.find();
  final NotificationController notificationController = Get.find();
  var listOfGradinetColor = [
    AppConstant.paitent_1_bg,
    AppConstant.paitent_2_bg,
    AppConstant.paitent_3_bg,
    AppConstant.paitent_4_bg,
    AppConstant.paitent_5_bg,
  ];

  final listOfStatus = [
    "Pending",
    "Rejected",
    "Visited",
    "Accepted",
    "Revisited",
    "Rescheduled",
    "Pending",
  ];

  getNotifty() {
    Get.defaultDialog(
        radius: 20,
        contentPadding: EdgeInsets.all(20),
        title: "Alert",
        content: Container(
          width: MediaQuery.of(context).size.width,
          height: 100,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Text("content"),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MaterialButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: Text("Cancel"),
                    color: Colors.red,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  MaterialButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: Text("Ok"),
                    color: Colors.red,
                  ),
                ],
              )
            ],
          ),
        ));
  }

  Future<String> apiCallLogic() async {
    await userController
        .getAppointmentlist(userid)
        .then((value) => userController.getlist.refresh());
    return Future.value("Hello World");
  }

  int _current = 0;
  final CarouselSliderController _controller = CarouselSliderController();

  void getUserData(String key) async {
    final sp = await SharedPreferences.getInstance();
    final userData = sp.getStringList(key);
    if (userData != null && userData.isNotEmpty) {
      setState(() {
        debugPrint("dashboardcalled");
        user_data = userData;
        load_status = true;
        userid = user_data[0].toString();
        // Server se latest data fetch karo taaki SharedPreferences sync rahe
        profileController.getProfile(userid).then((value) {
          if (value != null) {
            print("Abhi:- getedit profile data ${value.message.toString()}");
            print("Abhi:- getedit profile data body: ${value.body}");
            // Update UI fields with latest data from getProfile
            profileController.user_name.value = value.body.name ?? user_data[1];
            profileController.name_profile.text = value.body.name ?? user_data[1];
            profileController.email_profile.text = value.body.email ?? user_data[2];
            profileController.contact_profile.text = value.body.mobile ?? user_data[3];
          } else {
            util.showSnackBar("Alert", "Failed to fetch latest profile", false);
          }
          // Refresh appointments and notifications
          if (userid.isNotEmpty) {
            userController
                .getAppointmentlist(userid)
                .then((value) => userController.getlist.refresh());
            notificationController
                .getNotifications(userid)
                .then((value) => {
              notificationController.getlist.refresh(),
              // Dismiss loader after all API calls complete
              // if (myloader.EasyLoading.isShow) {
              //   myloader.EasyLoading.dismiss(),
              // },
            });
          }
          checkStatus();
        });
      });
    } else {
      util.showSnackBar("Alert", "User data not found", false);
      setState(() {
        load_status = false;
        // Dismiss loader if no user data
        // if (myloader.EasyLoading.isShow) {
        //   myloader.EasyLoading.dismiss();
        // }
      });
    }
  }

  checkStatus() {
    if (timer != null) {
      if (timer!.isActive) {
        timer!.cancel();
      }
    }
    timer = Timer.periodic(Duration(seconds: 2), (timer) {
      userController.getChatStatus(userid).then((value) => {
        debugPrint("apicalled"),
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    timer?.cancel();
    // if (myloader.EasyLoading.isShow) {
    //   myloader.EasyLoading.dismiss();
    // }
    showSuccessProcess() {
      EasyLoading.dismiss();
    }
    util.startLoading().dismiss();

  }

  void _pickFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);
    if (result == null) return;
    print(result.files.first.name);
    print(result.files.first.size);
    print(result.files.first.path);
  }

  Dialog resheduledDialog(BuildContext context, String appointment_id,
      AppointmentBody? appointmentBody) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0)),
      child: Container(
        child: FittedBox(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(12.0),
                child: Text(
                  'Reschedule',
                  style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.w700,
                      fontSize: 18),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(12.0),
                child: Text(
                  'Appointment has been rescheduled.\nNew date : ${appointmentBody!.date.toString().substring(0, 10)}\nNew time : ${appointmentBody!.timeSlotData.timeSlot}',
                  style: TextStyle(color: Colors.black, fontSize: 14),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 12.0),
                child: Text(
                  'Do you agree?',
                  style: TextStyle(color: Colors.black, fontSize: 14),
                ),
              ),
              Padding(padding: EdgeInsets.only(top: 10.0)),
              TextButton(
                  onPressed: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MaterialButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          debugPrint("Rescheduled" + "${appointment_id}");
                          userController.UpdateRescheduled(appointment_id, "1")
                              .then((value) => {
                            debugPrint("njtest" + "called"),
                            setState(() {
                              userController
                                  .getAppointmentlist(userid)
                                  .then((value) => {
                                userController.getlist
                                    .refresh(),
                                userController.update(),
                              });
                            }),
                            setState(() {
                              userController
                                  .getAppointmentlist(userid)
                                  .then((value) => {
                                userController.getlist
                                    .refresh(),
                                userController.update(),
                              });
                            }),
                          });
                        },
                        child: Text(
                          "Confirm",
                          style: TextStyle(color: Colors.white),
                        ),
                        color: Colors.blue,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      MaterialButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          debugPrint("resheduled" + "${appointment_id}");
                          userController.UpdateRescheduled(appointment_id, "0")
                              .then((value) => {
                            debugPrint("njtest" + "called"),
                            setState(() {
                              userController
                                  .getAppointmentlist(userid)
                                  .then((value) => {
                                userController.getlist
                                    .refresh(),
                                userController.update(),
                              });
                            }),
                            setState(() {
                              userController
                                  .getAppointmentlist(userid)
                                  .then((value) => {
                                userController.getlist
                                    .refresh(),
                                userController.update(),
                              });
                            }),
                          });
                        },
                        child: Text(
                          "Cancel",
                          style: TextStyle(color: Colors.white),
                        ),
                        color: Colors.blue,
                      ),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }

  Dialog errorDialog(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Container(
        height: height * 0.6,
        width: width * 0.85,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Stack(
              children: [
                Container(
                  height: height * 0.08,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(13),
                      topRight: Radius.circular(13),
                    ),
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [Color(0xff97e0f7), Color(0xff97a1dd)],
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Center(
                          child: Text(
                            'Tips',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: width * 0.05,
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: Align(
                          alignment: Alignment.topRight,
                          child: Icon(
                            Icons.close_rounded,
                            size: width * 0.07,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(width * 0.03),
              child: FittedBox(
                child: Text(
                  "${userController.gettitle ?? "Brush your teeth properly"}",
                  style: TextStyle(
                    fontSize: width * 0.05,
                    color: Color.fromRGBO(0, 0, 0, 1),
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            Obx(
                  () => Container(
                margin: EdgeInsets.symmetric(horizontal: width * 0.04),
                height: height * 0.40,
                width: width * 0.75,
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
                  borderRadius: BorderRadius.circular(20),
                ),
                child: InkWell(
                  onTap: (){
                    Get.to(ViewPhotosScreen(images: userController.getimage.value));
                    Get.back();
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: CachedNetworkImage(
                      imageUrl: userController.getimage.value,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Center(
                        child: CircularProgressIndicator(),
                      ),
                      errorWidget: (context, url, error) => Image.asset(
                        "assets/images/placeholder.png",
                        fit: BoxFit.cover,
                      ),
                      memCacheHeight: (height * 0.40).toInt(),
                      memCacheWidth: (width * 0.75).toInt(),
                      fadeInDuration: Duration(milliseconds: 500),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  getBanner() {}



  @override
  void initState() {
    super.initState();
    // Show loader at the start
   // myloader.EasyLoading.show(status: 'Loading...');
    getUserData("user_data");
    userController.getHomeBanner();
    userController.getBanner().then((value) => {
      debugPrint("njdebug" + value!.body!.image.toString()),
      isFirst = AppConstant.getString("isFirst"),
      if (isFirst == "yes")
        {
          AppConstant.save_data("isFirst", "no"),
          showDialog(
              context: context,
              builder: (BuildContext context) => errorDialog(context)),
        },
      // Dismiss loader after banner fetch
      // if (myloader.EasyLoading.isShow) {myloader.EasyLoading.dismiss()},
    });
  }

  Dialog changePassDialog(BuildContext context) {
    return Dialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0)),
        child: Container(
          height: 200.0,
          width: 200.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(12.0),
                child: Text(
                  'Exit',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      fontSize: 18),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(12.0),
                child: Center(
                  child: Text(
                    'D?',
                    style: TextStyle(color: Colors.black, fontSize: 14),
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.only(top: 20.0)),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MaterialButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text("Ok"),
                        color: Colors.blue,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      MaterialButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: Text("Cancel"),
                        color: Colors.blue,
                      ),
                    ],
                  ))
            ],
          ),
        ));
  }

  Future<SnackBar> askBack() async {
    return await util.showSnackBar("Alert", "double click to exit!", false);
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return GetBuilder<GetXNetworkManager>(builder: (builder) {
      if (_networkManager.connectionType == 0)
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/images/noint.jpeg"),
              SizedBox(
                height: 10,
              ),
              Text(
                "No Active Network Found!!",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        );
      return Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: height * 0.09,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: MyColor.primarycolor,
                  borderRadius: BorderRadiusDirectional.only(
                      bottomEnd: Radius.circular(25),
                      bottomStart: Radius.circular(25))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Obx(() => InkWell(
                    onTap: () {},
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      child: CircleAvatar(
                        radius: 30,
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: ClipOval(
                              child: profileController.image.value != null
                                  ? CachedNetworkImage(
                                imageUrl: profileController.image.value,
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                                placeholder: (context, url) =>
                                new CircularProgressIndicator(),
                                errorWidget: (context, url, error) =>
                                Container( color: Colors.white,
                                    child: new Image.asset("assets/images/user.png")),
                              )
                                  : Image.asset("assets/images/user_image.png")),
                        ),
                      ),
                    ),
                  )),
                  SizedBox(width: 8),
                  Obx(() => Expanded(
                    child: Text(
                     "Hi, ${ profileController.user_name.split(' ').map((e) => e.capitalizeFirst!).join(' ')}",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  )),
                  InkWell(
                    onTap: () {
                      Get.to(MyNotification());
                    },
                    child: Padding(
                      padding: EdgeInsets.only(right: 10),
                      child: Icon(
                        Icons.notifications_none,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Welcome to Pearlline",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: Colors.red,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Multispeciality Dentocare",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: Colors.red,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: height * 0.02,
            ),
            Row(
              mainAxisAlignment: userid.isEmpty
                  ? MainAxisAlignment.center
                  : MainAxisAlignment.spaceEvenly,
              children: [
                DashboardComponentContainer(
                  onTab: () {
                    Get.to(Video(
                      backarrow: true,
                    ));
                  },
                  backgroundImage: "assets/newImages/homegallery.png",
                  titleText: 'Gallery',
                  imageIcon: 'assets/newImages/homegallery1.png',
                ),
                if (userid.isEmpty) SizedBox(width: width * 0.03),
                DashboardComponentContainer(
                  onTab: () {
                    Get.to(Services());
                  },
                  backgroundImage: "assets/newImages/ourservices.png",
                  titleText: 'Our',
                  titleTextSecond: 'Services',
                  imageIcon: 'assets/newImages/ourservices1.png',
                ),
                if (userid.isNotEmpty)
                  DashboardComponentContainer(
                    onTab: () {
                      Get.to(Payment());
                    },
                    backgroundImage: "assets/newImages/paymenthistory.png",
                    titleText: 'Payment',
                    imageIcon: 'assets/newImages/paymenthistory1.png',
                  ),
              ],
            ),
            SizedBox(
              height: height * 0.01,
            ),
            Row(
              mainAxisAlignment: userid.isEmpty
                  ? MainAxisAlignment.center
                  : MainAxisAlignment.spaceEvenly,
              children: [
                DashboardComponentContainer(
                  onTab: () {
                    Get.to(ContactUS());
                  },
                  backgroundImage: "assets/newImages/contactus.png",
                  titleText: 'Contact Us',
                  imageIcon: 'assets/newImages/contactus1.png',
                ),
                userid.isEmpty
                    ? SizedBox(width: width * 0.03)
                    : DashboardComponentContainer(
                  onTab: () {
                    Get.to(BookAppointment());
                  },
                  backgroundImage: "assets/newImages/myappointment.png",
                  titleText: 'Book',
                  titleTextSecond: 'Appointment',
                  imageIcon: 'assets/newImages/myappointment1.png',
                ),
                DashboardComponentContainer(
                  onTab: () {
                    ReachedLocation.openGoogleMapsRoute();
                  },
                  backgroundImage: "assets/newImages/reachus.png",
                  titleText: 'Reach Us',
                  imageIcon: 'assets/newImages/reachus1.png',
                ),
              ],
            ),
            SizedBox(
              height: height * 0.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Dental care tips",
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: 17,
                        fontWeight: FontWeight.w600),
                  ),
                  Visibility(
                    child: Stack(
                      children: [
                        Stack(
                          children: [
                            Stack(
                              children: [
                                InkWell(
                                    onTap: () async {
                                      final number = "+918010201080";
                                      final message = "Hello Doc!!";
                                      var url =
                                          'https://wa.me/$number?text=$message';
                                      if (await canLaunch(url)) {
                                        await launch(url);
                                      }
                                    },
                                    child: Image.asset(
                                      "assets/newImages/whatsapplogo.png",
                                      fit: BoxFit.cover,
                                      scale: 2,
                                    ))
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Obx(() {
              final userController = Get.find<UserController>();
              if (userController.isLoading.value &&
                  userController.bannerItems.isEmpty) {
                return const Center(child: CircularProgressIndicator());
              }
              if (userController.bannerItems.isEmpty) {
                return const Center(child: Text('No banners available'));
              }
              final List<Widget> imageSliders = userController.bannerItems
                  .asMap()
                  .entries
                  .map((entry) {
                final item = entry.value;
                return InkWell(
                  onTap: (){
                    Get.to(ViewPhotosScreen(images: item.image ?? '',));
                  },
                  child: Container(
                    margin: const EdgeInsets.all(5.0),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                      child: Stack(
                        children: <Widget>[
                          CachedNetworkImage(
                            imageUrl: item.image ?? '',
                            fit: BoxFit.cover,
                            width: 1000.0,
                            placeholder: (context, url) =>
                            const Center(child: CircularProgressIndicator()),
                            errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                          ),
                          Positioned(
                            bottom: 0.0,
                            left: 0.0,
                            right: 0.0,
                            child: Container(
                              decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Color.fromARGB(200, 0, 0, 0),
                                    Color.fromARGB(0, 0, 0, 0),
                                  ],
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                ),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 20.0),
                              child: Text(
                                item.title ?? 'No Title',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList();

              return Column(
                children: [
                  CarouselSlider(
                    items: imageSliders,
                    carouselController: _controller,
                    options: CarouselOptions(
                      autoPlay: true,
                      enlargeCenterPage: true,
                      aspectRatio: 2.0,
                      onPageChanged: (index, reason) {
                        setState(() {
                          _current = index;
                        });
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:
                    userController.bannerItems.asMap().entries.map((entry) {
                      return GestureDetector(
                        onTap: () => _controller.animateToPage(entry.key),
                        child: Container(
                          width: 11.0,
                          height: 11.0,
                          margin: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 4.0),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: (Theme.of(context).brightness ==
                                Brightness.dark
                                ? Colors.white
                                : Colors.black)
                                .withOpacity(_current == entry.key ? 0.9 : 0.4),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              );
            })
          ],
        ),
      );
    });
  }

  getFormatedDate(int i) {}
}

class DashboardComponentContainer extends StatelessWidget {
  final VoidCallback onTab;
  final String backgroundImage;
  final String titleText;
  final String? titleTextSecond;
  final String imageIcon;

  const DashboardComponentContainer({
    Key? key,
    required this.onTab,
    required this.backgroundImage,
    required this.titleText,
    required this.imageIcon,
    this.titleTextSecond,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: onTab,
      child: Container(
        height: height * 0.156,
        width: width * 0.29,
        decoration: BoxDecoration(),
        child: Stack(
          children: [
            Container(
              child: Image.asset(
                backgroundImage,
                height: height * 0.156,
                width: width * 0.32,
                fit: BoxFit.fill,
                errorBuilder: (context, error, stackTrace) => Container(
                  color: Colors.grey,
                  child: const Center(child: Icon(Icons.error)),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: height * 0.02, left: height * 0.01, right: 8),
              child: Text(
                titleText,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: width * 0.040,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),Padding(
              padding: EdgeInsets.only(top: height * 0.045, left: height * 0.01, right: 8),
              child: Text(
                titleTextSecond ?? '',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: width * 0.040,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: EdgeInsets.only(bottom: height * 0.02, right: height * 0.02),
                child: Image.asset(
                  imageIcon,
                  height: height * 0.024,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) => const Icon(
                    Icons.broken_image,
                    size: 24,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}