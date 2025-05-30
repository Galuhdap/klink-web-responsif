// To parse this JSON data, do
//
//     final postTransactionRequest = postTransactionRequestFromJson(jsonString);

import 'dart:convert';

PostTransactionRequest postTransactionRequestFromJson(String str) => PostTransactionRequest.fromJson(json.decode(str));

String postTransactionRequestToJson(PostTransactionRequest data) => json.encode(data.toJson());

class PostTransactionRequest {
    String paymentMethod;
    int nominalPayment;
    int changeGiven;
    int amountPaid;
    String idRekamMedis;

    PostTransactionRequest({
        required this.paymentMethod,
        required this.nominalPayment,
        required this.changeGiven,
        required this.amountPaid,
        required this.idRekamMedis,
    });

    factory PostTransactionRequest.fromJson(Map<String, dynamic> json) => PostTransactionRequest(
        paymentMethod: json["payment_method"],
        nominalPayment: json["nominal_payment"],
        changeGiven: json["change_given"],
        amountPaid: json["amount_paid"],
        idRekamMedis: json["id_rekam_medis"],
    );

    Map<String, dynamic> toJson() => {
        "payment_method": paymentMethod,
        "nominal_payment": nominalPayment,
        "change_given": changeGiven,
        "amount_paid": amountPaid,
        "id_rekam_medis": idRekamMedis,
    };
}
