import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:klinik_web_responsif/core/assets/assets.gen.dart';
import 'package:klinik_web_responsif/core/components/button_component.dart';
import 'package:klinik_web_responsif/core/components/input_data_component.dart';
import 'package:klinik_web_responsif/core/components/show_bottom_dialog.dart';
import 'package:klinik_web_responsif/core/components/show_center_dialog.dart';
import 'package:klinik_web_responsif/core/styles/app_colors.dart';
import 'package:klinik_web_responsif/core/styles/app_sizes.dart';
import 'package:klinik_web_responsif/core/utils/extensions/int_ext.dart';
import 'package:klinik_web_responsif/core/utils/extensions/sized_box_ext.dart';
import 'package:klinik_web_responsif/presentations/apotik/controller/apotik_controller.dart';
import 'package:klinik_web_responsif/services/apotik/model/response/get_new_medicine_response.dart';
import 'package:lottie/lottie.dart';

class MedicineListMobile extends StatelessWidget {
  const MedicineListMobile({
    super.key,
    required this.datas,
    required this.controller,
  });

  final DatumNewMedicine datas;
  final ApotikController controller;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showModalBottom(
            context,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppSizes.s8.height,
                Center(
                  child: Container(
                    width: AppSizes.s56,
                    height: AppSizes.s4,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppSizes.s8),
                      color: AppColors.colorNeutrals100,
                    ),
                  ),
                ),
                AppSizes.s11.height,
                Column(
                  spacing: 24,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        controller.nameMedicineController.text =
                            datas.nameMedicine;
                        controller.priceBuyController.text =
                            datas.priceBuy.toString();
                        controller.priceSellController.text =
                            datas.priceSell.toString();
                        showModalCenter(
                          context,
                          Obx(
                            () {
                              return controller.isLoadingPostNewMedicine.value
                                  ? Center(
                                      child: SizedBox(
                                        width: 400,
                                        height: 400,
                                        child: Lottie.asset(
                                            Assets.lottie.hospital),
                                      ),
                                    )
                                  : Form(
                                      key: controller.formKey,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Center(
                                            child: Text(
                                              'Edit Obat',
                                              style: Get.textTheme.labelMedium!
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: AppSizes.s16),
                                            ),
                                          ),
                                          AppSizes.s12.height,
                                          Divider(),
                                          InputDataComponent(
                                            label: 'Nama Obat',
                                            hintText: 'Nama Obat',
                                            controller: controller
                                                .nameMedicineController,
                                          ),
                                          // InputDataComponent(
                                          //   label: 'Harga Beli',
                                          //   hintText: 'Harga Beli',
                                          //   controller:
                                          //       controller.priceBuyController,
                                          // ),
                                          InputDataComponent(
                                            label: 'Harga Jual',
                                            hintText: 'Harga Jual',
                                            controller:
                                                controller.priceSellController,
                                          ),
                                          Row(
                                            children: [
                                              Flexible(
                                                child: Button.outlined(
                                                    onPressed: () {
                                                      controller
                                                          .nameMedicineController
                                                          .text = "";
                                                      controller
                                                          .priceBuyController
                                                          .text = "";
                                                      controller
                                                          .priceSellController
                                                          .text = "";
                                                      Get.back();
                                                      Get.back();
                                                    },
                                                    label: 'Batal'),
                                              ),
                                              AppSizes.s12.width,
                                              Flexible(
                                                child: Button.filled(
                                                    onPressed: () async {
                                                      if (controller
                                                          .formKey.currentState!
                                                          .validate()) {
                                                        controller
                                                            .putNewMedicine(
                                                                datas.id);
                                                      }
                                                    },
                                                    label: 'Simpan'),
                                              ),
                                            ],
                                          )
                                        ],
                                      ).paddingSymmetric(
                                          horizontal: AppSizes.s50),
                                    );
                            },
                          ),
                        );
                      },
                      child: Text(
                        'Edit',
                        style: Get.textTheme.labelLarge!.copyWith(
                          fontSize: AppSizes.s14,
                          color: AppColors.colorBaseBlack,
                        ),
                      ),
                    ),
                  ],
                ).paddingOnly(
                  left: AppSizes.s24,
                  bottom: AppSizes.s20,
                ),
              ],
            ));
      },
      child: Container(
        margin: AppSizes.onlyPadding(
          top: AppSizes.s7,
          bottom: AppSizes.s7,
          left: AppSizes.s15,
          right: AppSizes.s15,
        ),
        padding: AppSizes.symmetricPadding(
          vertical: 15,
          horizontal: 15,
        ),
        decoration: BoxDecoration(
          color: AppColors.colorBaseWhite,
          borderRadius: BorderRadius.circular(
            AppSizes.s5,
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  datas.nameMedicine,
                  style: Get.textTheme.labelLarge!.copyWith(
                      fontSize: AppSizes.s15, color: AppColors.colorBaseBlack),
                ),
                Text(
                  'Stock ${datas.stock}',
                  style: Get.textTheme.labelLarge!.copyWith(
                      fontSize: AppSizes.s12, color: AppColors.colorBaseBlack),
                ),
                // Text(
                //   datas.noBuy,
                //   style: Get
                //       .textTheme.labelLarge!
                //       .copyWith(
                //           fontSize:
                //               AppSizes.s12,
                //           color: AppColors
                //               .colorBaseBlack),
                // ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Harga Jual ${datas.priceSell.currencyFormatRp}',
                  style: Get.textTheme.labelLarge!.copyWith(
                      fontSize: AppSizes.s12, color: AppColors.colorBaseBlack),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
