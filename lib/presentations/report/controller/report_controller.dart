import 'dart:developer';

import 'package:get/get.dart';
import 'package:klinik_web_responsif/di/application_module.dart';
import 'package:klinik_web_responsif/services/report/model/response/chart/daily_report_chart.dart';
import 'package:klinik_web_responsif/services/report/model/response/get/ger_report_count_patient_response.dart';
import 'package:klinik_web_responsif/services/report/model/response/get/get_daily_sale_medicine_response.dart';
import 'package:klinik_web_responsif/services/report/model/response/get/get_daily_summery_chart_response.dart';
import 'package:klinik_web_responsif/services/report/model/response/get/get_daily_trend_chart.dart';
import 'package:klinik_web_responsif/services/report/model/response/get/get_report_docter_fee_response.dart';
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

  RxList<DatumCountPatient> getCountPatientList = <DatumCountPatient>[].obs;
  RxList<DailyReportChart> getCountPatient = <DailyReportChart>[].obs;

  RxList<DatumDocterFee> getDoterFeeList = <DatumDocterFee>[].obs;
  RxList<DailyReportChart> getDocterFee = <DailyReportChart>[].obs;

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
    getReportCountPatient();
    getReportDocterFee();
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

/////////////////////////////////////////////////////////////////////////////////
  Future<void> getReportCountPatient() async {
    isLoadingDailyTrendChart.value = true;
    try {
      final response = await reportRepository.getReportCountPatient();

      response.fold(
        (failure) {
          inspect(failure.code);
        },
        (response) async {
          getCountPatientList.clear();
          getCountPatientList.addAll(response.data);
          getCountPatient.value = chartDataCountPatient(response.data);
        },
      );
    } catch (e) {
      print('e:$e');
    } finally {
      isLoadingDailyTrendChart.value = false;
    }
  }

  List<DailyReportChart> chartDataCountPatient(
      List<DatumCountPatient> listCommodityGrafilDailys) {
    return List<DailyReportChart>.generate(getCountPatientList.length, (index) {
      bool isDailyDataAvailable = listCommodityGrafilDailys.isNotEmpty &&
          index < getCountPatientList.length;
      return DailyReportChart(
        x: index,
        y: isDailyDataAvailable ? getCountPatientList[index].count : 0,
        time: isDailyDataAvailable
            ? getCountPatientList[index].date
            : DateTime.now().subtract(Duration(days: 7)),
      );
    });
  }

  /////////////////////////////////////////////////////////////////////////////////
  Future<void> getReportDocterFee() async {
    isLoadingDailyTrendChart.value = true;
    try {
      final response = await reportRepository.getReportDocterFee();

      response.fold(
        (failure) {
          inspect(failure.code);
        },
        (response) async {
          getDoterFeeList.clear();
          getDoterFeeList.addAll(response.data);
          getDocterFee.value = chartDataDocterFee(response.data);
        },
      );
    } catch (e) {
      print('e:$e');
    } finally {
      isLoadingDailyTrendChart.value = false;
    }
  }

  List<DailyReportChart> chartDataDocterFee(
      List<DatumDocterFee> listCommodityGrafilDailys) {
    return List<DailyReportChart>.generate(getDoterFeeList.length, (index) {
      bool isDailyDataAvailable = listCommodityGrafilDailys.isNotEmpty &&
          index < getDoterFeeList.length;
      return DailyReportChart(
        x: index,
        y: isDailyDataAvailable ? getDoterFeeList[index].totalFee : 0,
        label: isDailyDataAvailable ? getDoterFeeList[index].doctorName : '',
      );
    });
  }
}
