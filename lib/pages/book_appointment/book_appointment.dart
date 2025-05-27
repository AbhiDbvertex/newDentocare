// import 'dart:convert';
// import 'dart:io';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;
// import 'package:table_calendar/table_calendar.dart';
// import '../../Utills/Utills.dart';
// import '../../controllers/post_controller.dart';
// import '../../controllers/services_controller.dart';
// import '../../controllers/video_controller.dart';
// import '../../models/slot_select_DTO.dart';
// import '../../utils/app_constant.dart';
// import '../../utils/component_screen.dart';
// import '../../utils/mycolor.dart';
// import '../../models/slot_select_DTO.dart' as mySlotDTO;
//
// class BookAppointment extends StatefulWidget {
//   const BookAppointment({Key? key}) : super(key: key);
//
//   @override
//   State<BookAppointment> createState() => _BookAppointmentState();
// }
//
// class _BookAppointmentState extends State<BookAppointment> {
//   final ImagePicker _picker = ImagePicker();
//   DateTime _focusedDay = DateTime.now();
//   final PostController postController = Get.put(PostController());
//   final util = Utills();
//   var available_time_Slots = <SlotBody>[];
//   var noDoctorAvailable = false;
//   var all_slots = <String>[];
//   var _not_available_slots_index = <int>[];
//   var user_data = [];
//   var load_status = false;
//   var userid = "";
//   late var selectedIndex = -1;
//
//   Future<void> _pickImage() async {
//     if (postController.uploadedImages.length >= 3) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("You can only upload a maximum of 3 images")),
//       );
//       return;
//     }
//     final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
//     if (image != null) {
//       setState(() {
//         postController.uploadedImages.add(File(image.path));
//         print("Image Added: ${image.path}");
//       });
//     }
//   }
//
//   void _removeImage(int index) {
//     setState(() {
//       postController.uploadedImages.removeAt(index);
//       print("Image Removed at index: $index");
//     });
//   }
//
//   Future<mySlotDTO.SlotSelectDto?> getSlot(String date) async {
//     util.startLoading();
//     try {
//       var res = await http.post(
//         Uri.parse("${AppConstant.BASE_URL}/api/time_slot_get"),
//         body: <String, String>{"date": date},
//         headers: <String, String>{"x-api-key": "dentist@123"},
//       );
//       print("Response Time Slot: ${res.body}");
//       if (res.statusCode == 200 || res.statusCode == 201) {
//         util.stopLoading();
//         final temp = jsonDecode(res.body.toString());
//         if (temp["body"] == "Not Available doctor") {
//           util.showSnackBar("Alert", "No doctor available", false);
//           setState(() {
//             available_time_Slots = [];
//             all_slots = [];
//             noDoctorAvailable = true;
//             selectedIndex = -1;
//             postController.time_slot_id = "";
//             postController.seletecd_time_slot.value = "";
//           });
//           return null;
//         } else {
//           var result = mySlotDTO.slotSelectDtoFromJson(res.body);
//           setState(() {
//             noDoctorAvailable = false;
//             available_time_Slots = result.body ?? [];
//             all_slots = available_time_Slots.map((e) => e.timeSlot.toString()).toList();
//             _not_available_slots_index = available_time_Slots
//                 .asMap()
//                 .entries
//                 .where((entry) => entry.value.id == null || entry.value.id.isEmpty)
//                 .map((entry) => entry.key)
//                 .toList();
//             selectedIndex = -1;
//             postController.time_slot_id = "";
//             postController.seletecd_time_slot.value = "";
//             print("Available Slots: $all_slots");
//             print("Not Available Slots Index: $_not_available_slots_index");
//           });
//           return result;
//         }
//       } else {
//         util.showSnackBar("Alert", "Something went wrong!", false);
//         return null;
//       }
//     } catch (e) {
//       util.showSnackBar("Error", "Failed to fetch slots: $e", false);
//       return null;
//     } finally {
//       util.stopLoading();
//     }
//   }
//
//   void getUserData(String key) async {
//     final sp = await SharedPreferences.getInstance();
//     setState(() {
//       user_data = sp.getStringList(key) ?? [];
//       load_status = true;
//       userid = user_data.isNotEmpty ? user_data[0].toString() : "";
//       print("User ID: $userid");
//     });
//   }
//
//   @override
//   void initState() {
//     print("Abhi:- print time slotid : ${available_time_Slots}");
//     super.initState();
//     getUserData("user_data");
//     fetchGalleryImages();
//   }
//
//   final VideoController videoController = Get.find();
//   final Servicescontroller servicescontroller = Get.find();
//   getgalleryimagess? imagesList;
//
//   void fetchGalleryImages() async {
//     imagesList = await servicescontroller.getImages();
//     setState(() {
//       print("Gallery Images: ${imagesList?.body?.map((item) => item.id).toList()}");
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final height = MediaQuery.of(context).size.height;
//     final width = MediaQuery.of(context).size.width;
//
//     return AnnotatedRegion<SystemUiOverlayStyle>(
//       value: SystemUiOverlayStyle(
//         statusBarColor: MyColor.primarycolor,
//         statusBarIconBrightness: Brightness.light,
//         statusBarBrightness: Brightness.light,
//         systemNavigationBarColor: Colors.blueAccent,
//       ),
//       child: Scaffold(
//         body: SafeArea(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               CustomAppBar(title: 'Appointment'),
//               SizedBox(height: height * 0.02),
//               Center(
//                 child: Text(
//                   "Select Diseases",
//                   style: TextStyle(
//                     color: Colors.black,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//               ),
//               SizedBox(height: height * 0.02),
//               Expanded(
//                 child: SingleChildScrollView(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       SizedBox(
//                         height: height * 0.20,
//                         child: imagesList == null
//                             ? Center(child: CircularProgressIndicator())
//                             : imagesList!.body == null || imagesList!.body!.isEmpty
//                             ? Center(child: Text("No diseases found"))
//                             : GridView.builder(
//                           gridDelegate:
//                           SliverGridDelegateWithFixedCrossAxisCount(
//                             crossAxisCount: 3,
//                             crossAxisSpacing: 2,
//                             mainAxisSpacing: 2,
//                             childAspectRatio: 1.2,
//                           ),
//                           itemCount: imagesList!.body!.length,
//                           itemBuilder: (context, index) {
//                             var item = imagesList!.body![index];
//                             return Container(
//                               margin: EdgeInsets.all(4),
//                               decoration: BoxDecoration(
//                                 border: Border.all(color: Colors.grey),
//                                 borderRadius: BorderRadius.circular(8),
//                               ),
//                               child: Stack(
//                                 children: [
//                                   Column(
//                                     children: [
//                                       Expanded(
//                                         child: ClipRRect(
//                                           borderRadius:
//                                           BorderRadius.vertical(
//                                               top: Radius.circular(8)),
//                                           child: item.image != null &&
//                                               item.image!.isNotEmpty
//                                               ? Image.network(
//                                             item.image!,
//                                             width: double.infinity,
//                                             fit: BoxFit.cover,
//                                             errorBuilder: (context,
//                                                 error,
//                                                 stackTrace) {
//                                               return Icon(
//                                                   Icons.error);
//                                             },
//                                           )
//                                               : Image.asset(
//                                             "assets/newImages/videofiledimage.png",
//                                             width:
//                                             double.infinity,
//                                             fit: BoxFit.cover,
//                                           ),
//                                         ),
//                                       ),
//                                       Container(
//                                         padding: EdgeInsets.symmetric(
//                                             vertical: 2, horizontal: 2),
//                                         alignment: Alignment.center,
//                                         child: Text(
//                                           item.title ?? "No Title",
//                                           style:
//                                           TextStyle(fontSize: 10),
//                                           textAlign: TextAlign.center,
//                                           overflow:
//                                           TextOverflow.ellipsis,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                   Positioned(
//                                     top: 0,
//                                     right: 0,
//                                     child: Checkbox(
//                                       value: postController
//                                           .selectedImageIds
//                                           .contains(item.id),
//                                       onChanged: (value) {
//                                         setState(() {
//                                           if (value == true) {
//                                             postController
//                                                 .selectedImageIds
//                                                 .add(item.id!);
//                                           } else {
//                                             postController
//                                                 .selectedImageIds
//                                                 .remove(item.id);
//                                           }
//                                           print(
//                                               "Selected Image IDs: ${postController.selectedImageIds}");
//                                         });
//                                       },
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             );
//                           },
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Container(
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(15),
//                             border: Border.all(color: Colors.grey),
//                           ),
//                           child: Column(
//                             children: [
//                               SizedBox(height: height * 0.02),
//                               Center(
//                                 child: Text(
//                                   "Select Date",
//                                   style: TextStyle(
//                                     fontWeight: FontWeight.w500,
//                                     fontSize: 17,
//                                   ),
//                                 ),
//                               ),
//                               TableCalendar(
//                                 firstDay: DateTime.now(),
//                                 lastDay: DateTime.utc(2030, 12, 31),
//                                 focusedDay: _focusedDay,
//                                 selectedDayPredicate: (day) =>
//                                     isSameDay(postController.selectedDay, day),
//                                 onDaySelected: (selectedDay, focusedDay) {
//                                   setState(() {
//                                     postController.selectedDay = selectedDay;
//                                     _focusedDay = focusedDay;
//                                     available_time_Slots = [];
//                                     all_slots = [];
//                                     selectedIndex = -1;
//                                     postController.time_slot_id = "";
//                                     postController.seletecd_time_slot.value = "";
//                                     print("Selected Day: $selectedDay");
//                                   });
//                                   String formattedDate =
//                                       "${selectedDay.year}-${selectedDay.month.toString().padLeft(2, '0')}-${selectedDay.day.toString().padLeft(2, '0')}";
//                                   getSlot(formattedDate);
//                                 },
//                                 calendarStyle: CalendarStyle(
//                                   selectedDecoration: BoxDecoration(
//                                     color: Colors.blue,
//                                     shape: BoxShape.circle,
//                                   ),
//                                   todayDecoration: BoxDecoration(
//                                     color: Colors.grey,
//                                     shape: BoxShape.circle,
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                       Center(
//                         child: Text(
//                           "Select Time Slot",
//                           style: TextStyle(
//                             fontWeight: FontWeight.w500,
//                             fontSize: 17,
//                             color: Colors.blue,
//                           ),
//                         ),
//                       ),
//                       SizedBox(height: height * 0.01),
//                       Container(
//                         decoration: BoxDecoration(color: Colors.blue[100]),
//                         child: Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Column(
//                             children: [
//                               if (available_time_Slots.isEmpty &&
//                                   !noDoctorAvailable)
//                                 Center(child: Text("Please select a date")),
//                               if (noDoctorAvailable)
//                                 Center(child: Text("No slots available")),
//                               if (available_time_Slots.isNotEmpty)
//                                 for (int i = 0;
//                                 i < available_time_Slots.length;
//                                 i += 3)
//                                   Padding(
//                                     padding: EdgeInsets.only(top: 10),
//                                     child: Row(
//                                       mainAxisAlignment:
//                                       MainAxisAlignment.spaceEvenly,
//                                       children: List.generate(3, (index) {
//                                         int actualIndex = i + index;
//                                         if (actualIndex >=
//                                             available_time_Slots.length)
//                                           return SizedBox();
//                                         return GestureDetector(
//                                           onTap: () {
//                                             setState(() {
//                                               selectedIndex = actualIndex;
//                                               if (_not_available_slots_index
//                                                   .contains(actualIndex)) {
//                                                 util.showSnackBar(
//                                                     "Alert",
//                                                     "This slot is not available",
//                                                     false);
//                                               } else {
//                                                 postController
//                                                     .seletecd_time_slot
//                                                     .value =
//                                                     available_time_Slots[
//                                                     actualIndex]
//                                                         .timeSlot
//                                                         .toString();
//                                                 postController.time_slot_id =
//                                                     available_time_Slots[
//                                                     actualIndex]
//                                                         .id;
//                                                 util.showSnackBar(
//                                                     "Success",
//                                                     "Slot ${available_time_Slots[actualIndex].timeSlot} selected",
//                                                     true);
//                                                 print(
//                                                     "Selected Time Slot ID: ${postController.time_slot_id}");
//                                               }
//                                             });
//                                           },
//                                           child: Container(
//                                             width: width * 0.3,
//                                             padding: EdgeInsets.all(8),
//                                             decoration: BoxDecoration(
//                                               color:
//                                               selectedIndex == actualIndex
//                                                   ? Colors.blue
//                                                   : Colors.white,
//                                               borderRadius:
//                                               BorderRadius.circular(13),
//                                               border: Border.all(
//                                                   color: Colors.blue),
//                                             ),
//                                             child: Center(
//                                               child: Text(
//                                                 "${available_time_Slots[actualIndex].timeSlot}",
//                                                 style: TextStyle(
//                                                   fontSize: 12,
//                                                   color: selectedIndex ==
//                                                       actualIndex
//                                                       ? Colors.white
//                                                       : Colors.black,
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                         );
//                                       }),
//                                     ),
//                                   ),
//                             ],
//                           ),
//                         ),
//                       ),
//                       SizedBox(height: height * 0.02),
//                       Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Column(
//                           children: [
//                             Center(
//                               child: Text(
//                                 "Describe Your Problem",
//                                 style: TextStyle(
//                                   color: Colors.blue,
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.w600,
//                                 ),
//                               ),
//                             ),
//                             SizedBox(height: height * 0.01),
//                             Padding(
//                               padding:
//                               const EdgeInsets.symmetric(horizontal: 16.0),
//                               child: TextField(
//                                 controller: postController.problem,
//                                 decoration: InputDecoration(
//                                   hintText: "Enter your problem description",
//                                   border: OutlineInputBorder(),
//                                 ),
//                                 maxLines: 3,
//                               ),
//                             ),
//                             SizedBox(height: height * 0.02),
//                             Center(
//                               child: Text(
//                                 "Upload Photo",
//                                 style: TextStyle(
//                                   color: Colors.blue,
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.w600,
//                                 ),
//                               ),
//                             ),
//                             SizedBox(height: height * 0.01),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 ...postController.uploadedImages
//                                     .asMap()
//                                     .entries
//                                     .map((entry) {
//                                   int index = entry.key;
//                                   File imageFile = entry.value;
//                                   return Padding(
//                                     padding: const EdgeInsets.all(8.0),
//                                     child: Stack(
//                                       children: [
//                                         Container(
//                                           width: 90,
//                                           height: 90,
//                                           decoration: BoxDecoration(
//                                             border:
//                                             Border.all(color: Colors.grey),
//                                           ),
//                                           child: Image.file(
//                                             imageFile,
//                                             fit: BoxFit.cover,
//                                           ),
//                                         ),
//                                         Positioned(
//                                           top: 0,
//                                           right: 0,
//                                           left: 60,
//                                           bottom: 70,
//                                           child: IconButton(
//                                             icon: Icon(Icons.delete,
//                                                 color: Colors.red),
//                                             onPressed: () => _removeImage(index),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   );
//                                 }).toList(),
//                                 if (postController.uploadedImages.length < 3)
//                                   GestureDetector(
//                                     onTap: _pickImage,
//                                     child: Container(
//                                       width: 100,
//                                       height: 100,
//                                       decoration: BoxDecoration(
//                                         color: Colors.blue[100],
//                                         border: Border.all(color: Colors.blue),
//                                         borderRadius: BorderRadius.circular(5),
//                                       ),
//                                       child: Center(
//                                         child: Icon(
//                                           Icons.add,
//                                           color: Colors.blue,
//                                           size: 40,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                       SizedBox(height: height * 0.02),
//                       Container(
//                         width: width * 0.6,
//                         decoration: BoxDecoration(
//                           color: MyColor.primarycolor,
//                           borderRadius: BorderRadius.circular(25),
//                         ),
//                         child: TextButton(
//                           onPressed: () {
//                             if (postController.validation()) {
//                               postController.postData(userid);
//                             }
//                           },
//                           child: Text(
//                             "Book",
//                             style: TextStyle(color: Colors.white),
//                           ),
//                         ),
//                       ),
//                       SizedBox(height: height * 0.1),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

/*
import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:table_calendar/table_calendar.dart';
import '../../Utills/Utills.dart';
import '../../controllers/post_controller.dart';
import '../../controllers/services_controller.dart';
import '../../controllers/video_controller.dart';
import '../../models/slot_select_DTO.dart';
import '../../utils/app_constant.dart';
import '../../utils/component_screen.dart';
import '../../utils/mycolor.dart';
import '../../models/slot_select_DTO.dart' as mySlotDTO;

class BookAppointment extends StatefulWidget {
  const BookAppointment({Key? key}) : super(key: key);

  @override
  State<BookAppointment> createState() => _BookAppointmentState();
}

class _BookAppointmentState extends State<BookAppointment> {
  final ImagePicker _picker = ImagePicker();
  DateTime _focusedDay = DateTime.now();
  final PostController postController = Get.put(PostController());
  final util = Utills();
  var available_time_Slots = <SlotBody>[];
  var noDoctorAvailable = false;
  var all_slots = <String>[];
  var _not_available_slots_index = <int>[];
  var user_data = [];
  var load_status = false;
  var userid = "";
  late var selectedIndex = -1;

  Future<void> _pickImage() async {
    if (postController.uploadedImages.length >= 3) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("You can only upload a maximum of 3 images")),
      );
      return;
    }
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        postController.uploadedImages.add(File(image.path));
        print("Image Added: ${image.path}");
      });
    }
  }

  void _removeImage(int index) {
    setState(() {
      postController.uploadedImages.removeAt(index);
      print("Image Removed at index: $index");
    });
  }

  Future<mySlotDTO.SlotSelectDto?> getSlot(String date) async {
    util.startLoading();
    try {
      var res = await http.post(
        Uri.parse("${AppConstant.BASE_URL}/api/time_slot_get"),
        body: <String, String>{"date": date},
        headers: <String, String>{"x-api-key": "dentist@123"},
      );
      print("Response Time Slot: ${res.body}");
      if (res.statusCode == 200 || res.statusCode == 201) {
        util.stopLoading();
        final temp = jsonDecode(res.body.toString());
        if (temp["body"] == "Not Available doctor") {
          util.showSnackBar("Alert", "No doctor available", false);
          setState(() {
            available_time_Slots = [];
            all_slots = [];
            noDoctorAvailable = true;
            selectedIndex = -1;
            postController.time_slot_id = "";
            postController.seletecd_time_slot.value = "";
          });
          return null;
        } else {
          var result = mySlotDTO.slotSelectDtoFromJson(res.body);
          setState(() {
            noDoctorAvailable = false;
            available_time_Slots = result.body ?? [];
            all_slots = available_time_Slots.map((e) => e.timeSlot.toString()).toList();
            _not_available_slots_index = available_time_Slots
                .asMap()
                .entries
                .where((entry) => entry.value.id == null || entry.value.id.isEmpty)
                .map((entry) => entry.key)
                .toList();
            selectedIndex = -1;
            postController.time_slot_id = "";
            postController.seletecd_time_slot.value = "";
            print("Available Slots: $all_slots");
            print("Not Available Slots Index: $_not_available_slots_index");
          });
          return result;
        }
      } else {
        util.showSnackBar("Alert", "Something went wrong!", false);
        return null;
      }
    } catch (e) {
      util.showSnackBar("Error", "Failed to fetch slots: $e", false);
      return null;
    } finally {
      util.stopLoading();
    }
  }

  void getUserData(String key) async {
    final sp = await SharedPreferences.getInstance();
    setState(() {
      user_data = sp.getStringList(key) ?? [];
      load_status = true;
      userid = user_data.isNotEmpty ? user_data[0].toString() : "";
      print("User ID: $userid");
    });
  }

  @override
  void initState() {
    print("Abhi:- print time slotid : ${available_time_Slots}");
    super.initState();
    getUserData("user_data");
    fetchGalleryImages();
  }

  final VideoController videoController = Get.find();
  final Servicescontroller servicescontroller = Get.find();
  getgalleryimagess? imagesList;

  void fetchGalleryImages() async {
    imagesList = await servicescontroller.getImages();
    setState(() {
      print("Gallery Images: ${imagesList?.body?.map((item) => item.id).toList()}");
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: MyColor.primarycolor,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.light,
        systemNavigationBarColor: Colors.blueAccent,
      ),
      child: Scaffold(
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomAppBar(title: 'Appointment'),
              SizedBox(height: height * 0.02),
              Center(
                child: Text(
                  "Select Diseases",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(height: height * 0.02),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: height * 0.20,
                        child: imagesList == null
                            ? Center(child: CircularProgressIndicator())
                            : imagesList!.body == null || imagesList!.body!.isEmpty
                            ? Center(child: Text("No diseases found"))
                            : GridView.builder(
                          gridDelegate:
                          SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 2,
                            mainAxisSpacing: 2,
                            childAspectRatio: 1.2,
                          ),
                          itemCount: imagesList!.body!.length,
                          itemBuilder: (context, index) {
                            var item = imagesList!.body![index];
                            return Container(
                              margin: EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Stack(
                                children: [
                                  Column(
                                    children: [
                                      Expanded(
                                        child: ClipRRect(
                                          borderRadius:
                                          BorderRadius.vertical(
                                              top: Radius.circular(8)),
                                          child: item.image != null &&
                                              item.image!.isNotEmpty
                                              ? Image.network(
                                            item.image!,
                                            width: double.infinity,
                                            fit: BoxFit.cover,
                                            errorBuilder: (context,
                                                error,
                                                stackTrace) {
                                              return Icon(
                                                  Icons.error);
                                            },
                                          )
                                              : Image.asset(
                                            "assets/newImages/videofiledimage.png",
                                            width:
                                            double.infinity,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 2, horizontal: 2),
                                        alignment: Alignment.center,
                                        child: Text(
                                          item.title ?? "No Title",
                                          style:
                                          TextStyle(fontSize: 10),
                                          textAlign: TextAlign.center,
                                          overflow:
                                          TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Positioned(
                                    top: 0,
                                    right: 0,
                                    child: Checkbox(
                                      value: postController
                                          .selectedImageIds
                                          .contains(item.id),
                                      onChanged: (value) {
                                        setState(() {
                                          if (value == true) {
                                            postController
                                                .selectedImageIds
                                                .add(item.id!);
                                          } else {
                                            postController
                                                .selectedImageIds
                                                .remove(item.id);
                                          }
                                          print(
                                              "Selected Image IDs: ${postController.selectedImageIds}");
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: Colors.grey),
                          ),
                          child: Column(
                            children: [
                              SizedBox(height: height * 0.02),
                              Center(
                                child: Text(
                                  "Select Date",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 17,
                                  ),
                                ),
                              ),
                              TableCalendar(
                                firstDay: DateTime.now(),
                                lastDay: DateTime.utc(2030, 12, 31),
                                focusedDay: _focusedDay,
                                selectedDayPredicate: (day) =>
                                    isSameDay(postController.selectedDay, day),
                                onDaySelected: (selectedDay, focusedDay) {
                                  setState(() {
                                    postController.selectedDay = selectedDay;
                                    _focusedDay = focusedDay;
                                    available_time_Slots = [];
                                    all_slots = [];
                                    selectedIndex = -1;
                                    postController.time_slot_id = "";
                                    postController.seletecd_time_slot.value = "";
                                    print("Selected Day: $selectedDay");
                                  });
                                  String formattedDate =
                                      "${selectedDay.year}-${selectedDay.month.toString().padLeft(2, '0')}-${selectedDay.day.toString().padLeft(2, '0')}";
                                  getSlot(formattedDate);
                                },
                                calendarStyle: CalendarStyle(
                                  selectedDecoration: BoxDecoration(
                                    color: Colors.blue,
                                    shape: BoxShape.circle,
                                  ),
                                  todayDecoration: BoxDecoration(
                                    color: Colors.grey,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Center(
                        child: Text(
                          "Select Time Slot",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 17,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                      SizedBox(height: height * 0.01),
                      Container(
                        decoration: BoxDecoration(color: Colors.blue[100]),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              if (available_time_Slots.isEmpty &&
                                  !noDoctorAvailable)
                                Center(child: Text("Please select a date")),
                              if (noDoctorAvailable)
                                Center(child: Text("No slots available")),
                              if (available_time_Slots.isNotEmpty)
                                for (int i = 0;
                                i < available_time_Slots.length;
                                i += 3)
                                  Padding(
                                    padding: EdgeInsets.only(top: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                      children: List.generate(3, (index) {
                                        int actualIndex = i + index;
                                        if (actualIndex >=
                                            available_time_Slots.length)
                                          return SizedBox();
                                        return GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              selectedIndex = actualIndex;
                                              if (_not_available_slots_index
                                                  .contains(actualIndex)) {
                                                util.showSnackBar(
                                                    "Alert",
                                                    "This slot is not available",
                                                    false);
                                              } else {
                                                postController
                                                    .seletecd_time_slot
                                                    .value =
                                                    available_time_Slots[
                                                    actualIndex]
                                                        .timeSlot
                                                        .toString();
                                                postController.time_slot_id =
                                                    available_time_Slots[
                                                    actualIndex]
                                                        .id;
                                                util.showSnackBar(
                                                    "Success",
                                                    "Slot ${available_time_Slots[actualIndex].timeSlot} selected",
                                                    true);
                                                print(
                                                    "Selected Time Slot ID: ${postController.time_slot_id}");
                                              }
                                            });
                                          },
                                          child: Container(
                                            width: width * 0.3,
                                            padding: EdgeInsets.all(8),
                                            decoration: BoxDecoration(
                                              color:
                                              selectedIndex == actualIndex
                                                  ? Colors.blue
                                                  : Colors.white,
                                              borderRadius:
                                              BorderRadius.circular(13),
                                              border: Border.all(
                                                  color: Colors.blue),
                                            ),
                                            child: Center(
                                              child: Text(
                                                "${available_time_Slots[actualIndex].timeSlot}",
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: selectedIndex ==
                                                      actualIndex
                                                      ? Colors.white
                                                      : Colors.black,
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      }),
                                    ),
                                  ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: height * 0.02),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Center(
                              child: Text(
                                "Describe Your Problem",
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            SizedBox(height: height * 0.01),
                            Padding(
                              padding:
                              const EdgeInsets.symmetric(horizontal: 16.0),
                              child: TextField(
                                controller: postController.problem,
                                decoration: InputDecoration(
                                  hintText: "Enter your problem description",
                                  border: OutlineInputBorder(),
                                ),
                                maxLines: 3,
                              ),
                            ),
                            SizedBox(height: height * 0.02),
                            Center(
                              child: Text(
                                "Upload Photo",
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            SizedBox(height: height * 0.01),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ...postController.uploadedImages
                                    .asMap()
                                    .entries
                                    .map((entry) {
                                  int index = entry.key;
                                  File imageFile = entry.value;
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Stack(
                                      children: [
                                        Container(
                                          width: 90,
                                          height: 90,
                                          decoration: BoxDecoration(
                                            border:
                                            Border.all(color: Colors.grey),
                                          ),
                                          child: Image.file(
                                            imageFile,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        Positioned(
                                          top: 0,
                                          right: 0,
                                          left: 60,
                                          bottom: 70,
                                          child: IconButton(
                                            icon: Icon(Icons.delete,
                                                color: Colors.red),
                                            onPressed: () => _removeImage(index),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }).toList(),
                                if (postController.uploadedImages.length < 3)
                                  GestureDetector(
                                    onTap: _pickImage,
                                    child: Container(
                                      width: 100,
                                      height: 100,
                                      decoration: BoxDecoration(
                                        color: Colors.blue[100],
                                        border: Border.all(color: Colors.blue),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Center(
                                        child: Icon(
                                          Icons.add,
                                          color: Colors.blue,
                                          size: 40,
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: height * 0.02),
                      Container(
                        width: width * 0.6,
                        decoration: BoxDecoration(
                          color: MyColor.primarycolor,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: TextButton(
                          onPressed: () {
                            if (postController.validation()) {
                              postController.postData(userid);
                            }
                          },
                          child: Text(
                            "Book",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(height: height * 0.1),
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
}*/
                ///        this code is currct code
// import 'dart:convert';
// import 'dart:io';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;
// import 'package:table_calendar/table_calendar.dart';
// import '../../Utills/Utills.dart';
// import '../../controllers/post_controller.dart';
// import '../../controllers/services_controller.dart';
// import '../../controllers/video_controller.dart';
// import '../../models/slot_select_DTO.dart';
// import '../../utils/app_constant.dart';
// import '../../utils/component_screen.dart';
// import '../../utils/mycolor.dart';
// import '../../models/slot_select_DTO.dart' as mySlotDTO;
//
// class BookAppointment extends StatefulWidget {
//   const BookAppointment({Key? key}) : super(key: key);
//
//   @override
//   State<BookAppointment> createState() => _BookAppointmentState();
// }
//
// class _BookAppointmentState extends State<BookAppointment> {
//   final ImagePicker _picker = ImagePicker();
//   DateTime _focusedDay = DateTime.now();
//   final PostController postController = Get.put(PostController());
//   final util = Utills();
//   var available_time_Slots = <SlotBody>[];
//   var noDoctorAvailable = false;
//   var all_slots = <String>[];
//   var _not_available_slots_index = <int>[];
//   var user_data = [];
//   var load_status = false;
//   var userid = "";
//   late var selectedIndex = -1;
//
//   Future<void> _pickImage() async {
//     if (postController.uploadedImages.length >= 3) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("You can only upload a maximum of 3 images")),
//       );
//       return;
//     }
//     final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
//     if (image != null) {
//       setState(() {
//         postController.uploadedImages.add(File(image.path));
//         print("Image Added: ${image.path}");
//       });
//     }
//   }
//
//   void _removeImage(int index) {
//     setState(() {
//       postController.uploadedImages.removeAt(index);
//       print("Image Removed at index: $index");
//     });
//   }
//
//   Future<mySlotDTO.SlotSelectDto?> getSlot(String date) async {
//     util.startLoading();
//     try {
//       var res = await http.post(
//         Uri.parse("${AppConstant.BASE_URL}/api/time_slot_get"),
//         body: <String, String>{"date": date},
//         headers: <String, String>{"x-api-key": "dentist@123"},
//       );
//       print("Response Time Slot: ${res.body}");
//       if (res.statusCode == 200 || res.statusCode == 201) {
//         util.stopLoading();
//         final temp = jsonDecode(res.body.toString());
//         if (temp["body"] == "Not Available doctor") {
//           util.showSnackBar("Alert", "No doctor available", false);
//           setState(() {
//             available_time_Slots = [];
//             all_slots = [];
//             noDoctorAvailable = true;
//             selectedIndex = -1;
//             postController.time_slot_id = "";
//             postController.seletecd_time_slot.value = "";
//           });
//           return null;
//         } else {
//           var result = mySlotDTO.slotSelectDtoFromJson(res.body);
//           // Current time aur 30-minute window check
//           DateTime now = DateTime.now();
//           DateTime thirtyMinutesLater = now.add(Duration(minutes: 30));
//           print("Current Time: $now");
//           print("30 Minutes Later: $thirtyMinutesLater");
//           print("Selected Date: $date");
//
//           setState(() {
//             noDoctorAvailable = false;
//             available_time_Slots = result.body ?? [];
//             all_slots = available_time_Slots.map((e) => e.timeSlot.toString()).toList();
//             _not_available_slots_index = [];
//
//             // Regular expression to validate HH:mm AM/PM - HH:mm AM/PM format
//             RegExp timeFormat = RegExp(r'^\d{1,2}:\d{2}\s[AP]M\s-\s\d{1,2}:\d{2}\s[AP]M$');
//
//             // Check for slots within 30 minutes from current time
//             for (int i = 0; i < available_time_Slots.length; i++) {
//               // Check if slot ID is null or empty
//               if (available_time_Slots[i].id == null || available_time_Slots[i].id.isEmpty) {
//                 _not_available_slots_index.add(i);
//                 print("Slot $i is unavailable (null or empty ID): ${available_time_Slots[i].timeSlot}");
//                 continue;
//               }
//
//               // Check if timeSlot string is valid
//               String timeSlot = available_time_Slots[i].timeSlot.toString();
//               if (!timeFormat.hasMatch(timeSlot)) {
//                 _not_available_slots_index.add(i);
//                 print("Slot $i is unavailable (invalid time format): $timeSlot");
//                 continue;
//               }
//
//               // Parse the start time of the slot (e.g., "05:00 PM" from "05:00 PM - 05:30 PM")
//               try {
//                 print("Parsing Time Slot: $timeSlot");
//                 String startTime = timeSlot.split(' - ')[0]; // Get "05:00 PM"
//                 List<String> timeParts = startTime.split(':');
//                 int hour = int.parse(timeParts[0]);
//                 int minute = int.parse(timeParts[1].split(' ')[0]);
//                 String amPm = timeParts[1].split(' ')[1]; // Get "AM" or "PM"
//
//                 // Convert 12-hour format to 24-hour format
//                 if (amPm == 'PM' && hour != 12) {
//                   hour += 12;
//                 } else if (amPm == 'AM' && hour == 12) {
//                   hour = 0;
//                 }
//
//                 // Validate hour and minute ranges
//                 if (hour < 0 || hour > 23 || minute < 0 || minute > 59) {
//                   _not_available_slots_index.add(i);
//                   print("Slot $i is unavailable (invalid hour/minute): $timeSlot");
//                   continue;
//                 }
//
//                 // Create DateTime object for the slot with the selected date
//                 List<String> dateParts = date.split('-');
//                 DateTime slotDateTime = DateTime(
//                   int.parse(dateParts[0]), // Year
//                   int.parse(dateParts[1]), // Month
//                   int.parse(dateParts[2]), // Day
//                   hour,
//                   minute,
//                 );
//
//                 print("Slot DateTime: $slotDateTime");
//
//                 // Check if selected date is today
//                 bool isToday = slotDateTime.day == now.day &&
//                     slotDateTime.month == now.month &&
//                     slotDateTime.year == now.year;
//
//                 // If the slot is within 30 minutes from now and it's today, mark it as unavailable
//                 if (isToday && slotDateTime.isBefore(thirtyMinutesLater)) {
//                   _not_available_slots_index.add(i);
//                   print("Slot $i is unavailable (within 30 minutes): $timeSlot");
//                 } else {
//                   print("Slot $i is available: $timeSlot");
//                 }
//               } catch (e) {
//                 print("Error parsing time slot at index $i: $e");
//                 _not_available_slots_index.add(i); // Mark as unavailable if parsing fails
//               }
//             }
//
//             selectedIndex = -1;
//             postController.time_slot_id = "";
//             postController.seletecd_time_slot.value = "";
//             print("Available Slots: $all_slots");
//             print("Not Available Slots Index: $_not_available_slots_index");
//           });
//           return result;
//         }
//       } else {
//         util.showSnackBar("Alert", "Something went wrong!", false);
//         return null;
//       }
//     } catch (e) {
//       util.showSnackBar("Error", "Failed to fetch slots: $e", false);
//       return null;
//     } finally {
//       util.stopLoading();
//     }
//   }
//   void getUserData(String key) async {
//     final sp = await SharedPreferences.getInstance();
//     setState(() {
//       user_data = sp.getStringList(key) ?? [];
//       load_status = true;
//       userid = user_data.isNotEmpty ? user_data[0].toString() : "";
//       print("User ID: $userid");
//     });
//   }
//
//   @override
//   void initState() {
//     print("Abhi:- print time slotid : ${available_time_Slots}");
//     super.initState();
//     getUserData("user_data");
//     fetchGalleryImages();
//   }
//
//   final VideoController videoController = Get.find();
//   final Servicescontroller servicescontroller = Get.find();
//   getgalleryimagess? imagesList;
//
//   void fetchGalleryImages() async {
//     imagesList = await servicescontroller.getImages();
//     setState(() {
//       print("Gallery Images: ${imagesList?.body?.map((item) => item.id).toList()}");
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final height = MediaQuery.of(context).size.height;
//     final width = MediaQuery.of(context).size.width;
//
//     return AnnotatedRegion<SystemUiOverlayStyle>(
//       value: SystemUiOverlayStyle(
//         statusBarColor: MyColor.primarycolor,
//         statusBarIconBrightness: Brightness.light,
//         statusBarBrightness: Brightness.light,
//         systemNavigationBarColor: Colors.blueAccent,
//       ),
//       child: Scaffold(
//         body: SafeArea(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               CustomAppBar(title: 'Appointment'),
//               SizedBox(height: height * 0.02),
//               Center(
//                 child: Text(
//                   "Select Diseases",
//                   style: TextStyle(
//                     color: Colors.black,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//               ),
//               SizedBox(height: height * 0.02),
//               Expanded(
//                 child: SingleChildScrollView(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       SizedBox(
//                         height: height * 0.20,
//                         child: imagesList == null
//                             ? Center(child: CircularProgressIndicator())
//                             : imagesList!.body == null || imagesList!.body!.isEmpty
//                             ? Center(child: Text("No diseases found"))
//                             : GridView.builder(
//                           gridDelegate:
//                           SliverGridDelegateWithFixedCrossAxisCount(
//                             crossAxisCount: 3,
//                             crossAxisSpacing: 2,
//                             mainAxisSpacing: 2,
//                             childAspectRatio: 1.2,
//                           ),
//                           itemCount: imagesList!.body!.length,
//                           itemBuilder: (context, index) {
//                             var item = imagesList!.body![index];
//                             return Container(
//                               margin: EdgeInsets.all(4),
//                               decoration: BoxDecoration(
//                                 border: Border.all(color: Colors.grey),
//                                 borderRadius: BorderRadius.circular(8),
//                               ),
//                               child: Stack(
//                                 children: [
//                                   Column(
//                                     children: [
//                                       Expanded(
//                                         child: ClipRRect(
//                                           borderRadius:
//                                           BorderRadius.vertical(
//                                               top: Radius.circular(8)),
//                                           child: item.image != null &&
//                                               item.image!.isNotEmpty
//                                               ? Image.network(
//                                             item.image!,
//                                             width: double.infinity,
//                                             fit: BoxFit.cover,
//                                             errorBuilder: (context,
//                                                 error,
//                                                 stackTrace) {
//                                               return Icon(
//                                                   Icons.error);
//                                             },
//                                           )
//                                               : Image.asset(
//                                             "assets/newImages/videofiledimage.png",
//                                             width:
//                                             double.infinity,
//                                             fit: BoxFit.cover,
//                                           ),
//                                         ),
//                                       ),
//                                       Container(
//                                         padding: EdgeInsets.symmetric(
//                                             vertical: 2, horizontal: 2),
//                                         alignment: Alignment.center,
//                                         child: Text(
//                                           item.title ?? "No Title",
//                                           style:
//                                           TextStyle(fontSize: 10),
//                                           textAlign: TextAlign.center,
//                                           overflow:
//                                           TextOverflow.ellipsis,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                   Positioned(
//                                     top: 0,
//                                     right: 0,
//                                     child: Checkbox(
//                                       value: postController
//                                           .selectedImageIds
//                                           .contains(item.id),
//                                       onChanged: (value) {
//                                         setState(() {
//                                           if (value == true) {
//                                             postController
//                                                 .selectedImageIds
//                                                 .add(item.id!);
//                                           } else {
//                                             postController
//                                                 .selectedImageIds
//                                                 .remove(item.id);
//                                           }
//                                           print(
//                                               "Selected Image IDs: ${postController.selectedImageIds}");
//                                         });
//                                       },
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             );
//                           },
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Container(
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(15),
//                             border: Border.all(color: Colors.grey),
//                           ),
//                           child: Column(
//                             children: [
//                               SizedBox(height: height * 0.02),
//                               Center(
//                                 child: Text(
//                                   "Select Date",
//                                   style: TextStyle(
//                                     fontWeight: FontWeight.w500,
//                                     fontSize: 17,
//                                   ),
//                                 ),
//                               ),
//                               TableCalendar(
//                                 firstDay: DateTime.now(),
//                                 lastDay: DateTime.utc(2030, 12, 31),
//                                 focusedDay: _focusedDay,
//                                 selectedDayPredicate: (day) =>
//                                     isSameDay(postController.selectedDay, day),
//                                 onDaySelected: (selectedDay, focusedDay) {
//                                   setState(() {
//                                     postController.selectedDay = selectedDay;
//                                     _focusedDay = focusedDay;
//                                     available_time_Slots = [];
//                                     all_slots = [];
//                                     selectedIndex = -1;
//                                     postController.time_slot_id = "";
//                                     postController.seletecd_time_slot.value = "";
//                                     print("Selected Day: $selectedDay");
//                                   });
//                                   String formattedDate =
//                                       "${selectedDay.year}-${selectedDay.month.toString().padLeft(2, '0')}-${selectedDay.day.toString().padLeft(2, '0')}";
//                                   getSlot(formattedDate);
//                                 },
//                                 calendarStyle: CalendarStyle(
//                                   selectedDecoration: BoxDecoration(
//                                     color: Colors.blue,
//                                     shape: BoxShape.circle,
//                                   ),
//                                   todayDecoration: BoxDecoration(
//                                     color: Colors.grey,
//                                     shape: BoxShape.circle,
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                       Center(
//                         child: Text(
//                           "Select Time Slot",
//                           style: TextStyle(
//                             fontWeight: FontWeight.w500,
//                             fontSize: 17,
//                             color: Colors.blue,
//                           ),
//                         ),
//                       ),
//                       SizedBox(height: height * 0.01),
//                       Container(
//                         decoration: BoxDecoration(color: Colors.blue[100]),
//                         child: Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Column(
//                             children: [
//                               if (available_time_Slots.isEmpty &&
//                                   !noDoctorAvailable)
//                                 Center(child: Text("Please select a date")),
//                               if (noDoctorAvailable)
//                                 Center(child: Text("No slots available")),
//                               if (available_time_Slots.isNotEmpty)
//                                 for (int i = 0;
//                                 i < available_time_Slots.length;
//                                 i += 3)
//                                   Padding(
//                                     padding: EdgeInsets.only(top: 10),
//                                     child: Row(
//                                       mainAxisAlignment:
//                                       MainAxisAlignment.spaceEvenly,
//                                       children: List.generate(3, (index) {
//                                         int actualIndex = i + index;
//                                         if (actualIndex >=
//                                             available_time_Slots.length)
//                                           return SizedBox();
//                                         return GestureDetector(
//                                           onTap: () {
//                                             setState(() {
//                                               selectedIndex = actualIndex;
//                                               if (_not_available_slots_index
//                                                   .contains(actualIndex)) {
//                                                 util.showSnackBar(
//                                                     "Alert",
//                                                     "This slot is not available",
//                                                     false);
//                                               } else {
//                                                 postController
//                                                     .seletecd_time_slot
//                                                     .value =
//                                                     available_time_Slots[
//                                                     actualIndex]
//                                                         .timeSlot
//                                                         .toString();
//                                                 postController.time_slot_id =
//                                                     available_time_Slots[
//                                                     actualIndex]
//                                                         .id;
//                                                 util.showSnackBar(
//                                                     "Success",
//                                                     "Slot ${available_time_Slots[actualIndex].timeSlot} selected",
//                                                     true);
//                                                 print(
//                                                     "Selected Time Slot ID: ${postController.time_slot_id}");
//                                               }
//                                             });
//                                           },
//                                           child: Container(
//                                             width: width * 0.3,
//                                             padding: EdgeInsets.all(8),
//                                             decoration: BoxDecoration(
//                                               color:
//                                               selectedIndex == actualIndex
//                                                   ? Colors.blue
//                                                   : Colors.white,
//                                               borderRadius:
//                                               BorderRadius.circular(13),
//                                               border: Border.all(
//                                                   color: Colors.blue),
//                                             ),
//                                             child: Center(
//                                               child: Text(
//                                                 "${available_time_Slots[actualIndex].timeSlot}",
//                                                 style: TextStyle(
//                                                   fontSize: 12,
//                                                   color: selectedIndex ==
//                                                       actualIndex
//                                                       ? Colors.white
//                                                       : Colors.black,
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                         );
//                                       }),
//                                     ),
//                                   ),
//                             ],
//                           ),
//                         ),
//                       ),
//                       SizedBox(height: height * 0.02),
//                       Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Column(
//                           children: [
//                             Center(
//                               child: Text(
//                                 "Describe Your Problem",
//                                 style: TextStyle(
//                                   color: Colors.blue,
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.w600,
//                                 ),
//                               ),
//                             ),
//                             SizedBox(height: height * 0.01),
//                             Padding(
//                               padding:
//                               const EdgeInsets.symmetric(horizontal: 16.0),
//                               child: TextField(
//                                 controller: postController.problem,
//                                 decoration: InputDecoration(
//                                   hintText: "Enter your problem description",
//                                   border: OutlineInputBorder(),
//                                 ),
//                                 maxLines: 3,
//                               ),
//                             ),
//                             SizedBox(height: height * 0.02),
//                             Center(
//                               child: Text(
//                                 "Upload Photo",
//                                 style: TextStyle(
//                                   color: Colors.blue,
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.w600,
//                                 ),
//                               ),
//                             ),
//                             SizedBox(height: height * 0.01),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 ...postController.uploadedImages
//                                     .asMap()
//                                     .entries
//                                     .map((entry) {
//                                   int index = entry.key;
//                                   File imageFile = entry.value;
//                                   return Padding(
//                                     padding: const EdgeInsets.all(8.0),
//                                     child: Stack(
//                                       children: [
//                                         Container(
//                                           width: 90,
//                                           height: 90,
//                                           decoration: BoxDecoration(
//                                             border:
//                                             Border.all(color: Colors.grey),
//                                           ),
//                                           child: Image.file(
//                                             imageFile,
//                                             fit: BoxFit.cover,
//                                           ),
//                                         ),
//                                         Positioned(
//                                           top: 0,
//                                           right: 0,
//                                           left: 60,
//                                           bottom: 70,
//                                           child: IconButton(
//                                             icon: Icon(Icons.delete,
//                                                 color: Colors.red),
//                                             onPressed: () => _removeImage(index),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   );
//                                 }).toList(),
//                                 if (postController.uploadedImages.length < 3)
//                                   GestureDetector(
//                                     onTap: _pickImage,
//                                     child: Container(
//                                       width: 100,
//                                       height: 100,
//                                       decoration: BoxDecoration(
//                                         color: Colors.blue[100],
//                                         border: Border.all(color: Colors.blue),
//                                         borderRadius: BorderRadius.circular(5),
//                                       ),
//                                       child: Center(
//                                         child: Icon(
//                                           Icons.add,
//                                           color: Colors.blue,
//                                           size: 40,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                       SizedBox(height: height * 0.02),
//                       Container(
//                         width: width * 0.6,
//                         decoration: BoxDecoration(
//                           color: MyColor.primarycolor,
//                           borderRadius: BorderRadius.circular(25),
//                         ),
//                         child: TextButton(
//                           onPressed: () {
//                             if (postController.validation()) {
//                               postController.postData(userid);
//                             }
//                           },
//                           child: Text(
//                             "Book",
//                             style: TextStyle(color: Colors.white),
//                           ),
//                         ),
//                       ),
//                       SizedBox(height: height * 0.1),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
///

import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:table_calendar/table_calendar.dart';
import '../../Utills/Utills.dart';
import '../../controllers/post_controller.dart';
import '../../controllers/services_controller.dart';
import '../../controllers/video_controller.dart';
import '../../models/slot_select_DTO.dart';
import '../../utils/app_constant.dart';
import '../../utils/component_screen.dart';
import '../../utils/mycolor.dart';
import '../../models/slot_select_DTO.dart' as mySlotDTO;

class BookAppointment extends StatefulWidget {
  const BookAppointment({Key? key}) : super(key: key);

  @override
  State<BookAppointment> createState() => _BookAppointmentState();
}

class _BookAppointmentState extends State<BookAppointment> {
  final ImagePicker _picker = ImagePicker();
  DateTime _focusedDay = DateTime.now();
  final PostController postController = Get.put(PostController());
  final util = Utills();
  var available_time_Slots = <SlotBody>[];
  var noDoctorAvailable = false;
  var all_slots = <String>[];
  var _not_available_slots_index = <int>[];
  var user_data = [];
  var load_status = false;
  var userid = "";
  late var selectedIndex = -1;

  Future<void> _pickImage() async {
    if (postController.uploadedImages.length >= 3) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("You can only upload a maximum of 3 images")),
      );
      return;
    }
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        postController.uploadedImages.add(File(image.path));
        print("Image Added: ${image.path}");
      });
    }
  }

  void _removeImage(int index) {
    setState(() {
      postController.uploadedImages.removeAt(index);
      print("Image Removed at index: $index");
    });
  }

 /* Future<mySlotDTO.SlotSelectDto?> getSlot(String date) async {
    util.startLoading();
    try {
      var res = await http.post(
        Uri.parse("${AppConstant.BASE_URL}/api/time_slot_get"),
        body: <String, String>{"date": date},
        headers: <String, String>{"x-api-key": "dentist@123"},
      );
      print("Response Time Slot: ${res.body}");
      if (res.statusCode == 200 || res.statusCode == 201) {
        util.stopLoading();
        final temp = jsonDecode(res.body.toString());
        if (temp["body"] == "Not Available doctor") {
          util.showSnackBar("Alert", "No doctor available", false);
          setState(() {
            available_time_Slots = [];
            all_slots = [];
            noDoctorAvailable = true;
            selectedIndex = -1;
            postController.time_slot_id = "";
            postController.seletecd_time_slot.value = "";
          });
          return null;
        } else {
          var result = mySlotDTO.slotSelectDtoFromJson(res.body);
          DateTime now = DateTime.now();
          DateTime selectedDate = DateTime.parse(date);
          bool isToday = isSameDay(selectedDate, now);

          setState(() {
            noDoctorAvailable = false;
            available_time_Slots = result.body ?? [];
            all_slots = available_time_Slots.map((e) => e.timeSlot.toString()).toList();
            _not_available_slots_index = [];

            // Mark slots with null or empty id as unavailable
            for (int i = 0; i < available_time_Slots.length; i++) {
              if (available_time_Slots[i].id == null || available_time_Slots[i].id!.isEmpty) {
                _not_available_slots_index.add(i);
              }
            }

            // Check 30-minute rule for the first slot if today
            if (isToday && available_time_Slots.isNotEmpty) {
              String timeSlot = available_time_Slots[0].timeSlot.toString();
              try {
                // Extract start time (e.g., "05:00 PM" from "05:00 PM - 05:30 PM")
                String startTime = timeSlot.split(' - ')[0];
                DateTime slotTime = DateTime.parse(
                    "$date ${startTime.replaceAll(' AM', ':00 AM').replaceAll(' PM', ':00 PM')}"
                );
                // Check if first slot's start time is within 30 minutes
                DateTime thresholdTime = now.add(Duration(minutes: 30));
                if (slotTime.isBefore(thresholdTime) || slotTime.isAtSameMomentAs(thresholdTime)) {
                  _not_available_slots_index.add(0);
                }
              } catch (e) {
                print("Error parsing time slot $timeSlot: $e");
                _not_available_slots_index.add(0); // Mark first slot as unavailable if parsing fails
              }
            }

            selectedIndex = -1;
            postController.time_slot_id = "";
            postController.seletecd_time_slot.value = "";
            print("Available Slots: $all_slots");
            print("Not Available Slots Index: $_not_available_slots_index");
          });
          return result;
        }
      } else {
        util.showSnackBar("Alert", "Something went wrong!", false);
        return null;
      }
    } catch (e) {
      util.showSnackBar("Error", "Failed to fetch slots: $e", false);
      return null;
    } finally {
      util.stopLoading();
    }
  }
*/
  Future<mySlotDTO.SlotSelectDto?> getSlot(String date) async {
    util.startLoading();
    try {
      var res = await http.post(
        Uri.parse("${AppConstant.BASE_URL}/api/time_slot_get"),
        body: <String, String>{"date": date},
        headers: <String, String>{"x-api-key": "dentist@123"},
      );
      print("Response Time Slot: ${res.body}");
      if (res.statusCode == 200 || res.statusCode == 201) {
        util.stopLoading();
        final temp = jsonDecode(res.body.toString());
        if (temp["body"] == "Not Available doctor") {
          util.showSnackBar("Alert", "No doctor available", false);
          setState(() {
            available_time_Slots = [];
            all_slots = [];
            noDoctorAvailable = true;
            selectedIndex = -1;
            postController.time_slot_id = "";
            postController.seletecd_time_slot.value = "";
          });
          return null;
        } else {
          var result = mySlotDTO.slotSelectDtoFromJson(res.body);
          DateTime now = DateTime.now();
          DateTime selectedDate = DateTime.parse(date);
          bool isToday = isSameDay(selectedDate, now);

          setState(() {
            noDoctorAvailable = false;
            available_time_Slots = result.body ?? [];
            all_slots = available_time_Slots.map((e) => e.timeSlot.toString()).toList();
            _not_available_slots_index = [];

            // Mark slots with null or empty id as unavailable
            for (int i = 0; i < available_time_Slots.length; i++) {
              if (available_time_Slots[i].id == null || available_time_Slots[i].id!.isEmpty) {
                _not_available_slots_index.add(i);
              }
            }

            // Check 30-minute rule for the first slot if today
            if (isToday && available_time_Slots.isNotEmpty) {
              String timeSlot = available_time_Slots[0].timeSlot.toString();
              try {
                // Extract start time (e.g., "12:30 PM" from "12:30 PM - 01:00 PM")
                String startTime = timeSlot.split(' - ')[0];
                // Define the format for parsing time (e.g., "12:30 PM")
                final DateFormat timeFormat = DateFormat('hh:mm a');
                // Parse the start time
                DateTime slotTime = timeFormat.parse(startTime);
                // Combine with selected date
                slotTime = DateTime(
                  selectedDate.year,
                  selectedDate.month,
                  selectedDate.day,
                  slotTime.hour,
                  slotTime.minute,
                );
                // Check if first slot's start time is within 30 minutes
                DateTime thresholdTime = now.add(Duration(minutes: 30));
                if (slotTime.isBefore(thresholdTime) || slotTime.isAtSameMomentAs(thresholdTime)) {
                  _not_available_slots_index.add(0);
                }
              } catch (e) {
                print("Error parsing time slot $timeSlot: $e");
                _not_available_slots_index.add(0); // Mark first slot as unavailable if parsing fails
              }
            }

            selectedIndex = -1;
            postController.time_slot_id = "";
            postController.seletecd_time_slot.value = "";
            print("Available Slots: $all_slots");
            print("Not Available Slots Index: $_not_available_slots_index");
          });
          return result;
        }
      } else {
        util.showSnackBar("Alert", "Something went wrong!", false);
        return null;
      }
    } catch (e) {
      util.showSnackBar("Error", "Failed to fetch slots: $e", false);
      return null;
    } finally {
      util.stopLoading();
    }
  }
  void getUserData(String key) async {
    final sp = await SharedPreferences.getInstance();
    setState(() {
      user_data = sp.getStringList(key) ?? [];
      load_status = true;
      userid = user_data.isNotEmpty ? user_data[0].toString() : "";
      print("User ID: $userid");
    });
  }

  @override
  void initState() {
    print("Abhi:- print time slotid : ${available_time_Slots}");
    super.initState();
    getUserData("user_data");
    fetchGalleryImages();
  }

  final VideoController videoController = Get.find();
  final Servicescontroller servicescontroller = Get.find();
  getgalleryimagess? imagesList;

  void fetchGalleryImages() async {
    imagesList = await servicescontroller.getImages();
    setState(() {
      print("Gallery Images: ${imagesList?.body?.map((item) => item.id).toList()}");
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: MyColor.primarycolor,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.light,
        systemNavigationBarColor: Colors.blueAccent,
      ),
      child: Scaffold(
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomAppBar(title: 'Appointment'),
              SizedBox(height: height * 0.02),
              Center(
                child: Text(
                  "Select Diseases",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(height: height * 0.02),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: height * 0.20,
                        child: imagesList == null
                            ? Center(child: CircularProgressIndicator())
                            : imagesList!.body == null || imagesList!.body!.isEmpty
                            ? Center(child: Text("No diseases found"))
                            : GridView.builder(
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 2,
                            mainAxisSpacing: 2,
                            childAspectRatio: 1.2,
                          ),
                          itemCount: imagesList!.body!.length,
                          itemBuilder: (context, index) {
                            var item = imagesList!.body![index];
                            return Container(
                              margin: EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Stack(
                                children: [
                                  Column(
                                    children: [
                                      Expanded(
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
                                          child: item.image != null && item.image!.isNotEmpty
                                              ? Image.network(
                                            item.image!,
                                            width: double.infinity,
                                            fit: BoxFit.cover,
                                            errorBuilder: (context, error, stackTrace) {
                                              return Icon(Icons.error);
                                            },
                                          )
                                              : Image.asset(
                                            "assets/newImages/videofiledimage.png",
                                            width: double.infinity,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.symmetric(vertical: 2, horizontal: 2),
                                        alignment: Alignment.center,
                                        child: Text(
                                          item.title ?? "No Title",
                                          style: TextStyle(fontSize: 10),
                                          textAlign: TextAlign.center,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Positioned(
                                    top: 0,
                                    right: 0,
                                    child: Checkbox(
                                      value: postController.selectedImageIds.contains(item.id),
                                      onChanged: (value) {
                                        setState(() {
                                          if (value == true) {
                                            postController.selectedImageIds.add(item.id!);
                                          } else {
                                            postController.selectedImageIds.remove(item.id);
                                          }
                                          print("Selected Image IDs: ${postController.selectedImageIds}");
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: Colors.grey),
                          ),
                          child: Column(
                            children: [
                              SizedBox(height: height * 0.02),
                              Center(
                                child: Text(
                                  "Select Date",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 17,
                                  ),
                                ),
                              ),
                              TableCalendar(
                                firstDay: DateTime.now(),
                                lastDay: DateTime.utc(2030, 12, 31),
                                focusedDay: _focusedDay,
                                selectedDayPredicate: (day) => isSameDay(postController.selectedDay, day),
                                onDaySelected: (selectedDay, focusedDay) {
                                  setState(() {
                                    postController.selectedDay = selectedDay;
                                    _focusedDay = focusedDay;
                                    available_time_Slots = [];
                                    all_slots = [];
                                    selectedIndex = -1;
                                    postController.time_slot_id = "";
                                    postController.seletecd_time_slot.value = "";
                                    print("Selected Day: $selectedDay");
                                  });
                                  String formattedDate =
                                      "${selectedDay.year}-${selectedDay.month.toString().padLeft(2, '0')}-${selectedDay.day.toString().padLeft(2, '0')}";
                                  getSlot(formattedDate);
                                },
                                calendarStyle: CalendarStyle(
                                  selectedDecoration: BoxDecoration(
                                    color: Colors.blue,
                                    shape: BoxShape.circle,
                                  ),
                                  todayDecoration: BoxDecoration(
                                    color: Colors.grey,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Center(
                        child: Text(
                          "Select Time Slot",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 17,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                      SizedBox(height: height * 0.01),
                      Container(
                        decoration: BoxDecoration(color: Colors.blue[100]),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              if (available_time_Slots.isEmpty && !noDoctorAvailable)
                                Center(child: Text("Please select a date")),
                              if (noDoctorAvailable)
                                Center(child: Text("No slots available")),
                              if (available_time_Slots.isNotEmpty)
                                for (int i = 0; i < available_time_Slots.length; i += 3)
                                  Padding(
                                    padding: EdgeInsets.only(top: 10),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: List.generate(3, (index) {
                                        int actualIndex = i + index;
                                        if (actualIndex >= available_time_Slots.length) return SizedBox();
                                        // Skip unavailable slots
                                        if (_not_available_slots_index.contains(actualIndex)) return SizedBox();
                                        return GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              selectedIndex = actualIndex;
                                              postController.seletecd_time_slot.value = available_time_Slots[actualIndex].timeSlot.toString();
                                              postController.time_slot_id = available_time_Slots[actualIndex].id;
                                              util.showSnackBar(
                                                "Success",
                                                "Slot ${available_time_Slots[actualIndex].timeSlot} selected",
                                                true,
                                              );
                                              print("Selected Time Slot ID: ${postController.time_slot_id}");
                                            });
                                          },
                                          child: Container(
                                            width: width * 0.3,
                                            padding: EdgeInsets.all(8),
                                            decoration: BoxDecoration(
                                              color: selectedIndex == actualIndex ? Colors.blue : Colors.white,
                                              borderRadius: BorderRadius.circular(13),
                                              border: Border.all(color: Colors.blue),
                                            ),
                                            child: Center(
                                              child: Text(
                                                "${available_time_Slots[actualIndex].timeSlot}",
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: selectedIndex == actualIndex ? Colors.white : Colors.black,
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      }),
                                    ),
                                  ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: height * 0.02),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Center(
                              child: Text(
                                "Describe Your Problem",
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            SizedBox(height: height * 0.01),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16.0),
                              child: TextField(
                                controller: postController.problem,
                                decoration: InputDecoration(
                                  hintText: "Enter your problem description",
                                  border: OutlineInputBorder(),
                                ),
                                maxLines: 3,
                              ),
                            ),
                            SizedBox(height: height * 0.02),
                            Center(
                              child: Text(
                                "Upload Photo",
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            SizedBox(height: height * 0.01),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ...postController.uploadedImages.asMap().entries.map((entry) {
                                  int index = entry.key;
                                  File imageFile = entry.value;
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Stack(
                                      children: [
                                        Container(
                                          width: 90,
                                          height: 90,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.grey),
                                          ),
                                          child: Image.file(
                                            imageFile,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        Positioned(
                                          top: 0,
                                          right: 0,
                                          left: 60,
                                          bottom: 70,
                                          child: IconButton(
                                            icon: Icon(Icons.delete, color: Colors.red),
                                            onPressed: () => _removeImage(index),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }).toList(),
                                if (postController.uploadedImages.length < 3)
                                  GestureDetector(
                                    onTap: _pickImage,
                                    child: Container(
                                      width: 100,
                                      height: 100,
                                      decoration: BoxDecoration(
                                        color: Colors.blue[100],
                                        border: Border.all(color: Colors.blue),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Center(
                                        child: Icon(
                                          Icons.add,
                                          color: Colors.blue,
                                          size: 40,
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: height * 0.02),
                      Container(
                        width: width * 0.6,
                        decoration: BoxDecoration(
                          color: MyColor.primarycolor,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: /*TextButton(
                          onPressed: () {
                            if (postController.validation()) {
                              // Validate 30-minute rule for the first slot if today
                              if (isSameDay(postController.selectedDay, DateTime.now()) && postController.seletecd_time_slot.value.isNotEmpty) {
                                try {
                                  String timeSlot = postController.seletecd_time_slot.value;
                                  String startTime = timeSlot.split(' - ')[0];
                                  DateTime slotTime = DateTime.parse(
                                      "${postController.selectedDay.toString().split(' ')[0]} ${startTime.replaceAll(' AM', ':00 AM').replaceAll(' PM', ':00 PM')}"
                                  );
                                  DateTime thresholdTime = DateTime.now().add(Duration(minutes: 30));
                                  if (slotTime.isBefore(thresholdTime) || slotTime.isAtSameMomentAs(thresholdTime)) {
                                    util.showSnackBar(
                                      "Alert",
                                      "You cannot book an appointment now. You can book time slots after 30 minutes.",
                                      false,
                                    );
                                    return;
                                  }
                                } catch (e) {
                                  print("Error parsing selected time slot: $e");
                                  util.showSnackBar("Alert", "Invalid time slot format", false);
                                  return;
                                }
                              }
                              postController.postData(userid);
                            }
                          },
                          child: Text(
                            "Book",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),*/
                        TextButton(
                          onPressed: () {
                            if (postController.validation()) {
                              // Validate 30-minute rule for the first slot if today
                              if (isSameDay(postController.selectedDay, DateTime.now()) && postController.seletecd_time_slot.value.isNotEmpty) {
                                try {
                                  String timeSlot = postController.seletecd_time_slot.value;
                                  String startTime = timeSlot.split(' - ')[0];
                                  // Define the format for parsing time (e.g., "01:00 PM")
                                  final DateFormat timeFormat = DateFormat('hh:mm a');
                                  // Parse the start time
                                  DateTime slotTime = timeFormat.parse(startTime);
                                  // Combine with selected date
                                  slotTime = DateTime(
                                    postController.selectedDay!.year,
                                    postController.selectedDay!.month,
                                    postController.selectedDay!.day,
                                    slotTime.hour,
                                    slotTime.minute,
                                  );
                                  DateTime thresholdTime = DateTime.now().add(Duration(minutes: 30));
                                  if (slotTime.isBefore(thresholdTime) || slotTime.isAtSameMomentAs(thresholdTime)) {
                                    util.showSnackBar(
                                      "Alert",
                                      "You cannot book an appointment now. You can book time slots after 30 minutes.",
                                      false,
                                    );
                                    return;
                                  }
                                } catch (e) {
                                  print("Error parsing selected time slot: $e");
                                  util.showSnackBar("Alert", "Invalid time slot format", false);
                                  return;
                                }
                              }
                              postController.postData(userid);
                            }
                          },
                          child: Text(
                            "Book",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(height: height * 0.1),
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