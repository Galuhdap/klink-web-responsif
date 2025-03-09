import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:klinik_web_responsif/core/styles/app_colors.dart';
import 'package:klinik_web_responsif/core/styles/app_sizes.dart';
import 'package:klinik_web_responsif/core/utils/extensions/sized_box_ext.dart';
import 'package:klinik_web_responsif/presentations/login/widgets/input_widget.dart';

class InputDataComponent extends StatelessWidget {
  final String label;
  final String hintText;
  final TextEditingController controller;
  final bool readOnly;
  const InputDataComponent({
    super.key,
    required this.label,
    required this.hintText,
    required this.controller,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Get.textTheme.bodyMedium!.copyWith(
              fontWeight: FontWeight.w700,
              fontSize: AppSizes.s14,
              color: AppColors.colorBaseBlack),
        ),
        AppSizes.s12.height,
        InputWidget(
          label: '',
          hintText: hintText,
          controller: controller,
          textInputType: TextInputType.name,
          readOnly: readOnly,
          // validator: emptyValidation,
        ),
        AppSizes.s12.height,
      ],
    );
  }
}