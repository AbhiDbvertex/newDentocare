import 'dart:io';

import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:dentocoreauth/Utills/Utills.dart';
import 'package:dentocoreauth/controllers/post_controller.dart';
import 'package:dentocoreauth/controllers/post_controller.dart';
import 'package:dentocoreauth/pages/book_slot/book_slot.dart';
import 'package:dentocoreauth/pages/homepage/MyHomePage.dart';
import 'package:dentocoreauth/utils/app_constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Post extends StatefulWidget {
  const Post({Key? key}) : super(key: key);

  @override
  State<Post> createState() => _PostState();
}

class _PostState extends State<Post> {
  var _selected_date = "";
  var _selected_time = "";

  var selected_mon = "";
  var selected_day = "";
  List<File> selectedImages = [];
  var selected_year = "";

  final picker = ImagePicker();

  var postController = Get.put(PostController());

  final util = Utills();

  String? _hour, _minute, _time;

  String? dateTime;

  var user_data = [];
  var load_status = false;
  var userid = "";

  DateTime selectedDate = DateTime.now();

  TimeOfDay selectedTime = const TimeOfDay(hour: 00, minute: 00);

  Future getImages() async {
    final pickedFile = await picker.pickMultiImage(
        imageQuality: 70, maxHeight: 700, maxWidth: 700);
    List<XFile> xfilePick = pickedFile;

    setState(
      () {
        if (xfilePick.isNotEmpty) {
          //util.showSnackBar("A;ert", postController.selectedImages.length.toString(), true);

          if (xfilePick.length > 4 ||
              selectedImages.length > 3) {
            util.showSnackBar("Alert", "Max limit(4) reached*", false);
          } else {
            if (selectedImages.length < 3) {
              for (var i = 0; i < xfilePick.length; i++) {
                selectedImages.add(File(xfilePick[i].path));
              }
            } else {
              util.showSnackBar("Alert", "Max limit(4) reached*", false);
            }
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Nothing is selected')));
        }

        if(selectedImages.length==5){
          selectedImages.removeLast();
        }
      },
    );
  }

  @override
  void dispose() {
    super.dispose();

    if (EasyLoading.isShow) {
      EasyLoading.dismiss();
    }
    postController.dispose();
  }

  // Future<void> _selectDate(BuildContext context) async {
  //   final DateTime? picked = await showDatePicker(
  //       context: context,
  //       initialDate: selectedDate,
  //       initialDatePickerMode: DatePickerMode.day,
  //       firstDate: DateTime(2015),
  //       lastDate: DateTime(2101));
  //   if (picked != null)
  //     setState(() {
  //       selectedDate = picked;
  //       postController.date.text = DateFormat.yMd().format(selectedDate);
  //       _selected_date = DateFormat.yMd().format(selectedDate);
  //       util.showSnackBar("Alert", _selected_date.toString(), true);
  //     });
  // }

  // Future<void> _selectTime(BuildContext context) async {
  //   final TimeOfDay? picked = await showTimePicker(
  //     context: context,
  //     initialTime: selectedTime,
  //   );
  //   if (picked != null)
  //     setState(() {
  //       selectedTime = picked;
  //       _hour = selectedTime.hour.toString();
  //       _minute = selectedTime.minute.toString();
  //       _time = _hour! + ' : ' + _minute!;
  //       postController.time.text = _time!;
  //       // _timeController.text = formatDate(
  //       //     DateTime(2019, 08, 1, selectedTime.hour, selectedTime.minute),
  //       //     [hh, ':', nn, " ", am]).toString();
  //     });
  // }

  void getUserData(key) async {
    final sp = await SharedPreferences.getInstance();
    setState(() {
      user_data = sp.getStringList(key)!;
      load_status = true;
      userid = user_data[0].toString();
      Future.delayed(Duration(milliseconds: 200), () {});
      //  util.showSnackBar("Alert", userid.toString(), true);
    });
  }

  @override
  void initState() {
    super.initState();
    getUserData("user_data");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DoubleBackToCloseApp(
        snackBar: SnackBar(content: Text("Double tap to exit")),
        child: SingleChildScrollView(
          child: SafeArea(
            child: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xff0faac0),Color(0xff0faac0),Color(0xff0faac0), Color.fromRGBO(0, 127, 146, 1), Color(0x7affffff)],
              )),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      margin: EdgeInsets.only(top: 36),
                      child: Center(
                        child: Text("Select Date",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            )),
                      )),
                  InkWell(
                    onTap: () {
                      // _selectDate(context);
                      // Get.to(/*Book_Slot()*/);
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: 10, left: 40, right: 40),
                      height: 100,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border:
                              Border.all(color: Colors.transparent, width: 0)),
                      child: Center(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                CircleAvatar(
                                  radius: 30,
                                  backgroundColor: Colors.white,
                                  child: CircleAvatar(
                                    radius: 28,
                                    child: Align(
                                      alignment: Alignment.center,
                                      widthFactor: 1.0,
                                      heightFactor: 1.0,
                                      child: Container(
                                        width: 60,
                                        height: 60,
                                        decoration: BoxDecoration(
                                            gradient: AppConstant.Book_BG,
                                            borderRadius:
                                                BorderRadius.circular(60)),
                                        child: Center(
                                            child: Obx(() => Text("hide",
                                                // postController
                                                //         .selected_day.isNotEmpty
                                                //     ? "${postController.selected_day}"
                                                //     : "DD",
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.white)))),
                                      ),
                                    ),
                                  ),
                                ),
                                CircleAvatar(
                                  radius: 30,
                                  backgroundColor: Colors.white,
                                  child: CircleAvatar(
                                    radius: 28,
                                    child: Align(
                                      alignment: Alignment.center,
                                      widthFactor: 1.0,
                                      heightFactor: 1.0,
                                      child: Container(
                                        width: 60,
                                        height: 60,
                                        decoration: BoxDecoration(
                                            gradient: AppConstant.Book_BG,
                                            borderRadius:
                                                BorderRadius.circular(60)),
                                        child: Center(
                                            child: Obx(() => Text(
                                                /*postController
                                                        .selected_mon.isNotEmpty
                                                    ? "${postController.selected_mon}"
                                                    :*/ "MM",
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.white)))),
                                      ),
                                    ),
                                  ),
                                ),
                                CircleAvatar(
                                  radius: 30,
                                  backgroundColor: Colors.white,
                                  child: CircleAvatar(
                                    radius: 28,
                                    child: Align(
                                      alignment: Alignment.center,
                                      widthFactor: 1.0,
                                      heightFactor: 1.0,
                                      child: Container(
                                        width: 60,
                                        height: 60,
                                        decoration: BoxDecoration(
                                            gradient: AppConstant.Book_BG,
                                            borderRadius:
                                                BorderRadius.circular(60)),
                                        child: Center(
                                            child: Obx(() => Text(
                                                /*postController
                                                        .selected_year.isNotEmpty
                                                    ? "${postController.selected_year}"
                                                    :*/ "YY",
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.white)))),
                                      ),
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
                  Container(
                    margin: EdgeInsets.only(
                      top: 20,
                    ),
                    child: Center(
                      child: Text("Select Time",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          )),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      // _selectTime(context);
                      // Get.to(Book_Slot());
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: 10, left: 40, right: 40),
                      height: 100,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border:
                              Border.all(color: Colors.transparent, width: 0)),
                      child: Center(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  radius: 30,
                                  backgroundColor: Colors.white,
                                  child: CircleAvatar(
                                    radius: 28,
                                    child: Align(
                                      alignment: Alignment.center,
                                      widthFactor: 1.0,
                                      heightFactor: 1.0,
                                      child: Container(
                                        width: 60,
                                        height: 60,
                                        decoration: BoxDecoration(
                                            gradient: AppConstant.Book_BG,
                                            borderRadius:
                                                BorderRadius.circular(60)),
                                        child: Center(
                                            child: Obx(() => Text(
                                                postController.seletecd_time_slot
                                                        .isNotEmpty
                                                    ? postController
                                                        .seletecd_time_slot
                                                        .value
                                                        .characters
                                                        .take(2)
                                                        .toString()
                                                    : "HH",
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.white)))),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 40,
                                ),
                                CircleAvatar(
                                  radius: 30,
                                  backgroundColor: Colors.white,
                                  child: CircleAvatar(
                                    radius: 28,
                                    child: Align(
                                      alignment: Alignment.center,
                                      widthFactor: 1.0,
                                      heightFactor: 1.0,
                                      child: Container(
                                        width: 60,
                                        height: 60,
                                        decoration: BoxDecoration(
                                            gradient: AppConstant.Book_BG,
                                            borderRadius:
                                                BorderRadius.circular(60)),
                                        child: Center(
                                            child: Obx(() => Text(
                                                postController.seletecd_time_slot
                                                        .isNotEmpty
                                                    ? postController
                                                        .seletecd_time_slot
                                                        .value
                                                        .characters
                                                        .getRange(3, 5)
                                                        .toString()
                                                    : "MM",
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.white)))),
                                      ),
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
                  Container(
                    margin: EdgeInsets.only(
                      top: 20,
                    ),
                    child: Center(
                      child: Text("Explain Issue",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          )),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20, left: 40, right: 40),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.white, width: 1)),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            "Explain issue here",
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextField(
                                maxLines: 5,
                                controller: postController.problem,
                                decoration: InputDecoration.collapsed(
                                    hintText: "",
                                    hintStyle: TextStyle(color: Colors.white)),
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(

                    margin: EdgeInsets.only(top: 10, left: 40, right: 40),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Center(
                          child: const Text("Upload Photo",
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                              )),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Center(
                            child: InkWell(
                          onTap: () {
                            getImages();
                          },
                          child: Container(
                            width: 72,
                            height: 72,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.white, width: 1),
                                borderRadius: BorderRadius.circular(36),
                                color: Color(0x4cffffff)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset("assets/images/book_plus.png"),
                            ),
                          ),
                        )),
                        const SizedBox(
                          width: 20,
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 20),
                          height: 100,
                              // postController.selectedImages.isEmpty ? 100 : 300.0,
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    height: 300.0,
                                    child:GridView.builder(
                                            itemCount: 2/*postController
                                                .selectedImages.length*/,
                                            gridDelegate:
                                                const SliverGridDelegateWithFixedCrossAxisCount(
                                                    crossAxisCount: 3),
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: SizedBox(
                                                    height: MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            2 +
                                                        10,
                                                    child: Stack(
                                                      clipBehavior: Clip.hardEdge,
                                                      children: <Widget>[
                                                        Container(
                                                          margin:
                                                              EdgeInsets.all(9),
                                                          width: 100,
                                                          height: 100,
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                              border: Border.all(
                                                                  color: Colors
                                                                      .white,
                                                                  width: 2)),
                                                          child: Image.file("" as File,
                                                            // postController
                                                            //         .selectedImages[
                                                            //     index],
                                                            fit: BoxFit.contain,
                                                            width: 60,
                                                          ),
                                                        ),
                                                        Positioned(
                                                          right: 0,
                                                          top: 0,
                                                          child: GestureDetector(
                                                            onTap: () {
                                                              print(
                                                                  'deleted index:${index}');

                                                              // setState(() {
                                                              //   postController
                                                              //       .selectedImages
                                                              //       .removeAt(
                                                              //           index);
                                                              //   print(
                                                              //       'set new state of images');
                                                              // });
                                                            },
                                                            child: Icon(
                                                              Icons.delete,
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    )),
                                              );
                                            },
                                          ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: InkWell(
                              onTap: () {
                                if (postController.problem.text.isEmpty) {
                                  util.showSnackBar(
                                      "Alert", "Please fill all details!", false);
                                } else if (postController
                                    .seletecd_time_slot.isEmpty) {
                                  util.showSnackBar(
                                      "Alert", "Please fill all details!", false);

                                } else {
                                  // debugPrint("postdata" +
                                  //     postController.date.text.toString() +
                                  //     postController.time.text.toString() +
                                  //     postController.problem.text.toString());

                                  if (userid.isEmpty) {
                                    util.showSnackBar("Alert",
                                        "Sorry couldn't find user id", false);
                                  } else {
                                    postController
                                        .postData(userid)
                                        .then((value) => {
                                              // setState(() {
                                              //   postController.selectedImages
                                              //       .clear();
                                              //   Get.offAll(MyHomePage());
                                              // })
                                            });
                                  }
                                }
                              },
                              child: Container(
                                width: 289,
                                height: 44,
                                decoration: BoxDecoration(
                                  boxShadow  :  [
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
                                    borderRadius: BorderRadius.circular(30),
                                    border:
                                        Border.all(color: Colors.white, width: 1),
                                    gradient: AppConstant.bg_test,
                                    color: Colors.blue),
                                child: const Center(
                                    child: const Text("Add Appointment",
                                        style: TextStyle(
                                          color: Color.fromRGBO(138, 138, 138, 1),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w100,
                                        ))),
                              ),
                            ),
                          ),
                        )
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

/*
      Container(
                  child: selectedImages.isEmpty
                      ? const Center(child: Text('Sorry nothing selected!!'))
                      : Expanded(
                          child: GridView.builder(
                            itemCount: selectedImages.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3),
                            itemBuilder: (BuildContext context, int index) {
                              return Center(
                                  child: kIsWeb
                                      ? Image.network(selectedImages[index].path)
                                      : Image.file(selectedImages[index]));
                            },
                          ),
                        ),
                ),
 */
