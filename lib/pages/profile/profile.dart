
import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dentocoreauth/utils/app_constant.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;
import '../../Utills/Utills.dart';
import '../../controllers/profile_controller.dart';
import '../../models/normalDTO.dart';
import '../../utils/component_screen.dart';
import '../../utils/mycolor.dart';
import '../auth/login/login.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final ProfileController profileController = Get.find();
  var util = Utills();
  bool isUpdate = true; // Kept as true as per your logic
  String? userid;
  final ImagePicker picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  // Fetch user data from SharedPreferences
  void getUserData() async {
    final sp = await SharedPreferences.getInstance();
    final userData = sp.getStringList("user_data");
    if (userData != null && userData.isNotEmpty) {
      setState(() {
        userid = userData[0];
        profileController.getProfile(userid!).then((value) {
          if (value != null) {
            // util.showSnackBar("Alert", value.message.toString(), true);
            print("Abhi:- getedit profile data ${value.message.toString()}");
            print("Abhi:- getedit profile data body : ${value.body}");
          }
        });
      });
    } else {
      util.showSnackBar("Alert", "User data not found", false);
    }
  }

  // void getUserData() async {
  //   final sp = await SharedPreferences.getInstance();
  //   final userData = sp.getStringList("user_data");
  //   if (userData != null && userData.isNotEmpty) {
  //     setState(() {
  //       userid = userData[0];
  //       // Server se latest data fetch karo
  //       profileController.getProfile(userid!).then((value) {
  //         if (value != null) {
  //           print("Abhi:- getedit profile data ${value.message.toString()}");
  //           print("Abhi:- getedit profile data body : ${value.body}");
  //           // UI ko refresh karo
  //           setState(() {
  //             // Optional: UI variables ko update karo
  //             profileController.name_profile.text = userData[1];
  //             profileController.email_profile.text = userData[2];
  //             profileController.contact_profile.text = userData[3];
  //             // profileController._image.value = userData[6];
  //           });
  //         } else {
  //           util.showSnackBar("Alert", "Failed to fetch latest profile", false);
  //         }
  //       });
  //     });
  //   } else {
  //     util.showSnackBar("Alert", "User data not found", false);
  //   }
  // }

  // Check permission status only (no request)
  Future<bool> checkPermissions(ImageSource source) async {
    Permission permission = source == ImageSource.camera ? Permission.camera : Permission.photos;
    PermissionStatus status = await permission.status;
    print("Permission $permission status: $status");

    if (status.isPermanentlyDenied) {
      util.showSnackBar(
        "Alert",
        "Please enable ${source == ImageSource.camera ? 'camera' : 'gallery'} permission in app settings.",
        false,
      );
      await openAppSettings();
      return false;
    } else if (status.isDenied) {
      util.showSnackBar(
        "Alert",
        "${source == ImageSource.camera ? 'Camera' : 'Gallery'} permission is required.",
        false,
      );
      return false;
    }
    return true;
  }

  // Pick image with minimal permission handling
  Future<void> pickImage(ImageSource source) async {
    print("Attempting to pick image from: $source");
    try {
      // Check permission status
      bool canProceed = await checkPermissions(source);
      if (!canProceed) return;

      // Let image_picker handle runtime permissions
      final pickedFile = await picker.pickImage(
        source: source,
        maxHeight: 480,
        maxWidth: 640,
        imageQuality: 50,
      );
      if (pickedFile != null) {
        print("Image picked: ${pickedFile.path}");
        setState(() {
          profileController.fimage1 = File(pickedFile.path);
        });
      } else {
        print("No image selected");
        util.showSnackBar("Alert", "No image selected", false);
      }
    } catch (e) {
      print("Image picker error: $e");
      util.showSnackBar(
        "Alert",
        "Error picking image: $e",
        false,
      );
    }
  }

  // Dialog for image selection
  Widget errorDialog(BuildContext context) {
    return AlertDialog(
      title: const Text("Select Image"),
      content: const Text("Choose an image from:"),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            pickImage(ImageSource.camera);
          },
          child: const Text("Camera"),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            pickImage(ImageSource.gallery);
          },
          child: const Text("Gallery"),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Cancel"),
        ),
      ],
    );
  }


  //                      add image function
  File? fimage1;
  var islogin = false;
  final ProfileController profile_controller = Get.find();
  Future<NormalDTO?> update_profile(String id, File? img) async {
    util.startLoading();
    debugPrint("njimage" + "${img.toString()}}");
    debugPrint("njimage" + "${base64Encode(img!.readAsBytesSync())}");

    print("imageout" + img.toString());
    print("imageout" +
        'data:image/png;base64,' +
        base64Encode(img!.readAsBytesSync()));
    var res = await http.post(
        Uri.parse(AppConstant.BASE_URL + "/api/profileimage_update"),
        body: <String, String>{
          "id": id,
          'photo': img != null ? base64Encode(img!.readAsBytesSync()) : '',
        },
        headers: <String, String>{
          "x-api-key": "dentist@123"
        });

    if (res.statusCode == 200 || res.statusCode == 201) {
      debugPrint("njimage" + "200");
      var response = jsonDecode(res.body);
      if (response['status'] == true) {
        // util.showSuccessProcess();
        debugPrint("njimage" + "success");
        debugPrint("njimage" + response.toString());
        util.showSnackBar("Alert Abhi sfsd", response['message'], true);
        return response;
      } else if (response['status' == false]) {
        debugPrint("njimage" + "false");
        //util.showFailProcess();
       // util.showSnackBar("Alert", "Something went wrong!", false);
        return null;
      }
    } else {
      debugPrint("njimage" + "${res.statusCode}");
     // util.showFailProcess();
      return null;
    }
  }

  Future getImage(
      ImageSource img,
      ) async {
    final pickedFile = await picker.pickImage(
        source: img, maxHeight: 480, maxWidth: 640, imageQuality: 50);
    XFile? xfilePick = pickedFile;
    setState(
          () {
        if (xfilePick != null) {
          setState(() {
            fimage1 = File(pickedFile!.path);
            // profile_controller.updateprofileImage("20", profile_controller.fimage1);
            update_profile("${userid}", fimage1);
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(// is this context <<<
              const SnackBar(content: Text('Nothing is selected')));
        }
      },
    );
  }

  Dialog askDialog(BuildContext context) {
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
                  'Select',
                  style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.w700,
                      fontSize: 18),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(12.0),
                child: Text(
                  'Please select image from:',
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
                          Get.back();
                          getImage(ImageSource.camera);
                        },
                        child: Text("CAMERA"),
                        color: Colors.blue,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      MaterialButton(
                        onPressed: () {
                          Get.back();
                          getImage(ImageSource.gallery);
                        },
                        child: Text("GALLERY"),
                        color: Colors.blue,
                      ),
                    ],
                  ),),
            ],
          ),
        ),
    );
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
        body: GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          behavior: HitTestBehavior.opaque,
          child: SafeArea(
            child: SingleChildScrollView(
              child: Container(
                height: height,
                child: Stack(
                  children: [
                    // Background Image
                    Image.asset(
                      "assets/newImages/profile-background.jpg",
                      height: height * 0.3,
                      width: width,
                      fit: BoxFit.cover,
                    ),

                    // Custom App Bar
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child: CustomAppBar(title: 'My Profile'),
                      // CustomAppBar(
                      //   title: 'Contact Us',
                      // ),
                    ),

                    // Profile Picture
                    Positioned(
                      // top: height * 0.23,
                      // left: width * 0.05,
                      top: height * 0.0,
                      left: width * 0.0,
                      bottom: 340,
                      right: 210,
                      child: Stack(
                        children: [
                          Visibility(
                            visible: islogin == true ? true : true,
                            child: Container(
                              alignment: Alignment.center,
                              child: Stack(
                                children: [
                                 Obx(()=> CircleAvatar(
                                    radius: 55,
                                    // backgroundImage:AssetImage('assets/images/user.png'),
                                    child: ClipOval(
                                        child: fimage1 == null
                                            ? CachedNetworkImage(
                                          imageUrl: profile_controller
                                              .image.value,
                                          width: 100,
                                          height: 100,
                                          fit: BoxFit.cover,
                                          placeholder: (context, url) =>
                                          new CircularProgressIndicator(),
                                          errorWidget: (context, url,
                                              error) =>
                                          new Image.asset(
                                              "assets/images/user.png"),
                                        )
                                            : Image.file(
                                          fimage1!,
                                          width: 100,
                                          height: 100,
                                          cacheWidth: 100,
                                          cacheHeight: 100,
                                        )),
                                  )),
                                  Positioned(
                                    bottom: 75,
                                    right: -4,
                                    child: Container(
                                      child: Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: InkWell(
                                            onTap: () {
                                              // Get.to(Profile(),
                                              //     duration: Duration(seconds: 2),
                                              //     transition:
                                              //         Transition.circularReveal);
                                              showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) =>
                                                      askDialog(context));
                                            },
                                            child: Icon(Icons.add_a_photo,
                                                color: Colors.black)),
                                      ),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                            width: 1,
                                            color: Colors.white,
                                          ),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(
                                              60,
                                            ),
                                          ),
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                              offset: Offset(2, 4),
                                              color: Colors.black.withOpacity(
                                                0.3,
                                              ),
                                              blurRadius: 3,
                                            ),
                                          ]),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          // CircleAvatar(
                          //   radius: 50,
                          //   backgroundColor: Colors.white,
                          //   child: InkWell(
                          //     onTap: () {
                          //       showDialog(
                          //         context: context,
                          //         builder: (BuildContext context) => errorDialog(context),
                          //       );
                          //     },
                          //     child: ClipOval(
                          //       child: profileController.fimage1 == null
                          //           ? CachedNetworkImage(
                          //         imageUrl: profileController.image.value,
                          //         width: 100,
                          //         height: 100,
                          //         fit: BoxFit.cover,
                          //         placeholder: (context, url) =>
                          //             CircularProgressIndicator(),
                          //         errorWidget: (context, url, error) =>
                          //             Image.asset("assets/images/user.png"),
                          //       )
                          //           : Image.file(
                          //         profileController.fimage1!,
                          //         width: 100,
                          //         height: 100,
                          //         fit: BoxFit.cover,
                          //       ),
                          //     ),
                          //   ),
                          // ),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.center,
                          //   children: [
                          //
                          //     SizedBox(
                          //       width: 8,
                          //     ),
                          //   ],
                          // ),
                          // Positioned(
                          //   top: 0,
                          //   bottom: height * 0.74,
                          //   right: height * 0.31,
                          //   child: Container(
                          //     decoration: BoxDecoration(
                          //       color: Colors.white,
                          //       shape: BoxShape.circle,
                          //       boxShadow: [
                          //         BoxShadow(
                          //           offset: Offset(2, 4),
                          //           color: Colors.black.withOpacity(0.3),
                          //           blurRadius: 3,
                          //         ),
                          //       ],
                          //     ),
                          //     child: Padding(
                          //       padding: const EdgeInsets.all(4.0),
                          //       child: InkWell(
                          //         onTap: () {
                          //           showDialog(
                          //             context: context,
                          //             builder: (BuildContext context) => errorDialog(context),
                          //           );
                          //         },
                          //         child: Icon(Icons.add_a_photo, color: Colors.black, size: 20),
                          //       ),
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                    ),

                    // Form Fields
                    Positioned(
                      top: height * 0.35,
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: AppConstant.LARGE_SIZE),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Member Since
                            // Padding(
                            //   padding: const EdgeInsets.only(left: 10.0, top: 10.0),
                            //   child: Text(
                            //     "MEMBER SINCE 2016",
                            //     style: TextStyle(
                            //       fontSize: AppConstant.SMALL_TEXT_SIZE,
                            //       color: Colors.grey,
                            //     ),
                            //   ),
                            // ),

                            // Name Field
                            Padding(
                              padding: const EdgeInsets.only(left: 20.0, top: 20.0),
                              child: Text(
                                AppConstant.TEXT_NAME,
                                style: TextStyle(
                                  fontSize: AppConstant.MEDIUM_SIZE,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                            SizedBox(height: AppConstant.SMALL_TEXT_SIZE),
                            Padding(
                              padding: EdgeInsets.all(AppConstant.APP_NORMAL_PADDING),
                              child: Container(
                                height: 50,
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
                                  borderRadius:
                                  BorderRadius.circular(AppConstant.APP_NORMAL_PADDING),
                                  border: Border.all(color: Colors.grey, width: 1.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Center(
                                    child: TextField(
                                      controller: profileController.name_profile,
                                      decoration: InputDecoration.collapsed(
                                        hintText: AppConstant.HINT_TEXT_NAME,
                                      ),
                                      inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r"^[a-z A-Z\s]+$"))],
                                      keyboardType: TextInputType.text,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            // Email Field
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Text(
                                AppConstant.TEXT_EMAIL,
                                style: TextStyle(
                                  fontSize: AppConstant.MEDIUM_SIZE,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                            SizedBox(height: AppConstant.SMALL_TEXT_SIZE),
                            Padding(
                              padding: EdgeInsets.all(AppConstant.APP_NORMAL_PADDING),
                              child: Container(
                                height: 50,
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
                                  borderRadius:
                                  BorderRadius.circular(AppConstant.APP_NORMAL_PADDING),
                                  border: Border.all(color: Colors.grey, width: 1.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Center(
                                    child: TextField(
                                      enabled: false,
                                      controller: profileController.email_profile,
                                      decoration: InputDecoration.collapsed(
                                        hintText: AppConstant.HINT_TEXT_EMAIL,
                                      ),
                                      keyboardType: TextInputType.emailAddress,
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            // Phone Number Field
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Text(
                                AppConstant.TEXT_CONTACT_NUMBER,
                                style: TextStyle(
                                  fontSize: AppConstant.MEDIUM_SIZE,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                            SizedBox(height: AppConstant.SMALL_TEXT_SIZE),

                            Padding(
                              padding: EdgeInsets.all(AppConstant.APP_NORMAL_PADDING),
                              child: Container(
                                height: 50,
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
                                  borderRadius:
                                  BorderRadius.circular(AppConstant.APP_NORMAL_PADDING),
                                  border: Border.all(color: Colors.grey, width: 1.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Center(
                                    child: TextField(
                                      controller: profileController.contact_profile,
                                      enabled: true,
                                      inputFormatters: [
                                        LengthLimitingTextInputFormatter(10),
                                        FilteringTextInputFormatter.allow(RegExp(r"^[0-9\s]+$"))
                                      ],
                                      decoration: InputDecoration.collapsed(
                                        hintText: AppConstant.HINT_TEXT_CONTACT_NUMBER,
                                      ),
                                      keyboardType: TextInputType.number,
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            // Commented Age Field (kept as is)
                            // Padding(
                            //   padding: EdgeInsets.all(AppConstant.APP_NORMAL_PADDING),
                            //   child: Container(
                            //     height: 50,
                            //     decoration: BoxDecoration(
                            //       boxShadow: [
                            //         BoxShadow(
                            //           color: Colors.grey,
                            //           offset: const Offset(5.0, 5.0),
                            //           blurRadius: 10.0,
                            //           spreadRadius: 2.0,
                            //         ),
                            //         BoxShadow(
                            //           color: Colors.white,
                            //           offset: const Offset(0.0, 0.0),
                            //           blurRadius: 0.0,
                            //           spreadRadius: 0.0,
                            //         ),
                            //       ],
                            //       borderRadius: BorderRadius.circular(AppConstant.APP_NORMAL_PADDING),
                            //       border: Border.all(color: Colors.grey, width: 1.0),
                            //     ),
                            //     child: Padding(
                            //       padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            //       child: Center(
                            //         child: TextField(
                            //           controller: profileController.age_profile,
                            //           decoration: InputDecoration.collapsed(
                            //             hintText: "Enter Age",
                            //           ),
                            //           keyboardType: TextInputType.number,
                            //           inputFormatters: [
                            //             LengthLimitingTextInputFormatter(3),
                            //           ],
                            //         ),
                            //       ),
                            //     ),
                            //   ),
                            // ),

                            Spacer(), // Pushes the button to the bottom

                            // Submit Button
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: AppConstant.LARGE_SIZE,
                                vertical: AppConstant.LARGE_SIZE,
                              ),
                              child: Bounceable(
                                onTap: () {
                                  getUserData();
                                  if (isUpdate) {
                                    // getUserData();
                                    print("Abhi:-isupdate $isUpdate");
                                    if (userid == null) {
                                      util.showSnackBar(
                                          "Alert", "User ID not found", false);
                                      return;
                                    }
                                    // Check if image is selected
                                    if (profileController.fimage1 != null) {
                                      profileController.updateprofileImage(
                                          userid!, profileController.fimage1);
                                    }
                                    // Check if any text field is updated
                                    if (profileController.name_profile.text.isNotEmpty ||
                                        profileController.contact_profile.text.isNotEmpty) {
                                      profileController.updateprofile(userid!);
                                    }
                                    // If nothing is updated
                                    if (profileController.fimage1 == null &&
                                        profileController.name_profile.text.isEmpty &&
                                        profileController.contact_profile.text.isEmpty) {
                                      util.showSnackBar(
                                          "Alert",
                                          "Please update at least one field or select an image",
                                          false);
                                    }
                                  }
                                },
                                child: Container(
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
                                    color: MyColor.primarycolor,
                                   // gradient: AppConstant.BUTTON_COLOR,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  height: 44,
                                  width: double.infinity,
                                  child: Center(
                                    child: Text(
                                      isUpdate ? AppConstant.UPDATE : AppConstant.SUBMIT,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: AppConstant.MEDIUM_SIZE,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
