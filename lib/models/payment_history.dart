// To parse this JSON data, do
//
//     final paymentHistoryDto = paymentHistoryDtoFromJson(jsonString);

import 'dart:convert';

PaymentHistoryDto paymentHistoryDtoFromJson(String str) => PaymentHistoryDto.fromJson(json.decode(str));

String paymentHistoryDtoToJson(PaymentHistoryDto data) => json.encode(data.toJson());

class PaymentHistoryDto {
  bool status;
  String message;
  List<PaymentHistoryBody> body;

  PaymentHistoryDto({
    required this.status,
    required this.message,
    required this.body,
  });

  factory PaymentHistoryDto.fromJson(Map<String, dynamic> json) => PaymentHistoryDto(
    status: json["status"],
    message: json["message"],
    body: List<PaymentHistoryBody>.from(json["body"].map((x) => PaymentHistoryBody.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "body": List<dynamic>.from(body.map((x) => x.toJson())),
  };
}

class PaymentHistoryBody {
  String id;
  String userId;
  String razarpayPaymentId;
  String amount;
  DateTime created;

  PaymentHistoryBody({
    required this.id,
    required this.userId,
    required this.razarpayPaymentId,
    required this.amount,
    required this.created,
  });

  factory PaymentHistoryBody.fromJson(Map<String, dynamic> json) => PaymentHistoryBody(
    id: json["id"],
    userId: json["user_id"],
    razarpayPaymentId: json["razarpay_payment_id"],
    amount: json["amount"],
    created: DateTime.parse(json["created"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "razarpay_payment_id": razarpayPaymentId,
    "amount": amount,
    "created": created.toIso8601String(),
  };
}
