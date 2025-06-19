// To parse this JSON data, do
//
//     final getDailyMedicineChartResponse = getDailyMedicineChartResponseFromJson(jsonString);

import 'dart:convert';

GetDailyMedicineChartResponse getDailyMedicineChartResponseFromJson(String str) => GetDailyMedicineChartResponse.fromJson(json.decode(str));

String getDailyMedicineChartResponseToJson(GetDailyMedicineChartResponse data) => json.encode(data.toJson());

class GetDailyMedicineChartResponse {
    bool success;
    int code;
    String message;
    List<DatumDailySaleMedicine> data;

    GetDailyMedicineChartResponse({
        required this.success,
        required this.code,
        required this.message,
        required this.data,
    });

    factory GetDailyMedicineChartResponse.fromJson(Map<String, dynamic> json) => GetDailyMedicineChartResponse(
        success: json["success"],
        code: json["code"],
        message: json["message"],
        data: List<DatumDailySaleMedicine>.from(json["data"].map((x) => DatumDailySaleMedicine.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "code": code,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class DatumDailySaleMedicine {
    DateTime date;
    int total;

    DatumDailySaleMedicine({
        required this.date,
        required this.total,
    });

    factory DatumDailySaleMedicine.fromJson(Map<String, dynamic> json) => DatumDailySaleMedicine(
        date: DateTime.parse(json["date"]),
        total: json["total"],
    );

    Map<String, dynamic> toJson() => {
        "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "total": total,
    };
}
