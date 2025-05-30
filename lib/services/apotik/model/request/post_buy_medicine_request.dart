// To parse this JSON data, do
//
//     final postBuyMedicineRequest = postBuyMedicineRequestFromJson(jsonString);

import 'dart:convert';

PostBuyMedicineRequest postBuyMedicineRequestFromJson(String str) =>
    PostBuyMedicineRequest.fromJson(json.decode(str));

String postBuyMedicineRequestToJson(PostBuyMedicineRequest data) =>
    json.encode(data.toJson());

class PostBuyMedicineRequest {
  String nameSupplier;
  String noBuy;
  DateTime dateBuy;
  List<MedicineRequest> medicines;

  PostBuyMedicineRequest({
    required this.nameSupplier,
    required this.noBuy,
    required this.dateBuy,
    required this.medicines,
  });

  factory PostBuyMedicineRequest.fromJson(Map<String, dynamic> json) =>
      PostBuyMedicineRequest(
        nameSupplier: json["name_supplier"],
        noBuy: json["no_buy"],
        dateBuy: DateTime.parse(json["date_buy"]),
        medicines: List<MedicineRequest>.from(
            json["medicines"].map((x) => MedicineRequest.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "name_supplier": nameSupplier,
        "no_buy": noBuy,
        "date_buy":
            "${dateBuy.year.toString().padLeft(4, '0')}-${dateBuy.month.toString().padLeft(2, '0')}-${dateBuy.day.toString().padLeft(2, '0')}",
        "medicines": List<dynamic>.from(medicines.map((x) => x.toJson())),
      };
}

class MedicineRequest {
  String medicineId;
  int stock;
  DateTime dateExpired;
  int priceBuy;

  MedicineRequest({
    required this.medicineId,
    required this.stock,
    required this.dateExpired,
    required this.priceBuy,
  });

  factory MedicineRequest.fromJson(Map<String, dynamic> json) =>
      MedicineRequest(
        medicineId: json["medicineId"],
        stock: json["stock"],
        dateExpired: DateTime.parse(json["date_expired"]),
        priceBuy: json["price_buy"],
      );

  Map<String, dynamic> toJson() => {
        "medicineId": medicineId,
        "stock": stock,
        "date_expired":
            "${dateExpired.year.toString().padLeft(4, '0')}-${dateExpired.month.toString().padLeft(2, '0')}-${dateExpired.day.toString().padLeft(2, '0')}",
        "price_buy": priceBuy,
      };
}
