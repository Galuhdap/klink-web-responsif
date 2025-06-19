// To parse this JSON data, do
//
//     final getReportMedicineStockLowResponse = getReportMedicineStockLowResponseFromJson(jsonString);

import 'dart:convert';

GetReportMedicineStockLowResponse getReportMedicineStockLowResponseFromJson(String str) => GetReportMedicineStockLowResponse.fromJson(json.decode(str));

String getReportMedicineStockLowResponseToJson(GetReportMedicineStockLowResponse data) => json.encode(data.toJson());

class GetReportMedicineStockLowResponse {
    bool success;
    int code;
    String message;
    List<DatumLowStockMedicine> data;

    GetReportMedicineStockLowResponse({
        required this.success,
        required this.code,
        required this.message,
        required this.data,
    });

    factory GetReportMedicineStockLowResponse.fromJson(Map<String, dynamic> json) => GetReportMedicineStockLowResponse(
        success: json["success"],
        code: json["code"],
        message: json["message"],
        data: List<DatumLowStockMedicine>.from(json["data"].map((x) => DatumLowStockMedicine.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "code": code,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class DatumLowStockMedicine {
    String id;
    String name;
    String unit;
    int totalStock;

    DatumLowStockMedicine({
        required this.id,
        required this.name,
        required this.unit,
        required this.totalStock,
    });

    factory DatumLowStockMedicine.fromJson(Map<String, dynamic> json) => DatumLowStockMedicine(
        id: json["id"],
        name: json["name"],
        unit: json["unit"],
        totalStock: json["totalStock"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "unit": unit,
        "totalStock": totalStock,
    };
}
