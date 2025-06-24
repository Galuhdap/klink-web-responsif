import 'package:dartz/dartz.dart';
import 'package:klinik_web_responsif/core/utils/extensions/datasources/failure.dart';
import 'package:klinik_web_responsif/services/report/model/response/get/ger_report_count_patient_response.dart';
import 'package:klinik_web_responsif/services/report/model/response/get/get_daily_sale_medicine_response.dart';
import 'package:klinik_web_responsif/services/report/model/response/get/get_daily_summery_chart_response.dart';
import 'package:klinik_web_responsif/services/report/model/response/get/get_daily_trend_chart.dart';
import 'package:klinik_web_responsif/services/report/model/response/get/get_report_docter_fee_response.dart';
import 'package:klinik_web_responsif/services/report/model/response/get/get_report_medicine_low_stock_response.dart';
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

  Future<Either<Failure, GetDailyMedicineChartResponse>>
      getDailySellMedicineChart() async {
    return source.getChartReportDailySaleMedicine();
  }

  Future<Either<Failure, GetReportMedicineStockLowResponse>>
      getReportMedicineSellStock() async {
    return source.getReportMedicineSellStock();
  }

  Future<Either<Failure, GetReportCountPastienResponse>>
      getReportCountPatient() async {
    return source.getReportCountPatient();
  }

  Future<Either<Failure, GetReportDocterFeeResponse>>
      getReportDocterFee() async {
    return source.getReportDocterFee();
  }
}
