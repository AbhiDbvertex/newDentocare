//
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bounceable/flutter_bounceable.dart';
// import 'package:get/get.dart';
// import 'package:dentocoreauth/models/appointment_response.dart';
// import 'package:url_launcher/url_launcher.dart';
// import '../../controllers/appoinment_detail_page.dart';
// import '../../utils/app_constant.dart';
// import '../../utils/component_screen.dart';
// import '../../utils/mycolor.dart';
// import '../chat/chat.dart';
// import '../video/view_photos_screen.dart';
//
// class AppointmentDetails extends StatefulWidget {
//   // AppointmentBody? _appointmentBody;
//   final Body getitemslist;
//
//   AppointmentDetails(this.getitemslist/*AppointmentBody? appointmentBody*/) {
//     // this._appointmentBody = appointmentBody;
//   }
//
//   @override
//   State<AppointmentDetails> createState() =>
//       _AppointmentDetailsState(/*_appointmentBody*/);
// }
//
// class _AppointmentDetailsState extends State<AppointmentDetails> {
//   // AppointmentBody? _appointmentBody;
//
//   _AppointmentDetailsState(/*AppointmentBody? appointmentBody*/) {
//     // this._appointmentBody = appointmentBody;
//   }
//
//   late Body item;
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//   item = widget.getitemslist;
//   }
//
//
//   final listOfStatus = [
//     "Pending",
//     "Rejected",
//     "Visited",
//     "Accepted",
//   ];
//
//
//   @override
//   Widget build(BuildContext context) {
//     print("Abhi:- print item data :- ${widget.getitemslist.timeSlotData ?? "no time"}");
//     final height = MediaQuery.of(context).size.height;
//     final width = MediaQuery.of(context).size.width;
//     return SingleChildScrollView(
//       child: SafeArea(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Stack(
//               children: [
//                 Container(
//                   height: height*0.35,
//                   width: double.infinity,
//                   // decoration: BoxDecoration(
//                   //   borderRadius: BorderRadius.circular(0),
//                   //   image: DecorationImage(image: NetworkImage(item.serviceData?.image ??"assets/newImages/noimagefound.png"))
//                   // ),
//                   child: ClipRRect(
//                     borderRadius: BorderRadius.circular(0),
//                     child: CachedNetworkImage(
//                       // Check if nextVisitHistory exists and has items
//                       imageUrl: item.serviceData?.image != null &&
//                           item.serviceData!.image!.isNotEmpty
//                           ? item.serviceData?.image ?? ""
//                           : "assets/newImages/noimagefound.png",
//                       fit: BoxFit.cover,
//                       placeholder: (context, url) => const Center(
//                         child: CircularProgressIndicator(),
//                       ),
//                       errorWidget: (context, url, error) => Image.asset(
//                         "assets/newImages/noimagefound.png", // Placeholder image
//                         fit: BoxFit.cover,
//                       ),
//                       // Enable caching for faster loading
//                       memCacheHeight: (height * 0.40).toInt(),
//                       memCacheWidth: (width * 0.75).toInt(),
//                       fadeInDuration: const Duration(milliseconds: 500),
//                     ),
//                   ),
//                 ),
//                 // Custom App Bar
//                 Positioned(
//                   top: 00,
//                   left: 0,
//                   right: 0,
//                   // bottom: height * 0.3,
//                   child: CustomAppBar(title: 'Appointment Details'),
//                 ),
//               ],
//             ),
//             SizedBox(
//               height: height * 0.02,
//             ),
//             Row(
//               children: [
//                 Container(
//                   height: height * 0.05,
//                   width: width * 0.26,
//                   decoration: BoxDecoration(
//                     color: Colors.pink[200],
//                     borderRadius: BorderRadius.only(
//                         topRight: Radius.circular(20),
//                         bottomRight: Radius.circular(20)),
//                   ),
//                   child: Center(
//                       child: Text(
//                     // "25 Now",
//                         widget.getitemslist.date ?? "no data",
//                     style: TextStyle(
//                         fontWeight: FontWeight.w600, color: Colors.white,fontSize: 14),
//                   )),
//                 ),
//                 SizedBox(
//                   width: width * 0.03,
//                 ),
//                 Column(
//                   children: [
//                     Text(widget.getitemslist.serviceData?.title ?? " Disease name"),
//                     // Text("ID- ##202121"),
//                     Text("ID- ##${widget.getitemslist.id}"), Text("Booking time : ${widget.getitemslist.timeSlottime ?? "no time"}",style: TextStyle(color: Colors.black),),
//                   ],
//                 )
//               ],
//             ),
//             SizedBox(
//               height: height * 0.02,
//             ),
//             DataTable(
//               border: TableBorder(
//                 horizontalInside: BorderSide(color: Colors.transparent, width: 1),
//                 verticalInside: BorderSide(color: Colors.transparent, width: 1),
//                 top: BorderSide(color: Colors.transparent, width: 2),
//                 left: BorderSide(color: Colors.transparent, width: 2),
//                 right: BorderSide(color: Colors.transparent, width: 2),
//                 bottom: BorderSide(color: Colors.transparent, width: 2),
//               ),
//               columns: [
//                 DataColumn(
//                   label: Text(
//                     "Medicine Name",
//                     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
//                   ),
//                 ),
//                 DataColumn(
//                   label: Text(
//                     "Doses",
//                     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
//                   ),
//                 ),
//                 DataColumn(
//                   label: Text(
//                     "Time",
//                     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
//                   ),
//                 ),
//               ],
//               rows: widget.getitemslist.prescriptions?.map((row) {
//                 return DataRow(cells: [
//                   DataCell(Text(
//                     row.medicine ?? "N/A",
//                     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
//                   )),
//                   DataCell(Text(
//                     row.dose ?? "N/A",
//                     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
//                   )),
//                   DataCell(Text(
//                     row.time ?? "N/A",
//                     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
//                   )),
//                 ]);
//               }).toList() ?? [], // Fallback to empty list if prescriptions is null
//             ),
//             SizedBox(
//               height: height * 0.01,
//             ),
//             Container(
//               height: 30,
//               color: Colors.deepOrange[300],
//               child: Center(child: Text("Next Visit: ${widget.getitemslist.nextVisitedDate ?? "Next Visit 12/05/25, 2 PM"} ${widget.getitemslist.nextVisitedTime ?? "2 PM"}")),
//             ),
//             SizedBox(
//               height: height*0.01,
//             ),
//
//           /*  InkWell(
//               onTap: (){
//                 Get.to(ViewPhotosScreen(images: widget.getitemslist.nextVisitHistory != null &&
//                     widget.getitemslist.nextVisitHistory!.isNotEmpty
//                     ? widget.getitemslist.nextVisitHistory![0].fileUrl ?? "https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/1200px-No-Image-Placeholder.svg.png"
//                     : "https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/1200px-No-Image-Placeholder.svg.png",));
//               },
//               child: Center(
//                 child: Container(
//                   margin: EdgeInsets.symmetric(horizontal: width * 0.00),
//                   height: height * 0.40,
//                   width: width * 0.75,
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
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                   child: ClipRRect(
//                     borderRadius: BorderRadius.circular(20),
//                     child: CachedNetworkImage(
//                       // Check if nextVisitHistory exists and has items
//                       imageUrl: widget.getitemslist.nextVisitHistory != null &&
//                           widget.getitemslist.nextVisitHistory!.isNotEmpty
//                           ? widget.getitemslist.nextVisitHistory![0].fileUrl ?? ""
//                           : "assets/newImages/noimagefound.png",
//                       fit: BoxFit.cover,
//                       placeholder: (context, url) => const Center(
//                         child: CircularProgressIndicator(),
//                       ),
//                       errorWidget: (context, url, error) => Image.asset(
//                         "assets/newImages/noimagefound.png", // Placeholder image
//                         fit: BoxFit.cover,
//                       ),
//                       // Enable caching for faster loading
//                       memCacheHeight: (height * 0.40).toInt(),
//                       memCacheWidth: (width * 0.75).toInt(),
//                       fadeInDuration: const Duration(milliseconds: 500),
//                     ),
//                   ),
//                 ),
//               ),
//             ),*/
//             InkWell(
//               onTap: () {
//                 String fileUrl = widget.getitemslist.nextVisitHistory != null &&
//                     widget.getitemslist.nextVisitHistory!.isNotEmpty
//                     ? widget.getitemslist.nextVisitHistory![0].fileUrl ?? ""
//                     : "";
//
//                 if (fileUrl.toLowerCase().endsWith(".pdf")) {
//                   launchUrl(Uri.parse(fileUrl), mode: LaunchMode.externalApplication);
//                 } else {
//                   Get.to(ViewPhotosScreen(
//                     images: fileUrl.isNotEmpty
//                         ? fileUrl
//                         : "https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/1200px-No-Image-Placeholder.svg.png",
//                   ));
//                 }
//               },
//               child: Center(
//                 child: Container(
//                   margin: EdgeInsets.symmetric(horizontal: width * 0.00),
//                   height: height * 0.40,
//                   width: width * 0.75,
//                   decoration: BoxDecoration(
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.grey,
//                         offset: Offset(5.0, 5.0),
//                         blurRadius: 10.0,
//                         spreadRadius: 2.0,
//                       ),
//                       BoxShadow(
//                         color: Colors.white,
//                         offset: Offset(0.0, 0.0),
//                         blurRadius: 0.0,
//                         spreadRadius: 0.0,
//                       ),
//                     ],
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                   child: ClipRRect(
//                     borderRadius: BorderRadius.circular(20),
//                     child: (widget.getitemslist.nextVisitHistory != null &&
//                         widget.getitemslist.nextVisitHistory!.isNotEmpty &&
//                         widget.getitemslist.nextVisitHistory![0].fileUrl != null &&
//                         widget.getitemslist.nextVisitHistory![0].fileUrl!.toLowerCase().endsWith(".pdf"))
//                         ? Container(
//                       color: Colors.grey[200],
//                       child: Center(
//                         child: Icon(Icons.picture_as_pdf, size: 60, color: Colors.red),
//                       ),
//                     )
//                         : CachedNetworkImage(
//                       imageUrl: widget.getitemslist.nextVisitHistory != null &&
//                           widget.getitemslist.nextVisitHistory!.isNotEmpty
//                           ? widget.getitemslist.nextVisitHistory![0].fileUrl ?? ""
//                           : "assets/newImages/noimagefound.png",
//                       fit: BoxFit.cover,
//                       placeholder: (context, url) => const Center(
//                         child: CircularProgressIndicator(),
//                       ),
//                       errorWidget: (context, url, error) => Image.asset(
//                         "assets/newImages/noimagefound.png",
//                         fit: BoxFit.cover,
//                       ),
//                       memCacheHeight: (height * 0.40).toInt(),
//                       memCacheWidth: (width * 0.75).toInt(),
//                       fadeInDuration: const Duration(milliseconds: 500),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(
//               height: height*0.01,
//             ),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: RichText(text: TextSpan(children: [
//                 TextSpan(text: 'Remark :- ',style: TextStyle(color: Colors.deepOrange[300],fontSize: 16,fontWeight: FontWeight.w500),),
//               TextSpan(text: "${widget.getitemslist.nextVisitHistory != null &&
//                   widget.getitemslist.nextVisitHistory!.isNotEmpty
//                   ? widget.getitemslist.nextVisitHistory![0].remark ?? "No remmark"
//                   : "No remark"}",style: TextStyle(color: Colors.black))
//               ],),),
//             ),
//             SizedBox(
//               height: height*0.01,
//             ),
//             Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Center(
//                     child: InkWell(
//                   onTap: () {
//                     Get.to(Chat(null,'http name'));
//                   },
//                   child: Container(
//                     width: 289,
//                     height: 44,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(30),
//                       color: Colors.deepOrange[300],
//                     ),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Image.asset(
//                           "assets/images/chat_icon.png",
//                           color: Colors.white,
//                         ),
//                         SizedBox(
//                           width: 8,
//                         ),
//                         Center(
//                             child: Text(
//                           "Chat",
//                           style: TextStyle(
//                               color: Colors.white, fontWeight: FontWeight.bold),
//                         )),
//                       ],
//                     ),
//                   ),
//                 ))),SizedBox(
//               height: height*0.01,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

/*
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:get/get.dart';
import 'package:dentocoreauth/models/appointment_response.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../controllers/appoinment_detail_page.dart';
import '../../utils/app_constant.dart';
import '../../utils/component_screen.dart';
import '../../utils/mycolor.dart';
import '../chat/chat.dart';
import '../video/view_photos_screen.dart';

class AppointmentDetails extends StatefulWidget {
  final Body getitemslist;

  AppointmentDetails(this.getitemslist);

  @override
  State<AppointmentDetails> createState() => _AppointmentDetailsState();
}

class _AppointmentDetailsState extends State<AppointmentDetails> {
  late Body item;

  @override
  void initState() {
    super.initState();
    item = widget.getitemslist;
  }

  final listOfStatus = [
    "Pending",
    "Rejected",
    "Visited",
    "Accepted",
  ];

  @override
  Widget build(BuildContext context) {
    print("Abhi:- print item data :- ${widget.getitemslist.timeSlottime ?? "no time"}");
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    // Define responsive dimensions
    final bannerHeight = height * 0.35; // Maintained for banner
    final containerHeight = height * 0.06; // Adjusted from 0.05
    final containerWidth = width * 0.28; // Adjusted from 0.26
    final spacingSmall = height * 0.015; // Adjusted from 0.01
    final spacingMedium = height * 0.02; // Maintained
    final fontSizeLarge = width * 0.039; // ~12-38px for main text
    final fontSizeSmall = width * 0.033; // ~10-32px for table and small text
    final fontSizeRemark = width * 0.044; // ~14-43px for remark
    final imageHeight = height * 0.35; // Adjusted from 0.40 for better scaling
    final imageWidth = width * 0.8; // Adjusted from 0.75
    final nextVisitHeight = height * 0.045; // Adjusted from 30
    final buttonWidth = width * 0.7; // Adjusted from 289
    final buttonHeight = height * 0.055; // Adjusted from 44
    final borderRadiusLarge = width * 0.05; // Adjusted from 20
    final borderRadiusSmall = width * 0.03; // For smaller rounded corners
    final padding = width * 0.02; // Adjusted from 8.0
    final iconSize = width * 0.15; // Adjusted from 60 for PDF icon
    final chatIconSize = width * 0.06; // For chat icon scaling

    return SingleChildScrollView(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: bannerHeight,
                  width: double.infinity,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(0),
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
                      memCacheHeight: (imageHeight).toInt(),
                      memCacheWidth: (imageWidth).toInt(),
                      fadeInDuration: const Duration(milliseconds: 500),
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: CustomAppBar(title: 'Appointment Details'),
                ),
              ],
            ),
            SizedBox(height: spacingMedium),
            Row(
              children: [
                Container(
                  height: containerHeight,
                  width: containerWidth,
                  decoration: BoxDecoration(
                    color: Colors.pink[200],
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(borderRadiusLarge),
                      bottomRight: Radius.circular(borderRadiusLarge),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      widget.getitemslist.date ?? "No Date",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        fontSize: height*0.0167,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: width * 0.04), // Slightly adjusted from 0.03
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.getitemslist.serviceData?.title ?? "Disease name",
                      style: TextStyle(fontSize: fontSizeLarge,fontWeight: FontWeight.w500),
                    ),
                    Text(
                      "ID- ##${widget.getitemslist.id}",
                      style: TextStyle(fontSize: height*0.0167),
                    ),
                    Text(
                      "Booking time: ${widget.getitemslist.timeSlottime ?? "No Time"}",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: height*0.016,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: spacingMedium),
            DataTable(
              border: TableBorder(
                horizontalInside: BorderSide(color: Colors.transparent, width: 1),
                verticalInside: BorderSide(color: Colors.transparent, width: 1),
                top: BorderSide(color: Colors.transparent, width: 2),
                left: BorderSide(color: Colors.transparent, width: 2),
                right: BorderSide(color: Colors.transparent, width: 2),
                bottom: BorderSide(color: Colors.transparent, width: 2),
              ),
              columns: [
                DataColumn(
                  label: Text(
                    "Medicine Name",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: fontSizeSmall,
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    "Doses",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: fontSizeSmall,
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    "Time",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: fontSizeSmall,
                    ),
                  ),
                ),
              ],
              rows: widget.getitemslist.prescriptions?.map((row) {
                return DataRow(cells: [
                  DataCell(Text(
                    row.medicine ?? "N/A",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: fontSizeSmall * 0.9, // Slightly smaller for table
                    ),
                  )),
                  DataCell(Text(
                    row.dose ?? "N/A",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: fontSizeSmall * 0.9,
                    ),
                  )),
                  DataCell(Text(
                    row.time ?? "N/A",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: fontSizeSmall * 0.9,
                    ),
                  )),
                ]);
              }).toList() ??
                  [],
            ),
            SizedBox(height: spacingSmall),
            Container(
              height: nextVisitHeight,
              color: Colors.deepOrange[300],
              child: Center(
                child: Text(
                  "Next Visit: ${widget.getitemslist.nextVisitedDate ?? "No Date"} ${ widget.getitemslist.timeSlottime ?? "No Time"}",
                  style: TextStyle(fontSize: height*0.016),
                ),
              ),
            ),
            SizedBox(height: spacingSmall),
            ListView.builder(
              itemCount: 2,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    String fileUrl = widget.getitemslist.nextVisitHistory != null &&
                        widget.getitemslist.nextVisitHistory!.isNotEmpty
                        ? widget.getitemslist.nextVisitHistory![0].fileUrl ?? ""
                        : "";
                    if (fileUrl.toLowerCase().endsWith(".pdf")) {
                      launchUrl(
                        Uri.parse(fileUrl),
                        mode: LaunchMode.externalApplication,
                      );
                    } else {
                      Get.to(ViewPhotosScreen(
                        images: fileUrl.isNotEmpty
                            ? fileUrl
                            : "https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/1200px-No-Image-Placeholder.svg.png",
                      ));
                    }
                  },
                  child: Center(
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: padding),
                      height: imageHeight,
                      width: imageWidth,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            offset: Offset(5.0, 5.0),
                            blurRadius: 10.0,
                            spreadRadius: 2.0,
                          ),
                          BoxShadow(
                            color: Colors.white,
                            offset: Offset(0.0, 0.0),
                            blurRadius: 0.0,
                            spreadRadius: 0.0,
                          ),
                        ],
                        borderRadius: BorderRadius.circular(borderRadiusLarge),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(borderRadiusLarge),
                        child: (widget.getitemslist.nextVisitHistory != null &&
                            widget.getitemslist.nextVisitHistory!.isNotEmpty &&
                            widget.getitemslist.nextVisitHistory![0].fileUrl != null &&
                            widget.getitemslist.nextVisitHistory![0].fileUrl!.toLowerCase().endsWith(".pdf"))
                            ? Container(
                          color: Colors.grey[200],
                          child: Center(
                            child: Icon(
                              Icons.picture_as_pdf,
                              size: iconSize,
                              color: Colors.red,
                            ),
                          ),
                        )
                            : CachedNetworkImage(
                          imageUrl: widget.getitemslist.nextVisitHistory != null &&
                              widget.getitemslist.nextVisitHistory!.isNotEmpty
                              ? widget.getitemslist.nextVisitHistory![0].fileUrl ?? ""
                              : "assets/newImages/noimagefound.png",
                          fit: BoxFit.cover,
                          placeholder: (context, url) => const Center(
                            child: CircularProgressIndicator(),
                          ),
                          errorWidget: (context, url, error) => Image.asset(
                            "assets/newImages/noimagefound.png",
                            fit: BoxFit.cover,
                          ),
                          memCacheHeight: (imageHeight).toInt(),
                          memCacheWidth: (imageWidth).toInt(),
                          fadeInDuration: const Duration(milliseconds: 500),
                        ),
                      ),
                    ),
                  ),
                );
              },
              // child: InkWell(
              //   onTap: () {
              //     String fileUrl = widget.getitemslist.nextVisitHistory != null &&
              //         widget.getitemslist.nextVisitHistory!.isNotEmpty
              //         ? widget.getitemslist.nextVisitHistory![0].fileUrl ?? ""
              //         : "";
              //     if (fileUrl.toLowerCase().endsWith(".pdf")) {
              //       launchUrl(
              //         Uri.parse(fileUrl),
              //         mode: LaunchMode.externalApplication,
              //       );
              //     } else {
              //       Get.to(ViewPhotosScreen(
              //         images: fileUrl.isNotEmpty
              //             ? fileUrl
              //             : "https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/1200px-No-Image-Placeholder.svg.png",
              //       ));
              //     }
              //   },
              //   child: Center(
              //     child: Container(
              //       margin: EdgeInsets.symmetric(horizontal: padding),
              //       height: imageHeight,
              //       width: imageWidth,
              //       decoration: BoxDecoration(
              //         boxShadow: [
              //           BoxShadow(
              //             color: Colors.grey,
              //             offset: Offset(5.0, 5.0),
              //             blurRadius: 10.0,
              //             spreadRadius: 2.0,
              //           ),
              //           BoxShadow(
              //             color: Colors.white,
              //             offset: Offset(0.0, 0.0),
              //             blurRadius: 0.0,
              //             spreadRadius: 0.0,
              //           ),
              //         ],
              //         borderRadius: BorderRadius.circular(borderRadiusLarge),
              //       ),
              //       child: ClipRRect(
              //         borderRadius: BorderRadius.circular(borderRadiusLarge),
              //         child: (widget.getitemslist.nextVisitHistory != null &&
              //             widget.getitemslist.nextVisitHistory!.isNotEmpty &&
              //             widget.getitemslist.nextVisitHistory![0].fileUrl != null &&
              //             widget.getitemslist.nextVisitHistory![0].fileUrl!.toLowerCase().endsWith(".pdf"))
              //             ? Container(
              //           color: Colors.grey[200],
              //           child: Center(
              //             child: Icon(
              //               Icons.picture_as_pdf,
              //               size: iconSize,
              //               color: Colors.red,
              //             ),
              //           ),
              //         )
              //             : CachedNetworkImage(
              //           imageUrl: widget.getitemslist.nextVisitHistory != null &&
              //               widget.getitemslist.nextVisitHistory!.isNotEmpty
              //               ? widget.getitemslist.nextVisitHistory![0].fileUrl ?? ""
              //               : "assets/newImages/noimagefound.png",
              //           fit: BoxFit.cover,
              //           placeholder: (context, url) => const Center(
              //             child: CircularProgressIndicator(),
              //           ),
              //           errorWidget: (context, url, error) => Image.asset(
              //             "assets/newImages/noimagefound.png",
              //             fit: BoxFit.cover,
              //           ),
              //           memCacheHeight: (imageHeight).toInt(),
              //           memCacheWidth: (imageWidth).toInt(),
              //           fadeInDuration: const Duration(milliseconds: 500),
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
            ),
            SizedBox(height: spacingSmall),
            Padding(
              padding: EdgeInsets.all(padding),
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Remark :- ',
                      style: TextStyle(
                        color: Colors.deepOrange[300],
                        fontSize: fontSizeRemark,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    TextSpan(
                      text: widget.getitemslist.nextVisitHistory != null &&
                          widget.getitemslist.nextVisitHistory!.isNotEmpty
                          ? widget.getitemslist.nextVisitHistory![0].remark ?? "No remark"
                          : "No remark",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: fontSizeSmall,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: spacingSmall),
            Padding(
              padding: EdgeInsets.all(padding),
              child: Center(
                child: InkWell(
                  onTap: () {
                    Get.to(Chat(null, 'http name'));
                  },
                  child: Container(
                    width: buttonWidth,
                    height: buttonHeight,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(borderRadiusSmall),
                      color: Colors.deepOrange[300],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/images/chat_icon.png",
                          color: Colors.white,
                          width: chatIconSize,
                          height: chatIconSize,
                        ),
                        SizedBox(width: padding * 2),
                        Text(
                          "Chat",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: fontSizeSmall,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: spacingSmall),
          ],
        ),
      ),
    );
  }
}*/
//
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bounceable/flutter_bounceable.dart';
// import 'package:get/get.dart';
// import 'package:dentocoreauth/models/appointment_response.dart';
// import 'package:url_launcher/url_launcher.dart';
// import '../../controllers/appoinment_detail_page.dart';
// import '../../utils/app_constant.dart';
// import '../../utils/component_screen.dart';
// import '../../utils/mycolor.dart';
// import '../chat/chat.dart';
// import '../video/view_photos_screen.dart';
//
// class AppointmentDetails extends StatefulWidget {
//   final Body getitemslist;
//
//   AppointmentDetails(this.getitemslist);
//
//   @override
//   State<AppointmentDetails> createState() => _AppointmentDetailsState();
// }
//
// class _AppointmentDetailsState extends State<AppointmentDetails> {
//   late Body item;
//
//   @override
//   void initState() {
//     super.initState();
//     item = widget.getitemslist;
//   }
//
//   final listOfStatus = [
//     "Pending",
//     "Rejected",
//     "Visited",
//     "Accepted",
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     print("Abhi:- print item data :- ${widget.getitemslist.timeSlottime ?? "no time"}");
//     final height = MediaQuery.of(context).size.height;
//     final width = MediaQuery.of(context).size.width;
//
//     // Define responsive dimensions
//     final bannerHeight = height * 0.35; // Maintained for banner
//     final containerHeight = height * 0.06; // Adjusted from 0.05
//     final containerWidth = width * 0.28; // Adjusted from 0.26
//     final spacingSmall = height * 0.015; // Adjusted from 0.01
//     final spacingMedium = height * 0.02; // Maintained
//     final fontSizeLarge = width * 0.039; // ~12-38px for main text
//     final fontSizeSmall = width * 0.033; // ~10-32px for table and small text
//     final fontSizeRemark = width * 0.044; // ~14-43px for remark
//     final imageHeight = height * 0.35; // Adjusted from 0.40 for better scaling
//     final imageWidth = width * 0.8; // Adjusted from 0.75
//     final nextVisitHeight = height * 0.045; // Adjusted from 30
//     final buttonWidth = width * 0.7; // Adjusted from 289
//     final buttonHeight = height * 0.055; // Adjusted from 44
//     final borderRadiusLarge = width * 0.05; // Adjusted from 20
//     final borderRadiusSmall = width * 0.03; // For smaller rounded corners
//     final padding = width * 0.02; // Adjusted from 8.0
//     final iconSize = width * 0.15; // Adjusted from 60 for PDF icon
//     final chatIconSize = width * 0.06; // For chat icon scaling
//
//     return SingleChildScrollView(
//       child: SafeArea(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Stack(
//               children: [
//                 Container(
//                   height: bannerHeight,
//                   width: double.infinity,
//                   child: ClipRRect(
//                     borderRadius: BorderRadius.circular(0),
//                     child: CachedNetworkImage(
//                       imageUrl: item.serviceData?.image != null &&
//                           item.serviceData!.image!.isNotEmpty
//                           ? item.serviceData!.image!
//                           : "assets/newImages/noimagefound.png",
//                       fit: BoxFit.cover,
//                       placeholder: (context, url) => const Center(
//                         child: CircularProgressIndicator(),
//                       ),
//                       errorWidget: (context, url, error) => Image.asset(
//                         "assets/newImages/noimagefound.png",
//                         fit: BoxFit.cover,
//                       ),
//                       memCacheHeight: (imageHeight).toInt(),
//                       memCacheWidth: (imageWidth).toInt(),
//                       fadeInDuration: const Duration(milliseconds: 500),
//                     ),
//                   ),
//                 ),
//                 Positioned(
//                   top: 0,
//                   left: 0,
//                   right: 0,
//                   child: CustomAppBar(title: 'Appointment Details'),
//                 ),
//               ],
//             ),
//             SizedBox(height: spacingMedium),
//             Row(
//               children: [
//                 Container(
//                   height: containerHeight,
//                   width: containerWidth,
//                   decoration: BoxDecoration(
//                     color: Colors.pink[200],
//                     borderRadius: BorderRadius.only(
//                       topRight: Radius.circular(borderRadiusLarge),
//                       bottomRight: Radius.circular(borderRadiusLarge),
//                     ),
//                   ),
//                   child: Center(
//                     child: Text(
//                       widget.getitemslist.date ?? "No Date",
//                       style: TextStyle(
//                         fontWeight: FontWeight.w600,
//                         color: Colors.white,
//                         fontSize: height * 0.0167,
//                       ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(width: width * 0.04),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       widget.getitemslist.serviceData?.title ?? "Disease name",
//                       style: TextStyle(fontSize: fontSizeLarge, fontWeight: FontWeight.w500),
//                     ),
//                     Text(
//                       "ID- ##${widget.getitemslist.id}",
//                       style: TextStyle(fontSize: height * 0.0167),
//                     ),
//                     Text(
//                       "Booking time: ${widget.getitemslist.timeSlottime ?? "No Time"}",
//                       style: TextStyle(
//                         color: Colors.black,
//                         fontSize: height * 0.016,
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//             SizedBox(height: spacingMedium),
//             DataTable(
//               border: TableBorder(
//                 horizontalInside: BorderSide(color: Colors.transparent, width: 1),
//                 verticalInside: BorderSide(color: Colors.transparent, width: 1),
//                 top: BorderSide(color: Colors.transparent, width: 2),
//                 left: BorderSide(color: Colors.transparent, width: 2),
//                 right: BorderSide(color: Colors.transparent, width: 2),
//                 bottom: BorderSide(color: Colors.transparent, width: 2),
//               ),
//               columns: [
//                 DataColumn(
//                   label: Text(
//                     "Medicine Name",
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       fontSize: fontSizeSmall,
//                     ),
//                   ),
//                 ),
//                 DataColumn(
//                   label: Text(
//                     "Doses",
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       fontSize: fontSizeSmall,
//                     ),
//                   ),
//                 ),
//                 DataColumn(
//                   label: Text(
//                     "Time",
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       fontSize: fontSizeSmall,
//                     ),
//                   ),
//                 ),
//               ],
//               rows: widget.getitemslist.prescriptions?.map((row) {
//                 return DataRow(cells: [
//                   DataCell(Text(
//                     row.medicine ?? "N/A",
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       fontSize: fontSizeSmall * 0.9,
//                     ),
//                   )),
//                   DataCell(Text(
//                     row.dose ?? "N/A",
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       fontSize: fontSizeSmall * 0.9,
//                     ),
//                   )),
//                   DataCell(Text(
//                     row.time ?? "N/A",
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       fontSize: fontSizeSmall * 0.9,
//                     ),
//                   )),
//                 ]);
//               }).toList() ??
//                   [],
//             ),
//             SizedBox(height: spacingSmall),
//             Container(
//               height: nextVisitHeight,
//               color: Colors.deepOrange[300],
//               child: Center(
//                 child: Text(
//                   "Next Visit: ${widget.getitemslist.nextVisitedDate ?? "No Date"} ${widget.getitemslist.nextVisitedTime ?? "No Time"}",
//                   style: TextStyle(fontSize: height * 0.016),
//                 ),
//               ),
//             ),
//             SizedBox(height: spacingSmall),
//             widget.getitemslist.nextVisitHistory != null &&
//                 widget.getitemslist.nextVisitHistory!.isNotEmpty
//                 ? ListView.builder(
//               shrinkWrap: true,
//               physics: const NeverScrollableScrollPhysics(),
//               itemCount: widget.getitemslist.nextVisitHistory!.length,
//               itemBuilder: (context, index) {
//                 final historyItem = widget.getitemslist.nextVisitHistory![index];
//                 return Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     if (historyItem.fileUrl != null && historyItem.fileUrl!.isNotEmpty)
//                       ListView.builder(
//                         shrinkWrap: true,
//                         physics: const NeverScrollableScrollPhysics(),
//                         itemCount: historyItem.fileUrl!.length,
//                         itemBuilder: (context, fileIndex) {
//                           final fileUrl = historyItem.fileUrl![fileIndex];
//                           final isPdf = fileUrl.toLowerCase().endsWith(".pdf");
//                           return InkWell(
//                             onTap: () {
//                               if (isPdf) {
//                                 launchUrl(
//                                   Uri.parse(fileUrl),
//                                   mode: LaunchMode.externalApplication,
//                                 );
//                               } else {
//                                 Get.to(ViewPhotosScreen(
//                                   images: fileUrl,
//                                 ));
//                               }
//                             },
//                             child: Center(
//                               child: Container(
//                                 margin: EdgeInsets.symmetric(horizontal: padding, vertical: spacingSmall),
//                                 height: imageHeight,
//                                 width: imageWidth,
//                                 decoration: BoxDecoration(
//                                   boxShadow: [
//                                     BoxShadow(
//                                       color: Colors.grey,
//                                       offset: Offset(5.0, 5.0),
//                                       blurRadius: 10.0,
//                                       spreadRadius: 2.0,
//                                     ),
//                                     BoxShadow(
//                                       color: Colors.white,
//                                       offset: Offset(0.0, 0.0),
//                                       blurRadius: 0.0,
//                                       spreadRadius: 0.0,
//                                     ),
//                                   ],
//                                   borderRadius: BorderRadius.circular(borderRadiusLarge),
//                                 ),
//                                 child: ClipRRect(
//                                   borderRadius: BorderRadius.circular(borderRadiusLarge),
//                                   child: isPdf
//                                       ? Container(
//                                     color: Colors.grey[200],
//                                     child: Center(
//                                       child: Icon(
//                                         Icons.picture_as_pdf,
//                                         size: iconSize,
//                                         color: Colors.red,
//                                       ),
//                                     ),
//                                   )
//                                       : CachedNetworkImage(
//                                     imageUrl: fileUrl.isNotEmpty
//                                         ? fileUrl
//                                         : "assets/newImages/noimagefound.png",
//                                     fit: BoxFit.cover,
//                                     placeholder: (context, url) => const Center(
//                                       child: CircularProgressIndicator(),
//                                     ),
//                                     errorWidget: (context, url, error) => Image.asset(
//                                       "assets/newImages/noimagefound.png",
//                                       fit: BoxFit.cover,
//                                     ),
//                                     memCacheHeight: (imageHeight).toInt(),
//                                     memCacheWidth: (imageWidth).toInt(),
//                                     fadeInDuration: const Duration(milliseconds: 500),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           );
//                         },
//                       ),
//                     SizedBox(height: spacingSmall),
//                     Padding(
//                       padding: EdgeInsets.symmetric(horizontal: padding),
//                       child: RichText(
//                         text: TextSpan(
//                           children: [
//                             TextSpan(
//                               text: 'Remark :- ',
//                               style: TextStyle(
//                                 color: Colors.deepOrange[300],
//                                 fontSize: fontSizeRemark,
//                                 fontWeight: FontWeight.w500,
//                               ),
//                             ),
//                             TextSpan(
//                               text: historyItem.remark ?? "No remark",
//                               style: TextStyle(
//                                 color: Colors.black,
//                                 fontSize: fontSizeSmall,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: spacingSmall),
//                   ],
//                 );
//               },
//             )
//                 : Center(
//               child: Text(
//                 "No visit history available",
//                 style: TextStyle(
//                   fontSize: fontSizeSmall,
//                   color: Colors.grey,
//                 ),
//               ),
//             ),
//             SizedBox(height: spacingSmall),
//             Padding(
//               padding: EdgeInsets.all(5),
//               child: Center(
//                 child: InkWell(
//                   onTap: () {
//                     Get.to(Chat(null, 'http name'));
//                   },
//                   child: Container(
//                     width: buttonWidth,
//                     height: buttonHeight,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(borderRadiusSmall),
//                       color: Colors.deepOrange[300],
//                     ),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Image.asset(
//                           "assets/images/chat_icon.png",
//                           color: Colors.white,
//                           width: chatIconSize,
//                           height: chatIconSize,
//                         ),
//                         SizedBox(width: padding * 2),
//                         Text(
//                           "Chat",
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontWeight: FontWeight.bold,
//                             fontSize: fontSizeSmall,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(height: spacingSmall),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
// import '/package:get/get.dart';
import 'package:dentocoreauth/models/appointment_response.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../controllers/appoinment_detail_page.dart';
import '../../utils/app_constant.dart';
import '../../utils/component_screen.dart';
import '../../utils/mycolor.dart';
import '../chat/chat.dart';
import '../video/view_photos_screen.dart';

class AppointmentDetails extends StatefulWidget {
  final Body getitemslist;

  AppointmentDetails(this.getitemslist);

  @override
  State<AppointmentDetails> createState() => _AppointmentDetailsState();
}

class _AppointmentDetailsState extends State<AppointmentDetails> {
  late Body item;

  @override
  void initState() {
    super.initState();
    item = widget.getitemslist;
  }

  final listOfStatus = [
    "Pending",
    "Rejected",
    "Visited",
    "Accepted",
  ];

  @override
  Widget build(BuildContext context) {
    print("Abhi:- print item data :- ${widget.getitemslist.timeSlottime ?? "no time"}");
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    // Define responsive dimensions
    final bannerHeight = height * 0.35;
    final containerHeight = height * 0.06;
    final containerWidth = width * 0.28;
    final spacingSmall = height * 0.015;
    final spacingMedium = height * 0.02;
    final fontSizeLarge = width * 0.039;
    final fontSizeSmall = width * 0.033;
    final fontSizeRemark = width * 0.044;
    final imageHeight = height * 0.39;
    final imageWidth = width * 0.7; // Reduced for horizontal scrolling
    final nextVisitHeight = height * 0.045;
    final buttonWidth = width * 0.7;
    final buttonHeight = height * 0.055;
    final borderRadiusLarge = width * 0.05;
    final borderRadiusSmall = width * 0.03;
    final padding = width * 0.02;
    final iconSize = width * 0.15;
    final chatIconSize = width * 0.06;

    return SingleChildScrollView(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: bannerHeight,
                  width: double.infinity,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(0),
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
                      memCacheHeight: (imageHeight).toInt(),
                      memCacheWidth: (imageWidth).toInt(),
                      fadeInDuration: const Duration(milliseconds: 500),
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: CustomAppBar(title: 'Appointment Details'),
                ),
              ],
            ),
            SizedBox(height: spacingMedium),
            Row(
              children: [
                Container(
                  height: containerHeight,
                  width: containerWidth,
                  decoration: BoxDecoration(
                    color: Colors.pink[200],
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(borderRadiusLarge),
                      bottomRight: Radius.circular(borderRadiusLarge),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      widget.getitemslist.date ?? "No Date",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        fontSize: height * 0.0167,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: width * 0.04),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.getitemslist.serviceData?.title ?? "Disease name",
                      style: TextStyle(fontSize: fontSizeLarge, fontWeight: FontWeight.w500),
                    ),
                    Text(
                      "ID- ##${widget.getitemslist.id}",
                      style: TextStyle(fontSize: height * 0.0167),
                    ),
                    Text(
                      "Booking time: ${widget.getitemslist.timeSlottime ?? "No Time"}",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: height * 0.016,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: spacingMedium),
            DataTable(
              border: TableBorder(
                horizontalInside: BorderSide(color: Colors.transparent, width: 1),
                verticalInside: BorderSide(color: Colors.transparent, width: 1),
                top: BorderSide(color: Colors.transparent, width: 2),
                left: BorderSide(color: Colors.transparent, width: 2),
                right: BorderSide(color: Colors.transparent, width: 2),
                bottom: BorderSide(color: Colors.transparent, width: 2),
              ),
              columns: [
                DataColumn(
                  label: Text(
                    "Medicine Name",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: fontSizeSmall,
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    "Doses",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: fontSizeSmall,
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    "Time",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: fontSizeSmall,
                    ),
                  ),
                ),
              ],
              rows: widget.getitemslist.prescriptions?.map((row) {
                return DataRow(cells: [
                  DataCell(Text(
                    row.medicine ?? "N/A",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: fontSizeSmall * 0.9,
                    ),
                  )),
                  DataCell(Text(
                    row.dose ?? "N/A",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: fontSizeSmall * 0.9,
                    ),
                  )),
                  DataCell(Text(
                    row.time ?? "N/A",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: fontSizeSmall * 0.9,
                    ),
                  )),
                ]);
              }).toList() ??
                  [],
            ),
            SizedBox(height: spacingSmall),
            Container(
              height: nextVisitHeight,
              color: Colors.deepOrange[300],
              child: Center(
                child: Text(
                  "Next Visit: ${widget.getitemslist.nextVisitedDate ?? "No Date"} ${widget.getitemslist.nextVisitedTime ?? "No Time"}",
                  style: TextStyle(fontSize: height * 0.016),
                ),
              ),
            ),
            SizedBox(height: spacingSmall),
            widget.getitemslist.nextVisitHistory != null &&
                widget.getitemslist.nextVisitHistory!.isNotEmpty
                ? ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: widget.getitemslist.nextVisitHistory!.length,
              itemBuilder: (context, index) {
                final historyItem = widget.getitemslist.nextVisitHistory![index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (historyItem.fileUrl != null && historyItem.fileUrl!.isNotEmpty)
                        Container(
                          height: imageHeight,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            physics: const ClampingScrollPhysics(),
                            itemCount: historyItem.fileUrl!.length,
                            itemBuilder: (context, fileIndex) {
                              final fileUrl = historyItem.fileUrl![fileIndex];
                              final isPdf = fileUrl.toLowerCase().endsWith(".pdf");
                              return InkWell(
                                onTap: () {
                                  if (isPdf) {
                                    launchUrl(
                                      Uri.parse(fileUrl),
                                      mode: LaunchMode.externalApplication,
                                    );
                                  } else {
                                    Get.to(ViewPhotosScreen(
                                      images: fileUrl,
                                    ));
                                  }
                                },
                                child: Container(
                                  margin: EdgeInsets.symmetric(horizontal: padding / 1, vertical: spacingSmall),
                                  height: imageHeight,
                                  width: imageWidth,
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey,
                                        offset: Offset(5.0, 5.0),
                                        blurRadius: 10.0,
                                        spreadRadius: 2.0,
                                      ),
                                      BoxShadow(
                                        color: Colors.white,
                                        offset: Offset(0.0, 0.0),
                                        blurRadius: 0.0,
                                        spreadRadius: 0.0,
                                      ),
                                    ],
                                    borderRadius: BorderRadius.circular(borderRadiusLarge),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(borderRadiusLarge),
                                    child: isPdf
                                        ? Container(
                                      color: Colors.grey[200],
                                      child: Center(
                                        child: Icon(
                                          Icons.picture_as_pdf,
                                          size: iconSize,
                                          color: Colors.red,
                                        ),
                                      ),
                                    )
                                        : CachedNetworkImage(
                                      imageUrl: fileUrl.isNotEmpty
                                          ? fileUrl
                                          : "assets/newImages/noimagefound.png",
                                      // fit: BoxFit.cover,
                                      placeholder: (context, url) => const Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                      errorWidget: (context, url, error) => Image.asset(
                                        "assets/newImages/noimagefound.png",
                                        // fit: BoxFit.cover,
                                      ),
                                      memCacheHeight: (imageHeight).toInt(),
                                      memCacheWidth: (imageWidth).toInt(),
                                      fadeInDuration: const Duration(milliseconds: 500),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      SizedBox(height: spacingSmall),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: padding),
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Remark :- ',
                                style: TextStyle(
                                  color: Colors.deepOrange[300],
                                  fontSize: height * 0.025,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              TextSpan(
                                text: historyItem.remark ?? "No remark",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: height * 0.02,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: spacingSmall),
                    ],
                  ),
                );
              },
            )
                : Center(
              child: Text(
                "No visit history available",
                style: TextStyle(
                  fontSize: fontSizeSmall,
                  color: Colors.grey,
                ),
              ),
            ),
            SizedBox(height: spacingSmall),
            Padding(
              padding: EdgeInsets.all(padding),
              child: Center(
                child: InkWell(
                  onTap: () {
                    Get.to(Chat(null, 'http name'));
                  },
                  child: Container(
                    width: buttonWidth,
                    height: buttonHeight,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(borderRadiusSmall),
                      color: Colors.deepOrange[300],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/images/chat_icon.png",
                          color: Colors.white,
                          width: chatIconSize,
                          height: chatIconSize,
                        ),
                        SizedBox(width: padding * 2),
                        Text(
                          "Chat",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: fontSizeSmall,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: spacingSmall),
          ],
        ),
      ),
    );
  }
}