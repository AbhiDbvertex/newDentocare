import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'mycolor.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const CustomAppBar({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = kToolbarHeight; // Default AppBar height
    double width = MediaQuery.of(context).size.width;

    return Container(
      height: height,
      width: double.infinity,
      decoration: BoxDecoration(
        color: MyColor.primarycolor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: GestureDetector(
              onTap: () => Get.back(),
              child: Container(
                height: height * 0.6,
                width: width * 0.12,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(9),
                ),
                child: Icon(Icons.arrow_back_ios_new, size: 18),
              ),
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.center,
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          SizedBox(width: width * 0.12),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}


class CustomBooingAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const CustomBooingAppBar({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = kToolbarHeight; // Default AppBar height
    double width = MediaQuery.of(context).size.width;

    return Container(
      height: height,
      width: double.infinity,
      decoration: BoxDecoration(
        color: MyColor.primarycolor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Row(
        children: [
          // Padding(
          //   padding: const EdgeInsets.all(10.0),
          //   child: GestureDetector(
          //     onTap: () => Get.back(),
          //     child: Container(
          //       height: height * 0.6,
          //       width: width * 0.12,
          //       decoration: BoxDecoration(
          //         color: Colors.white,
          //         borderRadius: BorderRadius.circular(9),
          //       ),
          //       child: Icon(Icons.arrow_back_ios_new, size: 18),
          //     ),
          //   ),
          // ),
          Expanded(
            child: Align(
              alignment: Alignment.center,
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          //SizedBox(width: width * 0.12),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
