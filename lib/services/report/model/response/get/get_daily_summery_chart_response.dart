// To parse this JSON data, do
//
//     final getDailySummaryChart = getDailySummaryChartFromJson(jsonString);

import 'dart:convert';

GetDailySummaryChart getDailySummaryChartFromJson(String str) =>
    GetDailySummaryChart.fromJson(json.decode(str));

String getDailySummaryChartToJson(GetDailySummaryChart data) =>
    json.encode(data.toJson());

class GetDailySummaryChart {
  bool success;
  int code;
  String message;
  List<DatumDailySummury> data;

  GetDailySummaryChart({
    required this.success,
    required this.code,
    required this.message,
    required this.data,
  });

  factory GetDailySummaryChart.fromJson(Map<String, dynamic> json) =>
      GetDailySummaryChart(
        success: json["success"],
        code: json["code"],
        message: json["message"],
        data: List<DatumDailySummury>.from(
            json["data"].map((x) => DatumDailySummury.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "code": code,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class DatumDailySummury {
  String label;
  int total;

  DatumDailySummury({
    required this.label,
    required this.total,
  });

  factory DatumDailySummury.fromJson(Map<String, dynamic> json) =>
      DatumDailySummury(
        label: json["label"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "label": label,
        "total": total,
      };
}
