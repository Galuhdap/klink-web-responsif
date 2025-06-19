import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:klinik_web_responsif/core/components/card_dashboard_component.dart';
import 'package:klinik_web_responsif/core/styles/app_colors.dart';
import 'package:klinik_web_responsif/core/styles/app_sizes.dart';
import 'package:klinik_web_responsif/core/utils/extensions/int_ext.dart';
import 'package:klinik_web_responsif/core/utils/extensions/sized_box_ext.dart';
import 'package:klinik_web_responsif/presentations/apotik/controller/apotik_controller.dart';
import 'package:klinik_web_responsif/presentations/home/screen/stackholder/stackholder_screen.dart';
import 'package:klinik_web_responsif/presentations/report/controller/report_controller.dart';
import 'package:klinik_web_responsif/services/report/model/response/chart/daily_report_chart.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class GraphReportWidget extends StatelessWidget {
  const GraphReportWidget({
    super.key,
    required this.controller,
    required this.controllerReport,
  });

  final ApotikController controller;
  final ReportController controllerReport;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          spacing: AppSizes.s16,
          children: [
            Flexible(
                child: CardDashbordComponent(
              title: 'HPP Hari Ini',
              changeIcon: false,
              iconSaxChange: Iconsax.shopping_cart4,
              count: controller.isLoadingSummaryDailyMedicine.value
                  ? 'Load....'
                  : controller.summaryDailyMedicine.value!.hppHariIni == 0
                      ? 0.currencyFormatRp
                      : controller.summaryDailyMedicine.value!.hppHariIni
                          .currencyFormatRp,
            )),
            Flexible(
                child: CardDashbordComponent(
              title: 'Penjualan Obat Hari Ini',
              changeIcon: false,
              iconSaxChange: Iconsax.shopping_cart4,
              count: controller.isLoadingSummaryDailyMedicine.value
                  ? 'Load....'
                  : controller.summaryDailyMedicine.value!
                              .penjualanObatHariIni ==
                          0
                      ? 0.currencyFormatRp
                      : controller.summaryDailyMedicine.value!
                          .penjualanObatHariIni.currencyFormatRp,
            )),
          ],
        ),
        AppSizes.s20.height,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          spacing: AppSizes.s16,
          children: [
            Flexible(
              child: CardDashbordComponent(
                title: 'Laba Kotor Hari Ini',
                changeIcon: false,
                iconSaxChange: Iconsax.dollar_circle4,
                count: controller.isLoadingSummaryDailyMedicine.value
                    ? 'Load....'
                    : controller.summaryDailyMedicine.value!.labaKotorHariIni ==
                            0
                        ? 0.currencyFormatRp
                        : controller.summaryDailyMedicine.value!
                            .labaKotorHariIni.currencyFormatRp,
              ),
            ),
            Flexible(
              child: CardDashbordComponent(
                title: 'Laba Bersih Hari Ini',
                changeIcon: false,
                iconSaxChange: Iconsax.dollar_circle4,
                count: controller.isLoadingSummaryDailyMedicine.value
                    ? 'Load....'
                    : controller.summaryDailyMedicine.value!
                                .labaBersihHariIni ==
                            0
                        ? 0.currencyFormatRp
                        : controller.summaryDailyMedicine.value!
                            .labaBersihHariIni.currencyFormatRp,
              ),
            ),
          ],
        ),
        AppSizes.s20.height,
        Center(
          child: Container(
            width: double.infinity,
            height: 400,
            color: AppColors.colorBaseWhite,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppSizes.s20.height,
                Padding(
                  padding: EdgeInsets.only(left: 40),
                  child: Text(
                    'Tren Penjualan, HPP & Laba Harian',
                    style: Get.textTheme.bodyLarge!.copyWith(
                        fontSize: AppSizes.s18,
                        color: AppColors.colorBaseBlack,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                AppSizes.s20.height,
                Obx(() {
                  return controllerReport.dailyTrendChartList.isEmpty
                      ? Center(
                          child: Text('asdsad'),
                        )
                      : SfCartesianChart(
                          tooltipBehavior: controllerReport.tooltipBehavior,
                          primaryXAxis: DateTimeAxis(
                            majorGridLines: MajorGridLines(
                                width: 0, color: Colors.transparent),
                            axisLine: AxisLine(color: Colors.transparent),
                            labelStyle: Get.textTheme.labelMedium,
                            intervalType: DateTimeIntervalType.days,
                            dateFormat:
                                DateFormat('dd/MM'), // butuh import intl
                            majorTickLines: MajorTickLines(width: 0, size: 10),
                          ),
                          primaryYAxis: NumericAxis(
                            majorGridLines: MajorGridLines(
                                width: AppSizes.s1, color: Color(0xfffE5E5EF)),
                            axisLine: AxisLine(
                                width: AppSizes.s0, color: Colors.transparent),
                            isVisible: true,
                            majorTickLines:
                                MajorTickLines(width: AppSizes.s0, size: 5),
                          ),
                          series: <LineSeries<DailyReportChart, DateTime>>[
                            LineSeries<DailyReportChart, DateTime>(
                              // Bind data source
                              name: 'Penjualan',
                              dataSource: controllerReport.dailyChartDataSale,
                              xValueMapper: (DailyReportChart sales, _) =>
                                  sales.time,
                              yValueMapper: (DailyReportChart sales, _) =>
                                  sales.y,
                              markerSettings: MarkerSettings(
                                isVisible: true, // Aktifkan titik (dot)
                                shape: DataMarkerType
                                    .circle, // Bentuk dot (bisa square, diamond, dll)
                                width: 10, // Ukuran dot
                                height: 10,
                                borderColor: AppColors.colorBaseSuccess,
                                borderWidth: 2,
                              ),
                            ),
                            LineSeries<DailyReportChart, DateTime>(
                              // Bind data source
                              name: 'HPP',
                              dataSource: controllerReport.dailyChartDatasHpp,
                              xValueMapper: (DailyReportChart sales, _) =>
                                  sales.time,
                              yValueMapper: (DailyReportChart sales, _) =>
                                  sales.y,
                              markerSettings: MarkerSettings(
                                isVisible: true, // Aktifkan titik (dot)
                                shape: DataMarkerType
                                    .circle, // Bentuk dot (bisa square, diamond, dll)
                                width: 10, // Ukuran dot
                                height: 10,
                                borderColor: AppColors.colorBasePrimary,
                                borderWidth: 2,
                              ),
                            ),
                            LineSeries<DailyReportChart, DateTime>(
                              // Bind data source
                              name: 'LABA',
                              dataSource: controllerReport.dailyChartDataLaba,
                              xValueMapper: (DailyReportChart sales, _) =>
                                  sales.time,
                              yValueMapper: (DailyReportChart sales, _) =>
                                  sales.y,
                              markerSettings: MarkerSettings(
                                isVisible: true, // Aktifkan titik (dot)
                                shape: DataMarkerType
                                    .circle, // Bentuk dot (bisa square, diamond, dll)
                                width: 10, // Ukuran dot
                                height: 10,
                                borderColor: Color(0xfffC893FD),
                                borderWidth: 2,
                              ),
                            ),
                          ],
                        );
                })
              ],
            ),
          ),
        ),
        AppSizes.s20.height,
        Center(
          child: Container(
            width: double.infinity,
            height: 400,
            color: AppColors.colorBaseWhite,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppSizes.s20.height,
                Padding(
                  padding: EdgeInsets.only(left: 40),
                  child: Text(
                    'Daily Summary',
                    style: Get.textTheme.bodyLarge!.copyWith(
                        fontSize: AppSizes.s18,
                        color: AppColors.colorBaseBlack,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                AppSizes.s20.height,
                Obx(() {
                  return controllerReport.dailyTrendChartList.isEmpty
                      ? Center(
                          child: Text('asdsad'),
                        )
                      : SfCartesianChart(
                          tooltipBehavior: controllerReport.tooltipBehavior,
                          primaryXAxis: CategoryAxis(
                            majorGridLines: MajorGridLines(
                                width: 0, color: Colors.transparent),
                            axisLine: AxisLine(color: Colors.transparent),
                            labelStyle: Get.textTheme.labelMedium,
                            majorTickLines: MajorTickLines(width: 0, size: 10),
                          ),
                          primaryYAxis: NumericAxis(
                            majorGridLines: MajorGridLines(
                                width: AppSizes.s1, color: Color(0xfffE5E5EF)),
                            axisLine: AxisLine(
                                width: AppSizes.s0, color: Colors.transparent),
                            isVisible: true,
                            majorTickLines:
                                MajorTickLines(width: AppSizes.s0, size: 5),
                          ),
                          series: <CartesianSeries<DailyReportChart, String>>[
                            BarSeries<DailyReportChart, String>(
                              dataSource:
                                  controllerReport.dailySummarySaleChart,
                              xValueMapper: (DailyReportChart item, _) =>
                                  item.label ?? '',
                              yValueMapper: (DailyReportChart item, _) =>
                                  item.y,
                              name: 'Summary',
                              color: Color.fromRGBO(8, 142, 255, 1),
                              dataLabelSettings: DataLabelSettings(
                                  isVisible: true), // optional
                            )
                          ],
                        );
                })
              ],
            ),
          ),
        ),
      ],
    );
  }
}
