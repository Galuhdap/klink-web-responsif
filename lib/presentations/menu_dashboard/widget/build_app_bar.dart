import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:klinik_web_responsif/core/config/responsive.dart';
import 'package:klinik_web_responsif/core/styles/app_colors.dart';
import 'package:klinik_web_responsif/core/styles/app_sizes.dart';
import 'package:klinik_web_responsif/core/utils/extensions/date_ext.dart';

class BuildAppBar extends StatelessWidget {
  final String title;
  final bool withSearchInput;
  final TextEditingController? searchController;
  final void Function(String)? searchChanged;
  final String searchHint;
  final Widget? trailing;
  final bool isMake;
  final VoidCallback? onTapButton;
  final String labelButton;

  const BuildAppBar(
      {super.key,
      required this.title,
      this.withSearchInput = false,
      this.searchController,
      this.searchChanged,
      this.searchHint = 'Cari di sini',
      this.trailing,
      this.isMake = false,
      this.onTapButton,
      this.labelButton = 'Daftar Pasien'});

  @override
  Widget build(BuildContext context) {
    return Responsive.isMobile(context)
        ? Container(
            padding:
                const EdgeInsets.only(left: 27, bottom: 21, right: 27, top: 27),
            decoration: const BoxDecoration(
              color: AppColors.colorBaseWhite,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: Responsive.isMobile(context) ? 20 : 25,
                        fontWeight: FontWeight.w600,
                        color: AppColors.colorBaseBlack,
                      ),
                    ),
                    Text(
                      DateTime.now().toDayDateeddmmmyyyyFormattedString(),
                      style: TextStyle(
                        fontSize: Responsive.isMobile(context) ? 12 : 16,
                        color: AppColors.colorBaseBlack,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        : Container(
            padding:
                const EdgeInsets.only(left: 27, bottom: 20, right: 27, top: 27),
            decoration: const BoxDecoration(
              color: AppColors.colorBaseWhite,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: Responsive.isMobile(context) ? 20 : 25,
                          fontWeight: FontWeight.w600,
                          color: AppColors.colorBaseBlack,
                        ),
                      ),
                      Text(
                        DateTime.now().toDayDateeddmmmyyyyFormattedString(),
                        style: TextStyle(
                          fontSize: Responsive.isMobile(context) ? 8 : 13,
                          color: AppColors.colorBaseBlack,
                        ),
                      ),
                    ],
                  ),
                ),
                isMake
                    ? InkWell(
                        onTap: onTapButton,
                        child: Container(
                          width: 134,
                          height: 41,
                          decoration: BoxDecoration(
                            color: AppColors.colorBasePrimary,
                            borderRadius: BorderRadius.circular(AppSizes.s4),
                          ),
                          child: Center(
                            child: Text(
                              labelButton,
                              style: Get.textTheme.bodyMedium!.copyWith(
                                  fontSize: AppSizes.s16,
                                  color: AppColors.colorBaseWhite),
                            ),
                          ),
                        ),
                      )
                    : Container(),
              ],
            ),
          );
  }
}
