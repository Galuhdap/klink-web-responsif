// To parse this JSON data, do
//
//     final getMonthlySummaryMedicineResponse = getMonthlySummaryMedicineResponseFromJson(jsonString);

import 'dart:convert';

GetMonthlySummaryMedicineResponse getMonthlySummaryMedicineResponseFromJson(String str) => GetMonthlySummaryMedicineResponse.fromJson(json.decode(str));

String getMonthlySummaryMedicineResponseToJson(GetMonthlySummaryMedicineResponse data) => json.encode(data.toJson());

class GetMonthlySummaryMedicineResponse {
    bool success;
    int code;
    String message;
    DataSummaryMontlyMedicine data;

    GetMonthlySummaryMedicineResponse({
        required this.success,
        required this.code,
        required this.message,
        required this.data,
    });

    factory GetMonthlySummaryMedicineResponse.fromJson(Map<String, dynamic> json) => GetMonthlySummaryMedicineResponse(
        success: json["success"],
        code: json["code"],
        message: json["message"],
        data: DataSummaryMontlyMedicine.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "code": code,
        "message": message,
        "data": data.toJson(),
    };
}

class DataSummaryMontlyMedicine {
    int totalPenjualan;
    int totalPembelian;
    int hpp;
    int laba;

    DataSummaryMontlyMedicine({
        required this.totalPenjualan,
        required this.totalPembelian,
        required this.hpp,
        required this.laba,
    });

    factory DataSummaryMontlyMedicine.fromJson(Map<String, dynamic> json) => DataSummaryMontlyMedicine(
        totalPenjualan: json["total_penjualan"],
        totalPembelian: json["total_pembelian"],
        hpp: json["hpp"],
        laba: json["laba"],
    );

    Map<String, dynamic> toJson() => {
        "total_penjualan": totalPenjualan,
        "total_pembelian": totalPembelian,
        "hpp": hpp,
        "laba": laba,
    };
}
