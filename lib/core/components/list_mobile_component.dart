import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:klinik_web_responsif/core/styles/app_colors.dart';
import 'package:klinik_web_responsif/core/styles/app_sizes.dart';

class ListMobileContainerComponent extends StatelessWidget {
  final String label;
  final Widget children;
  const ListMobileContainerComponent({
    super.key,
    required this.label,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppSizes.symmetricPadding(
        vertical: 15,
        horizontal: 15,
      ),
      decoration: BoxDecoration(
        color: AppColors.colorBaseWhite,
        borderRadius: BorderRadius.circular(
          AppSizes.s10,
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
      child: Column(
        spacing: AppSizes.s15,
        children: [
          Text(
            label,
            style: Get.textTheme.labelLarge!.copyWith(
                fontSize: AppSizes.s17, color: AppColors.colorBaseBlack),
          ),
          SizedBox(
            height: AppSizes.s200,
            child: children,
          ),
        ],
      ),
    );
  }
}
