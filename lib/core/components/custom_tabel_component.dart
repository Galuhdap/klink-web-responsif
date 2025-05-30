import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:klinik_web_responsif/core/styles/app_colors.dart';
import 'package:klinik_web_responsif/core/styles/app_sizes.dart';
import 'package:klinik_web_responsif/core/utils/extensions/sized_box_ext.dart';

class CustomTabelComponent extends StatelessWidget {
  final String label;
  final double sizeRowTabel;
  final double sizeWidth;
  final List<DataColumn> listColumns;
  final List<DataRow> listRows;
  final Widget? customContent;
  final Widget? arrowBack;
  final Widget? customContentBottom;
  final Widget? customContentPagination;
  final TableBorder? border;
  const CustomTabelComponent(
      {super.key,
      required this.label,
      this.sizeRowTabel = 0,
      this.sizeWidth = 0,
      required this.listColumns,
      required this.listRows,
      this.customContent,
      this.customContentBottom,
      this.customContentPagination,
      this.arrowBack,
      this.border});

  @override
  Widget build(BuildContext context) {
    return Container(
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: AppSizes.symmetricPadding(
              vertical: AppSizes.s15,
              horizontal: AppSizes.s15,
            ),
            width: sizeWidth,
            decoration: BoxDecoration(
              color: AppColors.colorBasePrimary,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(AppSizes.s10),
                topRight: Radius.circular(AppSizes.s10),
              ),
            ),
            child: Row(
              children: [
                if (arrowBack != null) ...[
                  arrowBack!,
                  AppSizes.s10.width,
                ],
                Text(
                  label,
                  style: Get.textTheme.labelLarge!.copyWith(
                      fontSize: AppSizes.s17, color: AppColors.colorBackground),
                ),
              ],
            ),
          ),
          if (customContent != null) ...[
            AppSizes.s10.height,
            Container(
              padding: AppSizes.symmetricPadding(
                horizontal: 15,
              ),
              width: sizeRowTabel,
              child: customContent!,
            ),
          ],
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Theme(
              data:
                  Theme.of(context).copyWith(dividerColor: Colors.transparent),
              child: Container(
                padding: AppSizes.symmetricPadding(
                  vertical: 15,
                  horizontal: 15,
                ),
                width: sizeRowTabel,
                child: DataTable(
                  border: border,
                  columns: listColumns,
                  rows: listRows,
                ),
              ),
            ),
          ),
          if (customContentBottom != null) ...[
            AppSizes.s10.height,
            Container(
                padding: AppSizes.symmetricPadding(
                  horizontal: 15,
                  vertical: 15,
                ),
                child: customContentBottom!),
          ],
          if (customContentPagination != null) ...[
            customContentPagination!,
          ]
        ],
      ),
    );
  }
}
