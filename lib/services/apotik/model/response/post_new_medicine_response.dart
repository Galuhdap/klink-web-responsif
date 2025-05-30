// To parse this JSON data, do
//
//     final postNewMedicineResponse = postNewMedicineResponseFromJson(jsonString);

import 'dart:convert';

PostNewMedicineResponse postNewMedicineResponseFromJson(String str) =>
    PostNewMedicineResponse.fromJson(json.decode(str));

String postNewMedicineResponseToJson(PostNewMedicineResponse data) =>
    json.encode(data.toJson());

class PostNewMedicineResponse {
  bool success;
  int code;
  String message;
  Data data;

  PostNewMedicineResponse({
    required this.success,
    required this.code,
    required this.message,
    required this.data,
  });

  factory PostNewMedicineResponse.fromJson(Map<String, dynamic> json) =>
      PostNewMedicineResponse(
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
