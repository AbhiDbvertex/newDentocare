// import 'dart:async';
// import 'dart:convert';
// import 'dart:typed_data';
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/services.dart';
// import 'package:http/http.dart' as http;
// import 'package:double_back_to_close_app/double_back_to_close_app.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bounceable/flutter_bounceable.dart';
// import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:intl/intl.dart';
// import 'package:dentocoreauth/pages/chat/upload.dart';
// import 'package:dentocoreauth/utills/pdfsend.dart';
// import 'package:dentocoreauth/utils/app_constant.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../../controllers/user_controller.dart';
// import '../../models/chat_response_dto.dart' as myChatRes;
// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';
// import '../../Utills/Utills.dart';
// import '../../controllers/chat_controller.dart';
// import '../../utils/GetXNetworkManager.dart';
// import 'dart:io';
// import 'package:open_file/open_file.dart';
// import 'package:flutter_inappwebview_platform_interface/flutter_inappwebview_platform_interface.dart';
//
// import '../../utils/mycolor.dart';
// class Chat extends StatefulWidget {
//   var _username = "";
//
//   var _from = "";
//
//   Chat(String? userName, String from) {
//     this._username = userName ?? "";
//     this._from = from ?? "";
//   }
//
//   @override
//   State<Chat> createState() => _ChatState(_username, _from);
// }
//
// class _ChatState extends State<Chat> {
//   var _username = "";
//   var from = "";
//   late Map<String, String> _headers;
//
//   _ChatState(String userName, String from) {
//     _username = userName;
//     this.from = from ?? "";
//     _headers = {"x-api-key": "dentist@123"};
//   }
//
//   var loadingPercentage = 0;
//   var btnSize = 30.0;
//   late Animation<double> animation;
//   late AnimationController anim_controller;
//   var user_data = [];
//
//   late Map chat_map;
//   var chat_data = <myChatRes.chatBODY?>[];
//   var load_chat_status = false;
//   Timer? timer;
//   late Map send_msg_map;
//   var sender = "4";
//   var receiver = "8";
//   var pro_id = "1";
//   var offset = "0";
//   var user_img = "";
//   var cindex = 0;
//   var customid = "";
//   var userid = "";
//   var chaturl = "";
//   Uri? uri;
//   File? fimage1;
//   final _scaffoldKey = new GlobalKey<ScaffoldState>();
//   InAppWebViewController? _webViewController;
//
//   ScrollController _controller = new ScrollController(keepScrollOffset: false);
//
//   _scrollToBottom() {
//     _controller.jumpTo(_controller.position.maxScrollExtent);
//     WidgetsBinding.instance.addPostFrameCallback(
//         (_) => {_controller.jumpTo(_controller.position.maxScrollExtent)});
//   }
//
//   final network_controller = Get.put<GetXNetworkManager>(GetXNetworkManager());
//
//   final ChatController chatController = Get.find();
//   final UserController userController = Get.find();
//   var util = Utills();
//
//   ImagePicker picker = ImagePicker();
//
//   void _pickFile() async {
//     PDFsend pdFsend = new PDFsend();
//
//     //var dio=new Dio();
//     // opens storage to pick files and the picked file or files
//     // are assigned into result and if no file is chosen result is null.
//     // you can also toggle "allowMultiple" true or false depending on your need
//     // FilePickerResult? result = await FilePicker.platform.pickFiles(allowMultiple: false,type: FileType.custom, allowedExtensions: ['pdf'],withData: true,withReadStream: true,allowCompression: true);
//
//     // if no file is picked
//     //  if (result == null) return;
//     //
//     //  // we get the file from result object
//     //  final filee =await  result.files.first;
//     //
//     // File file=new File(result.files.single.path??"");
//     // String filename=file.path.split('/').last;
//     // String path=file.path;
//     // FormData formData=FormData({
//     //   'image':"await MultipartFile(path, filename: filename)",
//     //   "sender_id":"4",
//     //   "receiver_id":"1"
//     // });
//
//     //  var myres=await http.post(Uri.parse("https://work.dbvertex.com/dentist1/api/chatpdf"),headers: <String,String>{"x-api-key": "dentist@123"},body: formData);
//     //  if(myres.statusCode==200){
//     //    debugPrint("njtest1" + "200");
//     //  }else{
//     //    debugPrint("njtest1" + myres.statusCode.toString());
//     //  }
//     //
//
//     //_openFile(file);
//
//     //var myres=await http.post(Uri.parse("https://work.dbvertex.com/dentist1/api/chatpdf"),headers: <String,String>{"x-api-key": "dentist@123"},body: formData);
//     // if(myres.statusCode==200){
//     //   debugPrint("njtest1" + "200");
//     // }else{
//     //   debugPrint("njtest1" + myres.statusCode.toString());
//     // }
//
//     Get.back();
//   }
//
//   void _openFile(PlatformFile file) {
//     OpenFile.open(file.path);
//   }
//
//   Future<bool> _upload(PlatformFile file, String message, String receiver_id,
//       String sender_id) async {
//     debugPrint("njtest" + "called");
//     var request = http.MultipartRequest('post',
//         WebUri(AppConstant.BASE_URL + "/api/chat")); // your server url
//     request.fields.addAll({
//       "sender_id": sender_id,
//       "receiver_id": receiver_id,
//       "message": message,
//     }); // any other fields required by your server
//     debugPrint("njtest" + "");
//     request.files.add(await http.MultipartFile.fromPath(
//         'image', '${file.path}')); // file you want to upload
//     request.headers.addAll(_headers);
//     var response = await request.send();
//     if (response.statusCode == 200) {
//       debugPrint("njtest" + "200");
//       print(await response.stream.bytesToString());
//       return true;
//     } else {
//       debugPrint("njtest" + "afiled");
//       print(response.reasonPhrase);
//       return false;
//     }
//   }
//
//   Future sendPdf(PlatformFile pf) async {
//     debugPrint("njres" + "called");
//     debugPrint("njres" + pf.bytes.toString());
//
//     var request = http.MultipartRequest(
//         'POST',
//         WebUri(
//           AppConstant.BASE_URL + "/api/chat",
//         ));
//     request.fields['sender_id'] = '4';
//     request.fields['receiver_id'] = '1';
//     request.fields['message'] = 'sdfds';
//     request!.headers!.addAll(_headers);
//     Uint8List? fileBytes = pf.bytes;
//     String fileName = pf.name;
//     var pdf =
//         http.MultipartFile.fromBytes("image", fileBytes!, filename: fileName);
//     request.files.add(pdf);
//     var res = await request.send();
//
//     var fres = await res.stream.toBytes();
//     var f_res = String.fromCharCodes(fres);
//     debugPrint("njres" + f_res);
//
//     if (res.statusCode == 200 || res.statusCode == 201) {
//       debugPrint("njres" + "200");
//     } else if (res.statusCode == 400) {
//       debugPrint("njres" + "400");
//     } else {
//       debugPrint("njres" + "failed");
//     }
//   }
//
//   Future getImage(
//     ImageSource img,
//   ) async {
//     final pickedFile = await picker.pickImage(
//         source: img, maxHeight: 480, maxWidth: 640, imageQuality: 50);
//
//     XFile? xfilePick = pickedFile;
//     setState(
//       () {
//         if (xfilePick != null) {
//           setState(() {
//             chatController.fimage1 = File(pickedFile!.path);
//             Get.defaultDialog(
//               title: "Alert",
//               middleText: "Do you really want to send this picture?",
//               backgroundColor: Color.fromRGBO(153, 171, 224, 1),
//               titleStyle: TextStyle(color: Colors.white),
//               middleTextStyle: TextStyle(color: Colors.white),
//               textConfirm: "Confirm",
//               textCancel: "Cancel",
//               onConfirm: () {
//                 chatController
//                     .sendChat("${userid}", "1", chatController.fimage1)
//                     .then((value) => Get.back());
//               },
//               onCancel: () {
//                 chatController.fimage1 = null;
//                 Get.back();
//               },
//               cancelTextColor: Colors.white,
//               confirmTextColor: Colors.white,
//               buttonColor: Colors.red,
//
//               barrierDismissible: false,
//               radius: 10,
//             );
//             //
//           });
//         } else {
//           ScaffoldMessenger.of(context).showSnackBar(// is this context <<<
//               const SnackBar(content: Text('Nothing is selected')));
//         }
//       },
//     );
//   }
//
//   void getUserData(key) async {
//     final sp = await SharedPreferences.getInstance();
//     setState(() {
//       user_data = sp.getStringList(key)!;
//       userid = user_data[0].toString();
//       customid = userid;
//       debugPrint("myidchat${userid}" + userid);
//       debugPrint("myidchat" + customid);
//       uri = WebUri(chaturl);
//       getCurrentTime;
//       chatController.updateChatStatus(userid).then((value) => {
//             debugPrint("chatupdated" + "true"),
//             userController.readStatus.value = true,
//           });
//
//       //  util.showSnackBar("Alert", userid.toString(), true);
//     });
//
//     //  util.showSnackBar("Alert", chaturl, true);
//     //chatController.getChat("${userid}", "1");
//     //_scrollToBottom();
//     // timer = new Timer.periodic(Duration(seconds: 2), (timer) {
//     //   call_api();
//     // });
//
//     //call_api();
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//     timer!.cancel();
//
//     chatController.dispose();
//   }
//
//   getdata() {
//     StreamBuilder(
//       stream: Stream.periodic(Duration(seconds: 5))
//           .asyncMap((i) => chatController.getChat("45", "1")),
//       // i is null here (check periodic docs)
//       builder: (context, snapshot) => Text(snapshot.data
//           .toString()), // builder should also handle the case when data is not fetched yet
//     );
//   }
//
//   call_api() {
//     if (userid.toString() != "") {
//       chatController.getChat("${userid}}", "1").then((value) => {
//             //chat_data = value!.data,
//             //chatController.sender_id = userid,
//           });
//     }
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     getUserData("user_data");
//   }
//
//   getCurrentTime() {
//     String cdate = DateFormat("yyyy-MM-dd").format(DateTime.now());
//     debugPrint("testdate" + cdate);
//   }
//
//   Dialog errorDialog(BuildContext context) {
//     return Dialog(
//         shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(12.0)), //this right here
//         child: Container(
//           height: MediaQuery.of(context).size.height / 3,
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
//               Padding(padding: EdgeInsets.only(top: 20.0)),
//               TextButton(
//                   onPressed: () {
//                     Navigator.of(context).pop();
//                   },
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
//                       SizedBox(
//                         width: 10,
//                       ),
//                       MaterialButton(
//                         onPressed: () async {
//                           Get.back();
//                           PDFsend pdf = new PDFsend();
//
//                           await pdf.uploadPDF(userid).then((value) => {});
//                         },
//                         child: Text("Select PDF"),
//                         color: Colors.blue,
//                       ),
//                     ],
//                   ))
//             ],
//           ),
//         ));
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return AnnotatedRegion<SystemUiOverlayStyle>(
//         value: SystemUiOverlayStyle(
//           statusBarColor: Colors.transparent,
//           statusBarIconBrightness: Brightness.light,
//           statusBarBrightness: Brightness.light,
//           systemNavigationBarColor: Colors.transparent,
//         ),
//         child: Obx(() => chatController.load_status == true
//         ? Center(
//             child: Center(
//             child: Text("No chat found!"),
//           ))
//         : Scaffold(
//             key: _scaffoldKey,
//             body: DoubleBackToCloseApp(
//               snackBar: SnackBar(content: Text("Double tap to exit")),
//               child: Scrollbar(
//                 thumbVisibility: true,
//                 trackVisibility: true,
//                 child: GetBuilder<GetXNetworkManager>(
//                   builder: (builder) => network_controller.connectionType == 0
//                       ? Center(
//                           child: Text("No network found!!"),
//                         )
//                       : GestureDetector(
//                           onTap: () {
//                             FocusManager.instance.primaryFocus?.unfocus();
//                           },
//                           behavior: HitTestBehavior.opaque,
//                           child: SafeArea(
//                               child: Container(
//                             child: Center(
//                               child: Container(
//                                 child: Column(
//                                   mainAxisAlignment: MainAxisAlignment.start,
//                                   children: [
//                                     Align(
//                                       alignment: Alignment.centerLeft,
//                                       child: Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.spaceBetween,
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.center,
//                                         children: [
//                                           Visibility(
//                                             visible: this.from == "from_home"
//                                                 ? true
//                                                 : false,
//                                             maintainSize: true,
//                                             maintainState: true,
//                                             maintainSemantics: true,
//                                             maintainAnimation: true,
//                                             child: Container(
//                                               width: MediaQuery.of(context)
//                                                       .size
//                                                       .width /
//                                                   5,
//                                               alignment: Alignment.centerLeft,
//                                               child: Padding(
//                                                 padding:
//                                                     EdgeInsets.only(top: 10),
//                                                 child: Bounceable(
//                                                   onTap: () {
//                                                     Get.back();
//                                                   },
//                                                   child: Container(
//                                                     width: 70,
//                                                     height: 40,
//                                                     decoration: BoxDecoration(
//                                                       color: Colors.white,
//                                                       borderRadius:
//                                                           BorderRadius.only(
//                                                               topRight: Radius
//                                                                   .circular(30),
//                                                               bottomRight:
//                                                                   Radius
//                                                                       .circular(
//                                                                           30)),
//                                                       boxShadow: [
//                                                         BoxShadow(
//                                                           color: Colors.grey
//                                                               .withOpacity(0.5),
//                                                           spreadRadius: 1,
//                                                           blurRadius: 2,
//                                                           offset: Offset(0,
//                                                               3), // changes position of shadow
//                                                         ),
//                                                       ],
//                                                     ),
//                                                     child: Container(
//                                                       decoration: BoxDecoration(
//                                                           borderRadius:
//                                                               BorderRadius.only(
//                                                                   topRight: Radius
//                                                                       .circular(
//                                                                           30),
//                                                                   bottomRight:
//                                                                       Radius.circular(
//                                                                           30)),
//                                                           gradient: AppConstant
//                                                               .BUTTON_COLOR),
//                                                       child: Image.asset(
//                                                         'assets/images/back_icon.png',
//                                                         width: 10,
//                                                         height: 10,
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//
//                                           Row(
//                                             children: [
//                                               Padding(
//                                                 padding: const EdgeInsets.all(8.0),
//                                                 child: Container(
//                                                   height: 40,
//                                                   decoration: BoxDecoration(
//                                                       borderRadius:
//                                                       BorderRadius.circular(40),
//                                                       border: Border.all(
//                                                           color: Colors.transparent,
//                                                           width: 1)),
//                                                   child: Align(
//                                                     alignment:
//                                                     Alignment.bottomCenter,
//                                                     child: Image.asset(
//                                                       "assets/newImages/applogo.png",
//                                                       scale: 1,
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ),
//                                               Padding(
//                                                 padding: const EdgeInsets.only(
//                                                     top: 0.0),
//                                                 child: Container(
//                                                   child: AppConstant.HEADLINE_TEXT(
//                                                       "Doctor", context),
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//
//
//
//                                           Padding(
//                                             padding: const EdgeInsets.all(8.0),
//                                             child: Align(
//                                               alignment: Alignment.centerRight,
//                                               child: Container(
//                                                 height: 40,
//                                                 decoration: BoxDecoration(
//                                                     borderRadius:
//                                                     BorderRadius.circular(40),
//                                                     border: Border.all(
//                                                         color: Colors.transparent,
//                                                         width: 1)),
//                                                 child:  MaterialButton(
//                                                   child: Icon(Icons.refresh),
//                                                   onPressed: () {
//                                                     setState(() {
//                                                       if (_webViewController != null) {
//                                                         _webViewController!.reload();
//                                                       }
//                                                     });
//
//                                                   },
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//
//                                         ],
//                                       ),
//                                     ),
//                                     Expanded(
//                                       child: Container(
//                                         decoration: BoxDecoration(
//                                             borderRadius:
//                                                 BorderRadius.circular(10),
//                                             border: Border.all(
//                                                 color: Colors.grey, width: 0)),
//                                         child: Column(
//                                           children: [
//                                             Expanded(
//                                               child: Container(
//                                                   child: chatController
//                                                               .chats.length !=
//                                                           0
//                                                       ? Center(
//                                                           child: Text(
//                                                               "No chat found!"),
//                                                         )
//                                                       : RefreshIndicator(
//                                                           onRefresh:
//                                                               () async {},
//                                                           child: InAppWebView(
//                                                             key: UniqueKey(),
//                                                             initialUrlRequest:
//                                                                 URLRequest(
//                                                                     url: WebUri(
//                                                                         "https://work.dbvertex.com/dentist1/admin/chats/$customid/1"),
//                                                                     headers:
//                                                                         _headers),
//                                                             initialOptions:
//                                                                 InAppWebViewGroupOptions(
//                                                                     crossPlatform:
//                                                                         InAppWebViewOptions(
//                                                               javaScriptEnabled:
//                                                                   true,
//                                                               verticalScrollBarEnabled:
//                                                                   true,
//                                                               supportZoom:
//                                                                   false,
//                                                                             javaScriptCanOpenWindowsAutomatically: true
//                                                             ), android: AndroidInAppWebViewOptions(
//                                                                   // on Android you need to set supportMultipleWindows to true,
//                                                                   // otherwise the onCreateWindow event won't be called
//                                                                     supportMultipleWindows: false,
//
//                                                                 )),
//                                                             onWebViewCreated:
//                                                                 (InAppWebViewController
//                                                                     controller) {
//                                                               _webViewController =
//                                                                   controller;
//                                                             },
//                                                           ),
//                                                         )),
//                                             ),
//                                             //text msg
//                                             Padding(
//                                               padding:
//                                                   const EdgeInsets.all(20.0),
//                                               child: Container(
//                                                 height: 60,
//                                                 decoration: BoxDecoration(
//                                                   border: Border.all(
//                                                       color: Colors.grey,
//                                                       width: 2),
//                                                   borderRadius:
//                                                       BorderRadius.circular(30),
//                                                 ),
//                                                 child: Row(
//                                                   children: [
//                                                     Expanded(
//                                                       child: Padding(
//                                                         padding:
//                                                             const EdgeInsets
//                                                                     .only(
//                                                                 left: 4.0,
//                                                                 right: 4.0),
//                                                         child: Padding(
//                                                           padding:
//                                                               const EdgeInsets
//                                                                   .all(8.0),
//                                                           child: TextField(
//                                                               controller:
//                                                                   chatController
//                                                                       .chatTxt,
//                                                               decoration: new InputDecoration
//                                                                       .collapsed(
//                                                                   hintText:
//                                                                       "Type Message.."),
//                                                               style: GoogleFonts
//                                                                   .inter(
//                                                                       color: Colors
//                                                                           .black,
//                                                                       fontSize:
//                                                                           14.00)),
//                                                         ),
//                                                       ),
//                                                     ),
//                                                     InkWell(
//                                                       onTap: () {},
//                                                       child: Row(
//                                                         children: [
//                                                           Padding(
//                                                             padding:
//                                                                 const EdgeInsets
//                                                                         .only(
//                                                                     top: 8.0),
//                                                             child: SizedBox(
//                                                                 width: 38,
//                                                                 height: 38,
//                                                                 child: InkWell(
//                                                                     onTap: () {
//                                                                       showDialog(
//                                                                           context:
//                                                                               context,
//                                                                           builder: (BuildContext context) =>
//                                                                               errorDialog(context));
//                                                                     },
//                                                                     child: Icon(
//                                                                         Icons
//                                                                             .attachment_rounded))),
//                                                           ),
//                                                           Padding(
//                                                               padding:
//                                                                   const EdgeInsets
//                                                                           .only(
//                                                                       right:
//                                                                           8.0),
//                                                               child: SizedBox(
//                                                                 width: 34,
//                                                                 height: 34,
//                                                                 child: InkWell(
//                                                                   onTap: () {
//                                                                     if (chatController
//                                                                         .chatTxt
//                                                                         .text
//                                                                         .isEmpty) {
//                                                                       util.showSnackBar(
//                                                                           "Alert",
//                                                                           "Please enter message",
//                                                                           false);
//                                                                     } else {
//                                                                       chatController
//                                                                           .sendChat(
//                                                                         "${userid}",
//                                                                         "1",
//                                                                       );
//                                                                     }
//                                                                   },
//                                                                   child: Image
//                                                                       .asset(
//                                                                     "assets/images/send_chat.png",
//                                                                   ),
//                                                                 ),
//                                                               )),
//                                                         ],
//                                                       ),
//                                                     ),
//                                                   ],
//                                                 ),
//                                               ),
//                                             )
//                                           ],
//                                         ),
//                                       ),
//                                     )
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           )),
//                         ),
//                 ),
//               ),
//             ),
//           )));
//   }
// }

import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:dentocoreauth/pages/chat/upload.dart';
import 'package:dentocoreauth/utills/pdfsend.dart';
import 'package:dentocoreauth/utils/app_constant.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../controllers/user_controller.dart';
import '../../models/chat_response_dto.dart' as myChatRes;
import 'dart:io';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import '../../Utills/Utills.dart';
import '../../controllers/chat_controller.dart';
import '../../utils/GetXNetworkManager.dart';
import 'package:open_file/open_file.dart';
import '../../utils/mycolor.dart';

class Chat extends StatefulWidget {
  var _username = "";
  var _from = "";

  Chat(String? userName, String from) {
    this._username = userName ?? "";
    this._from = from ?? "";
  }

  @override
  State<Chat> createState() => _ChatState(_username, _from);
}

class _ChatState extends State<Chat> {
  var _username = "";
  var from = "";
  late Map<String, String> _headers;

  _ChatState(String userName, String from) {
    _username = userName;
    this.from = from ?? "";
    _headers = {"x-api-key": "dentist@123"};
  }

  var loadingPercentage = 0;
  var btnSize = 30.0;
  var user_data = [];
  late Map chat_map;
  var chat_data = <myChatRes.chatBODY?>[];
  var load_chat_status = false;
  Timer? timer;
  late Map send_msg_map;
  var sender = "4";
  var receiver = "8";
  var pro_id = "1";
  var offset = "0";
  var user_img = "";
  var cindex = 0;
  var customid = "";
  var userid = "";
  var chaturl = "";
  Uri? uri;
  File? fimage1;
  final _scaffoldKey = new GlobalKey<ScaffoldState>();
  InAppWebViewController? _webViewController;

  ScrollController _controller = new ScrollController(keepScrollOffset: false);

  _scrollToBottom() {
    _controller.jumpTo(_controller.position.maxScrollExtent);
    WidgetsBinding.instance.addPostFrameCallback(
            (_) => {_controller.jumpTo(_controller.position.maxScrollExtent)});
  }

  final network_controller = Get.put<GetXNetworkManager>(GetXNetworkManager());
  final ChatController chatController = Get.find();
  final UserController userController = Get.find();
  var util = Utills();

  ImagePicker picker = ImagePicker();

  void _pickFile() async {
    PDFsend pdFsend = new PDFsend();
    Get.back();
  }

  void _openFile(PlatformFile file) {
    OpenFile.open(file.path);
  }

  Future<bool> _upload(PlatformFile file, String message, String receiver_id,
      String sender_id) async {
    debugPrint("njtest" + "called");
    var request = http.MultipartRequest(
        'post', WebUri(AppConstant.BASE_URL + "/api/chat"));
    request.fields.addAll({
      "sender_id": sender_id,
      "receiver_id": receiver_id,
      "message": message,
    });
    debugPrint("njtest" + "");
    request.files.add(await http.MultipartFile.fromPath('image', '${file.path}'));
    request.headers.addAll(_headers);
    var response = await request.send();
    if (response.statusCode == 200) {
      debugPrint("njtest" + "200");
      print(await response.stream.bytesToString());
      return true;
    } else {
      debugPrint("njtest" + "afiled");
      print(response.reasonPhrase);
      return false;
    }
  }

  Future sendPdf(PlatformFile pf) async {
    debugPrint("njres" + "called");
    debugPrint("njres" + pf.bytes.toString());

    var request = http.MultipartRequest(
        'POST', WebUri(AppConstant.BASE_URL + "/api/chat"));
    request.fields['sender_id'] = '4';
    request.fields['receiver_id'] = '1';
    request.fields['message'] = 'sdfds';
    request!.headers!.addAll(_headers);
    Uint8List? fileBytes = pf.bytes;
    String fileName = pf.name;
    var pdf =
    http.MultipartFile.fromBytes("image", fileBytes!, filename: fileName);
    request.files.add(pdf);
    var res = await request.send();

    var fres = await res.stream.toBytes();
    var f_res = String.fromCharCodes(fres);
    debugPrint("njres" + f_res);

    if (res.statusCode == 200 || res.statusCode == 201) {
      debugPrint("njres" + "200");
    } else if (res.statusCode == 400) {
      debugPrint("njres" + "400");
    } else {
      debugPrint("njres" + "failed");
    }
  }

  Future getImage(ImageSource img) async {
    final pickedFile = await picker.pickImage(
        source: img, maxHeight: 480, maxWidth: 640, imageQuality: 50);

    XFile? xfilePick = pickedFile;
    setState(() {
      if (xfilePick != null) {
        chatController.fimage1 = File(pickedFile!.path);
        Get.defaultDialog(
          title: "Alert",
          middleText: "Do you really want to send this picture?",
          backgroundColor: Color.fromRGBO(153, 171, 224, 1),
          titleStyle: TextStyle(color: Colors.white),
          middleTextStyle: TextStyle(color: Colors.white),
          textConfirm: "Confirm",
          textCancel: "Cancel",
          onConfirm: () {
            chatController
                .sendChat("${userid}", "1", chatController.fimage1)
                .then((value) => {
              Get.back(),
              _webViewController?.evaluateJavascript(
                  source:
                  "window.location.reload()") // Refresh WebView after sending
            });
          },
          onCancel: () {
            chatController.fimage1 = null;
            Get.back();
          },
          cancelTextColor: Colors.white,
          confirmTextColor: Colors.white,
          buttonColor: Colors.red,
          barrierDismissible: false,
          radius: 10,
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Nothing is selected')));
      }
    });
  }

  void getUserData(key) async {
    final sp = await SharedPreferences.getInstance();
    setState(() {
      user_data = sp.getStringList(key)!;
      userid = user_data[0].toString();
      customid = userid;
      debugPrint("myidchat${userid}" + userid);
      debugPrint("myidchat" + customid);
      uri = WebUri(chaturl);
      getCurrentTime;
      chatController.updateChatStatus(userid).then((value) => {
        debugPrint("chatupdated" + "true"),
        userController.readStatus.value = true,
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    timer?.cancel();
    chatController.dispose();
  }

  getdata() {
    StreamBuilder(
      stream: Stream.periodic(Duration(seconds: 5))
          .asyncMap((i) => chatController.getChat("45", "1")),
      builder: (context, snapshot) =>
          Text(snapshot.data.toString()),
    );
  }

  call_api() {
    if (userid.toString() != "") {
      chatController.getChat("${userid}", "1").then((value) => {});
    }
  }

  @override
  void initState() {
    super.initState();
    getUserData("user_data");
  }

  getCurrentTime() {
    String cdate = DateFormat("yyyy-MM-dd").format(DateTime.now());
    debugPrint("testdate" + cdate);
  }

  Dialog errorDialog(BuildContext context) {
    return Dialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0)),
        child: Container(
          height: MediaQuery.of(context).size.height / 3,
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
              Padding(padding: EdgeInsets.only(top: 20.0)),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MaterialButton(
                        onPressed: () {
                          Get.back();
                          getImage(ImageSource.camera);
                        },
                        child: Text("CAMERA"),
                        color: Colors.blue,
                      ),
                      SizedBox(width: 10),
                      MaterialButton(
                        onPressed: () {
                          Get.back();
                          getImage(ImageSource.gallery);
                        },
                        child: Text("GALLERY"),
                        color: Colors.blue,
                      ),
                      SizedBox(width: 10),
                      MaterialButton(
                        onPressed: () async {
                          Get.back();
                          PDFsend pdf = new PDFsend();
                          await pdf.uploadPDF(userid).then((value) => {});
                        },
                        child: Text("Select PDF"),
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
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.light,
          systemNavigationBarColor: Colors.transparent,
        ),
        child: Obx(() => chatController.load_status == true
            ? Center(child: Text("No chat found!"))
            : Scaffold(
            key: _scaffoldKey,
            body: DoubleBackToCloseApp(
              snackBar: SnackBar(content: Text("Double tap to exit")),
              child: Scrollbar(
                thumbVisibility: true,
                trackVisibility: true,
                child: GetBuilder<GetXNetworkManager>(
                  builder: (builder) => network_controller.connectionType == 0
                      ? Center(child: Text("No network found!!"))
                      : GestureDetector(
                    onTap: () {
                      FocusManager.instance.primaryFocus?.unfocus();
                    },
                    behavior: HitTestBehavior.opaque,
                    child: SafeArea(
                        child: Container(
                          child: Center(
                            child: Container(
                              child: Column(
                                mainAxisAlignment:
                                MainAxisAlignment.start,
                                children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                      children: [
                                        // Visibility(
                                        //   visible: this.from == "from_home"
                                        //       ? true
                                        //       : true,
                                        //   maintainSize: true,
                                        //   maintainState: true,
                                        //   maintainSemantics: true,
                                        //   maintainAnimation: true,
                                        //   child: Container(
                                        //     width: MediaQuery.of(context)
                                        //         .size
                                        //         .width /
                                        //         5,
                                        //     alignment:
                                        //     Alignment.centerLeft,
                                        //     child: Padding(
                                        //       padding:
                                        //       EdgeInsets.only(top: 10),
                                        //       child: Bounceable(
                                        //         onTap: () {
                                        //           Get.back();
                                        //         },
                                        //         child: Container(
                                        //           width: 70,
                                        //           height: 40,
                                        //           decoration: BoxDecoration(
                                        //             color: Colors.white,
                                        //             borderRadius:
                                        //             BorderRadius.only(
                                        //                 topRight:
                                        //                 Radius
                                        //                     .circular(
                                        //                     30),
                                        //                 bottomRight:
                                        //                 Radius
                                        //                     .circular(
                                        //                     30)),
                                        //             boxShadow: [
                                        //               BoxShadow(
                                        //                 color: Colors.grey
                                        //                     .withOpacity(
                                        //                     0.5),
                                        //                 spreadRadius: 1,
                                        //                 blurRadius: 2,
                                        //                 offset: Offset(0,
                                        //                     3),
                                        //               ),
                                        //             ],
                                        //           ),
                                        //           child: Container(
                                        //             decoration: BoxDecoration(
                                        //                 borderRadius:
                                        //                 BorderRadius
                                        //                     .only(
                                        //                     topRight:
                                        //                     Radius.circular(30),
                                        //                     bottomRight: Radius.circular(30)),
                                        //                 gradient:
                                        //                 AppConstant
                                        //                     .BUTTON_COLOR),
                                        //             child: Image.asset(
                                        //               'assets/images/back_icon.png',
                                        //               width: 10,
                                        //               height: 10,
                                        //             ),
                                        //           ),
                                        //         ),
                                        //       ),
                                        //     ),
                                        //   ),
                                        // ),
                                        Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(10.0),
                                              child: InkWell(
                                                onTap: (){
                                                  Get.back();
                                                },
                                                  child: Icon(Icons.arrow_back_ios_new)),
                                            ),
                                            Padding(
                                              padding:
                                              const EdgeInsets.all(
                                                  8.0),
                                              child: Container(
                                                height: 40,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                    BorderRadius
                                                        .circular(40),
                                                    border: Border.all(
                                                        color: Colors
                                                            .transparent,
                                                        width: 1)),
                                                child: Align(
                                                  alignment: Alignment
                                                      .bottomCenter,
                                                  child: Image.asset(
                                                    "assets/newImages/applogo.png",
                                                    scale: 1,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                              const EdgeInsets.only(
                                                  top: 0.0),
                                              child: Container(
                                                child: AppConstant
                                                    .HEADLINE_TEXT(
                                                    "Doctor",
                                                    context),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding:
                                          const EdgeInsets.all(8.0),
                                          child: Align(
                                            alignment:
                                            Alignment.centerRight,
                                            child: Container(
                                              height: 40,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                  BorderRadius
                                                      .circular(40),
                                                  border: Border.all(
                                                      color: Colors
                                                          .transparent,
                                                      width: 1)),
                                              child: MaterialButton(
                                                child: Icon(Icons.refresh),
                                                onPressed: () {
                                                  _webViewController
                                                      ?.reload();
                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.circular(10),
                                          border: Border.all(
                                              color: Colors.grey,
                                              width: 0)),
                                      child: Column(
                                        children: [
                                          Expanded(
                                            child: Container(
                                                child: InAppWebView(
                                                  key: ValueKey(customid),
                                                  initialUrlRequest:
                                                  URLRequest(
                                                      url: WebUri(
                                                          "https://work.dbvertex.com/dentist1/admin/chats/$customid/1"),
                                                      headers: _headers),
                                                  initialOptions:
                                                  InAppWebViewGroupOptions(
                                                      crossPlatform:
                                                      InAppWebViewOptions(
                                                        javaScriptEnabled:
                                                        true,
                                                        verticalScrollBarEnabled:
                                                        true,
                                                        supportZoom: false,
                                                        javaScriptCanOpenWindowsAutomatically:
                                                        true,
                                                      ),
                                                      android:
                                                      AndroidInAppWebViewOptions(
                                                        supportMultipleWindows:
                                                        false,
                                                      )),
                                                  onWebViewCreated:
                                                      (InAppWebViewController
                                                  controller) {
                                                    _webViewController =
                                                        controller;
                                                  },
                                                  onLoadStart: (controller,
                                                      url) {
                                                    setState(() {
                                                      loadingPercentage = 0;
                                                    });
                                                  },
                                                  onLoadStop: (controller,
                                                      url) {
                                                    setState(() {
                                                      loadingPercentage = 100;
                                                    });
                                                  },
                                                  onProgressChanged:
                                                      (controller,
                                                      progress) {
                                                    setState(() {
                                                      loadingPercentage =
                                                          progress;
                                                    });
                                                  },
                                                )),
                                          ),
                                          if (loadingPercentage < 100)
                                            LinearProgressIndicator(
                                              value:
                                              loadingPercentage / 100.0,
                                            ),
                                          Padding(
                                            padding:
                                            const EdgeInsets.all(20.0),
                                            child: Container(
                                              height: 60,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.grey,
                                                    width: 2),
                                                borderRadius:
                                                BorderRadius.circular(
                                                    30),
                                              ),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    child: Padding(
                                                      padding:
                                                      const EdgeInsets
                                                          .only(
                                                          left: 4.0,
                                                          right: 4.0),
                                                      child: Padding(
                                                        padding:
                                                        const EdgeInsets
                                                            .all(8.0),
                                                        child: TextField(
                                                            inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r"^[a-z 0-9,.@!?&%A-Z\s]+$"))],
                                                            controller:
                                                            chatController
                                                                .chatTxt,
                                                            decoration: InputDecoration
                                                                .collapsed(
                                                                hintText:
                                                                "Type Message.."),
                                                            style: GoogleFonts
                                                                .inter(
                                                                color:
                                                                Colors.black,
                                                                fontSize:
                                                                14.00)),
                                                      ),
                                                    ),
                                                  ),
                                                  InkWell(
                                                    onTap: () {},
                                                    child: Row(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                          const EdgeInsets
                                                              .only(
                                                              top:
                                                              8.0),
                                                          child: SizedBox(
                                                              width: 38,
                                                              height: 38,
                                                              child: InkWell(
                                                                  onTap:
                                                                      () {
                                                                    showDialog(
                                                                        context: context,
                                                                        builder: (BuildContext context) => errorDialog(context));
                                                                  },
                                                                  child: Icon(Icons
                                                                      .attachment_rounded))),
                                                        ),
                                                        Padding(
                                                            padding: const EdgeInsets
                                                                .only(
                                                                right:
                                                                8.0),
                                                            child: SizedBox(
                                                              width: 34,
                                                              height: 34,
                                                              child: InkWell(
                                                                onTap: () {
                                                                  if (chatController
                                                                      .chatTxt
                                                                      .text
                                                                      .isEmpty) {
                                                                    util.showSnackBar(
                                                                        "Alert",
                                                                        "Please enter message",
                                                                        false);
                                                                  } else {
                                                                    chatController
                                                                        .sendChat(
                                                                      "${userid}",
                                                                      "1",
                                                                    ).then((value) => {
                                                                      chatController
                                                                          .chatTxt
                                                                          .clear(),
                                                                      _webViewController?.evaluateJavascript(source: "window.location.reload()")
                                                                    });
                                                                  }
                                                                },
                                                                child: Image
                                                                    .asset(
                                                                  "assets/images/send_chat.png",
                                                                ),
                                                              ),
                                                            )),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        )),
                  ),
                ),
              ),
            ))));
  }
}
