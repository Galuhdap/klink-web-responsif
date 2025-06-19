import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:klinik_web_responsif/core/components/custom_tabel_component.dart';
import 'package:klinik_web_responsif/core/components/search_new_component.dart';
import 'package:klinik_web_responsif/core/resources/constans/app_constants.dart';
import 'package:klinik_web_responsif/core/styles/app_colors.dart';
import 'package:klinik_web_responsif/core/styles/app_sizes.dart';
import 'package:klinik_web_responsif/core/utils/extensions/date_ext.dart';
import 'package:klinik_web_responsif/core/utils/extensions/int_ext.dart';
import 'package:klinik_web_responsif/core/utils/extensions/sized_box_ext.dart';
import 'package:klinik_web_responsif/presentations/apotik/controller/apotik_controller.dart';
import 'package:klinik_web_responsif/presentations/apotik/screen/tabel/list_report_sale_tabel.dart';
import 'package:number_paginator/number_paginator.dart';

class ReportTransactionSellValidasi extends StatelessWidget {
  const ReportTransactionSellValidasi({
    super.key,
    required this.controller,
  });
  final ApotikController controller;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: ListView(
          children: [
            CustomTabelComponent(
              label:
                  'Laporan Transaksi Penjualan',
              sizeRowTabel:
                  MediaQuery.of(context)
                          .size
                          .width /
                      1.1,
              sizeWidth: MediaQuery.of(context)
                      .size
                      .width /
                  1,
              border: TableBorder.all(
                color: AppColors
                    .colorBaseSecondary
                    .withAlpha(50),
              ),
              customContentPagination: controller
                          .numberOfPageReportSale
                          .value ==
                      0
                  ? Container()
                  : Container(
                      width: double.infinity,
                      padding:
                          AppSizes.onlyPadding(
                              bottom:
                                  AppSizes.s50),
                      child: Column(
                        children: [
                          Container(
                            //width: 400,
                            decoration:
                                BoxDecoration(
                              color: AppColors
                                  .colorBaseWhite,
                              borderRadius:
                                  BorderRadius
                                      .circular(
                                          AppSizes
                                              .s4),
                            ),
                            child: Obx(() {
                              return NumberPaginator(
                                numberPages:
                                    controller
                                        .numberOfPageReportSale
                                        .value,
                                onPageChange:
                                    (int
                                        index) {
                                  final page =
                                      index + 1;
                                  final dateFormat =
                                      DateFormat(
                                          'yyyy-MM-dd');
                                  controller
                                      .getSaleReportMedicine(
                                    page: page,
                                    invoice: controller
                                        .noInvSearch
                                        .value,
                                    no_rekam_medis:
                                        controller
                                            .noRmeSearch
                                            .value,
                                    name: controller
                                        .namePasienSearch
                                        .value,
                                    start_date: controller
                                            .selectedDateRange
                                            .isNotEmpty
                                        ? dateFormat
                                            .format(controller.selectedDateRange[0]!)
                                        : "",
                                    end_date: controller
                                            .selectedDateRange
                                            .isNotEmpty
                                        ? dateFormat
                                            .format(controller.selectedDateRange[1]!)
                                        : "",
                                  );
                                },
                                child:
                                    const SizedBox(
                                  height: 48,
                                  width: 300,
                                  child: Row(
                                    children: [
                                      PrevButton(),
                                      Expanded(
                                        child:
                                            NumberContent(),
                                      ),
                                      NextButton(),
                                    ],
                                  ),
                                ),
                              );
                            }),
                          ),
                        ],
                      ),
                    ),
              customContentBottom: Column(
                children: [
                  Container(
                    width:
                        MediaQuery.of(context)
                                .size
                                .width /
                            1,
                    height: 1,
                    color: AppColors
                        .colorBaseSecondary,
                  ),
                  AppSizes.s20.height,
                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.end,
                    children: [
                      Text(
                        'Total Keseluruhan Penjualan',
                        style: Get.textTheme
                            .labelMedium!
                            .copyWith(
                          fontSize:
                              AppSizes.s16,
                          fontWeight:
                              FontWeight.bold,
                          color: AppColors
                              .colorBaseBlack,
                        ),
                      ),
                      AppSizes.s100.width,
                      Obx(() => Text(
                            controller
                                .totalSaleReport
                                .value
                                .currencyFormatRp,
                            style: Get.textTheme
                                .labelMedium!
                                .copyWith(
                              fontSize:
                                  AppSizes.s16,
                              fontWeight:
                                  FontWeight
                                      .bold,
                              color: AppColors
                                  .colorBaseBlack,
                            ),
                          )),
                    ],
                  ).paddingOnly(
                      right: AppSizes.s70,
                      bottom: AppSizes.s10),
                ],
              ),
              customContent: Row(
                children: [
                  Flexible(
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            offset:
                                const Offset(
                                    0, 0),
                            blurRadius: 15,
                            spreadRadius: 0,
                            color: AppColors
                                .colorNeutrals300
                                .withAlpha(40),
                          ),
                        ],
                      ),
                      child: SearchNewComponent(
                          controller: controller
                              .searchController,
                          keyboardType:
                              TextInputType
                                  .name,
                          hintText: AppConstants
                              .LABEL_CARI,
                          suffixIcon:
                              const Icon(
                            Icons.search,
                            color: AppColors
                                .colorSecondary500,
                          ),
                          onChanged: (value) {
                            final input =
                                value.trim();
                            final parts = input
                                .split(',')
                                .map((e) =>
                                    e.trim())
                                .toList();
    
                            String name = '';
                            String no_inv = '';
                            String no_rme = '';
    
                            for (var part
                                in parts) {
                              if (RegExp(
                                      r'^INV-\d+$')
                                  .hasMatch(
                                      part)) {
                                no_inv = part;
                              } else if (RegExp(
                                      r'^\d{6}$')
                                  .hasMatch(
                                      part)) {
                                no_rme = part;
                              } else {
                                name +=
                                    '$part ';
                              }
                            }
    
                            name = name.trim();
    
                            controller
                                .namePasienSearch
                                .value = name;
                            controller
                                .noInvSearch
                                .value = no_inv;
                            controller
                                .noRmeSearch
                                .value = no_rme;
    
                            final dateFormat =
                                DateFormat(
                                    'yyyy-MM-dd');
    
                            controller
                                .getSaleReportMedicine(
                              name: name,
                              no_rekam_medis:
                                  no_rme,
                              invoice: no_inv,
                              start_date: controller
                                      .selectedDateRange
                                      .isNotEmpty
                                  ? dateFormat.format(
                                      controller
                                          .selectedDateRange[0]!)
                                  : "",
                              end_date: controller
                                      .selectedDateRange
                                      .isNotEmpty
                                  ? dateFormat.format(
                                      controller
                                          .selectedDateRange[1]!)
                                  : "",
                            );
                          }),
                    ),
                  ),
                  AppSizes.s10.width,
                  InkWell(
                    onTap: () async {
                      List<DateTime?>?
                          selectedDates =
                          await showCalendarDatePicker2Dialog(
                        context: context,
                        config:
                            CalendarDatePicker2WithActionButtonsConfig(
                          calendarType:
                              CalendarDatePicker2Type
                                  .range,
                          firstDate:
                              DateTime(2000),
                          lastDate:
                              DateTime.now(),
                        ),
                        dialogSize: const Size(
                            325, 400),
                        value: controller
                            .selectedDateRange,
                        borderRadius:
                            BorderRadius
                                .circular(15),
                      );
    
                      if (selectedDates !=
                          null) {
                        controller
                                .selectedDateRange
                                .value =
                            selectedDates;
                        final dateFormat =
                            DateFormat(
                                'yyyy-MM-dd');
                        controller
                            .getSaleReportMedicine(
                          name: controller
                              .namePasienSearch
                              .value,
                          invoice: controller
                              .noInvSearch
                              .value,
                          no_rekam_medis:
                              controller
                                  .noRmeSearch
                                  .value,
                          start_date: dateFormat
                              .format(controller
                                      .selectedDateRange[
                                  0]!),
                          end_date: dateFormat
                              .format(controller
                                      .selectedDateRange[
                                  1]!),
                        );
                      }
                    },
                    child: Container(
                      width: 300,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius
                                .circular(
                                    AppSizes
                                        .s4),
                        border: Border.all(
                            color: Color(
                                0xfffF0F0F0)),
                        color: AppColors
                            .colorBaseWhite,
                        boxShadow: [
                          BoxShadow(
                            offset:
                                const Offset(
                                    0, 0),
                            blurRadius: 15,
                            spreadRadius: 0,
                            color: AppColors
                                .colorNeutrals300
                                .withAlpha(40),
                          ),
                        ],
                      ),
                      child: Row(
                        spacing: 20,
                        children: [
                          AppSizes.s10.width,
                          Icon(Icons
                              .calendar_month_rounded),
                          Text(
                            controller.selectedDateRange
                                        .isNotEmpty &&
                                    controller.selectedDateRange[
                                            0] !=
                                        null
                                ? '${controller.selectedDateRange[0]!.toDateddmmFormattedString()} - ${controller.selectedDateRange[1]!.toDateddmmFormattedString()}'
                                : 'Pilih Range Tanggal',
                            style: Get.textTheme
                                .labelMedium!
                                .copyWith(
                              fontSize:
                                  AppSizes.s14,
                              fontWeight:
                                  FontWeight
                                      .w100,
                              color: AppColors
                                  .colorBaseBlack,
                            ),
                          ),
                          AppSizes.s10.width,
                          controller
                                  .selectedDateRange
                                  .isNotEmpty
                              ? IconButton(
                                  onPressed:
                                      () {
                                    controller
                                        .selectedDateRange
                                        .value = [];
                                    controller.getSaleReportMedicine(
                                        start_date:
                                            "",
                                        end_date:
                                            "",
                                        invoice: controller
                                            .noInvSearch
                                            .value,
                                        no_rekam_medis: controller
                                            .noRmeSearch
                                            .value,
                                        name: controller
                                            .namePasienSearch
                                            .value);
                                  },
                                  icon: Icon(
                                    Icons
                                        .delete,
                                  ))
                              : Container(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              listColumns:
                  getListMedicineReportSaleColumns(),
              listRows: getRowsMedicineReportSale(
                  data: controller
                      .reportSaleMedicineList,
                  isLoading: controller
                      .isLoadingReportSale
                      .value,
                  controller: controller),
            ),
          ],
        ),
      );
  }
}