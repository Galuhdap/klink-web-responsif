import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:klinik_web_responsif/core/styles/app_colors.dart';
import 'package:klinik_web_responsif/core/styles/app_sizes.dart';
import 'package:klinik_web_responsif/core/utils/extensions/date_ext.dart';
import 'package:klinik_web_responsif/core/utils/extensions/int_ext.dart';
import 'package:klinik_web_responsif/services/apotik/model/response/get_purchase_report_medicine_response.dart';

class MedicineMenuReportListMobile extends StatelessWidget {
  const MedicineMenuReportListMobile({
    super.key,
    required this.datas,
  });

  final DatumReportPurchase datas;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: AppSizes.onlyPadding(
        top: AppSizes.s7,
        bottom: AppSizes.s7,
        left: AppSizes.s15,
        right: AppSizes.s15,
      ),
      padding: AppSizes.symmetricPadding(
        vertical: 15,
        horizontal: 15,
      ),
      decoration: BoxDecoration(
        color: AppColors.colorBaseWhite,
        borderRadius: BorderRadius.circular(
          AppSizes.s5,
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
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            spacing: 5,
            children: [
              Text(
                datas.noPembelian,
                style: Get.textTheme.labelLarge!.copyWith(
                    fontSize: AppSizes.s15, color: AppColors.colorBaseBlack),
              ),
              Text(
                datas.tanggalPembelian.toDateddmmmyyyyFormattedString(),
                style: Get.textTheme.labelLarge!.copyWith(
                    fontSize: AppSizes.s12, color: AppColors.colorBaseBlack),
              ),
              Text(
                datas.total.currencyFormatRp,
                style: Get.textTheme.labelLarge!.copyWith(
                    fontSize: AppSizes.s14, color: AppColors.colorBaseBlack),
              ),
              Divider(
                color: AppColors.colorBasePrimary,
              ),
            ],
          ),
          Row(
            spacing: 5,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Text(
                  datas.supplier,
                  style: Get.textTheme.labelLarge!.copyWith(
                      fontSize: AppSizes.s12, color: AppColors.colorBaseBlack),
                ),
              ),
              Container(
                height: 20,
                width: 1,
                color: AppColors.colorBasePrimary,
              ),
              Flexible(
                child: Text(
                  datas.userInput,
                  style: Get.textTheme.labelLarge!.copyWith(
                      fontSize: AppSizes.s12, color: AppColors.colorBaseBlack),
                ),
              ),
            ],
          )
          // Text(
          //   datas.noBuy,
          //   style: Get
          //       .textTheme.labelLarge!
          //       .copyWith(
          //           fontSize:
          //               AppSizes.s12,
          //           color: AppColors
          //               .colorBaseBlack),
          // ),
        ],
      ),
    );
  }
}
