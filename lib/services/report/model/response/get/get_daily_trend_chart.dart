// To parse this JSON data, do
//
//     final getDailyTrendChart = getDailyTrendChartFromJson(jsonString);

import 'dart:convert';

GetDailyTrendChart getDailyTrendChartFromJson(String str) => GetDailyTrendChart.fromJson(json.decode(str));

String getDailyTrendChartToJson(GetDailyTrendChart data) => json.encode(data.toJson());

class GetDailyTrendChart {
    bool success;
    int code;
    String message;
    List<DatumDailyTrendChart> data;

    GetDailyTrendChart({
        required this.success,
        required this.code,
        required this.message,
        required this.data,
    });

    factory GetDailyTrendChart.fromJson(Map<String, dynamic> json) => GetDailyTrendChart(
        success: json["success"],
        code: json["code"],
        message: json["message"],
        data: List<DatumDailyTrendChart>.from(json["data"].map((x) => DatumDailyTrendChart.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "code": code,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class DatumDailyTrendChart {
    DateTime tanggal;
    int penjualan;
    int hpp;
    int laba;

    DatumDailyTrendChart({
        required this.tanggal,
        required this.penjualan,
        required this.hpp,
        required this.laba,
    });

    factory DatumDailyTrendChart.fromJson(Map<String, dynamic> json) => DatumDailyTrendChart(
        tanggal: DateTime.parse(json["tanggal"]),
        penjualan: json["penjualan"],
        hpp: json["hpp"],
        laba: json["laba"],
    );

    Map<String, dynamic> toJson() => {
        "tanggal": "${tanggal.year.toString().padLeft(4, '0')}-${tanggal.month.toString().padLeft(2, '0')}-${tanggal.day.toString().padLeft(2, '0')}",
        "penjualan": penjualan,
        "hpp": hpp,
        "laba": laba,
    };
}
