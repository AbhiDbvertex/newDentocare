// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bounceable/flutter_bounceable.dart';
// import 'package:get/get.dart';
//
// import '../../utils/app_constant.dart';
//
// class  Services extends StatefulWidget {
//   const Services({Key? key}) : super(key: key);
//
//   @override
//   State<Services> createState() => _ServicesState();
// }
//
// class _ServicesState extends State<Services> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
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
//                                   height: 30,
//                                   child: FittedBox(
//                                     child: AppConstant.HEADLINE_TEXT_SERVICE(
//                                         AppConstant.TITLE_TEXT_SERVICES,
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
//                           BoxDecoration(color: Colors.grey, boxShadow: [
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
//               SizedBox(
//                 height: AppConstant.APP_EXTRA_LARGE_PADDING,
//               ),
//               Center(
//                 child: Container(
//                   padding: EdgeInsets.only(left:AppConstant.LARGE_SIZE,right:AppConstant.LARGE_SIZE ),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Flex(
//                             direction: Axis.vertical,
//                             children:[ SingleChildScrollView(
//                               child: Column(
//                                   mainAxisAlignment: MainAxisAlignment.start,
//                                   crossAxisAlignment: CrossAxisAlignment.center,
//                                   children: [
//                                     Column(
//                                         mainAxisAlignment: MainAxisAlignment.start,
//                                         crossAxisAlignment: CrossAxisAlignment.center,
//                                         children: [
//                                           Text("General Dentistry",style: TextStyle(fontSize: 20,color: Color.fromRGBO(138, 159, 219, 1),)),
//                                           SizedBox(height: 2,),
//                                           Text("Dental Examinations"),
//                                           Text("Teeth Cleaning and Polishing"),
//                                           Text("Oral Hygiene Instructions"),
//                                           Text("Tooth Extractions"),
//                                           SizedBox(height: 8,),
//
//                                           Text("Cosmetic Dentistry:",style: TextStyle(fontSize: 20,color: Color.fromRGBO(138, 159, 219, 1),)),
//                                           SizedBox(height: 2,),
//                                           Text("Teeth Whitening"),
//                                           Text("Dental Veneers"),
//                                           Text("Smile Makeovers"),
//                                           Text(" Gum Contouring"),
//                                           SizedBox(height: 8,),
//
//                                           Text("Restorative Dentistry:",style: TextStyle(fontSize: 20,color: Color.fromRGBO(138, 159, 219, 1),)),
//                                           SizedBox(height: 2,),
//                                           Text("Dental Fillings (Composite, Amalgam)"),
//                                           Text("Dental Crowns (Metal, Ceramic, Zirconia)"),
//                                           Text("Dental Bridges"),
//                                           SizedBox(height: 8,),
//
//
//                                           Text("Orthodontics:", style: TextStyle(fontSize: 20,color: Color.fromRGBO(138, 159, 219, 1),)),
//                                           SizedBox(height: 2,),
//                                           Text("Traditional Braces"),
//                                           Text("Clear Aligners (Invisalign)"),
//                                           Text("Retainers"),
//                                           SizedBox(height: 8,),
//
//                                           Text("Endodontics:",style: TextStyle(fontSize: 20,color: Color.fromRGBO(138, 159, 219, 1),)),
//                                           SizedBox(height: 2,),
//                                           Text("Root Canal Treatment"),
//                                           Text("Apicoectomy (Root-End Surgery)"),
//                                           Text("Teeth Cleaning and Polishing"),
//                                           SizedBox(height: 8,),
//
//                                           Text("Periodontics:",style: TextStyle(fontSize: 20,color: Color.fromRGBO(138, 159, 219, 1),)),
//                                           SizedBox(height: 2,),
//                                           Text("Gum Disease Treatment"),
//                                           Text("Scaling and Root Planing"),
//                                           Text("Gum Grafting"),
//
//                                           SizedBox(height: 8,),
//
//                                           Text("Dental Implants:",style: TextStyle(fontSize: 20,color: Color.fromRGBO(138, 159, 219, 1),)),
//                                           SizedBox(height: 2,),
//                                           Text("Single Tooth Implants"),
//                                           Text("All-on-4 Implants"),
//                                           Text("Implant-Supported Dentures"),
//
//                                           SizedBox(height: 8,),
//
//                                           Text("Prosthodontics:",style: TextStyle(fontSize: 20,color: Color.fromRGBO(138, 159, 219, 1),)),
//                                           SizedBox(height: 2,),
//                                           Text("Dentures (Partial, Complete)"),
//                                           Text("Dental Bridges"),
//                                           Text("Implant-Supported Prosthetics"),
//
//                                           SizedBox(height: 8,),
//
//                                           Text("Pediatric Dentistry:",style: TextStyle(fontSize: 20,color: Color.fromRGBO(138, 159, 219, 1),)),
//                                           SizedBox(height: 2,),
//                                           Text("Children's Dental Examinations"),
//                                           Text("Dental Sealants"),
//                                           Text("Space Maintainers"),
//
//                                           SizedBox(height: 8,),
//
//
//                                           Text("Oral Surgery:",style: TextStyle(fontSize: 20,color: Color.fromRGBO(138, 159, 219, 1),)),
//                                           SizedBox(height: 2,),
//                                           Text("Wisdom Tooth Extraction"),
//                                           Text("Dental Implant Surgery"),
//                                           Text("Biopsies"),
//                                           SizedBox(height: 8,),
//
//                                           Text("Emergency Dentistry:",style: TextStyle(fontSize: 20,color: Color.fromRGBO(138, 159, 219, 1),)),
//                                           SizedBox(height: 2,),
//                                           Text("Same-Day Emergency Appointments"),
//                                           Text("Pain Relief and Management"),
//                                           SizedBox(height: 8,),
//
//                                           Text("TMJ Disorder Treatment:",style: TextStyle(fontSize: 20,color: Color.fromRGBO(138, 159, 219, 1),)),
//                                           SizedBox(height: 2,),
//                                           Text("Diagnosis and Treatment of"),
//                                           Text("Temporomandibular Joint Issues"),
//
//                                           SizedBox(height: 8,),
//                                           Text("Sleep Apnea Treatment:",style: TextStyle(fontSize: 20,color: Color.fromRGBO(138, 159, 219, 1),)),
//                                           SizedBox(height: 2,),
//                                           Text("Oral Appliances for Sleep Apnea"),
//
//                                           SizedBox(height: 8,),
//
//                                           Text("Dental Sedation:",style: TextStyle(fontSize: 20,color: Color.fromRGBO(138, 159, 219, 1),)),
//                                           SizedBox(height: 2,),
//                                           Text("Sedation Options for Anxious Patients"),
//                                           SizedBox(height: 8,),
//
//                                           Text("Oral Cancer Screenings:",style: TextStyle(fontSize: 20,color: Color.fromRGBO(138, 159, 219, 1),)),
//                                           SizedBox(height: 2,),
//                                           Text("Regular Oral Cancer Examinations"),
//                                           SizedBox(height: 8,),
//
//                                         ],
//                                       ),
//
//                                   ],
//                                 ),
//
//                             ),]
//                           ),
//                       SizedBox(
//                         height: AppConstant.LARGE_SIZE,
//                       ),
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

///                          new code
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_bounceable/flutter_bounceable.dart';
// import 'package:get/get.dart';
// import 'package:dentocoreauth/utils/mycolor.dart';
//
// import '../../utils/app_constant.dart';
// import '../../utils/component_screen.dart';
//
// class Services extends StatefulWidget {
//   const Services({Key? key}) : super(key: key);
//
//   @override
//   State<Services> createState() => _ServicesState();
// }
//
// class _ServicesState extends State<Services> {
//   final List<Color> colorslist = [
//     Colors.purple[200]!,
//     Colors.orange[200]!,
//     Colors.pink[200]!,
//     Colors.blue[200]!,
//     Colors.green[200]!,
//     Colors.red[200]!,
//     Colors.yellow[200]!,
//   ];
//
//   final List<String> ServicesList = [
//     "Sleep Apnea Treatment",
//     "TMJ Disorder Treatment",
//     "Pediatric Dentistry",
//     "Prosthodontics",
//     "Dental Implants",
//     "Restorative Dentistry",
//     "General Dentistry",
//     "Dental Examinations",
//     "Cosmetic Dentistry",
//     "Orthodontics",
//     "Endodontics",
//     "Periodontics",
//     "Oral Surgery",
//     "Oral Cancer Screenings",
//     "Emergency Dentistry",
//   ];
//
//   final List ServicesImages = [
//     "assets/newImages/SleepApneaTreatment.jpg",
//     "assets/newImages/TMJDisorderTreatment.jpg",
//     "assets/newImages/PediatricDentistry.webp",
//     "assets/newImages/Prosthodontics-img.jpg",
//     "assets/newImages/DentalImplants.webp",
//     "assets/newImages/RestorativeDentistry.webp",
//     "assets/newImages/GeneralDentistry.jpg",
//     "assets/newImages/DentalExaminations.jpg",
//     "assets/newImages/CosmeticDentistry.jpg",
//     "assets/newImages/Orthodontics.webp",
//     "assets/newImages/Endodontics.jpg",
//     "assets/newImages/Periodontics.jpg",
//     "OralSurgery.jpg",
//     "assets/newImages/OralCancerScreenings.jpeg",
//     "assets/newImages/EmergencyDentistry.jpg",
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return AnnotatedRegion<SystemUiOverlayStyle>(
//         value: SystemUiOverlayStyle(
//           statusBarColor: MyColor.primarycolor,
//           statusBarIconBrightness: Brightness.light,
//           statusBarBrightness: Brightness.light,
//           systemNavigationBarColor: Colors.transparent,
//         ),
//         child: Scaffold(
//           body: SafeArea(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 CustomAppBar(title: 'Service'),
//                 Expanded(
//                   child: ListView.builder(
//                     itemCount: ServicesImages.length,
//                     padding: EdgeInsets.all(10),
//                     itemExtent: 165.0,
//                     itemBuilder: (context, index) {
//                       return Stack(
//                         children: [
//                           // Image.asset("assets/newImages/Serviceimage.png"),
//                           Image.asset(ServicesImages[index% ServicesImages.length]),
//                           Positioned(
//                             top: 90,
//                             left: 0,
//                             right: 0,
//                             bottom: 10,
//                             child: Padding(
//                               padding: const EdgeInsets.symmetric(horizontal: 18,vertical: 12),
//                               child: Container(
//                                 // height: 30,
//                                 // width: 100, //
//                                 decoration: BoxDecoration(
//                                   color: colorslist[index % colorslist.length],
//                                   borderRadius: BorderRadius.circular(25),
//                                 ),
//                                 child: Center(
//                                   child: Text(
//                                       ServicesList[index % ServicesList.length],style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600),),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       );
//                     },
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ));
//   }
// }

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:get/get.dart';
import 'package:dentocoreauth/utils/mycolor.dart';

import '../../controllers/services_controller.dart';
import '../../controllers/video_controller.dart';
import '../../utils/app_constant.dart';
import '../../utils/component_screen.dart';

class Services extends StatefulWidget {
  const Services({Key? key}) : super(key: key);

  @override
  State<Services> createState() => _ServicesState();
}

class _ServicesState extends State<Services> {
  final List<Color> colorslist = [
    Colors.purple[200]!,
    Colors.orange[200]!,
    Colors.pink[200]!,
    Colors.blue[200]!,
    Colors.green[200]!,
    Colors.red[200]!,
    Colors.yellow[200]!,
  ];

  final List<String> ServicesList = [
    "Sleep Apnea Treatment",
    "TMJ Disorder Treatment",
    "Pediatric Dentistry",
    "Dental Implants",
    "Restorative Dentistry",
    "General Dentistry",
    "Dental Examinations",
    "Cosmetic Dentistry",
    "Orthodontics",
    "Endodontics",
    "Periodontics",
    "Oral Surgery",
    "Oral Cancer Screenings",
    "Emergency Dentistry",
    "Prosthodontics",
  ];

  final List<String> ServicesImages = [
    "assets/newImages/SleepApneaTreatment.jpg",
    "assets/newImages/TMJDisorderTreatment.jpg",
    "assets/newImages/PediatricDentistry.webp",
    "assets/newImages/DentalImplants.webp",
    "assets/newImages/RestorativeDentistry.webp",
    "assets/newImages/GeneralDentistry.jpg",
    "assets/newImages/DentalExaminations.jpg",
    "assets/newImages/CosmeticDentistry.jpg",
    "assets/newImages/Orthodontics.webp",
    "assets/newImages/Endodontics.jpg",
    "assets/newImages/Periodontics.jpg",
    "assets/newImages/OralSurgery.jpg",
    "assets/newImages/OralCancerScreenings.jpeg",
    "assets/newImages/EmergencyDentistry.jpg",
    "assets/newImages/Prosthodontics-img.jpg",
  ];
  final VideoController videoController = Get.find();
  final Servicescontroller servicescontroller = Get.find();
  getgalleryimagess? imagesList;
  void fetchGalleryImages() async {
    imagesList = await servicescontroller.getImages();
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchGalleryImages();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: MyColor.primarycolor,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.light,
        systemNavigationBarColor: Colors.transparent,
      ),
      child: Scaffold(
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CustomAppBar(title: 'Service'),
              Expanded(
                child: imagesList == null ? Center(child: CircularProgressIndicator(),):
               /* ListView.builder(
                  itemCount: imagesList?.body?.length, // Full list length
                  padding: EdgeInsets.only(bottom: 20),
                  itemExtent: 170.0, // Adjusted for image + text
                  itemBuilder: (context, index) {
                    var item = imagesList!.body![index];
                    return Stack(
                      alignment: Alignment.center,
                      children: [
                        // Image with specified dimensions
                        Image.asset(
                          ServicesImages[index], // Unique image per item
                          width: double.infinity,
                          height: 200,
                          fit: BoxFit.cover,
                        ),
                        // Center(child: Image.network(item.image ?? "assets/newImages/videofiledimage.png")),
                        Positioned(
                          top: 100, // Below the image
                          left: 0,
                          right: 0,
                          bottom: 10,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 18,
                              vertical: 12,
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                color: colorslist[index % colorslist.length], // Cycle colors
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child: Center(
                                child: Text(
                                  // ServicesList[index], // Unique text per item
                                 "${item.title}",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),*/
                ListView.builder(
                  itemCount: imagesList?.body?.length ?? 0, // Safe check for null
                  padding: EdgeInsets.all(15), // Overall padding for ListView
                  itemBuilder: (context, index) {
                    var item = imagesList!.body![index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16.0), // Space between items
                      child: Stack(
                       // crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Image Container
                          Container(
                            height: height*0.23, // Fixed height for image
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(18),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.3),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(18),
                              child: Image.network(
                                item.image ?? "https://via.placeholder.com/150", // Fallback image
                                width: double.infinity,
                                height: 150,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Image.asset(
                                    "assets/newImages/videofiledimage.png",
                                    width: double.infinity,
                                    height: 150,
                                    fit: BoxFit.cover,
                                  );
                                },
                              ),
                            ),
                          ),
                          // Text Container
                          Positioned(
                            top: height*0.15,
                            bottom: 10,
                            left: 10,
                            right: 10,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 8.0), // Space between image and text
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 18),
                                decoration: BoxDecoration(
                                  color: colorslist[index % colorslist.length], // Cycle colors
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                child: Text(
                                  item.title ?? "No Title", // Fallback for null title
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}