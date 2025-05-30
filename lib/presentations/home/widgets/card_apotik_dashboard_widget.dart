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
  const CardApotikDashbordWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Responsive.isDesktop(context)
        ? Obx(
            () {
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    spacing: AppSizes.s16,
                    children: [
                      Flexible(
                          child: CardDashbordComponent(
                        title: 'Pembelian Bulan Ini',
                        changeIcon: false,
                        iconSaxChange: Iconsax.shopping_cart4,
                        count: controller.isLoadingSummaryMonthMedicine.value
                            ? 'Load....'
                            : controller.summaryMonthlyMedicine.value!
                                        .totalPembelian ==
                                    0
                                ? 0.currencyFormatRp
                                : controller.summaryMonthlyMedicine.value!
                                    .totalPembelian.currencyFormatRp,
                      )),
                      Flexible(
                          child: CardDashbordComponent(
                        title: 'Penjualan Bulan Ini',
                        changeIcon: false,
                        iconSaxChange: Iconsax.shopping_cart4,
                        count: controller.isLoadingSummaryMonthMedicine.value
                            ? 'Load....'
                            : controller.summaryMonthlyMedicine.value!
                                        .totalPenjualan ==
                                    0
                                ? 0.currencyFormatRp
                                : controller.summaryMonthlyMedicine.value!
                                    .totalPenjualan.currencyFormatRp,
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
                          count: controller.isLoadingSummaryMonthMedicine.value
                              ? 'Load....'
                              : controller.summaryMonthlyMedicine.value!.hpp ==
                                      0
                                  ? 0.currencyFormatRp
                                  : controller.summaryMonthlyMedicine.value!.hpp
                                      .currencyFormatRp,
                        ),
                      ),
                      Flexible(
                        child: CardDashbordComponent(
                          title: 'Laba Bulan Ini',
                          changeIcon: false,
                          iconSaxChange: Iconsax.dollar_circle4,
                          count: controller.isLoadingSummaryMonthMedicine.value
                              ? 'Load....'
                              : controller.summaryMonthlyMedicine.value!.laba ==
                                      0
                                  ? 0.currencyFormatRp
                                  : controller.summaryMonthlyMedicine.value!
                                      .laba.currencyFormatRp,
                        ),
                      ),
                    ],
                  )
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
                                    .totalPembelian ==
                                0
                            ? 0.currencyFormatRp
                            : controller.summaryMonthlyMedicine.value!
                                .totalPembelian.currencyFormatRp,
                  ),
                  CardDashbordComponent(
                    title: 'Penjualan Bulan Ini',
                    changeIcon: false,
                    iconSaxChange: Iconsax.shopping_cart4,
                    count: controller.isLoadingSummaryMonthMedicine.value
                        ? 'Load....'
                        : controller.summaryMonthlyMedicine.value!
                                    .totalPenjualan ==
                                0
                            ? 0.currencyFormatRp
                            : controller.summaryMonthlyMedicine.value!
                                .totalPenjualan.currencyFormatRp,
                  ),
                  CardDashbordComponent(
                    title: 'HPP Bulan Ini',
                    changeIcon: false,
                    iconSaxChange: Iconsax.dollar_circle4,
                    count: controller.isLoadingSummaryMonthMedicine.value
                        ? 'Load....'
                        : controller.summaryMonthlyMedicine.value!.hpp == 0
                            ? 0.currencyFormatRp
                            : controller.summaryMonthlyMedicine.value!.hpp
                                .currencyFormatRp,
                  ),
                  CardDashbordComponent(
                    title: 'Laba Bulan Ini',
                    changeIcon: false,
                    iconSaxChange: Iconsax.dollar_circle4,
                    count: controller.isLoadingSummaryMonthMedicine.value
                        ? 'Load....'
                        : controller.summaryMonthlyMedicine.value!.laba == 0
                            ? 0.currencyFormatRp
                            : controller.summaryMonthlyMedicine.value!.laba
                                .currencyFormatRp,
                  ),
                ],
              );
            },
          );
  }
}
