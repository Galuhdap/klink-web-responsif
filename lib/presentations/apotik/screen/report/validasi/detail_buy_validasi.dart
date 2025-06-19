import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:klinik_web_responsif/core/components/custom_tabel_component.dart';
import 'package:klinik_web_responsif/core/styles/app_colors.dart';
import 'package:klinik_web_responsif/core/styles/app_sizes.dart';
import 'package:klinik_web_responsif/core/utils/extensions/int_ext.dart';
import 'package:klinik_web_responsif/core/utils/extensions/sized_box_ext.dart';
import 'package:klinik_web_responsif/presentations/apotik/controller/apotik_controller.dart';
import 'package:klinik_web_responsif/presentations/apotik/screen/tabel/list_detail_report_buy_tabel.dart';

class DetailBuyValidasi extends StatelessWidget {
  const DetailBuyValidasi({
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
              arrowBack: IconButton(
                onPressed: () {
                  controller
                      .grandTotalDetailPurchaseReport
                      .value = 0;
                  controller
                      .noBuyDetailPurchaseReport
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
                  color:
                      AppColors.colorBaseWhite,
                ),
              ),
              label: 'Detail Laporan Pembelian',
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
                        'Grand Total : ',
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
                                .grandTotalDetailPurchaseReport
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
              customContent: Column(
                spacing: AppSizes.s10,
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: Container(
                          padding: AppSizes
                              .symmetricPadding(
                            vertical:
                                AppSizes.s10,
                            horizontal:
                                AppSizes.s10,
                          ),
                          width:
                              double.infinity,
                          decoration:
                              BoxDecoration(
                            border: Border.all(
                                color: AppColors
                                    .colorSecondary500),
                            boxShadow: [
                              BoxShadow(
                                offset:
                                    const Offset(
                                        0, 0),
                                blurRadius: 15,
                                spreadRadius: 0,
                                color: AppColors
                                    .colorNeutrals300
                                    .withAlpha(
                                        40),
                              ),
                            ],
                          ),
                          child: Text(
                            'No Pembelian : ${controller.noBuyDetailPurchaseReport.value}',
                            style: Get.textTheme
                                .bodyMedium!
                                .copyWith(
                                    fontSize:
                                        AppSizes
                                            .s16,
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
                            vertical:
                                AppSizes.s10,
                            horizontal:
                                AppSizes.s10,
                          ),
                          width:
                              double.infinity,
                          decoration:
                              BoxDecoration(
                            border: Border.all(
                                color: AppColors
                                    .colorSecondary500),
                            boxShadow: [
                              BoxShadow(
                                offset:
                                    const Offset(
                                        0, 0),
                                blurRadius: 15,
                                spreadRadius: 0,
                                color: AppColors
                                    .colorNeutrals300
                                    .withAlpha(
                                        40),
                              ),
                            ],
                          ),
                          child: Text(
                            'Supplier : ${controller.supplierBuyDetailPurchaseReport.value}',
                            style: Get.textTheme
                                .bodyMedium!
                                .copyWith(
                                    fontSize:
                                        AppSizes
                                            .s16,
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
                            vertical:
                                AppSizes.s10,
                            horizontal:
                                AppSizes.s10,
                          ),
                          width:
                              double.infinity,
                          decoration:
                              BoxDecoration(
                            border: Border.all(
                                color: AppColors
                                    .colorSecondary500),
                            boxShadow: [
                              BoxShadow(
                                offset:
                                    const Offset(
                                        0, 0),
                                blurRadius: 15,
                                spreadRadius: 0,
                                color: AppColors
                                    .colorNeutrals300
                                    .withAlpha(
                                        40),
                              ),
                            ],
                          ),
                          child: Text(
                            'Tanggal Pembelian : ${controller.dateBuyDetailPurchaseReport.value}',
                            style: Get.textTheme
                                .bodyMedium!
                                .copyWith(
                                    fontSize:
                                        AppSizes
                                            .s16,
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
                            vertical:
                                AppSizes.s10,
                            horizontal:
                                AppSizes.s10,
                          ),
                          width:
                              double.infinity,
                          decoration:
                              BoxDecoration(
                            border: Border.all(
                                color: AppColors
                                    .colorSecondary500),
                            boxShadow: [
                              BoxShadow(
                                offset:
                                    const Offset(
                                        0, 0),
                                blurRadius: 15,
                                spreadRadius: 0,
                                color: AppColors
                                    .colorNeutrals300
                                    .withAlpha(
                                        40),
                              ),
                            ],
                          ),
                          child: Text(
                            'Petugas : ${controller.petugasBuyDetailPurchaseReport.value}',
                            style: Get.textTheme
                                .bodyMedium!
                                .copyWith(
                                    fontSize:
                                        AppSizes
                                            .s16,
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
                selectedPurchaseNo: controller
                    .noPurchaseReport.value,
              ),
            ),
          ],
        ),
      );
  }
}
