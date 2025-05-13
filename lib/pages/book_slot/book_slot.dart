// import 'dart:convert';
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bounceable/flutter_bounceable.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
// import 'package:dentocoreauth/Utills/Utills.dart';
// import 'package:dentocoreauth/pages/post/post.dart';
// import 'package:http/http.dart' as http;
// import '../../controllers/post_controller.dart';
// import '../../models/slot_select_DTO.dart';
// import '../../utils/app_constant.dart';
// import '../../models/slot_select_DTO.dart' as mySlotDTO;
//
// class Book_Slot extends StatefulWidget {
//   const Book_Slot({Key? key}) : super(key: key);
//
//   @override
//   State<Book_Slot> createState() => _Book_SlotState();
// }
//
// class _Book_SlotState extends State<Book_Slot> {
//   var _selected_slot = false;
//   var _checked_index = -1;
//   var available_time_Slots = <SlotBody>[];
//   var _disabled_slot_index = -1;
//   var noDoctorAvailable = false;
//
//   var search_date = "";
//   var _not_available_slots_index = [0, 4, 5, 3, 9];
//   var postController = Get.put(PostController());
//   final util = Utills();
//   DateTime selectedDate = DateTime.now();
//
//   var _selected_date = "";
//   var _selected_month = "";
//   var _selected_year = "";
//
//   var all_slots = [
//     "10:00 AM to 10:30 AM",
//     "10:30 AM to 11:00 AM",
//     "11:00-11:30",
//     "11:30-12:00",
//     "12:00-12:30",
//     "12:30-01:00",
//     "01:00-01:30",
//     "01:30-02:00",
//     "02:00-02:30",
//     "02:30-03:00",
//     "03:00-03:30",
//     "03:30-04:00",
//   ];
//
//   _selectDate(BuildContext context) async {
//     final DateTime? selected = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       initialDatePickerMode: DatePickerMode.day,
//       firstDate: DateTime.now().subtract(Duration(days: 0)),
//       lastDate: DateTime(2100),
//       builder: (context, child) {
//         return Theme(
//           data: Theme.of(context).copyWith(
//             colorScheme: ColorScheme.light(
//               primary: Color(0xaf6d2caf), // <-- SEE HERE
//               onPrimary: Colors.black, // <-- SEE HERE
//               onSurface: Colors.blueAccent, // <-- SEE HERE
//             ),
//             textButtonTheme: TextButtonThemeData(
//               style: TextButton.styleFrom(
//                 foregroundColor: Colors.black, // button text color
//               ),
//             ),
//           ),
//           child: child!,
//         );
//       },
//     );
//     if (selected != null)
//       setState(() {
//         selectedDate = selected;
//
//         //postController.date.text = DateFormat.yMd().format(selectedDate);
//
//         // util.showSnackBar(
//         //     "Alert", DateFormat.yMd().format(selectedDate).toString(), true);
//         _selected_year = DateFormat.y().format(selectedDate);
//         _selected_month = DateFormat.M().format(selectedDate);
//         _selected_date = DateFormat.d().format(selectedDate);
//         postController.selected_year.value = _selected_year.toString();
//         if (int.parse(_selected_date) <= 9) {
//           _selected_date = "0" + _selected_date.toString();
//           postController.selected_day.value = _selected_date.toString();
//         } else {
//           _selected_date = _selected_date;
//           postController.selected_day.value = _selected_date.toString();
//         }
//         if (int.parse(_selected_month) <= 9) {
//           _selected_month = "0" + _selected_month.toString();
//           postController.selected_mon.value = _selected_month.toString();
//         } else {
//           _selected_month = _selected_month;
//           postController.selected_mon.value = _selected_month.toString();
//         }
//         // util.showSnackBar(
//         //     "Alert",
//         //     "${postController.selected_year}" +
//         //         "-" +
//         //         "${postController.selected_mon}" +
//         //         "-" +
//         //         "${postController.selected_day}",
//         //     true);
//         search_date = "${postController.selected_year}" +
//             "-" +
//             "${postController.selected_mon}" +
//             "-" +
//             "${postController.selected_day}";
//         getSlot(search_date);
//       });
//   }
//
//   // Future<void> _selectDate(BuildContext context) async {
//   //   final DateTime? picked = await showDatePicker(
//   //     context: context,
//   //     initialDate: DateTime.now(),
//   //     initialDatePickerMode: DatePickerMode.day,
//   //     firstDate: DateTime.now().subtract(Duration(days: 0)),
//   //     lastDate: DateTime(2100),
//   //
//   //
//   //   );
//   //   if (picked != null)
//   //     setState(() {
//   //       selectedDate = picked;
//   //
//   //       //postController.date.text = DateFormat.yMd().format(selectedDate);
//   //
//   //       // util.showSnackBar(
//   //       //     "Alert", DateFormat.yMd().format(selectedDate).toString(), true);
//   //       _selected_year = DateFormat.y().format(selectedDate);
//   //       _selected_month = DateFormat.M().format(selectedDate);
//   //       _selected_date = DateFormat.d().format(selectedDate);
//   //       postController.selected_year.value = _selected_year.toString();
//   //       if (int.parse(_selected_date) <= 9) {
//   //         _selected_date = "0" + _selected_date.toString();
//   //         postController.selected_day.value = _selected_date.toString();
//   //       } else {
//   //         _selected_date = _selected_date;
//   //         postController.selected_day.value = _selected_date.toString();
//   //       }
//   //       if (int.parse(_selected_month) <= 9) {
//   //         _selected_month = "0" + _selected_month.toString();
//   //         postController.selected_mon.value = _selected_month.toString();
//   //       } else {
//   //         _selected_month = _selected_month;
//   //         postController.selected_mon.value = _selected_month.toString();
//   //       }
//   //       // util.showSnackBar(
//   //       //     "Alert",
//   //       //     "${postController.selected_year}" +
//   //       //         "-" +
//   //       //         "${postController.selected_mon}" +
//   //       //         "-" +
//   //       //         "${postController.selected_day}",
//   //       //     true);
//   //       search_date = "${postController.selected_year}" +
//   //           "-" +
//   //           "${postController.selected_mon}" +
//   //           "-" +
//   //           "${postController.selected_day}";
//   //       getSlot(search_date);
//   //     });
//   // }
//
//   @override
//   void initState() {
//     super.initState();
//     new Future.delayed(Duration.zero, () {
//       _selectDate(context);
//     });
//   }
//
//   Future<mySlotDTO.SlotSelectDto?> getSlot(String date) async {
//     util.startLoading();
//     var res = await http.post(
//         Uri.parse(AppConstant.BASE_URL + "/api/time_slot_get"),
//         body: <String, String>{
//           "date": "${date}",
//         },headers: <String,String>{"x-api-key":"dentist@123"});
//     print("Abhi:- response time slot ${res.body}");
//     if (res.statusCode == 200 || res.statusCode == 201) {
//       util.stopLoading();
//
//       final temp = jsonDecode(res.body.toString());
//       if (temp["body"] == "Not Available doctor") {
//         util.showSnackBar("Aleret", "No doctor available", false);
//         setState(() {
//           available_time_Slots = [];
//           noDoctorAvailable = true;
//         });
//       }
//
//       var result = mySlotDTO.slotSelectDtoFromJson(res.body);
//
//       setState(() {
//         noDoctorAvailable = false;
//         available_time_Slots = result.body;
//         _not_available_slots_index.clear();
//         _not_available_slots_index =
//             available_time_Slots.map((e) => int.parse(e.id)).toList();
//         all_slots.clear();
//         all_slots =
//             available_time_Slots.map((e) => e.timeSlot.toString()).toList();
//         debugPrint("slotdebug" + _not_available_slots_index.toString());
//         debugPrint("slotdebug" + all_slots.toString());
//       });
//       return result;
//     } else {
//       util.stopLoading();
//       util.showSnackBar("Alert", "something went wrong!", false);
//       return null;
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: SafeArea(
//           child: Container(
//             decoration: BoxDecoration(
//                 gradient: LinearGradient(
//               begin: Alignment.topCenter,
//               end: AlignmentDirectional.bottomCenter,
//               colors: [
//                 Color.fromRGBO(0, 127, 146, 1),
//                 Color.fromRGBO(0, 127, 146, 1),
//                 Color.fromRGBO(0, 127, 146, 1),
//                 Color.fromRGBO(0, 127, 146, 1),
//                 Color.fromRGBO(255, 255, 255, 0.48)
//               ],
//             )),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Container(
//                   color: Colors.white,
//                   child: Center(
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: [
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             Visibility(
//                               visible: true,
//                               maintainSize: true,
//                               maintainState: true,
//                               maintainSemantics: true,
//                               maintainAnimation: true,
//                               child: Container(
//                                 color: Colors.white,
//                                 width: MediaQuery.of(context).size.width / 3,
//                                 alignment: Alignment.centerLeft,
//                                 child: Padding(
//                                   padding: EdgeInsets.only(top: 10),
//                                   child: Bounceable(
//                                     onTap: () {
//                                       goback();
//                                     },
//                                     child: Container(
//                                       width: 70,
//                                       height: 40,
//                                       decoration: BoxDecoration(
//                                         color: Colors.white,
//                                         borderRadius: BorderRadius.only(
//                                             topRight: Radius.circular(30),
//                                             bottomRight: Radius.circular(30)),
//                                         boxShadow: [
//                                           BoxShadow(
//                                             color: Colors.grey.withOpacity(0.5),
//                                             spreadRadius: 1,
//                                             blurRadius: 2,
//                                             offset: Offset(0,
//                                                 3), // changes position of shadow
//                                           ),
//                                         ],
//                                       ),
//                                       child: Container(
//                                         decoration: BoxDecoration(
//                                             borderRadius: BorderRadius.only(
//                                                 topRight: Radius.circular(30),
//                                                 bottomRight:
//                                                     Radius.circular(30)),
//                                             gradient: AppConstant.BUTTON_COLOR),
//                                         child: Image.asset(
//                                           'assets/images/back_icon.png',
//                                           width: 10,
//                                           height: 10,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             Container(
//                               color: Colors.white,
//                               alignment: Alignment.center,
//                               width: MediaQuery.of(context).size.width / 3,
//                               child: Padding(
//                                 padding: const EdgeInsets.only(top: 15.0),
//                                 child: Container(
//                                   height: 40,
//                                   child: AppConstant.HEADLINE_TEXT(
//                                       "Appointment", context),
//                                 ),
//                               ),
//                             ),
//                             Visibility(
//                               visible: false,
//                               maintainAnimation: true,
//                               maintainSemantics: true,
//                               maintainState: true,
//                               maintainSize: true,
//                               child: Container(
//                                 color: Colors.white,
//                                 width: MediaQuery.of(context).size.width / 3,
//                                 alignment: Alignment.centerRight,
//                                 child: Padding(
//                                     padding: EdgeInsets.only(top: 0, right: 10),
//                                     child: Icon(Icons.notifications)),
//                               ),
//                             )
//                           ],
//                         ),
//                         SizedBox(
//                           height: 8,
//                         ),
//                         SizedBox(
//                           child: Container(
//                             height: 2,
//                             decoration:
//                                 BoxDecoration(color: Colors.grey, boxShadow: [
//                               BoxShadow(
//                                 offset: Offset(2, 4),
//                                 color: Colors.black.withOpacity(
//                                   0.3,
//                                 ),
//                                 blurRadius: 3,
//                               ),
//                             ]),
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                 ),
//                 Container(
//                     margin: EdgeInsets.only(top: 50),
//                     child: Center(
//                       child: Text("Select Date",
//                           style: TextStyle(
//                             fontSize: 20,
//                             color: Colors.white,
//                             fontWeight: FontWeight.w700,
//                           )),
//                     )),
//                 InkWell(
//                   onTap: () {
//                     _selectDate(context);
//                   },
//                   child: Container(
//                     margin: EdgeInsets.only(top: 10, left: 40, right: 40),
//                     height: 100,
//                     decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(20),
//                         border:
//                             Border.all(color: Colors.transparent, width: 0)),
//                     child: Center(
//                       child: Align(
//                         alignment: Alignment.centerLeft,
//                         child: Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceAround,
//                             children: [
//                               CircleAvatar(
//                                 radius: 30,
//                                 backgroundColor: Colors.white,
//                                 child: CircleAvatar(
//                                   radius: 28,
//                                   child: Align(
//                                     alignment: Alignment.center,
//                                     widthFactor: 1.0,
//                                     heightFactor: 1.0,
//                                     child: Container(
//                                       width: 60,
//                                       height: 60,
//                                       decoration: BoxDecoration(
//                                           gradient: AppConstant.Book_BG,
//                                           borderRadius:
//                                               BorderRadius.circular(60)),
//                                       child: Center(
//                                           child: Text(
//                                               _selected_date.isNotEmpty
//                                                   ? _selected_date
//                                                   : "DD",
//                                               style: TextStyle(
//                                                   fontSize: 20,
//                                                   fontWeight: FontWeight.w400,
//                                                   color: Colors.white))),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               CircleAvatar(
//                                 radius: 30,
//                                 backgroundColor: Colors.white,
//                                 child: CircleAvatar(
//                                   radius: 28,
//                                   child: Align(
//                                     alignment: Alignment.center,
//                                     widthFactor: 1.0,
//                                     heightFactor: 1.0,
//                                     child: Container(
//                                       width: 60,
//                                       height: 60,
//                                       decoration: BoxDecoration(
//                                           gradient: AppConstant.Book_BG,
//                                           borderRadius:
//                                               BorderRadius.circular(60)),
//                                       child: Center(
//                                           child: Text(
//                                               _selected_month.isNotEmpty
//                                                   ? _selected_month
//                                                   : "MM",
//                                               style: TextStyle(
//                                                   fontSize: 20,
//                                                   fontWeight: FontWeight.w400,
//                                                   color: Colors.white))),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               CircleAvatar(
//                                 radius: 30,
//                                 backgroundColor: Colors.white,
//                                 child: CircleAvatar(
//                                   radius: 28,
//                                   child: Align(
//                                     alignment: Alignment.center,
//                                     widthFactor: 1.0,
//                                     heightFactor: 1.0,
//                                     child: Container(
//                                       width: 60,
//                                       height: 60,
//                                       decoration: BoxDecoration(
//                                           gradient: AppConstant.Book_BG,
//                                           borderRadius:
//                                               BorderRadius.circular(60)),
//                                       child: Center(
//                                           child: Text(
//                                               _selected_year.isNotEmpty
//                                                   ? _selected_year
//                                                   : "YY",
//                                               style: TextStyle(
//                                                   fontSize: 20,
//                                                   fontWeight: FontWeight.w400,
//                                                   color: Colors.white))),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 Container(
//                   margin: EdgeInsets.only(top: 46, left: 30, right: 30),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text("Select Time Slot",
//                           style: TextStyle(
//                             fontSize: 20,
//                             color: Colors.white,
//                             fontWeight: FontWeight.w700,
//                           )),
//                       Column(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Row(
//                             children: [
//                               Visibility(
//                                 visible:false,
//                                 child: Container(
//                                   width: 9,
//                                   height: 7,
//                                   color: Colors.white,
//                                 ),
//                               ),
//                               SizedBox(
//                                 width: 8,
//                               ),
//                               Visibility(
//                                 visible: false,
//                                 child: Text("Available",
//                                     style: TextStyle(
//                                       fontSize: 11,
//                                       color: Colors.white,
//                                       fontWeight: FontWeight.w700,
//                                     )),
//                               )
//                             ],
//                           ),
//                           Visibility(
//                             visible: false,
//                             child: Row(
//                               children: [
//                                 Container(
//                                   width: 9,
//                                   height: 7,
//                                   color: Colors.red,
//                                 ),
//                                 SizedBox(
//                                   width: 8,
//                                 ),
//                                 Text("Not-Available",
//                                     style: TextStyle(
//                                       fontSize: 11,
//                                       color: Colors.white,
//                                       fontWeight: FontWeight.w700,
//                                     ))
//                               ],
//                             ),
//                           ),
//                         ],
//                       )
//                     ],
//                   ),
//                 ),
//
//                 //select time slots
//                 InkWell(
//                   onTap: () {
//                     setState(() {});
//                   },
//                   child: Container(
//
//                     margin: EdgeInsets.only(top: 10, left: 20, right: 20),
//                     height: MediaQuery.of(context).size.height / 2,
//
//                     decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(20),
//                         border:
//                             Border.all(color: Colors.transparent, width: 0.5)),
//                     child: noDoctorAvailable == true
//                         ? Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Image.asset("assets/images/no_doc.png",scale: 3,),
//                             SizedBox(height: 8,),
//                             Center(
//                               child: Text(
//                                 "Doctor is not available!",
//                                 style: TextStyle(fontSize: 20),
//                               ),
//                             ),
//                           ],
//                         )
//                         : Center(
//                             child: Align(
//                               alignment: Alignment.centerLeft,
//                               child: Padding(
//                                   padding: const EdgeInsets.all(8.0),
//                                   child: GridView.builder(
//                                     gridDelegate:
//                                         SliverGridDelegateWithFixedCrossAxisCount(
//                                             crossAxisCount: 3),
//                                     itemBuilder: (c, i) {
//                                       return InkWell(
//                                         onTap: () {
//                                           setState(() {
//                                             _selected_slot = true;
//                                             if (_not_available_slots_index
//                                                 .contains(i.toString())) {
//                                               util.showSnackBar("Alert",
//                                                   "not available${i}", false);
//                                             } else {
//                                               // util.showSnackBar(
//                                               //     "Alert", " available${i}", true);
//                                               postController.seletecd_time_slot
//                                                       .value =
//                                                   all_slots[i].toString();
//                                               //util.showSnackBar("Alert", "${available_time_Slots[i].id}", true);
//                                               postController.time_slot_id =
//                                                   available_time_Slots[i].id;
//                                              // goback();
//                                             }
//                                             _checked_index = i;
//                                           });
//                                         },
//                                         child: Center(
//                                           child: Column(
//                                            crossAxisAlignment: CrossAxisAlignment.center,
//                                             mainAxisAlignment: MainAxisAlignment.center,
//
//                                             children: [
//                                               Flexible(
//                                                 child: CircleAvatar(
//                                                   radius: 30,
//                                                   backgroundColor:
//                                                     _checked_index == i
//                                                               ? Colors.green
//                                                               : Colors.white,
//                                                   child: CircleAvatar(
//                                                     radius: 28,
//                                                     child: Align(
//                                                       alignment: Alignment.center,
//                                                       widthFactor: 1.0,
//                                                       heightFactor: 1.0,
//                                                       child: Container(
//                                                         width: 60,
//                                                         height: 60,
//                                                         decoration: BoxDecoration(
//                                                             gradient:
//                                                                 AppConstant.Book_BG,
//                                                             borderRadius:
//                                                                 BorderRadius
//                                                                     .circular(60)),
//                                                         child: Center(
//                                                             child:    _checked_index == i
//                                                                 ? Image.asset(
//                                                                 "assets/images/sel_img.png")
//                                                                 : Image.asset(
//                                                                 "assets/images/newbed.png"),),
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ),
//                                               SizedBox(
//                                                 height: 4,
//                                               ),
//                                               Center(
//                                                 child: Text(
//                                                     "${available_time_Slots[i].timeSlot}"
//                                                             .substring(0, 9) +
//                                                         "-" +
//                                                         "${available_time_Slots[i].timeSlot}"
//                                                             .substring(11),
//                                                     style: TextStyle(
//                                                       fontSize: 10,
//                                                       color:
//                                                           _not_available_slots_index
//                                                                   .contains(
//                                                                       i.toString())
//                                                               ? Colors.red
//                                                               : Colors.white,
//                                                       fontWeight: FontWeight.w700,
//                                                     )),
//                                               )
//                                             ],
//                                           ),
//                                         ),
//                                       );
//                                     },
//                                     itemCount: available_time_Slots.length,
//                                   )),
//                             ),
//                           ),
//                   ),
//                 ),
//
//                 //button
//                 Bounceable(
//                   onTap: (){
//                     goback();
//                   },
//                   child: Center(
//                     child: Container(
//                       margin: EdgeInsets.only(top: 60, bottom: 60),
//                       width: 289,
//                       height: 45,
//                       decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(20),
//                           boxShadow:  [
//                             BoxShadow(
//                               color: Colors.grey,
//                               offset: const Offset(
//                                 5.0,
//                                 5.0,
//                               ),
//                               blurRadius: 10.0,
//                               spreadRadius: 2.0,
//                             ), //BoxShadow
//                             BoxShadow(
//                               color: Colors.white,
//                               offset: const Offset(0.0, 0.0),
//                               blurRadius: 0.0,
//                               spreadRadius: 0.0,
//                             ), //
//                             // BoxShadow
//                           ],
//                           border: Border.all(color: Colors.transparent, width: 1),
//                           gradient: LinearGradient(
//                               begin: AlignmentDirectional.centerStart,
//                               end: AlignmentDirectional.centerEnd,
//                               colors: [
//                                 Color.fromRGBO(255, 255, 255, 1),
//                                 Color.fromRGBO(114, 196, 255, 0.69),
//                               ])),
//                       child: Center(
//                         child: Bounceable(
//                           onTap: () {
//                             goback();
//                           },
//                           child:  Container(
//                             child: Text("Done",
//                                 style: TextStyle(
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.w700,
//                                 )),
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
//
//   void goback() {
//     Get.back();
//   }
// }
