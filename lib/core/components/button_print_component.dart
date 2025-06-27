import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:klinik_web_responsif/core/styles/app_colors.dart';
import 'package:klinik_web_responsif/core/styles/app_sizes.dart';
import 'package:klinik_web_responsif/core/utils/extensions/sized_box_ext.dart';

class ButtonPrintComponent extends StatelessWidget {
  const ButtonPrintComponent(
      {super.key,
      required this.onTap,
      required this.backgroundColor,
      required this.label,
      required this.icon});

  final Function()? onTap;
  final Color backgroundColor;
  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: AppSizes.symmetricPadding(
          vertical: 5,
          horizontal: 5,
        ),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: AppColors.colorBaseWhite,
            ),
            AppSizes.s8.width,
            Text(
              label,
              style: Get.textTheme.labelLarge!.copyWith(
                  fontSize: AppSizes.s12, color: AppColors.colorBackground),
            ),
          ],
        ),
      ),
    );
  }
}
