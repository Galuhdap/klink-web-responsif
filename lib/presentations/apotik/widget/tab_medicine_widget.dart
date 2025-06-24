import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:klinik_web_responsif/core/styles/app_colors.dart';
import 'package:klinik_web_responsif/core/styles/app_sizes.dart';
import 'package:klinik_web_responsif/core/utils/extensions/sized_box_ext.dart';
import 'package:klinik_web_responsif/presentations/apotik/controller/apotik_controller.dart';

class TabMedicineWidget extends StatelessWidget {
  final ApotikController controller;
  final Function()? onTap;
  final String label;
  final int index;
  final RxInt indexSelect;

  const TabMedicineWidget({
    super.key,
    required this.label,
    required this.onTap,
    required this.controller,
    required this.index,
    required this.indexSelect,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Obx(() => Container(
            width: double.infinity,
            padding: AppSizes.symmetricPadding(
              vertical: AppSizes.s10,
              horizontal: AppSizes.s10,
            ),
            decoration: BoxDecoration(
              color: AppColors.colorBaseWhite,
            ),
            child: Column(
              children: [
                Text(
                  label,
                  style: Get.textTheme.labelLarge!.copyWith(
                    fontSize: AppSizes.s17,
                    color: indexSelect.value == index
                        ? AppColors.colorBaseBlack
                        : AppColors.colorBaseSecondary,
                  ),
                ),
                AppSizes.s5.height,
                Container(
                  width: double.infinity,
                  height: 2,
                  color: indexSelect.value == index
                      ? AppColors.colorBasePrimary
                      : AppColors.colorBaseSecondary.withAlpha(50),
                ),
              ],
            ),
          )),
    );
  }
}


// controller.selectedIndexReport.value
// controller.selectedIndexReport.value