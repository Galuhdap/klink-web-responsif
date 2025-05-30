// To parse this JSON data, do
//
//     final postTransactionResponse = postTransactionResponseFromJson(jsonString);

import 'dart:convert';

PostTransactionResponse postTransactionResponseFromJson(String str) => PostTransactionResponse.fromJson(json.decode(str));

String postTransactionResponseToJson(PostTransactionResponse data) => json.encode(data.toJson());

class PostTransactionResponse {
    final bool success;
    final int code;
    final String message;
    final TransactionPost data;

    PostTransactionResponse({
        required this.success,
        required this.code,
        required this.message,
        required this.data,
    });

    PostTransactionResponse copyWith({
        bool? success,
        int? code,
        String? message,
        TransactionPost? data,
    }) => 
        PostTransactionResponse(
            success: success ?? this.success,
            code: code ?? this.code,
            message: message ?? this.message,
            data: data ?? this.data,
        );

    factory PostTransactionResponse.fromJson(Map<String, dynamic> json) => PostTransactionResponse(
        success: json["success"],
        code: json["code"],
        message: json["message"],
        data: TransactionPost.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "code": code,
        "message": message,
        "data": data.toJson(),
    };
}

class TransactionPost {
    final String id;
    final String invoce;
    final String paymentMethod;
    final int nominalPayment;
    final int changeGiven;
    final int amountPaid;
    final String rekamMedisid;
    final DateTime createdAt;
    final String userId;

    TransactionPost({
        required this.id,
        required this.invoce,
        required this.paymentMethod,
        required this.nominalPayment,
        required this.changeGiven,
        required this.amountPaid,
        required this.rekamMedisid,
        required this.createdAt,
        required this.userId,
    });

    TransactionPost copyWith({
        String? id,
        String? invoce,
        String? paymentMethod,
        int? nominalPayment,
        int? changeGiven,
        int? amountPaid,
        String? rekamMedisid,
        DateTime? createdAt,
        String? userId,
    }) => 
        TransactionPost(
            id: id ?? this.id,
            invoce: invoce ?? this.invoce,
            paymentMethod: paymentMethod ?? this.paymentMethod,
            nominalPayment: nominalPayment ?? this.nominalPayment,
            changeGiven: changeGiven ?? this.changeGiven,
            amountPaid: amountPaid ?? this.amountPaid,
            rekamMedisid: rekamMedisid ?? this.rekamMedisid,
            createdAt: createdAt ?? this.createdAt,
            userId: userId ?? this.userId,
        );

    factory TransactionPost.fromJson(Map<String, dynamic> json) => TransactionPost(
        id: json["id"],
        invoce: json["invoce"],
        paymentMethod: json["payment_method"],
        nominalPayment: json["nominal_payment"],
        changeGiven: json["change_given"],
        amountPaid: json["amount_paid"],
        rekamMedisid: json["rekam_medisid"],
        createdAt: DateTime.parse(json["createdAt"]),
        userId: json["userId"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "invoce": invoce,
        "payment_method": paymentMethod,
        "nominal_payment": nominalPayment,
        "change_given": changeGiven,
        "amount_paid": amountPaid,
        "rekam_medisid": rekamMedisid,
        "createdAt": createdAt.toIso8601String(),
        "userId": userId,
    };
}
