import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:klinik_web_responsif/core/components/input_data_component.dart';
import 'package:klinik_web_responsif/core/styles/app_colors.dart';
import 'package:klinik_web_responsif/core/styles/app_sizes.dart';
import 'package:klinik_web_responsif/core/utils/extensions/date_ext.dart';
import 'package:klinik_web_responsif/core/utils/extensions/sized_box_ext.dart';
import 'package:klinik_web_responsif/presentations/apotik/controller/apotik_controller.dart';

class HeaderInputTransactionMobile extends StatelessWidget {
  const HeaderInputTransactionMobile({
    super.key,
    required this.controller
  });

  final ApotikController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppSizes.symmetricPadding(
          vertical: AppSizes.s20,
          horizontal: AppSizes.s20),
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.colorBaseWhite,
        borderRadius: BorderRadius.circular(
          AppSizes.s10,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withAlpha(40),
            spreadRadius: 0,
            blurRadius: 24,
            offset: Offset(0, 0),
          ),
        ],
      ),
      child: Column(
        // mainAxisAlignment:
        //     MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment:
                CrossAxisAlignment.center,
            children: [
              Text(
                'No Pembelian',
                style: Get.textTheme.bodyMedium!
                    .copyWith(
                        fontSize: AppSizes.s17,
                        color: AppColors
                            .colorBaseBlack),
              ),
              AppSizes.s5.height,
              Obx(() => Text(
                    controller.purchaseNumber.value,
                    style: Get.textTheme.labelLarge!
                        .copyWith(
                            fontSize: AppSizes.s17,
                            color: AppColors
                                .colorBaseBlack),
                  )),
              Divider(
                color: AppColors.colorBasePrimary,
              ),
            ],
          ),
          AppSizes.s10.height,
          Row(
            children: [
              Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Text(
                    'Tanggal Pembelian',
                    style: Get.textTheme.bodyMedium!
                        .copyWith(
                            fontWeight:
                                FontWeight.w700,
                            fontSize: AppSizes.s14,
                            color: AppColors
                                .colorBaseBlack),
                  ),
                  AppSizes.s12.height,
                  InkWell(
                    onTap: () async {
                      final DateTime? pickedDate =
                          await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1950),
                        lastDate: DateTime
                            .now(), // ⛔ hanya sampai hari ini, tidak bisa pilih besok
                      );
                      if (pickedDate != null) {
                        controller
                            .dateBuyMedicineController
                            .value = pickedDate;
                      }
                    },
                    child: Container(
                        padding: AppSizes
                            .symmetricPadding(
                                vertical:
                                    AppSizes.s5,
                                horizontal:
                                    AppSizes.s20),
                        width: 200,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: AppColors
                                .colorSecondary400,
                          ),
                          borderRadius:
                              BorderRadius.circular(
                                  AppSizes.s4),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.calendar_month,
                              weight: AppSizes.s20,
                              size: AppSizes.s30,
                              color: AppColors
                                  .colorNeutrals100,
                            ),
                            AppSizes.s10.width,
                            Text(
                              controller
                                  .dateBuyMedicineController
                                  .value
                                  .toDateyyyymmddFormattedString(),
                              style: Get.textTheme
                                  .bodySmall!
                                  .copyWith(
                                fontSize:
                                    AppSizes.s14,
                                color: AppColors
                                    .colorNeutrals400,
                              ),
                            ),
                          ],
                        ).paddingSymmetric(
                            vertical: AppSizes.s5)),
                  ),
                  AppSizes.s12.height,
                ],
              ),
              AppSizes.s20.width,
              Container(
                width: 200,
                child: InputDataComponent(
                    label: 'Supplier',
                    hintText:
                        'Masukan Nama Supplier',
                    controller: controller
                        .supplierController),
              ),
            ],
          ),
        ],
      ),
    );
  }
}


