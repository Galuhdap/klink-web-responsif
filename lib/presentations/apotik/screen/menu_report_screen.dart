import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:klinik_web_responsif/core/components/custom_tabel_component.dart';
import 'package:klinik_web_responsif/core/components/list_mobile_component.dart';
import 'package:klinik_web_responsif/core/components/search_new_component.dart';
import 'package:klinik_web_responsif/core/config/responsive.dart';
import 'package:klinik_web_responsif/core/resources/constans/app_constants.dart';
import 'package:klinik_web_responsif/core/styles/app_colors.dart';
import 'package:klinik_web_responsif/core/styles/app_sizes.dart';
import 'package:klinik_web_responsif/core/utils/extensions/date_ext.dart';
import 'package:klinik_web_responsif/core/utils/extensions/int_ext.dart';
import 'package:klinik_web_responsif/core/utils/extensions/sized_box_ext.dart';
import 'package:klinik_web_responsif/presentations/apotik/controller/apotik_controller.dart';
import 'package:klinik_web_responsif/presentations/apotik/screen/mobile/medicine_menu_report_list_mobile.dart';
import 'package:klinik_web_responsif/presentations/apotik/screen/tabel/list_detail_report_buy_tabel.dart';
import 'package:klinik_web_responsif/presentations/apotik/screen/tabel/list_report_buy_tabel.dart';
import 'package:klinik_web_responsif/presentations/apotik/widget/tab_medicine_widget.dart';
import 'package:klinik_web_responsif/presentations/menu_dashboard/widget/build_app_bar.dart';
import 'package:number_paginator/number_paginator.dart';

class MenuReportScreen extends StatelessWidget {
  const MenuReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ApotikController>(
      init: ApotikController(),
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
            physics: NeverScrollableScrollPhysics(),
            children: [
              Row(
                children: [
                  Flexible(
                    child: TabMedicineWidget(
                      label: 'Pembelian',
                      controller: controller,
                      index: 0,
                      indexSelect: controller.selectedIndexReport.value.obs,
                      onTap: () => controller.selectTabReport(0),
                    ),
                  ),
                  Flexible(
                    child: TabMedicineWidget(
                      label: 'Penjualan',
                      controller: controller,
                      index: 1,
                      indexSelect: controller.selectedIndexReport.value.obs,
                      onTap: () => controller.selectTabReport(1),
                    ),
                  ),
                  Flexible(
                    child: TabMedicineWidget(
                      label: 'Stock Obat',
                      controller: controller,
                      index: 2,
                      indexSelect: controller.selectedIndexReport.value.obs,
                      onTap: () => controller.selectTabReport(2),
                    ),
                  ),
                ],
              ),
              AppSizes.s20.height,
              Responsive.isDesktop(context)
                  ? Obx(() {
                      return controller.selectedIndexReport.value == 0
                          ? controller.isDetailView.value
                              ? SizedBox(
                                  width: double.infinity,
                                  height: 600,
                                  child: ListView(
                                    children: [
                                      CustomTabelComponent(
                                        arrowBack: IconButton(
                                          onPressed: () {
                                            controller
                                                .grandTotalDetailPurchaseReport
                                                .value = 0;
                                            controller.noBuyDetailPurchaseReport
                                                .value = '';
                                            controller
                                                .dateBuyDetailPurchaseReport
                                                .value = '';
                                            controller
                                                .supplierBuyDetailPurchaseReport
                                                .value = '';
                                            controller
                                                .petugasBuyDetailPurchaseReport
                                                .value = '';
                                            controller.backToList();
                                          },
                                          icon: Icon(
                                            Icons.arrow_back,
                                            color: AppColors.colorBaseWhite,
                                          ),
                                        ),
                                        label: 'Detail Laporan Pembelian',
                                        sizeRowTabel:
                                            MediaQuery.of(context).size.width /
                                                1.1,
                                        sizeWidth:
                                            MediaQuery.of(context).size.width /
                                                1,
                                        border: TableBorder.all(
                                          color: AppColors.colorBaseSecondary
                                              .withAlpha(50),
                                        ),
                                        customContentBottom: Column(
                                          children: [
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  1,
                                              height: 1,
                                              color:
                                                  AppColors.colorBaseSecondary,
                                            ),
                                            AppSizes.s20.height,
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Text(
                                                  'Grand Total : ',
                                                  style: Get
                                                      .textTheme.labelMedium!
                                                      .copyWith(
                                                    fontSize: AppSizes.s16,
                                                    fontWeight: FontWeight.bold,
                                                    color: AppColors
                                                        .colorBaseBlack,
                                                  ),
                                                ),
                                                AppSizes.s100.width,
                                                Obx(() => Text(
                                                      controller
                                                          .grandTotalDetailPurchaseReport
                                                          .value
                                                          .currencyFormatRp,
                                                      style: Get.textTheme
                                                          .labelMedium!
                                                          .copyWith(
                                                        fontSize: AppSizes.s16,
                                                        fontWeight:
                                                            FontWeight.bold,
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
                                        customContent: Column(
                                          spacing: AppSizes.s10,
                                          children: [
                                            Row(
                                              children: [
                                                Flexible(
                                                  child: Container(
                                                    padding: AppSizes
                                                        .symmetricPadding(
                                                      vertical: AppSizes.s10,
                                                      horizontal: AppSizes.s10,
                                                    ),
                                                    width: double.infinity,
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: AppColors
                                                              .colorSecondary500),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          offset: const Offset(
                                                              0, 0),
                                                          blurRadius: 15,
                                                          spreadRadius: 0,
                                                          color: AppColors
                                                              .colorNeutrals300
                                                              .withAlpha(40),
                                                        ),
                                                      ],
                                                    ),
                                                    child: Text(
                                                      'No Pembelian : ${controller.noBuyDetailPurchaseReport.value}',
                                                      style: Get
                                                          .textTheme.bodyMedium!
                                                          .copyWith(
                                                              fontSize:
                                                                  AppSizes.s16,
                                                              color: AppColors
                                                                  .colorSecondary800),
                                                    ),
                                                  ),
                                                ),
                                                AppSizes.s30.width,
                                                Flexible(
                                                  child: Container(
                                                    padding: AppSizes
                                                        .symmetricPadding(
                                                      vertical: AppSizes.s10,
                                                      horizontal: AppSizes.s10,
                                                    ),
                                                    width: double.infinity,
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: AppColors
                                                              .colorSecondary500),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          offset: const Offset(
                                                              0, 0),
                                                          blurRadius: 15,
                                                          spreadRadius: 0,
                                                          color: AppColors
                                                              .colorNeutrals300
                                                              .withAlpha(40),
                                                        ),
                                                      ],
                                                    ),
                                                    child: Text(
                                                      'Supplier : ${controller.supplierBuyDetailPurchaseReport.value}',
                                                      style: Get
                                                          .textTheme.bodyMedium!
                                                          .copyWith(
                                                              fontSize:
                                                                  AppSizes.s16,
                                                              color: AppColors
                                                                  .colorSecondary800),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Flexible(
                                                  child: Container(
                                                    padding: AppSizes
                                                        .symmetricPadding(
                                                      vertical: AppSizes.s10,
                                                      horizontal: AppSizes.s10,
                                                    ),
                                                    width: double.infinity,
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: AppColors
                                                              .colorSecondary500),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          offset: const Offset(
                                                              0, 0),
                                                          blurRadius: 15,
                                                          spreadRadius: 0,
                                                          color: AppColors
                                                              .colorNeutrals300
                                                              .withAlpha(40),
                                                        ),
                                                      ],
                                                    ),
                                                    child: Text(
                                                      'Tanggal Pembelian : ${controller.dateBuyDetailPurchaseReport.value}',
                                                      style: Get
                                                          .textTheme.bodyMedium!
                                                          .copyWith(
                                                              fontSize:
                                                                  AppSizes.s16,
                                                              color: AppColors
                                                                  .colorSecondary800),
                                                    ),
                                                  ),
                                                ),
                                                AppSizes.s30.width,
                                                Flexible(
                                                  child: Container(
                                                    padding: AppSizes
                                                        .symmetricPadding(
                                                      vertical: AppSizes.s10,
                                                      horizontal: AppSizes.s10,
                                                    ),
                                                    width: double.infinity,
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: AppColors
                                                              .colorSecondary500),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          offset: const Offset(
                                                              0, 0),
                                                          blurRadius: 15,
                                                          spreadRadius: 0,
                                                          color: AppColors
                                                              .colorNeutrals300
                                                              .withAlpha(40),
                                                        ),
                                                      ],
                                                    ),
                                                    child: Text(
                                                      'Petugas : ${controller.petugasBuyDetailPurchaseReport.value}',
                                                      style: Get
                                                          .textTheme.bodyMedium!
                                                          .copyWith(
                                                              fontSize:
                                                                  AppSizes.s16,
                                                              color: AppColors
                                                                  .colorSecondary800),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        listColumns:
                                            getListDetailMedicineReportBuyColumns(),
                                        listRows:
                                            getRowsDetailMedicineReportBuy(
                                          controller: controller,
                                          data: controller
                                              .reportPurchaseMedicineList,
                                          isLoading: controller
                                              .isLoadingHasExpiredMedicine
                                              .value,
                                          selectedPurchaseNo:
                                              controller.noPurchaseReport.value,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : SizedBox(
                                  width: double.infinity,
                                  height: 600,
                                  child: ListView(
                                    children: [
                                      CustomTabelComponent(
                                        label: 'Laporan Pembelian',
                                        sizeRowTabel:
                                            MediaQuery.of(context).size.width /
                                                1.1,
                                        sizeWidth:
                                            MediaQuery.of(context).size.width /
                                                1,
                                        border: TableBorder.all(
                                          color: AppColors.colorBaseSecondary
                                              .withAlpha(50),
                                        ),
                                        customContentPagination: controller
                                                    .numberOfPageReportPurchase
                                                    .value ==
                                                0
                                            ? Container()
                                            : Container(
                                                width: double.infinity,
                                                padding: AppSizes.onlyPadding(
                                                    bottom: AppSizes.s50),
                                                child: Column(
                                                  children: [
                                                    Container(
                                                      //width: 400,
                                                      decoration: BoxDecoration(
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
                                                          numberPages: controller
                                                              .numberOfPageReportPurchase
                                                              .value,
                                                          onPageChange:
                                                              (int index) {
                                                            final page =
                                                                index + 1;
                                                            final dateFormat =
                                                                DateFormat(
                                                                    'yyyy-MM-dd');
                                                            controller
                                                                .getPurchaseReportMedicine(
                                                              page: page,
                                                              name_supplier:
                                                                  controller
                                                                      .nameSupplierSearch
                                                                      .value,
                                                              no_buy: controller
                                                                  .noBuySearch
                                                                  .value,
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
                                                          },
                                                          child: const SizedBox(
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
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  1,
                                              height: 1,
                                              color:
                                                  AppColors.colorBaseSecondary,
                                            ),
                                            AppSizes.s20.height,
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Text(
                                                  'Total Keseluruhan Pembelian',
                                                  style: Get
                                                      .textTheme.labelMedium!
                                                      .copyWith(
                                                    fontSize: AppSizes.s16,
                                                    fontWeight: FontWeight.bold,
                                                    color: AppColors
                                                        .colorBaseBlack,
                                                  ),
                                                ),
                                                AppSizes.s100.width,
                                                Obx(() => Text(
                                                      controller
                                                          .totalPurchaseReport
                                                          .value
                                                          .currencyFormatRp,
                                                      style: Get.textTheme
                                                          .labelMedium!
                                                          .copyWith(
                                                        fontSize: AppSizes.s16,
                                                        fontWeight:
                                                            FontWeight.bold,
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
                                                          const Offset(0, 0),
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
                                                      TextInputType.name,
                                                  hintText:
                                                      AppConstants.LABEL_CARI,
                                                  suffixIcon: const Icon(
                                                    Icons.search,
                                                    color: AppColors
                                                        .colorSecondary500,
                                                  ),
                                                  onChanged: (value) {
                                                    final input = value.trim();
                                                    final parts = input
                                                        .split(',')
                                                        .map((e) => e.trim())
                                                        .toList();

                                                    String name = '';
                                                    String no_buy = '';

                                                    for (var part in parts) {
                                                      if (RegExp(
                                                              r'^(BUY-\d+|\d{3,})$')
                                                          .hasMatch(part)) {
                                                        no_buy = part;
                                                      } else {
                                                        name += '$part ';
                                                      }
                                                    }
                                                    controller
                                                        .nameSupplierSearch
                                                        .value = name;
                                                    controller.noBuySearch
                                                        .value = no_buy;
                                                    name = name.trim();
                                                    final dateFormat =
                                                        DateFormat(
                                                            'yyyy-MM-dd');

                                                    controller
                                                        .getPurchaseReportMedicine(
                                                      name_supplier: name,
                                                      no_buy: no_buy,
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
                                                  },
                                                ),
                                              ),
                                            ),
                                            AppSizes.s10.width,
                                            InkWell(
                                              onTap: () async {
                                                List<DateTime?>? selectedDates =
                                                    await showCalendarDatePicker2Dialog(
                                                  context: context,
                                                  config:
                                                      CalendarDatePicker2WithActionButtonsConfig(
                                                    calendarType:
                                                        CalendarDatePicker2Type
                                                            .range,
                                                    firstDate: DateTime(2000),
                                                    lastDate: DateTime.now(),
                                                  ),
                                                  dialogSize:
                                                      const Size(325, 400),
                                                  value: controller
                                                      .selectedDateRange,
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                );

                                                if (selectedDates != null) {
                                                  controller.selectedDateRange
                                                      .value = selectedDates;
                                                  final dateFormat =
                                                      DateFormat('yyyy-MM-dd');
                                                  controller
                                                      .getPurchaseReportMedicine(
                                                    name_supplier: controller
                                                        .nameSupplierSearch
                                                        .value,
                                                    no_buy: controller
                                                        .noBuySearch.value,
                                                    start_date: dateFormat
                                                        .format(controller
                                                                .selectedDateRange[
                                                            0]!),
                                                    end_date: dateFormat.format(
                                                        controller
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
                                                      BorderRadius.circular(
                                                          AppSizes.s4),
                                                  border: Border.all(
                                                      color:
                                                          Color(0xfffF0F0F0)),
                                                  color:
                                                      AppColors.colorBaseWhite,
                                                  boxShadow: [
                                                    BoxShadow(
                                                      offset:
                                                          const Offset(0, 0),
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
                                                        fontSize: AppSizes.s14,
                                                        fontWeight:
                                                            FontWeight.w100,
                                                        color: AppColors
                                                            .colorBaseBlack,
                                                      ),
                                                    ),
                                                    AppSizes.s10.width,
                                                    controller.selectedDateRange
                                                            .isNotEmpty
                                                        ? IconButton(
                                                            onPressed: () {
                                                              controller
                                                                  .selectedDateRange
                                                                  .value = [];
                                                              controller
                                                                  .getPurchaseReportMedicine(
                                                                start_date: "",
                                                                end_date: "",
                                                              );
                                                            },
                                                            icon: Icon(
                                                              Icons.delete,
                                                            ))
                                                        : Container(),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        listColumns:
                                            getListMedicineReportBuyColumns(),
                                        listRows: getRowsMedicineReportBuy(
                                            data: controller
                                                .reportPurchaseMedicineList,
                                            isLoading: controller
                                                .isLoadingReportPurchase.value,
                                            controller: controller),
                                      ),
                                    ],
                                  ),
                                )
                          : controller.selectedIndexReport.value == 1
                              ? Center(
                                  child: Text('Penjualan'),
                                )
                              : Center(
                                  child: Text('StockObat'),
                                );
                    })
                  : Obx(() {
                      return controller.selectedIndexReport.value == 0
                          ? ListMobileContainerComponent(
                              label: 'Laporan Pembelian',
                              height: 480,
                              children: controller.isLoadingReportPurchase.value
                                  ? Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  : ListView.builder(
                                      itemCount: controller
                                          .reportPurchaseMedicineList.length,
                                      itemBuilder:
                                          (BuildContext context, index) {
                                        var datas = controller
                                            .reportPurchaseMedicineList[index];
                                        return MedicineMenuReportListMobile(
                                            datas: datas);
                                      },
                                    ),
                            )
                          : controller.selectedIndexReport.value == 1
                              ? Center(
                                  child: Text('Penjualan'),
                                )
                              : Center(
                                  child: Text('StockObat'),
                                );
                    })
            ],
          ).paddingSymmetric(
            vertical: AppSizes.s41,
            horizontal: AppSizes.s28,
          ),
        );
      },
    );
  }
}
