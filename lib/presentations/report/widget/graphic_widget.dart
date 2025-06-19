import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:klinik_web_responsif/core/styles/app_colors.dart';
import 'package:klinik_web_responsif/core/styles/app_sizes.dart';
import 'package:klinik_web_responsif/core/utils/extensions/sized_box_ext.dart';

class GraphicWidget extends StatelessWidget {
  const GraphicWidget({
    super.key,
    required this.label,
    this.content,
    this.height = 400,
  });
  final String label;
  final Widget? content;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: height,
      color: AppColors.colorBaseWhite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: AppSizes.symmetricPadding(
              vertical: AppSizes.s15,
              horizontal: AppSizes.s15,
            ),
            decoration: BoxDecoration(
              color: AppColors.colorBasePrimary,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(AppSizes.s10),
                topRight: Radius.circular(AppSizes.s10),
              ),
            ),
            child: Text(
              label,
              style: Get.textTheme.bodyLarge!.copyWith(
                  fontSize: AppSizes.s18,
                  color: AppColors.colorBaseWhite,
                  fontWeight: FontWeight.bold),
            ),
          ),
          if (content != null) ...[
            AppSizes.s20.height,
            content!,
          ]
        ],
      ),
    );
  }
}
