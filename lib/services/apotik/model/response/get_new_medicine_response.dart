// To parse this JSON data, do
//
//     final getNewMedicineResponse = getNewMedicineResponseFromJson(jsonString);

import 'dart:convert';

GetNewMedicineResponse getNewMedicineResponseFromJson(String str) =>
    GetNewMedicineResponse.fromJson(json.decode(str));

String getNewMedicineResponseToJson(GetNewMedicineResponse data) =>
    json.encode(data.toJson());

class GetNewMedicineResponse {
  bool success;
  int code;
  String message;
  Data data;

  GetNewMedicineResponse({
    required this.success,
    required this.code,
    required this.message,
    required this.data,
  });

  factory GetNewMedicineResponse.fromJson(Map<String, dynamic> json) =>
      GetNewMedicineResponse(
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
  List<DatumNewMedicine> data;
  Pagination pagination;

  Data({
    required this.data,
    required this.pagination,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        data: List<DatumNewMedicine>.from(
            json["data"].map((x) => DatumNewMedicine.fromJson(x))),
        pagination: Pagination.fromJson(json["pagination"]),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "pagination": pagination.toJson(),
      };
}

class DatumNewMedicine {
  int no;
  String id;
  String nameMedicine;
  int priceSell;
  DateTime createdAt;
  int stock;
  String baseUnit;
  String idBaseUnit;
  List<Conversion> conversions;

  DatumNewMedicine({
    required this.no,
    required this.id,
    required this.nameMedicine,
    required this.priceSell,
    required this.createdAt,
    required this.stock,
    required this.baseUnit,
    required this.idBaseUnit,
    required this.conversions,
  });

  factory DatumNewMedicine.fromJson(Map<String, dynamic> json) =>
      DatumNewMedicine(
        no: json["no"],
        id: json["id"],
        nameMedicine: json["name_medicine"],
        priceSell: json["price_sell"],
        createdAt: DateTime.parse(json["createdAt"]),
        stock: json["stock"],
        baseUnit: json["baseUnit"],
        idBaseUnit: json["idBaseUnit"],
        conversions: List<Conversion>.from(
            json["conversions"].map((x) => Conversion.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "no": no,
        "id": id,
        "name_medicine": nameMedicine,
        "price_sell": priceSell,
        "createdAt": createdAt.toIso8601String(),
        "stock": stock,
        "baseUnit": baseUnit,
        "idBaseUnit": idBaseUnit,
        "conversions": List<dynamic>.from(conversions.map((x) => x.toJson())),
      };
}

class Conversion {
  String id;
  String unitName;
  int multiplier;

  Conversion({
    required this.id,
    required this.unitName,
    required this.multiplier,
  });

  factory Conversion.fromJson(Map<String, dynamic> json) => Conversion(
        id: json["id"],
        unitName: json["unitName"],
        multiplier: json["multiplier"],
      );

  Map<String, dynamic> toJson() => {
        "unitName": unitName,
        "id": id,
        "multiplier": multiplier,
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
