// import 'dart:convert';
// import 'dart:io';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:double_back_to_close_app/double_back_to_close_app.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:flutter_phoenix/flutter_phoenix.dart';
// import 'package:http/http.dart' as http;
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bounceable/flutter_bounceable.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';
//
// import 'package:path_provider/path_provider.dart';
// import 'package:dentocoreauth/pages/about/about.dart';
// import 'package:dentocoreauth/pages/contact_us/contact_us.dart';
// import 'package:dentocoreauth/pages/payment/payment.dart';
// import 'package:dentocoreauth/pages/payment_history/payment_history.dart';
// import 'package:dentocoreauth/pages/profile/profile.dart';
// import 'package:dentocoreauth/pages/razorpay/ApiServices.dart';
// import 'package:dentocoreauth/utils/app_constant.dart';
// import 'package:dentocoreauth/utils/mycolor.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:url_launcher/url_launcher.dart';
// import '../../Utills/Utills.dart';
// import '../../controllers/notification_controller.dart';
// import '../../controllers/profile_controller.dart';
// import '../../controllers/user_controller.dart';
// import '../../models/normalDTO.dart';
// import '../Services/Services.dart';
// import '../auth/login/login.dart';
// import '../change_pasword/change_password.dart';
// import 'package:http_parser/http_parser.dart';
//
// import 'package:restart_app/restart_app.dart';
//
// class
// Setting extends StatefulWidget {
//   var from = "";
//
//   Setting(String _from) {
//     this.from = _from;
//   }
//   @override
//   State<Setting> createState() => _SettingsState(from);
// }
// class _SettingsState extends State<Setting> {
//   var from = "";
//   _SettingsState(String _from) {
//     this.from = _from;
//   }
//   final ProfileController profile_controller = Get.find();
//   final NotificationController notificationController = Get.find();
//   final UserController userController = Get.find();
//
//   late UserClass myuser;
//   var islogin = false;
//   var util = Utills();
//   var uimage = "";
//   var mylist = [
//     "My Profile",
//     "Change Password",
//     "T&C",
//     "Privacy Policy",
//     "About US",
//     "Payment History",
//     "Logout"
//   ];
//
//   File? fimage1;
//   ImagePicker picker = ImagePicker();
//   var user_data = [];
//   var load_status = true;
//   var userid = "";
//   var user_name = "";
//   var user_mail = "";
//   var user_phone = "";
//
//   void asklogout() {
//     showDialog<String>(
//       context: context,
//       builder: (BuildContext context) => AlertDialog(
//         title: const Text('Logout'),
//         content: const Text('Do you really want to Logout!'),
//         actions: <Widget>[
//           TextButton(
//             onPressed: () => Navigator.pop(context, 'Cancel'),
//             child: const Text('Cancel'),
//           ),
//           TextButton(
//             onPressed: () => {
//               logoutApi(),
//               Navigator.pop(context, 'OK'),
//             },
//             child: const Text('OK'),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Dialog changePassDialog(BuildContext context) {
//     return Dialog(
//         shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(12.0)), //this right here
//         child: Container(
//           height: 200.0,
//           width: 200.0,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: <Widget>[
//               Padding(
//                 padding: EdgeInsets.all(12.0),
//                 child: Text(
//                   'Change Password',
//                   style: TextStyle(
//                       color: Colors.black,
//                       fontWeight: FontWeight.w700,
//                       fontSize: 18),
//                 ),
//               ),
//               Padding(
//                 padding: EdgeInsets.all(12.0),
//                 child: Center(
//                   child: Text(
//                     'Do you really want to change password?',
//                     style: TextStyle(color: Colors.black, fontSize: 14),
//                   ),
//                 ),
//               ),
//               Padding(padding: EdgeInsets.only(top: 20.0)),
//               TextButton(
//                   onPressed: () {
//                     Navigator.of(context).pop();
//                   },
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       MaterialButton(
//                         onPressed: () {
//                           Navigator.of(context).pop();
//                           gotoChangePassword();
//                         },
//                         child: Text("Ok"),
//                         color: Colors.blue,
//                       ),
//                       SizedBox(
//                         width: 10,
//                       ),
//                       MaterialButton(
//                         onPressed: () {
//                           Get.back();
//                         },
//                         child: Text("Cancel"),
//                         color: Colors.blue,
//                       ),
//                     ],
//                   ))
//             ],
//           ),
//         ));
//   }
//
//   void askChangePassword() {
//     showDialog<String>(
//       context: context,
//       builder: (BuildContext context) => AlertDialog(
//         title: const Text('Logout'),
//         content: const Text('Do you really want to change password?'),
//         actions: <Widget>[
//           TextButton(
//             onPressed: () => Navigator.pop(context, 'Cancel'),
//             child: const Text('Cancel'),
//           ),
//           TextButton(
//             onPressed: () => {
//               Navigator.pop(context, 'OK'),
//               gotoChangePassword(),
//             },
//             child: const Text('OK'),
//           ),
//         ],
//       ),
//     );
//   }
//
//
//
//   Future<void> _deleteCacheDir() async {
//     final cacheDir = await getTemporaryDirectory();
//
//     if (cacheDir.existsSync()) {
//       cacheDir.deleteSync(recursive: true);
//     }
//   }
//
//   void logout() async {
//     var sp = await SharedPreferences.getInstance();
//     // await DefaultCacheManager().emptyCache();
//
//     // var appDir = (await getTemporaryDirectory()).path +
//     //     '/com.dbvertex.pearllinedentocare';
//     // new Directory(appDir).delete(recursive: true);
//     sp.remove("user_data").then((value) => {
//           if (value == true)
//             {
//               util.showSnackBar("Alert", "logout successfully", true),
//               AppConstant.save_data("token", ""),
//               AppConstant.save_data("isFirst", "no"),
//               //AppConstant.removeData("fcm"),
//               //  Restart.restartApp(),
//               //   _deleteCacheDir(),
//               Phoenix.rebirth(context),
//               Navigator.pushReplacement(
//                   context, MaterialPageRoute(builder: (context) => Login()))
//             }
//           else
//             {
//               util.showSnackBar("Alert", "Something went wrong!", false),
//             }
//         });
//   }
//
//   gotoChangePassword() {
//     Get.to(ChangePassword(false, userid),
//         duration: Duration(seconds: 1), transition: Transition.leftToRight);
//   }
//
//   logoutApi() async {
//     util.startLoading();
//     var res = await http.get(
//         Uri.parse(
//             AppConstant.BASE_URL + AppConstant.LOGOUT_ENDPOINT + "${userid}"),
//         headers: <String, String>{"x-api-key": "dentist@123"});
//     if (res.statusCode == 200 || res.statusCode == 201) {
//       util.showFailProcess();
//       var temp = jsonDecode(res.body);
//       logout();
//     } else {
//       util.showFailProcess();
//       util.showSnackBar("Alert", "Something went wrong!", false);
//     }
//   }
//
//   void getUserData(key) async {
//     final sp = await SharedPreferences.getInstance();
//     setState(() {
//       user_data = sp.getStringList(key)?? [];
//
//      // util.showSnackBar("userid", user_data[0].toString(), true);
//       debugPrint("userdata" + user_data.toString());
//
//       myuser= UserClass(
//           userid,user_name,user_mail,user_phone
//       );
//       userid = user_data[0].toString();
//       user_name = user_data[1].toString();
//       user_mail = user_data[2].toString();
//       user_phone = user_data[3].toString();
//
//       if (userid.isNotEmpty) {
//         var res = profile_controller.getProfile(userid);
//         EasyLoading.show(status: "Loading..");
//         res.then((value) {
//           EasyLoading.dismiss();
//           setState(() {
//             uimage = value!.body.image.toString() ?? "";
//             debugPrint("testnj-${uimage}");
//             profile_controller.image.value = value.body.image.toString();
//           });
//         });
//         print("islogintrue");
//         islogin = true;
//         mylist = mylist = [
//           "My Profile",
//           "Change Password",
//           "T&C",
//           "Privacy Policy",
//           "About US",
//           "Payment History",
//           "Logout"
//         ];
//       } else {
//         print("isloginfalse");
//         islogin = false;
//       }
//     });
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//
//     if (EasyLoading.isShow) {
//       EasyLoading.dismiss();
//     }
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     getUserData("user_data");
//     if (userid.isEmpty) {
//       mylist.removeRange(0, 2);
//       mylist.removeLast();
//       mylist.removeLast();
//     } else {}
//     load_status = false;
//     Future.delayed(Duration(milliseconds: 100), () {
//       setState(() {
//         load_status = true;
//       });
//     });
//   }
//
//   Dialog errorDialog(BuildContext context) {
//     return Dialog(
//         shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(12.0)), //this right here
//         child: Container(
//           height: 200.0,
//           width: 200.0,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               Padding(
//                 padding: EdgeInsets.all(12.0),
//                 child: Text(
//                   'Logout',
//                   style: TextStyle(
//                       color: Colors.red,
//                       fontWeight: FontWeight.w700,
//                       fontSize: 18),
//                 ),
//               ),
//               Padding(
//                 padding: EdgeInsets.all(12.0),
//                 child: Text(
//                   'Do you really want to Logout?',
//                   style: TextStyle(color: Colors.red, fontSize: 14),
//                 ),
//               ),
//               Padding(padding: EdgeInsets.only(top: 20.0)),
//               TextButton(
//                   onPressed: () {
//                     Navigator.of(context).pop();
//                   },
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       MaterialButton(
//                         onPressed: () {
//                           logout();
//                         },
//                         child: Text("Ok"),
//                         color: Colors.blue,
//                       ),
//                       SizedBox(
//                         width: 10,
//                       ),
//                       MaterialButton(
//                         onPressed: () {
//                           Get.back();
//                         },
//                         child: Text("Cancel"),
//                         color: Colors.blue,
//                       ),
//                     ],
//                   ))
//             ],
//           ),
//         ));
//   }
//
//   Dialog askDialog(BuildContext context) {
//     return Dialog(
//         shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(12.0)), //this right here
//         child: Container(
//           height: 200.0,
//           width: 200.0,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               Padding(
//                 padding: EdgeInsets.all(12.0),
//                 child: Text(
//                   'Select',
//                   style: TextStyle(
//                       color: Colors.red,
//                       fontWeight: FontWeight.w700,
//                       fontSize: 18),
//                 ),
//               ),
//               Padding(
//                 padding: EdgeInsets.all(12.0),
//                 child: Text(
//                   'Please select image from:',
//                   style: TextStyle(color: Colors.red, fontSize: 14),
//                 ),
//               ),
//               Padding(padding: EdgeInsets.only(top: 20.0)),
//               TextButton(
//                   onPressed: () {
//                     Navigator.of(context).pop();
//                   },
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       MaterialButton(
//                         onPressed: () {
//                           Get.back();
//                           getImage(ImageSource.camera);
//                         },
//                         child: Text("CAMERA"),
//                         color: Colors.blue,
//                       ),
//                       SizedBox(
//                         width: 10,
//                       ),
//                       MaterialButton(
//                         onPressed: () {
//                           Get.back();
//                           getImage(ImageSource.gallery);
//                         },
//                         child: Text("GALLERY"),
//                         color: Colors.blue,
//                       ),
//                     ],
//                   ))
//             ],
//           ),
//         ));
//   }
//
//   Future getImage(
//     ImageSource img,
//   ) async {
//     final pickedFile = await picker.pickImage(
//         source: img, maxHeight: 480, maxWidth: 640, imageQuality: 50);
//     XFile? xfilePick = pickedFile;
//     setState(
//       () {
//         if (xfilePick != null) {
//           setState(() {
//             fimage1 = File(pickedFile!.path);
//             // profile_controller.updateprofileImage("20", profile_controller.fimage1);
//             update_profile("${userid}", fimage1);
//           });
//         } else {
//           ScaffoldMessenger.of(context).showSnackBar(// is this context <<<
//               const SnackBar(content: Text('Nothing is selected')));
//         }
//       },
//     );
//   }
//
//   Future<NormalDTO?> update_profile(String id, File? img) async {
//     util.startLoading();
//     debugPrint("njimage" + "${img.toString()}}");
//     debugPrint("njimage" + "${base64Encode(img!.readAsBytesSync())}");
//
//     print("imageout" + img.toString());
//     print("imageout" +
//         'data:image/png;base64,' +
//         base64Encode(img!.readAsBytesSync()));
//     var res = await http.post(
//         Uri.parse(AppConstant.BASE_URL + "/api/profileimage_update"),
//         body: <String, String>{
//           "id": id,
//           'photo': img != null ? base64Encode(img!.readAsBytesSync()) : '',
//         },
//         headers: <String, String>{
//           "x-api-key": "dentist@123"
//         });
//
//     if (res.statusCode == 200 || res.statusCode == 201) {
//       debugPrint("njimage" + "200");
//       var response = jsonDecode(res.body);
//       if (response['status'] == true) {
//         util.showSuccessProcess();
//         debugPrint("njimage" + "success");
//         debugPrint("njimage" + response.toString());
//         util.showSnackBar("Alert", response['message'], true);
//         return response;
//       } else if (response['status' == false]) {
//         debugPrint("njimage" + "false");
//         util.showFailProcess();
//         util.showSnackBar("Alert", "Something went wrong!", false);
//         return null;
//       }
//     } else {
//       debugPrint("njimage" + "${res.statusCode}");
//       util.showFailProcess();
//       return null;
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: DoubleBackToCloseApp(
//         snackBar: SnackBar(content: Text("Double tap to exit")),
//         child: load_status == false
//             ? Center(
//                 child: CircularProgressIndicator(),
//               )
//             : SafeArea(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Container(
//                       child: Center(
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               children: [
//                                 Visibility(
//                                   visible:
//                                       this.from == "from_home" ? true : false,
//                                   maintainSize: true,
//                                   maintainState: true,
//                                   maintainSemantics: true,
//                                   maintainAnimation: true,
//                                   child: Container(
//                                     width:
//                                         MediaQuery.of(context).size.width / 3,
//                                     alignment: Alignment.centerLeft,
//                                     child: Padding(
//                                       padding: EdgeInsets.only(top: 10),
//                                       child: Bounceable(
//                                         onTap: () {
//                                           Get.back();
//                                         },
//                                         child: Container(
//                                           width: 70,
//                                           height: 40,
//                                           decoration: BoxDecoration(
//                                             color: Colors.white,
//                                             borderRadius: BorderRadius.only(
//                                                 topRight: Radius.circular(30),
//                                                 bottomRight:
//                                                     Radius.circular(30)),
//                                             boxShadow: [
//                                               BoxShadow(
//                                                 color: Colors.grey
//                                                     .withOpacity(0.5),
//                                                 spreadRadius: 1,
//                                                 blurRadius: 2,
//                                                 offset: Offset(0,
//                                                     3), // changes position of shadow
//                                               ),
//                                             ],
//                                           ),
//                                           child: Container(
//                                             decoration: BoxDecoration(
//                                                 borderRadius: BorderRadius.only(
//                                                     topRight:
//                                                         Radius.circular(30),
//                                                     bottomRight:
//                                                         Radius.circular(30)),
//                                                 gradient:
//                                                     AppConstant.BUTTON_COLOR),
//                                             child: Image.asset(
//                                               'assets/images/back_icon.png',
//                                               width: 10,
//                                               height: 10,
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                                 Container(
//                                   alignment: Alignment.center,
//                                   width: MediaQuery.of(context).size.width / 3,
//                                   child: Padding(
//                                     padding: const EdgeInsets.only(top: 15.0),
//                                     child: Container(
//                                       height: 40,
//                                       child: AppConstant.HEADLINE_TEXT(
//                                           AppConstant.TITLE_TEXT_SETTING,
//                                           context),
//                                     ),
//                                   ),
//                                 ),
//                                 Visibility(
//                                   visible: false,
//                                   maintainAnimation: true,
//                                   maintainSemantics: true,
//                                   maintainState: true,
//                                   maintainSize: true,
//                                   child: Container(
//                                     width:
//                                         MediaQuery.of(context).size.width / 3,
//                                     alignment: Alignment.centerRight,
//                                     child: Padding(
//                                         padding:
//                                             EdgeInsets.only(top: 0, right: 10),
//                                         child: Icon(Icons.notifications)),
//                                   ),
//                                 )
//                               ],
//                             ),
//                             SizedBox(
//                               height: 8,
//                             ),
//                             SizedBox(
//                               child: Container(
//                                 height: 2,
//                                 decoration: BoxDecoration(
//                                     color: Colors.grey,
//                                     boxShadow: [
//                                       BoxShadow(
//                                         offset: Offset(2, 4),
//                                         color: Colors.black.withOpacity(
//                                           0.3,
//                                         ),
//                                         blurRadius: 3,
//                                       ),
//                                     ]),
//                               ),
//                             )
//                           ],
//                         ),
//                       ),
//                     ),
//                     Visibility(
//                       visible: islogin == true ? false : true,
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           SizedBox(
//                             height: 80,
//                           ),
//                           Container(
//                             child: Center(
//                               child: Column(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 crossAxisAlignment: CrossAxisAlignment.center,
//                                 children: [
//                                   Center(
//                                     child: Text(
//
//                                       "You Need To Login With Pearllinedentocare",
//                                       textAlign: TextAlign.center,
//                                       style: TextStyle(
//
//                                         fontWeight: FontWeight.bold,
//                                         fontSize: 20,
//                                       ),
//                                     ),
//                                   ),
//                                   SizedBox(
//                                     height: 10,
//                                   ),
//                                   Padding(
//                                     padding: const EdgeInsets.all(8.0),
//                                     child: Container(
//                                       width: 200,
//                                       decoration: BoxDecoration(
//                                           color: Colors.blue,
//                                           borderRadius:
//                                               BorderRadius.circular(100)),
//                                       child: MaterialButton(
//                                         onPressed: () {
//                                           Get.to(Login());
//                                         },
//                                         child: Text(
//                                           "Login",
//                                           style: TextStyle(
//                                               fontWeight: FontWeight.bold,
//                                               color: Colors.white,
//                                               fontSize: 20),
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     SizedBox(
//                       height: 20,
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Visibility(
//                           visible: islogin == true ? true : false,
//                           child: Container(
//                             alignment: Alignment.center,
//                             child: Stack(
//                               children: [
//                                 CircleAvatar(
//                                   radius: 55,
//                                   // backgroundImage:AssetImage('assets/images/user.png'),
//                                   child: ClipOval(
//                                       child: fimage1 == null
//                                           ? CachedNetworkImage(
//                                               imageUrl: profile_controller
//                                                   .image.value,
//                                               width: 100,
//                                               height: 100,
//                                               fit: BoxFit.cover,
//                                               placeholder: (context, url) =>
//                                                   new CircularProgressIndicator(),
//                                               errorWidget: (context, url,
//                                                       error) =>
//                                                   new Image.asset(
//                                                       "assets/images/user.png"),
//                                             )
//                                           : Image.file(
//                                               fimage1!,
//                                               width: 100,
//                                               height: 100,
//                                               cacheWidth: 100,
//                                               cacheHeight: 100,
//                                             )),
//                                 ),
//                                 Positioned(
//                                   bottom: 75,
//                                   right: -4,
//                                   child: Container(
//                                     child: Padding(
//                                       padding: const EdgeInsets.all(2.0),
//                                       child: InkWell(
//                                           onTap: () {
//                                             // Get.to(Profile(),
//                                             //     duration: Duration(seconds: 2),
//                                             //     transition:
//                                             //         Transition.circularReveal);
//                                             showDialog(
//                                                 context: context,
//                                                 builder:
//                                                     (BuildContext context) =>
//                                                         askDialog(context));
//                                           },
//                                           child: Icon(Icons.add_a_photo,
//                                               color: Colors.black)),
//                                     ),
//                                     decoration: BoxDecoration(
//                                         border: Border.all(
//                                           width: 1,
//                                           color: Colors.white,
//                                         ),
//                                         borderRadius: BorderRadius.all(
//                                           Radius.circular(
//                                             60,
//                                           ),
//                                         ),
//                                         color: Colors.white,
//                                         boxShadow: [
//                                           BoxShadow(
//                                             offset: Offset(2, 4),
//                                             color: Colors.black.withOpacity(
//                                               0.3,
//                                             ),
//                                             blurRadius: 3,
//                                           ),
//                                         ]),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                         SizedBox(
//                           width: 8,
//                         ),
//                         Visibility(
//                           visible: userid.isNotEmpty ? true : false,
//                           child: InkWell(
//                             onTap: () {
//                                //Get.to(InstaMojoDemo());
//                               //util.showSnackBar("data",myuser.uid , true);
//                               //startInstamojo();
//                               //util.showSnackBar("Alert", "Clicked", true);
//                               Get.to(Payment());
//                             },
//                             child: Column(
//                               children: [
//                                 Container(
//                                   height: 47,
//                                   width: 126,
//                                   decoration: BoxDecoration(
//                                       boxShadow: [
//                                         BoxShadow(
//                                           color: Colors.grey,
//                                           offset: const Offset(
//                                             5.0,
//                                             5.0,
//                                           ),
//                                           blurRadius: 3.0,
//                                           spreadRadius: 2.0,
//                                         ), //BoxShadow
//                                         BoxShadow(
//                                           color: Colors.white,
//                                           offset: const Offset(0.0, 0.0),
//                                           blurRadius: 0.0,
//                                           spreadRadius: 0.0,
//                                         ), //
//                                         // BoxShadow
//                                       ],
//                                       gradient: LinearGradient(
//                                           begin: Alignment.centerLeft,
//                                           end: Alignment.centerRight,
//                                           colors: [
//                                             Color.fromRGBO(187, 250, 255, 1),
//                                             Color.fromRGBO(143, 162, 219, 1)
//                                           ]),
//                                       color: Color.fromRGBO(75, 255, 136, 1),
//                                       borderRadius: BorderRadius.circular(10)),
//                                   child: Center(
//                                       child: Text(
//                                     "Pay to Doctor",
//                                     style: AppConstant.OpenSans(
//                                         context, Color(0xFF333333)),
//                                   )),
//                                 ),
//                                 SizedBox(
//                                   height: 10,
//                                 ),
//                                 InkWell(
//                                     onTap: () {
//                                       Get.to(ContactUS());
//                                     },
//                                     child: Text("Contact Us")),
//                                 SizedBox(
//                                   height: 10,
//                                 ),
//                                 InkWell(
//                                     onTap: () {
//                                       Get.to(Services());
//                                     },
//                                     child: Text("Our Services")),
//                               ],
//                             ),
//                           ),
//                         )
//                       ],
//                     ),
//                     SizedBox(
//                       height: 20,
//                     ),
//                     Expanded(
//                       flex: 20,
//                       child: ListView.builder(
//                           itemBuilder: (c, i) {
//                             return InkWell(
//                               onTap: () {
//                                 switch (i) {
//                                   case 0:
//                                     {
//                                       if (mylist[i] == "T&C") {
//                                         Get.to(About(3),
//                                             duration: Duration(seconds: 1),
//                                             transition: Transition.leftToRight);
//                                       } else {
//                                         Get.to(Profile(),
//                                             duration: Duration(seconds: 1),
//                                             transition: Transition.leftToRight);
//                                       }
//                                     }
//                                     break;
//
//                                   case 1:
//                                     {
//                                       if (mylist[i] == "Privacy Policy") {
//                                         Get.to(About(2),
//                                             duration: Duration(seconds: 1),
//                                             transition: Transition.leftToRight);
//                                       } else {
//                                         // askChangePassword();
//                                         showDialog(
//                                             context: context,
//                                             builder: (BuildContext context) =>
//                                                 changePassDialog(context));
//                                       }
//                                     }
//                                     break;
//
//                                   case 2:
//                                     {
//                                       if (mylist[i] == "About US") {
//                                         Get.to(About(1),
//                                             duration: Duration(seconds: 1),
//                                             transition: Transition.leftToRight);
//                                       } else {
//                                         Get.to(About(3),
//                                             duration: Duration(seconds: 1),
//                                             transition: Transition.leftToRight);
//                                       }
//                                     }
//                                     break;
//
//                                   case 3:
//                                     {
//                                       if (mylist[i] == "Logout") {
//                                         // showDialog(
//                                         //     context: context,
//                                         //     builder: (BuildContext context) =>
//                                         //         errorDialog(context));
//                                         asklogout();
//                                       } else {
//                                         Get.to(About(2),
//                                             duration: Duration(seconds: 1),
//                                             transition: Transition.leftToRight);
//                                       }
//                                     }
//                                     break;
//                                   case 4:
//                                     {
//                                       if (mylist[i] == "Logout") {
//                                         // showDialog(
//                                         //     context: context,
//                                         //     builder: (BuildContext context) =>
//                                         //         errorDialog(context));
//                                         asklogout();
//                                       } else {
//                                         Get.to(About(1),
//                                             duration: Duration(seconds: 1),
//                                             transition: Transition.leftToRight);
//                                       }
//                                     }
//                                     break;
//                                   case 5:
//                                     {
//                                       if (mylist[i] == "Logout") {
//                                         showDialog(
//                                             context: context,
//                                             builder: (BuildContext context) =>
//                                                 errorDialog(context));
//                                         //asklogout();
//                                       } else if (mylist[i] ==
//                                           "Payment History") {
//                                         Get.to(PaymentHistory(),
//                                             transition: Transition.leftToRight);
//                                       }
//                                     }
//                                     break;
//                                   case 6:
//                                     {
//                                       if (mylist[i] == "Logout") {
//                                         showDialog(
//                                             context: context,
//                                             builder: (BuildContext context) =>
//                                                 errorDialog(context));
//                                         //asklogout();
//                                       } else {}
//                                     }
//                                 }
//                               },
//                               child: Padding(
//                                 padding: const EdgeInsets.only(
//                                     left: 8.0, right: 8.00),
//                                 child: Container(
//                                   clipBehavior: Clip.antiAlias,
//                                   decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.only(
//                                     topRight: Radius.circular(20),
//                                     topLeft: Radius.circular(20),
//                                     bottomLeft: Radius.circular(20),
//                                     bottomRight: Radius.circular(20),
//                                   )),
//                                   child: Container(
//                                     height: 76,
//
//                                     margin: EdgeInsets.only(bottom: 10), // ***
//                                     decoration: BoxDecoration(
//                                       gradient:
//                                           mylist[i] == "Payment History" ||
//                                                   mylist[i] == "T&C" ||
//                                                   mylist[i] != "Logout"
//                                               ? AppConstant.SETTING_BUTTON_COLOR
//                                               : AppConstant
//                                                   .LOGOUT_SETTING_BUTTON_COLOR,
//                                       border: Border.all(
//                                           color: Colors.white, width: 0.2),
//                                       borderRadius: BorderRadius.only(
//                                         bottomLeft: Radius.circular(20),
//                                         bottomRight: Radius.circular(20),
//                                       ),
//                                       color: Colors.white,
//                                       boxShadow: [
//                                         BoxShadow(
//                                           color: Colors.grey,
//                                           blurRadius: 4,
//                                           spreadRadius: 2,
//                                         )
//                                       ],
//                                     ),
//                                     child: Center(
//                                       child: mylist[i] == "T&C" ||
//                                               mylist[i] != "Logout"
//                                           ? ListTile(
//                                               title: Text(
//                                                 mylist[i].toString(),
//                                                 style: AppConstant.OpenSans(
//                                                   context,
//                                                   Color(0xFF333333),
//                                                 ),
//                                               ),
//                                               trailing: i !=
//                                                           mylist[i].length -
//                                                               1 ||
//                                                       mylist[i] == "T&C"
//                                                   ? Icon(
//                                                       Icons.arrow_forward_ios,
//                                                       color:
//                                                           MyColor.ARROW_COLOR,
//                                                     )
//                                                   : null,
//                                               leading: i !=
//                                                           mylist[i].length -
//                                                               1 ||
//                                                       mylist[i] == "T&C"
//                                                   ? Text(" ")
//                                                   : Icon(
//                                                       Icons.power_settings_new),
//                                             )
//                                           : Container(
//                                               child: Row(
//                                                 mainAxisAlignment:
//                                                     MainAxisAlignment.center,
//                                                 children: [
//                                                   Icon(
//                                                     Icons.power_settings_new,
//                                                     size: 34,
//                                                   ),
//                                                   SizedBox(
//                                                     width: 10,
//                                                   ),
//                                                   Text("LOGOUT")
//                                                 ],
//                                               ),
//                                             ),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             );
//                           },
//                           itemCount: mylist.length),
//                     ),
//                     Expanded(
//                         flex: 2,
//                         child: Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Center(
//                                   child: InkWell(
//                                       onTap: () async {
//                                         final Uri url = Uri.parse(
//                                             'https://work.dbvertex.com/dentist1/admin/chats/42/1');
//                                         if (!await launchUrl(url)) {
//                                         util.showSnackBar("Alert", "Could not launched url!", false);
//                                         }
//                                         // await Share.share("https://dbvertex.com");
//                                       },
//                                       child: Text(
//                                         "Developed By DB-Vertex",
//                                         style: AppConstant.Lextendnew(
//                                             context, Colors.black, null),
//                                       ))),
//                               SizedBox(width: 8),
//                             ],
//                           ),
//                         ))
//                   ],
//                 ),
//               ),
//       ),
//     );
//   }
// }
//
// class UserClass {
//   String? _uid="";
//   String? _uname="";
//   String? _uemail="";
//   String? _phone="";
//
//
//   String get uid => _uid!;
//
//   set uid(String value) {
//     _uid = value;
//   }
//
//
//   String get uname => _uname!;
//
//   set uname(String value) {
//     _uname = value;
//   }
//
//   String get uemail => _uemail!;
//
//   set uemail(String value) {
//     _uemail = value;
//   }
//
//   String get phone => _phone!;
//
//   set phone(String value) {
//     _phone = value;
//   }
//
//   UserClass(this._uid, this._uname, this._uemail, this._phone);
// }

///                                    new code                         ///
import 'dart:convert';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'package:path_provider/path_provider.dart';
import 'package:dentocoreauth/pages/about/about.dart';
import 'package:dentocoreauth/pages/profile/profile.dart';
import 'package:dentocoreauth/pages/razorpay/ApiServices.dart';
import 'package:dentocoreauth/utils/app_constant.dart';
import 'package:dentocoreauth/utils/mycolor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../Utills/Utills.dart';
import '../../controllers/notification_controller.dart';
import '../../controllers/profile_controller.dart';
import '../../controllers/user_controller.dart';
import '../../models/normalDTO.dart';
import '../Services/Services.dart';
import '../auth/login/login.dart';
import '../change_pasword/change_password.dart';
import '../contact_us/contact_us.dart';
import '../faq/faq.dart';

class Setting extends StatefulWidget {
  var from = "";

  Setting(String _from) {
    this.from = _from;
  }

  @override
  State<Setting> createState() => _SettingsState(from);
}

class _SettingsState extends State<Setting> {
  var from = "";

  _SettingsState(String _from) {
    this.from = _from;
  }

  final ProfileController profile_controller = Get.find();
  final NotificationController notificationController = Get.find();
  final UserController userController = Get.find();

  late UserClass myuser;
  var islogin = false;
  var util = Utills();
  var uimage = "";
  var mylist = [
    "My Profile",
    "Change Password",
    "T&C Abhi 1",
    "Privacy Policy",
    "About US",
    "Payment History",
    "Logout"
  ];

  File? fimage1;
  ImagePicker picker = ImagePicker();
  var user_data = [];
  var load_status = true;
  var userid = "";
  var user_name = "";
  var user_mail = "";
  var user_phone = "";

  asklogout() {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Do you really want to Logout!'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => {
              logoutApi(),
              Navigator.pop(context, 'OK'),
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  Dialog changePassDialog(BuildContext context) {
    return Dialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0)), //this right here
        child: Container(
          height: 200.0,
          width: 200.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(12.0),
                child: Text(
                  'Change Password',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      fontSize: 18),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(12.0),
                child: Center(
                  child: Text(
                    'Do you really want to change password?',
                    style: TextStyle(color: Colors.black, fontSize: 14),
                  ),
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
                          Navigator.of(context).pop();
                          gotoChangePassword();
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

  void askChangePassword() {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Do you really want to change password?'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => {
              Navigator.pop(context, 'OK'),
              gotoChangePassword(),
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  Future<void> _deleteCacheDir() async {
    final cacheDir = await getTemporaryDirectory();

    if (cacheDir.existsSync()) {
      cacheDir.deleteSync(recursive: true);
    }
  }

  logout() async {
    var sp = await SharedPreferences.getInstance();
    // await DefaultCacheManager().emptyCache();

    // var appDir = (await getTemporaryDirectory()).path +
    //     '/com.dbvertex.pearllinedentocare';
    // new Directory(appDir).delete(recursive: true);
    sp.remove("user_data").then((value) => {
          if (value == true)
            {
              util.showSnackBar("Alert", "logout successfully", true),
              AppConstant.save_data("token", ""),
              AppConstant.save_data("isFirst", "no"),
              //AppConstant.removeData("fcm"),
              //  Restart.restartApp(),
              //   _deleteCacheDir(),
              print("Abhi:-Logout successfully"),
              Get.to(Login()),
              Phoenix.rebirth(context),
              print("Abhi:-Logout successfully-->1"),
              // Get.back(),
              // Navigator.pushReplacement(
              //     context, MaterialPageRoute(builder: (context) => Login())),
              print("Abhi:-Logout successfully"),
            }
          else
            {
              util.showSnackBar("Alert", "Abhi Something went wrong!", false),
            }
        });
  }

  gotoChangePassword() {
    Get.to(ChangePassword(false, userid),
        duration: Duration(seconds: 1), transition: Transition.leftToRight);
  }

  logoutApi() async {
    util.startLoading();
    var res = await http.get(
        Uri.parse(
            AppConstant.BASE_URL + AppConstant.LOGOUT_ENDPOINT + "${userid}"),
        headers: <String, String>{"x-api-key": "dentist@123"});
    if (res.statusCode == 200 || res.statusCode == 201) {
      print("Abhi:- Logout reponse print ${res.body}");
      util.showFailProcess();
      var temp = jsonDecode(res.body);
      logout();
    } else {
      util.showFailProcess();
      util.showSnackBar("Alert", "Something went wrong!", false);
    }
  }

  void getUserData(key) async {
    final sp = await SharedPreferences.getInstance();
    setState(() {
      user_data = sp.getStringList(key) ?? [];

      // util.showSnackBar("userid", user_data[0].toString(), true);
      debugPrint("userdata" + user_data.toString());

      myuser = UserClass(userid, user_name, user_mail, user_phone);
      userid = user_data[0].toString();
      user_name = user_data[1].toString();
      user_mail = user_data[2].toString();
      user_phone = user_data[3].toString();

      if (userid.isNotEmpty) {
        var res = profile_controller.getProfile(userid);
        EasyLoading.show(status: "Loading..");
        res.then((value) {
          EasyLoading.dismiss();
          setState(() {
            uimage = value!.body.image.toString() ?? "";
            debugPrint("testnj-${uimage}");
            profile_controller.image.value = value.body.image.toString();
          });
        });
        print("islogintrue");
        islogin = true;
        mylist = mylist = [
          "My Profile",
          "Change Password",
          "T&C",
          "Privacy Policy",
          "About US",
          "Payment History",
          "Logout"
        ];
      } else {
        print("isloginfalse");
        islogin = false;
      }
    });
  }

  @override
  void dispose() {
    super.dispose();

    if (EasyLoading.isShow) {
      EasyLoading.dismiss();
    }
  }

  @override
  void initState() {
    super.initState();
    getUserData("user_data");
    if (userid.isEmpty) {
      mylist.removeRange(0, 2);
      mylist.removeLast();
      mylist.removeLast();
    } else {}
    load_status = false;
    Future.delayed(Duration(milliseconds: 100), () {
      setState(() {
        load_status = true;
      });
    });
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
                  'Logout',
                  style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.w700,
                      fontSize: 18),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(12.0),
                child: Text(
                  'Do you really want to Logout?',
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
                          logout();
                          Get.back();
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
                  ))
            ],
          ),
        ));
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
        util.showSuccessProcess();
        debugPrint("njimage" + "success");
        debugPrint("njimage" + response.toString());
        util.showSnackBar("Alert", response['message'], true);
        return response;
      } else if (response['status' == false]) {
        debugPrint("njimage" + "false");
        util.showFailProcess();
        util.showSnackBar("Alert", "Something went wrong!", false);
        return null;
      }
    } else {
      debugPrint("njimage" + "${res.statusCode}");
      util.showFailProcess();
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
        systemNavigationBarColor: MyColor.primarycolor,
      ),
      child: SafeArea(
        child: Scaffold(
          body: DoubleBackToCloseApp(
            snackBar: SnackBar(content: Text("Double tap to exit")),
            child: load_status == false
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: height * 0.01,
                            ),
                            Text(
                              "Setting",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 18),
                            ),
                            Container(
                              height: 75,
                              // color: Colors.purple,
                              child: Stack(
                                children: [
                                  // Background Container
                                  Positioned(
                                    top: 15,
                                    left: 0,
                                    right: 0,
                                    child: Container(
                                      height: 50,
                                      color: /*Color(0xFF144860)*/
                                          MyColor.primarycolor,
                                    ),
                                  ),
                                  // Profile Icon (Left side)
                                  // Positioned(
                                  //   top: 5,
                                  //   left: 15,
                                  //   child:
                                  //   Obx(()=> ClipOval(
                                  //       child: fimage1 == null
                                  //           ? CachedNetworkImage(
                                  //               imageUrl: profile_controller
                                  //                   .image.value,
                                  //               width: 70,
                                  //               height: 70,
                                  //               fit: BoxFit.cover,
                                  //               placeholder: (context, url) =>
                                  //                    CircularProgressIndicator(),
                                  //               errorWidget: (context, url,
                                  //                       error) =>
                                  //                   Image.asset(
                                  //                       "assets/images/user.png"),
                                  //             )
                                  //           : Image.file(
                                  //               fimage1!,
                                  //               width: 70,
                                  //               height: 70,
                                  //               cacheWidth: 100,
                                  //               cacheHeight: 100,
                                  //             )),
                                  // )),
                                  Positioned(
                                    top: 5,
                                    left: 15,
                                    // child: Obx(() => CircleAvatar(
                                    //   radius: 55,
                                    //   child: ClipOval(
                                    //         child: fimage1 == null
                                    //             ? CachedNetworkImage(
                                    //                 imageUrl: profile_controller
                                    //                     .image.value,
                                    //                 width: 70,
                                    //                 height: 70,
                                    //                 fit: BoxFit.cover,
                                    //                 cacheKey:
                                    //                     "${profile_controller.image.value}_${DateTime.now().millisecondsSinceEpoch}",
                                    //                 placeholder: (context, url) =>
                                    //                     CircularProgressIndicator(),
                                    //                 errorWidget: (context, url,
                                    //                         error) =>
                                    //                     Image.asset(
                                    //                         "assets/images/user.png"),
                                    //               )
                                    //             : Image.file(
                                    //                 fimage1!,
                                    //                 width: 70,
                                    //                 height: 70,
                                    //                 fit: BoxFit.cover,
                                    //               ),
                                    //       ),
                                    // )),
                                  child: Obx(()=> CircleAvatar(
                                      radius: 35,
                                      // backgroundImage:AssetImage('assets/images/user.png'),
                                      child: ClipOval(
                                          child: fimage1 == null
                                              ? CachedNetworkImage(
                                            imageUrl: profile_controller
                                                .image.value,
                                            width: 64,
                                            height: 64,
                                            fit: BoxFit.cover,
                                            placeholder: (context, url) =>
                                            new CircularProgressIndicator(),
                                            errorWidget: (context, url,
                                                error) =>
                                            Container(
                                              color: Colors.white,
                                              child: new Image.asset(
                                                  "assets/images/user.png"),
                                            ),
                                          )
                                              : Image.file(
                                            fimage1!,
                                            width: 70,
                                            height: 70,
                                            cacheWidth: 70,
                                            cacheHeight: 70,
                                          )),
                                    )),
                                  ),
                                  // Name & Icons (Aligned with profile pic)
                                  Positioned(
                                    top: 27,
                                    left: 90,
                                    child: Obx(()=>
                                      Row(
                                        children: [
                                          SizedBox(width: 13),
                                          Text(
                                            "Hi,${profile_controller.user_name ?? "user"}"
                                                .capitalizeFirst!,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
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
                        child: Card(
                          color: Color(0xFFF6F8FA),
                          elevation: 4,
                          // clipBehavior: Chi,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12.0, vertical: 12),
                            child: GestureDetector(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  userid.isEmpty
                                      ? SizedBox()
                                      : GestureDetector(
                                          child: _infoContainer(
                                              () /*=>Get.to(Profile(), {} )*/ {
                                            getUserData("user_data");
                                            // if (userid.isEmpty) {
                                            //   mylist.removeRange(0, 2);
                                            //   mylist.removeLast();
                                            //   mylist.removeLast();
                                            // } else {}
                                            // load_status = false;
                                            // Future.delayed(Duration(milliseconds: 100), () {
                                            //   setState(() {
                                            //     load_status = true;
                                            //   });
                                            // });
                                            Get.to(Profile());
                                          }, width, " Personal Info",
                                              "assets/newImages/drowerpersonlinfo.png"),
                                        ),
                                  userid.isEmpty
                                      ? SizedBox()
                                      : SizedBox(
                                          height: width * 0.05,
                                        ),
                                  userid.isEmpty
                                      ? SizedBox()
                                      : _infoContainer(
                                          () => Get.to(showDialog(
                                              context: context,
                                              builder: (BuildContext context) =>
                                                  changePassDialog(context))),
                                          width,
                                          " Change Password",
                                          "assets/newImages/changepassword.png"),
                                  userid.isEmpty
                                      ? SizedBox()
                                      : SizedBox(
                                          height: width * 0.05,
                                        ),
                                  _infoContainer(
                                      () => Get.to(FAQScreen()),
                                      width,
                                      " FAQ",
                                      "assets/newImages/faqsetting.png"),
                                  SizedBox(
                                    height: width * 0.05,
                                  ),
                                  _infoContainer(
                                      () => Get.to(ContactUS()),
                                      width,
                                      " Contact Us",
                                      "assets/newImages/fqa.png"),
                                  SizedBox(
                                    height: width * 0.05,
                                  ), //assets/newIma
                                  _infoContainer(
                                      () => Get.to(About(3)),
                                      width,
                                      "T&C",
                                      "assets/newImages/trams&conditionsetting.png"),
                                  SizedBox(
                                    height: width * 0.05,
                                  ),
                                  _infoContainer(
                                      () => Get.to(About(1)),
                                      width,
                                      "About us",
                                      "assets/newImages/abaout.png"),
                                  SizedBox(
                                    height: width * 0.05,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      userid.isEmpty
                          ? SizedBox()
                          : Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Card(
                                color: Color(0xFFF6F8FA),
                                elevation: 4,
                                // clipBehavior: Chi,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12.0, vertical: 12),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // _infoContainer(() => Get.to(asklogout()),width," Logout","assets/newImages/logout.png"),
                                      // _infoContainer(()  => logout(), width, "Logout", "assets/newImages/logout.png"),
                                      _infoContainer(() {
                                        Get.defaultDialog(
                                            radius: 20,
                                            contentPadding: EdgeInsets.all(20),
                                            title: "Alert",
                                            content: Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              height: 100,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Center(
                                                    child: Text(
                                                        "Do you want to log out of the app?"),
                                                  ),
                                                  SizedBox(height: 15),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      MaterialButton(
                                                        onPressed: () {
                                                          Get.back();
                                                        },
                                                        child: Text(
                                                          "Cancel",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                        color: MyColor
                                                            .primarycolor,
                                                      ),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      MaterialButton(
                                                        onPressed: () {
                                                          logout();
                                                        },
                                                        child: Text(
                                                          "Logout",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                        color: MyColor
                                                            .primarycolor,
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ));
                                      }, width, "Logout",
                                          "assets/newImages/logout.png"),
                                      // SizedBox(height: width*0.05,),
                                    ],
                                  ),
                                ),
                              ),
                            ),

                      /// Old code
                      // old code
                      // Expanded(
                      //   flex: 20,
                      //   child: Card(
                      //     elevation: 4,
                      //     color: Colors.red,
                      //     child: ListView.builder(
                      //         itemBuilder: (c, i) {
                      //           return InkWell(
                      //             onTap: () {
                      //               switch (i) {
                      //                 case 0:
                      //                   {
                      //                     if (mylist[i] == "T&C") {
                      //                       Get.to(About(3),
                      //                           duration: Duration(seconds: 1),
                      //                           transition: Transition.leftToRight);
                      //                     } else {
                      //                       Get.to(Profile(),
                      //                           duration: Duration(seconds: 1),
                      //                           transition: Transition.leftToRight);
                      //                     }
                      //                   }
                      //                   break;
                      //
                      //                 case 1:
                      //                   {
                      //                     if (mylist[i] == "Privacy Policy") {
                      //                       Get.to(About(2),
                      //                           duration: Duration(seconds: 1),
                      //                           transition: Transition.leftToRight);
                      //                     } else {
                      //                       // askChangePassword();
                      //                       showDialog(
                      //                           context: context,
                      //                           builder: (BuildContext context) =>
                      //                               changePassDialog(context));
                      //                     }
                      //                   }
                      //                   break;
                      //
                      //                 case 2:
                      //                   {
                      //                     if (mylist[i] == "About US") {
                      //                       Get.to(About(1),
                      //                           duration: Duration(seconds: 1),
                      //                           transition: Transition.leftToRight);
                      //                     } else {
                      //                       Get.to(About(3),
                      //                           duration: Duration(seconds: 1),
                      //                           transition: Transition.leftToRight);
                      //                     }
                      //                   }
                      //                   break;
                      //
                      //                 case 3:
                      //                   {
                      //                     if (mylist[i] == "Logout") {
                      //                       // showDialog(
                      //                       //     context: context,
                      //                       //     builder: (BuildContext context) =>
                      //                       //         errorDialog(context));
                      //                       asklogout();
                      //                     } else {
                      //                       Get.to(About(2),
                      //                           duration: Duration(seconds: 1),
                      //                           transition: Transition.leftToRight);
                      //                     }
                      //                   }
                      //                   break;
                      //                 case 4:
                      //                   {
                      //                     if (mylist[i] == "Logout") {
                      //                       // showDialog(
                      //                       //     context: context,
                      //                       //     builder: (BuildContext context) =>
                      //                       //         errorDialog(context));
                      //                       asklogout();
                      //                     } else {
                      //                       Get.to(About(1),
                      //                           duration: Duration(seconds: 1),
                      //                           transition: Transition.leftToRight);
                      //                     }
                      //                   }
                      //                   break;
                      //                 case 5:
                      //                   {
                      //                     if (mylist[i] == "Logout") {
                      //                       showDialog(
                      //                           context: context,
                      //                           builder: (BuildContext context) =>
                      //                               errorDialog(context));
                      //                       //asklogout();
                      //                     } else if (mylist[i] ==
                      //                         "Payment History") {
                      //                       Get.to(PaymentHistory(),
                      //                           transition: Transition.leftToRight);
                      //                     }
                      //                   }
                      //                   break;
                      //                 case 6:
                      //                   {
                      //                     if (mylist[i] == "Logout") {
                      //                       showDialog(
                      //                           context: context,
                      //                           builder: (BuildContext context) =>
                      //                               errorDialog(context));
                      //                       //asklogout();
                      //                     } else {}
                      //                   }
                      //               }
                      //             },
                      //             child: Padding(
                      //               padding: const EdgeInsets.only(
                      //                   left: 8.0, right: 8.00),
                      //               child: Card(
                      //                color: Colors.purple,
                      //                 child: Container(
                      //                   // clipBehavior: Clip.antiAlias,
                      //                   // decoration: BoxDecoration(
                      //                   //     borderRadius: BorderRadius.only(
                      //                   //   topRight: Radius.circular(20),
                      //                   //   topLeft: Radius.circular(20),
                      //                   //   bottomLeft: Radius.circular(20),
                      //                   //   bottomRight: Radius.circular(20),
                      //                   // )),
                      //                   child: Container(
                      //                     height: 76,
                      //
                      //                     margin: EdgeInsets.only(bottom: 10), // ***
                      //                     decoration: BoxDecoration(
                      //                       gradient:
                      //                           mylist[i] == "Payment History" ||
                      //                                   mylist[i] == "T&C" ||
                      //                                   mylist[i] != "Logout"
                      //                               ? AppConstant.SETTING_BUTTON_COLOR
                      //                               : AppConstant
                      //                                   .LOGOUT_SETTING_BUTTON_COLOR,
                      //                       border: Border.all(
                      //                           color: Colors.white, width: 0.2),
                      //                       borderRadius: BorderRadius.only(
                      //                         bottomLeft: Radius.circular(20),
                      //                         bottomRight: Radius.circular(20),
                      //                       ),
                      //                       color: Colors.white,
                      //                       boxShadow: [
                      //                         BoxShadow(
                      //                           color: Colors.grey,
                      //                           blurRadius: 4,
                      //                           spreadRadius: 2,
                      //                         )
                      //                       ],
                      //                     ),
                      //                     child: Center(
                      //                       child: mylist[i] == "T&C" ||
                      //                               mylist[i] != "Logout"
                      //                           ? ListTile(
                      //                               title: Text(
                      //                                 mylist[i].toString(),
                      //                                 style: AppConstant.OpenSans(
                      //                                   context,
                      //                                   Color(0xFF333333),
                      //                                 ),
                      //                               ),
                      //                               trailing: i != mylist[i].length - 1 || mylist[i] == "T&C" ? Icon(
                      //                                       Icons.arrow_forward_ios,
                      //                                       color: MyColor.ARROW_COLOR,
                      //                                     )
                      //                                   : null,
                      //                               leading: i !=
                      //                                           mylist[i].length -
                      //                                               1 ||
                      //                                       mylist[i] == "T&C"
                      //                                   ? Text(" ")
                      //                                   : Icon(
                      //                                       Icons.power_settings_new),
                      //                             )
                      //                           : Container(
                      //                               child: Row(
                      //                                 mainAxisAlignment:
                      //                                     MainAxisAlignment.center,
                      //                                 children: [
                      //                                   Icon(
                      //                                     Icons.power_settings_new,
                      //                                     size: 34,
                      //                                   ),
                      //                                   SizedBox(
                      //                                     width: 10,
                      //                                   ),
                      //                                   Text("LOGOUT")
                      //                                 ],
                      //                               ),
                      //                             ),
                      //                     ),
                      //                   ),
                      //                 ),
                      //               ),
                      //             ),
                      //           );
                      //         },
                      //         itemCount: mylist.length),
                      //   ),
                      // ),
                      // Expanded(
                      //     flex: 2,
                      //     child: Padding(
                      //       padding: const EdgeInsets.all(8.0),
                      //       child: Row(
                      //         mainAxisAlignment: MainAxisAlignment.center,
                      //         children: [
                      //           Center(
                      //               child: InkWell(
                      //                   onTap: () async {
                      //                     final Uri url = Uri.parse(
                      //                         'https://work.dbvertex.com/dentist1/admin/chats/42/1');
                      //                     if (!await launchUrl(url)) {
                      //                       util.showSnackBar("Alert",
                      //                           "Could not launched url!", false);
                      //                     }
                      //                     // await Share.share("https://dbvertex.com");
                      //                   },
                      //                   child: Text(
                      //                     "Developed By DB-Vertex",
                      //                     style: AppConstant.Lextendnew(
                      //                         context, Colors.black, null),
                      //                   ))),
                      //           SizedBox(width: 8),
                      //         ],
                      //       ),
                      //     ))
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  _infoContainer(
    onTab,
    double width,
    String hint,
    image,
  ) {
    return InkWell(
      onTap: onTab,
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CircleAvatar(
            backgroundColor: Colors.white,
            child: Image.asset(
              image,
              height: 22,
            ),
          ),
          SizedBox(
            width: width * 0.05,
          ),
          Text(hint),
          Spacer(),
          Icon(
            Icons.arrow_forward_ios,
            size: 18,
          )
        ],
      ),
    );
  }
}

class UserClass {
  String? _uid = "";
  String? _uname = "";
  String? _uemail = "";
  String? _phone = "";

  String get uid => _uid!;

  set uid(String value) {
    _uid = value;
  }

  String get uname => _uname!;

  set uname(String value) {
    _uname = value;
  }

  String get uemail => _uemail!;

  set uemail(String value) {
    _uemail = value;
  }

  String get phone => _phone!;

  set phone(String value) {
    _phone = value;
  }

  UserClass(this._uid, this._uname, this._uemail, this._phone);
}
