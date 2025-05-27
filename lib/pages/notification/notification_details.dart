import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utils/component_screen.dart';

class NotificationDetails extends StatefulWidget {
  final titel;
  final massage;
  final images;
  final appointmentId;
  const NotificationDetails({Key? key, this.titel, this.massage, this.images, this.appointmentId}) : super(key: key);

  @override
  State<NotificationDetails> createState() => _NotificationDetailsState();
}

class _NotificationDetailsState extends State<NotificationDetails> {
  @override
  Widget build(BuildContext context) {
    print("Abhi:- getnotfication detail pages titels : ${widget.titel} message : ${widget.massage} appointment : ${widget.appointmentId}");
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomAppBar(title: 'Notification Details'),
            // Image.network(widget.images),
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: CachedNetworkImage(
                  // Check if nextVisitHistory exists and has items
                  imageUrl: widget.images != null &&
                      widget.images.isNotEmpty
                      ? widget.images! ?? ""
                      : "assets/newImages/noimagefound.png",
                  fit: BoxFit.cover,
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => Image.asset(
                    "assets/newImages/noimagefound.png", // Placeholder image
                    fit: BoxFit.cover,
                  ),
                  // Enable caching for faster loading
                  memCacheHeight: (height * 0.40).toInt(),
                  memCacheWidth: (width * 0.75).toInt(),
                  fadeInDuration: const Duration(milliseconds: 500),
                ),
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: Column(
            //     children: [
            //       // Text("Appointment - Details ${widget.appointmentId}"),
            //       Row(
            //         children: [
            //           Text("Title : ",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),),
            //           // Text(widget.titel,style: TextStyle(fontSize: 18,),),
            //           Flexible(
            //             child: Text(
            //               widget.titel,
            //               style: TextStyle(fontSize: 16),
            //               softWrap: true,
            //               overflow: TextOverflow.visible,
            //             ),
            //           )
            //
            //         ],
            //       ),
            //       Row(
            //         children: [
            //           Text("Message : ",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
            //           Flexible(child: Text(widget.massage,style: TextStyle(fontSize: 18,),overflow: TextOverflow.visible,)),
            //         ],
            //       ),
            //     ],
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title Row
                  RichText(
                    text: TextSpan(
                      style: TextStyle(fontSize: 16, color: Colors.black),
                      children: [
                        TextSpan(
                          text: "Title: ",
                          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                        ),
                        TextSpan(
                          text: widget.titel,
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 8),
                  // Message Row
                  RichText(
                    text: TextSpan(
                      style: TextStyle(fontSize: 16, color: Colors.black),
                      children: [
                        TextSpan(
                          text: "Message: ",
                          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                        ),
                        TextSpan(
                          text: widget.massage,
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
