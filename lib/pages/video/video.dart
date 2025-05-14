//
// import 'package:double_back_to_close_app/double_back_to_close_app.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_bounceable/flutter_bounceable.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:get/get.dart';
// import 'package:dentocoreauth/pages/video/video_play.dart';
// import 'package:dentocoreauth/pages/video/video_play_new.dart';
// import 'package:dentocoreauth/pages/video/view_photos_screen.dart';
//
// import '../../controllers/services_controller.dart';
// import '../../controllers/video_controller.dart';
// import '../../utils/app_constant.dart';
// import '../../utils/mycolor.dart';
//
// class Video extends StatefulWidget {
//   final backarrow;
//
//   const Video({Key? key, this.backarrow = true}) : super(key: key);
//
//   @override
//   State<Video> createState() => _VideoState();
// }
//
// class _VideoState extends State<Video> {
//
//   final VideoController videoController = Get.find();
//   final Servicescontroller servicescontroller = Get.find();
//   getgalleryImagesfunction? imagesList;
//
//   void fetchGalleryImages() async {
//     imagesList = await videoController.getGalleryImages();
//     setState(() {});
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     fetchGalleryImages();
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
//   int isSelected = 0;
//
//   @override
//   Widget build(BuildContext context) {
//     double height = kToolbarHeight;
//     double width = MediaQuery.of(context).size.width;
//     return AnnotatedRegion<SystemUiOverlayStyle>(
//         value: SystemUiOverlayStyle(
//           statusBarColor: MyColor.primarycolor,
//           statusBarIconBrightness: Brightness.light,
//           statusBarBrightness: Brightness.light,
//           systemNavigationBarColor: Colors.transparent,
//         ),
//         child: Scaffold(
//           body: DoubleBackToCloseApp(
//             snackBar: SnackBar(content: Text("Double tap to exit")),
//             child: RefreshIndicator(
//               onRefresh: () async {
//                 videoController.getVideos().then((value) => {
//                       if (EasyLoading.isShow) {EasyLoading.dismiss()}
//                     });
//               },
//               child: SafeArea(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Container(
//                       child: Center(
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//                             Container(
//                               height: height * 1.8,
//                               width: double.infinity,
//                               decoration: BoxDecoration(
//                                 color: MyColor.primarycolor,
//                                 borderRadius: BorderRadius.only(
//                                   bottomLeft: Radius.circular(20),
//                                   bottomRight: Radius.circular(20),
//                                 ),
//                               ),
//                               child: Column(
//                                 children: [
//                                   Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       widget.backarrow
//                                           ? Padding(
//                                               padding:
//                                                   const EdgeInsets.all(10.0),
//                                               child: GestureDetector(
//                                                 onTap: () => Get.back(),
//                                                 child: Container(
//                                                   height: height * 0.6,
//                                                   width: width * 0.12,
//                                                   decoration: BoxDecoration(
//                                                     color: Colors.white,
//                                                     borderRadius:
//                                                         BorderRadius.circular(
//                                                             9),
//                                                   ),
//                                                   child: Icon(
//                                                       Icons.arrow_back_ios_new,
//                                                       size: 18),
//                                                 ),
//                                               ),
//                                             )
//                                           : SizedBox(),
//                                       // widget.backarrow == false ? Padding(
//                                       //   padding: const EdgeInsets.all(10.0),
//                                       //   child: GestureDetector(
//                                       //     onTap: () => Get.back(),
//                                       //     child: Container(
//                                       //       height: height * 0.6,
//                                       //       width: width * 0.12,
//                                       //       decoration: BoxDecoration(
//                                       //         color: Colors.transparent,
//                                       //         borderRadius:
//                                       //         BorderRadius.circular(9),
//                                       //       ),
//                                       //       child: Icon(
//                                       //           Icons.arrow_back_ios_new,
//                                       //           size: 18),
//                                       //     ),
//                                       //   ),
//                                       // ) : SizedBox(),
//                                       Center(
//                                           child: Text(
//                                         "Gallery",
//                                         style: TextStyle(
//                                             color: Colors.white,
//                                             fontWeight: FontWeight.w600,
//                                             fontSize: 18),
//                                       )),
//                                       Icon(
//                                         Icons.abc,
//                                         color: Colors.transparent,
//                                       )
//                                     ],
//                                   ),
//                                   widget.backarrow
//                                       ? SizedBox()
//                                       : SizedBox(
//                                           height: height * 0.3,
//                                         ),
//                                   Center(
//                                     child: Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.center,
//                                       children: [
//                                         GestureDetector(
//                                           onTap: () {
//                                             setState(() {
//                                               isSelected = 0;
//                                             });
//                                           },
//                                           child: Card(
//                                             elevation: 3,
//                                             child: Container(
//                                               height: 34,
//                                               width: width * 0.26,
//                                               decoration: BoxDecoration(
//                                                   border: Border.all(
//                                                       color: Colors.white),
//                                                   color: isSelected == 0
//                                                       ? Colors.white
//                                                       : MyColor.primarycolor,
//                                                   borderRadius:
//                                                       BorderRadius.circular(
//                                                           12)),
//                                               child:
//                                                   Center(child: Text("Video")),
//                                             ),
//                                           ),
//                                         ),
//                                         SizedBox(
//                                           width: width * 0.03,
//                                         ),
//                                         GestureDetector(
//                                           onTap: () {
//                                             setState(() {
//                                               isSelected = 1;
//                                             });
//                                           },
//                                           child: Card(
//                                             elevation: 3,
//                                             child: Container(
//                                               height: 34,
//                                               width: width * 0.26,
//                                               decoration: BoxDecoration(
//                                                   border: Border.all(
//                                                       color: Colors.white),
//                                                   color: isSelected == 1
//                                                       ? Colors.white
//                                                       : MyColor.primarycolor,
//                                                   borderRadius:
//                                                       BorderRadius.circular(
//                                                           12)),
//                                               child: const Center(
//                                                   child: Text("Photo")),
//                                             ),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   )
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     isSelected == 1
//                         ? Expanded(
//                             child: imagesList == null
//                                 ? Center(
//                                     child: CircularProgressIndicator(),
//                                   )
//                                 : (imagesList!.body == null ||
//                                         imagesList!.body!.isEmpty)
//                                     ? Center(child: Text("No images found"))
//                                     : GridView.builder(
//                                         key: ValueKey(
//                                             imagesList?.body?.length ?? 0),
//                                         gridDelegate:
//                                             const SliverGridDelegateWithFixedCrossAxisCount(
//                                           crossAxisCount: 2,
//                                           crossAxisSpacing: 0,
//                                         ),
//                                         itemCount: imagesList!.body!.length,
//                                         itemBuilder: (context, index) {
//                                           var item = imagesList!.body![index];
//                                           print(
//                                               "Abhi:-image URL:-${item.image}");
//                                           return GestureDetector(
//                                             onTap: (){
//                                              // Get.to(ViewPhotosScreen(item: item,));
//                                               Get.to(ViewPhotosScreen(images: item.image ?? ""));
//                                             },
//                                             child: Padding(
//                                               padding: const EdgeInsets.all(8.0),
//                                               child: Column(
//                                                 children: [
//                                                   Container(
//                                                     decoration: BoxDecoration(
//                                                         borderRadius:
//                                                             BorderRadius.circular(
//                                                                 12)),
//                                                     child: item.image != null
//                                                         ? Image.network(
//                                                             item.image!
//                                                                     .startsWith(
//                                                                         'http')
//                                                                 ? item.image!
//                                                                 : "https://work.dbvertex.com/dentist1${item.image!}",
//                                                             scale: 4,
//                                                             fit: BoxFit.cover,
//                                                             errorBuilder:
//                                                                 (context, error,
//                                                                     stackTrace) {
//                                                               print(
//                                                                   "Abhi:-image failed to load:-$error");
//                                                               return Icon(
//                                                                   Icons.error);
//                                                             },
//                                                           )
//                                                         : Image.asset(
//                                                             "assets/newImages/videofiledimage.png",
//                                                             fit: BoxFit.cover,
//                                                             scale: 4,
//                                                           ),
//                                                   ),
//                                                   // Text(item.title ??"no data",)
//                                                 ],
//                                               ),
//                                             ),
//                                           );
//                                         },
//                                       ),
//                           )
//                         : SizedBox(),
//                     isSelected == 0
//                         ? Expanded(
//                             child: Padding(
//                               padding: const EdgeInsets.only(
//                                   top: 2.0, left: 8.0, right: 8.0, bottom: 8.0),
//                               child: Obx(() => videoController.isLoading == true
//                                   ? Center(
//                                       child: CircularProgressIndicator(),
//                                     )
//                                   : ListView.builder(
//                                       itemBuilder: (c, i) {
//                                         return Stack(
//                                             alignment: Alignment.bottomLeft,
//                                             children: [
//                                               InkWell(
//                                                 onTap: () {
//                                                   var videolist = <String>[];
//                                                   for (int i = 0; i < videoController.getlist.length;
//                                                       i++) {
//                                                     videolist.add("${videoController.getlist[i]!.videolink}");
//                                                   }
//                                                   //video_link:"${videoController.getlist[i]!.videolink}"
//
//                                                   // Get.to(YoutubeAppDemo(videolist,"${videoController.getlist[i]!.title}"));
//                                                 },
//                                                 child: Padding(
//                                                   padding:
//                                                       const EdgeInsets.only(
//                                                           left: 8.00,
//                                                           right: 8.00,
//                                                           bottom: 16.00),
//                                                   child: ClipRRect(
//                                                     borderRadius:
//                                                         BorderRadius.circular(
//                                                             30.0),
//
//                                                     // colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.2), BlendMode.dstATop),
//                                                     child: Center(
//                                                       child: Container(
//                                                         alignment:
//                                                             Alignment.center,
//                                                         height: 190.0,
//                                                         width: MediaQuery.of(
//                                                                     context)
//                                                                 .size
//                                                                 .width -
//                                                             50.0,
//                                                         decoration:
//                                                             BoxDecoration(
//                                                                 borderRadius:
//                                                                     BorderRadius
//                                                                         .circular(
//                                                                             15),
//                                                                 border: Border.all(
//                                                                     color: Colors
//                                                                         .lightBlueAccent,
//                                                                     width: 2),
//                                                                 image:
//                                                                     DecorationImage(
//                                                                   colorFilter: new ColorFilter
//                                                                       .mode(
//                                                                       Colors
//                                                                           .grey
//                                                                           .withOpacity(
//                                                                               0.6),
//                                                                       BlendMode
//                                                                           .darken),
//                                                                   image: NetworkImage(
//                                                                       videoController
//                                                                           .getlist[
//                                                                               i]!
//                                                                           .video
//                                                                           .toString()),
//                                                                   opacity: 1,
//                                                                   fit: BoxFit
//                                                                       .fill,
//                                                                 )),
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ),
//                                               Padding(
//                                                 padding: const EdgeInsets.only(
//                                                     left: 60.0, bottom: 30),
//                                                 child: Text(
//                                                   "${videoController.getlist[i]!.title}"
//                                                       .capitalizeFirst!,
//                                                   style: TextStyle(
//                                                       color: Colors.white,
//                                                       fontWeight:
//                                                           FontWeight.bold,
//                                                       fontSize: 20),
//                                                 ),
//                                               ),
//                                               Padding(
//                                                 padding: const EdgeInsets.only(
//                                                     bottom: 80),
//                                                 child: Center(
//                                                     child: InkWell(
//                                                         onTap: () {
//                                                           debugPrint("njtest1" +
//                                                               "${videoController.getlist[i]!.videolink}");
//                                                           //  Get.to(YoutubeAppDemo(video_link:"${videoController.getlist[i]!.videolink}",title: "${videoController.getlist[i]!.title}"));
//
//                                                           var videolist =
//                                                               <String>[];
//                                                           for (int j = 0;
//                                                               j <
//                                                                   videoController
//                                                                       .getlist
//                                                                       .length;
//                                                               j++) {
//                                                             videolist.add(
//                                                                 "${videoController.getlist[i]!.videolink}");
//                                                           }
//                                                           debugPrint("njtest1" +
//                                                               videolist
//                                                                   .toString());
//                                                           //video_link:"${videoController.getlist[i]!.videolink}"
//
//                                                           //   videolist.add(videoController.getlist[i]!.videolink);
//                                                           Get.to(YoutubeAppDemo(
//                                                               videolist,
//                                                               "${videoController.getlist[i]!.title}"));
//                                                         },
//                                                         child: Image.asset(
//                                                           "assets/images/playicon.png",
//                                                           color: Colors.white,
//                                                           width: 50,
//                                                           height: 50,
//                                                         ))),
//                                               )
//                                             ]);
//                                       },
//                                       itemCount: videoController.getlist.length,
//                                     )),
//                             ),
//                           )
//                         : SizedBox()
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ));
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
  /// currect code
import 'package:dentocoreauth/pages/video/video_play_new.dart';
import 'package:dentocoreauth/pages/video/view_photos_screen.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../../controllers/services_controller.dart';
import '../../controllers/video_controller.dart';
import '../../utils/app_constant.dart';
import '../../utils/mycolor.dart';

class Video extends StatefulWidget {
  final bool backarrow;

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
    videoController.getVideos().then((value) {
      debugPrint("njtest: done");
      if (EasyLoading.isShow) {
        EasyLoading.dismiss();
      }
    });
  }

  @override
  void dispose() {
    if (EasyLoading.isShow) {
      EasyLoading.dismiss();
    }
    super.dispose();
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
          snackBar: const SnackBar(content: Text("Double tap to exit")),
          child: RefreshIndicator(
            onRefresh: () async {
              await videoController.getVideos();
              if (EasyLoading.isShow) {
                EasyLoading.dismiss();
              }
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
                              borderRadius: const BorderRadius.only(
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
                                      padding: const EdgeInsets.all(10.0),
                                      child: GestureDetector(
                                        onTap: () => Get.back(),
                                        child: Container(
                                          height: height * 0.6,
                                          width: width * 0.12,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                            BorderRadius.circular(9),
                                          ),
                                          child: const Icon(
                                            Icons.arrow_back_ios_new,
                                            size: 18,
                                          ),
                                        ),
                                      ),
                                    )
                                        : const SizedBox(),
                                    const Center(
                                      child: Text(
                                        "Gallery",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                    const Icon(
                                      Icons.abc,
                                      color: Colors.transparent,
                                    ),
                                  ],
                                ),
                                widget.backarrow
                                    ? const SizedBox()
                                    : SizedBox(height: height * 0.3),
                                Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                                              BorderRadius.circular(12),
                                            ),
                                            child: const Center(child: Text("Video")),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: width * 0.03),
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
                                              BorderRadius.circular(12),
                                            ),
                                            child: const Center(child: Text("Photo")),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: isSelected == 1
                        ? imagesList == null
                        ? const Center(child: CircularProgressIndicator())
                        : (imagesList!.body == null || imagesList!.body!.isEmpty)
                        ? const Center(child: Text("No images found"))
                        : GridView.builder(
                      key: ValueKey(imagesList?.body?.length ?? 0),
                      gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 0,
                      ),
                      itemCount: imagesList!.body!.length,
                      itemBuilder: (context, index) {
                        var item = imagesList!.body![index];
                        debugPrint("image URL: ${item.image}");
                        return GestureDetector(
                          onTap: () {
                            Get.to(() => ViewPhotosScreen(
                                images: item.image ?? ""));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.circular(12),
                                  ),
                                  child: item.image != null
                                      ? Image.network(
                                    item.image!.startsWith('http')
                                        ? item.image!
                                        : "https://work.dbvertex.com/dentist1${item.image!}",
                                    scale: 4,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context,
                                        error, stackTrace) {
                                      debugPrint(
                                          "image failed to load: $error");
                                      return const Icon(
                                          Icons.error);
                                    },
                                  )
                                      : Image.asset(
                                    "assets/newImages/videofiledimage.png",
                                    fit: BoxFit.cover,
                                    scale: 4,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    )
                        : Obx(() => videoController.isLoading.value
                        ? const Center(child: CircularProgressIndicator())
                        : videoController.getlist.isEmpty
                        ? const Center(child: Text("No videos found"))
                        : ListView.builder(
                      itemCount: videoController.getlist.length,
                      itemBuilder: (context, i) {
                        final video = videoController.getlist[i];
                        if (video == null ||
                            video.videolink == null ||
                            video.title == null ||
                            video.video == null) {
                          return const SizedBox();
                        }
                        return Stack(
                          alignment: Alignment.bottomLeft,
                          children: [
                            InkWell(
                              onTap: () {
                                final videolist = videoController
                                    .getlist
                                    .where((v) =>
                                v != null &&
                                    v.videolink != null)
                                    .map((v) => v!.videolink!)
                                    .toList();
                                Get.to(() => YoutubeAppDemo(
                                    videolist: videolist,
                                    title: video.title!,
                                    initialIndex: i));
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 8.0,
                                    right: 8.0,
                                    bottom: 16.0),
                                child: ClipRRect(
                                  borderRadius:
                                  BorderRadius.circular(30.0),
                                  child: Center(
                                    child: Container(
                                      alignment: Alignment.center,
                                      height: 190.0,
                                      width: MediaQuery.of(context)
                                          .size
                                          .width -
                                          50.0,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.circular(15),
                                        border: Border.all(
                                            color: Colors
                                                .lightBlueAccent,
                                            width: 2),
                                        image: DecorationImage(
                                          colorFilter: ColorFilter.mode(
                                              Colors.grey
                                                  .withOpacity(0.6),
                                              BlendMode.darken),
                                          image: NetworkImage(
                                              video.video!),
                                          fit: BoxFit.fill,
                                          onError: (exception,
                                              stackTrace) {
                                            debugPrint(
                                                "Video thumbnail error: $exception");
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 60.0, bottom: 30),
                              child: Text(
                                video.title!.capitalizeFirst!,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                              const EdgeInsets.only(bottom: 80),
                              child: Center(
                                child: InkWell(
                                  onTap: () {
                                    final videolist = videoController
                                        .getlist
                                        .where((v) =>
                                    v != null &&
                                        v.videolink != null)
                                        .map((v) => v!.videolink!)
                                        .toList();
                                    debugPrint(
                                        "videolist: $videolist");
                                    Get.to(() => YoutubeAppDemo(
                                        videolist: videolist,
                                        title: video.title!,
                                        initialIndex: i));
                                  },
                                  child: Image.asset(
                                    "assets/images/playicon.png",
                                    color: Colors.white,
                                    width: 50,
                                    height: 50,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    )),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
/*
class YoutubeAppDemo extends StatefulWidget {
  final List<String> videolist;
  final String title;
  final int initialIndex;

  const YoutubeAppDemo({
    Key? key,
    required this.videolist,
    required this.title,
    this.initialIndex = 0,
  }) : super(key: key);

  @override
  State<YoutubeAppDemo> createState() => _YoutubeAppDemoState();
}
class _YoutubeAppDemoState extends State<YoutubeAppDemo> {
  late YoutubePlayerController _controller;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _initializePlayer();
  }

  void _initializePlayer() {
    if (_currentIndex < 0 || _currentIndex >= widget.videolist.length) {
      return;
    }
    String? videoId = YoutubePlayer.convertUrlToId(widget.videolist[_currentIndex]);
    if (videoId == null) {
      Get.snackbar("Error", "Invalid video URL",
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    _controller = YoutubePlayerController(
      initialVideoId: videoId,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
        // disableFullScreen: true,
        showLiveFullscreenButton: false,

      ),
    )..addListener(() {
      if (_controller.value.isReady) {
        debugPrint("YouTube Player Ready: ${widget.videolist[_currentIndex]}");
      }
      if (_controller.value.hasError) {
        // debugPrint("YouTube Player Error: ${_controller.value.error}");
        Get.snackbar("Error", "Failed to play video",
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _playNextVideo() {
    if (_currentIndex < widget.videolist.length - 1) {
      setState(() {
        _currentIndex++;
        _controller.dispose();
        _initializePlayer();
      });
    }
  }

  void _playPreviousVideo() {
    if (_currentIndex > 0) {
      setState(() {
        _currentIndex--;
        _controller.dispose();
        _initializePlayer();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: MyColor.primarycolor,
      ),
      body: Column(
        children: [
          YoutubePlayer(
            controller: _controller,
            showVideoProgressIndicator: true,
            progressIndicatorColor: Colors.blueAccent,
            onReady: () {
              debugPrint("YouTube Player Ready");
            },
            onEnded: (metaData) {
              _playNextVideo();
            },
          ),
          const SizedBox(height: 16),
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: Align(
          //       alignment: Alignment.topLeft,
          //       child: Text("Title : ${widget.title}",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16),)),
          // ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     IconButton(
          //       onPressed: _currentIndex > 0 ? _playPreviousVideo : null,
          //       icon: const Icon(Icons.skip_previous),
          //     ),
          //     IconButton(
          //       onPressed: _currentIndex < widget.videolist.length - 1
          //           ? _playNextVideo
          //           : null,
          //       icon: const Icon(Icons.skip_next),
          //     ),
          //   ],
          // ),
          // Expanded(
          //   child: ListView.builder(
          //     itemCount: widget.videolist.length,
          //     itemBuilder: (context, index) {
          //       return ListTile(
          //         title: Text("Video ${index + 1}"),
          //         selected: index == _currentIndex,
          //         onTap: () {
          //           setState(() {
          //             _currentIndex = index;
          //             _controller.dispose();
          //             _initializePlayer();
          //           });
          //         },
          //       );
          //     },
          //   ),
          // ),
        ],
      ),
    );
  }
}
*/

class YoutubeAppDemo extends StatefulWidget {
  final List<String> videolist;
  final String title;
  final int initialIndex;

  const YoutubeAppDemo({
    Key? key,
    required this.videolist,
    required this.title,
    this.initialIndex = 0,
  }) : super(key: key);

  @override
  State<YoutubeAppDemo> createState() => _YoutubeAppDemoState();
}

class _YoutubeAppDemoState extends State<YoutubeAppDemo> {
  late YoutubePlayerController _controller;
  int _currentIndex = 0;
  bool _isFullscreen = false;

  @override
  void initState() {
    super.initState();
    // Lock orientation to portrait
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    _currentIndex = widget.initialIndex.clamp(0, widget.videolist.length - 1);
    _initializePlayer();
  }

  void _initializePlayer() {
    if (_currentIndex < 0 || _currentIndex >= widget.videolist.length) {
      Get.snackbar("Error", "Invalid video index",
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }
    String? videoId = YoutubePlayer.convertUrlToId(widget.videolist[_currentIndex]);
    if (videoId == null) {
      Get.snackbar("Error", "Invalid video URL: ${widget.videolist[_currentIndex]}",
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    _controller = YoutubePlayerController(
      initialVideoId: videoId,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
        showLiveFullscreenButton: false,
        // No disableFullScreen flag; we'll handle fullscreen manually
      ),
    )..addListener(() {
      if (_controller.value.isReady) {
        debugPrint("YouTube Player Ready: ${widget.videolist[_currentIndex]}");
      }
      if (_controller.value.hasError) {
        // debugPrint("YouTube Player Error: ${_controller.value.error}");
        Get.snackbar("Error", "Failed to play video",
            backgroundColor: Colors.red, colorText: Colors.white);
      }
      // Monitor fullscreen state
      if (_controller.value.isFullScreen != _isFullscreen) {
        setState(() {
          _isFullscreen = _controller.value.isFullScreen;
        });
        // Force portrait even in fullscreen
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
        ]);
      }
    });
  }

  void _playNextVideo() {
    if (_currentIndex < widget.videolist.length - 1) {
      setState(() {
        _currentIndex++;
        _controller.dispose();
        _initializePlayer();
      });
    }
  }

  void _playPreviousVideo() {
    if (_currentIndex > 0) {
      setState(() {
        _currentIndex--;
        _controller.dispose();
        _initializePlayer();
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    // Reset orientation to portrait
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: MyColor.primarycolor,
      ),
      body: Column(
        children: [
          // Video player with fixed aspect ratio
          AspectRatio(
            aspectRatio: 16 / 9,
            child: YoutubePlayer(
              controller: _controller,
              showVideoProgressIndicator: true,
              progressIndicatorColor: Colors.blueAccent,
              progressColors: const ProgressBarColors(
                playedColor: Colors.blueAccent,
                handleColor: Colors.blue,
                bufferedColor: Colors.white54,
                backgroundColor: Colors.grey,
              ),
              onReady: () {
                debugPrint("YouTube Player Ready");
              },
              onEnded: (metaData) {
                _playNextVideo();
              },
            ),
          ),
          const SizedBox(height: 16),
          // Optional: Uncomment to re-enable playlist controls
          /*
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Title: ${widget.title}",
                style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: _currentIndex > 0 ? _playPreviousVideo : null,
                icon: const Icon(Icons.skip_previous),
              ),
              IconButton(
                onPressed: _currentIndex < widget.videolist.length - 1
                    ? _playNextVideo
                    : null,
                icon: const Icon(Icons.skip_next),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: widget.videolist.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text("Video ${index + 1}"),
                  selected: index == _currentIndex,
                  onTap: () {
                    setState(() {
                      _currentIndex = index;
                      _controller.dispose();
                      _initializePlayer();
                    });
                  },
                );
              },
            ),
          ),
          */
        ],
      ),
    );
  }
}


 //   niche vala code new updated code hai or working bhi

/*
class YoutubeAppDemo extends StatefulWidget {
  final List<String> videolist;
  final String title;
  final int initialIndex;

  const YoutubeAppDemo({
    Key? key,
    required this.videolist,
    required this.title,
    this.initialIndex = 0,
  }) : super(key: key);

  @override
  State<YoutubeAppDemo> createState() => _YoutubeAppDemoState();
}

class _YoutubeAppDemoState extends State<YoutubeAppDemo> {
  late YoutubePlayerController _controller;
  int _currentIndex = 0;
  bool _isPlayerReady = false;
  bool _showControls = true;
  bool _isFullscreen = false;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex.clamp(0, widget.videolist.length - 1);
    _initializePlayer();
  }

  void _initializePlayer() {
    if (_currentIndex < 0 || _currentIndex >= widget.videolist.length) {
      Get.snackbar("Error", "Invalid video index",
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }
    String? videoId = YoutubePlayer.convertUrlToId(widget.videolist[_currentIndex]);
    if (videoId == null) {
      Get.snackbar("Error", "Invalid video URL: ${widget.videolist[_currentIndex]}",
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    _controller = YoutubePlayerController(
      initialVideoId: videoId,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
        showLiveFullscreenButton: false,
        enableCaption: true,
        captionLanguage: 'en',
      ),
    )..addListener(() {
      if (_controller.value.isReady && !_isPlayerReady) {
        setState(() {
          _isPlayerReady = true;
        });
        debugPrint("YouTube Player Ready: ${widget.videolist[_currentIndex]}");
      }
      if (_controller.value.hasError) {
        // debugPrint("YouTube Player Error: ${_controller.value.error}");
        Get.snackbar("Error", "Failed to play video",
            backgroundColor: Colors.red, colorText: Colors.white);
      }
      if (_controller.value.isFullScreen != _isFullscreen) {
        setState(() {
          _isFullscreen = _controller.value.isFullScreen;
        });
        if (_isFullscreen) {
          SystemChrome.setPreferredOrientations([
            DeviceOrientation.landscapeLeft,
            DeviceOrientation.landscapeRight,
          ]);
          SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
        } else {
          SystemChrome.setPreferredOrientations([
            DeviceOrientation.portraitUp,
          ]);
          SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
        }
      }
    });
  }

  void _playNextVideo() {
    if (_currentIndex < widget.videolist.length - 1) {
      setState(() {
        _currentIndex++;
        _controller.dispose();
        _isPlayerReady = false;
        _initializePlayer();
      });
    }
  }

  void _playPreviousVideo() {
    if (_currentIndex > 0) {
      setState(() {
        _currentIndex--;
        _controller.dispose();
        _isPlayerReady = false;
        _initializePlayer();
      });
    }
  }

  void _togglePlayPause() {
    if (_controller.value.isPlaying) {
      _controller.pause();
    } else {
      _controller.play();
    }
    setState(() {
      _showControls = true;
    });
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted && _controller.value.isPlaying) {
        setState(() {
          _showControls = false;
        });
      }
    });
  }

  void _seekForward() {
    final currentPosition = _controller.value.position.inSeconds;
    final newPosition = currentPosition + 10;
    _controller.seekTo(Duration(seconds: newPosition));
  }

  void _seekBackward() {
    final currentPosition = _controller.value.position.inSeconds;
    final newPosition = (currentPosition - 10).clamp(0, _controller.value.metaData.duration.inSeconds);
    _controller.seekTo(Duration(seconds: newPosition));
  }

  void _toggleFullscreen() {
    _controller.toggleFullScreenMode();
  }

  @override
  void dispose() {
    _controller.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    super.dispose();
  }

  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: OrientationBuilder(
          builder: (context, orientation) {
            return Stack(
              children: [
                Column(
                  children: [
                    // Video Player
                    AspectRatio(
                      aspectRatio: _isFullscreen ? MediaQuery.of(context).size.aspectRatio : 16 / 9,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          YoutubePlayer(
                            controller: _controller,
                            showVideoProgressIndicator: true,
                            progressIndicatorColor: Colors.red,
                            progressColors: const ProgressBarColors(
                              playedColor: Colors.red,
                              handleColor: Colors.redAccent,
                              bufferedColor: Colors.white54,
                              backgroundColor: Colors.grey,
                            ),
                            onReady: () {
                              debugPrint("YouTube Player Ready");
                            },
                            onEnded: (metaData) {
                              _playNextVideo();
                            },
                          ),
                          // Controls Overlay
                          if (_isPlayerReady)
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  _showControls = !_showControls;
                                });
                                if (_controller.value.isPlaying && _showControls) {
                                  Future.delayed(const Duration(seconds: 3), () {
                                    if (mounted && _controller.value.isPlaying) {
                                      setState(() {
                                        _showControls = false;
                                      });
                                    }
                                  });
                                }
                              },
                              child: AnimatedOpacity(
                                opacity: _showControls ? 1.0 : 0.0,
                                duration: const Duration(milliseconds: 300),
                                child: Container(
                                  color: Colors.black54,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      // Top Bar (Fullscreen Toggle)
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          IconButton(
                                            icon: Icon(
                                              _isFullscreen
                                                  ? Icons.fullscreen_exit
                                                  : Icons.fullscreen,
                                              color: Colors.white,
                                            ),
                                            onPressed: _toggleFullscreen,
                                          ),
                                        ],
                                      ),
                                      const Spacer(),
                                      // Main Controls
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          IconButton(
                                            icon: const Icon(
                                              Icons.replay_10,
                                              color: Colors.white,
                                              size: 36,
                                            ),
                                            onPressed: _seekBackward,
                                          ),
                                          IconButton(
                                            icon: Icon(
                                              _controller.value.isPlaying
                                                  ? Icons.pause
                                                  : Icons.play_arrow,
                                              color: Colors.white,
                                              size: 48,
                                            ),
                                            onPressed: _togglePlayPause,
                                          ),
                                          IconButton(
                                            icon: const Icon(
                                              Icons.forward_10,
                                              color: Colors.white,
                                              size: 36,
                                            ),
                                            onPressed: _seekForward,
                                          ),
                                        ],
                                      ),
                                      // Time Display
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16.0, vertical: 8.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              _formatDuration(_controller.value.position),
                                              style: const TextStyle(color: Colors.white),
                                            ),
                                            Text(
                                              _formatDuration(
                                                  _controller.value.metaData.duration),
                                              style: const TextStyle(color: Colors.white),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                    // Video Info and Playlist
                    if (!_isFullscreen)
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text(
                                widget.title,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const Divider(color: Colors.grey),
                            Expanded(
                              child: ListView.builder(
                                itemCount: widget.videolist.length,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    leading: Image.network(
                                      'https://img.youtube.com/vi/${YoutubePlayer.convertUrlToId(widget.videolist[index])}/0.jpg',
                                      width: 80,
                                      height: 45,
                                      fit: BoxFit.cover,
                                      errorBuilder: (context, error, stackTrace) =>
                                      const Icon(Icons.error, color: Colors.white),
                                    ),
                                    title: Text(
                                      "Video ${index + 1}",
                                      style: const TextStyle(color: Colors.white),
                                    ),
                                    subtitle: Text(
                                      widget.videolist[index],
                                      style: const TextStyle(color: Colors.grey),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    selected: index == _currentIndex,
                                    selectedTileColor: Colors.white12,
                                    onTap: () {
                                      setState(() {
                                        _currentIndex = index;
                                        _controller.dispose();
                                        _isPlayerReady = false;
                                        _initializePlayer();
                                      });
                                    },
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
                // Back Button for Fullscreen
                if (_isFullscreen)
                  Positioned(
                    top: 16,
                    left: 16,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: _toggleFullscreen,
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}*/
