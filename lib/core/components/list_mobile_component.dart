import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:klinik_web_responsif/core/styles/app_colors.dart';
import 'package:klinik_web_responsif/core/styles/app_sizes.dart';

class ListMobileContainerComponent extends StatelessWidget {
  final String label;
  final Widget? children;
  final Widget? customSearch;
  final double height;
  final String? labelButton;
  final Function()? onTap;
  const ListMobileContainerComponent({
    super.key,
    required this.label,
    this.children,
    this.customSearch,
    this.labelButton = '',
    this.height = 400,
    this.onTap,
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  label,
                  style: Get.textTheme.labelLarge!.copyWith(
                      fontSize: AppSizes.s17, color: AppColors.colorBaseWhite),
                ),
                if (labelButton!.isNotEmpty) ...[
                  InkWell(
                    onTap: onTap,
                    child: Container(
                      width: 150,
                      height: 35,
                      decoration: BoxDecoration(
                        color: AppColors.colorSuccess300,
                        borderRadius: BorderRadius.circular(AppSizes.s4),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.add_rounded,
                            color: AppColors.colorBaseWhite,
                            size: 20,
                          ),
                          Text(
                            labelButton!,
                            style: Get.textTheme.bodyMedium!.copyWith(
                                fontSize: AppSizes.s12,
                                color: AppColors.colorBaseWhite),
                          ),
                        ],
                      ),
                    ),
                  )
                ]
              ],
            ),
          ),
          if (customSearch != null) ...[
            customSearch!,
          ],
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
