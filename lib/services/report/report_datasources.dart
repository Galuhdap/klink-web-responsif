import 'package:dartz/dartz.dart';
import 'package:klinik_web_responsif/core/utils/extensions/datasources/failure.dart';
import 'package:klinik_web_responsif/core/utils/preferences/shared_preferences_utils.dart';
import 'package:klinik_web_responsif/services/lib/api_services.dart';
import 'package:klinik_web_responsif/services/lib/network_constants.dart';
import 'package:klinik_web_responsif/services/report/model/response/get/get_daily_sale_medicine_response.dart';
import 'package:klinik_web_responsif/services/report/model/response/get/get_daily_summery_chart_response.dart';
import 'package:klinik_web_responsif/services/report/model/response/get/get_report_medicine_low_stock_response.dart';

import 'model/response/get/get_daily_trend_chart.dart';

class ReportDatasources extends ApiService {
  Future<Either<Failure, GetDailyTrendChart>> getChartReportDaily() async {
    final prefs = await SharedPreferencesUtils.getAuthToken();

    try {
      final response =
          await get(NetworkConstants.GET_CHART_REPORT_DAILY_URL(), header: {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${prefs}",
      });

      return Right(GetDailyTrendChart.fromJson(response));
    } catch (e) {
      return left(Failure(false, 400, 'Data Tidak Masuk'));
    }
  }

  Future<Either<Failure, GetDailySummaryChart>> getChartReportDailySummary() async {
    final prefs = await SharedPreferencesUtils.getAuthToken();
    

    try {
      final response =
          await get(NetworkConstants.GET_CHART_REPORT_DAILY_SUMMARY_URL(), header: {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${prefs}",
      });

      return Right(GetDailySummaryChart.fromJson(response));
    } catch (e) {
      return left(Failure(false, 400, 'Data Tidak Masuk'));
    }
  }

  Future<Either<Failure, GetDailyMedicineChartResponse>> getChartReportDailySaleMedicine() async {
    final prefs = await SharedPreferencesUtils.getAuthToken();

    try {
      final response =
          await get(NetworkConstants.GET_CHART_REPORT_DAILY_SALE_MEDICINE_URL(), header: {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${prefs}",
      });

      return Right(GetDailyMedicineChartResponse.fromJson(response));
    } catch (e) {
      return left(Failure(false, 400, 'Data Tidak Masuk'));
    }
  }

  Future<Either<Failure, GetReportMedicineStockLowResponse>> getReportMedicineSellStock() async {
    final prefs = await SharedPreferencesUtils.getAuthToken();

    try {
      final response =
          await get(NetworkConstants.GET_REPORT_SELL_LOW_MEDICINE_URL(), header: {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${prefs}",
      });

      return Right(GetReportMedicineStockLowResponse.fromJson(response));
    } catch (e) {
      return left(Failure(false, 400, 'Data Tidak Masuk'));
    }
  }
}
