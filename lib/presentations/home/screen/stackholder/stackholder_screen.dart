import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:klinik_web_responsif/core/components/card_dashboard_component.dart';
import 'package:klinik_web_responsif/core/config/responsive.dart';
import 'package:klinik_web_responsif/core/resources/constans/app_constants.dart';
import 'package:klinik_web_responsif/core/styles/app_colors.dart';
import 'package:klinik_web_responsif/core/styles/app_sizes.dart';
import 'package:klinik_web_responsif/core/utils/extensions/sized_box_ext.dart';
import 'package:klinik_web_responsif/presentations/apotik/controller/apotik_controller.dart';
import 'package:klinik_web_responsif/presentations/home/controllers/home_controller.dart';
import 'package:klinik_web_responsif/presentations/home/widgets/card_apotik_dashboard_widget.dart';
import 'package:klinik_web_responsif/presentations/menu_dashboard/widget/build_app_bar.dart';
import 'package:klinik_web_responsif/presentations/report/controller/report_controller.dart';
import 'package:klinik_web_responsif/presentations/report/widget/graphic_widget.dart';
import 'package:klinik_web_responsif/services/report/model/response/chart/daily_report_chart.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class StackholderScreen extends StatefulWidget {
  const StackholderScreen({super.key});

  @override
  State<StackholderScreen> createState() => _StackholderScreenState();
}

class _StackholderScreenState extends State<StackholderScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var controllerApotik = Get.put(ApotikController());
    var controllerReport = Get.put(ReportController());
    return GetBuilder<HomeController>(
        init: HomeController(),
        builder: (controller) {
          return Scaffold(
            backgroundColor: Color(0xfffF8F8F8),
            appBar: PreferredSize(
              preferredSize: Responsive.isMobile(context)
                  ? Size.fromHeight(90.0)
                  : Size.fromHeight(110.0),
              child: BuildAppBar(
                title: 'Klinik Chania Care Center',
                withSearchInput: true,
                searchController: TextEditingController(),
                searchHint: 'Cari Pasien',
                searchChanged: (_) {},
              ),
            ),
            body: ListView(
              children: [
                Responsive.isMobile(context)
                    ? Column(
                        spacing: AppSizes.s16,
                        children: [
                          Obx(() => CardDashbordComponent(
                                title: AppConstants.LABEL_PASIEN_BULAN_INI,
                                count: controller.isLoadingTotal.value
                                    ? 'Load...'
                                    : controller.totalPasien.value == ''
                                        ? '-'
                                        : controller.totalPasien.value!.data
                                            .pasienBaruBulanIni
                                            .toString(),
                              )),
                          Obx(
                            () => CardDashbordComponent(
                              title: AppConstants.LABEL_PASIEN_TERDAFTAR,
                              count: controller.isLoadingTotal.value
                                  ? 'Load...'
                                  : controller.totalPasien.value == ''
                                      ? '-'
                                      : controller
                                          .totalPasien.value!.data.totalPasien
                                          .toString(),
                            ),
                          ),
                        ],
                      )
                    : Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            spacing: AppSizes.s16,
                            children: [
                              Flexible(
                                child: Obx(() => CardDashbordComponent(
                                      title:
                                          AppConstants.LABEL_PASIEN_BULAN_INI,
                                      count: controller.isLoadingTotal.value
                                          ? 'Load...'
                                          : controller.totalPasien.value == ''
                                              ? '-'
                                              : controller.totalPasien.value!
                                                  .data.pasienBaruBulanIni
                                                  .toString(),
                                    )),
                              ),
                              Flexible(
                                child: Obx(() => CardDashbordComponent(
                                      title:
                                          AppConstants.LABEL_PASIEN_TERDAFTAR,
                                      count: controller.isLoadingTotal.value
                                          ? 'Load...'
                                          : controller.totalPasien.value == ''
                                              ? '-'
                                              : controller.totalPasien.value!
                                                  .data.totalPasien
                                                  .toString(),
                                    )),
                              ),
                            ],
                          ),
                          AppSizes.s20.height,
                          CardApotikDashbordWidget(
                            controller: controllerApotik,
                            owner: true,
                          ),
                        ],
                      ),
                AppSizes.s32.height,
                Row(
                  children: [
                    Flexible(
                      child: GraphicWidget(
                        label: 'Pasien Periksa per Hari',
                        content: Obx(
                          () {
                            return controllerReport.getCountPatientList.isEmpty
                                ? Center(
                                    child: Text('Data Kosong'),
                                  )
                                : SfCartesianChart(
                                    tooltipBehavior:
                                        controllerReport.tooltipBehavior,
                                    primaryXAxis: DateTimeAxis(
                                      majorGridLines: MajorGridLines(
                                          width: 0, color: Colors.transparent),
                                      axisLine:
                                          AxisLine(color: Colors.transparent),
                                      labelStyle: Get.textTheme.labelMedium,
                                      intervalType: DateTimeIntervalType.days,
                                      dateFormat: DateFormat(
                                          'd MMM'), // butuh import intl
                                      majorTickLines:
                                          MajorTickLines(width: 0, size: 10),
                                    ),
                                    primaryYAxis: NumericAxis(
                                      majorGridLines: MajorGridLines(
                                          width: AppSizes.s1,
                                          color: Color(0xfffE5E5EF)),
                                      axisLine: AxisLine(
                                          width: AppSizes.s0,
                                          color: Colors.transparent),
                                      isVisible: true,
                                      majorTickLines: MajorTickLines(
                                          width: AppSizes.s0, size: 5),
                                    ),
                                    series: <LineSeries<DailyReportChart,
                                        DateTime>>[
                                      LineSeries<DailyReportChart, DateTime>(
                                        // Bind data source
                                        name: 'Paseint',
                                        dataSource:
                                            controllerReport.getCountPatient,
                                        xValueMapper:
                                            (DailyReportChart sales, _) =>
                                                sales.time,
                                        yValueMapper:
                                            (DailyReportChart sales, _) =>
                                                sales.y,
                                        markerSettings: MarkerSettings(
                                          isVisible:
                                              true, // Aktifkan titik (dot)
                                          shape: DataMarkerType
                                              .circle, // Bentuk dot (bisa square, diamond, dll)
                                          width: 10, // Ukuran dot
                                          height: 10,
                                          borderColor:
                                              AppColors.colorBaseSuccess,
                                          borderWidth: 2,
                                        ),
                                      ),
                                    ],
                                  );
                          },
                        ),
                      ),
                    ),
                    AppSizes.s20.width,
                    Flexible(
                      child: GraphicWidget(
                        label: 'Top 5 Obat Paling Laris',
                        content: Obx(
                          () {
                            return controllerApotik.topFiveMedicineList.isEmpty
                                ? Center(
                                    child: Text('asdsad'),
                                  )
                                : SfCircularChart(
                                    tooltipBehavior:
                                        controllerApotik.tooltipBehavior,
                                    series: <CircularSeries>[
                                      // Render pie chart
                                      PieSeries<ChartDataPie, String>(
                                        dataSource:
                                            controllerApotik.dailyChartDatas,
                                        pointColorMapper:
                                            (ChartDataPie data, _) =>
                                                data.color,
                                        xValueMapper: (ChartDataPie data, _) =>
                                            data.x,
                                        yValueMapper: (ChartDataPie data, _) =>
                                            data.y,
                                      )
                                    ],
                                  );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ).paddingSymmetric(
              vertical: AppSizes.s41,
              horizontal: AppSizes.s28,
            ),
          );
        });
  }
}

class SalesData {
  SalesData(this.year, this.sales);
  final int year;
  final double sales;
}
