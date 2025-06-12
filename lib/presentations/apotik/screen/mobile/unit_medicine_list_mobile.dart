import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:klinik_web_responsif/core/assets/assets.gen.dart';
import 'package:klinik_web_responsif/core/components/modal/show_modal_tanda_tanya_component.dart';
import 'package:klinik_web_responsif/core/components/show_bottom_dialog.dart';
import 'package:klinik_web_responsif/core/components/show_center_dialog.dart';
import 'package:klinik_web_responsif/core/styles/app_colors.dart';
import 'package:klinik_web_responsif/core/styles/app_sizes.dart';
import 'package:klinik_web_responsif/core/utils/extensions/sized_box_ext.dart';
import 'package:klinik_web_responsif/presentations/apotik/controller/apotik_controller.dart';
import 'package:klinik_web_responsif/services/apotik/model/response/get_unit_response.dart';
import 'package:lottie/lottie.dart';

class UnitMedicineListMobile extends StatelessWidget {
  const UnitMedicineListMobile({
    super.key,
    required this.datas,
    required this.controller,
  });

  final DatumUnit datas;
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
                      controller.idUnitMedicine.value = datas.id;
                      controller.nameUnitMedicineController.text = datas.name;
                      Get.back();
                      controller.showEditUnitMedicine();
                    },
                    child: Text(
                      'Edit',
                      style: Get.textTheme.labelLarge!.copyWith(
                        fontSize: AppSizes.s14,
                        color: AppColors.colorBaseBlack,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      showModalCenter(
                        context,
                        Obx(
                          () {
                            return controller.isLoadingPostUnitNewMedicine.value
                                ? Center(
                                    child: SizedBox(
                                      width: 400,
                                      height: 400,
                                      child:
                                          Lottie.asset(Assets.lottie.hospital),
                                    ),
                                  )
                                : ShowModalTandaTanyaComponent(
                                    label:
                                        'Apakah Anda Akan Menghapus Satuan ${datas.name} ?',
                                    onTapNo: () {
                                      Get.back();
                                    },
                                    onTapYes: () async {
                                      await controller
                                          .deleteUnitNewMedicine(datas.id);
                                    },
                                  );
                          },
                        ),
                      );
                    },
                    child: Text(
                      'Hapus',
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
          ),
        );
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
        child: Center(
          child: Text(
            datas.name
                .split(' ')
                .map((word) => word.isNotEmpty
                    ? '${word[0].toUpperCase()}${word.substring(1)}'
                    : '')
                .join(' '),
            style: Get.textTheme.labelLarge!.copyWith(
                fontSize: AppSizes.s20, color: AppColors.colorBaseBlack),
          ),
        ),
      ),
    );
  }
}
