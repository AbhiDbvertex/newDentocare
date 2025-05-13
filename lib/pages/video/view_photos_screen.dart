import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../utils/component_screen.dart';
import '../../utils/mycolor.dart';

class ViewPhotosScreen extends StatefulWidget {
  // final body item;
  final images;
  const ViewPhotosScreen({Key? key, required this.images, /*this.item*/}) : super(key: key);

  @override
  State<ViewPhotosScreen> createState() => _ViewPhotosScreenState();
}

class _ViewPhotosScreenState extends State<ViewPhotosScreen> {
  @override
  Widget build(BuildContext context) {
    print("Abhi:- get images function call ${widget.images}");
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
        statusBarColor: MyColor.primarycolor,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.light,
        systemNavigationBarColor: Colors.transparent,
    ),
    child: Scaffold(
      // backgroundColor: Colors.black,
      appBar: AppBar(title: Text("Veiw Images"),centerTitle: true,),
      // appBar: CustomBooingAppBar(title: ' Appointment List'),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: Image.network(widget.images)),
        ],
      ),
    ));
  }
}
