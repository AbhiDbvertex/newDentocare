import 'package:get/get.dart';
import 'package:dentocoreauth/data/api/apiclient.dart';

class PaymentRepository extends GetxService{
  final ApiClient apiClient;

  PaymentRepository({required this.apiClient});


  Future<Response> getPaymentHistory(String id) async{
    return apiClient.getPaymentHistory("/api/getTransaction/${id}");
  }
}