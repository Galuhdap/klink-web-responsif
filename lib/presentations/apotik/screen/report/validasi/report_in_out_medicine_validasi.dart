import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:klinik_web_responsif/core/components/custom_tabel_component.dart';
import 'package:klinik_web_responsif/core/styles/app_colors.dart';
import 'package:klinik_web_responsif/core/styles/app_sizes.dart';
import 'package:klinik_web_responsif/core/utils/extensions/sized_box_ext.dart';
import 'package:klinik_web_responsif/presentations/apotik/controller/apotik_controller.dart';
import 'package:klinik_web_responsif/presentations/apotik/screen/tabel/list_report_in_out_tabel.dart';
import 'package:number_paginator/number_paginator.dart';

class ReportInOutMedicineValidasi extends StatelessWidget {
  const ReportInOutMedicineValidasi({
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
            label: 'Laporan Keluar Masuk Obat',
            sizeRowTabel: MediaQuery.of(context).size.width / 1.1,
            sizeWidth: MediaQuery.of(context).size.width / 1,
            border: TableBorder.all(
              color: AppColors.colorBaseSecondary.withAlpha(50),
            ),
            customContentPagination: controller.numberOfPageReportInOut.value ==
                    0
                ? Container()
                : Container(
                    width: double.infinity,
                    padding: AppSizes.onlyPadding(bottom: AppSizes.s50),
                    child: Column(
                      children: [
                        Container(
                          //width: 400,
                          decoration: BoxDecoration(
                            color: AppColors.colorBaseWhite,
                            borderRadius: BorderRadius.circular(AppSizes.s4),
                          ),
                          child: Obx(() {
                            return NumberPaginator(
                              numberPages:
                                  controller.numberOfPageReportInOut.value,
                              onPageChange: (int index) {
                                final page = index + 1;
                                final dateFormat = DateFormat('yyyy-MM-dd');
                                controller.getInOutReportMedicine(
                                  page: page,
                                  name_supplier:
                                      controller.nameSupplierSearch.value,
                                  no_buy: controller.noBuySearch.value,
                                  start_date:
                                      controller.selectedDateRange.isNotEmpty
                                          ? dateFormat.format(
                                              controller.selectedDateRange[0]!)
                                          : "",
                                  end_date:
                                      controller.selectedDateRange.isNotEmpty
                                          ? dateFormat.format(
                                              controller.selectedDateRange[1]!)
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
                                      child: NumberContent(),
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
                  width: MediaQuery.of(context).size.width / 1,
                  height: 1,
                  color: AppColors.colorBaseSecondary,
                ),
                AppSizes.s20.height,
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Total Obat Masuk',
                      style: Get.textTheme.labelMedium!.copyWith(
                        fontSize: AppSizes.s16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.colorBaseBlack,
                      ),
                    ),
                    AppSizes.s100.width,
                    Obx(() => Text(
                          controller.totalInReport.value.toString(),
                          style: Get.textTheme.labelMedium!.copyWith(
                            fontSize: AppSizes.s16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.colorBaseBlack,
                          ),
                        )),
                  ],
                ).paddingOnly(right: AppSizes.s70, bottom: AppSizes.s10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Total Obat Keluar',
                      style: Get.textTheme.labelMedium!.copyWith(
                        fontSize: AppSizes.s16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.colorBaseBlack,
                      ),
                    ),
                    AppSizes.s100.width,
                    Obx(() => Text(
                          controller.totalOutReport.value.toString(),
                          style: Get.textTheme.labelMedium!.copyWith(
                            fontSize: AppSizes.s16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.colorBaseBlack,
                          ),
                        )),
                  ],
                ).paddingOnly(right: AppSizes.s70, bottom: AppSizes.s10),
              ],
            ),
            listColumns: getListMedicineReportInOutColumns(),
            listRows: getRowsMedicineReportInOut(
                data: controller.reportInOutMedicineList,
                isLoading: controller.isLoadingReportInOut.value,
                controller: controller),
          ),
        ],
      ),
    );
  }
}
