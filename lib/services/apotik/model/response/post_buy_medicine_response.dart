// To parse this JSON data, do
//
//     final postBuyMedicineResponse = postBuyMedicineResponseFromJson(jsonString);

import 'dart:convert';

PostBuyMedicineResponse postBuyMedicineResponseFromJson(String str) => PostBuyMedicineResponse.fromJson(json.decode(str));

String postBuyMedicineResponseToJson(PostBuyMedicineResponse data) => json.encode(data.toJson());

class PostBuyMedicineResponse {
    bool success;
    int code;
    String message;
    Data data;

    PostBuyMedicineResponse({
        required this.success,
        required this.code,
        required this.message,
        required this.data,
    });

    factory PostBuyMedicineResponse.fromJson(Map<String, dynamic> json) => PostBuyMedicineResponse(
        success: json["success"],
        code: json["code"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "code": code,
        "message": message,
        "data": data.toJson(),
    };
}

class Data {
    String id;
    String noBuy;
    String nameSupplier;
    DateTime dateBuy;
    dynamic nominalPayment;
    DateTime createdAt;
    String userId;

    Data({
        required this.id,
        required this.noBuy,
        required this.nameSupplier,
        required this.dateBuy,
        required this.nominalPayment,
        required this.createdAt,
        required this.userId,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        noBuy: json["no_buy"],
        nameSupplier: json["name_supplier"],
        dateBuy: DateTime.parse(json["date_buy"]),
        nominalPayment: json["nominal_payment"],
        createdAt: DateTime.parse(json["createdAt"]),
        userId: json["userId"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "no_buy": noBuy,
        "name_supplier": nameSupplier,
        "date_buy": dateBuy.toIso8601String(),
        "nominal_payment": nominalPayment,
        "createdAt": createdAt.toIso8601String(),
        "userId": userId,
    };
}
