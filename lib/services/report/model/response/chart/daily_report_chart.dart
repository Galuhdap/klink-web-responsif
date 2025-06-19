import 'package:flutter/material.dart';

class DailyReportChart {
  DailyReportChart({
    this.x,
    this.time,
    this.y,
    this.label,
  });
  final int? x;
  final int? y;
  final DateTime? time;
  final String? label;
}

class ChartDataPie {
  ChartDataPie(this.x, this.y, [this.color]);
  final String x;
  final int y;
  final Color? color;
}
