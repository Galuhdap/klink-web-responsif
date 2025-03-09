import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:klinik_web_responsif/core/components/button_component.dart';
import 'package:klinik_web_responsif/core/config/responsive.dart';
import 'package:klinik_web_responsif/core/styles/app_colors.dart';
import 'package:klinik_web_responsif/core/styles/app_sizes.dart';
import 'package:klinik_web_responsif/core/utils/extensions/sized_box_ext.dart';

import '../../assets/assets.gen.dart';

class ShowModalTandaTanyaComponent extends StatelessWidget {
  final String label;
  final Function() onTapYes;
  final Function() onTapNo;
  const ShowModalTandaTanyaComponent({
    super.key,
    required this.label,
    required this.onTapYes,
    required this.onTapNo,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 20,
      children: [
        SvgPicture.asset(Assets.icons.tandaTanya.path),
        Center(
          child: Text(
            label,
            style: Get.textTheme.labelLarge!.copyWith(
              fontSize: AppSizes.s20,
              color: AppColors.colorBaseBlack,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        Center(
          child: Row(
            children: [
              Flexible(
                child: Button.outlined(
                  onPressed: onTapNo,
                  label: 'Tidak',
                ),
              ),
              AppSizes.s12.width,
              Flexible(
                child: Button.filled(
                  onPressed: onTapYes,
                  label: 'Ya',
                ),
              ),
            ],
          ),
        ).paddingSymmetric(
          horizontal:
              Responsive.isMobile(context) ? AppSizes.s0 : AppSizes.s200,
        ),
      ],
    );
  }
}
