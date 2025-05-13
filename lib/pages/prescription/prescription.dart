import 'package:carousel_slider/carousel_slider.dart';
import 'package:drop_shadow/drop_shadow.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:get/get.dart';
import 'package:open_file/open_file.dart';
import 'package:dentocoreauth/pages/chat/chat.dart';
import '../../Utills/Utills.dart';
import '../../controllers/user_controller.dart';
import '../../models/appointment_response.dart';
import '../../utills/pdfviewe.dart';
import '../../utils/app_constant.dart';
import '../../utils/component_screen.dart';
import '../../utils/mycolor.dart';
import 'package:photo_view/photo_view.dart';

import 'image_viewer.dart';

class MyPrescription extends StatefulWidget {
  List? _appointmentBody;
  bool? _isReschedule;

  MyPrescription(List? appointmentBody,bool? isReschedule) {
    this._appointmentBody = appointmentBody;
    this._isReschedule=isReschedule;
  }

  @override
  State<MyPrescription> createState() => _PrescriptionState(_appointmentBody!,_isReschedule);
}

class _PrescriptionState extends State<MyPrescription> {
  List? _appointmentBody;
  bool? _isReschedule;
  final UserController userController = Get.find();

  _PrescriptionState(List? appointmentBody,bool? isReschedule) {
    this._appointmentBody = appointmentBody;
    this._isReschedule=isReschedule;

    if(_isReschedule==true){

    }
  }

  @override
  void initState() {
    super.initState();
    imgList.clear();
    for (int i = 0; i < this._appointmentBody!.length; i++) {
      imgList.add(this._appointmentBody![i].toString());
    }
    // Future.delayed(Duration(milliseconds: 500),(){
    //   if(userController.getPrescription!=null){
    //     userController.getPrescction(this.appointmentID.toString()).then((value) => {
    //
    //     });
    //   }
    // });


  }

  Dialog errorDialog(BuildContext context) {
    return Dialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0)), //this right here
        child: Container(
          height: 200.0,
          width: 200.0,
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
                  'Time has been rescheduled',
                  style: TextStyle(color: Colors.red, fontSize: 14),
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

  final List<String> imgList = [];

  // var rowSpacer = TableRow(children: [
  //   SizedBox(
  //     height: 8,
  //   ),
  //   SizedBox(
  //     height: 8,
  //   ),
  //   SizedBox(
  //     height: 8,
  //   )
  // ]);



  getTable(int i) {
    return TableRow(children: [
      Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            '${userController.getPrescription.prescription![i].medicine}'.capitalizeFirst!,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            '${userController.getPrescription.prescription![i].dose}',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            '${userController.getPrescription.prescription![i].time}',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(

                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CustomAppBar(title: 'Notification'),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   crossAxisAlignment: CrossAxisAlignment.center,
                      //   children: [
                      //     // Visibility(
                      //     //   visible: true,
                      //     //   maintainSize: true,
                      //     //   maintainState: true,
                      //     //   maintainSemantics: true,
                      //     //   maintainAnimation: true,
                      //     //   child: Container(
                      //     //     width: MediaQuery.of(context).size.width / 3,
                      //     //     alignment: Alignment.centerLeft,
                      //     //     child: Padding(
                      //     //       padding: EdgeInsets.only(top: 10),
                      //     //       child: Bounceable(
                      //     //         onTap: () {
                      //     //           Get.back();
                      //     //         },
                      //     //         child: Container(
                      //     //             width: 70,
                      //     //             height: 40,
                      //     //             decoration: BoxDecoration(
                      //     //               color: Colors.white,
                      //     //               borderRadius: BorderRadius.only(
                      //     //                   topRight: Radius.circular(30),
                      //     //                   bottomRight: Radius.circular(30)),
                      //     //               boxShadow: [
                      //     //                 BoxShadow(
                      //     //                   color: Colors.grey.withOpacity(0.5),
                      //     //                   spreadRadius: 1,
                      //     //                   blurRadius: 2,
                      //     //                   offset: Offset(0,
                      //     //                       3), // changes position of shadow
                      //     //                 ),
                      //     //               ],
                      //     //             ),
                      //     //             child: Container(
                      //     //               decoration: BoxDecoration(
                      //     //                   borderRadius: BorderRadius.only(
                      //     //                       topRight: Radius.circular(30),
                      //     //                       bottomRight:
                      //     //                           Radius.circular(30)),
                      //     //                   gradient: AppConstant.BUTTON_COLOR),
                      //     //               child: Image.asset(
                      //     //                 'assets/images/back_icon.png',
                      //     //                 width: 10,
                      //     //                 height: 10,
                      //     //               ),
                      //     //             )),
                      //     //       ),
                      //     //     ),
                      //     //   ),
                      //     // ),
                      //     // Container(
                      //     //   alignment: Alignment.center,
                      //     //   width: MediaQuery.of(context).size.width / 3,
                      //     //   child: Padding(
                      //     //     padding: const EdgeInsets.only(top: 15.0),
                      //     //     child: Container(
                      //     //       height: 40,
                      //     //       child: AppConstant.HEADLINE_TEXT(
                      //     //           AppConstant.TITLE_TEXT_PRESCRIPTION,
                      //     //           context),
                      //     //     ),
                      //     //   ),
                      //     // ),
                      //
                      //     // Flexible(
                      //     //   child: Visibility(
                      //     //     visible: false,
                      //     //     maintainAnimation: true,
                      //     //     maintainSemantics: true,
                      //     //     maintainState: true,
                      //     //     maintainSize: true,
                      //     //     child: Container(
                      //     //       width: MediaQuery.of(context).size.width / 3,
                      //     //       alignment: Alignment.centerRight,
                      //     //       child: Padding(
                      //     //           padding: EdgeInsets.only(top: 0, right: 10),
                      //     //           child: Icon(Icons.notifications)),
                      //     //     ),
                      //     //   ),
                      //     // )
                      //   ],
                      // ),  // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   crossAxisAlignment: CrossAxisAlignment.center,
                      //   children: [
                      //     // Visibility(
                      //     //   visible: true,
                      //     //   maintainSize: true,
                      //     //   maintainState: true,
                      //     //   maintainSemantics: true,
                      //     //   maintainAnimation: true,
                      //     //   child: Container(
                      //     //     width: MediaQuery.of(context).size.width / 3,
                      //     //     alignment: Alignment.centerLeft,
                      //     //     child: Padding(
                      //     //       padding: EdgeInsets.only(top: 10),
                      //     //       child: Bounceable(
                      //     //         onTap: () {
                      //     //           Get.back();
                      //     //         },
                      //     //         child: Container(
                      //     //             width: 70,
                      //     //             height: 40,
                      //     //             decoration: BoxDecoration(
                      //     //               color: Colors.white,
                      //     //               borderRadius: BorderRadius.only(
                      //     //                   topRight: Radius.circular(30),
                      //     //                   bottomRight: Radius.circular(30)),
                      //     //               boxShadow: [
                      //     //                 BoxShadow(
                      //     //                   color: Colors.grey.withOpacity(0.5),
                      //     //                   spreadRadius: 1,
                      //     //                   blurRadius: 2,
                      //     //                   offset: Offset(0,
                      //     //                       3), // changes position of shadow
                      //     //                 ),
                      //     //               ],
                      //     //             ),
                      //     //             child: Container(
                      //     //               decoration: BoxDecoration(
                      //     //                   borderRadius: BorderRadius.only(
                      //     //                       topRight: Radius.circular(30),
                      //     //                       bottomRight:
                      //     //                           Radius.circular(30)),
                      //     //                   gradient: AppConstant.BUTTON_COLOR),
                      //     //               child: Image.asset(
                      //     //                 'assets/images/back_icon.png',
                      //     //                 width: 10,
                      //     //                 height: 10,
                      //     //               ),
                      //     //             )),
                      //     //       ),
                      //     //     ),
                      //     //   ),
                      //     // ),
                      //     // Container(
                      //     //   alignment: Alignment.center,
                      //     //   width: MediaQuery.of(context).size.width / 3,
                      //     //   child: Padding(
                      //     //     padding: const EdgeInsets.only(top: 15.0),
                      //     //     child: Container(
                      //     //       height: 40,
                      //     //       child: AppConstant.HEADLINE_TEXT(
                      //     //           AppConstant.TITLE_TEXT_PRESCRIPTION,
                      //     //           context),
                      //     //     ),
                      //     //   ),
                      //     // ),
                      //
                      //     // Flexible(
                      //     //   child: Visibility(
                      //     //     visible: false,
                      //     //     maintainAnimation: true,
                      //     //     maintainSemantics: true,
                      //     //     maintainState: true,
                      //     //     maintainSize: true,
                      //     //     child: Container(
                      //     //       width: MediaQuery.of(context).size.width / 3,
                      //     //       alignment: Alignment.centerRight,
                      //     //       child: Padding(
                      //     //           padding: EdgeInsets.only(top: 0, right: 10),
                      //     //           child: Icon(Icons.notifications)),
                      //     //     ),
                      //     //   ),
                      //     // )
                      //   ],
                      // ),
                      // SizedBox(
                      //   height: 8,
                      // ),
                      // SizedBox(
                      //   child: Container(
                      //     height: 2,
                      //     decoration:
                      //         BoxDecoration(
                      //             color: Colors.grey, boxShadow: [
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
              Visibility(
                visible: false,
                child: Container(
                  margin: EdgeInsets.all(20),
                  decoration: BoxDecoration(

                      borderRadius: BorderRadius.circular(20),
                      color: Colors.blue.shade50),
                  child: Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Appointment. ID-#204521",
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            Container(
                                width: 200,
                                child: Text(
                                  AppConstant.dummy_text,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 3,
                                  style: TextStyle(color: Colors.grey),
                                )),
                            SizedBox(
                              height: 2,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.more_time_outlined,
                                  size: 20,
                                ),
                                SizedBox(
                                  width: 4,
                                ),
                                Text(
                                  "13 nov 2023 01:00AM",
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w300,
                                      fontSize: 15),
                                )
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(
                  color: MyColor.primarycolor,
                    // gradient: LinearGradient(
                    //   begin: Alignment.topCenter,
                    //   end: AlignmentDirectional.bottomCenter,
                    //   colors: [
                    //     // Color.fromRGBO(0, 127, 146, 1),
                    //     // Color.fromRGBO(0, 127, 146, 1),
                    //     // Color.fromRGBO(0, 127, 146, 1),
                    //     // Color.fromRGBO(0, 127, 146, 1),
                    //
                    //   ],
                    // )
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 10, left: 16.0, right: 16.0),
                      child: Stack(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            child: CarouselSlider(
                              options: CarouselOptions(
                                autoPlay: true,
                                aspectRatio: 1.9,
                                clipBehavior: Clip.hardEdge,
                                enableInfiniteScroll: false,
                                enlargeStrategy:
                                    CenterPageEnlargeStrategy.height,
                                enlargeCenterPage: false,
                                onScrolled: (index) {
                                  //  final util=Utills()..showSnackBar("Alert", index.toString(), true);
                                },
                                padEnds: true,
                                pageSnapping: true,
                                viewportFraction: 1,
                              ),
                              items: imgList
                                  .map((item) => InkWell(
                                        onTap: () {
                                          // PhotoView(
                                          //   imageProvider: NetworkImage("${item}"),
                                          // );
                                          //   final util=Utills()..showSnackBar("Alert", "clicked$item}", true);
                                          debugPrint("urlimg" + item);
                                          Get.to(ImageViewer(item));
                                        },
                                        child: Stack(children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                              child: Image.network(
                                                item,
                                                fit: BoxFit.fitHeight,
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                errorBuilder: (context,
                                                    exception, stackTrace) {
                                                  return Image.asset(
                                                      "assets/images/app_logo.png");
                                                },
                                              ),
                                            ),
                                          ),
                                        ]),
                                      ))
                                  .toList(),
                            ),
                          ),
                          Visibility(
                            visible: false,
                            child: Positioned(
                              top: 55,
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Icon(Icons.swipe_left),
                              ),
                            ),
                          ),
                          Visibility(
                            visible: false,
                            child: Positioned(
                              top: 55,
                              right: 10,
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Icon(Icons.swipe_right),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 30),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Appointment.ID- #' +
                                    '${userController.getPrescription.id}',
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    'Date - ',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                  Text(
                                    '${userController.getPrescription.date}'
                                        .substring(0, 10),
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Description - ',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.only(left: 10),
                                  width: MediaQuery.of(context).size.width,
                                  child: Text(
                                    '${userController.getPrescription.description}'.capitalizeFirst!,
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),

                    Center(
                      child: Container(
                        decoration: BoxDecoration(


                            // gradient: LinearGradient(
                            //   begin: Alignment.topCenter,
                            //   end: AlignmentDirectional.bottomCenter,
                            //   colors: [
                            //     Color.fromRGBO(0, 127, 146, 1),
                            //     Color.fromRGBO(0, 127, 146, 1),
                            //     Color.fromRGBO(0, 127, 146, 1),
                            //     Color.fromRGBO(0, 127, 146, 1),
                            //
                            //   ],
                            // )
                        ),
                        padding: EdgeInsets.only(
                            left: 20.0, right: 20.0, top: 10, bottom: 20),
                        child: Center(
                            child: Obx(
                          () => Table(
                            children: [
                              TableRow(children: [
                                Center(
                                  child: Text(
                                    'Medicine Name',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ),
                                Center(
                                  child: Text('Doses',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white)),
                                ),
                                Center(
                                  child: Text('Time',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white)),
                                ),
                              ]),
                              TableRow(children: [
                                Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(''),
                                  ),
                                ),
                                Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(''),
                                  ),
                                ),
                                Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(''),
                                  ),
                                ),
                              ]),
                              for (int i = 0;
                                  i <
                                      userController
                                          .getPrescription.prescription!.length;
                                  i++)
                                getTable(i)
                            ],
                          ),
                        )),
                      ),
                    ),

                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      width: MediaQuery.of(context).size.width,
                      height: userController.getPrescription.next!.length == 1
                          ? 100
                          : 200,
                      child: userController.getPrescription.next!.length == 0
                          ? Center(
                              child: Text("No next visited data found!"),
                            )
                          : ListView.builder(
                              itemBuilder: (c, i) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: 50,
                                              height: 50,
                                              color: Colors.white,
                                              child: InkWell(
                                                  onTap: () {
                                                    if(userController.getPrescription.next![i].file!.contains(".pdf"))
                                                   {
                                                     debugPrint("yesss"+userController.getPrescription.next![i].file!.toString());
                                                    // OpenFile.open(userController.getPrescription.next![i].file!.toString());
                                                   //  PDF().cachedFromUrl(userController.getPrescription.next![i].file!);
                                                    final url=userController.getPrescription.next![i].file!;
                                                     Navigator.push(
                                                       context,
                                                       MaterialPageRoute<dynamic>(
                                                         builder: (_) =>  PDFViewerFromUrl(
                                                           url: url.toString(),
                                                         ),
                                                       ),
                                                     );
                                                 
                                                 
                                                   }else{
                                                      Get.to(ImageViewer(
                                                          userController
                                                              .getPrescription
                                                              .next![i]
                                                              .file
                                                              .toString()));
                                                    }

                                                  },
                                                  child: userController
                                                          .getPrescription
                                                          .next![i]
                                                          .file!
                                                          .isEmpty||userController
                                                      .getPrescription
                                                      .next![i]
                                                      .file=="${AppConstant.BASE_URL+"/upload/banner/"}"

                                                  ///upload/banner/
                                                  //https://work.dbvertex.com/dentist1/assets/images/logo.png
                                                      ? Image.network(
                                                      "${AppConstant.BASE_URL+"/assets/images/logo.png"}",
                                                      fit: BoxFit.cover)
                                                      :userController.getPrescription.next![i].file!.contains(".pdf")?
                                                  Image.network(
                                                      "${AppConstant.BASE_URL+"/assets/images/logo.png"}",
                                                      fit: BoxFit.cover)

                                                  :Image.network(
                                              "${userController.getPrescription.next![i].file}",
                                                  fit: BoxFit.cover)),
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Revisited Date - ${userController.getPrescription.next![i].date}'
                                                      .substring(0, 28),
                                                  overflow: TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white),
                                                ),

                                                    InkWell(
                                                      onTap: (){
                                                        Get.bottomSheet(
                                                          Column(
                                                                mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                                children: [
                                                                  Padding(
                                                                    padding: const EdgeInsets.all(8.0),
                                                                    child: Align(
                                                                      alignment: Alignment.centerRight,
                                                                      child: InkWell(
                                                                          onTap: (){
                                                                            Get.back();
                                                                          },
                                                                          child: Icon(Icons.cancel)),

                                                                    ),
                                                                  ),
                                                                  Center(
                                                                    child: Text("Remark",style: TextStyle(
                                                                      fontSize: 20,
                                                                      fontWeight: FontWeight.bold
                                                                    ),),
                                                                  ),
                                                                  Padding(
                                                                    padding: const EdgeInsets.all(16.0),
                                                                    child: RichText(
                                                                        text: TextSpan(text: "",children: [TextSpan(text:userController.getPrescription.next![i].remark!.capitalizeFirst!,style: TextStyle(color: Colors.black))]),
                                                                    ),

                                                                  ),
                                                                  SizedBox(
                                                                    height:
                                                                    50,
                                                                  )
                                                                ],
                                                              ),
                                                          barrierColor:
                                                          Colors.red[50],
                                                          isDismissible: true,
                                                          enableDrag: false,
                                                          shape: ContinuousRectangleBorder(
                                                            borderRadius: BorderRadius.circular(100),

                                                          ),);


                                                      },
                                                      child: Container(
                                                        width:200,
                                                        child: Text(
                                                          'Remark - ${userController.getPrescription.next![i].remark}'.capitalizeFirst!,
                                                          overflow: TextOverflow.ellipsis,
                                                         maxLines: 1,
                                                         style: TextStyle(
                                                              overflow: TextOverflow
                                                                  .ellipsis,
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight.bold,
                                                              color: Colors.white),
                                                        ),
                                                      ),
                                                    ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                        key: UniqueKey(),
                              itemCount:
                                  userController.getPrescription.next!.length,
                            ),
                    ),
                    Visibility(
                      visible: false,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(

                          margin: EdgeInsets.symmetric(horizontal: 10),
                          height: 52,
                          color: Color.fromRGBO(255, 255, 255, 0.2),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Next Visit Date",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  userController.getPrescription!.prescription!
                                              .length !=
                                          0
                                      ? userController!
                                          .getPrescription!.timeSlotData
                                          .toString()
                                          .substring(0, 10)??"No date"
                                      : "Not added yet!",
                                  style: AppConstant.Lextendnew(
                                      context, Colors.white, 15),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: false,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          height: 52,
                          color: Color.fromRGBO(255, 255, 255, 0.2),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Next Visit Time",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  userController.getPrescription!.prescription!
                                              .length !=
                                          0
                                      ? userController!
                                              .getPrescription!.timeSlotData
                                              .toString() ??
                                          "no data"
                                      : "Not added yet!",
                                  style: AppConstant.Lextendnew(
                                      context, Colors.white, 15),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: InkWell(
                    onTap: () {
                      // final util=Utills();
                      // util.showSnackBar("Alert", "Working on this", true);
                      Get.to(Chat(null, "from_home"));
                    },
                    child: Container(
                      width: 289,
                      height: 44,
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color:
                              Colors.grey.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 2,
                              offset: Offset(0,
                                  3), // changes position of shadow
                            ),
                          ],

                          borderRadius: BorderRadius.circular(30),
                         // gradient: AppConstant.BUTTON_COLOR,
                          color: Colors.blue),
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
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          )),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
