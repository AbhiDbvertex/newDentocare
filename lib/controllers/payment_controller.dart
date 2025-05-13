import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:dentocoreauth/pages/payment_history/payment_history.dart';

import '../Utills/Utills.dart';
import '../data/repository/payment_repository.dart';
import '../models/payment_history.dart' as PaymentHistoryDTO;

class PaymentController extends GetxController {
  final PaymentRepository paymentRepository;

  PaymentController({required this.paymentRepository});

  final util = Utills();

  RxBool _isLoading = false.obs;

  RxBool nodata = true.obs;

  RxBool get _nodata => nodata;

  RxBool get isLoading => _isLoading;

  RxList<PaymentHistoryDTO.PaymentHistoryBody?> _getHistory =
      <PaymentHistoryDTO.PaymentHistoryBody>[].obs;

  RxList<PaymentHistoryDTO.PaymentHistoryBody?> get getHistory => _getHistory;

  Future<PaymentHistoryDTO.PaymentHistoryDto?> getPaymentHistory(
      String uid) async {
    var res = await paymentRepository.getPaymentHistory(uid);
    debugPrint("nj_history" + "called");
    util.startLoading();
    _isLoading(true);
    if (res.statusCode == 200 || res.statusCode == 201) {
      util.stopLoading();
      debugPrint("nj_history" + "200");
      debugPrint("Abhi:- nj_history" + "get payment history---> ${res.body}");
      final response = jsonDecode(res.bodyString!);
      if (response["status"] == false) {
        debugPrint("nj_history" + "false");
        _nodata.value = true;
        _isLoading(false);
      } else {
        _nodata.value = false;
        debugPrint("nj_history" + "true");
      }
      var myres = PaymentHistoryDTO.paymentHistoryDtoFromJson(res.bodyString!);
      _getHistory.value = myres.body;
      _getHistory.refresh();
      update();
      debugPrint("nj_history" + _isLoading.toString());
      _isLoading(false);
      debugPrint("nj_history" + "before".toString());

      return myres;
    } else if (res.statusCode == 400) {
      util.stopLoading();
      _isLoading(false);
      debugPrint("nj_history" + _isLoading.toString());
      //util.showSnackBar("Alert", "error", false);
      return null;
    }else{
      util.stopLoading();
     // util.showSnackBar("Alert", "error", false);
    }
  }
}
