// To parse this JSON data, do
//
//     final getGroupStockMedicineResponse = getGroupStockMedicineResponseFromJson(jsonString);

import 'dart:convert';

GetGroupStockMedicineResponse getGroupStockMedicineResponseFromJson(
        String str) =>
    GetGroupStockMedicineResponse.fromJson(json.decode(str));

String getGroupStockMedicineResponseToJson(
        GetGroupStockMedicineResponse data) =>
    json.encode(data.toJson());

class GetGroupStockMedicineResponse {
  bool success;
  int code;
  String message;
  Data data;

  GetGroupStockMedicineResponse({
    required this.success,
    required this.code,
    required this.message,
    required this.data,
  });

  factory GetGroupStockMedicineResponse.fromJson(Map<String, dynamic> json) =>
      GetGroupStockMedicineResponse(
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
  List<DatumGroupStockMedicine> data;
  Pagination pagination;

  Data({
    required this.data,
    required this.pagination,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        data: List<DatumGroupStockMedicine>.from(
            json["data"].map((x) => DatumGroupStockMedicine.fromJson(x))),
        pagination: Pagination.fromJson(json["pagination"]),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "pagination": pagination.toJson(),
      };
}

class DatumGroupStockMedicine {
  int no;
  String id;
  String nameMedicine;
  int totalStock;

  DatumGroupStockMedicine({
    required this.no,
    required this.id,
    required this.nameMedicine,
    required this.totalStock,
  });

  factory DatumGroupStockMedicine.fromJson(Map<String, dynamic> json) =>
      DatumGroupStockMedicine(
        no: json["no"],
        id: json["id"],
        nameMedicine: json["name_medicine"],
        totalStock: json["total_stock"],
      );

  Map<String, dynamic> toJson() => {
        "no": no,
        "id": id,
        "name_medicine": nameMedicine,
        "total_stock": totalStock,
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
