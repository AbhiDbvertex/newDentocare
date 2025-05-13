// import 'package:double_back_to_close_app/double_back_to_close_app.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bounceable/flutter_bounceable.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:get/get.dart';
// import 'package:dentocoreauth/pages/video/video_play.dart';
// import 'package:dentocoreauth/pages/video/video_play_new.dart';
//
// import '../../controllers/video_controller.dart';
// import '../../utils/app_constant.dart';
//
// class Video extends StatefulWidget {
//   const Video({Key? key}) : super(key: key);
//
//   @override
//   State<Video> createState() => _VideoState();
// }
//
// class _VideoState extends State<Video> {
//   final VideoController videoController = Get.find();
//
//   @override
//   void initState() {
//     super.initState();
//
//     videoController.getVideos().then((value) => {
//           debugPrint("njtest" + "done"),
//           if (EasyLoading.isShow) {EasyLoading.dismiss()}
//         });
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//     videoController.dispose();
//     if (EasyLoading.isShow) {
//       EasyLoading.dismiss();
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: DoubleBackToCloseApp(
//         snackBar: SnackBar(content: Text("Double tap to exit")),
//         child: RefreshIndicator(
//           onRefresh: () async {
//             videoController.getVideos().then((value) => {
//                   if (EasyLoading.isShow) {EasyLoading.dismiss()}
//                 });
//           },
//           child: SafeArea(
//             child: Container(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Container(
//                     child: Center(
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: [
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             children: [
//                               Visibility(
//                                 visible: false,
//                                 maintainSize: true,
//                                 maintainState: true,
//                                 maintainSemantics: true,
//                                 maintainAnimation: true,
//                                 child: Container(
//                                   width: MediaQuery.of(context).size.width / 3,
//                                   alignment: Alignment.centerLeft,
//                                   child: Padding(
//                                     padding: EdgeInsets.only(top: 10),
//                                     child: Bounceable(
//                                       onTap: () {
//                                         Get.back();
//                                       },
//                                       child: Container(
//                                         width: 70,
//                                         height: 40,
//                                         decoration: BoxDecoration(
//                                           color: Colors.white,
//                                           borderRadius: BorderRadius.only(
//                                               topRight: Radius.circular(30),
//                                               bottomRight: Radius.circular(30)),
//                                           boxShadow: [
//                                             BoxShadow(
//                                               color:
//                                                   Colors.grey.withOpacity(0.5),
//                                               spreadRadius: 1,
//                                               blurRadius: 2,
//                                               offset: Offset(0,
//                                                   3), // changes position of shadow
//                                             ),
//                                           ],
//                                         ),
//                                         child: Container(
//                                           decoration: BoxDecoration(
//                                               borderRadius: BorderRadius.only(
//                                                   topRight: Radius.circular(30),
//                                                   bottomRight:
//                                                       Radius.circular(30)),
//                                               gradient:
//                                                   AppConstant.BUTTON_COLOR),
//                                           child: Image.asset(
//                                             'assets/images/back_icon.png',
//                                             width: 10,
//                                             height: 10,
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               Container(
//                                 alignment: Alignment.center,
//                                 width: MediaQuery.of(context).size.width / 3,
//                                 child: Padding(
//                                   padding: const EdgeInsets.only(top: 15.0),
//                                   child: Container(
//                                     height: 40,
//                                     child: AppConstant.HEADLINE_TEXT(
//                                         "Videos", context),
//                                   ),
//                                 ),
//                               ),
//                               Visibility(
//                                 visible: false,
//                                 maintainAnimation: true,
//                                 maintainSemantics: true,
//                                 maintainState: true,
//                                 maintainSize: true,
//                                 child: Container(
//                                   width: MediaQuery.of(context).size.width / 3,
//                                   alignment: Alignment.centerRight,
//                                   child: Padding(
//                                       padding:
//                                           EdgeInsets.only(top: 0, right: 10),
//                                       child: Icon(Icons.notifications)),
//                                 ),
//                               )
//                             ],
//                           ),
//                           SizedBox(
//                             height: 8,
//                           ),
//                           SizedBox(
//                             child: Container(
//                               height: 2,
//                               decoration:
//                                   BoxDecoration(color: Colors.grey, boxShadow: [
//                                 BoxShadow(
//                                   offset: Offset(2, 4),
//                                   color: Colors.black.withOpacity(
//                                     0.3,
//                                   ),
//                                   blurRadius: 3,
//                                 ),
//                               ]),
//                             ),
//                           )
//                         ],
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     height: 20,
//                   ),
//                   Expanded(
//                     child: Padding(
//                       padding: const EdgeInsets.only(
//                           top: 2.0, left: 8.0, right: 8.0, bottom: 8.0),
//                       child: Obx(() => videoController.isLoading == true
//                           ? Center(
//                               child: CircularProgressIndicator(),
//                             )
//                           : ListView.builder(
//                               itemBuilder: (c, i) {
//                                 return Stack(
//                                     alignment: Alignment.bottomLeft,
//                                     children: [
//                                       InkWell(
//                                         onTap: () {
//                                           var videolist = <String>[];
//                                           for (int i = 0;
//                                               i <
//                                                   videoController
//                                                       .getlist.length;
//                                               i++) {
//                                             videolist.add(
//                                                 "${videoController.getlist[i]!.videolink}");
//                                           }
//                                           //video_link:"${videoController.getlist[i]!.videolink}"
//
//                                           // Get.to(YoutubeAppDemo(videolist,"${videoController.getlist[i]!.title}"));
//                                         },
//                                         child: Padding(
//                                           padding: const EdgeInsets.only(
//                                               left: 8.00,
//                                               right: 8.00,
//                                               bottom: 16.00),
//                                           child: ClipRRect(
//                                             borderRadius:
//                                                 BorderRadius.circular(30.0),
//
//                                             // colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.2), BlendMode.dstATop),
//
//                                             child: Center(
//                                               child: Container(
//                                                 alignment: Alignment.center,
//                                                 height: 190.0,
//                                                 width: MediaQuery.of(context)
//                                                         .size
//                                                         .width -
//                                                     50.0,
//                                                 decoration: BoxDecoration(
//                                                     borderRadius:
//                                                         BorderRadius.circular(
//                                                             15),
//                                                     border: Border.all(
//                                                         color: Colors
//                                                             .lightBlueAccent,
//                                                         width: 2),
//                                                     image: DecorationImage(
//                                                       colorFilter:
//                                                           new ColorFilter.mode(
//                                                               Colors.grey
//                                                                   .withOpacity(
//                                                                       0.6),
//                                                               BlendMode.darken),
//                                                       image: NetworkImage(
//                                                           videoController
//                                                               .getlist[i]!.video
//                                                               .toString()),
//                                                       opacity: 1,
//                                                       fit: BoxFit.fill,
//                                                     )),
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                       Padding(
//                                         padding: const EdgeInsets.only(
//                                             left: 60.0, bottom: 30),
//                                         child: Text(
//                                           "${videoController.getlist[i]!.title}"
//                                               .capitalizeFirst!,
//                                           style: TextStyle(
//                                               color: Colors.white,
//                                               fontWeight: FontWeight.bold,
//                                               fontSize: 20),
//                                         ),
//                                       ),
//                                       Padding(
//                                         padding:
//                                             const EdgeInsets.only(bottom: 80),
//                                         child: Center(
//                                             child: InkWell(
//                                                 onTap: () {
//                                                   debugPrint("njtest1" +
//                                                       "${videoController.getlist[i]!.videolink}");
//                                                   //  Get.to(YoutubeAppDemo(video_link:"${videoController.getlist[i]!.videolink}",title: "${videoController.getlist[i]!.title}"));
//
//                                                   var videolist = <String>[];
//                                                   for (int j = 0;
//                                                       j <
//                                                           videoController
//                                                               .getlist.length;
//                                                       j++) {
//                                                     videolist.add(
//                                                         "${videoController.getlist[i]!.videolink}");
//                                                   }
//                                                   debugPrint("njtest1" +
//                                                       videolist.toString());
//                                                   //video_link:"${videoController.getlist[i]!.videolink}"
//
//                                                   //   videolist.add(videoController.getlist[i]!.videolink);
//                                                   Get.to(YoutubeAppDemo(
//                                                       videolist,
//                                                       "${videoController.getlist[i]!.title}"));
//                                                 },
//                                                 child: Image.asset(
//                                                   "assets/images/playicon.png",
//                                                   color: Colors.white,
//                                                   width: 50,
//                                                   height: 50,
//                                                 ))),
//                                       )
//                                     ]);
//                               },
//                               itemCount: videoController.getlist.length,
//                             )),
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class GradientText extends StatelessWidget {
//   const GradientText(
//     this.text, {
//     required this.gradient,
//     this.style,
//   });
//
//   final String text;
//   final TextStyle? style;
//   final Gradient gradient;
//
//   @override
//   Widget build(BuildContext context) {
//     return ShaderMask(
//       blendMode: BlendMode.srcIn,
//       shaderCallback: (bounds) => gradient.createShader(
//         Rect.fromLTWH(0, 0, bounds.width, bounds.height),
//       ),
//       child: Text(text, style: style),
//     );
//   }
// }

import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:dentocoreauth/pages/video/video_play.dart';
import 'package:dentocoreauth/pages/video/video_play_new.dart';
import 'package:dentocoreauth/pages/video/view_photos_screen.dart';

import '../../controllers/services_controller.dart';
import '../../controllers/video_controller.dart';
import '../../utils/app_constant.dart';
import '../../utils/mycolor.dart';

class Video extends StatefulWidget {
  final backarrow;

  const Video({Key? key, this.backarrow = true}) : super(key: key);

  @override
  State<Video> createState() => _VideoState();
}

class _VideoState extends State<Video> {

  final VideoController videoController = Get.find();
  final Servicescontroller servicescontroller = Get.find();
  getgalleryImagesfunction? imagesList;

  void fetchGalleryImages() async {
    imagesList = await videoController.getGalleryImages();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    fetchGalleryImages();
    videoController.getVideos().then((value) => {
          debugPrint("njtest" + "done"),
          if (EasyLoading.isShow) {EasyLoading.dismiss()}
        });
  }

  @override
  void dispose() {
    super.dispose();
    videoController.dispose();
    if (EasyLoading.isShow) {
      EasyLoading.dismiss();
    }
  }

  int isSelected = 0;

  @override
  Widget build(BuildContext context) {
    double height = kToolbarHeight;
    double width = MediaQuery.of(context).size.width;
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarColor: MyColor.primarycolor,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.light,
          systemNavigationBarColor: Colors.transparent,
        ),
        child: Scaffold(
          body: DoubleBackToCloseApp(
            snackBar: SnackBar(content: Text("Double tap to exit")),
            child: RefreshIndicator(
              onRefresh: () async {
                videoController.getVideos().then((value) => {
                      if (EasyLoading.isShow) {EasyLoading.dismiss()}
                    });
              },
              child: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              height: height * 1.8,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: MyColor.primarycolor,
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(20),
                                  bottomRight: Radius.circular(20),
                                ),
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      widget.backarrow
                                          ? Padding(
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              child: GestureDetector(
                                                onTap: () => Get.back(),
                                                child: Container(
                                                  height: height * 0.6,
                                                  width: width * 0.12,
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            9),
                                                  ),
                                                  child: Icon(
                                                      Icons.arrow_back_ios_new,
                                                      size: 18),
                                                ),
                                              ),
                                            )
                                          : SizedBox(),
                                      // widget.backarrow == false ? Padding(
                                      //   padding: const EdgeInsets.all(10.0),
                                      //   child: GestureDetector(
                                      //     onTap: () => Get.back(),
                                      //     child: Container(
                                      //       height: height * 0.6,
                                      //       width: width * 0.12,
                                      //       decoration: BoxDecoration(
                                      //         color: Colors.transparent,
                                      //         borderRadius:
                                      //         BorderRadius.circular(9),
                                      //       ),
                                      //       child: Icon(
                                      //           Icons.arrow_back_ios_new,
                                      //           size: 18),
                                      //     ),
                                      //   ),
                                      // ) : SizedBox(),
                                      Center(
                                          child: Text(
                                        "Gallery",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 18),
                                      )),
                                      Icon(
                                        Icons.abc,
                                        color: Colors.transparent,
                                      )
                                    ],
                                  ),
                                  widget.backarrow
                                      ? SizedBox()
                                      : SizedBox(
                                          height: height * 0.3,
                                        ),
                                  Center(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              isSelected = 0;
                                            });
                                          },
                                          child: Card(
                                            elevation: 3,
                                            child: Container(
                                              height: 34,
                                              width: width * 0.26,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.white),
                                                  color: isSelected == 0
                                                      ? Colors.white
                                                      : MyColor.primarycolor,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12)),
                                              child:
                                                  Center(child: Text("Video")),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: width * 0.03,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              isSelected = 1;
                                            });
                                          },
                                          child: Card(
                                            elevation: 3,
                                            child: Container(
                                              height: 34,
                                              width: width * 0.26,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.white),
                                                  color: isSelected == 1
                                                      ? Colors.white
                                                      : MyColor.primarycolor,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12)),
                                              child: const Center(
                                                  child: Text("Photo")),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    isSelected == 1
                        ? Expanded(
                            child: imagesList == null
                                ? Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : (imagesList!.body == null ||
                                        imagesList!.body!.isEmpty)
                                    ? Center(child: Text("No images found"))
                                    : GridView.builder(
                                        key: ValueKey(
                                            imagesList?.body?.length ?? 0),
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          crossAxisSpacing: 0,
                                        ),
                                        itemCount: imagesList!.body!.length,
                                        itemBuilder: (context, index) {
                                          var item = imagesList!.body![index];
                                          print(
                                              "Abhi:-image URL:-${item.image}");
                                          return GestureDetector(
                                            onTap: (){
                                             // Get.to(ViewPhotosScreen(item: item,));
                                              Get.to(ViewPhotosScreen(images: item.image ?? ""));
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Column(
                                                children: [
                                                  Container(
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                12)),
                                                    child: item.image != null
                                                        ? Image.network(
                                                            item.image!
                                                                    .startsWith(
                                                                        'http')
                                                                ? item.image!
                                                                : "https://work.dbvertex.com/dentist1${item.image!}",
                                                            scale: 4,
                                                            fit: BoxFit.cover,
                                                            errorBuilder:
                                                                (context, error,
                                                                    stackTrace) {
                                                              print(
                                                                  "Abhi:-image failed to load:-$error");
                                                              return Icon(
                                                                  Icons.error);
                                                            },
                                                          )
                                                        : Image.asset(
                                                            "assets/newImages/videofiledimage.png",
                                                            fit: BoxFit.cover,
                                                            scale: 4,
                                                          ),
                                                  ),
                                                  // Text(item.title ??"no data",)
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                          )
                        : SizedBox(),
                    isSelected == 0
                        ? Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 2.0, left: 8.0, right: 8.0, bottom: 8.0),
                              child: Obx(() => videoController.isLoading == true
                                  ? Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  : ListView.builder(
                                      itemBuilder: (c, i) {
                                        return Stack(
                                            alignment: Alignment.bottomLeft,
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  var videolist = <String>[];
                                                  for (int i = 0;
                                                      i <
                                                          videoController
                                                              .getlist.length;
                                                      i++) {
                                                    videolist.add(
                                                        "${videoController.getlist[i]!.videolink}");
                                                  }
                                                  //video_link:"${videoController.getlist[i]!.videolink}"

                                                  // Get.to(YoutubeAppDemo(videolist,"${videoController.getlist[i]!.title}"));
                                                },
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 8.00,
                                                          right: 8.00,
                                                          bottom: 16.00),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30.0),

                                                    // colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.2), BlendMode.dstATop),

                                                    child: Center(
                                                      child: Container(
                                                        alignment:
                                                            Alignment.center,
                                                        height: 190.0,
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width -
                                                            50.0,
                                                        decoration:
                                                            BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            15),
                                                                border: Border.all(
                                                                    color: Colors
                                                                        .lightBlueAccent,
                                                                    width: 2),
                                                                image:
                                                                    DecorationImage(
                                                                  colorFilter: new ColorFilter
                                                                      .mode(
                                                                      Colors
                                                                          .grey
                                                                          .withOpacity(
                                                                              0.6),
                                                                      BlendMode
                                                                          .darken),
                                                                  image: NetworkImage(
                                                                      videoController
                                                                          .getlist[
                                                                              i]!
                                                                          .video
                                                                          .toString()),
                                                                  opacity: 1,
                                                                  fit: BoxFit
                                                                      .fill,
                                                                )),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 60.0, bottom: 30),
                                                child: Text(
                                                  "${videoController.getlist[i]!.title}"
                                                      .capitalizeFirst!,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 20),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 80),
                                                child: Center(
                                                    child: InkWell(
                                                        onTap: () {
                                                          debugPrint("njtest1" +
                                                              "${videoController.getlist[i]!.videolink}");
                                                          //  Get.to(YoutubeAppDemo(video_link:"${videoController.getlist[i]!.videolink}",title: "${videoController.getlist[i]!.title}"));

                                                          var videolist =
                                                              <String>[];
                                                          for (int j = 0;
                                                              j <
                                                                  videoController
                                                                      .getlist
                                                                      .length;
                                                              j++) {
                                                            videolist.add(
                                                                "${videoController.getlist[i]!.videolink}");
                                                          }
                                                          debugPrint("njtest1" +
                                                              videolist
                                                                  .toString());
                                                          //video_link:"${videoController.getlist[i]!.videolink}"

                                                          //   videolist.add(videoController.getlist[i]!.videolink);
                                                          Get.to(YoutubeAppDemo(
                                                              videolist,
                                                              "${videoController.getlist[i]!.title}"));
                                                        },
                                                        child: Image.asset(
                                                          "assets/images/playicon.png",
                                                          color: Colors.white,
                                                          width: 50,
                                                          height: 50,
                                                        ))),
                                              )
                                            ]);
                                      },
                                      itemCount: videoController.getlist.length,
                                    )),
                            ),
                          )
                        : SizedBox()
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}

class GradientText extends StatelessWidget {
  const GradientText(
    this.text, {
    required this.gradient,
    this.style,
  });

  final String text;
  final TextStyle? style;
  final Gradient gradient;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => gradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: Text(text, style: style),
    );
  }
}
