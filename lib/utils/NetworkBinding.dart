import 'package:get/get.dart';

import '../controllers/notification_controller.dart';
import 'GetXNetworkManager.dart';


class NetworkBinding extends Bindings{

  // dependence injection attach our class.
  @override
  void dependencies() {
    Get.lazyPut<GetXNetworkManager>(() => GetXNetworkManager());

    //Get.put<MyPostController>(MyPostController());
  }

}