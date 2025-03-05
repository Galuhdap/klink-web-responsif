import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:klinik_web_responsif/core/config/responsive.dart';
import 'package:klinik_web_responsif/core/resources/constans/app_constants.dart';
import 'package:klinik_web_responsif/core/styles/app_colors.dart';
import 'package:klinik_web_responsif/core/styles/app_sizes.dart';
import 'package:klinik_web_responsif/core/utils/extensions/sized_box_ext.dart';

class LabelStatusAntrianComponent extends StatelessWidget {
  const LabelStatusAntrianComponent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Responsive.isDesktop(context)
        ? Row(
            spacing: AppSizes.s24,
            children: [
              Row(
                children: [
                  Container(
                    width: 14,
                    height: 14,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppSizes.s100),
                      color: Color(0xfff6C22A6),
                    ),
                  ),
                  AppSizes.s8.width,
                  Text(
                    AppConstants.LABEL_MENUNGGU,
                    style: Get.textTheme.bodyMedium!.copyWith(
                        fontSize: AppSizes.s14,
                        color: AppColors.colorBaseBlack),
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    width: 14,
                    height: 14,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppSizes.s100),
                      color: Color(0xfff6962AD),
                    ),
                  ),
                  AppSizes.s8.width,
                  Text(
                    AppConstants.LABEL_PROSES,
                    style: Get.textTheme.bodyMedium!.copyWith(
                        fontSize: AppSizes.s14,
                        color: AppColors.colorBaseBlack),
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    width: 14,
                    height: 14,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppSizes.s100),
                      color: Color(0xfffFFA756),
                    ),
                  ),
                  AppSizes.s8.width,
                  Text(
                    AppConstants.LABEL_PENDING,
                    style: Get.textTheme.bodyMedium!.copyWith(
                        fontSize: AppSizes.s14,
                        color: AppColors.colorBaseBlack),
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    width: 14,
                    height: 14,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppSizes.s100),
                      color: Color(0xfffFF3A29),
                    ),
                  ),
                  AppSizes.s8.width,
                  Text(
                    AppConstants.LABEL_SELESAI,
                    style: Get.textTheme.bodyMedium!.copyWith(
                        fontSize: AppSizes.s14,
                        color: AppColors.colorBaseBlack),
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    width: 14,
                    height: 14,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppSizes.s100),
                      color: Color(0xfff6C22A6),
                    ),
                  ),
                  AppSizes.s8.width,
                  Text(
                    AppConstants.LABEL_DIBATALKAN,
                    style: Get.textTheme.bodyMedium!.copyWith(
                        fontSize: AppSizes.s14,
                        color: AppColors.colorBaseBlack),
                  ),
                ],
              ),
            ],
          )
        : Column(
            spacing: AppSizes.s10,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: AppSizes.s10,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 14,
                        height: 14,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(AppSizes.s100),
                          color: Color(0xfff6C22A6),
                        ),
                      ),
                      AppSizes.s8.width,
                      Text(
                        AppConstants.LABEL_MENUNGGU,
                        style: Get.textTheme.bodyMedium!.copyWith(
                            fontSize: AppSizes.s14,
                            color: AppColors.colorBaseBlack),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        width: 14,
                        height: 14,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(AppSizes.s100),
                          color: Color(0xfff6962AD),
                        ),
                      ),
                      AppSizes.s8.width,
                      Text(
                        AppConstants.LABEL_PROSES,
                        style: Get.textTheme.bodyMedium!.copyWith(
                            fontSize: AppSizes.s14,
                            color: AppColors.colorBaseBlack),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        width: 14,
                        height: 14,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(AppSizes.s100),
                          color: Color(0xfffFFA756),
                        ),
                      ),
                      AppSizes.s8.width,
                      Text(
                        AppConstants.LABEL_PENDING,
                        style: Get.textTheme.bodyMedium!.copyWith(
                            fontSize: AppSizes.s14,
                            color: AppColors.colorBaseBlack),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: AppSizes.s10,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 14,
                        height: 14,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(AppSizes.s100),
                          color: Color(0xfffFF3A29),
                        ),
                      ),
                      AppSizes.s8.width,
                      Text(
                        AppConstants.LABEL_SELESAI,
                        style: Get.textTheme.bodyMedium!.copyWith(
                            fontSize: AppSizes.s14,
                            color: AppColors.colorBaseBlack),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        width: 14,
                        height: 14,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(AppSizes.s100),
                          color: Color(0xfff6C22A6),
                        ),
                      ),
                      AppSizes.s8.width,
                      Text(
                        AppConstants.LABEL_DIBATALKAN,
                        style: Get.textTheme.bodyMedium!.copyWith(
                            fontSize: AppSizes.s14,
                            color: AppColors.colorBaseBlack),
                      ),
                    ],
                  ),
                ],
              )
            ],
          );
  }
}
