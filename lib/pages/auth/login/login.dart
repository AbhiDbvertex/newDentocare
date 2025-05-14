// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bounceable/flutter_bounceable.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:dentocoreauth/pages/auth/forgot_password/forgot_password.dart';
// import 'package:dentocoreauth/pages/auth/signup/signup.dart';
// import 'package:dentocoreauth/pages/homepage/MyHomePage.dart';
// import 'package:dentocoreauth/utils/app_constant.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// // import 'package:your_project_name/services/google_auth_service.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';
//
// import '../../../FirebaseApi/FirebaseApi.dart';
// import '../../../Utills/Utills.dart';
// import '../../../controllers/login_controller.dart';
// import '../../../controllers/notification_controller.dart';
// import '../../../controllers/profile_controller.dart';
// import '../../../controllers/user_controller.dart';
// import '../../../utils/mycolor.dart';
//
// class Login extends StatefulWidget {
//   const Login({Key? key}) : super(key: key);
//
//   @override
//   State<Login> createState() => _LoginState();
// }
//
// class Guser {
//   Guser(this._name, this._email, this._photo, this._id);
//
//   get name => _name;
//
//   set name(value) {
//     _name = value;
//   }
//   var _name;
//   var _email;
//   var _photo;
//   var _id;
//   get email => _email;
//   set email(value) {
//     _email = value;
//   }
//   get photo => _photo;
//   set photo(value) {
//     _photo = value;
//   }
//
//   get id => _id;
//   set id(value) {
//     _id = value;
//   }
// }
//
// class _LoginState extends State<Login> {
//   var notVerified = true;
//   var util = Utills();
//   var loginData = [];
//   var user_data = [];
//   var isPhoneClicked = false;
//   var isPasswordClicked = false;
//   var userMobile = "";
//   var userPassword = "";
//   var isVisible = false;
//
//   LoginController login_Controller = Get.find();
//   final NotificationController notificationController = Get.find();
//   final UserController userController = Get.find();
//   final ProfileController profileController = Get.find();
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
//   // function to implement the google signin
//
// // creating firebase instance
//   final FirebaseAuth auth = FirebaseAuth.instance;
//   Future signOut() async {
//     return await FirebaseAuth.instance.signOut();
//   }
//   @override
//   void initState() {
//     super.initState();
//
//   }
//   @override
//   void dispose() {
//     super.dispose();
//     login_Controller.dispose();
//   }
//   /*Future<void> signup(BuildContext context) async {
//
//     final GoogleSignIn googleSignIn = GoogleSignIn();
//     await googleSignIn.signOut();
//
//     final GoogleSignInAccount? googleSignInAccount =
//         await googleSignIn.signIn();
//     if (googleSignInAccount != null) {
//       final GoogleSignInAuthentication googleSignInAuthentication =
//           await googleSignInAccount.authentication;
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
//         // util.showSnackBar("Alert", guser.email, true);
//         // util.showSnackBar("Alert", guser.name, true);
//         // util.showSnackBar("Alert", guser.photo, true);
//         debugPrint(
//             "guser" + guser._email + guser._name + guser.photo + guser._id);
//
//         debugPrint("onlyemail" + "${guser._email}");
//         debugPrint("onlynname" + "${guser._name}");
//         await FirebaseApi().initFirebase();
//         login_Controller
//             .loginByGoogle(guser._name, guser._email)
//             .then((value) => {
//                   if (value!.message == "Login successfully." ||
//                       value!.message == "User created successfully.")
//                     {
//                       debugPrint("debuggoogle" + "success"),
//                       util.showSuccessProcess(),
//                       saveUserData("user_data", [
//                         value!.data.id.toString(),
//                         value!.data.name.toString(),
//                         value!.data.email.toString(),
//                         value!.data.mobile.toString(),
//                         value!.data.password.toString(),
//                         value!.data.address.toString(),
//                         value!.data.profile_images.toString(),
//                         value!.data.createdAt.toString(),
//                       ]),
//                       AppConstant.save_data("token", value!.data.id.toString()),
//                       AppConstant.save_data("isFirst", "yes"),
//                       util.showSuccessProcess(),
//                       if (value!.data.id.toString().isNotEmpty)
//                         {
//                           notificationController
//                               .getNotifications(value!.data.id.toString()),
//                           userController
//                               .getAppointmentlist(value!.data.id.toString())
//                               .then(
//                                   (value) => userController.getlist.refresh()),
//                           profileController
//                               .getProfile(value!.data.id.toString())
//                               .then((value) => profileController.image.value =
//                                   value!.body.image),
//                         },
//                       Navigator.pushReplacement(context,
//                           MaterialPageRoute(builder: (context) => MyHomePage()))
//                     }
//                   else
//                     {debugPrint("debuggoogle" + "else")}
//                 });
//
//         //hit api
//         // Navigator.pushReplacement(
//         //     context, MaterialPageRoute(builder: (context) => MyHomePage()));
//       }else{
//         util.stopLoading();
//       } // if result not null we simply call the MaterialpageRoute,
//       // for go to the HomePage screen
//     }
//   }*/
//
//   Future<void> signup(BuildContext context) async {
//     final GoogleSignIn googleSignIn = GoogleSignIn(scopes: ['email']);
//     await googleSignIn.signOut(); // Ensure a fresh sign-in
//
//     try {
//       util.startLoading();
//
//       final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
//       if (googleSignInAccount == null) {
//         debugPrint("Sign-in cancelled by user");
//         return;
//       }
//
//       final GoogleSignInAuthentication googleSignInAuthentication =
//       await googleSignInAccount.authentication;
//       final AuthCredential authCredential = GoogleAuthProvider.credential(
//         idToken: googleSignInAuthentication.idToken,
//         accessToken: googleSignInAuthentication.accessToken,
//       );
//
//       UserCredential result = await auth.signInWithCredential(authCredential);
//       User? user = result.user;
//
//       if (user == null) {
//         util.showSnackBar("Error", "Failed to retrieve user data", false);
//         return;
//       }
//
//       Guser guser = Guser(
//         user.displayName.toString(),
//         user.email.toString(),
//         user.photoURL.toString(),
//         user.uid.toString(),
//       );
//       debugPrint("guser: ${guser._email}, ${guser._name}, ${guser._photo}, ${guser._id}");
//
//       final value = await login_Controller.loginByGoogle(guser._name, guser._email);
//       if (value?.message == "Login successfully." || value?.message == "User created successfully.") {
//         debugPrint("debuggoogle: success");
//
//         saveUserData("user_data", [
//           value!.data.id.toString(),
//           value!.data.name.toString(),
//           value!.data.email.toString(),
//           value!.data.mobile.toString(),
//           value!.data.password.toString(),
//           value!.data.address.toString(),
//           value!.data.profile_images.toString(),
//           value!.data.createdAt.toString(),
//         ]);
//         AppConstant.save_data("token", value!.data.id.toString());
//         AppConstant.save_data("isFirst", "yes");
//
//         if (value!.data.id.toString().isNotEmpty) {
//           notificationController.getNotifications(value!.data.id.toString());
//           await userController.getAppointmentlist(value!.data.id.toString()).then(
//                 (value) => userController.getlist.refresh(),
//           );
//           await profileController.getProfile(value!.data.id.toString()).then(
//                 (value) => profileController.image.value = value!.body.image,
//           );
//         }
//
//         util.showSuccessProcess();
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => MyHomePage()),
//         );
//       } else {
//         debugPrint("debuggoogle: API login failed");
//         util.showSnackBar("Error", "Login failed via API", false);
//       }
//     } catch (e) {
//       debugPrint("Error during sign-in: $e");
//       util.showSnackBar("Error", "An error occurred: $e", false);
//     } finally {
//       util.stopLoading();
//     }
//   }
//
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final GoogleSignIn _googleSignIn = GoogleSignIn();
//   Future<User?> signInWithGoogle() async {
//     try {
//       // Google Sign-In popup
//       final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
//       if (googleUser == null) return null;
//
//       final GoogleSignInAuthentication googleAuth =
//       await googleUser.authentication;
//
//       // Create credential
//       final AuthCredential credential = GoogleAuthProvider.credential(
//         accessToken: googleAuth.accessToken,
//         idToken: googleAuth.idToken,
//       );
//
//       // Sign in with Firebase
//       UserCredential userCredential =
//       await _auth.signInWithCredential(credential);
//
//       return userCredential.user;
//     } catch (e) {
//       debugPrint("Google Sign-In Error: $e");
//       return null;
//     }
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: GestureDetector(
//         onTap: () {
//           FocusManager.instance.primaryFocus?.unfocus();
//           setState(() {
//             isPhoneClicked = false;
//             isPasswordClicked = false;
//           });
//         },
//         behavior: HitTestBehavior.opaque,
//         child: SingleChildScrollView(
//                   child: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: [
//           //logo
//           Container(
//             margin: EdgeInsets.only(top: 40),
//             // height: 260,
//             child: Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Align(
//                     alignment: Alignment.center,
//                     child: InkWell(
//                         onTap: () {
//                           // signup(context);
//                           //Get.to(MyHomePage());
//                         },
//                         child: Image.asset(
//                           'assets/newImages/applogo.png',
//                           height: 200,
//                           width: 200,
//                         )),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           SizedBox(
//             height: AppConstant.APP_NORMAL_PADDING,
//           ),
//           //login head
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 15.0),
//             child: Column(
//               children: [
//                 SizedBox(height: 30,),
//                 Text(AppConstant.LOGIN_HEAD,
//                     style: GoogleFonts.openSans(
//                         textStyle: Theme.of(context).textTheme.displayLarge,
//                         fontSize: 22,
//                         fontWeight: FontWeight.w600,
//                         fontStyle: FontStyle.normal,
//                         color: MyColor.LOGIN_TITLE_COLOR)),
//                 SizedBox(height: 50,),
//                 Align(
//                     alignment: Alignment.centerLeft,
//                     child: Text(AppConstant.LOGIN_EMAIL_TEXT,
//                         style: GoogleFonts.openSans(
//                             textStyle:
//                             Theme.of(context).textTheme.displayLarge,
//                             fontSize: 16,
//                             fontStyle: FontStyle.normal,
//                             color: Colors.grey, ))),
//
//                 SizedBox(
//                   height: AppConstant.MEDIUM_TEXT_SIZE,
//                 ),
//                 Container(
//                   decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(
//                           AppConstant.APP_NORMAL_PADDING),
//                       border: Border.all(color: Colors.grey, width: 1.0)),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Container(
//                           height: 38.00,
//                           child: Center(
//                               child: GestureDetector(
//                                 onTap: () {
//                                   setState(() {
//                                     isPhoneClicked == true;
//                                   });
//                                 },
//                                 behavior: HitTestBehavior.opaque,
//                                 child: TextFormField(
//                                   controller: login_Controller.log_email,
//                                   decoration: InputDecoration.collapsed(
//                                       hintText: "Your email or number",
//                                       hintStyle: TextStyle(
//                                           color:Colors.grey),
//                                       border: InputBorder.none,
//                                       floatingLabelAlignment:
//                                       FloatingLabelAlignment.start),
//                                   keyboardType: TextInputType.emailAddress,
//                                   autovalidateMode: AutovalidateMode.disabled,
//                                   onTap: () {
//                                     setState(() {
//                                       isPhoneClicked = true;
//                                       isPasswordClicked = false;
//                                     });
//                                   },
//                                   onChanged: (phone) {},
//                                   textAlignVertical: TextAlignVertical.center,
//                                 ),
//                               )),
//                         ),
//                       ),
//                       // Visibility(
//                       //   visible: isPhoneClicked == true ? true : false,
//                       //   child: SizedBox(
//                       //     width: double.infinity,
//                       //     height: 2,
//                       //     child: Container(
//                       //       color: const Color(0xFF54E28D),
//                       //     ),
//                       //   ),
//                       // )
//                     ],
//                   ),
//                 ),
//
//                 SizedBox(
//                   height: AppConstant.LARGE_SIZE,
//                 ),
//
//                 Align(
//                     alignment: Alignment.centerLeft,
//                     child: Text(AppConstant.LOGIN_HEAD_TEXT_PASSWORD,
//                         style: GoogleFonts.openSans(
//                           textStyle:
//                           Theme.of(context).textTheme.displayLarge,
//                           fontSize: 16,
//
//                           fontStyle: FontStyle.normal,
//                           color:Colors.grey,
//                         ))),
//
//                 SizedBox(
//                   height:10,
//                 ),
//                 //password
//                 Container(
//                   decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(
//                           AppConstant.APP_NORMAL_PADDING),
//                       border: Border.all(color: Colors.grey, width: 1.0)),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       Container(
//                         height: 48,
//                         child: Center(
//                             child: TextFormField(
//                               onTap: () {
//                                 setState(() {
//                                   isPasswordClicked = true;
//                                   isPhoneClicked = false;
//                                 });
//                               },
//                               controller: login_Controller.log_password,
//                               decoration: InputDecoration(
//                                   border: InputBorder.none,
//                                   hintText: "  Password",
//                                   hintStyle: TextStyle(
//                                       color: MyColor
//                                           .LOGIN_TEXT_HINT_PASSWORD_COLOR),
//                                   contentPadding: EdgeInsets.only(left: 10.0,top: 12),
//                                   suffixIcon: IconButton(
//                                     onPressed: () {
//                                       setState(() {
//                                         isVisible = !isVisible;
//                                       });
//                                     },
//                                     icon: Icon(isVisible
//                                         ? Icons.remove_red_eye
//                                         : Icons.remove_red_eye),
//                                     color: isVisible
//                                         ? Colors.grey
//                                         : Colors.grey,
//                                   )),
//                               keyboardType: TextInputType.visiblePassword,
//                               obscureText: isVisible ? true : false,
//                             )),
//                       ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 Align(
//                   alignment: Alignment.centerRight,
//                   child: Bounceable(
//                     onTap: () {
//                       Get.to(ForgotPassword());
//                     },
//                     child: Container(
//                       child: Text(AppConstant.FORGOT_PW,
//                           style: GoogleFonts.nunitoSans(
//                               textStyle: Theme.of(context)
//                                   .textTheme
//                                   .displayLarge,
//                               fontSize: AppConstant.EXTRA_MEDIUM_SIZE,
//                               fontStyle: FontStyle.normal,
//                               color: Color(0xFF8E8E8E))),
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 50,
//                 ),
//
//                 //login normal
//                 Flex(direction: Axis.vertical, children: [
//                   Padding(
//                     padding: EdgeInsets.only(
//                         left: AppConstant.LARGE_SIZE,
//                         right: AppConstant.LARGE_SIZE,
//                         bottom: AppConstant.SMALL_TEXT_SIZE),
//                     child: Bounceable(
//                       onTap: () {
//                         // if (EasyLoading.isShow == true) {
//                         //   return;
//                         // }
//                         var result = login_Controller.login().then((value) => {
//                           AppConstant.user_id = value!.data.id.toString(),
//                           util.showSnackBar(
//                             "Alert",
//                             value!.message.toString(),
//                             true,
//                           ),
//                           saveUserData("user_data", [
//                             value!.data.id.toString(),
//                             value!.data.name.toString(),
//                             value!.data.email.toString(),
//                             value!.data.mobile.toString(),
//                             value!.data.password.toString(),
//                             value!.data.address.toString(),
//                             value!.data.image.toString()
//                           ]),
//                           AppConstant.save_data(
//                               "token", value!.data.id.toString()),
//                           AppConstant.save_data("isFirst", "yes"),
//                           if (value!.data.id.toString().isNotEmpty)
//                             {
//                               notificationController.getNotifications(
//                                   value!.data.id.toString()),
//                               userController
//                                   .getAppointmentlist(
//                                   value!.data.id.toString())
//                                   .then((value) =>
//                                   userController.getlist.refresh()),
//                               profileController
//                                   .getProfile(value!.data.id.toString())
//                                   .then((value) => profileController
//                                   .image.value = value!.body.image),
//                             },
//                           Navigator.pushReplacement(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) => MyHomePage()))
//                         });
//                       },
//                       child: Container(
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
//                           color: Colors.blue,
//                           // gradient: AppConstant.BUTTON_COLOR,
//                           borderRadius: BorderRadius.circular(20),
//                         ),
//                         width: AppConstant.BUTTON_WIDTH,
//                         height: AppConstant.BUTTON_HIGHT,
//                         child: Center(
//                           child: Text(AppConstant.LOGIN_HEAD,
//                               style: GoogleFonts.nunitoSans(
//                                   textStyle:
//                                   Theme.of(context).textTheme.displayLarge,
//                                   fontSize: AppConstant.MEDIUM_SIZE,
//                                   fontWeight: FontWeight.w700,
//                                   fontStyle: FontStyle.normal,
//                                   color: Colors.white)),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ]),SizedBox(
//                   height: 12,),
//
//                 //login google
//                 Visibility(
//                   visible: true,
//                   child: Padding(
//                     padding: EdgeInsets.only(
//                         left: AppConstant.LARGE_SIZE,
//                         right: AppConstant.LARGE_SIZE,
//                         bottom: AppConstant.SMALL_TEXT_SIZE),
//                     child: Bounceable(
//                       onTap: () {
//                         if (EasyLoading.isShow == true) {
//                           return;
//                         }
//                         var result = login_Controller.login();
//                         signup(context);
//                       },
//                       /*onTap: () async {
//                         User? user = await GoogleAuthService().signInWithGoogle();
//                         if (user != null) {
//                           debugPrint("User Signed In: ${user.displayName}, ${user.email}");
//                           // Navigate to home screen
//                         } else {
//                           debugPrint("Sign-In Failed");
//                         }
//                       },*/
//                       child: Card(
//                         margin: const EdgeInsets.all(0.00),
//                         shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(20)),
//                         elevation: 1,
//                         child: Container(
//                           decoration: BoxDecoration(
//                             boxShadow:  [
//                               BoxShadow(
//                                 color: Colors.grey,
//                                 offset: const Offset(
//                                   5.0,
//                                   5.0,
//                                 ),
//                                 blurRadius: 10.0,
//                                 spreadRadius: 2.0,
//                               ), //BoxShadow
//                               BoxShadow(
//                                 color: Colors.white,
//                                 offset: const Offset(0.0, 0.0),
//                                 blurRadius: 0.0,
//                                 spreadRadius: 0.0,
//                               ), //
//                               // BoxShadow
//                             ],
//                             borderRadius: BorderRadius.circular(20),
//                           ),
//                           width: AppConstant.BUTTON_WIDTH,
//                           height: AppConstant.BUTTON_HIGHT,
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Center(
//                                   child: Container(
//                                     width: 30,
//                                     height: 30,
//                                     decoration: BoxDecoration(
//                                         borderRadius: BorderRadius.circular(100),
//                                         color: Colors.red,
//                                         gradient: LinearGradient(
//                                             begin: Alignment.topCenter,
//                                             end: Alignment.bottomCenter,
//                                             colors: [
//                                               Color.fromRGBO(151, 231, 249, 1),
//                                               Color.fromRGBO(151, 135, 210, 1)
//                                             ])),
//                                     child: Image.asset(
//                                       "assets/images/google.png",
//                                       scale: 1,
//                                     ),
//                                   )),
//                               SizedBox(
//                                 width: 10,
//                               ),
//                               Center(
//                                 child: Text("Sign in with Google",
//                                     style: GoogleFonts.nunitoSans(
//                                       textStyle: Theme.of(context)
//                                           .textTheme
//                                           .displayLarge,
//                                       fontSize: AppConstant.MEDIUM_SIZE,
//                                       fontWeight: FontWeight.w700,
//                                       fontStyle: FontStyle.normal,
//                                       color: Color.fromRGBO(0, 149, 173, 1),
//                                     )),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//
//                 //go to signup
//                 Bounceable(
//                     onTap: () {
//                       //   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Signup_Screen()));
//                       Get.offAll(const Signup());
//                     },
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text("Don't have an account?",
//                             style: GoogleFonts.nunitoSans(
//                                 textStyle:
//                                 Theme.of(context!).textTheme.displayLarge,
//                                 fontSize: AppConstant.SMALL_SIZE,
//                                 fontWeight: FontWeight.w700,
//                                 fontStyle: FontStyle.normal,
//                                 color: MyColor.LOGIN_TEXT_HAVE_AC_COLOR)),
//                         Text(" Sign up",
//                             style: GoogleFonts.nunitoSans(
//                                 textStyle:
//                                 Theme.of(context).textTheme.displayLarge,
//                                 fontSize: AppConstant.SMALL_SIZE,
//                                 fontWeight: FontWeight.w700,
//                                 fontStyle: FontStyle.normal,
//                                 color: MyColor.LOGIN_TEXT_SIGNUP_COLOR))
//                       ],
//                     )),
//                 SizedBox(
//                   height: 30,
//                 )
//               ],
//             ),
//           ),
//         ],
//                   ),
//                 ),
//       ),
//     );
//   }
// }
// class BackButtonArrow extends StatelessWidget implements PreferredSizeWidget {
//   final bool backFunction;
//   final String? hint;
//
//   const BackButtonArrow({Key? key, this.backFunction = false, this.hint}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return AppBar(
//       automaticallyImplyLeading: false,
//       title: Text(hint ?? "", style: TextStyle(color: Colors.white)), // ✅ Null check
//       centerTitle: true,
//       // backgroundColor: MyColor.primarycolor,
//       leading: backFunction
//           ? Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: GestureDetector(
//           onTap: () => Navigator.pop(context),
//           child: Container(
//             decoration: BoxDecoration(
//               color: MyColor.primarycolor,
//               borderRadius: BorderRadius.circular(12),
//             ),
//             child: Padding(
//               padding: const EdgeInsets.only(left: 8.0),
//               child: Icon(Icons.arrow_back_ios, color: Colors.white),
//             ),
//           ),
//         ),
//       )
//           : SizedBox(),
//     );
//   }
//
//   @override
//   Size get preferredSize => Size.fromHeight(kToolbarHeight); // ✅ Required for AppBar
// }
//
//
// class GoogleAuthService {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final GoogleSignIn _googleSignIn = GoogleSignIn();
//
//   Future<User?> signInWithGoogle() async {
//     try {
//       final GoogleSignInAccount? googleUser = await _googleSignIn.signIn().catchError((error) {
//         debugPrint("Google Sign-In Error: $error");
//         return null;
//       });
//
//       if (googleUser == null) return null; // User cancelled login
//
//       final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
//
//       final AuthCredential credential = GoogleAuthProvider.credential(
//         accessToken: googleAuth.accessToken,
//         idToken: googleAuth.idToken,
//       );
//
//       UserCredential userCredential = await _auth.signInWithCredential(credential);
//
//       if (userCredential.user == null) {
//         debugPrint("Firebase User is Null");
//         return null;
//       }
//
//       debugPrint("User Signed In: ${userCredential.user?.displayName}, ${userCredential.user?.email}");
//       return userCredential.user;
//     } catch (e) {
//       debugPrint("Google Sign-In Error: $e");
//       return null;
//     }
//   }
//
//   Future<void> signOut() async {
//     await _googleSignIn.signOut();
//     await _auth.signOut();
//     debugPrint("User Signed Out");
//   }
// }
//

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:dentocoreauth/pages/auth/forgot_password/forgot_password.dart';
import 'package:dentocoreauth/pages/auth/signup/signup.dart';
import 'package:dentocoreauth/pages/homepage/MyHomePage.dart';
import 'package:dentocoreauth/utils/app_constant.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../FirebaseApi/FirebaseApi.dart';
import '../../../Utills/Utills.dart';
import '../../../controllers/login_controller.dart';
import '../../../controllers/notification_controller.dart';
import '../../../controllers/profile_controller.dart';
import '../../../controllers/user_controller.dart';
import '../../../utils/mycolor.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class Guser {
  Guser(this._name, this._email, this._photo, this._id);

  get name => _name;
  set name(value) {
    _name = value;
  }
  var _name;
  var _email;
  var _photo;
  var _id;
  get email => _email;
  set email(value) {
    _email = value;
  }
  get photo => _photo;
  set photo(value) {
    _photo = value;
  }
  get id => _id;
  set id(value) {
    _id = value;
  }
}

class _LoginState extends State<Login> {
  var notVerified = true;
  var util = Utills();
  var loginData = [];
  var user_data = [];
  var isPhoneClicked = false;
  var isPasswordClicked = false;
  var userMobile = "";
  var userPassword = "";
  var isVisible = true;

  LoginController login_Controller = Get.find();
  final NotificationController notificationController = Get.find();
  final UserController userController = Get.find();
  final ProfileController profileController = Get.find();

  final FirebaseAuth auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

  void saveUserData(key, value) async {
    final sp = await SharedPreferences.getInstance();
    setState(() {
      sp.setStringList(key, value);
      if (key == "user_data") {
        print("loginitlogin${"datasaved"}");
      } else if (key == "temp") {
        print("loginit${"datasavedtemp"}");
      }
    });
  }

  Future signOut() async {
    await _googleSignIn.signOut();
    return await FirebaseAuth.instance.signOut();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    login_Controller.dispose();
    login_Controller.log_email.clear();
    login_Controller.log_password.clear();
  }
  Future<void> signup(BuildContext context) async {
    try {
      util.startLoading();
      debugPrint("Starting Google Sign-In");
      await _googleSignIn.signOut();

      final GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
      if (googleSignInAccount == null) {
        debugPrint("Sign-in cancelled by user");
        return;
      }
      debugPrint("Google Sign-In successful: ${googleSignInAccount.email}");

      final GoogleSignInAuthentication googleAuth = await googleSignInAccount.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
        accessToken: googleAuth.accessToken,
      );

      UserCredential result = await auth.signInWithCredential(credential);
      User? user = result.user;
      if (user == null) {
        debugPrint("Firebase auth failed: No user returned");
        util.showSnackBar("Error", "Failed to sign in with Google", false);
        return;
      }
      debugPrint("Firebase auth successful: ${user.email}");

      Guser guser = Guser(
        user.displayName.toString(),
        user.email.toString(),
        user.photoURL.toString(),
        user.uid.toString(),
      );
      debugPrint("Guser created: name=${guser._name}, email=${guser._email}");

      await FirebaseApi().initFirebase();
      debugPrint("Calling loginByGoogle with name=${guser._name}, email=${guser._email}");
      final value = await login_Controller.loginByGoogle(guser._name, guser._email);
      debugPrint("loginByGoogle returned: ${value.toString()}");

      if (value?.message == "Login successfully." || value?.message == "User created successfully.") {
        debugPrint("API login successful");
        saveUserData("user_data", [
          value!.data.id.toString(),
          value!.data.name.toString(),
          value!.data.email.toString(),
          value!.data.mobile.toString(),
          value!.data.password.toString(),
          value!.data.address.toString(),
          value!.data.profile_images.toString(),
          value!.data.createdAt.toString(),
        ]);
        AppConstant.save_data("token", value!.data.id.toString());
        AppConstant.save_data("isFirst", "yes");

        if (value!.data.id.toString().isNotEmpty) {
          notificationController.getNotifications(value!.data.id.toString());
          await userController.getAppointmentlist(value!.data.id.toString());
          await profileController.getProfile(value!.data.id.toString()).then((value) {
            String? imageUrl = value!.body.image;
            profileController.image.value = (imageUrl != null && imageUrl.isNotEmpty)
                ? imageUrl
                : "https://via.placeholder.com/150";
          });
        }

        util.showSuccessProcess();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MyHomePage()),
        );
      } else {
        debugPrint("API login failed: ${value?.message}");
        util.showSnackBar("Error", "API login failed", false);
      }
    } catch (e) {
      debugPrint("Google Sign-In Error: $e");
      util.showSnackBar("Error", "Sign-in failed: $e", false);
    } finally {
      util.stopLoading();
    }
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return null;

      final GoogleSignInAuthentication googleAuth =
      await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential =
      await _auth.signInWithCredential(credential);

      return userCredential.user;
    } catch (e) {
      debugPrint("Google Sign-In Error: $e");
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
          setState(() {
            isPhoneClicked = false;
            isPasswordClicked = false;
          });
        },
        behavior: HitTestBehavior.opaque,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                margin: EdgeInsets.only(top: 40),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: InkWell(
                          onTap: () {},
                          child: Container(
                            // color: Colors.blue,
                            child: Image.asset(
                              'assets/newImages/applogo.png',
                              height: 200,
                              width: 300,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: AppConstant.APP_NORMAL_PADDING,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Column(
                  children: [
                    SizedBox(height: 30),
                    Text(AppConstant.LOGIN_HEAD,
                        style: GoogleFonts.openSans(
                            textStyle: Theme.of(context).textTheme.displayLarge,
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                            fontStyle: FontStyle.normal,
                            color: MyColor.LOGIN_TITLE_COLOR)),
                    SizedBox(height: 50),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text(AppConstant.LOGIN_EMAIL_TEXT,
                            style: GoogleFonts.openSans(
                                textStyle:
                                Theme.of(context).textTheme.displayLarge,
                                fontSize: 16,
                                fontStyle: FontStyle.normal,
                                color: Colors.grey))),
                    SizedBox(
                      height: AppConstant.MEDIUM_TEXT_SIZE,
                    ),
                    // Column(
                    //   crossAxisAlignment: CrossAxisAlignment.start,
                    //   children: [
                    //     Container(
                    //       child: Text(),
                    //     )
                    //   ],
                    // ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                              AppConstant.APP_NORMAL_PADDING),
                          border: Border.all(color: Colors.grey, width: 1.0)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 38.00,
                              child: Center(
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        isPhoneClicked = true;
                                      });
                                    },
                                    behavior: HitTestBehavior.opaque,

                                    child: TextFormField(
                                      controller: login_Controller.log_email,
                                      decoration: InputDecoration.collapsed(
                                          hintText: "Your email or number",
                                          hintStyle: TextStyle(color: Colors.grey),
                                          border: InputBorder.none,
                                          floatingLabelAlignment:
                                          FloatingLabelAlignment.start),
                                      keyboardType: TextInputType.emailAddress,
                                      autovalidateMode: AutovalidateMode.disabled,
                                      onTap: () {
                                        setState(() {
                                          isPhoneClicked = true;
                                          isPasswordClicked = false;
                                        });
                                      },
                                      onChanged: (phone) {},
                                      textAlignVertical: TextAlignVertical.center,
                                    ),
                                  )),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: AppConstant.LARGE_SIZE,
                    ),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text(AppConstant.LOGIN_HEAD_TEXT_PASSWORD,
                            style: GoogleFonts.openSans(
                              textStyle: Theme.of(context).textTheme.displayLarge,
                              fontSize: 16,
                              fontStyle: FontStyle.normal,
                              color: Colors.grey,
                            ))),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                              AppConstant.APP_NORMAL_PADDING),
                          border: Border.all(color: Colors.grey, width: 1.0)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            height: 48,
                            child: Center(
                                child: TextFormField(
                                  onTap: () {
                                    setState(() {
                                      isPasswordClicked = true;
                                      isPhoneClicked = false;
                                    });
                                  },
                                  controller: login_Controller.log_password,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "  Password",
                                      hintStyle: TextStyle(
                                          color: MyColor
                                              .LOGIN_TEXT_HINT_PASSWORD_COLOR),
                                      contentPadding:
                                      EdgeInsets.only(left: 10.0, top: 12),
                                      suffixIcon: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            isVisible = !isVisible;
                                          });
                                        },
                                        icon: Icon(isVisible
                                            ? Icons.visibility_off
                                            : Icons.remove_red_eye),
                                        color:
                                        isVisible ? Colors.grey : Colors.grey,
                                      )),
                                  keyboardType: TextInputType.visiblePassword,
                                  obscureText: isVisible ? true : false,
                                )),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Bounceable(
                        onTap: () {
                          Get.to(ForgotPassword());
                        },
                        child: Container(
                          child: Text(AppConstant.FORGOT_PW,
                              style: GoogleFonts.nunitoSans(
                                  textStyle:
                                  Theme.of(context).textTheme.displayLarge,
                                  fontSize: AppConstant.EXTRA_MEDIUM_SIZE,
                                  fontStyle: FontStyle.normal,
                                  color: Color(0xFF8E8E8E))),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Flex(direction: Axis.vertical, children: [
                      Padding(
                        padding: EdgeInsets.only(
                            left: AppConstant.LARGE_SIZE,
                            right: AppConstant.LARGE_SIZE,
                            bottom: AppConstant.SMALL_TEXT_SIZE),
                        child: Bounceable(
                          onTap: () {
                            var result = login_Controller.login().then((value) => {
                              AppConstant.user_id = value!.data.id.toString(),
                              util.showSnackBar(
                                "Alert",
                                value!.message.toString(),
                                true,
                              ),
                              saveUserData("user_data", [
                                value!.data.id.toString(),
                                value!.data.name.toString(),
                                value!.data.email.toString(),
                                value!.data.mobile.toString(),
                                value!.data.password.toString(),
                                value!.data.address.toString(),
                                value!.data.image.toString()
                              ]),
                              AppConstant.save_data(
                                  "token", value!.data.id.toString()),
                              AppConstant.save_data("isFirst", "yes"),
                              if (value!.data.id.toString().isNotEmpty)
                                {
                                  notificationController.getNotifications(
                                      value!.data.id.toString()),
                                  userController
                                      .getAppointmentlist(
                                      value!.data.id.toString())
                                      .then((value) => userController
                                      .getlist
                                      .refresh()),
                                  profileController
                                      .getProfile(value!.data.id.toString())
                                      .then((value) => profileController
                                      .image.value = value!.body.image),
                                },
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MyHomePage()))
                            });
                          },
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
                                ),
                                BoxShadow(
                                  color: Colors.white,
                                  offset: const Offset(0.0, 0.0),
                                  blurRadius: 0.0,
                                  spreadRadius: 0.0,
                                ),
                              ],
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            width: AppConstant.BUTTON_WIDTH,
                            height: AppConstant.BUTTON_HIGHT,
                            child: Center(
                              child: Text(AppConstant.LOGIN_HEAD,
                                  style: GoogleFonts.nunitoSans(
                                      textStyle: Theme.of(context)
                                          .textTheme
                                          .displayLarge,
                                      fontSize: AppConstant.MEDIUM_SIZE,
                                      fontWeight: FontWeight.w700,
                                      fontStyle: FontStyle.normal,
                                      color: Colors.white)),
                            ),
                          ),
                        ),
                      ),
                    ]),
                    SizedBox(
                      height: 12,
                    ),
                    Visibility(
                      visible: true,
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: AppConstant.LARGE_SIZE,
                            right: AppConstant.LARGE_SIZE,
                            bottom: AppConstant.SMALL_TEXT_SIZE),
                        child: Bounceable(
                          onTap: () {
                            if (EasyLoading.isShow == true) {
                              return;
                            }
                            signup(context);
                          },
                          child: Card(
                            margin: const EdgeInsets.all(0.00),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            elevation: 1,
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
                              width: AppConstant.BUTTON_WIDTH,
                              height: AppConstant.BUTTON_HIGHT,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Center(
                                      child: Container(
                                        width: 30,
                                        height: 30,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                            BorderRadius.circular(100),
                                            color: Colors.white,
                                            // gradient: LinearGradient(
                                            //     begin: Alignment.topCenter,
                                            //     end: Alignment.bottomCenter,
                                            //     colors: [
                                            //       Color.fromRGBO(151, 231, 249, 1),
                                            //       Color.fromRGBO(151, 135, 210, 1)
                                            //     ])
                                        ),
                                        child: Image.asset(
                                          "assets/images/google.png",height: 2,
                                          // scale: ,
                                        ),
                                      )),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Center(
                                    child: Text("Sign in with Google",
                                        style: GoogleFonts.nunitoSans(
                                          textStyle: Theme.of(context)
                                              .textTheme
                                              .displayLarge,
                                          fontSize: AppConstant.MEDIUM_SIZE,
                                          fontWeight: FontWeight.w700,
                                          fontStyle: FontStyle.normal,
                                          color:
                                          Color.fromRGBO(0, 149, 173, 1),
                                        )),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),SizedBox(
                      height: 10,
                    ),
                    Bounceable(
                        onTap: () {
                          Get.offAll(const Signup());
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Don't have an account?",
                                style: GoogleFonts.nunitoSans(
                                    textStyle:
                                    Theme.of(context).textTheme.displayLarge,
                                    fontSize: AppConstant.SMALL_SIZE,
                                    fontWeight: FontWeight.w700,
                                    fontStyle: FontStyle.normal,
                                    color: MyColor.LOGIN_TEXT_HAVE_AC_COLOR)),
                            Text(" Sign up",
                                style: GoogleFonts.nunitoSans(
                                    textStyle:
                                    Theme.of(context).textTheme.displayLarge,
                                    fontSize: AppConstant.SMALL_SIZE,
                                    fontWeight: FontWeight.w700,
                                    fontStyle: FontStyle.normal,
                                    color: MyColor.LOGIN_TEXT_SIGNUP_COLOR))
                          ],
                        )),
                    SizedBox(
                      height: 30,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BackButtonArrow extends StatelessWidget implements PreferredSizeWidget {
  final bool backFunction;
  final String? hint;

  const BackButtonArrow({Key? key, this.backFunction = false, this.hint})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Text(hint ?? "", style: TextStyle(color: Colors.white)),
      centerTitle: true,
      leading: backFunction
          ? Padding(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            decoration: BoxDecoration(
              color: MyColor.primarycolor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Icon(Icons.arrow_back_ios, color: Colors.white),
            ),
          ),
        ),
      )
          : SizedBox(),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class GoogleAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser =
      await _googleSignIn.signIn().catchError((error) {
        debugPrint("Google Sign-In Error: $error");
        return null;
      });

      if (googleUser == null) return null;

      final GoogleSignInAuthentication googleAuth =
      await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential =
      await _auth.signInWithCredential(credential);

      if (userCredential.user == null) {
        debugPrint("Firebase User is Null");
        return null;
      }

      debugPrint(
          "User Signed In: ${userCredential.user?.displayName}, ${userCredential.user?.email}");
      return userCredential.user;
    } catch (e) {
      debugPrint("Google Sign-In Error: $e");
      return null;
    }
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
    debugPrint("User Signed Out");
  }
}