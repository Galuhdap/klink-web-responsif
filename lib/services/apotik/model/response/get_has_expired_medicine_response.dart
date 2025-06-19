// To parse this JSON data, do
//
//     final getHasExpiredMedicineResponse = getHasExpiredMedicineResponseFromJson(jsonString);

import 'dart:convert';

GetHasExpiredMedicineResponse getHasExpiredMedicineResponseFromJson(
        String str) =>
    GetHasExpiredMedicineResponse.fromJson(json.decode(str));

String getHasExpiredMedicineResponseToJson(
        GetHasExpiredMedicineResponse data) =>
    json.encode(data.toJson());

class GetHasExpiredMedicineResponse {
  bool success;
  int code;
  String message;
  Data data;

  GetHasExpiredMedicineResponse({
    required this.success,
    required this.code,
    required this.message,
    required this.data,
  });

  factory GetHasExpiredMedicineResponse.fromJson(Map<String, dynamic> json) =>
      GetHasExpiredMedicineResponse(
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
  List<DatumHasExpiredMedicine> data;
  Pagination pagination;

  Data({
    required this.data,
    required this.pagination,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        data: List<DatumHasExpiredMedicine>.from(
            json["data"].map((x) => DatumHasExpiredMedicine.fromJson(x))),
        pagination: Pagination.fromJson(json["pagination"]),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "pagination": pagination.toJson(),
      };
}

class DatumHasExpiredMedicine {
  int no;
  String id;
  String nameMedicine;
  int stock;
  String noBuy;
  DateTime tanggalExpired;

  DatumHasExpiredMedicine({
    required this.no,
    required this.id,
    required this.nameMedicine,
    required this.stock,
    required this.noBuy,
    required this.tanggalExpired,
  });

  factory DatumHasExpiredMedicine.fromJson(Map<String, dynamic> json) =>
      DatumHasExpiredMedicine(
        no: json["no"],
        id: json["id"],
        nameMedicine: json["name_medicine"],
        stock: json["stock"],
        noBuy: json["no_buy"],
        tanggalExpired: DateTime.parse(json["tanggal_expired"]),
      );

  Map<String, dynamic> toJson() => {
        "no": no,
        "id": id,
        "name_medicine": nameMedicine,
        "stock": stock,
        "no_buy": noBuy,
        "tanggal_expired":
            "${tanggalExpired.year.toString().padLeft(4, '0')}-${tanggalExpired.month.toString().padLeft(2, '0')}-${tanggalExpired.day.toString().padLeft(2, '0')}",
      };
}

class Pagination {
  int total;
  int page;
  int limit;
  int totalPages;

  Pagination({
    required this.total,
    required this.page,
    required this.limit,
    required this.totalPages,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
        total: json["total"],
        page: json["page"],
        limit: json["limit"],
        totalPages: json["totalPages"],
      );

  Map<String, dynamic> toJson() => {
        "total": total,
        "page": page,
        "limit": limit,
        "totalPages": totalPages,
      };
}
