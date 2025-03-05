
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:klinik_web_responsif/core/assets/assets.gen.dart';
import 'package:klinik_web_responsif/core/styles/app_colors.dart';
import 'package:klinik_web_responsif/core/styles/app_sizes.dart';
import 'package:klinik_web_responsif/core/utils/extensions/sized_box_ext.dart';

class CardDashbordComponent extends StatelessWidget {
  final String title;
  final String count;
  final bool isIconActive;
  const CardDashbordComponent({
    super.key,
    required this.title,
    required this.count,
    this.isIconActive = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: AppSizes.onlyPadding(right: AppSizes.s20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSizes.s5),
        color: AppColors.colorBaseWhite,
      ),
      child: Row(
        children: [
          if (isIconActive) ...[
            Container(
              padding: AppSizes.symmetricPadding(
                  vertical: AppSizes.s20, horizontal: AppSizes.s30),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(AppSizes.s5),
                  bottomLeft: Radius.circular(AppSizes.s5),
                ),
                color: AppColors.colorPrimary50,
              ),
              child: Center(
                child: SvgPicture.asset(
                  Assets.icons.pasienIcon.path,
                ),
              ),
            ),
            AppSizes.s16.width,
          ],
          Container(
            padding: AppSizes.onlyPadding(
                top: AppSizes.s25, bottom: AppSizes.s25, left: AppSizes.s16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: AppSizes.s16,
              children: [
                Text(
                  title,
                  style: Get.textTheme.labelMedium!.copyWith(
                      fontSize: AppSizes.s16,
                      color: AppColors.colorBaseBlack),
                ),
                Text(
                  count,
                  style: Get.textTheme.labelMedium!.copyWith(
                    fontSize: AppSizes.s16,
                    color: AppColors.colorBaseBlack,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
