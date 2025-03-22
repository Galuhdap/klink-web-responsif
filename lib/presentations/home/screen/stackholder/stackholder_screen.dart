import 'package:flutter/material.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';

import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:klinik_web_responsif/core/components/button_component.dart';
import 'package:klinik_web_responsif/core/components/card_dashboard_component.dart';
import 'package:klinik_web_responsif/core/components/label_status_antrian_component.dart';
import 'package:klinik_web_responsif/core/components/search_new_component.dart';
import 'package:klinik_web_responsif/core/components/status_antrian_component.dart';
import 'package:klinik_web_responsif/core/config/responsive.dart';
import 'package:klinik_web_responsif/core/resources/constans/app_constants.dart';
import 'package:klinik_web_responsif/core/styles/app_colors.dart';
import 'package:klinik_web_responsif/core/styles/app_sizes.dart';
import 'package:klinik_web_responsif/core/utils/extensions/sized_box_ext.dart';
import 'package:klinik_web_responsif/presentations/home/controllers/home_controller.dart';
import 'package:klinik_web_responsif/presentations/menu_dashboard/widget/build_app_bar.dart';
import 'package:klinik_web_responsif/routes/app_routes.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class StackholderScreen extends StatefulWidget {
  const StackholderScreen({super.key});

  @override
  State<StackholderScreen> createState() => _StackholderScreenState();
}

class _StackholderScreenState extends State<StackholderScreen> {
  late TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
    super.initState();
    _tooltipBehavior = TooltipBehavior(enable: true);
  }

  @override
  Widget build(BuildContext context) {
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
                          CardDashbordComponent(
                            title: AppConstants.LABEL_PASIEN_BULAN_INI,
                            count: '20',
                          ),
                          CardDashbordComponent(
                            title: AppConstants.LABEL_PASIEN_TERDAFTAR,
                            count: '20',
                          ),
                        ],
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        spacing: AppSizes.s16,
                        children: [
                          Flexible(
                            child: CardDashbordComponent(
                              title: AppConstants.LABEL_PASIEN_BULAN_INI,
                              count: '20',
                            ),
                          ),
                          Flexible(
                            child: CardDashbordComponent(
                              title: AppConstants.LABEL_PASIEN_TERDAFTAR,
                              count: '20',
                            ),
                          ),
                        ],
                      ),
                AppSizes.s32.height,
                Container(
                  width: double.infinity,
                  padding: AppSizes.symmetricPadding(
                      vertical: AppSizes.s35, horizontal: AppSizes.s41),
                  decoration: BoxDecoration(
                    color: AppColors.colorBaseWhite,
                    borderRadius: BorderRadius.circular(AppSizes.s4),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (Responsive.isMobile(context)) ...[
                        Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                AppConstants.LABEL_TOTAL_PASIEN,
                                style: Get.textTheme.labelMedium!.copyWith(
                                    fontSize: AppSizes.s22,
                                    color: AppColors.colorBaseBlack,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                AppConstants.LABEL_STATISTIC,
                                style: Get.textTheme.labelMedium!.copyWith(
                                  fontSize: AppSizes.s18,
                                  color: AppColors.colorBaseBlack,
                                ),
                              ),
                              AppSizes.s10.height,
                            ],
                          ),
                        ),
                      ],
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          if (Responsive.isDesktop(context)) ...[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  AppConstants.LABEL_STATISTIC,
                                  style: Get.textTheme.labelMedium!.copyWith(
                                    fontSize: AppSizes.s18,
                                    color: AppColors.colorBaseBlack,
                                  ),
                                ),
                                AppSizes.s5.height,
                                Text(
                                  AppConstants.LABEL_TOTAL_PASIEN,
                                  style: Get.textTheme.labelMedium!.copyWith(
                                      fontSize: AppSizes.s22,
                                      color: AppColors.colorBaseBlack,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            )
                          ],
                          Row(
                            children: [
                              if (Responsive.isDesktop(context)) ...[
                                Row(
                                  children: [
                                    Container(
                                      width: 8,
                                      height: 8,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            AppSizes.s100),
                                        color: AppColors.colorBasePrimary,
                                      ),
                                    ),
                                    AppSizes.s8.width,
                                    Text(
                                      AppConstants.LABEL_LAKI_LAKI,
                                      style: Get.textTheme.bodyMedium!.copyWith(
                                          fontSize: AppSizes.s14,
                                          color: AppColors.colorBaseBlack),
                                    ),
                                  ],
                                ),
                                AppSizes.s70.width,
                                Row(
                                  children: [
                                    Container(
                                      width: 8,
                                      height: 8,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            AppSizes.s100),
                                        color: Color(0xfffC893FD),
                                      ),
                                    ),
                                    AppSizes.s8.width,
                                    Text(
                                      AppConstants.LABEL_PEREMPUAN,
                                      style: Get.textTheme.bodyMedium!.copyWith(
                                          fontSize: AppSizes.s14,
                                          color: AppColors.colorBaseBlack),
                                    ),
                                  ],
                                ),
                                AppSizes.s27.width,
                                Container(
                                  width: 281,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.circular(AppSizes.s4),
                                    border:
                                        Border.all(color: Color(0xfffF0F0F0)),
                                    color: AppColors.colorBaseWhite,
                                    boxShadow: [
                                      BoxShadow(
                                        offset: const Offset(0, 0),
                                        blurRadius: 15,
                                        spreadRadius: 0,
                                        color: AppColors.colorNeutrals300
                                            .withAlpha(40),
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    spacing: 20,
                                    children: [
                                      AppSizes.s10.width,
                                      Icon(Icons.calendar_month_rounded),
                                      Text(
                                        'Februari 2024',
                                        style:
                                            Get.textTheme.labelMedium!.copyWith(
                                          fontSize: AppSizes.s16,
                                          color: AppColors.colorBaseBlack,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ],
                      ),
                      if (Responsive.isMobile(context)) ...[
                        AppSizes.s10.height,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 8,
                                  height: 8,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.circular(AppSizes.s100),
                                    color: AppColors.colorBasePrimary,
                                  ),
                                ),
                                AppSizes.s8.width,
                                Text(
                                  AppConstants.LABEL_LAKI_LAKI,
                                  style: Get.textTheme.bodyMedium!.copyWith(
                                      fontSize: AppSizes.s14,
                                      color: AppColors.colorBaseBlack),
                                ),
                              ],
                            ),
                            AppSizes.s17.width,
                            Row(
                              children: [
                                Container(
                                  width: 8,
                                  height: 8,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.circular(AppSizes.s100),
                                    color: Color(0xfffC893FD),
                                  ),
                                ),
                                AppSizes.s8.width,
                                Text(
                                  AppConstants.LABEL_PEREMPUAN,
                                  style: Get.textTheme.bodyMedium!.copyWith(
                                      fontSize: AppSizes.s14,
                                      color: AppColors.colorBaseBlack),
                                ),
                              ],
                            ),
                          ],
                        ),
                        AppSizes.s17.height,
                        Center(
                          child: Container(
                            width: 281,
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(AppSizes.s4),
                              border: Border.all(color: Color(0xfffF0F0F0)),
                              color: AppColors.colorBaseWhite,
                              boxShadow: [
                                BoxShadow(
                                  offset: const Offset(0, 0),
                                  blurRadius: 15,
                                  spreadRadius: 0,
                                  color:
                                      AppColors.colorNeutrals300.withAlpha(40),
                                ),
                              ],
                            ),
                            child: Row(
                              spacing: 20,
                              children: [
                                AppSizes.s10.width,
                                Icon(Icons.calendar_month_rounded),
                                Text(
                                  'Februari 2024',
                                  style: Get.textTheme.labelMedium!.copyWith(
                                    fontSize: AppSizes.s16,
                                    color: AppColors.colorBaseBlack,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                Center(
                  child: Container(
                    width: double.infinity,
                    height: 500,
                    color: AppColors.colorBaseWhite,
                    child: SfCartesianChart(
                      tooltipBehavior: _tooltipBehavior,
                      primaryXAxis: NumericAxis(
                        majorGridLines: MajorGridLines(
                            width: AppSizes.s0, color: Colors.transparent),
                        axisLine: AxisLine(color: Colors.transparent),
                        labelStyle: Get.textTheme.labelMedium,
                        rangePadding: ChartRangePadding.additional,
                        interval: AppSizes.s1,
                        minimum: 0,
                        maximum: 30,
                        plotOffset: 20,
                        majorTickLines:
                            MajorTickLines(width: AppSizes.s0, size: 10),
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
                      series: <LineSeries<SalesData, int>>[
                        LineSeries<SalesData, int>(
                          // Bind data source
                          name: 'Laki-Laki',
                          dataSource: <SalesData>[
                            SalesData(0, 40),
                            SalesData(1, 35),
                            SalesData(2, 28),
                            SalesData(3, 34),
                            SalesData(4, 32),
                            SalesData(5, 20),
                            SalesData(6, 90),
                          ],
                          xValueMapper: (SalesData sales, _) => sales.year,
                          yValueMapper: (SalesData sales, _) => sales.sales,
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
                        LineSeries<SalesData, int>(
                          // Bind data source
                          name: 'Perempuan',
                          dataSource: <SalesData>[
                            SalesData(0, 20),
                            SalesData(1, 20),
                            SalesData(2, 40),
                            SalesData(3, 24),
                            SalesData(4, 80),
                            SalesData(5, 40),
                            SalesData(6, 20),
                          ],
                          xValueMapper: (SalesData sales, _) => sales.year,
                          yValueMapper: (SalesData sales, _) => sales.sales,
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
                    ),
                  ),
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
