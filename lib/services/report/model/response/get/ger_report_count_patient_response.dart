// To parse this JSON data, do
//
//     final getReportCountPastienResponse = getReportCountPastienResponseFromJson(jsonString);

import 'dart:convert';

GetReportCountPastienResponse getReportCountPastienResponseFromJson(String str) => GetReportCountPastienResponse.fromJson(json.decode(str));

String getReportCountPastienResponseToJson(GetReportCountPastienResponse data) => json.encode(data.toJson());

class GetReportCountPastienResponse {
    bool success;
    int code;
    String message;
    List<DatumCountPatient> data;

    GetReportCountPastienResponse({
        required this.success,
        required this.code,
        required this.message,
        required this.data,
    });

    factory GetReportCountPastienResponse.fromJson(Map<String, dynamic> json) => GetReportCountPastienResponse(
        success: json["success"],
        code: json["code"],
        message: json["message"],
        data: List<DatumCountPatient>.from(json["data"].map((x) => DatumCountPatient.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "code": code,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class DatumCountPatient {
    DateTime date;
    int count;

    DatumCountPatient({
        required this.date,
        required this.count,
    });

    factory DatumCountPatient.fromJson(Map<String, dynamic> json) => DatumCountPatient(
        date: DateTime.parse(json["date"]),
        count: json["count"],
    );

    Map<String, dynamic> toJson() => {
        "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "count": count,
    };
}
