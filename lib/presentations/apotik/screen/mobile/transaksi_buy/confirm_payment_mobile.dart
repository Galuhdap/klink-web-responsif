import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:klinik_web_responsif/core/assets/assets.gen.dart';
import 'package:klinik_web_responsif/core/components/button_component.dart';
import 'package:klinik_web_responsif/core/components/modal/show_modal_tanda_tanya_component.dart';
import 'package:klinik_web_responsif/core/components/show_center_dialog.dart';
import 'package:klinik_web_responsif/core/styles/app_colors.dart';
import 'package:klinik_web_responsif/core/styles/app_sizes.dart';
import 'package:klinik_web_responsif/core/utils/extensions/int_ext.dart';
import 'package:klinik_web_responsif/core/utils/extensions/sized_box_ext.dart';
import 'package:klinik_web_responsif/presentations/apotik/controller/apotik_controller.dart';
import 'package:lottie/lottie.dart';

class ConfirmPaymentMobile extends StatelessWidget {
  const ConfirmPaymentMobile({super.key, required this.controller});

  final ApotikController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Obx(() => Text(
              'Grand Total : ${controller.grandTotal.value.currencyFormatRp}',
              style: Get.textTheme.labelLarge!.copyWith(
                  fontSize: AppSizes.s17, color: AppColors.colorBaseBlack),
            )),
        AppSizes.s10.height,
        Divider(
          color: AppColors.colorBasePrimary,
        ),
        AppSizes.s10.height,
        Center(
          child: Container(
            width: 150,
            child: Button.filled(
                color: AppColors.colorPrimary200,
                onPressed: () {
                  showModalCenter(
                    context,
                    Obx(
                      () {
                        return controller.isLoadingPostBuyMedicine.value
                            ? Center(
                                child: SizedBox(
                                  width: 400,
                                  height: 400,
                                  child: Lottie.asset(Assets.lottie.hospital),
                                ),
                              )
                            : ShowModalTandaTanyaComponent(
                                label: 'Apakah anda sudah yakin ?',
                                onTapNo: () {
                                  Get.back();
                                },
                                onTapYes: () async {
                                  await controller.postBuyMedicine();
                                },
                              );
                      },
                    ),
                  );
                },
                label: 'Simpan'),
          ),
        ),
      ],
    ).paddingSymmetric(horizontal: AppSizes.s10);
  }
}
