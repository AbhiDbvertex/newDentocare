// import 'dart:async';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:dentocoreauth/pages/auth/login/login.dart';
// import 'package:dentocoreauth/pages/homepage/MyHomePage.dart';
// import 'package:dentocoreauth/utils/app_constant.dart';
// import 'package:dentocoreauth/utils/mycolor.dart';
// import 'package:get/get.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../../Utills/Utills.dart';
//
// class Splash extends StatefulWidget {
//   const Splash({Key? key}) : super(key: key);
//
//   @override
//   State<Splash> createState() => _SplashState();
// }
//
// class _SplashState extends State<Splash> {
//   final util = Utills();
//
//   var user_data = [];
//   var load_status = false;
//   var userid = "";
//
//
//   void GoToHome(String? uid, BuildContext context) {
//     Future.delayed(Duration(seconds: 2), () {
//       debugPrint("Abhi:- get uid njdebug2" + uid!);
//       if (uid == null || uid == "") {
//         debugPrint("njdebug3" + uid!);
//         AppConstant.save_data("isFirst", "yes");
//         Get.offAll(Login());
//       } else {
//
//         setState(() {
//           AppConstant.save_data("isFirst", "yes");
//           Get.offAll(MyHomePage(),arguments: {"is_first":true});
//         });
//
//       }
//     });
//   }
//
//   @override
//   void initState() {
//     // getUserData("user_data");
//
//     setState(() {
//       userid = AppConstant.take_data("token");
//     });
//     Future.delayed(Duration(milliseconds: 500), () {
//       debugPrint("njdebug1" + userid);
//       GoToHome(userid, context);
//     });
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//     SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     SystemChrome.setEnabledSystemUIMode(
//       SystemUiMode.manual,
//       overlays: [
//         SystemUiOverlay.top, // Shows Status bar and hides Navigation bar
//       ],
//     );
//     return AnnotatedRegion<SystemUiOverlayStyle>(
//         value: SystemUiOverlayStyle(
//           statusBarColor: Colors.transparent,
//           statusBarIconBrightness: Brightness.light,
//           statusBarBrightness: Brightness.light,
//           systemNavigationBarColor: Colors.transparent,
//         ),
//         child: Scaffold(
//       backgroundColor: MyColor.APP_COLOR,
//       body: Center(
//               child: Container(
//       height: 180,
//       // width: double.infinity,
//       // height: double.infinity,
//       child: Image.asset(
//         // 'assets/images/Splash.jpg',
//         'assets/newImages/applogo.png',
//         // fit: BoxFit.fill,
//       ),
//               ),
//             ),
//     ));
//   }
// }
//
//

import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dentocoreauth/pages/auth/login/login.dart';
import 'package:dentocoreauth/pages/homepage/MyHomePage.dart';
import 'package:dentocoreauth/utils/app_constant.dart';
import 'package:dentocoreauth/utils/mycolor.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import '../../Utills/Utills.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  final util = Utills();
  var user_data = [];
  var load_status = false;
  var userid = "";
  late VideoPlayerController _controller;

  void GoToHome(String? uid, BuildContext context) {
    Future.delayed(Duration(seconds: 8), () {
      debugPrint("Abhi:- get uid njdebug2" + uid!);
      if (uid == null || uid == "") {
        debugPrint("njdebug3" + uid!);
        AppConstant.save_data("isFirst", "yes");
        Get.offAll(() => Login());
      } else {
        setState(() {
          AppConstant.save_data("isFirst", "yes");
          Get.offAll(() => MyHomePage(), arguments: {"is_first": true});
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();

    // Video controller ko initialize karo
    _controller = VideoPlayerController.asset('assets/splashvideo/splashvideo11.mp4')
      ..initialize().then((_) {
        setState(() {}); // Video ready hone ke baad UI update karo
        _controller.play(); // Video start karo
        _controller.setLooping(false); // Video repeat nahi hoga
      });

    // User ID check karo aur GoToHome call karo
    setState(() {
      userid = AppConstant.take_data("token");
    });
    Future.delayed(Duration(milliseconds: 500), () {
      debugPrint("njdebug1" + userid);
      GoToHome(userid, context);
    });
  }

  @override
  void dispose() {
    _controller.dispose(); // Video controller ko free karo
    super.dispose();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: [
        SystemUiOverlay.top, // Status bar dikhao, navigation bar hide karo
      ],
    );
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.light,
        systemNavigationBarColor: Colors.transparent,
      ),
      child: Scaffold(
        // backgroundColor:  Color(0xE9ECE4F8),
        backgroundColor:  Color(0xFFebebeb),
        body: Center(
          child: _controller.value.isInitialized
              ? AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            child: VideoPlayer(_controller),
          )
              : Container(
            height: 180,
            child: Image.asset(
              'assets/newImages/applogo.png', // Fallback image jab video load ho raha ho
            ),
          ),
        ),
      ),
    );
  }
}


