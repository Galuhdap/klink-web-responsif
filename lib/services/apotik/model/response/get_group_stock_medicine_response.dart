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
  int priceSell;
  int totalStock;
  String idUnit;
  String nameUnit;
  List<Conversion> conversion;

  DatumGroupStockMedicine({
    required this.no,
    required this.id,
    required this.nameMedicine,
    required this.priceSell,
    required this.totalStock,
    required this.idUnit,
    required this.nameUnit,
    required this.conversion,
  });

  factory DatumGroupStockMedicine.fromJson(Map<String, dynamic> json) =>
      DatumGroupStockMedicine(
        no: json["no"],
        id: json["id"],
        nameMedicine: json["name_medicine"],
        priceSell: json["price_sell"],
        totalStock: json["total_stock"],
        idUnit: json["id_unit"],
        nameUnit: json["name_unit"],
        conversion: List<Conversion>.from(
            json["conversion"].map((x) => Conversion.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "no": no,
        "id": id,
        "name_medicine": nameMedicine,
        "price_sell": priceSell,
        "total_stock": totalStock,
        "name_unit": nameUnit,
        "id_unit": idUnit,
        "conversion": List<dynamic>.from(conversion.map((x) => x.toJson())),
      };
}

class Conversion {
  String id;
  String medicineId;
  String unitId;
  int multiplier;
  UnitS unit;

  Conversion({
    required this.id,
    required this.medicineId,
    required this.unitId,
    required this.multiplier,
    required this.unit,
  });

  factory Conversion.fromJson(Map<String, dynamic> json) => Conversion(
        id: json["id"],
        medicineId: json["medicineId"],
        unitId: json["unitId"],
        multiplier: json["multiplier"],
        unit: UnitS.fromJson(json["unit"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "medicineId": medicineId,
        "unitId": unitId,
        "multiplier": multiplier,
        "unit": unit.toJson(),
      };
}

class UnitS {
  String id;
  String name;
  int level;

  UnitS({
    required this.id,
    required this.name,
    required this.level,
  });

  factory UnitS.fromJson(Map<String, dynamic> json) => UnitS(
        id: json["id"],
        name: json["name"],
        level: json["level"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "level": level,
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
