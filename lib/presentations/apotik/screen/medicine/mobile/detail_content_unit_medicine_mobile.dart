import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:klinik_web_responsif/core/components/input_component.dart';
import 'package:klinik_web_responsif/core/styles/app_colors.dart';
import 'package:klinik_web_responsif/core/styles/app_sizes.dart';
import 'package:klinik_web_responsif/core/utils/extensions/sized_box_ext.dart';
import 'package:klinik_web_responsif/presentations/apotik/controller/apotik_controller.dart';
import 'package:klinik_web_responsif/services/apotik/model/response/get_unit_response.dart';

class DetailContentUnitMedicineMobile extends StatelessWidget {
  const DetailContentUnitMedicineMobile({
    super.key,
    required this.datas,
    required this.controller,
    required this.index,
  });

  final DatumUnit datas;
  final ApotikController controller;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
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
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  datas.name,
                  style: Get.textTheme.labelLarge!.copyWith(
                    fontSize: AppSizes.s20,
                    color: AppColors.colorBaseBlack,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Divider(
                  color: AppColors.colorBasePrimary,
                ),
                Row(
                  spacing: 10,
                  children: [
                    Flexible(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'ISI PER UNIT',
                          style: Get.textTheme.bodyMedium!.copyWith(
                              fontWeight: FontWeight.w700,
                              fontSize: AppSizes.s12,
                              color: AppColors.colorBaseBlack),
                        ),
                        AppSizes.s5.height,
                        CustomTextField(
                          label: 'Masukan isi per unit',
                          controller: controller.unitControllers[index],
                          keyboardType: TextInputType.text,
                          horizontal: 10,
                          vertical: 10,
                          onChanged: (value) {
                            controller.updateTotalForIndex(index);
                          },
                          fontSize: 10,
                        ),
                      ],
                    )),
                  ],
                ),
                AppSizes.s20.height,
                InkWell(
                  onTap: () {
                    controller.removeSelectedMedicineUnit(datas.id);
                  },
                  child: Container(
                    width: double.infinity,
                    height: 40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(AppSizes.s5),
                        color: AppColors.colorError200),
                    child: Center(
                      child: Icon(
                        Iconsax.trash4,
                        color: AppColors.colorBaseWhite,
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