import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:dentocoreauth/Utills/Utills.dart';
import 'package:dentocoreauth/pages/auth/login/login.dart';
import 'package:dentocoreauth/pages/setting/settings.dart';
import 'package:dentocoreauth/utils/mycolor.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:upgrader/upgrader.dart';


import '../../controllers/user_controller.dart';
import '../appointment_list/appointment_list.dart';
import '../chat/chat.dart';
import '../dashboard/dashboard.dart';
import '../post/post.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart' as myloader;
import '../video/video.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var pageIndex = 0;
  var user_data = [];
  var load_status = false;
  var userid = "";
  final UserController userController = Get.find();
  final util = Utills();

  var   nav_Screens = <Widget>[
    const Dashboard(),
    // const Video(backarrow: false,),
    const AppointmentList(),
    const Post(),
    Chat(null, "http"),
    // const AppointmentList(),
    Setting("")
  ];

  void getUserData(key) async {
    final sp = await SharedPreferences.getInstance();
    setState(() {
      user_data = sp.getStringList(key)!;
      load_status = true;
      userid = user_data[0].toString();
      userController.readStatus.value = true;

      //  util.showSnackBar("Alert", userid.toString(), true);
    });
  }


  @override
  void initState() {
    super.initState();
    getUserData("user_data"); // Fetch user data
    // fetchGalleryImages();
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
                padding: EdgeInsets.all(10.0),
                child: Text(
                  'Login',
                  style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.w700,
                      fontSize: 18),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  'You need to login first!',
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
                          Get.to(const Login());
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

  @override
  Widget build(BuildContext context) {
    print("user id is check ${user_data}");
    print("user id is check ${userid}");
    return SafeArea(      // i have remove the  OverlaySupport( this widget for my code . rezone is my ui is not showing!!
      child: Scaffold(
        // body: UpgradeAlert(child: nav_Screens[pageIndex]),
        body: nav_Screens[pageIndex],
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: MyColor.primarycolor, // Set the desired background color
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(35),  // Top-left corner radius
              topRight: Radius.circular(35), // Top-right corner radius
            ),
          ),
          child: BottomAppBar(
            padding: EdgeInsets.all(1),
            color: Colors.transparent,
            height: 60,
            child: Padding(
              padding: const EdgeInsets.only(top: 3.0),
              child: Row(
                //children inside bottom appbar
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  //home
                  // SizedBox(
                  //   height: 10,
                  // ),
                  Container(
                    height: 65,
                    width: 60,
                    child: Column(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Container(
                            decoration: BoxDecoration(
                                color: pageIndex == 0 ?  Colors.white : MyColor.primarycolor,
                              borderRadius: BorderRadius.circular(35)
                            ),
                            child: IconButton(
                              icon: Image.asset(
                                "assets/images/home_icon.png",
                                color: pageIndex == 0 ? Colors.black : Colors.white,
                              ),
                              onPressed: () {
                                setState(() {
                                  pageIndex = 0;
                                });
                              },
                            ),
                          ),
                        ),
                        Expanded(
                            flex: 1,
                            child: Text(
                              "Home",
                              style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                  color: pageIndex == 0
                                      ? Colors.white
                                      : Colors.white),
                            )),
                      ],
                    ),
                  ),

                  //post
                  Container(
                    height: 60,
                    width: 60,
                    child: Column(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Container(
                            decoration: BoxDecoration(
                                color: pageIndex == 1 ?  Colors.white : MyColor.primarycolor,
                                borderRadius: BorderRadius.circular(35)
                            ),
                            child: IconButton(
                              icon: Image.asset(
                                // "assets/images/playicon.png",
                                "assets/newImages/bookingicon.png",
                                color: pageIndex == 1 ? Colors.black : Colors.white,
                              ),
                              onPressed: () {
                                userid.isEmpty
                                    ? showDialog(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            errorDialog(context))
                                    : setState(() {
                                        pageIndex = 1;
                                      });
                              },
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text("Booking",
                              style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                  color: pageIndex == 1
                                      ? Colors.white
                                      : Colors.white)),
                        ),
                      ],
                    ),
                  ),

                  // book
                  // Container(
                  //   height: 60,
                  //   width: 60,
                  //   decoration: BoxDecoration(
                  //       borderRadius: BorderRadius.circular(30),
                  //       gradient: pageIndex == 2
                  //           ? LinearGradient(colors: [
                  //               Color.fromRGBO(82, 217, 236, 1),
                  //               Color.fromRGBO(30, 106, 161, 0.84)
                  //             ])
                  //           : LinearGradient(
                  //               colors: [Colors.white, Colors.white])),
                  //   child: Column(
                  //     children: [
                  //       Expanded(
                  //         flex: 2,
                  //         child: IconButton(
                  //           icon: Image.asset(
                  //             "assets/images/book.png",
                  //             color: pageIndex == 2 ? Colors.white : Colors.black,
                  //           ),
                  //           onPressed: () {
                  //             userid.isEmpty
                  //                 ? showDialog(
                  //                     context: context,
                  //                     builder: (BuildContext context) =>
                  //                         errorDialog(context))
                  //                 : setState(() {
                  //
                  //                     pageIndex = 2;
                  //                   });
                  //           },
                  //         ),
                  //       ),
                  //       Expanded(
                  //         flex: 1,
                  //         child: Text("Book",
                  //             style: TextStyle(
                  //                 fontSize: 8,
                  //                 color: pageIndex == 2
                  //                     ? Colors.white
                  //                     : Colors.black)),
                  //       ),
                  //     ],
                  //   ),
                  // ),

                  // //chat
                  // Container(
                  //   height: 60,
                  //   width: 60,
                  //   decoration: BoxDecoration(
                  //       borderRadius: BorderRadius.circular(30),
                  //       gradient: pageIndex == 3
                  //           ? LinearGradient(colors: [
                  //               Color.fromRGBO(82, 217, 236, 1),
                  //               Color.fromRGBO(30, 106, 161, 0.84)
                  //             ])
                  //           : LinearGradient(
                  //               colors: [Colors.white, Colors.white])),
                  //   child: Column(
                  //     children: [
                  //       Expanded(
                  //         flex: 2,
                  //         child: Stack(
                  //           children:[ IconButton(
                  //             icon: Image.asset(
                  //               "assets/images/chat_icon.png",
                  //               color: pageIndex == 3 ? Colors.white : Colors.black,
                  //             ),
                  //             onPressed: () {
                  //               userid.isEmpty
                  //                   ? showDialog(
                  //                       context: context,
                  //                       builder: (BuildContext context) =>
                  //                           errorDialog(context))
                  //                   : setState(() {
                  //                       pageIndex = 3;
                  //                       // final util=Utills();
                  //                       // util.showSnackBar("Alert", "Working on this", true);
                  //                     });
                  //             },
                  //           ),
                  //             Obx(() =>Visibility(
                  //               visible: !userController.readStatus.value,
                  //               child: Positioned(child: Container(
                  //                 width: 10,
                  //                 height: 10,
                  //                 decoration: BoxDecoration(
                  //                     borderRadius: BorderRadius.circular(100),
                  //                     color: Colors.red
                  //                 ),
                  //               )),
                  //             ) ),
                  //           ]
                  //         ),
                  //       ),
                  //       Expanded(
                  //         flex: 1,
                  //         child: Text("My Chat",
                  //             style: TextStyle(
                  //                 fontSize: 8,
                  //                 color: pageIndex == 3
                  //                     ? Colors.white
                  //                     : Colors.black)),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  //profile
                  Container(
                    height: 60,
                    width: 60,
                    child: Column(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Container(
                            decoration: BoxDecoration(
                                color: pageIndex == 4 ?  Colors.white : MyColor.primarycolor,
                                borderRadius: BorderRadius.circular(35)
                            ),
                            child: IconButton(
                              icon: Image.asset(
                                "assets/images/profile_icon.png",
                                color: pageIndex == 4 ? Colors.black : Colors.white,
                              ),
                              onPressed: () {
                                setState(() {
                                  pageIndex = 4;
                                });
                              },
                            ),
                          ),
                        ),
                        Expanded(
                            flex: 1,
                              child: Text(
                                "Profile",
                                style: TextStyle(
                                    fontSize: 10,
                                    color: pageIndex == 4
                                        ? Colors.white
                                        : Colors.white),
                              ),
                            ),
                      ],
                    ),
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
