import 'package:get/get.dart';

import '../../api/apiclient.dart';

class NotificationRepository extends GetxService{

  final ApiClient apiclient ;

  NotificationRepository({required this.apiclient});

  Future<Response> getNotification(String id) async{
    // return apiclient.getnotification("/api/notification_get/${id}");
    return apiclient.getnotification("/api/notification_get/${id}");
  }

  Future<Response> getNotificationDetails(String id) async{
    return apiclient.getnotificationDetails("/api/appointment_details_get/${id}");
  }

}