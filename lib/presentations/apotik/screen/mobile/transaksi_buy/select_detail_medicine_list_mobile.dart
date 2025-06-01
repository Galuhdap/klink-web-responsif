import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:klinik_web_responsif/core/components/input_component.dart';
import 'package:klinik_web_responsif/core/styles/app_colors.dart';
import 'package:klinik_web_responsif/core/styles/app_sizes.dart';
import 'package:klinik_web_responsif/core/utils/extensions/date_ext.dart';
import 'package:klinik_web_responsif/core/utils/extensions/int_ext.dart';
import 'package:klinik_web_responsif/core/utils/extensions/sized_box_ext.dart';
import 'package:klinik_web_responsif/presentations/apotik/controller/apotik_controller.dart';
import 'package:klinik_web_responsif/services/apotik/model/response/get_group_stock_medicine_response.dart';

class SelectDetailMedicineListMobile extends StatelessWidget {
  const SelectDetailMedicineListMobile({
    super.key,
    required this.datas,
    required this.controller,
    required this.index
  });

  final DatumGroupStockMedicine datas;
  final ApotikController controller;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: AppSizes
          .onlyPadding(
        top: AppSizes.s7,
        bottom: AppSizes.s7,
        left: AppSizes.s15,
        right: AppSizes.s15,
      ),
      padding: AppSizes
          .symmetricPadding(
        vertical: 15,
        horizontal: 15,
      ),
      decoration:
          BoxDecoration(
        color: AppColors
            .colorBaseWhite,
        borderRadius:
            BorderRadius
                .circular(
          AppSizes.s5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey
                .withAlpha(
                    40),
            spreadRadius: 0,
            blurRadius: 24,
            offset:
                Offset(0, 0),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment:
            MainAxisAlignment
                .spaceBetween,
        children: [
          Flexible(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment
                      .center,
              children: [
                Text(
                  datas
                      .nameMedicine,
                  style: Get
                      .textTheme
                      .labelLarge!
                      .copyWith(
                    fontSize:
                        AppSizes
                            .s20,
                    color: AppColors
                        .colorBaseBlack,
                    fontWeight:
                        FontWeight
                            .bold,
                  ),
                ),
                Obx(
                    () =>
                        Text(
                          'Total ${controller.totalSelectedMedicineList[index].value.currencyFormatRp}',
                          style:
                              Get.textTheme.labelLarge!.copyWith(fontSize: AppSizes.s14, color: AppColors.colorBaseBlack),
                        )),
                Divider(
                  color: AppColors
                      .colorBasePrimary,
                ),
                Row(
                  spacing: 10,
                  children: [
                    Flexible(
                      child:
                          Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Pilih Tanggal Expired',
                            style: Get.textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w700, fontSize: AppSizes.s12, color: AppColors.colorBaseBlack),
                          ),
                          AppSizes.s5.height,
                          InkWell(
                            onTap: () async {
                              final DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime.now(),
                                lastDate: DateTime(2045), // ⛔ hanya sampai hari ini, tidak bisa pilih besok
                              );
                              if (pickedDate != null) {
                                controller.tglKadaluarsaList[index] = pickedDate;
                              }
                            },
                            child: Container(
                                padding: AppSizes.symmetricPadding(
                                  vertical: AppSizes.s5,
                                  horizontal: AppSizes.s5,
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: AppColors.colorSecondary400,
                                  ),
                                  borderRadius: BorderRadius.circular(AppSizes.s4),
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.calendar_month,
                                      weight: AppSizes.s20,
                                      size: AppSizes.s20,
                                      color: AppColors.colorNeutrals100,
                                    ),
                                    AppSizes.s10.width,
                                    Text(
                                      controller.tglKadaluarsaList[index] != [] ? controller.tglKadaluarsaList[index].toDateyyyymmddFormattedString() : 'Pilih Tanggal',
                                      style: Get.textTheme.bodySmall!.copyWith(
                                        fontSize: AppSizes.s12,
                                        color: AppColors.colorNeutrals400,
                                      ),
                                    ),
                                  ],
                                ).paddingSymmetric(vertical: AppSizes.s5)),
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                        child:
                            Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Masukan Stock',
                          style: Get.textTheme.bodyMedium!.copyWith(
                              fontWeight: FontWeight.w700,
                              fontSize: AppSizes.s12,
                              color: AppColors.colorBaseBlack),
                        ),
                        AppSizes
                            .s5
                            .height,
                        CustomTextField(
                          label:
                              'Masukan Stock',
                          controller:
                              controller.stockControllers[index],
                          keyboardType:
                              TextInputType.text,
                          horizontal:
                              10,
                          vertical:
                              10,
                          onChanged:
                              (value) {
                            controller.updateTotalForIndex(index);
                          },
                          fontSize:
                              10,
                        ),
                      ],
                    )),
                    Flexible(
                      child:
                          Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Masukan Harga Beli',
                            style: Get.textTheme.bodyMedium!.copyWith(
                              fontWeight: FontWeight.w700,
                              fontSize: AppSizes.s12,
                              color: AppColors.colorBaseBlack,
                            ),
                          ),
                          AppSizes.s5.height,
                          CustomTextField(
                            controller: controller.priceBuyControllers[index],
                            keyboardType: TextInputType.text,
                            onChanged: (value) {
                              controller.updateTotalForIndex(index);
                            },
                            horizontal: 10,
                            vertical: 10,
                            fontSize: 10,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                AppSizes.s20
                    .height,
                InkWell(
                  onTap: () {
                    controller
                        .removeSelectedMedicine(
                            datas.id);
                  },
                  child:
                      Container(
                    width: double
                        .infinity,
                    height:
                        40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(AppSizes
                            .s5),
                        color:
                            AppColors.colorError200),
                    child:
                        Center(
                      child:
                          Icon(
                        Iconsax
                            .trash4,
                        color:
                            AppColors.colorBaseWhite,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}