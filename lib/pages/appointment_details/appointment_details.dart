// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bounceable/flutter_bounceable.dart';
// import 'package:get/get.dart';
// import 'package:dentocoreauth/models/appointment_response.dart';
// import '../../utils/app_constant.dart';
// import '../../utils/mycolor.dart';
//
// class AppointmentDetails extends StatefulWidget {
//   // AppointmentBody? _appointmentBody;
//
//   AppointmentDetails(/*AppointmentBody? appointmentBody*/) {
//     // this._appointmentBody = appointmentBody;
//   }
//
//   @override
//   State<AppointmentDetails> createState() => _AppointmentDetailsState( /*_appointmentBody*/);
// }
//
// class _AppointmentDetailsState extends State<AppointmentDetails> {
//   // AppointmentBody? _appointmentBody;
//
//   _AppointmentDetailsState(/*AppointmentBody? appointmentBody*/) {
//     // this._appointmentBody = appointmentBody;
//   }
//   final listOfStatus = [
//     "Pending",
//     "Rejected",
//     "Visited",
//     "Accepted",
//   ];
//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: SafeArea(
//         child: Container(
//           child: Column(
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
//                                 height: 40,
//                                 child: AppConstant.HEADLINE_TEXT(
//                                     AppConstant.TITLE_TEXT_PRESCRIPTION,
//                                     context),
//                               ),
//                             ),
//                           ),
//                           Flexible(
//                             child: Visibility(
//                               visible: false,
//                               maintainAnimation: true,
//                               maintainSemantics: true,
//                               maintainState: true,
//                               maintainSize: true,
//                               child: Container(
//                                 width: MediaQuery.of(context).size.width / 3,
//                                 alignment: Alignment.centerRight,
//                                 child: Padding(
//                                     padding: EdgeInsets.only(top: 0, right: 10),
//                                     child: Icon(Icons.notifications)),
//                               ),
//                             ),
//                           )
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
//               Visibility(
//                 visible: false,
//                 child: Container(
//                   margin: EdgeInsets.all(20),
//                   decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(20),
//                       color: Colors.blue.shade50),
//                   child: Padding(
//                     padding: const EdgeInsets.all(14.0),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         Column(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               "Appro. ID-#204521",
//                               style: TextStyle(
//                                   color: Colors.blue,
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: 14),
//                             ),
//                             SizedBox(
//                               height: 2,
//                             ),
//                             Container(
//                                 width: 200,
//                                 child: Text(
//                                   AppConstant.dummy_text,
//                                   overflow: TextOverflow.ellipsis,
//                                   maxLines: 3,
//                                   style: TextStyle(color: Colors.grey),
//                                 )),
//                             SizedBox(
//                               height: 2,
//                             ),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               children: [
//                                 Icon(
//                                   Icons.more_time_outlined,
//                                   size: 20,
//                                 ),
//                                 SizedBox(
//                                   width: 4,
//                                 ),
//                                 Text(
//                                   "13 nov 2023 01:00AM",
//                                   style: TextStyle(
//                                       color: Colors.grey,
//                                       fontWeight: FontWeight.w300,
//                                       fontSize: 15),
//                                 )
//                               ],
//                             )
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//               Container(
//
//                 decoration: BoxDecoration(
//                   gradient: LinearGradient(colors: [
//                     MyColor.PRECRIPTION_GRADIENT_START_COLOR,
//                     MyColor.PRECRIPTION_GRADIENT_END_COLOR,
//                   ]),
//                 ),
//                 child: Column(
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.only(
//                           top: 10, left: 16.0, right: 16.0),
//                       child: ClipRRect(
//
//                         borderRadius: BorderRadius.circular(30.0),
//                         // child: _appointmentBody!.appointmentImages!.isNotEmpty?Image.network(_appointmentBody!.appointmentImages[0],fit: BoxFit.cover,):Image.asset(
//                  child:  Image.asset('assets/images/back_icon.png')     ,
//                         )),
//
//                     Center(
//                       child: Container(
//                         decoration: BoxDecoration(
//                           gradient: LinearGradient(colors: [
//                             MyColor.PRECRIPTION_GRADIENT_START_COLOR,
//                             MyColor.PRECRIPTION_GRADIENT_END_COLOR,
//                           ]),
//                         ),
//                         padding: EdgeInsets.only(
//                             left: 20.0, right: 20.0, top: 40, bottom: 20),
//                         child: Center(
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text("Status:",style: TextStyle(color: Colors.white),),
//                                   SizedBox(width: 8,),
//                                   Text( '22'/*listOfStatus[int.parse(_appointmentBody!.status)]*/,style: TextStyle(color: Colors.white),)
//                                 ],
//                               ),
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Text("Date:",style: TextStyle(color: Colors.white),),
//                                   SizedBox(width: 8,),
//                                   Text("body"/*_appointmentBody!.date.toString()*/,style: TextStyle(color: Colors.white),)
//                                 ],
//                               ),
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Text("Description:",style: TextStyle(color: Colors.white),),
//                                   SizedBox(width: 8,),
//                                   Flexible(child: Text("body"/*_appointmentBody!.description.toString()*/,style: TextStyle(color: Colors.white),))
//                                 ],
//                               )
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       height: 40,
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Container(
//                         width: 325,
//                         height: 52,
//                         color: Color.fromRGBO(255, 255, 255, 0.2),
//                         child: Center(
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             children: [
//                               Text(
//                                 "Time Slot allowted",
//                                 style: TextStyle(
//                                     color: Colors.white,
//                                     fontWeight: FontWeight.bold),
//                               ),
//                               SizedBox(
//                                 width: 10,
//                               ),
//                               Text(
//                                 "${"body"/*_appointmentBody!.timeSlotData.timeSlot*/}",
//                                 style: AppConstant.Lextendnew(
//                                     context, Colors.white, 15),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(
//                 height: 40,
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Center(
//                   child: InkWell(
//                     onTap: () {
//                       // Get.to(Chat(null, null, null, null, null));
//                     },
//                     child: Container(
//                       width: 289,
//                       height: 44,
//                       decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(30),
//                           gradient: AppConstant.BUTTON_COLOR,
//                           color: Colors.blue),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Image.asset(
//                             "assets/images/chat_icon.png",
//                             color: Colors.white,
//                           ),
//                           SizedBox(
//                             width: 8,
//                           ),
//                           Center(
//                               child: Text(
//                             "Chat",
//                             style: TextStyle(
//                                 color: Colors.white,
//                                 fontWeight: FontWeight.bold),
//                           )),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               )
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
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:get/get.dart';
import 'package:dentocoreauth/models/appointment_response.dart';
import '../../controllers/appoinment_detail_page.dart';
import '../../utils/app_constant.dart';
import '../../utils/component_screen.dart';
import '../../utils/mycolor.dart';
import '../chat/chat.dart';

class AppointmentDetails extends StatefulWidget {
  // AppointmentBody? _appointmentBody;
  final Body getitemslist;

  AppointmentDetails(this.getitemslist/*AppointmentBody? appointmentBody*/) {
    // this._appointmentBody = appointmentBody;
  }

  @override
  State<AppointmentDetails> createState() =>
      _AppointmentDetailsState(/*_appointmentBody*/);
}

class _AppointmentDetailsState extends State<AppointmentDetails> {
  // AppointmentBody? _appointmentBody;

  _AppointmentDetailsState(/*AppointmentBody? appointmentBody*/) {
    // this._appointmentBody = appointmentBody;
  }

  late Body item;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  item = widget.getitemslist;
  }


  final listOfStatus = [
    "Pending",
    "Rejected",
    "Visited",
    "Accepted",
  ];

  // final List<Map<String, String>> medicineData = [
  //   {"medicineName": "Medicine 1", "doses": "200 ml", "time": "Mor-Even"},
  //   {
  //     "medicineName": "Medicine 2",
  //     "doses": "1 Tablet",
  //     "time": "Mor-Noon-Even"
  //   },
  //   {
  //     "medicineName": "Medicine 3",
  //     "doses": "1 Tablet",
  //     "time": "Mor-Noon-Even"
  //   },
  // ];

  @override
  Widget build(BuildContext context) {
    print("Abhi:- print item data :- ${widget.getitemslist.timeSlotData ?? "no time"}");
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                // Image.asset(
                //   "assets/newImages/appointmentdeails.png",
                //   height: height * 0.3,
                //   width: width,
                //   fit: BoxFit.cover,
                // ),
                // Image.network(item.serviceData?.image ?? "assets/newImages/appointmentdeails.png"),
                Container(
                  height: height*0.35,
                  width: double.infinity,
                  // decoration: BoxDecoration(
                  //   borderRadius: BorderRadius.circular(0),
                  //   image: DecorationImage(image: NetworkImage(item.serviceData?.image ??"assets/newImages/noimagefound.png"))
                  // ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(0),
                    child: CachedNetworkImage(
                      // Check if nextVisitHistory exists and has items
                      imageUrl: item.serviceData?.image != null &&
                          item.serviceData!.image!.isNotEmpty
                          ? item.serviceData?.image ?? ""
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
                // Custom App Bar
                Positioned(
                  top: 00,
                  left: 0,
                  right: 0,
                  // bottom: height * 0.3,
                  child: CustomAppBar(title: 'Appointment Details'),
                ),
              ],
            ),
            SizedBox(
              height: height * 0.02,
            ),
            Row(
              children: [
                Container(
                  height: height * 0.05,
                  width: width * 0.26,
                  decoration: BoxDecoration(
                    color: Colors.pink[200],
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20),
                        bottomRight: Radius.circular(20)),
                  ),
                  child: Center(
                      child: Text(
                    // "25 Now",
                        widget.getitemslist.date ?? "no data",
                    style: TextStyle(
                        fontWeight: FontWeight.w600, color: Colors.white,fontSize: 14),
                  )),
                ),
                SizedBox(
                  width: width * 0.03,
                ),
                Column(
                  children: [
                    Text(widget.getitemslist.serviceData?.title ?? " Disease name"),
                    // Text("ID- ##202121"),
                    Text("ID- ##${widget.getitemslist.id}"), Text("Booking time : ${widget.getitemslist.timeSlottime ?? "no time"}",style: TextStyle(color: Colors.black),),
                  ],
                )
              ],
            ),
            SizedBox(
              height: height * 0.02,
            ),
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
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                  ),
                ),
                DataColumn(
                  label: Text(
                    "Doses",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                  ),
                ),
                DataColumn(
                  label: Text(
                    "Time",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                  ),
                ),
              ],
              rows: widget.getitemslist.prescriptions?.map((row) {
                return DataRow(cells: [
                  DataCell(Text(
                    row.medicine ?? "N/A",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
                  )),
                  DataCell(Text(
                    row.dose ?? "N/A",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
                  )),
                  DataCell(Text(
                    row.time ?? "N/A",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
                  )),
                ]);
              }).toList() ?? [], // Fallback to empty list if prescriptions is null
            ),
            SizedBox(
              height: height * 0.01,
            ),
            Container(
              height: 30,
              color: Colors.deepOrange[300],
              child: Center(child: Text("Next Visit: ${widget.getitemslist.nextVisitedDate ?? "Next Visit 12/05/25, 2 PM"} ${widget.getitemslist.nextVisitedTime ?? "2 PM"}")),
            ),
            SizedBox(
              height: height*0.01,
            ),

            Center(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: width * 0.00),
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
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: CachedNetworkImage(
                    // Check if nextVisitHistory exists and has items
                    imageUrl: widget.getitemslist.nextVisitHistory != null &&
                        widget.getitemslist.nextVisitHistory!.isNotEmpty
                        ? widget.getitemslist.nextVisitHistory![0].fileUrl ?? ""
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
            ),
            SizedBox(
              height: height*0.01,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RichText(text: TextSpan(children: [
                TextSpan(text: 'Remark :- ',style: TextStyle(color: Colors.deepOrange[300],fontSize: 16,fontWeight: FontWeight.w500),),
              TextSpan(text: "${widget.getitemslist.nextVisitHistory != null &&
                  widget.getitemslist.nextVisitHistory!.isNotEmpty
                  ? widget.getitemslist.nextVisitHistory![0].remark ?? "No remmark"
                  : "No remark"}",style: TextStyle(color: Colors.black))
              ],),),
            ),
            SizedBox(
              height: height*0.01,
            ),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                    child: InkWell(
                  onTap: () {
                    Get.to(Chat(null,'http name'));
                  },
                  child: Container(
                    width: 289,
                    height: 44,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.deepOrange[300],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/images/chat_icon.png",
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Center(
                            child: Text(
                          "Chat",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        )),
                      ],
                    ),
                  ),
                ))),SizedBox(
              height: height*0.01,
            ),
          ],
        ),
      ),
    );
  }
}
