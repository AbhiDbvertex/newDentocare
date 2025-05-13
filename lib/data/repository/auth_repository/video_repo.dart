import 'package:get/get.dart';

import '../../api/apiclient.dart';

class VideoRepository extends GetxService{

  final ApiClient apiclient ;

  VideoRepository({required this.apiclient});

  Future<Response> getVideoList() async{
    return apiclient.getVideoLists("/api/video");
  }
}