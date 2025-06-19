import 'package:dartz/dartz.dart';
import 'package:klinik_web_responsif/core/utils/extensions/datasources/failure.dart';
import 'package:klinik_web_responsif/services/report/model/response/get/get_daily_summery_chart_response.dart';
import 'package:klinik_web_responsif/services/report/model/response/get/get_daily_trend_chart.dart';
import 'package:klinik_web_responsif/services/report/report_datasources.dart';

class ReportRepository {
  final ReportDatasources source;

  ReportRepository(this.source);

  Future<Either<Failure, GetDailyTrendChart>> getDailyTrendChart() async {
    return source.getChartReportDaily();
  }
  Future<Either<Failure, GetDailySummaryChart>> getDailySummaryChart() async {
    return source.getChartReportDailySummary();
  }
}
