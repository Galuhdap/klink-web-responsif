import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:klinik_web_responsif/core/styles/app_colors.dart';
import 'package:klinik_web_responsif/core/styles/app_sizes.dart';
import 'package:klinik_web_responsif/presentations/apotik/controller/apotik_controller.dart';
import 'package:klinik_web_responsif/services/apotik/model/response/get_unit_response.dart';

class ContentUnitChooseMedicineMobile extends StatelessWidget {
  const ContentUnitChooseMedicineMobile({
    super.key,
    required this.datas,
    required this.controller,
  });

  final DatumUnit datas;
  final ApotikController controller;

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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                datas.name,
                style: Get.textTheme.labelLarge!.copyWith(
                    fontSize: AppSizes.s15, color: AppColors.colorBaseBlack),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                onPressed: controller.selectedUnitId.value == datas.id
                    ? () {}
                    : () {
                        controller.addSelectedMedicineUnit(datas.id);
                      },
                icon: Icon(
                  Iconsax.add_circle5,
                ),
                color: controller.selectedUnitId.value == datas.id
                    ? AppColors.colorBaseSecondary
                    : AppColors.colorBasePrimary,
              ),
            ],
          )
        ],
      ),
    );
  }
}
