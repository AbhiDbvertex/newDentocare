import 'package:get/get.dart';

import '../../api/apiclient.dart';

class UserRepositry extends GetxService {
  final ApiClient apiclient;
  UserRepositry({required this.apiclient});


  Future<Response> getAppointmentList(String uid) async{
    return await apiclient.getAppointmentList("/api/appointment_get/$uid");

  }

  Future<Response> updateRescheduled(Map body) async {
    return apiclient.updateRescheduled("/api/reshedule_status_update", body);
  }

  Future<Response> getPrescriptionList(String uid) async{
    return await apiclient.getPrescriptionList("/api/appointment_details_get/$uid");

  }

  Future<Response> getBanner() async {
    return await apiclient.getBanner("/api/banner_get");
  }
  Future<Response> getHomeBanner() async {
    return await apiclient.getBanner("/api/bannerMobile_get");
  }

  Future<Response> getChatStatus(String uid) async {
    return await apiclient.getChatStatus("/api/chatmessage_get/$uid");
  }

}
