import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:klinik_web_responsif/core/components/input_component.dart';
import 'package:klinik_web_responsif/core/styles/app_colors.dart';
import 'package:klinik_web_responsif/core/styles/app_sizes.dart';

class InputWidget extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String? hintText;
  final TextInputType? textInputType;
  final String? Function(String?)? validator;
  final bool isObscure;
  final bool suffixIcon;
  final bool? readOnly;
  final TextStyle? hintStyle;
  final Function(String)? onChanged;
  final List<TextInputFormatter>? inputFormatters;
  final int maxLines;
  final String? errorText;

  const InputWidget({
    super.key,
    required this.controller,
    required this.label,
    this.hintText,
    this.textInputType,
    this.validator,
    this.isObscure = false,
    this.suffixIcon = false,
    this.readOnly = false,
    this.hintStyle,
    this.onChanged,
    this.inputFormatters,
    this.maxLines = 1,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Text(
        //   label,
        //   style: Get.textTheme.labelLarge!.copyWith(
        //     fontSize: AppSizes.s12,
        //   ),
        // ),
        // AppSizes.s10.height,
        CustomTextField(
          maxLines: maxLines,
          hintText: hintText,
          controller: controller,
          keyboardType: textInputType,
          validator: validator,
          isObscure: isObscure,
          suffixIcon: suffixIcon,
          readOnly: readOnly!,
          errorText: errorText,
          hintStyle: Get.textTheme.bodySmall!.copyWith(
            fontSize: AppSizes.s14,
            color: AppColors.colorNeutrals400,
          ),
          onChanged: onChanged,
          inputFormatters: inputFormatters,
        ),
      ],
    );
  }
}
