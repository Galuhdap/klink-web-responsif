// To parse this JSON data, do
//
//     final getDailySummaryMedicineResponse = getDailySummaryMedicineResponseFromJson(jsonString);

import 'dart:convert';

GetDailySummaryMedicineResponse getDailySummaryMedicineResponseFromJson(String str) => GetDailySummaryMedicineResponse.fromJson(json.decode(str));

String getDailySummaryMedicineResponseToJson(GetDailySummaryMedicineResponse data) => json.encode(data.toJson());

class GetDailySummaryMedicineResponse {
    bool success;
    int code;
    String message;
    DataSummaryDailyMedicine data;

    GetDailySummaryMedicineResponse({
        required this.success,
        required this.code,
        required this.message,
        required this.data,
    });

    factory GetDailySummaryMedicineResponse.fromJson(Map<String, dynamic> json) => GetDailySummaryMedicineResponse(
        success: json["success"],
        code: json["code"],
        message: json["message"],
        data: DataSummaryDailyMedicine.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "code": code,
        "message": message,
        "data": data.toJson(),
    };
}

class DataSummaryDailyMedicine {
    int penjualanObatHariIni;
    int hppHariIni;
    int labaKotorHariIni;
    int labaBersihHariIni;
    int feeDokterHariIni;

    DataSummaryDailyMedicine({
        required this.penjualanObatHariIni,
        required this.hppHariIni,
        required this.labaKotorHariIni,
        required this.labaBersihHariIni,
        required this.feeDokterHariIni,
    });

    factory DataSummaryDailyMedicine.fromJson(Map<String, dynamic> json) => DataSummaryDailyMedicine(
        penjualanObatHariIni: json["penjualan_obat_hari_ini"],
        hppHariIni: json["hpp_hari_ini"],
        labaKotorHariIni: json["laba_kotor_hari_ini"],
        labaBersihHariIni: json["laba_bersih_hari_ini"],
        feeDokterHariIni: json["fee_dokter_hari_ini"],
    );

    Map<String, dynamic> toJson() => {
        "penjualan_obat_hari_ini": penjualanObatHariIni,
        "hpp_hari_ini": hppHariIni,
        "laba_kotor_hari_ini": labaKotorHariIni,
        "laba_bersih_hari_ini": labaBersihHariIni,
        "fee_dokter_hari_ini": feeDokterHariIni,
    };
}
