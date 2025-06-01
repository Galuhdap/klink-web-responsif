// To parse this JSON data, do
//
//     final putNewMedicineResponse = putNewMedicineResponseFromJson(jsonString);

import 'dart:convert';

PutNewMedicineResponse putNewMedicineResponseFromJson(String str) => PutNewMedicineResponse.fromJson(json.decode(str));

String putNewMedicineResponseToJson(PutNewMedicineResponse data) => json.encode(data.toJson());

class PutNewMedicineResponse {
    bool success;
    int code;
    String message;
    Data data;

    PutNewMedicineResponse({
        required this.success,
        required this.code,
        required this.message,
        required this.data,
    });

    factory PutNewMedicineResponse.fromJson(Map<String, dynamic> json) => PutNewMedicineResponse(
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
    String nameMedicine;
    int priceSell;
    int priceBuy;
    DateTime createdAt;

    Data({
        required this.id,
        required this.nameMedicine,
        required this.priceSell,
        required this.priceBuy,
        required this.createdAt,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        nameMedicine: json["name_medicine"],
        priceSell: json["price_sell"],
        priceBuy: json["price_buy"],
        createdAt: DateTime.parse(json["createdAt"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name_medicine": nameMedicine,
        "price_sell": priceSell,
        "price_buy": priceBuy,
        "createdAt": createdAt.toIso8601String(),
    };
}
