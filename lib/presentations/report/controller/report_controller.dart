import 'dart:developer';

import 'package:get/get.dart';
import 'package:klinik_web_responsif/di/application_module.dart';
import 'package:klinik_web_responsif/services/report/model/response/chart/daily_report_chart.dart';
import 'package:klinik_web_responsif/services/report/model/response/get/get_daily_sale_medicine_response.dart';
import 'package:klinik_web_responsif/services/report/model/response/get/get_daily_summery_chart_response.dart';
import 'package:klinik_web_responsif/services/report/model/response/get/get_daily_trend_chart.dart';
import 'package:klinik_web_responsif/services/report/model/response/get/get_report_medicine_low_stock_response.dart';
import 'package:klinik_web_responsif/services/report/report_repository.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ReportController extends GetxController {
  final ReportRepository reportRepository = locator();
  late TooltipBehavior tooltipBehavior;

  RxList<DatumDailyTrendChart> dailyTrendChartList =
      <DatumDailyTrendChart>[].obs;
  RxList<DailyReportChart> dailyChartDatasHpp = <DailyReportChart>[].obs;
  RxList<DailyReportChart> dailyChartDataLaba = <DailyReportChart>[].obs;
  RxList<DailyReportChart> dailyChartDataSale = <DailyReportChart>[].obs;

  RxList<DatumDailySummury> dailySummaryChartList = <DatumDailySummury>[].obs;
  RxList<DailyReportChart> dailySummarySaleChart = <DailyReportChart>[].obs;

  RxList<DatumDailySaleMedicine> dailySellMedicineList =
      <DatumDailySaleMedicine>[].obs;
  RxList<DailyReportChart> dailySellMedicineChart = <DailyReportChart>[].obs;

  RxList<DatumLowStockMedicine> getMedicineStockLowList =
      <DatumLowStockMedicine>[].obs;
  RxList<DailyReportChart> getMedicineStockLow = <DailyReportChart>[].obs;

  RxInt buyMedicineToday = 0.obs;

  RxBool isLoadingDailyTrendChart = false.obs;

  RxInt selectedX = 0.obs;
  RxDouble selectedY = 0.0.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    tooltipBehavior = TooltipBehavior(enable: true);
    getDailyTrendChart();
    getDailySummaryBar();
    getDailySellMedicine();
    getReportMedicineStcokLow();
  }

  Future<void> getDailyTrendChart() async {
    isLoadingDailyTrendChart.value = true;
    try {
      final response = await reportRepository.getDailyTrendChart();

      response.fold(
        (failure) {
          inspect(failure.code);
        },
        (response) async {
          dailyTrendChartList.clear();
          dailyTrendChartList.addAll(response.data);
          dailyChartDatasHpp.value = chartDataHppTrend(dailyTrendChartList);
          dailyChartDataLaba.value = chartDataLabaTrend(dailyTrendChartList);
          dailyChartDataSale.value =
              chartDataSaleDailyTrend(dailyTrendChartList);
          inspect(dailyChartDatasHpp);
          inspect(dailyChartDataLaba);
          inspect(dailyChartDataLaba);
        },
      );
      isLoadingDailyTrendChart.value = false;
    } catch (e) {
      print('e:$e');
      isLoadingDailyTrendChart.value = false;
    }
  }

  List<DailyReportChart> chartDataHppTrend(
      List<DatumDailyTrendChart> listCommodityGrafilDailys) {
    return List<DailyReportChart>.generate(listCommodityGrafilDailys.length,
        (index) {
      bool isDailyDataAvailable = listCommodityGrafilDailys.isNotEmpty &&
          index < dailyTrendChartList.length;
      return DailyReportChart(
        x: index,
        y: isDailyDataAvailable ? dailyTrendChartList[index].hpp.toInt() : 0,
        time: isDailyDataAvailable
            ? dailyTrendChartList[index].tanggal
            : DateTime.now().subtract(Duration(days: 7)),
      );
    });
  }

  List<DailyReportChart> chartDataLabaTrend(
      List<DatumDailyTrendChart> listCommodityGrafilDailys) {
    return List<DailyReportChart>.generate(dailyTrendChartList.length, (index) {
      bool isDailyDataAvailable = listCommodityGrafilDailys.isNotEmpty &&
          index < dailyTrendChartList.length;
      return DailyReportChart(
        x: index,
        y: isDailyDataAvailable ? dailyTrendChartList[index].laba.toInt() : 0,
        time: isDailyDataAvailable
            ? dailyTrendChartList[index].tanggal
            : DateTime.now().subtract(Duration(days: 7)),
      );
    });
  }

  List<DailyReportChart> chartDataSaleDailyTrend(
      List<DatumDailyTrendChart> listCommodityGrafilDailys) {
    return List<DailyReportChart>.generate(dailyTrendChartList.length, (index) {
      bool isDailyDataAvailable = listCommodityGrafilDailys.isNotEmpty &&
          index < dailyTrendChartList.length;
      return DailyReportChart(
        x: index,
        y: isDailyDataAvailable
            ? dailyTrendChartList[index].penjualan.toInt()
            : 0,
        time: isDailyDataAvailable
            ? dailyTrendChartList[index].tanggal
            : DateTime.now().subtract(Duration(days: 7)),
      );
    });
  }

  /////////////////////////////////////////////////////////////////
  Future<void> getDailySummaryBar() async {
    isLoadingDailyTrendChart.value = true;
    try {
      final response = await reportRepository.getDailySummaryChart();

      response.fold(
        (failure) {
          inspect(failure.code);
        },
        (response) async {
          dailySummaryChartList.clear();
          dailySummaryChartList.addAll(response.data);
          dailySummarySaleChart.value = chartDataSaleDilySummary(response.data);
        },
      );
    } catch (e) {
      print('e:$e');
    } finally {
      isLoadingDailyTrendChart.value = false;
    }
  }

  List<DailyReportChart> chartDataSaleDilySummary(
      List<DatumDailySummury> listCommodityGrafilDailys) {
    return List<DailyReportChart>.generate(dailySummaryChartList.length,
        (index) {
      bool isDailyDataAvailable = listCommodityGrafilDailys.isNotEmpty &&
          index < dailySummaryChartList.length;
      return DailyReportChart(
        x: index,
        y: isDailyDataAvailable ? dailySummaryChartList[index].total : 0,
        label: isDailyDataAvailable ? dailySummaryChartList[index].label : '',
      );
    });
  }

/////////////////////////////////////////////////////////////////////////////////
  Future<void> getDailySellMedicine() async {
    isLoadingDailyTrendChart.value = true;
    try {
      final response = await reportRepository.getDailySellMedicineChart();

      response.fold(
        (failure) {
          inspect(failure.code);
        },
        (response) async {
          dailySellMedicineList.clear();
          dailySellMedicineList.addAll(response.data);
          dailySellMedicineChart.value =
              chartDataSaleMedicineDaily(response.data);
        },
      );
    } catch (e) {
      print('e:$e');
    } finally {
      isLoadingDailyTrendChart.value = false;
    }
  }

  List<DailyReportChart> chartDataSaleMedicineDaily(
      List<DatumDailySaleMedicine> listCommodityGrafilDailys) {
    return List<DailyReportChart>.generate(dailySellMedicineList.length,
        (index) {
      bool isDailyDataAvailable = listCommodityGrafilDailys.isNotEmpty &&
          index < dailySellMedicineList.length;
      return DailyReportChart(
        x: index,
        y: isDailyDataAvailable ? dailySellMedicineList[index].total : 0,
        time: isDailyDataAvailable
            ? dailySellMedicineList[index].date
            : DateTime.now().subtract(Duration(days: 7)),
      );
    });
  }

/////////////////////////////////////////////////////////////////////////////////
  Future<void> getReportMedicineStcokLow() async {
    isLoadingDailyTrendChart.value = true;
    try {
      final response = await reportRepository.getReportMedicineSellStock();

      response.fold(
        (failure) {
          inspect(failure.code);
        },
        (response) async {
          getMedicineStockLowList.clear();
          getMedicineStockLowList.addAll(response.data);
          getMedicineStockLow.value = chartDataMedicineStockLow(response.data);
        },
      );
    } catch (e) {
      print('e:$e');
    } finally {
      isLoadingDailyTrendChart.value = false;
    }
  }

  List<DailyReportChart> chartDataMedicineStockLow(
      List<DatumLowStockMedicine> listCommodityGrafilDailys) {
    return List<DailyReportChart>.generate(getMedicineStockLowList.length,
        (index) {
      bool isDailyDataAvailable = listCommodityGrafilDailys.isNotEmpty &&
          index < getMedicineStockLowList.length;
      return DailyReportChart(
        x: index,
        y: isDailyDataAvailable ? getMedicineStockLowList[index].totalStock : 0,
        label: isDailyDataAvailable ? getMedicineStockLowList[index].name : '',
      );
    });
  }
}
