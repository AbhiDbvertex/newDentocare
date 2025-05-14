// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:dentocoreauth/utils/app_constant.dart';
//
// class AppointmentList extends StatefulWidget {
//   const AppointmentList({Key? key}) : super(key: key);
//
//   @override
//   State<AppointmentList> createState() => _AppointmentListState();
// }
//
// class _AppointmentListState extends State<AppointmentList> {
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Container(
//         margin: EdgeInsets.all(10),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Container(
//                   margin: EdgeInsets.only(left: 50,top: 20),
//                   child: CircleAvatar(
//                     radius: 22,
//                     backgroundColor: Colors.black,
//                     child: ClipOval(
//                       child: Image.asset(
//                         "assets/images/demologo.png",
//                         fit: BoxFit.cover,
//                         width: 40,
//                         height: 40,
//                       ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   width: 8,
//                 ),
//                 Container(
//                   margin: EdgeInsets.only(left: 0,top: 30),
//                   child: Center(
//                       child: Text(
//                     "Welcome - Ranu",
//                     style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
//                   )),
//                 )
//               ],
//             ),
//             SizedBox(
//               height: 10,
//             ),
//             Container(
//                 margin: EdgeInsets.only(left: 40),
//                 child: Text(
//                   "Appointment List",
//                   style: TextStyle(fontSize: 19, fontWeight: FontWeight.w300,color: Colors.blue),
//                 )),
//             SizedBox(
//               height: 10,
//             ),
//             Expanded(
//               child: ListView.builder(
//                 itemBuilder: (c, index) {
//                   return Container(
//                     margin: EdgeInsets.all(10),
//                     decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(20),
//                         color: Colors.blue.shade50),
//                     child: Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           Column(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text("Appro. ID-#204521",style: TextStyle(color: Colors.blue,fontWeight: FontWeight.w400,fontSize: 18),),
//                               SizedBox(
//                                 height: 2,
//                               ),
//                               Container(
//                                   width: 200,
//                                   child: Text(AppConstant.dummy_text,overflow: TextOverflow.ellipsis,maxLines: 3,style: TextStyle(color: Colors.grey),)),
//                               SizedBox(
//                                 height: 2,
//                               ),
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.start,
//                                 children: [
//                                   Icon(
//                                     Icons.more_time_outlined,
//                                     size: 20,
//                                   ),
//                                   SizedBox(
//                                     width: 4,
//                                   ),
//                                   Text("13 nov 2023 01:00AM",style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w300,fontSize: 15),)
//                                 ],
//                               )
//                             ],
//                           ),
//                           Column(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Container(
//                                 margin: EdgeInsets.only(left: 50),
//                                 child: CircleAvatar(
//                                   radius: 25,
//                                   backgroundColor: Colors.black,
//                                   child: ClipOval(
//                                     child: Image.asset(
//                                       "assets/images/stomach_ache.jpg",
//                                       fit: BoxFit.cover,
//                                       width: 50,
//                                       height: 50,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               SizedBox(
//                                 height: 10,
//                               ),
//                               Container(
//                                 margin: EdgeInsets.only(left: 40),
//
//                                   child: Text(
//                                     index%2==0? "Accepted":"Rejected",
//                                     style: TextStyle(
//                                         fontSize: 18, fontWeight: FontWeight.bold,color: index%2==0?Colors.green:Colors.red),
//                                   ),
//
//                               )
//                             ],
//                           )
//                         ],
//                       ),
//                     ),
//                   );
//                 },
//                 itemCount: 10,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
   // 2 tarkikh changes
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:dentocoreauth/utils/app_constant.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// import '../../controllers/appoinment_detail_page.dart';
// import '../../utils/component_screen.dart';
// import '../../utils/mycolor.dart';
// import '../appointment_details/appointment_details.dart';
//
// class AppointmentList extends StatefulWidget {
//   const AppointmentList({Key? key}) : super(key: key);
//
//   @override
//   State<AppointmentList> createState() => _AppointmentListState();
// }
//
// class _AppointmentListState extends State<AppointmentList> {
//
//   // final PostController postController = Get.put(PostController());
//    final AppoinmentDetailPages appoinmentDetailController = Get.put(AppoinmentDetailPages());
//    AppoinmentDetail? appointmentData;
//    Future<void> fechDetailData () async {
//      appointmentData = await appoinmentDetailController.getAppoinmentDetail();
//      setState(() {});
//    }
//
//    @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     getUserData("user_data");
//     fechDetailData();
//   }
//    var user_data = [];
//    var load_status = false;
//    // var userid = "";
//    void getUserData(String key) async {
//      final sp = await SharedPreferences.getInstance();
//      setState(() {
//        user_data = sp.getStringList(key) ?? [];
//        load_status = true;
//        appoinmentDetailController.userid = user_data.isNotEmpty ? user_data[0].toString() : "";
//      });
//    }
//
//
//    final List<Color> containerColors = [
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
//     print("Abhi:-print user id ${appoinmentDetailController.userid}");
//     final height = MediaQuery.of(context).size.height;
//     final width = MediaQuery.of(context).size.width;
//     return AnnotatedRegion<SystemUiOverlayStyle>(
//         value: SystemUiOverlayStyle(
//           statusBarColor: MyColor.primarycolor,
//           statusBarIconBrightness: Brightness.light,
//           statusBarBrightness: Brightness.light,
//           systemNavigationBarColor: Colors.transparent,
//         ),
//         child: SafeArea(
//       child: Container(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // CustomAppBar(
//             //   title: 'Appointment List',
//             // ),
//             CustomBooingAppBar(title: ' Appointment List',),
//             SizedBox(
//               height: 10,
//             ),
//
//              Expanded(
//               child: appointmentData == null ? Center(child: CircularProgressIndicator(color: Colors.blue,),): ListView.builder(
//                 itemCount: appointmentData?.body?.length ?? 0,
//                 itemBuilder: (c, index) {
//                   var item = appointmentData?.body?[index];
//                   return InkWell(
//                       onTap: () {
//                         Get.to(AppointmentDetails(item!));
//                       },
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Divider(),
//                           Row(
//                             children: [
//                               Container(
//                                 height: height * 0.05,
//                                 width: width * 0.24,
//                                 decoration: BoxDecoration(
//                                   color: containerColors[
//                                   index % containerColors.length],
//                                   borderRadius: BorderRadius.only(
//                                       topRight: Radius.circular(20),
//                                       bottomRight: Radius.circular(20)),
//                                 ),
//                                 child: Center(
//                                     child: Text(
//                                       // "25 Now",
//                                       item?.date ?? "no data",
//                                       style: TextStyle(
//                                           fontWeight: FontWeight.w600,
//                                           color: Colors.white),
//                                     )),
//                               ),
//                               SizedBox(width: width*0.05,),
//                               Container(
//                                 height: 60,
//                                 width: 60,
//                                 decoration: BoxDecoration(
//                                   image: DecorationImage(
//                                     image: item?.serviceData?.image != null
//                                         ? NetworkImage(item!.serviceData!.image!)
//                                         : AssetImage("assets/newImages/videofiledimage.png") as ImageProvider,
//                                     fit: BoxFit.cover,
//                                   ),
//                                   borderRadius: BorderRadius.circular(10), // optional
//                                 ),
//                               ),
//                               // Image.asset("assets/newImages/videofiledimage.png",scale: 4,),
//                               SizedBox(width: width*0.05,),
//                               Column(
//                                 children: [
//                                   Text(item?.serviceData?.title ?? "Disease name"),
//                                   Text("ID- ##202121"),
//                                   Text(index%2==0? "Accepted" : "Rejected",style: TextStyle(color: index%2 ==0 ? Colors.red :Colors.green),),
//                                 ],
//                               )
//                             ],
//                           ),
//                         ],
//                       ),
//                     );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     ));
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
      Get.snackbar("Error", "Please login to view appointments",
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
    // Fetch appointment data after userId is set
    await fechDetailData();
  }
  // final util = Utills();
  // var available_time_Slots = <SlotBody>[];
  // var noDoctorAvailable = false;
  // var all_slots = <String>[];
  // var _not_available_slots_index = <int>[];
  // var user_data = [];
  // var load_status = false;
  // var userid = "";
  // late var selectedIndex = 0;
  // final PostController postController = Get.put(PostController());
  // Future<mySlotDTO.SlotSelectDto?> getSlot(String date) async {
  //   util.startLoading();
  //   try {
  //     var res = await http.post(
  //       Uri.parse("${AppConstant.BASE_URL}/api/time_slot_get"),
  //       body: <String, String>{"date": date},
  //       headers: <String, String>{"x-api-key": "dentist@123"},
  //     );
  //     print("Response Time Slot: ${res.body}");
  //     if (res.statusCode == 200 || res.statusCode == 201) {
  //       util.stopLoading();
  //       final temp = jsonDecode(res.body.toString());
  //       if (temp["body"] == "Not Available doctor") {
  //         util.showSnackBar("Alert", "No doctor available", false);
  //         setState(() {
  //           available_time_Slots = [];
  //           all_slots = [];
  //           noDoctorAvailable = true;
  //           selectedIndex = 0;
  //           postController.time_slot_id = "";
  //           postController.seletecd_time_slot.value = "";
  //         });
  //         return null;
  //       } else {
  //         var result = mySlotDTO.slotSelectDtoFromJson(res.body);
  //         setState(() {
  //           noDoctorAvailable = false;
  //           available_time_Slots = result.body ?? [];
  //           all_slots = available_time_Slots.map((e) => e.timeSlot.toString()).toList();
  //           _not_available_slots_index = available_time_Slots
  //               .asMap()
  //               .entries
  //               .where((entry) => entry.value.id == null || entry.value.id.isEmpty)
  //               .map((entry) => entry.key)
  //               .toList();
  //           selectedIndex = 0;
  //           postController.time_slot_id = "";
  //           postController.seletecd_time_slot.value = "";
  //           print("Available Slots: $all_slots");
  //           print("Not Available Slots Index: $_not_available_slots_index");
  //         });
  //         return result;
  //       }
  //     } else {
  //       util.showSnackBar("Alert", "Something went wrong!", false);
  //       return null;
  //     }
  //   } catch (e) {
  //     util.showSnackBar("Error", "Failed to fetch slots: $e", false);
  //     return null;
  //   } finally {
  //     util.stopLoading();
  //   }
  // }

  void matchetimesoletid () {

  }

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
              CustomBooingAppBar(title: ' Appointment List'),
              SizedBox(height: 10),
              Expanded(
                child: Obx(() {
                  if (appoinmentDetailController.isLoading.value) {
                    myloader.EasyLoading.show(status: 'Loading...');
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
                                    height: height * 0.05,
                                    width: width * 0.26,
                                    decoration: BoxDecoration(
                                      color: containerColors[index % containerColors.length],
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(20),
                                        bottomRight: Radius.circular(20),
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        item.date ?? "No Date",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: width * 0.05),
                                  Container(
                                    height: 60,
                                    width: 60,
                                    /*decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: item.serviceData?.image != null
                                            ? NetworkImage(item.serviceData!.image!)
                                            : AssetImage("assets/newImages/videofiledimage.png")
                                        as ImageProvider,
                                        fit: BoxFit.cover,
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),*/
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: CachedNetworkImage(
                                        // Check if nextVisitHistory exists and has items
                                        imageUrl: item.serviceData?.image != null &&
                                            item.serviceData!.image!.isNotEmpty
                                            ? item.serviceData!.image! ?? ""
                                            : "assets/newImages/noimagefound.png",
                                        fit: BoxFit.cover,
                                        placeholder: (context, url) => const Center(
                                          child: CircularProgressIndicator(),
                                        ),
                                        errorWidget: (context, url, error) => Image.asset(
                                          "assets/newImages/noimagefound.png", // Placeholder image
                                          fit: BoxFit.cover,
                                        ),
                                        // Enable caching for faster loading
                                        memCacheHeight: (height * 0.40).toInt(),
                                        memCacheWidth: (width * 0.75).toInt(),
                                        fadeInDuration: const Duration(milliseconds: 500),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: width * 0.05),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(item.serviceData?.title ?? "Disease name"),
                                      Text("ID- ##${item.id}"),
                                      // Text(
                                      // //  index % 2 == 0 ? "Accepted" : "Rejected",
                                      //   item.status == 2 ? "Accepted" : item.status == 0 ? "Pending" : item.status == 1 ? "Rejected" : "No status",
                                      //   style: TextStyle(
                                      //     color: index % 2 == 0 ? Colors.green : Colors.red,
                                      //   ),
                                      // ),
                                      Text(
                                        item.status == "0"
                                            ? "Pending"
                                            : item.status == "1"
                                            ? "Rejected"
                                            : item.status == "2"
                                            ? "visit"
                                            : "Accepted",
                                        style: TextStyle(
                                          color: item.status == "1"
                                              ? Colors.red
                                              : item.status == "2"
                                              ? Colors.blue[200]
                                              : item.status == "3"
                                              ? Colors.green
                                              : Colors.purple[200],
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