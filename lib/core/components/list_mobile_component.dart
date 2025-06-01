import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:klinik_web_responsif/core/styles/app_colors.dart';
import 'package:klinik_web_responsif/core/styles/app_sizes.dart';

class ListMobileContainerComponent extends StatelessWidget {
  final String label;
  final Widget? children;
  final double height;
  const ListMobileContainerComponent({
    super.key,
    required this.label,
    this.children,
    this.height = 400
  });

  @override
  Widget build(BuildContext context) {
    return Container(
     
      height: height,
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
          Container(
            padding: AppSizes.symmetricPadding(
              vertical: AppSizes.s15,
              horizontal: AppSizes.s15,
            ),
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.colorBasePrimary,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(AppSizes.s10),
                topRight: Radius.circular(AppSizes.s10),
              ),
            ),
            child: Text(
              label,
              style: Get.textTheme.labelLarge!.copyWith(
                  fontSize: AppSizes.s17, color: AppColors.colorBaseWhite),
            ),
          ),
          Expanded(
            // height: AppSizes.s200,
            child: children!,
          )
          // SizedBox(
          //   height: AppSizes.s200,
          //   child: children,
          // )
          // if (children != null) ...[children!],
        ],
      ),
    );
  }
}
