//
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:dentocoreauth/utils/app_constant.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart' as myloader;
//
// import '../../Utills/Utills.dart';
// import '../../controllers/appoinment_detail_page.dart';
// import '../../controllers/post_controller.dart';
// import '../../models/slot_select_DTO.dart';
// import '../../utils/component_screen.dart';
// import '../../utils/mycolor.dart';
// import '../appointment_details/appointment_details.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import '../../models/slot_select_DTO.dart' as mySlotDTO;
//
//
// class AppointmentList extends StatefulWidget {
//   const AppointmentList({Key? key}) : super(key: key);
//
//   @override
//   State<AppointmentList> createState() => _AppointmentListState();
// }
//
// class _AppointmentListState extends State<AppointmentList> {
//   final AppoinmentDetailPages appoinmentDetailController = Get.find();
//   AppoinmentDetail? appointmentData;
//   var userId = "";
//
//   Future<void> fechDetailData() async {
//     if (userId.isEmpty) {
//       print("fechDetailData: User ID is empty, skipping API call");
//       Get.snackbar("Error", "Please login to view appointments",
//           backgroundColor: Colors.red, colorText: Colors.white);
//       appoinmentDetailController.isLoading.value = false;
//       return;
//     }
//     print("fechDetailData: Fetching details for userId: $userId");
//     appointmentData = await appoinmentDetailController.getAppoinmentDetail(userId);
//     setState(() {});
//   }
//
//   void getUserData(String key) async {
//     final sp = await SharedPreferences.getInstance();
//     setState(() {
//       var user_data = sp.getStringList(key) ?? [];
//       userId = user_data.isNotEmpty ? user_data[0].toString() : "";
//       print("User ID Fetched: $userId");
//     });
//     // Fetch appointment data after userId is set
//     await fechDetailData();
//   }
//   // final util = Utills();
//   // var available_time_Slots = <SlotBody>[];
//   // var noDoctorAvailable = false;
//   // var all_slots = <String>[];
//   // var _not_available_slots_index = <int>[];
//   // var user_data = [];
//   // var load_status = false;
//   // var userid = "";
//   // late var selectedIndex = 0;
//   // final PostController postController = Get.put(PostController());
//   // Future<mySlotDTO.SlotSelectDto?> getSlot(String date) async {
//   //   util.startLoading();
//   //   try {
//   //     var res = await http.post(
//   //       Uri.parse("${AppConstant.BASE_URL}/api/time_slot_get"),
//   //       body: <String, String>{"date": date},
//   //       headers: <String, String>{"x-api-key": "dentist@123"},
//   //     );
//   //     print("Response Time Slot: ${res.body}");
//   //     if (res.statusCode == 200 || res.statusCode == 201) {
//   //       util.stopLoading();
//   //       final temp = jsonDecode(res.body.toString());
//   //       if (temp["body"] == "Not Available doctor") {
//   //         util.showSnackBar("Alert", "No doctor available", false);
//   //         setState(() {
//   //           available_time_Slots = [];
//   //           all_slots = [];
//   //           noDoctorAvailable = true;
//   //           selectedIndex = 0;
//   //           postController.time_slot_id = "";
//   //           postController.seletecd_time_slot.value = "";
//   //         });
//   //         return null;
//   //       } else {
//   //         var result = mySlotDTO.slotSelectDtoFromJson(res.body);
//   //         setState(() {
//   //           noDoctorAvailable = false;
//   //           available_time_Slots = result.body ?? [];
//   //           all_slots = available_time_Slots.map((e) => e.timeSlot.toString()).toList();
//   //           _not_available_slots_index = available_time_Slots
//   //               .asMap()
//   //               .entries
//   //               .where((entry) => entry.value.id == null || entry.value.id.isEmpty)
//   //               .map((entry) => entry.key)
//   //               .toList();
//   //           selectedIndex = 0;
//   //           postController.time_slot_id = "";
//   //           postController.seletecd_time_slot.value = "";
//   //           print("Available Slots: $all_slots");
//   //           print("Not Available Slots Index: $_not_available_slots_index");
//   //         });
//   //         return result;
//   //       }
//   //     } else {
//   //       util.showSnackBar("Alert", "Something went wrong!", false);
//   //       return null;
//   //     }
//   //   } catch (e) {
//   //     util.showSnackBar("Error", "Failed to fetch slots: $e", false);
//   //     return null;
//   //   } finally {
//   //     util.stopLoading();
//   //   }
//   // }
//
//   void matchetimesoletid () {
//
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     getUserData("user_data");
//   }
//
//   final List<Color> containerColors = [
//     Colors.blue[200]!,
//     Colors.green[200]!,
//     Colors.red[200]!,
//     Colors.yellow[200]!,
//     Colors.purple[200]!,
//     Colors.orange[200]!,
//     Colors.pink[200]!,
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     print("Building AppointmentList, User ID: $userId");
//     final height = MediaQuery.of(context).size.height;
//     final width = MediaQuery.of(context).size.width;
//     return AnnotatedRegion<SystemUiOverlayStyle>(
//       value: SystemUiOverlayStyle(
//         statusBarColor: MyColor.primarycolor,
//         statusBarIconBrightness: Brightness.light,
//         statusBarBrightness: Brightness.light,
//         systemNavigationBarColor: Colors.transparent,
//       ),
//       child: SafeArea(
//         child: Container(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               CustomBooingAppBar(title: ' Appointment List'),
//               SizedBox(height: 10),
//               Expanded(
//                 child: Obx(() {
//                   if (appoinmentDetailController.isLoading.value) {
//                    // myloader.EasyLoading.show(status: 'Loading...');
//                     return Center(child: CircularProgressIndicator(color: Colors.blue));
//                   } else {
//                     myloader.EasyLoading.dismiss();
//                     if (appointmentData == null ||
//                         appointmentData!.body == null ||
//                         appointmentData!.body!.isEmpty) {
//                       return Center(child: Text("No appointments found"));
//                     }
//                     return ListView.builder(
//                       itemCount: appointmentData!.body!.length,
//                       itemBuilder: (c, index) {
//                         var item = appointmentData!.body![index];
//                         return InkWell(
//                           onTap: () {
//                             Get.to(AppointmentDetails(item));
//                           },
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Divider(),
//                               Row(
//                                 children: [
//                                   Container(
//                                     height: height * 0.05,
//                                     width: width * 0.26,
//                                     decoration: BoxDecoration(
//                                       color: containerColors[index % containerColors.length],
//                                       borderRadius: BorderRadius.only(
//                                         topRight: Radius.circular(20),
//                                         bottomRight: Radius.circular(20),
//                                       ),
//                                     ),
//                                     child: Center(
//                                       child: Text(
//                                         item.date ?? "No Date",
//                                         style: TextStyle(
//                                           fontSize: 14,
//                                           fontWeight: FontWeight.w600,
//                                           color: Colors.white,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                   SizedBox(width: width * 0.05),
//                                   InkWell(
//                                     onTap: (){
//                                      // Get.to();
//                                     },
//                                     child: Container(
//                                       height: 60,
//                                       width: 60,
//                                       /*decoration: BoxDecoration(
//                                         image: DecorationImage(
//                                           image: item.serviceData?.image != null
//                                               ? NetworkImage(item.serviceData!.image!)
//                                               : AssetImage("assets/newImages/videofiledimage.png")
//                                           as ImageProvider,
//                                           fit: BoxFit.cover,
//                                         ),
//                                         borderRadius: BorderRadius.circular(10),
//                                       ),*/
//                                       child: ClipRRect(
//                                         borderRadius: BorderRadius.circular(12),
//                                         child: CachedNetworkImage(
//                                           // Check if nextVisitHistory exists and has items
//                                           imageUrl: item.serviceData?.image != null &&
//                                               item.serviceData!.image!.isNotEmpty
//                                               ? item.serviceData!.image! ?? ""
//                                               : "assets/newImages/noimagefound.png",
//                                           fit: BoxFit.cover,
//                                           placeholder: (context, url) => const Center(
//                                             child: CircularProgressIndicator(),
//                                           ),
//                                           errorWidget: (context, url, error) => Image.asset(
//                                             "assets/newImages/noimagefound.png", // Placeholder image
//                                             fit: BoxFit.cover,
//                                           ),
//                                           // Enable caching for faster loading
//                                           memCacheHeight: (height * 0.40).toInt(),
//                                           memCacheWidth: (width * 0.75).toInt(),
//                                           fadeInDuration: const Duration(milliseconds: 500),
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                   SizedBox(width: width * 0.05),
//                                   Column(
//                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                     children: [
//                                       Text(item.serviceData?.title ?? "Disease name"),
//                                       Text("ID- ##${item.id}"),
//                                       // Text(
//                                       // //  index % 2 == 0 ? "Accepted" : "Rejected",
//                                       //   item.status == 2 ? "Accepted" : item.status == 0 ? "Pending" : item.status == 1 ? "Rejected" : "No status",
//                                       //   style: TextStyle(
//                                       //     color: index % 2 == 0 ? Colors.green : Colors.red,
//                                       //   ),
//                                       // ),
//                                       Text(
//                                         item.status == "0"
//                                             ? "Pending"
//                                             : item.status == "1"
//                                             ? "Rejected"
//                                             : item.status == "2"
//                                             ? "visit"
//                                             : "Accepted",
//                                         style: TextStyle(
//                                           color: item.status == "1"
//                                               ? Colors.red
//                                               : item.status == "2"
//                                               ? Colors.blue[200]
//                                               : item.status == "3"
//                                               ? Colors.green
//                                               : Colors.purple[200],
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         );
//                       },
//                     );
//                   }
//                 }),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:dentocoreauth/utils/app_constant.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart' as myloader;

import '../../Utills/Utills.dart';
import '../../controllers/appoinment_detail_page.dart';
import '../../controllers/post_controller.dart';
import '../../models/slot_select_DTO.dart';
import '../../utils/component_screen.dart';
import '../../utils/mycolor.dart';
import '../appointment_details/appointment_details.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../models/slot_select_DTO.dart' as mySlotDTO;

class AppointmentList extends StatefulWidget {
  const AppointmentList({Key? key}) : super(key: key);

  @override
  State<AppointmentList> createState() => _AppointmentListState();
}

class _AppointmentListState extends State<AppointmentList> {
  final AppoinmentDetailPages appoinmentDetailController = Get.find();
  AppoinmentDetail? appointmentData;
  var userId = "";

  Future<void> fechDetailData() async {
    if (userId.isEmpty) {
      print("fechDetailData: User ID is empty, skipping API call");
      Get.snackbar("Error", "Please login to view Ascending order view appointments",
          backgroundColor: Colors.red, colorText: Colors.white);
      appoinmentDetailController.isLoading.value = false;
      return;
    }
    print("fechDetailData: Fetching details for userId: $userId");
    appointmentData = await appoinmentDetailController.getAppoinmentDetail(userId);
    setState(() {});
  }

  void getUserData(String key) async {
    final sp = await SharedPreferences.getInstance();
    setState(() {
      var user_data = sp.getStringList(key) ?? [];
      userId = user_data.isNotEmpty ? user_data[0].toString() : "";
      print("User ID Fetched: $userId");
    });
    await fechDetailData();
  }

  void matchetimesoletid() {}

  @override
  void initState() {
    super.initState();
    getUserData("user_data");
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
    print("Building AppointmentList, User ID: $userId");
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    // Define responsive dimensions as fractions of screen size
    final containerHeight = height * 0.06; // Adjusted from 0.05 for slightly better scaling
    final containerWidth = width * 0.28; // Adjusted from 0.26
    final imageSize = width * 0.15; // Adjusted from hardcoded 60
    final spacing = width * 0.04; // Adjusted from 0.05
    final fontSizeTitle = width * 0.039; // Responsive font size for title
    final fontSizeIdStatus = width * 0.039; // Responsive font size for ID and status

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: MyColor.primarycolor,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.light,
        systemNavigationBarColor: Colors.transparent,
      ),
      child: SafeArea(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomBooingAppBar(title: 'Appointment List'),
              SizedBox(height: height * 0.015), // Adjusted from 10 pixels
              Expanded(
                child: Obx(() {
                  if (appoinmentDetailController.isLoading.value) {
                    return Center(child: CircularProgressIndicator(color: Colors.blue));
                  } else {
                    myloader.EasyLoading.dismiss();
                    if (appointmentData == null ||
                        appointmentData!.body == null ||
                        appointmentData!.body!.isEmpty) {
                      return Center(child: Text("No appointments found"));
                    }
                    return ListView.builder(
                      itemCount: appointmentData!.body!.length,
                      itemBuilder: (c, index) {
                        var item = appointmentData!.body![index];
                        return InkWell(
                          onTap: () {
                            Get.to(AppointmentDetails(item));
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Divider(),
                              Row(
                                children: [
                                  Container(
                                    height: containerHeight,
                                    width: containerWidth,
                                    decoration: BoxDecoration(
                                      color: containerColors[index % containerColors.length],
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(width * 0.05),
                                        bottomRight: Radius.circular(width * 0.05),
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        item.date ?? "No Date",
                                        style: TextStyle(
                                          fontSize: fontSizeTitle,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: spacing),
                                  InkWell(
                                    onTap: () {
                                      // Get.to();
                                    },
                                    child: Container(
                                      height: imageSize,
                                      width: imageSize,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(width * 0.03),
                                        child: CachedNetworkImage(
                                          imageUrl: item.serviceData?.image != null &&
                                              item.serviceData!.image!.isNotEmpty
                                              ? item.serviceData!.image!
                                              : "assets/newImages/noimagefound.png",
                                          fit: BoxFit.cover,
                                          placeholder: (context, url) => const Center(
                                            child: CircularProgressIndicator(),
                                          ),
                                          errorWidget: (context, url, error) => Image.asset(
                                            "assets/newImages/noimagefound.png",
                                            fit: BoxFit.cover,
                                          ),
                                          memCacheHeight: (height * 0.15).toInt(), // Adjusted from 0.40
                                          memCacheWidth: (width * 0.25).toInt(), // Adjusted from 0.75
                                          fadeInDuration: const Duration(milliseconds: 500),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: spacing),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item.serviceData?.title ?? "Disease name",
                                        style: TextStyle(fontSize: fontSizeTitle,fontWeight: FontWeight.w500),
                                      ),
                                      Text(
                                        "ID- ##${item.id}",
                                        style: TextStyle(fontSize: fontSizeIdStatus,),
                                      ),
                                      // Text(
                                      //   item.status == "0"
                                      //       ? "Pending"
                                      //       : item.status == "1"
                                      //       ? "Rejected"
                                      //       : item.status == "2"
                                      //       ? "Visit"
                                      //       : item.status == "3"
                                      //       ? "Accepted"
                                      //       : item.status == "4"
                                      //       ? "Revisited"
                                      //       : "Reschedule"
                                      //   ,
                                      //   style: TextStyle(
                                      //     fontSize: fontSizeIdStatus,
                                      //     color: item.status == "1"
                                      //         ? Colors.red
                                      //         : item.status == "2"
                                      //         ? Colors.blue[200]
                                      //         : item.status == "3"
                                      //         ? Colors.green
                                      //         : Colors.purple[200],
                                      //   ),
                                      // ),
                                      Text(
                                        item.status == "0"
                                            ? "Pending"
                                            : item.status == "1"
                                            ? "Rejected"
                                            : item.status == "2"
                                            ? "Visit"
                                            : item.status == "3"
                                            ? "Accepted"
                                            : item.status == "4"
                                            ? "Revisited"
                                            : "Reschedule",
                                        style: TextStyle(
                                          fontSize: fontSizeIdStatus,
                                          color: item.status == "0"
                                              ? Colors.orange
                                              : item.status == "1"
                                              ? Colors.red
                                              : item.status == "2"
                                              ? Colors.blueAccent
                                              : item.status == "3"
                                              ? Colors.green
                                              : item.status == "4"
                                              ? Colors.purple
                                              : Colors.teal,
                                        ),
                                      ),

                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  }
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}