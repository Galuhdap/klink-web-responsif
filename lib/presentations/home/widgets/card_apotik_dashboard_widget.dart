import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:klinik_web_responsif/core/components/card_dashboard_component.dart';
import 'package:klinik_web_responsif/core/config/responsive.dart';
import 'package:klinik_web_responsif/core/styles/app_sizes.dart';
import 'package:klinik_web_responsif/core/utils/extensions/int_ext.dart';
import 'package:klinik_web_responsif/core/utils/extensions/sized_box_ext.dart';
import 'package:klinik_web_responsif/presentations/apotik/controller/apotik_controller.dart';

class CardApotikDashbordWidget extends StatelessWidget {
  final ApotikController controller;
  final bool owner;
  const CardApotikDashbordWidget({
    super.key,
    required this.controller,
    this.owner = false,
  });

  @override
  Widget build(BuildContext context) {
    return Responsive.isDesktop(context)
        ? Obx(
            () {
              return Column(
                children: [
                  if (owner == false) ...[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      spacing: AppSizes.s16,
                      children: [
                        Flexible(
                            child: CardDashbordComponent(
                          title: 'Pembelian Obat Bulan Ini',
                          changeIcon: false,
                          iconSaxChange: Iconsax.shopping_cart4,
                          count: controller.isLoadingSummaryMonthMedicine.value
                              ? 'Load....'
                              : controller.summaryMonthlyMedicine.value!
                                          .pembelianObatBulanIni ==
                                      0
                                  ? 0.currencyFormatRp
                                  : controller.summaryMonthlyMedicine.value!
                                      .pembelianObatBulanIni.currencyFormatRp,
                        )),
                        Flexible(
                            child: CardDashbordComponent(
                          title: 'Penjualan Obat Bulan Ini',
                          changeIcon: false,
                          iconSaxChange: Iconsax.shopping_cart4,
                          count: controller.isLoadingSummaryMonthMedicine.value
                              ? 'Load....'
                              : controller.summaryMonthlyMedicine.value!
                                          .penjualanObatBulanIni ==
                                      0
                                  ? 0.currencyFormatRp
                                  : controller.summaryMonthlyMedicine.value!
                                      .penjualanObatBulanIni.currencyFormatRp,
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
                            title: 'HPP Bulan Ini',
                            changeIcon: false,
                            iconSaxChange: Iconsax.dollar_circle4,
                            count:
                                controller.isLoadingSummaryMonthMedicine.value
                                    ? 'Load....'
                                    : controller.summaryMonthlyMedicine.value!
                                                .hppBulanIni ==
                                            0
                                        ? 0.currencyFormatRp
                                        : controller
                                            .summaryMonthlyMedicine
                                            .value!
                                            .hppBulanIni
                                            .currencyFormatRp,
                          ),
                        ),
                        Flexible(
                          child: CardDashbordComponent(
                            title: 'Laba Bersih Bulan Ini',
                            changeIcon: false,
                            iconSaxChange: Iconsax.dollar_circle4,
                            count:
                                controller.isLoadingSummaryMonthMedicine.value
                                    ? 'Load....'
                                    : controller.summaryMonthlyMedicine.value!
                                                .labaBersihBulanIni ==
                                            0
                                        ? 0.currencyFormatRp
                                        : controller
                                            .summaryMonthlyMedicine
                                            .value!
                                            .labaBersihBulanIni
                                            .currencyFormatRp,
                          ),
                        ),
                      ],
                    ),
                  ],
                  if (owner == true) ...[
                    // AppSizes.s20.height,
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   spacing: AppSizes.s16,
                    //   children: [
                    //     Flexible(
                    //       child: CardDashbordComponent(
                    //         title: 'Laba Kotor Bulan Ini',
                    //         changeIcon: false,
                    //         iconSaxChange: Iconsax.dollar_circle4,
                    //         count:
                    //             controller.isLoadingSummaryMonthMedicine.value
                    //                 ? 'Load....'
                    //                 : controller.summaryMonthlyMedicine.value!
                    //                             .labaKotorBulanIni ==
                    //                         0
                    //                     ? 0.currencyFormatRp
                    //                     : controller
                    //                         .summaryMonthlyMedicine
                    //                         .value!
                    //                         .labaKotorBulanIni
                    //                         .currencyFormatRp,
                    //       ),
                    //     ),
                    //     Flexible(
                    //       child: CardDashbordComponent(
                    //         title: 'Fee Dokter Bulan Ini',
                    //         changeIcon: false,
                    //         iconSaxChange: Iconsax.dollar_circle4,
                    //         count:
                    //             controller.isLoadingSummaryMonthMedicine.value
                    //                 ? 'Load....'
                    //                 : controller.summaryMonthlyMedicine.value!
                    //                             .feeDokterBulanIni ==
                    //                         0
                    //                     ? 0.currencyFormatRp
                    //                     : controller
                    //                         .summaryMonthlyMedicine
                    //                         .value!
                    //                         .feeDokterBulanIni
                    //                         .currencyFormatRp,
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    AppSizes.s20.height,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      spacing: AppSizes.s16,
                      children: [
                        Flexible(
                          child: CardDashbordComponent(
                            title: 'Total Pembelian Obat',
                            changeIcon: false,
                            iconSaxChange: Iconsax.dollar_circle4,
                            count:
                                controller.isLoadingSummaryMonthMedicine.value
                                    ? 'Load....'
                                    : controller.summaryMonthlyMedicine.value!
                                                .totalPembelianObat ==
                                            0
                                        ? 0.currencyFormatRp
                                        : controller
                                            .summaryMonthlyMedicine
                                            .value!
                                            .totalPembelianObat
                                            .currencyFormatRp,
                          ),
                        ),
                        AppSizes.s20.height,
                        Flexible(
                          child: CardDashbordComponent(
                            title: 'Total Penjualan Obat',
                            changeIcon: false,
                            iconSaxChange: Iconsax.dollar_circle4,
                            count:
                                controller.isLoadingSummaryMonthMedicine.value
                                    ? 'Load....'
                                    : controller.summaryMonthlyMedicine.value!
                                                .totalPenjualanObat ==
                                            0
                                        ? 0.currencyFormatRp
                                        : controller
                                            .summaryMonthlyMedicine
                                            .value!
                                            .totalPenjualanObat
                                            .currencyFormatRp,
                          ),
                        ),
                      ],
                    ),
                    AppSizes.s20.height,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      spacing: AppSizes.s16,
                      children: [
                        Flexible(
                          child: CardDashbordComponent(
                            title: 'Total HPP',
                            changeIcon: false,
                            iconSaxChange: Iconsax.dollar_circle4,
                            count:
                                controller.isLoadingSummaryMonthMedicine.value
                                    ? 'Load....'
                                    : controller.summaryMonthlyMedicine.value!
                                                .totalHpp ==
                                            0
                                        ? 0.currencyFormatRp
                                        : controller.summaryMonthlyMedicine
                                            .value!.totalHpp.currencyFormatRp,
                          ),
                        ),
                        Flexible(
                          child: CardDashbordComponent(
                            title: 'Total Fee Dokter',
                            changeIcon: false,
                            iconSaxChange: Iconsax.dollar_circle4,
                            count:
                                controller.isLoadingSummaryMonthMedicine.value
                                    ? 'Load....'
                                    : controller.summaryMonthlyMedicine.value!
                                                .totalFeeDokter ==
                                            0
                                        ? 0.currencyFormatRp
                                        : controller
                                            .summaryMonthlyMedicine
                                            .value!
                                            .totalFeeDokter
                                            .currencyFormatRp,
                          ),
                        ),
                      ],
                    ),
                    AppSizes.s20.height,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      spacing: AppSizes.s16,
                      children: [
                        Flexible(
                          child: CardDashbordComponent(
                            title: 'Total Laba Kotor',
                            changeIcon: false,
                            iconSaxChange: Iconsax.dollar_circle4,
                            count:
                                controller.isLoadingSummaryMonthMedicine.value
                                    ? 'Load....'
                                    : controller.summaryMonthlyMedicine.value!
                                                .totalLabaKotor ==
                                            0
                                        ? 0.currencyFormatRp
                                        : controller
                                            .summaryMonthlyMedicine
                                            .value!
                                            .totalLabaKotor
                                            .currencyFormatRp,
                          ),
                        ),
                        Flexible(
                          child: CardDashbordComponent(
                            title: 'Total Labar Bersih',
                            changeIcon: false,
                            iconSaxChange: Iconsax.dollar_circle4,
                            count:
                                controller.isLoadingSummaryMonthMedicine.value
                                    ? 'Load....'
                                    : controller.summaryMonthlyMedicine.value!
                                                .totalLabaBersih ==
                                            0
                                        ? 0.currencyFormatRp
                                        : controller
                                            .summaryMonthlyMedicine
                                            .value!
                                            .totalLabaBersih
                                            .currencyFormatRp,
                          ),
                        ),
                      ],
                    )
                  ]
                ],
              );
            },
          )
        : Obx(
            () {
              return Column(
                spacing: AppSizes.s10,
                children: [
                  CardDashbordComponent(
                    title: 'Pembelian Bulan Ini',
                    changeIcon: false,
                    iconSaxChange: Iconsax.shopping_cart4,
                    count: controller.isLoadingSummaryMonthMedicine.value
                        ? 'Load....'
                        : controller.summaryMonthlyMedicine.value!
                                    .pembelianObatBulanIni ==
                                0
                            ? 0.currencyFormatRp
                            : controller.summaryMonthlyMedicine.value!
                                .pembelianObatBulanIni.currencyFormatRp,
                  ),
                  CardDashbordComponent(
                    title: 'Penjualan Bulan Ini',
                    changeIcon: false,
                    iconSaxChange: Iconsax.shopping_cart4,
                    count: controller.isLoadingSummaryMonthMedicine.value
                        ? 'Load....'
                        : controller.summaryMonthlyMedicine.value!
                                    .penjualanObatBulanIni ==
                                0
                            ? 0.currencyFormatRp
                            : controller.summaryMonthlyMedicine.value!
                                .penjualanObatBulanIni.currencyFormatRp,
                  ),
                  CardDashbordComponent(
                    title: 'HPP Bulan Ini',
                    changeIcon: false,
                    iconSaxChange: Iconsax.dollar_circle4,
                    count: controller.isLoadingSummaryMonthMedicine.value
                        ? 'Load....'
                        : controller.summaryMonthlyMedicine.value!
                                    .hppBulanIni ==
                                0
                            ? 0.currencyFormatRp
                            : controller.summaryMonthlyMedicine.value!
                                .hppBulanIni.currencyFormatRp,
                  ),
                  CardDashbordComponent(
                    title: 'Laba Bersih Bulan Ini',
                    changeIcon: false,
                    iconSaxChange: Iconsax.dollar_circle4,
                    count: controller.isLoadingSummaryMonthMedicine.value
                        ? 'Load....'
                        : controller.summaryMonthlyMedicine.value!
                                    .labaBersihBulanIni ==
                                0
                            ? 0.currencyFormatRp
                            : controller.summaryMonthlyMedicine.value!
                                .labaBersihBulanIni.currencyFormatRp,
                  ),
                ],
              );
            },
          );
  }
}
