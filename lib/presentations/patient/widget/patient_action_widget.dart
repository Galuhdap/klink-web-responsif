import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:klinik_web_responsif/core/styles/app_colors.dart';
import 'package:klinik_web_responsif/core/styles/app_sizes.dart';

class PatientActionWidget extends StatelessWidget {
  const PatientActionWidget(
      {super.key,
      required this.onTap,
      required this.colorBackground,
      this.iconData,
      required this.label,
      this.vertical = 5,
      this.horizontal = 7});

  final Function()? onTap;
  final Color colorBackground;
  final IconData? iconData;
  final String label;
  final double vertical;
  final double horizontal;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: AppSizes.symmetricPadding(
          vertical: vertical,
          horizontal:horizontal,
        ),
        decoration: BoxDecoration(
          color: colorBackground,
          borderRadius: BorderRadius.circular(AppSizes.s5),
        ),
        child: Row(
          spacing: 3,
          children: [
            if (iconData != null) ...[
              Icon(
                iconData,
                color: AppColors.colorBaseWhite,
              ),
            ],
            Text(
              label,
              style: Get.textTheme.labelLarge!.copyWith(
                fontSize: AppSizes.s11,
                color: AppColors.colorBaseWhite,
              ),
            )
          ],
        ),
      ),
    );
  }
}
