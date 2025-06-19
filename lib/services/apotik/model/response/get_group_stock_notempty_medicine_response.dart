// To parse this JSON data, do
//
//     final getGroupStockNotEmptyMedicineResponse = getGroupStockNotEmptyMedicineResponseFromJson(jsonString);

import 'dart:convert';

GetGroupStockNotEmptyMedicineResponse getGroupStockNotEmptyMedicineResponseFromJson(String str) => GetGroupStockNotEmptyMedicineResponse.fromJson(json.decode(str));

String getGroupStockNotEmptyMedicineResponseToJson(GetGroupStockNotEmptyMedicineResponse data) => json.encode(data.toJson());

class GetGroupStockNotEmptyMedicineResponse {
    bool success;
    int code;
    String message;
    Data data;

    GetGroupStockNotEmptyMedicineResponse({
        required this.success,
        required this.code,
        required this.message,
        required this.data,
    });

    factory GetGroupStockNotEmptyMedicineResponse.fromJson(Map<String, dynamic> json) => GetGroupStockNotEmptyMedicineResponse(
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
    List<DatumGroupStockNotEmptyMedicine> data;
    Pagination pagination;

    Data({
        required this.data,
        required this.pagination,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        data: List<DatumGroupStockNotEmptyMedicine>.from(json["data"].map((x) => DatumGroupStockNotEmptyMedicine.fromJson(x))),
        pagination: Pagination.fromJson(json["pagination"]),
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "pagination": pagination.toJson(),
    };
}

class DatumGroupStockNotEmptyMedicine {
    int no;
    String id;
    String nameMedicine;
    int priceSell;
    String unitId;
    String nameUnit;
    int totalStock;

    DatumGroupStockNotEmptyMedicine({
        required this.no,
        required this.id,
        required this.nameMedicine,
        required this.priceSell,
        required this.unitId,
        required this.nameUnit,
        required this.totalStock,
    });

    factory DatumGroupStockNotEmptyMedicine.fromJson(Map<String, dynamic> json) => DatumGroupStockNotEmptyMedicine(
        no: json["no"],
        id: json["id"],
        nameMedicine: json["name_medicine"],
        priceSell: json["price_sell"],
        unitId: json["unitId"],
        nameUnit: json["name_unit"],
        totalStock: json["total_stock"],
    );

    Map<String, dynamic> toJson() => {
        "no": no,
        "id": id,
        "name_medicine": nameMedicine,
        "price_sell": priceSell,
        "unitId": unitId,
        "name_unit": nameUnit,
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
