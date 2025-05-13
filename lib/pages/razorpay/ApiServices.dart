import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import '../../Utills/Utills.dart';

class ApiServices {
  final razorPayKey ="rzp_test_TWnCcoS9kjCyoX";
  final razorPaySecret = "CoEStk0zR5UXpimqtQI54FI8";
  final util=Utills();

  razorPayApi(num amount, String receiptId) async {
    util.stopLoading();
    debugPrint("testpayment"+"called");
    var auth =
        'Basic ' + base64Encode(utf8.encode('$razorPayKey:$razorPaySecret'));
    var headers = {'content-type': 'application/json', 'Authorization': auth};
   // var request =
    //http.Request('POST', Uri.parse('https://api.razorpay.com/v1/orders'));
    var response=await http.post(Uri.parse("https://api.razorpay.com/v1/orders"),body: {
      "amount":amount*100,
      "currency": "INR",
      "receipt": receiptId
    },headers: headers);
    // request.body = json.encode({
    //   // Amount in smallest unit
    //   // like in paise for INR
    //   "amount": amount * 100,
    //   // Currency
    //   "currency": "INR",
    //   // Receipt Id
    //   "receipt": receiptId
    // });
    //request.headers.addAll(headers);

    // http.StreamedResponse response = await request.send();
    // print(response.statusCode);
   // debugPrint("testpayment"+response.statusCode.toString());
    if (response.statusCode == 200) {
      debugPrint("testpayment"+"200");
      debugPrint("testpayment"+"${jsonDecode(response.body)}");

      util.stopLoading();
      return {
        "status": "success",
        "body": jsonDecode(response.body)
      };
    } else {
      debugPrint("testpayment"+"failed");
      util.stopLoading();
      return {"status": "fail", "message": (response.reasonPhrase)};
    }
  }
}
