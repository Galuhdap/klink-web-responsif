import 'package:flutter/material.dart';
import 'package:klinik_web_responsif/core/styles/app_colors.dart';
import 'package:klinik_web_responsif/core/styles/app_sizes.dart';

class SearchInput extends StatelessWidget {
  final TextEditingController controller;
  final Function(String value)? onChanged;
  final VoidCallback? onTap;
  final String hintText;

  const SearchInput({
    super.key,
    required this.controller,
    this.onChanged,
    this.onTap,
    this.hintText = 'Cari di sini',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppSizes.allPadding(AppSizes.s5),
      decoration: BoxDecoration(
        color: AppColors.colorPrimary200.withAlpha(50),
        borderRadius: BorderRadius.circular(
          AppSizes.s10,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.colorBaseWhite,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: TextFormField(
          onTap: onTap,
          // readOnly: onTap != null,
          controller: controller,
          onChanged: onChanged,
          decoration: InputDecoration(
            hintText: hintText,
            prefixIcon: const Icon(
              Icons.search,
              color: AppColors.colorBasePrimary,
            ),
            contentPadding: const EdgeInsets.all(16.0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: const BorderSide(color: Colors.grey),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: const BorderSide(color: Colors.grey),
            ),
          ),
        ),
      ),
    );
  }
}
