import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:klinik_web_responsif/core/styles/app_colors.dart';
import 'package:klinik_web_responsif/core/styles/app_sizes.dart';

class PopupMenuActionComponent extends StatelessWidget {
  final String label;
  const PopupMenuActionComponent({
    super.key,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 103,
        height: 29,
        decoration: BoxDecoration(
          color: Color(0xfffEFEFEF),
          borderRadius: BorderRadius.circular(AppSizes.s5),
        ),
        child: Center(
          child: Text(
            label,
            style: Get.textTheme.labelLarge!.copyWith(
              fontSize: AppSizes.s11,
              color: AppColors.colorBaseBlack,
            ),
          ),
        ),
      ),
    );
  }
}