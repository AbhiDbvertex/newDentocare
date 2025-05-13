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
    print("Abhi:- getnotfication detail pages titels : ${widget.titel} massage : ${widget.massage} appointment : ${widget.appointmentId}");
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomAppBar(title: 'Notification Details'),
            Image.network(widget.images),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text("Appointment - Details ${widget.appointmentId}"),
                  Row(
                    children: [
                      Text("Title : ",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),),
                      // Text(widget.titel,style: TextStyle(fontSize: 18,),),
                      Flexible(
                        child: Text(
                          widget.titel,
                          style: TextStyle(fontSize: 16),
                          softWrap: true,
                          overflow: TextOverflow.visible,
                        ),
                      )

                    ],
                  ),
                  Row(
                    children: [
                      Text("Massage : ",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
                      Flexible(child: Text(widget.massage,style: TextStyle(fontSize: 18,),overflow: TextOverflow.visible,)),
                    ],
                  ),
                  // Row(
                  //   children: [
                  //     Text("Appointment Date  : ",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),),
                  //     Text(widget.massage,style: TextStyle(fontSize: 18,),),
                  //   ],
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
