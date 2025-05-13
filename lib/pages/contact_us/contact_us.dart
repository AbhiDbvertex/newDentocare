// import 'dart:convert';
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_bounceable/flutter_bounceable.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:http/http.dart' as http;
// import 'package:url_launcher/url_launcher.dart';
// import '../../Utills/Utills.dart';
// import '../../utils/app_constant.dart';
// import '../../utils/component_screen.dart';
// import '../../utils/mycolor.dart';
//
// class ContactUS extends StatefulWidget {
//   const ContactUS({Key? key}) : super(key: key);
//
//   @override
//   State<ContactUS> createState() => _ContactUSState();
// }
//
// class _ContactUSState extends State<ContactUS> {
//   final util = Utills();
//
//   final name = TextEditingController();
//   final email = TextEditingController();
//   final phone = TextEditingController();
//   final description = TextEditingController();
//
//   contact_post(
//     String name,
//     String email,
//     String phone,
//     String description,
//   ) async {
//     util.startLoading();
//     var response = await http.post(
//         Uri.parse(AppConstant.BASE_URL + "/api/contactus"),
//         body: <String, String>{
//           "name": name,
//           "mobile": phone,
//           "description": description,
//           "email": email
//         },
//         headers: <String, String>{
//           "x-api-key": "dentist@123"
//         });
//     if (response.statusCode == 201 || response.statusCode == 200) {
//       util.stopLoading();
//       final res = jsonDecode(response.body);
//       util.showSnackBar("Alert", "${res['message'].toString()}", true);
//     } else {
//       util.stopLoading();
//       util.showSnackBar("Alert", "something went wrong!", true);
//     }
//   }
//
// // To create email with params
//   final Uri _emailLaunchUri = Uri(
//     scheme: 'mailto',
//     path: 'contact@abc.services.gmail.com',
//     queryParameters: {'subject': "Dear doctor i have some need for root canal", 'body': "Hey Kashish here goes the body"},
//   );
//
//   @override
//   Widget build(BuildContext context) {
//     final height = MediaQuery.of(context).size.height;
//     final width = MediaQuery.of(context).size.width;
//     return AnnotatedRegion<SystemUiOverlayStyle>(
//         value: SystemUiOverlayStyle(
//           statusBarColor: MyColor.primarycolor,
//           statusBarIconBrightness: Brightness.light,
//           statusBarBrightness: Brightness.light,
//           systemNavigationBarColor: Colors.transparent,
//         ),
//         child: Scaffold(
//       body: SafeArea(
//           child: Container(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             CustomAppBar(
//               title: 'Contact Us',
//             ),
//             SizedBox(
//               height: 20,
//             ),
//             /// this is new correct code
//
//            Center(child:Text("Contact Us",style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),)),
//            Center(child:Text("If you have any questionwe\n         are happy to help",style: TextStyle(color: Colors.grey, fontSize: 16, fontWeight: FontWeight.w400),)),
//             SizedBox(
//               height: height*0.1,
//             ),
//             InkWell(
//               onTap: () {
//                 launch("tel://+919894742511");
//                 },
//                 child: Image.asset("assets/newImages/contactphone.png",scale: 2,)),
//             Center(child:Text("+9298274799",style: TextStyle(color: Colors.grey, fontSize: 16, fontWeight: FontWeight.w400),)),
//             SizedBox(
//               height: height*0.04,
//             ),
//             InkWell(
//                 onTap: () {
//                   setState(() {
//                     launch(_emailLaunchUri.toString());
//                     });
//                 },
//                 child: Image.asset("assets/newImages/contactemail.png",scale: 2,)),
//             Center(child:Text("contact@abc.services",style: TextStyle(color: Colors.grey, fontSize: 16, fontWeight: FontWeight.w400),)),
//             Spacer(),
//             Center(child:Text("Get Connected",style: TextStyle(color: Colors.grey, fontSize: 16, fontWeight: FontWeight.w400),)),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Image.asset("assets/newImages/contactlinden.png",scale: 1,),
//                 SizedBox(
//                   width: width*0.04,
//                 ),
//                 Image.asset("assets/newImages/contactfacebook.png",scale: 2 ,),
//                 SizedBox(
//                   width: width*0.04,
//                 ),
//                 Image.asset("assets/newImages/contactx.png",scale: 2 ,),
//                 SizedBox(
//                   width: width*0.04,
//                 ),
//                 Image.asset("assets/newImages/instagram.png",scale: 2 ,),
//                 SizedBox(
//                   width: width*0.04,
//                 ),
//                 InkWell(
//                     onTap: () async {
//                       final number = "+919894742511";
//                       final message = "Hello Doc!!";
//                       var url = 'https://wa.me/$number?text=$message';
//                       if (await canLaunch(url)) {
//                         await launch(url);
//                       }
//                     },
//                     child: Image.asset("assets/newImages/contactwatshapp.png",scale: 2 ,)),
//               ],
//             ),
//             Padding(
//               padding: const EdgeInsets.all(15.0),
//               child: Divider(),
//             ),
//
//             // Padding(
//             //   padding: const EdgeInsets.only(
//             //       left: 16.0, right: 24.0, bottom: 8, top: 8),
//             //   child: Container(
//             //     height: 45.00,
//             //     decoration: BoxDecoration(
//             //         borderRadius: BorderRadius.circular(10),
//             //         border: Border.all(color: Colors.blue, width: 1)),
//             //     child: Center(
//             //         child: GestureDetector(
//             //       onTap: () {
//             //         setState(() {});
//             //       },
//             //       behavior: HitTestBehavior.opaque,
//             //       child: Padding(
//             //         padding: const EdgeInsets.all(8.0),
//             //         child: TextFormField(
//             //           controller: name,
//             //           decoration: InputDecoration.collapsed(
//             //               hintText: "Enter your name",
//             //               hintStyle: TextStyle(
//             //                   color: MyColor.LOGIN_TEXT_HINT_PASSWORD_COLOR),
//             //               border: InputBorder.none,
//             //               floatingLabelAlignment: FloatingLabelAlignment.start),
//             //           keyboardType: TextInputType.text,
//             //           autovalidateMode: AutovalidateMode.disabled,
//             //           onTap: () {
//             //             setState(() {});
//             //           },
//             //           onChanged: (phone) {},
//             //           textAlignVertical: TextAlignVertical.center,
//             //         ),
//             //       ),
//             //     )),
//             //   ),
//             // ),
//             // Padding(
//             //   padding: const EdgeInsets.only(
//             //       left: 16.0, right: 24.0, bottom: 8, top: 8),
//             //   child: Container(
//             //     height: 45.00,
//             //     decoration: BoxDecoration(
//             //         borderRadius: BorderRadius.circular(10),
//             //         border: Border.all(color: Colors.blue, width: 1)),
//             //     child: Center(
//             //         child: GestureDetector(
//             //       onTap: () {
//             //         setState(() {});
//             //       },
//             //       behavior: HitTestBehavior.opaque,
//             //       child: Padding(
//             //         padding: const EdgeInsets.all(8.0),
//             //         child: TextFormField(
//             //           controller: email,
//             //           decoration: InputDecoration.collapsed(
//             //               hintText: "Enter your email",
//             //               hintStyle: TextStyle(
//             //                   color: MyColor.LOGIN_TEXT_HINT_PASSWORD_COLOR),
//             //               border: InputBorder.none,
//             //               floatingLabelAlignment: FloatingLabelAlignment.start),
//             //           keyboardType: TextInputType.emailAddress,
//             //           autovalidateMode: AutovalidateMode.disabled,
//             //           onTap: () {
//             //             setState(() {});
//             //           },
//             //           onChanged: (phone) {},
//             //           textAlignVertical: TextAlignVertical.center,
//             //         ),
//             //       ),
//             //     )),
//             //   ),
//             // ),
//             // Padding(
//             //   padding: const EdgeInsets.only(
//             //       left: 16.0, right: 24.0, bottom: 8, top: 8),
//             //   child: Container(
//             //     height: 45.00,
//             //     decoration: BoxDecoration(
//             //         borderRadius: BorderRadius.circular(10),
//             //         border: Border.all(color: Colors.blue, width: 1)),
//             //     child: Center(
//             //         child: GestureDetector(
//             //       onTap: () {
//             //         setState(() {});
//             //       },
//             //       behavior: HitTestBehavior.opaque,
//             //       child: Padding(
//             //         padding: const EdgeInsets.all(8.0),
//             //         child: TextFormField(
//             //           controller: phone,
//             //           decoration: InputDecoration.collapsed(
//             //               hintText: "Enter your phone",
//             //               hintStyle: TextStyle(
//             //                   color: MyColor.LOGIN_TEXT_HINT_PASSWORD_COLOR),
//             //               border: InputBorder.none,
//             //               floatingLabelAlignment: FloatingLabelAlignment.start),
//             //           keyboardType: TextInputType.phone,
//             //           inputFormatters: [
//             //             LengthLimitingTextInputFormatter(10),
//             //           ],
//             //           autovalidateMode: AutovalidateMode.disabled,
//             //           onTap: () {
//             //             setState(() {});
//             //           },
//             //           onChanged: (phone) {},
//             //           textAlignVertical: TextAlignVertical.center,
//             //         ),
//             //       ),
//             //     )),
//             //   ),
//             // ),
//             // Padding(
//             //   padding: const EdgeInsets.only(
//             //       left: 16.0, right: 24.0, bottom: 8, top: 8),
//             //   child: Container(
//             //   //  height: 45.00,
//             //     decoration: BoxDecoration(
//             //         borderRadius: BorderRadius.circular(10),
//             //         border: Border.all(color: Colors.blue, width: 1)),
//             //     child: Center(
//             //         child: GestureDetector(
//             //       onTap: () {
//             //         setState(() {});
//             //       },
//             //       behavior: HitTestBehavior.opaque,
//             //       child: Padding(
//             //         padding: const EdgeInsets.all(8.0),
//             //         child: TextFormField(
//             //           controller: description,
//             //           maxLines: 3,
//             //           decoration: InputDecoration.collapsed(
//             //               hintText: "Enter your description",
//             //               hintStyle: TextStyle(
//             //                   color: MyColor.LOGIN_TEXT_HINT_PASSWORD_COLOR),
//             //               border: InputBorder.none,
//             //               floatingLabelAlignment: FloatingLabelAlignment.start),
//             //           keyboardType: TextInputType.text,
//             //           autovalidateMode: AutovalidateMode.disabled,
//             //           onTap: () {
//             //             setState(() {});
//             //           },
//             //           onChanged: (phone) {},
//             //           textAlignVertical: TextAlignVertical.center,
//             //         ),
//             //       ),
//             //     )),
//             //   ),
//             // ),
//             // SizedBox(
//             //   height: 20,
//             // ),
//             // Center(
//             //   child: Bounceable(
//             //     onTap: () {
//             //       if (name.text.isEmpty) {
//             //         util.showSnackBar("Alert", "Please enter name", false);
//             //       } else if (!GetUtils.isEmail(email.text) ||
//             //           email.text.isEmpty) {
//             //         util.showSnackBar(
//             //             "Alert", "Please enter valid email", false);
//             //       } else if (phone.text.isEmpty || phone.text.length < 10) {
//             //         util.showSnackBar(
//             //             "Alert", "Please enter valid phone no.", false);
//             //       } else if (description.text.isEmpty) {
//             //         util.showSnackBar(
//             //             "Alert", "Please enter description", false);
//             //       } else {
//             //         contact_post(
//             //             name.text, email.text, phone.text, description.text);
//             //       }
//             //     },
//             //     child: Container(
//             //       decoration: BoxDecoration(
//             //       color: MyColor.primarycolor,
//             //         borderRadius: BorderRadius.circular(20),
//             //       ),
//             //       margin: const EdgeInsets.all(8.00),
//             //       width: AppConstant.BUTTON_WIDTH,
//             //       height: AppConstant.BUTTON_HIGHT,
//             //       child: Center(
//             //         child: Text("Send",
//             //             style: GoogleFonts.nunitoSans(
//             //                 textStyle: Theme.of(context).textTheme.displayLarge,
//             //                 fontSize: AppConstant.MEDIUM_SIZE,
//             //                 fontWeight: FontWeight.w700,
//             //                 fontStyle: FontStyle.normal,
//             //                 color: Colors.white)),
//             //       ),
//             //     ),
//             //   ),
//             // )
//           ],
//         ),
//       )),
//     ));
//   }
// }

 import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import '../../Utills/Utills.dart';
import '../../utils/app_constant.dart';
import '../../utils/component_screen.dart';
import '../../utils/mycolor.dart';

class ContactUS extends StatefulWidget {
  const ContactUS({Key? key}) : super(key: key);

  @override
  State<ContactUS> createState() => _ContactUSState();
}

class _ContactUSState extends State<ContactUS> {
  final util = Utills();

  final name = TextEditingController();
  final email = TextEditingController();
  final phone = TextEditingController();
  final description = TextEditingController();

  contact_post(
      String name,
      String email,
      String phone,
      String description,
      ) async {
    util.startLoading();
    var response = await http.post(
        Uri.parse(AppConstant.BASE_URL + "/api/contactus"),
        body: <String, String>{
          "name": name,
          "mobile": phone,
          "description": description,
          "email": email
        },
        headers: <String, String>{
          "x-api-key": "dentist@123"
        });
    if (response.statusCode == 201 || response.statusCode == 200) {
      util.stopLoading();
      final res = jsonDecode(response.body);
      util.showSnackBar("Alert", "${res['message'].toString()}", true);
    } else {
      util.stopLoading();
      util.showSnackBar("Alert", "something went wrong!", true);
    }
  }

// To create email with params
  final Uri _emailLaunchUri = Uri(
    scheme: 'mailto',
    path: 'pearllinedentocare@gmail.com',
    queryParameters: {'subject': "Dear doctor i have some need for root canal", 'body': "Hey Kashish here goes the body"},
  );

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarColor: MyColor.primarycolor,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.light,
          systemNavigationBarColor: Colors.transparent,
        ),
        child: Scaffold(
          body: SafeArea(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CustomAppBar(
                      title: 'Contact Us',
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    /// this is new correct code

                    Center(child:Text("Contact Us",style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),)),
                    Center(child:Text("If you have any questionwe\n         are happy to help",style: TextStyle(color: Colors.grey, fontSize: 16, fontWeight: FontWeight.w400),)),
                    SizedBox(
                      height: height*0.1,
                    ),
                    InkWell(
                        onTap: () {
                          // launch("tel://+919894742511");
                          launch("tel://+919790099950");
                        },
                        child: Image.asset("assets/newImages/contactphone.png",scale: 2,)),
                    Center(child:Text("+919790099950",style: TextStyle(color: Colors.grey, fontSize: 16, fontWeight: FontWeight.w400),)),
                    SizedBox(
                      height: height*0.04,
                    ),
                    InkWell(
                        onTap: () {
                          setState(() {
                            launch(_emailLaunchUri.toString());
                          });
                        },
                        child: Image.asset("assets/newImages/contactemail.png",scale: 2,)),
                    Center(child:Text("pearllinedentocare@gmail.com",style: TextStyle(color: Colors.grey, fontSize: 16, fontWeight: FontWeight.w400),)),
                    Spacer(),
                    Center(child:Text("Get Connected",style: TextStyle(color: Colors.grey, fontSize: 16, fontWeight: FontWeight.w400),)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () async {
                            const url = 'https://www.linkedin.com/company/yourcompany'; // Replace with your LinkedIn URL
                            if (await canLaunch(url)) {
                              await launch(url);
                            }
                          },
                          child: Image.asset("assets/newImages/contactlinden.png", scale: 1,),
                        ),
                        SizedBox(
                          width: width*0.04,
                        ),
                        InkWell(
                          onTap: () async {
                            const url = 'https://www.facebook.com/pearllinedentocare'; // Replace with your Facebook URL
                            if (await canLaunch(url)) {
                              await launch(url);
                            }
                          },
                          child: Image.asset("assets/newImages/contactfacebook.png", scale: 2,),
                        ),
                        SizedBox(
                          width: width*0.04,
                        ),
                        InkWell(
                          onTap: () async {
                            const url = 'X.com/pearlline'; // Replace with your Twitter URL
                            if (await canLaunch(url)) {
                              await launch(url);
                            }
                          },
                          child: Image.asset("assets/newImages/contactx.png", scale: 2,),
                        ),
                        SizedBox(
                          width: width*0.04,
                        ),
                        InkWell(
                          onTap: () async {
                            const url = 'https://www.instagram.com/Pearllinedentocare'; // Replace with your Instagram URL
                            if (await canLaunch(url)) {
                              await launch(url);
                            }
                          },
                          child: Image.asset("assets/newImages/instagram.png", scale: 2,),
                        ),
                        SizedBox(
                          width: width*0.04,
                        ),
                        InkWell(
                            onTap: () async {
                              final number = "+918010201080";
                              final message = "Hello Doc!!";
                              var url = 'https://wa.me/$number?text=$message';
                              if (await canLaunch(url)) {
                                await launch(url);
                              }
                            },
                            child: Image.asset("assets/newImages/contactwatshapp.png",scale: 2 ,)),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Divider(),
                    ),

                    // Padding(
                    //   padding: const EdgeInsets.only(
                    //       left: 16.0, right: 24.0, bottom: 8, top: 8),
                    //   child: Container(
                    //     height: 45.00,
                    //     decoration: BoxDecoration(
                    //         borderRadius: BorderRadius.circular(10),
                    //         border: Border.all(color: Colors.blue, width: 1)),
                    //     child: Center(
                    //         child: GestureDetector(
                    //       onTap: () {
                    //         setState(() {});
                    //       },
                    //       behavior: HitTestBehavior.opaque,
                    //       child: Padding(
                    //         padding: const EdgeInsets.all(8.0),
                    //         child: TextFormField(
                    //           controller: name,
                    //           decoration: InputDecoration.collapsed(
                    //               hintText: "Enter your name",
                    //               hintStyle: TextStyle(
                    //                   color: MyColor.LOGIN_TEXT_HINT_PASSWORD_COLOR),
                    //               border: InputBorder.none,
                    //               floatingLabelAlignment: FloatingLabelAlignment.start),
                    //           keyboardType: TextInputType.text,
                    //           autovalidateMode: AutovalidateMode.disabled,
                    //           onTap: () {
                    //             setState(() {});
                    //           },
                    //           onChanged: (phone) {},
                    //           textAlignVertical: TextAlignVertical.center,
                    //         ),
                    //       ),
                    //     )),
                    //   ),
                    // ),
                    // Padding(
                    //   padding: const EdgeInsets.only(
                    //       left: 16.0, right: 24.0, bottom: 8, top: 8),
                    //   child: Container(
                    //     height: 45.00,
                    //     decoration: BoxDecoration(
                    //         borderRadius: BorderRadius.circular(10),
                    //         border: Border.all(color: Colors.blue, width: 1)),
                    //     child: Center(
                    //         child: GestureDetector(
                    //       onTap: () {
                    //         setState(() {});
                    //       },
                    //       behavior: HitTestBehavior.opaque,
                    //       child: Padding(
                    //         padding: const EdgeInsets.all(8.0),
                    //         child: TextFormField(
                    //           controller: email,
                    //           decoration: InputDecoration.collapsed(
                    //               hintText: "Enter your email",
                    //               hintStyle: TextStyle(
                    //                   color: MyColor.LOGIN_TEXT_HINT_PASSWORD_COLOR),
                    //               border: InputBorder.none,
                    //               floatingLabelAlignment: FloatingLabelAlignment.start),
                    //           keyboardType: TextInputType.emailAddress,
                    //           autovalidateMode: AutovalidateMode.disabled,
                    //           onTap: () {
                    //             setState(() {});
                    //           },
                    //           onChanged: (phone) {},
                    //           textAlignVertical: TextAlignVertical.center,
                    //         ),
                    //       ),
                    //     )),
                    //   ),
                    // ),
                    // Padding(
                    //   padding: const EdgeInsets.only(
                    //       left: 16.0, right: 24.0, bottom: 8, top: 8),
                    //   child: Container(
                    //     height: 45.00,
                    //     decoration: BoxDecoration(
                    //         borderRadius: BorderRadius.circular(10),
                    //         border: Border.all(color: Colors.blue, width: 1)),
                    //     child: Center(
                    //         child: GestureDetector(
                    //       onTap: () {
                    //         setState(() {});
                    //       },
                    //       behavior: HitTestBehavior.opaque,
                    //       child: Padding(
                    //         padding: const EdgeInsets.all(8.0),
                    //         child: TextFormField(
                    //           controller: phone,
                    //           decoration: InputDecoration.collapsed(
                    //               hintText: "Enter your phone",
                    //               hintStyle: TextStyle(
                    //                   color: MyColor.LOGIN_TEXT_HINT_PASSWORD_COLOR),
                    //               border: InputBorder.none,
                    //               floatingLabelAlignment: FloatingLabelAlignment.start),
                    //           keyboardType: TextInputType.phone,
                    //           inputFormatters: [
                    //             LengthLimitingTextInputFormatter(10),
                    //           ],
                    //           autovalidateMode: AutovalidateMode.disabled,
                    //           onTap: () {
                    //             setState(() {});
                    //           },
                    //           onChanged: (phone) {},
                    //           textAlignVertical: TextAlignVertical.center,
                    //         ),
                    //       ),
                    //     )),
                    //   ),
                    // ),
                    // Padding(
                    //   padding: const EdgeInsets.only(
                    //       left: 16.0, right: 24.0, bottom: 8, top: 8),
                    //   child: Container(
                    //   //  height: 45.00,
                    //     decoration: BoxDecoration(
                    //         borderRadius: BorderRadius.circular(10),
                    //         border: Border.all(color: Colors.blue, width: 1)),
                    //     child: Center(
                    //         child: GestureDetector(
                    //       onTap: () {
                    //         setState(() {});
                    //       },
                    //       behavior: HitTestBehavior.opaque,
                    //       child: Padding(
                    //         padding: const EdgeInsets.all(8.0),
                    //         child: TextFormField(
                    //           controller: description,
                    //           maxLines: 3,
                    //           decoration: InputDecoration.collapsed(
                    //               hintText: "Enter your description",
                    //               hintStyle: TextStyle(
                    //                   color: MyColor.LOGIN_TEXT_HINT_PASSWORD_COLOR),
                    //               border: InputBorder.none,
                    //               floatingLabelAlignment: FloatingLabelAlignment.start),
                    //           keyboardType: TextInputType.text,
                    //           autovalidateMode: AutovalidateMode.disabled,
                    //           onTap: () {
                    //             setState(() {});
                    //           },
                    //           onChanged: (phone) {},
                    //           textAlignVertical: TextAlignVertical.center,
                    //         ),
                    //       ),
                    //     )),
                    //   ),
                    // ),
                    // SizedBox(
                    //   height: 20,
                    // ),
                    // Center(
                    //   child: Bounceable(
                    //     onTap: () {
                    //       if (name.text.isEmpty) {
                    //         util.showSnackBar("Alert", "Please enter name", false);
                    //       } else if (!GetUtils.isEmail(email.text) ||
                    //           email.text.isEmpty) {
                    //         util.showSnackBar(
                    //             "Alert", "Please enter valid email", false);
                    //       } else if (phone.text.isEmpty || phone.text.length < 10) {
                    //         util.showSnackBar(
                    //             "Alert", "Please enter valid phone no.", false);
                    //       } else if (description.text.isEmpty) {
                    //         util.showSnackBar(
                    //             "Alert", "Please enter description", false);
                    //       } else {
                    //         contact_post(
                    //             name.text, email.text, phone.text, description.text);
                    //       }
                    //     },
                    //     child: Container(
                    //       decoration: BoxDecoration(
                    //       color: MyColor.primarycolor,
                    //         borderRadius: BorderRadius.circular(20),
                    //       ),
                    //       margin: const EdgeInsets.all(8.00),
                    //       width: AppConstant.BUTTON_WIDTH,
                    //       height: AppConstant.BUTTON_HIGHT,
                    //       child: Center(
                    //         child: Text("Send",
                    //             style: GoogleFonts.nunitoSans(
                    //                 textStyle: Theme.of(context).textTheme.displayLarge,
                    //                 fontSize: AppConstant.MEDIUM_SIZE,
                    //                 fontWeight: FontWeight.w700,
                    //                 fontStyle: FontStyle.normal,
                    //                 color: Colors.white)),
                    //       ),
                    //     ),
                    //   ),
                    // )
                  ],
                ),
              )),
        ));
  }
}