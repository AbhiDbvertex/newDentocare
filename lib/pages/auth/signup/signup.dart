// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_bounceable/flutter_bounceable.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:dentocoreauth/controllers/signup_controller.dart';
// import 'package:dentocoreauth/pages/auth/login/login.dart';
// import 'package:dentocoreauth/pages/auth/otp/otp.dart';
// import 'package:dentocoreauth/utils/app_constant.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../../../FirebaseApi/FirebaseApi.dart';
// import '../../../Utills/Utills.dart';
// import '../../../controllers/login_controller.dart';
// import '../../../controllers/notification_controller.dart';
// import '../../../controllers/profile_controller.dart';
// import '../../../controllers/user_controller.dart';
// import '../../../utils/mycolor.dart';
// import '../../homepage/MyHomePage.dart';
//
// class Signup extends StatefulWidget {
//   const Signup({Key? key}) : super(key: key);
//
//   @override
//   State<Signup> createState() => _SignupState();
// }
//
// class _SignupState extends State<Signup> {
//   SignupController reg_controller = Get.find();
//   var util = Utills();
//
//   String? f_state = null;
//   String location = "Search Location";
//
//   String googleApikey = "AIzaSyAgSj_AkWBNXVHO4H_UkWnsPecG7IQypfg";
//
//   var isEmailClicked = false;
//   var isPhoneClicked = false;
//   var isNameClicked = false;
//   var isPasswordClicked = false;
//   var isAddressClicked = false;
//
//   LoginController login_Controller = Get.find();
//   final NotificationController notificationController = Get.find();
//   final UserController userController = Get.find();
//   final ProfileController profileController = Get.find();
//
//
//   void saveUserData(key, value) async {
//     final sp = await SharedPreferences.getInstance();
//     setState(() {
//       sp.setStringList(key, value);
//       if (key == "user_data") {
//         print("loginitlogin${"datasaved"}");
//       } else if (key == "temp") {
//         print("loginit${"datasavedtemp"}");
//       }
//       ;
//     });
//   }
//
//   final FirebaseAuth auth = FirebaseAuth.instance;
//
//   Future signOut() async {
//     return await FirebaseAuth.instance.signOut();
//   }
//   Future<void> signup(BuildContext context) async {
//
//     final GoogleSignIn googleSignIn = GoogleSignIn();
//     await googleSignIn.signOut();
//
//     final GoogleSignInAccount? googleSignInAccount =
//     await googleSignIn.signIn();
//     if (googleSignInAccount != null) {
//       final GoogleSignInAuthentication googleSignInAuthentication =
//       await googleSignInAccount.authentication;
//
//       final AuthCredential authCredential = GoogleAuthProvider.credential(
//           idToken: googleSignInAuthentication.idToken,
//           accessToken: googleSignInAuthentication.accessToken);
//
//       // Getting users credential
//       util.startLoading();
//       UserCredential result = await auth.signInWithCredential(authCredential);
//       User? user = result.user;
//
//       if (result != null) {
//         util.stopLoading();
//         Guser guser = new Guser(
//           user!.displayName.toString(),
//           user!.email.toString(),
//           user!.photoURL.toString(),
//           user!.uid.toString(),
//         );
//
//
//         // util.showSnackBar("Alert", guser.email, true);
//         // util.showSnackBar("Alert", guser.name, true);
//         // util.showSnackBar("Alert", guser.photo, true);
//         debugPrint(
//             "guser" + guser.email + guser.name + guser.photo + guser.id);
//
//         debugPrint("onlyemail" + "${guser.email}");
//         debugPrint("onlynname" + "${guser.name}");
//         await FirebaseApi().initFirebase();
//         login_Controller
//             .loginByGoogle(guser.name, guser.email)
//             .then((value) => {
//           if (value!.message == "Login successfully." ||
//               value!.message == "User created successfully.")
//             {
//               debugPrint("debuggoogle" + "success"),
//               util.showSuccessProcess(),
//               saveUserData("user_data", [
//                 value!.data.id.toString(),
//                 value!.data.name.toString(),
//                 value!.data.email.toString(),
//                 value!.data.mobile.toString(),
//                 value!.data.password.toString(),
//                 value!.data.address.toString(),
//                 value!.data.profile_images.toString(),
//                 value!.data.createdAt.toString(),
//               ]),
//               AppConstant.save_data("token", value!.data.id.toString()),
//               AppConstant.save_data("isFirst", "yes"),
//               util.showSuccessProcess(),
//               if (value!.data.id.toString().isNotEmpty)
//                 {
//                   notificationController
//                       .getNotifications(value!.data.id.toString()),
//                   userController
//                       .getAppointmentlist(value!.data.id.toString())
//                       .then(
//                           (value) => userController.getlist.refresh()),
//                   profileController
//                       .getProfile(value!.data.id.toString())
//                       .then((value) => profileController.image.value =
//                       value!.body.image),
//                 },
//               Navigator.pushReplacement(context,
//                   MaterialPageRoute(builder: (context) => MyHomePage()))
//             }
//           else
//             {debugPrint("debuggoogle" + "else")}
//         });
//
//         //hit api
//         // Navigator.pushReplacement(
//         //     context, MaterialPageRoute(builder: (context) => MyHomePage()));
//       }else{
//         util.stopLoading();
//       } // if result not null we simply call the MaterialpageRoute,
//       // for go to the HomePage screen
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final height = MediaQuery.of(context).size.height;
//     final width = MediaQuery.of(context).size.width;
//     return Scaffold(
//       body: GestureDetector(
//         onTap: () {
//           FocusManager.instance.primaryFocus?.unfocus();
//           setState(() {
//             isEmailClicked = false;
//             isPhoneClicked = false;
//             isNameClicked = false;
//             isPasswordClicked = false;
//             isAddressClicked = false;
//           });
//         },
//         behavior: HitTestBehavior.opaque,
//         child: SingleChildScrollView(
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 30),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   SizedBox(
//                     height: height*0.03
//                   ),
//                   Text("Singup",
//                       style: GoogleFonts.openSans(
//                           textStyle: Theme.of(context).textTheme.displayLarge,
//                           fontSize: AppConstant.LARGE_SIZE,
//                           fontWeight: FontWeight.w600,
//                           fontStyle: FontStyle.normal,
//                           color: MyColor.APP_TITLE_COLOR)),
//                   Align(
//                       alignment: Alignment.centerLeft,
//                       child: Text("Full name",
//                           style: GoogleFonts.nunitoSans(
//                               textStyle: Theme.of(context)
//                                   .textTheme
//                                   .displayLarge,
//                               fontSize: 17,
//                               // fontWeight: FontWeight.w600,
//                               fontStyle: FontStyle.normal,
//                               color: Colors.grey))),
//                   SizedBox(
//                     height: AppConstant.MEDIUM_TEXT_SIZE,
//                   ),
//                   Container(
//                     decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(
//                             AppConstant.APP_NORMAL_PADDING),
//                         border:
//                         Border.all(color: Colors.grey, width: 1.0)),
//                     child: Column(
//                       children: [
//                         Container(
//                           height: height*0.07,
//                           child: Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Center(
//                               child: TextFormField(
//                                 onTap: () {
//                                   setState(() {
//                                     isEmailClicked = false;
//                                     isPhoneClicked = false;
//                                     isNameClicked = true;
//                                     isPasswordClicked = false;
//                                     isAddressClicked = false;
//                                   });
//                                 },
//                                 controller: reg_controller.name,
//                                 decoration:
//                                  InputDecoration.collapsed(
//                                   hintText: AppConstant.HINT_TEXT_NAME,
//                                   hintStyle: TextStyle(
//                                       color: MyColor
//                                           .LOGIN_TEXT_HINT_PASSWORD_COLOR),
//                                 ),
//                                 keyboardType: TextInputType.text,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   SizedBox(
//                     height: height*0.03,
//                   ),
//                   Container(
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Align(
//                             alignment: Alignment.centerLeft,
//                             child: Text("E-mail",
//                                 style: GoogleFonts.nunitoSans(
//                                     textStyle: Theme.of(context)
//                                         .textTheme
//                                         .displayLarge,
//                                     fontSize: 17,
//                                     // fontWeight: FontWeight.w600,
//                                     fontStyle: FontStyle.normal,
//                                     color: Colors.grey))),
//                         SizedBox(
//                           height: height*0.01,
//                         ),
//                         Container(
//                           decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(
//                                   AppConstant.APP_NORMAL_PADDING),
//                               border:
//                                   Border.all(color: Colors.grey, width: 1.0)),
//                           child: Column(
//                             children: [
//                               Container(
//                                 height: height*0.07,
//                                 child: Padding(
//                                   padding: const EdgeInsets.all(8.0),
//                                   child: Center(
//                                     child: TextField(
//                                       onTap: () {
//                                         setState(() {
//                                           isEmailClicked = true;
//                                           isPhoneClicked = false;
//                                           isNameClicked = false;
//                                           isPasswordClicked = false;
//                                           isAddressClicked = false;
//                                         });
//                                       },
//                                       controller: reg_controller.email,
//                                       decoration:
//                                         InputDecoration.collapsed(
//                                         hintText: AppConstant.HINT_TEXT_EMAIL,
//                                         hintStyle: TextStyle(
//                                             color: MyColor
//                                                 .LOGIN_TEXT_HINT_PASSWORD_COLOR),
//                                       ),
//                                       keyboardType:
//                                           TextInputType.emailAddress,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         SizedBox(
//                           height: height*0.02,
//                         ),
//                         Align(
//                             alignment: Alignment.centerLeft,
//                             child: Text("Mobile",
//                                 style: GoogleFonts.nunitoSans(
//                                     textStyle: Theme.of(context)
//                                         .textTheme
//                                         .displayLarge,
//                                     fontSize: 17,
//                                     // fontWeight: FontWeight.w600,
//                                     fontStyle: FontStyle.normal,
//                                     color: Colors.grey))),
//
//                         SizedBox(
//                           height: height*0.01,
//                         ),
//                         //mobile
//                         Container(
//                           decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(
//                                   AppConstant.APP_NORMAL_PADDING),
//                               border:
//                                   Border.all(color: Colors.grey, width: 1.0)),
//                           child: Column(
//                             children: [
//                               Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: Container(
//                                   height: height*0.05,
//                                   child: Center(
//                                       child: TextFormField(
//                                     onTap: () {
//                                       setState(() {
//                                         isEmailClicked = false;
//                                         isPhoneClicked = true;
//                                         isNameClicked = false;
//                                         isPasswordClicked = false;
//                                         isAddressClicked = false;
//                                       });
//                                     },
//                                     controller: reg_controller.phone,
//                                     inputFormatters: [
//                                       LengthLimitingTextInputFormatter(10),
//                                     ],
//                                     decoration: InputDecoration.collapsed(
//                                         hintText:
//                                             AppConstant.HINT_TEXT_MOBILE,
//                                         hintStyle: TextStyle(
//                                             color: MyColor
//                                                 .LOGIN_TEXT_HINT_PASSWORD_COLOR),
//                                         border: InputBorder.none,
//                                         floatingLabelAlignment:
//                                             FloatingLabelAlignment.start),
//                                     keyboardType: TextInputType.phone,
//                                     onChanged: (phone) {},
//                                     textAlignVertical:
//                                         TextAlignVertical.center,
//                                   )),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         // SizedBox(
//                         //   height: AppConstant.LARGE_SIZE,
//                         // ),
//                         //
//                         SizedBox(
//                           height: height*0.03,
//                         ),
//                         Align(
//                             alignment: Alignment.centerLeft,
//                             child: Text("Password",
//                                 style: GoogleFonts.nunitoSans(
//                                     textStyle: Theme.of(context)
//                                         .textTheme
//                                         .displayLarge,
//                                     fontSize: 17,
//                                     // fontWeight: FontWeight.w600,
//                                     fontStyle: FontStyle.normal,
//                                     color: Colors.grey))),
//                         SizedBox(
//                           height: height*0.01,
//                         ),
//                         Container(
//                           decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(
//                                   AppConstant.APP_NORMAL_PADDING),
//                               border:
//                                   Border.all(color: Colors.grey, width: 1.0)),
//                           child: Column(
//                             children: [
//                               Container(
//                                 height: height*0.07,
//                                 child: Center(
//                                   child: TextField(
//                                     onTap: () {
//                                       setState(() {
//                                         isEmailClicked = false;
//                                         isPhoneClicked = false;
//                                         isNameClicked = false;
//                                         isPasswordClicked = true;
//                                         isAddressClicked = false;
//                                       });
//                                     },
//                                     controller: reg_controller.password,
//                                     decoration:
//                                         new InputDecoration.collapsed(
//                                       hintText:
//                                           AppConstant.HINT_TEXT_PASSWORD,
//                                       hintStyle: TextStyle(
//                                           color: MyColor
//                                               .LOGIN_TEXT_HINT_PASSWORD_COLOR),
//                                     ),
//                                     keyboardType:
//                                         TextInputType.visiblePassword,
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         SizedBox(
//                           height: height*0.03,
//                         ),
//                         Align(
//                             alignment: Alignment.centerLeft,
//                             child: Text("Address",
//                                 style: GoogleFonts.nunitoSans(
//                                     textStyle: Theme.of(context)
//                                         .textTheme
//                                         .displayLarge,
//                                     fontSize: 17,
//                                     // fontWeight: FontWeight.w600,
//                                     fontStyle: FontStyle.normal,
//                                     color: Colors.grey))),
//                         SizedBox(
//                           height: height*0.01,
//                         ),
//                         Container(
//                           decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(
//                                   AppConstant.APP_NORMAL_PADDING),
//                               border:
//                                   Border.all(color: Colors.grey, width: 1.0)),
//                           child: Column(
//                             children: [
//                               Container(
//                                 height: height*0.07,
//                                 child: Padding(
//                                   padding: const EdgeInsets.all(8.0),
//                                   child: Center(
//                                     child: TextField(
//                                       onTap: () {
//                                         isEmailClicked = false;
//                                         isPhoneClicked = false;
//                                         isNameClicked = false;
//                                         isPasswordClicked = false;
//                                         isAddressClicked = true;
//                                       },
//                                       controller: reg_controller.address,
//                                       decoration:
//                                           new InputDecoration.collapsed(
//                                         hintText: "Please Enter Address",
//                                         hintStyle: TextStyle(
//                                             color: MyColor
//                                                 .LOGIN_TEXT_HINT_PASSWORD_COLOR),
//                                       ),
//                                       keyboardType: TextInputType.text,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   SizedBox(
//                     height: AppConstant.APP_EXTRA_LARGE_PADDING,
//                   ),
//                   InkWell(
//                     onTap: () {
//                       if (EasyLoading.isShow == true) {
//                         return null;
//                       }
//                       var res = reg_controller.signUp();
//                       if (res != null) {
//                         res.then((value) => () {
//                               util.showSnackBar(
//                                   "Alert", value!.message.toString(), true);
//
//                               util.showSnackBar(
//                                   "Hello", "${value.data.name}", true);
//                               if (value.message != null) {
//                                 if (value.message.toString() ==
//                                     "OTP sent successfully to email.") {
//                                   Get.to(Otp(
//                                       reg_controller.email.text.toString(),
//                                       "registration"));
//                                 }
//                               }
//                             });
//                       }
//
//                       //Get.to(Forgot_Password());
//                     },
//                     child: Padding(
//                       padding: const EdgeInsets.all(10.0),
//                       child: Container(
//
//                         decoration: BoxDecoration(
//                           boxShadow:  [
//                             BoxShadow(
//                               color: Colors.grey,
//                               offset: const Offset(
//                                 5.0,
//                                 5.0,
//                               ),
//                               blurRadius: 10.0,
//                               spreadRadius: 2.0,
//                             ), //BoxShadow
//                             BoxShadow(
//                               color: Colors.white,
//                               offset: const Offset(0.0, 0.0),
//                               blurRadius: 0.0,
//                               spreadRadius: 0.0,
//                             ), //
//                             // BoxShadow
//                           ],
//                          color: MyColor.primarycolor,
//                           borderRadius: BorderRadius.circular(20),
//                         ),
//                         margin: EdgeInsets.only(top: 8.00,bottom: 8.00),
//                         height: 49,
//                         width: 289,
//                         child: Center(
//                           child: Text("SING UP",
//                               style: GoogleFonts.nunitoSans(
//                                   textStyle: Theme.of(context)
//                                       .textTheme
//                                       .displayLarge,
//                                   fontSize:18,
//                                   fontWeight: FontWeight.w700,
//                                   fontStyle: FontStyle.normal,
//                                   color: Colors.white)),
//                         ),
//                       ),
//                     ),
//                   ),
//                   // Visibility(
//                   //   visible: true,
//                   //   child: Padding(
//                   //     padding: EdgeInsets.only(
//                   //         left: AppConstant.LARGE_SIZE,
//                   //         right: AppConstant.LARGE_SIZE,
//                   //         bottom: AppConstant.SMALL_TEXT_SIZE),
//                   //     child: Bounceable(
//                   //       onTap: () {
//                   //         // if (EasyLoading.isShow == true) {
//                   //         //   return;
//                   //         // }
//                   //         //var result = login_Controller.login();
//                   //        // signup(context);
//                   //         // signOut().then((value) => {
//                   //         //   debugPrint("debuggoogle"+"${value.toString()}"),
//                   //         //
//                   //         // });
//                   //          signup(context);
//                   //         //
//                   //         // if (result != null) {
//                   //         //   result.then((value) => {
//                   //         //     AppConstant.user_id =
//                   //         //         value!.data.id.toString(),
//                   //         //     util.showSnackBar(
//                   //         //       "Alert",
//                   //         //       value!.message.toString(),
//                   //         //       true,
//                   //         //     ),
//                   //         //     saveUserData("user_data", [
//                   //         //       value!.data.id.toString(),
//                   //         //       value!.data.name.toString(),
//                   //         //       value!.data.email.toString(),
//                   //         //       value!.data.mobile.toString(),
//                   //         //       value!.data.password.toString(),
//                   //         //       value!.data.address.toString(),
//                   //         //       value!.data.image.toString()
//                   //         //     ]),
//                   //         //     AppConstant.save_data(
//                   //         //         "token", value!.data.id.toString()),
//                   //         //     AppConstant.save_data("isFirst", "yes"),
//                   //         //     Get.offAll(MyHomePage())
//                   //         //   });
//                   //         // }
//                   //       },
//                   //       child: Card(
//                   //         margin: const EdgeInsets.all(8.00),
//                   //         shape: RoundedRectangleBorder(
//                   //             borderRadius: BorderRadius.circular(20)),
//                   //         elevation: 1,
//                   //         child: Container(
//                   //           decoration: BoxDecoration(
//                   //             boxShadow:  [
//                   //               BoxShadow(
//                   //                 color: Colors.grey,
//                   //                 offset: const Offset(
//                   //                   5.0,
//                   //                   5.0,
//                   //                 ),
//                   //                 blurRadius: 10.0,
//                   //                 spreadRadius: 2.0,
//                   //               ), //BoxShadow
//                   //               BoxShadow(
//                   //                 color: Colors.white,
//                   //                 offset: const Offset(0.0, 0.0),
//                   //                 blurRadius: 0.0,
//                   //                 spreadRadius: 0.0,
//                   //               ), //
//                   //               // BoxShadow
//                   //             ],
//                   //             borderRadius: BorderRadius.circular(20),
//                   //           ),
//                   //           width: AppConstant.BUTTON_WIDTH,
//                   //           height: AppConstant.BUTTON_HIGHT,
//                   //           child: Row(
//                   //             mainAxisAlignment: MainAxisAlignment.center,
//                   //             children: [
//                   //               Center(
//                   //                   child: Container(
//                   //                     width: 30,
//                   //                     height: 30,
//                   //                     decoration: BoxDecoration(
//                   //                         borderRadius:
//                   //                         BorderRadius.circular(100),
//                   //                         color: Colors.red,
//                   //                         gradient: LinearGradient(
//                   //                             begin: Alignment.topCenter,
//                   //                             end: Alignment.bottomCenter,
//                   //                             colors: [
//                   //                               Color.fromRGBO(151, 231, 249, 1),
//                   //                               Color.fromRGBO(151, 135, 210, 1)
//                   //                             ])),
//                   //                     child: Image.asset(
//                   //                       "assets/images/google.png",
//                   //                       scale: 1,
//                   //                     ),
//                   //                   )),
//                   //               SizedBox(
//                   //                 width: 10,
//                   //               ),
//                   //               Center(
//                   //                 child: Text("Sign in with Google",
//                   //                     style: GoogleFonts.nunitoSans(
//                   //                       textStyle: Theme.of(context)
//                   //                           .textTheme
//                   //                           .displayLarge,
//                   //                       fontSize: AppConstant.MEDIUM_SIZE,
//                   //                       fontWeight: FontWeight.w700,
//                   //                       fontStyle: FontStyle.normal,
//                   //                       color: Color.fromRGBO(0, 149, 173, 1),
//                   //                     )),
//                   //               ),
//                   //             ],
//                   //           ),
//                   //         ),
//                   //       ),
//                   //     ),
//                   //   ),
//                   // ),
//                   Padding(
//                     padding: const EdgeInsets.only(top: 8.00, bottom: 16.0),
//                     child: Bounceable(
//                         onTap: () {
//                           //   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Signup_Screen()));
//                           Get.offAll(Login());
//                         },
//                         child: Center(child: AppConstant.lgoin_text(context))),
//                   ),
//                   SizedBox(
//                     height: 30,
//                   )
//                 ],
//               ),
//             ),
//
//         ),
//       ),
//     );
//   }
// }

/// currect code

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_bounceable/flutter_bounceable.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:dentocoreauth/controllers/signup_controller.dart';
// import 'package:dentocoreauth/pages/auth/forgot_password/forgot_password.dart';
// import 'package:dentocoreauth/pages/auth/login/login.dart';
// import 'package:dentocoreauth/pages/auth/otp/otp.dart';
// import 'package:dentocoreauth/utils/app_constant.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../../../FirebaseApi/FirebaseApi.dart';
// import '../../../Utills/Utills.dart';
// import '../../../controllers/login_controller.dart';
// import '../../../controllers/notification_controller.dart';
// import '../../../controllers/profile_controller.dart';
// import '../../../controllers/user_controller.dart';
// import '../../../utils/mycolor.dart';
// import '../../homepage/MyHomePage.dart';
//
// class Signup extends StatefulWidget {
//   const Signup({Key? key}) : super(key: key);
//
//   @override
//   State<Signup> createState() => _SignupState();
// }
//
// class _SignupState extends State<Signup> {
//   SignupController reg_controller = Get.find();
//   var util = Utills();
//
//   String? f_state = null;
//   String location = "Search Location";
//
//   String googleApikey = "AIzaSyAgSj_AkWBNXVHO4H_UkWnsPecG7IQypfg";
//
//   var isEmailClicked = false;
//   var isPhoneClicked = false;
//   var isNameClicked = false;
//   var isPasswordClicked = false;
//   var isAddressClicked = false;
//
//   LoginController login_Controller = Get.find();
//   final NotificationController notificationController = Get.find();
//   final UserController userController = Get.find();
//   final ProfileController profileController = Get.find();
//   var isVisible = true;
//   var isVisibletwo = true;
//
//   @override
//   void dispose() {
//     // TODO: implement dispose
//     super.dispose();
//     reg_controller.email.clear();
//     reg_controller.name.clear();
//     reg_controller.address.clear();
//     reg_controller.password.clear();
//     reg_controller.phone.clear();
//   }
//
//   void saveUserData(key, value) async {
//     final sp = await SharedPreferences.getInstance();
//     setState(() {
//       sp.setStringList(key, value);
//       if (key == "user_data") {
//         print("loginitlogin${"datasaved"}");
//       } else if (key == "temp") {
//         print("loginit${"datasavedtemp"}");
//       }
//       ;
//     });
//   }
//
//   final FirebaseAuth auth = FirebaseAuth.instance;
//
//   Future signOut() async {
//     return await FirebaseAuth.instance.signOut();
//   }
//   Future<void> signup(BuildContext context) async {
//
//     final GoogleSignIn googleSignIn = GoogleSignIn();
//     await googleSignIn.signOut();
//
//     final GoogleSignInAccount? googleSignInAccount =
//     await googleSignIn.signIn();
//     if (googleSignInAccount != null) {
//       final GoogleSignInAuthentication googleSignInAuthentication =
//       await googleSignInAccount.authentication;
//
//       final AuthCredential authCredential = GoogleAuthProvider.credential(
//           idToken: googleSignInAuthentication.idToken,
//           accessToken: googleSignInAuthentication.accessToken);
//
//       // Getting users credential
//       util.startLoading();
//       UserCredential result = await auth.signInWithCredential(authCredential);
//       User? user = result.user;
//
//       if (result != null) {
//         util.stopLoading();
//         Guser guser = new Guser(
//           user!.displayName.toString(),
//           user!.email.toString(),
//           user!.photoURL.toString(),
//           user!.uid.toString(),
//         );
//
//
//         // util.showSnackBar("Alert", guser.email, true);
//         // util.showSnackBar("Alert", guser.name, true);
//         // util.showSnackBar("Alert", guser.photo, true);
//         debugPrint(
//             "guser" + guser.email + guser.name + guser.photo + guser.id);
//
//         debugPrint("onlyemail" + "${guser.email}");
//         debugPrint("onlynname" + "${guser.name}");
//         await FirebaseApi().initFirebase();
//         login_Controller
//             .loginByGoogle(guser.name, guser.email)
//             .then((value) => {
//           if (value!.message == "Login successfully." ||
//               value!.message == "User created successfully.")
//             {
//               debugPrint("debuggoogle" + "success"),
//               util.showSuccessProcess(),
//               saveUserData("user_data", [
//                 value!.data.id.toString(),
//                 value!.data.name.toString(),
//                 value!.data.email.toString(),
//                 value!.data.mobile.toString(),
//                 value!.data.password.toString(),
//                 value!.data.address.toString(),
//                 value!.data.profile_images.toString(),
//                 value!.data.createdAt.toString(),
//               ]),
//               AppConstant.save_data("token", value!.data.id.toString()),
//               AppConstant.save_data("isFirst", "yes"),
//               util.showSuccessProcess(),
//               if (value!.data.id.toString().isNotEmpty)
//                 {
//                   notificationController
//                       .getNotifications(value!.data.id.toString()),
//                   userController
//                       .getAppointmentlist(value!.data.id.toString())
//                       .then(
//                           (value) => userController.getlist.refresh()),
//                   profileController
//                       .getProfile(value!.data.id.toString())
//                       .then((value) => profileController.image.value =
//                       value!.body.image),
//                 },
//               Navigator.pushReplacement(context,
//                   MaterialPageRoute(builder: (context) => MyHomePage()))
//             }
//           else
//             {debugPrint("debuggoogle" + "else")}
//         });
//
//         //hit api
//         // Navigator.pushReplacement(
//         //     context, MaterialPageRoute(builder: (context) => MyHomePage()));
//       }else{
//         util.stopLoading();
//       } // if result not null we simply call the MaterialpageRoute,
//       // for go to the HomePage screen
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final height = MediaQuery.of(context).size.height;
//     final width = MediaQuery.of(context).size.width;
//     return Scaffold(
//       body: GestureDetector(
//         onTap: () {
//           FocusManager.instance.primaryFocus?.unfocus();
//           setState(() {
//             isEmailClicked = false;
//             isPhoneClicked = false;
//             isNameClicked = false;
//             isPasswordClicked = false;
//             isAddressClicked = false;
//           });
//         },
//         behavior: HitTestBehavior.opaque,
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 30),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 SizedBox(
//                     height: height*0.03
//                 ),
//                 Text("Singup",
//                     style: GoogleFonts.openSans(
//                         textStyle: Theme.of(context).textTheme.displayLarge,
//                         fontSize: AppConstant.LARGE_SIZE,
//                         fontWeight: FontWeight.w600,
//                         fontStyle: FontStyle.normal,
//                         color: MyColor.APP_TITLE_COLOR)),
//                 Align(
//                     alignment: Alignment.centerLeft,
//                     child: Text("Full name",
//                         style: GoogleFonts.nunitoSans(
//                             textStyle: Theme.of(context)
//                                 .textTheme
//                                 .displayLarge,
//                             fontSize: 17,
//                             // fontWeight: FontWeight.w600,
//                             fontStyle: FontStyle.normal,
//                             color: Colors.grey))),
//                 SizedBox(
//                   height: AppConstant.MEDIUM_TEXT_SIZE,
//                 ),
//                 Container(
//                   decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(
//                           AppConstant.APP_NORMAL_PADDING),
//                       border:
//                       Border.all(color: Colors.grey, width: 1.0)),
//                   child: Column(
//                     children: [
//                       Container(
//                         height: height*0.07,
//                         child: Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Center(
//                             child: TextFormField(
//                               inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r"^[a-z,A-Z\s]+$"))],
//                               onTap: () {
//                                 setState(() {
//                                   isEmailClicked = false;
//                                   isPhoneClicked = false;
//                                   isNameClicked = true;
//                                   isPasswordClicked = false;
//                                   isAddressClicked = false;
//                                 });
//                               },
//                               controller: reg_controller.name,
//                               decoration:
//                               InputDecoration.collapsed(
//                                 hintText: AppConstant.HINT_TEXT_NAME,
//                                 hintStyle: TextStyle(
//                                     color: MyColor
//                                         .LOGIN_TEXT_HINT_PASSWORD_COLOR),
//                               ),
//                               keyboardType: TextInputType.text,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(
//                   height: height*0.03,
//                 ),
//                 Container(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Align(
//                           alignment: Alignment.centerLeft,
//                           child: Text("E-mail",
//                               style: GoogleFonts.nunitoSans(
//                                   textStyle: Theme.of(context)
//                                       .textTheme
//                                       .displayLarge,
//                                   fontSize: 17,
//                                   // fontWeight: FontWeight.w600,
//                                   fontStyle: FontStyle.normal,
//                                   color: Colors.grey))),
//                       SizedBox(
//                         height: height*0.01,
//                       ),
//                       Container(
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(
//                                 AppConstant.APP_NORMAL_PADDING),
//                             border:
//                             Border.all(color: Colors.grey, width: 1.0)),
//                         child: Column(
//                           children: [
//                             Container(
//                               height: height*0.07,
//                               child: Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: Center(
//                                   child: TextField(/* r"^[a-z,A-Z]+$"*/
//                                     inputFormatters: [
//                                       FilteringTextInputFormatter.allow(
//                                         RegExp(r'[a-zA-Z0-9@._-]'),
//                                       ),
//                                     ],
//                                     onTap: () {
//                                       setState(() {
//                                         isEmailClicked = true;
//                                         isPhoneClicked = false;
//                                         isNameClicked = false;
//                                         isPasswordClicked = false;
//                                         isAddressClicked = false;
//                                       });
//                                     },
//                                     controller: reg_controller.email,
//                                     decoration:
//                                     InputDecoration.collapsed(
//                                       hintText: AppConstant.HINT_TEXT_EMAIL,
//                                       hintStyle: TextStyle(
//                                           color: MyColor
//                                               .LOGIN_TEXT_HINT_PASSWORD_COLOR),
//                                     ),
//                                     keyboardType:
//                                     TextInputType.emailAddress,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       SizedBox(
//                         height: height*0.02,
//                       ),
//                       Align(
//                           alignment: Alignment.centerLeft,
//                           child: Text("Mobile",
//                               style: GoogleFonts.nunitoSans(
//                                   textStyle: Theme.of(context)
//                                       .textTheme
//                                       .displayLarge,
//                                   fontSize: 17,
//                                   // fontWeight: FontWeight.w600,
//                                   fontStyle: FontStyle.normal,
//                                   color: Colors.grey))),
//
//                       SizedBox(
//                         height: height*0.01,
//                       ),
//                       //mobile
//                       Container(
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(
//                                 AppConstant.APP_NORMAL_PADDING),
//                             border:
//                             Border.all(color: Colors.grey, width: 1.0)),
//                         child: Column(
//                           children: [
//                             Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Container(
//                                 height: height*0.05,
//                                 child: Center(
//                                     child: TextFormField(
//                                       inputFormatters: [ LengthLimitingTextInputFormatter(10),FilteringTextInputFormatter.allow(RegExp(r"^[0-9]+$"))],
//                                       onTap: () {
//                                         setState(() {
//                                           isEmailClicked = false;
//                                           isPhoneClicked = true;
//                                           isNameClicked = false;
//                                           isPasswordClicked = false;
//                                           isAddressClicked = false;
//                                         });
//                                       },
//                                       controller: reg_controller.phone,
//                                       // inputFormatters: [
//                                       //   LengthLimitingTextInputFormatter(10),
//                                       // ],
//                                       decoration: InputDecoration.collapsed(
//                                           hintText:
//                                           AppConstant.HINT_TEXT_MOBILE,
//                                           hintStyle: TextStyle(
//                                               color: MyColor
//                                                   .LOGIN_TEXT_HINT_PASSWORD_COLOR),
//                                           border: InputBorder.none,
//                                           floatingLabelAlignment:
//                                           FloatingLabelAlignment.start),
//                                       keyboardType: TextInputType.phone,
//                                       onChanged: (phone) {},
//                                       textAlignVertical:
//                                       TextAlignVertical.center,
//                                     )),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       // SizedBox(
//                       //   height: AppConstant.LARGE_SIZE,
//                       // ),
//                       //
//                       SizedBox(
//                         height: height*0.03,
//                       ),
//                       Align(
//                           alignment: Alignment.centerLeft,
//                           child: Text("Address",
//                               style: GoogleFonts.nunitoSans(
//                                   textStyle: Theme.of(context)
//                                       .textTheme
//                                       .displayLarge,
//                                   fontSize: 17,
//                                   // fontWeight: FontWeight.w600,
//                                   fontStyle: FontStyle.normal,
//                                   color: Colors.grey))),
//                       SizedBox(
//                         height: height*0.01,
//                       ),
//                       Container(
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(
//                                 AppConstant.APP_NORMAL_PADDING),
//                             border:
//                             Border.all(color: Colors.grey, width: 1.0)),
//                         child: Column(
//                           children: [
//                             Container(
//                               height: height*0.07,
//                               child: Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: Center(
//                                   child: TextField(
//                                     inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r"^[a-z,A-Z\s0-9@$,.]+$"))],
//                                     onTap: () {
//                                       isEmailClicked = false;
//                                       isPhoneClicked = false;
//                                       isNameClicked = false;
//                                       isPasswordClicked = false;
//                                       isAddressClicked = true;
//                                     },
//                                     controller: reg_controller.address,
//                                     decoration:
//                                     new InputDecoration.collapsed(
//                                       hintText: "Please Enter Address",
//                                       hintStyle: TextStyle(
//                                           color: MyColor
//                                               .LOGIN_TEXT_HINT_PASSWORD_COLOR),
//                                     ),
//                                     keyboardType: TextInputType.text,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       SizedBox(
//                         height: height*0.03,
//                       ),
//                       Align(
//                           alignment: Alignment.centerLeft,
//                           child: Text("Password",
//                               style: GoogleFonts.nunitoSans(
//                                   textStyle: Theme.of(context)
//                                       .textTheme
//                                       .displayLarge,
//                                   fontSize: 17,
//                                   // fontWeight: FontWeight.w600,
//                                   fontStyle: FontStyle.normal,
//                                   color: Colors.grey))),
//                       SizedBox(
//                         height: height*0.01,
//                       ),
//                       Container(
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(
//                                 AppConstant.APP_NORMAL_PADDING),
//                             border:
//                             Border.all(color: Colors.grey, width: 1.0)),
//                         child: Column(
//                           children: [
//                             Container(
//                               height: height*0.07,
//                               child: Center(
//                                 child: Padding(
//                                   padding: const EdgeInsets.all(5.0),
//                                   child: TextField(
//                                     onTap: () {
//                                       setState(() {
//                                         isEmailClicked = false;
//                                         isPhoneClicked = false;
//                                         isNameClicked = false;
//                                         isPasswordClicked = true;
//                                         isAddressClicked = false;
//                                       });
//                                     },
//                                     controller: reg_controller.password,
//                                     decoration: InputDecoration(
//                                       hintText:
//                                       AppConstant.HINT_TEXT_PASSWORD,
//                                       hintStyle: TextStyle(
//                                           color: MyColor
//                                               .LOGIN_TEXT_HINT_PASSWORD_COLOR),
//                                         suffixIcon: IconButton(
//                                           onPressed: () {
//                                             setState(() {
//                                               isVisible = !isVisible;
//                                             });
//                                           },
//                                           icon: Icon(isVisible
//                                               ? Icons.visibility_off
//                                               : Icons.remove_red_eye),
//                                           color:
//                                           isVisible ? Colors.grey : Colors.grey,
//                                         ),
//                                       border: InputBorder.none
//                                     ),
//                                     obscureText: isVisible,
//                                     keyboardType:
//                                     TextInputType.visiblePassword,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       // conform password
//                       SizedBox(
//                         height: height*0.03,
//                       ),
//                       Align(
//                           alignment: Alignment.centerLeft,
//                           child: Text("Conform Password",
//                               style: GoogleFonts.nunitoSans(
//                                   textStyle: Theme.of(context)
//                                       .textTheme
//                                       .displayLarge,
//                                   fontSize: 17,
//                                   // fontWeight: FontWeight.w600,
//                                   fontStyle: FontStyle.normal,
//                                   color: Colors.grey))),
//                       SizedBox(
//                         height: height*0.01,
//                       ),
//                       Container(
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(
//                                 AppConstant.APP_NORMAL_PADDING),
//                             border:
//                             Border.all(color: Colors.grey, width: 1.0)),
//                         child: Column(
//                           children: [
//                             Container(
//                               height: height*0.07,
//                               child: Center(
//                                 child: Padding(
//                                   padding: const EdgeInsets.all(5.0),
//                                   child: TextField(
//                                     onTap: () {
//                                       setState(() {
//                                         isEmailClicked = false;
//                                         isPhoneClicked = false;
//                                         isNameClicked = false;
//                                         isPasswordClicked = true;
//                                         isAddressClicked = false;
//                                       });
//                                     },
//                                     // controller: reg_controller.password,
//                                     decoration: InputDecoration(
//                                         hintText:
//                                         AppConstant.HINT_TEXT_PASSWORD,
//                                         hintStyle: TextStyle(
//                                             color: MyColor
//                                                 .LOGIN_TEXT_HINT_PASSWORD_COLOR),
//                                         suffixIcon: IconButton(
//                                           onPressed: () {
//                                             setState(() {
//                                               isVisibletwo = !isVisibletwo;
//                                             });
//                                           },
//                                           icon: Icon(isVisibletwo
//                                               ? Icons.visibility_off
//                                               : Icons.remove_red_eye),
//                                           color:
//                                           isVisibletwo ? Colors.grey : Colors.grey,
//                                         ),
//                                         border: InputBorder.none
//                                     ),
//                                     obscureText: isVisibletwo,
//                                     keyboardType:
//                                     TextInputType.visiblePassword,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(
//                   height: AppConstant.APP_EXTRA_LARGE_PADDING,
//                 ),
//                 InkWell(
//                   onTap: () {
//                     if (EasyLoading.isShow == true) {
//                       return null;
//                     }
//                     var res = reg_controller.signUp();
//                     if (res != null) {
//                       res.then((value) => () {
//                         util.showSnackBar(
//                             "Alert", value!.message.toString(), true);
//
//                         util.showSnackBar(
//                             "Hello", "${value.data.name}", true);
//                         if (value.message != null) {
//                           if (value.message.toString() ==
//                               "OTP sent successfully to email.") {
//                             Get.to(Otp(
//                                 reg_controller.email.text.toString(),
//                                 "registration"));
//                           }
//                         }
//                       });
//                     }
//                     //Get.to(Forgot_Password());
//                   },
//                   child: Padding(
//                     padding: const EdgeInsets.all(10.0),
//                     child: Container(
//
//                       decoration: BoxDecoration(
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.grey,
//                             offset: const Offset(
//                               5.0,
//                               5.0,
//                             ),
//                             blurRadius: 10.0,
//                             spreadRadius: 2.0,
//                           ), //BoxShadow
//                           BoxShadow(
//                             color: Colors.white,
//                             offset: const Offset(0.0, 0.0),
//                             blurRadius: 0.0,
//                             spreadRadius: 0.0,
//                           ), //
//                           // BoxShadow
//                         ],
//                         color: MyColor.primarycolor,
//                         borderRadius: BorderRadius.circular(20),
//                       ),
//                       margin: EdgeInsets.only(top: 8.00,bottom: 8.00),
//                       height: 49,
//                       width: 289,
//                       child: Center(
//                         child: Text("SING UP",
//                             style: GoogleFonts.nunitoSans(
//                                 textStyle: Theme.of(context)
//                                     .textTheme
//                                     .displayLarge,
//                                 fontSize:18,
//                                 fontWeight: FontWeight.w700,
//                                 fontStyle: FontStyle.normal,
//                                 color: Colors.white)),
//                       ),
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(top: 8.00, bottom: 16.0),
//                   child: Bounceable(
//                       onTap: () {
//                         //   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Signup_Screen()));
//                         Get.offAll(Login());
//                       },
//                       child: Center(child: AppConstant.lgoin_text(context))),
//                 ),
//                 SizedBox(
//                   height: 30,
//                 )
//               ],
//             ),
//           ),
//
//         ),
//       ),
//     );
//   }
// }
///

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_bounceable/flutter_bounceable.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:dentocoreauth/controllers/signup_controller.dart';
// import 'package:dentocoreauth/pages/auth/forgot_password/forgot_password.dart';
// import 'package:dentocoreauth/pages/auth/login/login.dart';
// import 'package:dentocoreauth/pages/auth/otp/otp.dart';
// import 'package:dentocoreauth/utils/app_constant.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../../../FirebaseApi/FirebaseApi.dart';
// import '../../../Utills/Utills.dart';
// import '../../../controllers/login_controller.dart';
// import '../../../controllers/notification_controller.dart';
// import '../../../controllers/profile_controller.dart';
// import '../../../controllers/user_controller.dart';
// import '../../../utils/mycolor.dart';
// import '../../homepage/MyHomePage.dart';
//
// class Signup extends StatefulWidget {
//   const Signup({Key? key}) : super(key: key);
//
//   @override
//   State<Signup> createState() => _SignupState();
// }
//
// class _SignupState extends State<Signup> {
//   SignupController reg_controller = Get.find();
//   var util = Utills();
//
//   String? f_state = null;
//   String location = "Search Location";
//
//   String googleApikey = "AIzaSyAgSj_AkWBNXVHO4H_UkWnsPecG7IQypfg";
//
//   var isEmailClicked = false;
//   var isPhoneClicked = false;
//   var isNameClicked = false;
//   var isPasswordClicked = false;
//   var isAddressClicked = false;
//
//   LoginController login_Controller = Get.find();
//   final NotificationController notificationController = Get.find();
//   final UserController userController = Get.find();
//   final ProfileController profileController = Get.find();
//   var isVisible = true;
//   var isVisibletwo = true;
//
//   @override
//   void dispose() {
//     // TODO: implement dispose
//     super.dispose();
//     reg_controller.email.clear();
//     reg_controller.name.clear();
//     reg_controller.address.clear();
//     reg_controller.password.clear();
//     reg_controller.phone.clear();
//     reg_controller.confirmPassword.clear();
//   }
//
//   void saveUserData(key, value) async {
//     final sp = await SharedPreferences.getInstance();
//     setState(() {
//       sp.setStringList(key, value);
//       if (key == "user_data") {
//         print("loginitlogin${"datasaved"}");
//       } else if (key == "temp") {
//         print("loginit${"datasavedtemp"}");
//       }
//       ;
//     });
//   }
//
//   final FirebaseAuth auth = FirebaseAuth.instance;
//
//   Future signOut() async {
//     return await FirebaseAuth.instance.signOut();
//   }
//   Future<void> signup(BuildContext context) async {
//
//     final GoogleSignIn googleSignIn = GoogleSignIn();
//     await googleSignIn.signOut();
//
//     final GoogleSignInAccount? googleSignInAccount =
//     await googleSignIn.signIn();
//     if (googleSignInAccount != null) {
//       final GoogleSignInAuthentication googleSignInAuthentication =
//       await googleSignInAccount.authentication;
//
//       final AuthCredential authCredential = GoogleAuthProvider.credential(
//           idToken: googleSignInAuthentication.idToken,
//           accessToken: googleSignInAuthentication.accessToken);
//
//       // Getting users credential
//       util.startLoading();
//       UserCredential result = await auth.signInWithCredential(authCredential);
//       User? user = result.user;
//
//       if (result != null) {
//         util.stopLoading();
//         Guser guser = new Guser(
//           user!.displayName.toString(),
//           user!.email.toString(),
//           user!.photoURL.toString(),
//           user!.uid.toString(),
//         );
//
//
//         // util.showSnackBar("Alert", guser.email, true);
//         // util.showSnackBar("Alert", guser.name, true);
//         // util.showSnackBar("Alert", guser.photo, true);
//         debugPrint(
//             "guser" + guser.email + guser.name + guser.photo + guser.id);
//
//         debugPrint("onlyemail" + "${guser.email}");
//         debugPrint("onlynname" + "${guser.name}");
//         await FirebaseApi().initFirebase();
//         login_Controller
//             .loginByGoogle(guser.name, guser.email)
//             .then((value) => {
//           if (value!.message == "Login successfully." ||
//               value!.message == "User created successfully.")
//             {
//               debugPrint("debuggoogle" + "success"),
//               util.showSuccessProcess(),
//               saveUserData("user_data", [
//                 value!.data.id.toString(),
//                 value!.data.name.toString(),
//                 value!.data.email.toString(),
//                 value!.data.mobile.toString(),
//                 value!.data.password.toString(),
//                 value!.data.address.toString(),
//                 value!.data.profile_images.toString(),
//                 value!.data.createdAt.toString(),
//               ]),
//               AppConstant.save_data("token", value!.data.id.toString()),
//               AppConstant.save_data("isFirst", "yes"),
//               util.showSuccessProcess(),
//               if (value!.data.id.toString().isNotEmpty)
//                 {
//                   notificationController
//                       .getNotifications(value!.data.id.toString()),
//                   userController
//                       .getAppointmentlist(value!.data.id.toString())
//                       .then(
//                           (value) => userController.getlist.refresh()),
//                   profileController
//                       .getProfile(value!.data.id.toString())
//                       .then((value) => profileController.image.value =
//                       value!.body.image),
//                 },
//               Navigator.pushReplacement(context,
//                   MaterialPageRoute(builder: (context) => MyHomePage()))
//             }
//           else
//             {debugPrint("debuggoogle" + "else")}
//         });
//
//         //hit api
//         // Navigator.pushReplacement(
//         //     context, MaterialPageRoute(builder: (context) => MyHomePage()));
//       }else{
//         util.stopLoading();
//       } // if result not null we simply call the MaterialpageRoute,
//       // for go to the HomePage screen
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final height = MediaQuery.of(context).size.height;
//     final width = MediaQuery.of(context).size.width;
//     return Scaffold(
//       body: GestureDetector(
//         onTap: () {
//           FocusManager.instance.primaryFocus?.unfocus();
//           setState(() {
//             isEmailClicked = false;
//             isPhoneClicked = false;
//             isNameClicked = false;
//             isPasswordClicked = false;
//             isAddressClicked = false;
//           });
//         },
//         behavior: HitTestBehavior.opaque,
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 30),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 SizedBox(
//                     height: height*0.03
//                 ),
//                 Text("Singup",
//                     style: GoogleFonts.openSans(
//                         textStyle: Theme.of(context).textTheme.displayLarge,
//                         fontSize: AppConstant.LARGE_SIZE,
//                         fontWeight: FontWeight.w600,
//                         fontStyle: FontStyle.normal,
//                         color: MyColor.APP_TITLE_COLOR)),
//                 Align(
//                     alignment: Alignment.centerLeft,
//                     child: Text("Full name",
//                         style: GoogleFonts.nunitoSans(
//                             textStyle: Theme.of(context)
//                                 .textTheme
//                                 .displayLarge,
//                             fontSize: 17,
//                             // fontWeight: FontWeight.w600,
//                             fontStyle: FontStyle.normal,
//                             color: Colors.grey))),
//                 SizedBox(
//                   height: AppConstant.MEDIUM_TEXT_SIZE,
//                 ),
//                 Container(
//                   decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(
//                           AppConstant.APP_NORMAL_PADDING),
//                       border:
//                       Border.all(color: Colors.grey, width: 1.0)),
//                   child: Column(
//                     children: [
//                       Container(
//                         height: height*0.07,
//                         child: Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Center(
//                             child: TextFormField(
//                               inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r"^[a-z,A-Z\s]+$"))],
//                               onTap: () {
//                                 setState(() {
//                                   isEmailClicked = false;
//                                   isPhoneClicked = false;
//                                   isNameClicked = true;
//                                   isPasswordClicked = false;
//                                   isAddressClicked = false;
//                                 });
//                               },
//                               controller: reg_controller.name,
//                               decoration:
//                               InputDecoration.collapsed(
//                                 hintText: AppConstant.HINT_TEXT_NAME,
//                                 hintStyle: TextStyle(
//                                     color: MyColor
//                                         .LOGIN_TEXT_HINT_PASSWORD_COLOR),
//                               ),
//                               keyboardType: TextInputType.text,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(
//                   height: height*0.03,
//                 ),
//                 Container(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Align(
//                           alignment: Alignment.centerLeft,
//                           child: Text("E-mail",
//                               style: GoogleFonts.nunitoSans(
//                                   textStyle: Theme.of(context)
//                                       .textTheme
//                                       .displayLarge,
//                                   fontSize: 17,
//                                   // fontWeight: FontWeight.w600,
//                                   fontStyle: FontStyle.normal,
//                                   color: Colors.grey))),
//                       SizedBox(
//                         height: height*0.01,
//                       ),
//                       Container(
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(
//                                 AppConstant.APP_NORMAL_PADDING),
//                             border:
//                             Border.all(color: Colors.grey, width: 1.0)),
//                         child: Column(
//                           children: [
//                             Container(
//                               height: height*0.07,
//                               child: Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: Center(
//                                   child: TextField(/* r"^[a-z,A-Z]+$"*/
//                                     inputFormatters: [
//                                       FilteringTextInputFormatter.allow(
//                                         RegExp(r'[a-zA-Z0-9@._-]'),
//                                       ),
//                                     ],
//                                     onTap: () {
//                                       setState(() {
//                                         isEmailClicked = true;
//                                         isPhoneClicked = false;
//                                         isNameClicked = false;
//                                         isPasswordClicked = false;
//                                         isAddressClicked = false;
//                                       });
//                                     },
//                                     controller: reg_controller.email,
//                                     decoration:
//                                     InputDecoration.collapsed(
//                                       hintText: AppConstant.HINT_TEXT_EMAIL,
//                                       hintStyle: TextStyle(
//                                           color: MyColor
//                                               .LOGIN_TEXT_HINT_PASSWORD_COLOR),
//                                     ),
//                                     keyboardType:
//                                     TextInputType.emailAddress,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       SizedBox(
//                         height: height*0.02,
//                       ),
//                       Align(
//                           alignment: Alignment.centerLeft,
//                           child: Text("Mobile",
//                               style: GoogleFonts.nunitoSans(
//                                   textStyle: Theme.of(context)
//                                       .textTheme
//                                       .displayLarge,
//                                   fontSize: 17,
//                                   // fontWeight: FontWeight.w600,
//                                   fontStyle: FontStyle.normal,
//                                   color: Colors.grey))),
//
//                       SizedBox(
//                         height: height*0.01,
//                       ),
//                       //mobile
//                       Container(
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(
//                                 AppConstant.APP_NORMAL_PADDING),
//                             border:
//                             Border.all(color: Colors.grey, width: 1.0)),
//                         child: Column(
//                           children: [
//                             Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Container(
//                                 height: height*0.05,
//                                 child: Center(
//                                     child: TextFormField(
//                                       inputFormatters: [ LengthLimitingTextInputFormatter(10),FilteringTextInputFormatter.allow(RegExp(r"^[0-9]+$"))],
//                                       onTap: () {
//                                         setState(() {
//                                           isEmailClicked = false;
//                                           isPhoneClicked = true;
//                                           isNameClicked = false;
//                                           isPasswordClicked = false;
//                                           isAddressClicked = false;
//                                         });
//                                       },
//                                       controller: reg_controller.phone,
//                                       // inputFormatters: [
//                                       //   LengthLimitingTextInputFormatter(10),
//                                       // ],
//                                       decoration: InputDecoration.collapsed(
//                                           hintText:
//                                           AppConstant.HINT_TEXT_MOBILE,
//                                           hintStyle: TextStyle(
//                                               color: MyColor
//                                                   .LOGIN_TEXT_HINT_PASSWORD_COLOR),
//                                           border: InputBorder.none,
//                                           floatingLabelAlignment:
//                                           FloatingLabelAlignment.start),
//                                       keyboardType: TextInputType.phone,
//                                       onChanged: (phone) {},
//                                       textAlignVertical:
//                                       TextAlignVertical.center,
//                                     )),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       // SizedBox(
//                       //   height: AppConstant.LARGE_SIZE,
//                       // ),
//                       //
//                       SizedBox(
//                         height: height*0.03,
//                       ),
//                       Align(
//                           alignment: Alignment.centerLeft,
//                           child: Text("Address",
//                               style: GoogleFonts.nunitoSans(
//                                   textStyle: Theme.of(context)
//                                       .textTheme
//                                       .displayLarge,
//                                   fontSize: 17,
//                                   // fontWeight: FontWeight.w600,
//                                   fontStyle: FontStyle.normal,
//                                   color: Colors.grey))),
//                       SizedBox(
//                         height: height*0.01,
//                       ),
//                       Container(
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(
//                                 AppConstant.APP_NORMAL_PADDING),
//                             border:
//                             Border.all(color: Colors.grey, width: 1.0)),
//                         child: Column(
//                           children: [
//                             Container(
//                               height: height*0.07,
//                               child: Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: Center(
//                                   child: TextField(
//                                     inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r"^[a-z,A-Z\s0-9@$,.]+$"))],
//                                     onTap: () {
//                                       isEmailClicked = false;
//                                       isPhoneClicked = false;
//                                       isNameClicked = false;
//                                       isPasswordClicked = false;
//                                       isAddressClicked = true;
//                                     },
//                                     controller: reg_controller.address,
//                                     decoration:
//                                     new InputDecoration.collapsed(
//                                       hintText: "Please Enter Address",
//                                       hintStyle: TextStyle(
//                                           color: MyColor
//                                               .LOGIN_TEXT_HINT_PASSWORD_COLOR),
//                                     ),
//                                     keyboardType: TextInputType.text,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       SizedBox(
//                         height: height*0.03,
//                       ),
//                       Align(
//                           alignment: Alignment.centerLeft,
//                           child: Text("Password",
//                               style: GoogleFonts.nunitoSans(
//                                   textStyle: Theme.of(context)
//                                       .textTheme
//                                       .displayLarge,
//                                   fontSize: 17,
//                                   // fontWeight: FontWeight.w600,
//                                   fontStyle: FontStyle.normal,
//                                   color: Colors.grey))),
//                       SizedBox(
//                         height: height*0.01,
//                       ),
//                       Container(
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(
//                                 AppConstant.APP_NORMAL_PADDING),
//                             border:
//                             Border.all(color: Colors.grey, width: 1.0)),
//                         child: Column(
//                           children: [
//                             Container(
//                               height: height*0.07,
//                               child: Center(
//                                 child: Padding(
//                                   padding: const EdgeInsets.all(5.0),
//                                   child: TextField(
//                                     onTap: () {
//                                       setState(() {
//                                         isEmailClicked = false;
//                                         isPhoneClicked = false;
//                                         isNameClicked = false;
//                                         isPasswordClicked = true;
//                                         isAddressClicked = false;
//                                       });
//                                     },
//                                     controller: reg_controller.password,
//                                     decoration: InputDecoration(
//                                         hintText:
//                                         AppConstant.HINT_TEXT_PASSWORD,
//                                         hintStyle: TextStyle(
//                                             color: MyColor
//                                                 .LOGIN_TEXT_HINT_PASSWORD_COLOR),
//                                         suffixIcon: IconButton(
//                                           onPressed: () {
//                                             setState(() {
//                                               isVisible = !isVisible;
//                                             });
//                                           },
//                                           icon: Icon(isVisible
//                                               ? Icons.visibility_off
//                                               : Icons.remove_red_eye),
//                                           color:
//                                           isVisible ? Colors.grey : Colors.grey,
//                                         ),
//                                         border: InputBorder.none
//                                     ),
//                                     obscureText: isVisible,
//                                     keyboardType:
//                                     TextInputType.visiblePassword,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       // conform password
//                       SizedBox(
//                         height: height*0.03,
//                       ),
//                       Align(
//                           alignment: Alignment.centerLeft,
//                           child: Text("Conform Password",
//                               style: GoogleFonts.nunitoSans(
//                                   textStyle: Theme.of(context)
//                                       .textTheme
//                                       .displayLarge,
//                                   fontSize: 17,
//                                   // fontWeight: FontWeight.w600,
//                                   fontStyle: FontStyle.normal,
//                                   color: Colors.grey))),
//                       SizedBox(
//                         height: height*0.01,
//                       ),
//                       Container(
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(
//                                 AppConstant.APP_NORMAL_PADDING),
//                             border:
//                             Border.all(color: Colors.grey, width: 1.0)),
//                         child: Column(
//                           children: [
//                             Container(
//                               height: height*0.07,
//                               child: Center(
//                                 child: Padding(
//                                   padding: const EdgeInsets.all(5.0),
//                                   child: TextField(
//                                     onTap: () {
//                                       setState(() {
//                                         isEmailClicked = false;
//                                         isPhoneClicked = false;
//                                         isNameClicked = false;
//                                         isPasswordClicked = true;
//                                         isAddressClicked = false;
//                                       });
//                                     },
//                                     controller: reg_controller.confirmPassword,
//                                     decoration: InputDecoration(
//                                         hintText:
//                                         AppConstant.HINT_TEXT_PASSWORD,
//                                         hintStyle: TextStyle(
//                                             color: MyColor
//                                                 .LOGIN_TEXT_HINT_PASSWORD_COLOR),
//                                         suffixIcon: IconButton(
//                                           onPressed: () {
//                                             setState(() {
//                                               isVisibletwo = !isVisibletwo;
//                                             });
//                                           },
//                                           icon: Icon(isVisibletwo
//                                               ? Icons.visibility_off
//                                               : Icons.remove_red_eye),
//                                           color:
//                                           isVisibletwo ? Colors.grey : Colors.grey,
//                                         ),
//                                         border: InputBorder.none
//                                     ),
//                                     obscureText: isVisibletwo,
//                                     keyboardType:
//                                     TextInputType.visiblePassword,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(
//                   height: AppConstant.APP_EXTRA_LARGE_PADDING,
//                 ),
//                 InkWell(
//                   onTap: () {
//                     if (EasyLoading.isShow == true) {
//                       return null;
//                     }
//                     var res = reg_controller.signUp();
//                     if (res != null) {
//                       res.then((value) => () {
//                         util.showSnackBar(
//                             "Alert", value!.message.toString(), true);
//
//                         util.showSnackBar(
//                             "Hello", "${value.data.name}", true);
//                         if (value.message != null) {
//                           if (value.message.toString() ==
//                               "OTP sent successfully to email.") {
//                             Get.to(Otp(
//                                 reg_controller.email.text.toString(),
//                                 "registration"));
//                           }
//                         }
//                       });
//                     }
//                     //Get.to(Forgot_Password());
//                   },
//                   child: Padding(
//                     padding: const EdgeInsets.all(10.0),
//                     child: Container(
//                       decoration: BoxDecoration(
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.grey,
//                             offset: const Offset(
//                               5.0,
//                               5.0,
//                             ),
//                             blurRadius: 10.0,
//                             spreadRadius: 2.0,
//                           ), //BoxShadow
//                           BoxShadow(
//                             color: Colors.white,
//                             offset: const Offset(0.0, 0.0),
//                             blurRadius: 0.0,
//                             spreadRadius: 0.0,
//                           ), //
//                           // BoxShadow
//                         ],
//                         color: MyColor.primarycolor,
//                         borderRadius: BorderRadius.circular(20),
//                       ),
//                       margin: EdgeInsets.only(top: 8.00,bottom: 8.00),
//                       height: 49,
//                       width: 289,
//                       child: Center(
//                         child: Text("SING UP",
//                             style: GoogleFonts.nunitoSans(
//                                 textStyle: Theme.of(context)
//                                     .textTheme
//                                     .displayLarge,
//                                 fontSize:18,
//                                 fontWeight: FontWeight.w700,
//                                 fontStyle: FontStyle.normal,
//                                 color: Colors.white)),
//                       ),
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(top: 8.00, bottom: 16.0),
//                   child: Bounceable(
//                       onTap: () {
//                         //   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Signup_Screen()));
//                         Get.offAll(Login());
//                       },
//                       child: Center(child: AppConstant.lgoin_text(context))),
//                 ),
//                 SizedBox(
//                   height: 30,
//                 )
//               ],
//             ),
//           ),
//
//         ),
//       ),
//     );
//   }
// }

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:dentocoreauth/controllers/signup_controller.dart';
import 'package:dentocoreauth/pages/auth/forgot_password/forgot_password.dart';
import 'package:dentocoreauth/pages/auth/login/login.dart';
import 'package:dentocoreauth/pages/auth/otp/otp.dart';
import 'package:dentocoreauth/utils/app_constant.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../FirebaseApi/FirebaseApi.dart';
import '../../../Utills/Utills.dart';
import '../../../controllers/login_controller.dart';
import '../../../controllers/notification_controller.dart';
import '../../../controllers/profile_controller.dart';
import '../../../controllers/user_controller.dart';
import '../../../utils/mycolor.dart';
import '../../homepage/MyHomePage.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  SignupController reg_controller = Get.find();
  var util = Utills();

  String? f_state = null;
  String location = "Search Location";

  String googleApikey = "AIzaSyAgSj_AkWBNXVHO4H_UkWnsPecG7IQypfg";

  var isEmailClicked = false;
  var isPhoneClicked = false;
  var isNameClicked = false;
  var isPasswordClicked = false;
  var isAddressClicked = false;
  var isDobClicked = false;

  LoginController login_Controller = Get.find();
  final NotificationController notificationController = Get.find();
  final UserController userController = Get.find();
  final ProfileController profileController = Get.find();
  var isVisible = true;
  var isVisibletwo = true;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    reg_controller.email.clear();
    reg_controller.name.clear();
    reg_controller.address.clear();
    reg_controller.password.clear();
    reg_controller.phone.clear();
    reg_controller.confirmPassword.clear();
    reg_controller.dob.clear();
  }

  void saveUserData(key, value) async {
    final sp = await SharedPreferences.getInstance();
    setState(() {
      sp.setStringList(key, value);
      if (key == "user_data") {
        print("loginitlogin${"datasaved"}");
      } else if (key == "temp") {
        print("loginit${"datasavedtemp"}");
      }
      ;
    });
  }

  final FirebaseAuth auth = FirebaseAuth.instance;

  Future signOut() async {
    return await FirebaseAuth.instance.signOut();
  }

  Future<void> signup(BuildContext context) async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();

    final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;

      final AuthCredential authCredential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken);

      // Getting users credential
      util.startLoading();
      UserCredential result = await auth.signInWithCredential(authCredential);
      User? user = result.user;

      if (result != null) {
        util.stopLoading();
        Guser guser = new Guser(
          user!.displayName.toString(),
          user!.email.toString(),
          user!.photoURL.toString(),
          user!.uid.toString(),
        );

        // util.showSnackBar("Alert", guser.email, true);
        // util.showSnackBar("Alert", guser.name, true);
        // util.showSnackBar("Alert", guser.photo, true);
        debugPrint("guser" + guser.email + guser.name + guser.photo + guser.id);

        debugPrint("onlyemail" + "${guser.email}");
        debugPrint("onlynname" + "${guser.name}");
        await FirebaseApi().initFirebase();
        login_Controller.loginByGoogle(guser.name, guser.email).then((value) => {
          if (value!.message == "Login successfully." ||
              value!.message == "User created successfully.")
            {
              debugPrint("debuggoogle" + "success"),
              util.showSuccessProcess(),
              saveUserData("user_data", [
                value!.data.id.toString(),
                value!.data.name.toString(),
                value!.data.email.toString(),
                value!.data.mobile.toString(),
                value!.data.password.toString(),
                value!.data.address.toString(),
                value!.data.profile_images.toString(),
                value!.data.createdAt.toString(),
              ]),
              AppConstant.save_data("token", value!.data.id.toString()),
              AppConstant.save_data("isFirst", "yes"),
              util.showSuccessProcess(),
              if (value!.data.id.toString().isNotEmpty)
                {
                  notificationController
                      .getNotifications(value!.data.id.toString()),
                  userController
                      .getAppointmentlist(value!.data.id.toString())
                      .then((value) => userController.getlist.refresh()),
                  profileController
                      .getProfile(value!.data.id.toString())
                      .then((value) =>
                  profileController.image.value = value!.body.image),
                },
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => MyHomePage()))
            }
          else
            {debugPrint("debuggoogle" + "else")}
        });

        //hit api
        // Navigator.pushReplacement(
        //     context, MaterialPageRoute(builder: (context) => MyHomePage()));
      } else {
        util.stopLoading();
      } // if result not null we simply call the MaterialpageRoute,
      // for go to the HomePage screen
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        reg_controller.dob.text =
        "${picked.year}-${picked.month}-${picked.day}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    print("Abhi:- print date or form piked : ${reg_controller.dob.text}");
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
          setState(() {
            isEmailClicked = false;
            isPhoneClicked = false;
            isNameClicked = false;
            isPasswordClicked = false;
            isAddressClicked = false;
            isDobClicked = false;
          });
        },
        behavior: HitTestBehavior.opaque,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: height * 0.03),
                Text(
                    "Singup",
                    style: GoogleFonts.openSans(
                        textStyle: Theme.of(context).textTheme.displayLarge,
                        fontSize: AppConstant.LARGE_SIZE,
                        fontWeight: FontWeight.w600,
                        fontStyle: FontStyle.normal,
                        color: MyColor.APP_TITLE_COLOR)),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Full name",
                        style: GoogleFonts.nunitoSans(
                            textStyle: Theme.of(context).textTheme.displayLarge,
                            fontSize: 17,
                            fontStyle: FontStyle.normal,
                            color: Colors.grey))),
                SizedBox(height: AppConstant.MEDIUM_TEXT_SIZE),
                Container(
                  decoration: BoxDecoration(
                      borderRadius:
                      BorderRadius.circular(AppConstant.APP_NORMAL_PADDING),
                      border: Border.all(color: Colors.grey, width: 1.0)),
                  child: Column(
                    children: [
                      Container(
                        height: height * 0.07,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: TextFormField(
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r"^[a-z,A-Z\s]+$"))
                              ],
                              onTap: () {
                                setState(() {
                                  isEmailClicked = false;
                                  isPhoneClicked = false;
                                  isNameClicked = true;
                                  isPasswordClicked = false;
                                  isAddressClicked = false;
                                  isDobClicked = false;
                                });
                              },
                              controller: reg_controller.name,
                              decoration: InputDecoration.collapsed(
                                hintText: AppConstant.HINT_TEXT_NAME,
                                hintStyle: TextStyle(
                                    color:
                                    MyColor.LOGIN_TEXT_HINT_PASSWORD_COLOR),
                              ),
                              keyboardType: TextInputType.text,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: height * 0.03),
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text("E-mail",
                              style: GoogleFonts.nunitoSans(
                                  textStyle:
                                  Theme.of(context).textTheme.displayLarge,
                                  fontSize: 17,
                                  fontStyle: FontStyle.normal,
                                  color: Colors.grey))),
                      SizedBox(height: height * 0.01),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                AppConstant.APP_NORMAL_PADDING),
                            border: Border.all(color: Colors.grey, width: 1.0)),
                        child: Column(
                          children: [
                            Container(
                              height: height * 0.07,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                  child: TextField(
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(
                                        RegExp(r'[a-zA-Z0-9@._-]'),
                                      ),
                                    ],
                                    onTap: () {
                                      setState(() {
                                        isEmailClicked = true;
                                        isPhoneClicked = false;
                                        isNameClicked = false;
                                        isPasswordClicked = false;
                                        isAddressClicked = false;
                                        isDobClicked = false;
                                      });
                                    },
                                    controller: reg_controller.email,
                                    decoration: InputDecoration.collapsed(
                                      hintText: AppConstant.HINT_TEXT_EMAIL,
                                      hintStyle: TextStyle(
                                          color: MyColor
                                              .LOGIN_TEXT_HINT_PASSWORD_COLOR),
                                    ),
                                    keyboardType: TextInputType.emailAddress,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: height * 0.02),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text("Mobile",
                              style: GoogleFonts.nunitoSans(
                                  textStyle:
                                  Theme.of(context).textTheme.displayLarge,
                                  fontSize: 17,
                                  fontStyle: FontStyle.normal,
                                  color: Colors.grey))),
                      SizedBox(height: height * 0.01),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                AppConstant.APP_NORMAL_PADDING),
                            border: Border.all(color: Colors.grey, width: 1.0)),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: height * 0.05,
                                child: Center(
                                    child: TextFormField(
                                      inputFormatters: [
                                        LengthLimitingTextInputFormatter(10),
                                        FilteringTextInputFormatter.allow(
                                            RegExp(r"^[0-9]+$"))
                                      ],
                                      onTap: () {
                                        setState(() {
                                          isEmailClicked = false;
                                          isPhoneClicked = true;
                                          isNameClicked = false;
                                          isPasswordClicked = false;
                                          isAddressClicked = false;
                                          isDobClicked = false;
                                        });
                                      },
                                      controller: reg_controller.phone,
                                      decoration: InputDecoration.collapsed(
                                          hintText: AppConstant.HINT_TEXT_MOBILE,
                                          hintStyle: TextStyle(
                                              color: MyColor
                                                  .LOGIN_TEXT_HINT_PASSWORD_COLOR),
                                          border: InputBorder.none,
                                          floatingLabelAlignment:
                                          FloatingLabelAlignment.start),
                                      keyboardType: TextInputType.phone,
                                      onChanged: (phone) {},
                                      textAlignVertical: TextAlignVertical.center,
                                    )),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: height * 0.03),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text("Date of Birth",
                              style: GoogleFonts.nunitoSans(
                                  textStyle:
                                  Theme.of(context).textTheme.displayLarge,
                                  fontSize: 17,
                                  fontStyle: FontStyle.normal,
                                  color: Colors.grey))),
                      SizedBox(height: height * 0.01),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                AppConstant.APP_NORMAL_PADDING),
                            border: Border.all(color: Colors.grey, width: 1.0)),
                        child: Column(
                          children: [
                            Container(
                              height: height * 0.07,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                  child: TextField(
                                    readOnly: true,
                                    onTap: () {
                                      setState(() {
                                        isEmailClicked = false;
                                        isPhoneClicked = false;
                                        isNameClicked = false;
                                        isPasswordClicked = false;
                                        isAddressClicked = false;
                                        isDobClicked = true;
                                      });
                                      _selectDate(context);
                                    },
                                    controller: reg_controller.dob,
                                    decoration: InputDecoration.collapsed(
                                      hintText: "Select Date of Birth",
                                      hintStyle: TextStyle(
                                          color: MyColor
                                              .LOGIN_TEXT_HINT_PASSWORD_COLOR),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: height * 0.03),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text("Address",
                              style: GoogleFonts.nunitoSans(
                                  textStyle:
                                  Theme.of(context).textTheme.displayLarge,
                                  fontSize: 17,
                                  fontStyle: FontStyle.normal,
                                  color: Colors.grey))),
                      SizedBox(height: height * 0.01),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                AppConstant.APP_NORMAL_PADDING),
                            border: Border.all(color: Colors.grey, width: 1.0)),
                        child: Column(
                          children: [
                            Container(
                              height: height * 0.07,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                  child: TextField(
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(
                                          RegExp(r"^[a-z,A-Z\s0-9@$,.]+$"))
                                    ],
                                    onTap: () {
                                      setState(() {
                                        isEmailClicked = false;
                                        isPhoneClicked = false;
                                        isNameClicked = false;
                                        isPasswordClicked = false;
                                        isAddressClicked = true;
                                        isDobClicked = false;
                                      });
                                    },
                                    controller: reg_controller.address,
                                    decoration: InputDecoration.collapsed(
                                      hintText: "Please Enter Address",
                                      hintStyle: TextStyle(
                                          color: MyColor
                                              .LOGIN_TEXT_HINT_PASSWORD_COLOR),
                                    ),
                                    keyboardType: TextInputType.text,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: height * 0.03),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text("Password",
                              style: GoogleFonts.nunitoSans(
                                  textStyle:
                                  Theme.of(context).textTheme.displayLarge,
                                  fontSize: 17,
                                  fontStyle: FontStyle.normal,
                                  color: Colors.grey))),
                      SizedBox(height: height * 0.01),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                AppConstant.APP_NORMAL_PADDING),
                            border: Border.all(color: Colors.grey, width: 1.0)),
                        child: Column(
                          children: [
                            Container(
                              height: height * 0.07,
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: TextField(
                                    onTap: () {
                                      setState(() {
                                        isEmailClicked = false;
                                        isPhoneClicked = false;
                                        isNameClicked = false;
                                        isPasswordClicked = true;
                                        isAddressClicked = false;
                                        isDobClicked = false;
                                      });
                                    },
                                    controller: reg_controller.password,
                                    decoration: InputDecoration(
                                        hintText: AppConstant.HINT_TEXT_PASSWORD,
                                        hintStyle: TextStyle(
                                            color: MyColor
                                                .LOGIN_TEXT_HINT_PASSWORD_COLOR),
                                        suffixIcon: IconButton(
                                          onPressed: () {
                                            setState(() {
                                              isVisible = !isVisible;
                                            });
                                          },
                                          icon: Icon(isVisible
                                              ? Icons.visibility_off
                                              : Icons.remove_red_eye),
                                          color: isVisible
                                              ? Colors.grey
                                              : Colors.grey,
                                        ),
                                        border: InputBorder.none),
                                    obscureText: isVisible,
                                    keyboardType: TextInputType.visiblePassword,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: height * 0.03),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text("Conform Password",
                              style: GoogleFonts.nunitoSans(
                                  textStyle:
                                  Theme.of(context).textTheme.displayLarge,
                                  fontSize: 17,
                                  fontStyle: FontStyle.normal,
                                  color: Colors.grey))),
                      SizedBox(height: height * 0.01),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                AppConstant.APP_NORMAL_PADDING),
                            border: Border.all(color: Colors.grey, width: 1.0)),
                        child: Column(
                          children: [
                            Container(
                              height: height * 0.07,
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: TextField(
                                    onTap: () {
                                      setState(() {
                                        isEmailClicked = false;
                                        isPhoneClicked = false;
                                        isNameClicked = false;
                                        isPasswordClicked = true;
                                        isAddressClicked = false;
                                        isDobClicked = false;
                                      });
                                    },
                                    controller: reg_controller.confirmPassword,
                                    decoration: InputDecoration(
                                        hintText: AppConstant.HINT_TEXT_PASSWORD,
                                        hintStyle: TextStyle(
                                            color: MyColor
                                                .LOGIN_TEXT_HINT_PASSWORD_COLOR),
                                        suffixIcon: IconButton(
                                          onPressed: () {
                                            setState(() {
                                              isVisibletwo = !isVisibletwo;
                                            });
                                          },
                                          icon: Icon(isVisibletwo
                                              ? Icons.visibility_off
                                              : Icons.remove_red_eye),
                                          color: isVisibletwo
                                              ? Colors.grey
                                              : Colors.grey,
                                        ),
                                        border: InputBorder.none),
                                    obscureText: isVisibletwo,
                                    keyboardType: TextInputType.visiblePassword,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: AppConstant.APP_EXTRA_LARGE_PADDING),
                InkWell(
                  onTap: () {
                    if (EasyLoading.isShow == true) {
                      return null;
                    }
                    var res = reg_controller.signUp();
                    if (res != null) {
                      res.then((value) => () {
                        util.showSnackBar(
                            "Alert", value!.message.toString(), true);
                        util.showSnackBar(
                            "Hello", "${value.data.name}", true);
                        if (value.message != null) {
                          if (value.message.toString() ==
                              "OTP sent successfully to email.") {
                            Get.to(Otp(
                                reg_controller.email.text.toString(),
                                "registration"));
                          }
                        }
                      });
                    }
                    //Get.to(Forgot_Password());
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            offset: const Offset(
                              5.0,
                              5.0,
                            ),
                            blurRadius: 10.0,
                            spreadRadius: 2.0,
                          ), //BoxShadow
                          BoxShadow(
                            color: Colors.white,
                            offset: const Offset(0.0, 0.0),
                            blurRadius: 0.0,
                            spreadRadius: 0.0,
                          ), //
                          // BoxShadow
                        ],
                        color: MyColor.primarycolor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      margin: EdgeInsets.only(top: 8.00, bottom: 8.00),
                      height: 49,
                      width: 289,
                      child: Center(
                        child: Text(
                            "SING UP",
                            style: GoogleFonts.nunitoSans(
                                textStyle:
                                Theme.of(context).textTheme.displayLarge,
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                fontStyle: FontStyle.normal,
                                color: Colors.white)),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.00, bottom: 16.0),
                  child: Bounceable(
                      onTap: () {
                        //   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Signup_Screen()));
                        Get.offAll(Login());
                      },
                      child: Center(child: AppConstant.lgoin_text(context))),
                ),
                SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}