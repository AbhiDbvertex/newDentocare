import 'dart:convert';
import 'dart:math';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:dentocoreauth/Utills/Utills.dart';
import 'package:dentocoreauth/pages/homepage/MyHomePage.dart';

import 'package:dentocoreauth/utils/app_constant.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/component_screen.dart';
import '../../utils/mycolor.dart';
import '../payment_history/payment_history.dart';

class Payment extends StatefulWidget {
  const Payment({Key? key}) : super(key: key);

  @override
  State<Payment> createState() => _PaymentState();
}

class PaymentModel {
  String _paymentID;
  String _orderID;
  String _signature;

  PaymentModel(this._paymentID, this._orderID, this._signature);

  String get paymentID => _paymentID;

  set paymentID(String value) {
    _paymentID = value;
  }

  String get orderID => _orderID;

  set orderID(String value) {
    _orderID = value;
  }

  String get signature => _signature;

  set signature(String value) {
    _signature = value;
  }
}

class _PaymentState extends State<Payment> {
  final _razorpay = Razorpay();
  final payment_amount = TextEditingController();
  final util = Utills();

  var user_data = [];
  var load_status = false;
  var userid = "";
  var userEmail = "";
  var userPhone = "";

  void getUserData(key) async {
    final sp = await SharedPreferences.getInstance();
    setState(() {
      user_data = sp.getStringList(key)!;
      load_status = true;
      userid = user_data[0].toString();
      userEmail = user_data[2].toString();
      userPhone = user_data[3].toString();
      //  util.showSnackBar("Alert", userid.toString(), true);
    });
  }

  postPayment(String razarpay_payment_id, String user_id, String amount) async {
    util.startLoading();
    var res = await http.post(
        Uri.parse("https://work.dbvertex.com/dentist1/api/payment"),
        body: <String, String>{
          "razarpay_payment_id": "${razarpay_payment_id}",
          "user_id": "${user_id}",
          "amount": "${amount}"
        },
        headers: <String, String>{
          "x-api-key": "dentist@123"
        });

    if (res.statusCode == 200 || res.statusCode == 201) {
      var result = jsonDecode(res.body);
      util.stopLoading();
      util.showSnackBar("Alert", "Payment Success", true);
      payment_amount.text = "";
      Get.offAll(MyHomePage());
    } else {
      util.stopLoading();
      util.showSnackBar("Alert", "Data couldn't be saved", true);
    }
  }

  @override
  void initState() {
    super.initState();
    getUserData("user_data");
    Future.delayed(Duration(milliseconds: 500));
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    //util.showSnackBar("Alert", "${response.paymentId}", true);
    //util.showSnackBar("Alert", "PaymentSuccess", true);

    final payModel = PaymentModel(
      response.paymentId.toString(),
      response.orderId.toString(),
      response.signature.toString(),
    );

    AppConstant.storePaymentInfo("paymentinfo", payModel);
    postPayment(response.paymentId.toString(), userid, payment_amount.text);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    util.showSnackBar("Alert", "${response.message}", false);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    util.showSnackBar("Alert", "${response.walletName} Selected", true);
  }

  razorPayApi(num amount, String receiptId) async {
    util.startLoading();
    debugPrint("testpayment" + "called");
    var auth = 'Basic ' +
        base64Encode(
            utf8.encode('rzp_live_u1PQF1udlICNdx:9HdXwvg1gvKE3uerbtjxuaPI'));
    var headers = {'content-type': 'application/json', 'Authorization': auth};
    // var request =
    //http.Request('POST', Uri.parse('https://api.razorpay.com/v1/orders'));
    var response = await http.post(
        Uri.parse("https://api.razorpay.com/v1/orders"),
        body: {"amount": amount * 100, "currency": "INR", "receipt": receiptId},
        headers: headers);
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
      util.stopLoading();
      debugPrint("testpayment" + "200");
      util.showSnackBar("Alert", response.body.toString(), true);
      debugPrint("testpayment" + "${jsonDecode(response.body)}");

      return {"status": "success", "body": jsonDecode(response.body)};
    } else {
      util.stopLoading();
      debugPrint("testpayment" + "failed");
      util.showSnackBar("Alert", "failed", false);
      util.showSnackBar("Alert", response.body.toString(), false);

      return {"status": "fail", "message": (response.reasonPhrase)};
    }
  }

  pay(String amount) {
    if (payment_amount.text.isEmpty) {
      Utills().showSnackBar("Alert", "Please enter amount to pay!", false);
      return;
    }
    var options = {
      // 'key': 'rzp_live_u1PQF1udlICNdx',
      'key': 'rzp_test_yds44ayQjStCiB', // testing key add
      'amount': int.parse(amount) * 100,
      'name': 'Pearlline Dental Experts',
      'description': 'Pearlline Dental Experts payment',
      'prefill': {
        'contact': '${userPhone ?? "1111111111"}',
        'email': '${userEmail ?? "test@razorpay.com"}'
      }
    };
    _razorpay.open(options);
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarColor: MyColor.primarycolor,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.light,
          systemNavigationBarColor: Colors.transparent,
        ),
        child: Scaffold(
          floatingActionButton: FloatingActionButton(onPressed: () {
            Get.to(PaymentHistory());
          }, //
          child: Icon(Icons.payments_outlined,color: Colors.white,),
            focusColor: MyColor.primarycolor,
            backgroundColor: MyColor.primarycolor,
          ),
          body: SingleChildScrollView(
            child: SafeArea(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CustomAppBar(title: 'Appointment'),
                    // Container(
                    //   child: Center(
                    //     child: Column(
                    //       mainAxisAlignment: MainAxisAlignment.start,
                    //       children: [
                    //         Row(
                    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //           crossAxisAlignment: CrossAxisAlignment.center,
                    //           children: [
                    //             Visibility(
                    //               visible: true,
                    //               maintainSize: true,
                    //               maintainState: true,
                    //               maintainSemantics: true,
                    //               maintainAnimation: true,
                    //               child: Container(
                    //                 width: MediaQuery.of(context).size.width / 3,
                    //                 alignment: Alignment.centerLeft,
                    //                 child: Padding(
                    //                   padding: EdgeInsets.only(top: 10),
                    //                   child: Bounceable(
                    //                     onTap: () {
                    //                       Get.back();
                    //                     },
                    //                     child: Container(
                    //                       width: 70,
                    //                       height: 40,
                    //                       decoration: BoxDecoration(
                    //                         color: Colors.white,
                    //                         borderRadius: BorderRadius.only(
                    //                             topRight: Radius.circular(30),
                    //                             bottomRight: Radius.circular(30)),
                    //                         boxShadow: [
                    //                           BoxShadow(
                    //                             color: Colors.grey.withOpacity(0.5),
                    //                             spreadRadius: 1,
                    //                             blurRadius: 2,
                    //                             offset: Offset(0,
                    //                                 3), // changes position of shadow
                    //                           ),
                    //                         ],
                    //                       ),
                    //                       child: Container(
                    //                         decoration: BoxDecoration(
                    //                             borderRadius: BorderRadius.only(
                    //                                 topRight: Radius.circular(30),
                    //                                 bottomRight:
                    //                                     Radius.circular(30)),
                    //                             gradient: AppConstant.BUTTON_COLOR),
                    //                         child: Image.asset(
                    //                           'assets/images/back_icon.png',
                    //                           width: 10,
                    //                           height: 10,
                    //                         ),
                    //                       ),
                    //                     ),
                    //                   ),
                    //                 ),
                    //               ),
                    //             ),
                    //             Container(
                    //               alignment: Alignment.center,
                    //               width: MediaQuery.of(context).size.width / 3,
                    //               child: Padding(
                    //                 padding: const EdgeInsets.only(top: 15.0),
                    //                 child: Container(
                    //                   height: 40,
                    //                   child: AppConstant.HEADLINE_TEXT(
                    //                       "Payment", context),
                    //                 ),
                    //               ),
                    //             ),
                    //             Visibility(
                    //               visible: false,
                    //               maintainAnimation: true,
                    //               maintainSemantics: true,
                    //               maintainState: true,
                    //               maintainSize: true,
                    //               child: Container(
                    //                 width: MediaQuery.of(context).size.width / 3,
                    //                 alignment: Alignment.centerRight,
                    //                 child: Padding(
                    //                     padding: EdgeInsets.only(top: 0, right: 10),
                    //                     child: Icon(Icons.notifications)),
                    //               ),
                    //             )
                    //           ],
                    //         ),
                    //         SizedBox(
                    //           height: 8,
                    //         ),
                    //         SizedBox(
                    //           child: Container(
                    //             height: 2,
                    //             decoration:
                    //                 BoxDecoration(color: Colors.grey, boxShadow: [
                    //               BoxShadow(
                    //                 offset: Offset(2, 4),
                    //                 color: Colors.black.withOpacity(
                    //                   0.3,
                    //                 ),
                    //                 blurRadius: 3,
                    //               ),
                    //             ]),
                    //           ),
                    //         )
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    Container(
                      margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height / 5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                              child: Image.asset(
                            "assets/newImages/applogo.png",
                            scale: 4,
                          )),
                          Text(
                            "Payment",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: 60,
                            width: MediaQuery.of(context).size.width / 2,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border:
                                    Border.all(color: Colors.black, width: 1)),
                            margin: EdgeInsets.symmetric(horizontal: 30),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: TextFormField(
                                    controller: payment_amount,
                                    decoration: InputDecoration.collapsed(
                                        hintText:
                                            "Please enter amount to pay")),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),

                          //razor pay
                          Padding(
                            padding: EdgeInsets.only(
                                left: AppConstant.LARGE_SIZE,
                                right: AppConstant.LARGE_SIZE,
                                bottom: AppConstant.SMALL_TEXT_SIZE),
                            child: Bounceable(
                              onTap: () {
                                // if (EasyLoading.isShow == true) {
                                //   return;
                                // }

                                pay(payment_amount.text);
                                final pay_data =
                                    AppConstant.getPaymentInfo("paymentinfo");
                                util.showSnackBar(
                                    "Alert", pay_data._paymentID, true);
                                util.showSnackBar(
                                    "Alert", pay_data._orderID, true);
                                util.showSnackBar(
                                    "Alert", pay_data._signature, true);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: MyColor.primarycolor,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 1,
                                      blurRadius: 2,
                                      offset: Offset(
                                          0, 3), // changes position of shadow
                                    ),
                                  ],
                                  // gradient: AppConstant.BUTTON_COLOR,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                margin: const EdgeInsets.all(8.00),
                                width: AppConstant.BUTTON_WIDTH,
                                height: AppConstant.BUTTON_HIGHT,
                                child: Center(
                                  child: Text("Pay",
                                      style: GoogleFonts.nunitoSans(
                                          textStyle: Theme.of(context)
                                              .textTheme
                                              .displayLarge,
                                          fontSize: AppConstant.MEDIUM_SIZE,
                                          fontWeight: FontWeight.w700,
                                          fontStyle: FontStyle.normal,
                                          color: Colors.white)),
                                ),
                              ),
                            ),
                          ),

                          //instamojo

                          Visibility(
                            visible: false,
                            child: Container(
                                child: ElevatedButton(
                              onPressed: () {
                                util.showSnackBar(
                                    "Alert",
                                    AppConstant.getPaymentInfo("paymentinfo")
                                        ._paymentID,
                                    true);
                              },
                              style: ButtonStyle(
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(18.0),
                                          side: BorderSide(
                                              color: Colors.black)))),
                              child: Text("Get Payment details"),
                            )),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
