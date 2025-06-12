// To parse this JSON data, do
//
//     final getExpiringMedicinesResponse = getExpiringMedicinesResponseFromJson(jsonString);

import 'dart:convert';

GetExpiringMedicinesResponse getExpiringMedicinesResponseFromJson(String str) =>
    GetExpiringMedicinesResponse.fromJson(json.decode(str));

String getExpiringMedicinesResponseToJson(GetExpiringMedicinesResponse data) =>
    json.encode(data.toJson());

class GetExpiringMedicinesResponse {
  bool success;
  int code;
  String message;
  Data data;

  GetExpiringMedicinesResponse({
    required this.success,
    required this.code,
    required this.message,
    required this.data,
  });

  factory GetExpiringMedicinesResponse.fromJson(Map<String, dynamic> json) =>
      GetExpiringMedicinesResponse(
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
  List<DatumExpiredMedicine> data;
  Pagination pagination;

  Data({
    required this.data,
    required this.pagination,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        data: List<DatumExpiredMedicine>.from(
            json["data"].map((x) => DatumExpiredMedicine.fromJson(x))),
        pagination: Pagination.fromJson(json["pagination"]),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "pagination": pagination.toJson(),
      };
}

class DatumExpiredMedicine {
  int no;
  String nameMedicine;
  String noBuy;
  int stock;
  String nameUnit;
  DateTime tanggalExpired;
  int sisaHari;

  DatumExpiredMedicine({
    required this.no,
    required this.nameMedicine,
    required this.noBuy,
    required this.stock,
    required this.nameUnit,
    required this.tanggalExpired,
    required this.sisaHari,
  });

  factory DatumExpiredMedicine.fromJson(Map<String, dynamic> json) =>
      DatumExpiredMedicine(
        no: json["no"],
        nameMedicine: json["name_medicine"],
        noBuy: json["no_buy"],
        stock: json["stock"],
        nameUnit: json["name_unit"],
        tanggalExpired: DateTime.parse(json["tanggal_expired"]),
        sisaHari: json["sisa_hari"],
      );

  Map<String, dynamic> toJson() => {
        "no": no,
        "name_medicine": nameMedicine,
        "no_buy": noBuy,
        "stock": stock,
        "name_unit": nameUnit,
        "tanggal_expired":
            "${tanggalExpired.year.toString().padLeft(4, '0')}-${tanggalExpired.month.toString().padLeft(2, '0')}-${tanggalExpired.day.toString().padLeft(2, '0')}",
        "sisa_hari": sisaHari,
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
