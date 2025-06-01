import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:klinik_web_responsif/core/styles/app_colors.dart';
import 'package:klinik_web_responsif/core/styles/app_sizes.dart';
import 'package:klinik_web_responsif/core/utils/extensions/date_ext.dart';
import 'package:klinik_web_responsif/services/apotik/model/response/get_expired_medicines_response.dart';

class MedicineHasExpiredListMobile extends StatelessWidget {
  const MedicineHasExpiredListMobile({
    super.key,
    required this.datas,
  });

  final DatumExpiredMedicine datas;

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
            color:
                Colors.grey.withAlpha(40),
            spreadRadius: 0,
            blurRadius: 24,
            offset: Offset(0, 0),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment:
            MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Text(
                datas.nameMedicine,
                style: Get
                    .textTheme.labelLarge!
                    .copyWith(
                        fontSize:
                            AppSizes.s15,
                        color: AppColors
                            .colorBaseBlack),
              ),
              Text(
                'Stock ${datas.stock}',
                style: Get
                    .textTheme.labelLarge!
                    .copyWith(
                        fontSize:
                            AppSizes.s12,
                        color: AppColors
                            .colorBaseBlack),
              ),
              Text(
                datas.noBuy,
                style: Get
                    .textTheme.labelLarge!
                    .copyWith(
                        fontSize:
                            AppSizes.s12,
                        color: AppColors
                            .colorBaseBlack),
              ),
            ],
          ),
          Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Text(
                'Expired ${datas.tanggalExpired.toDateddmmmyyyyFormattedString()}',
                style: Get
                    .textTheme.labelLarge!
                    .copyWith(
                        fontSize:
                            AppSizes.s12,
                        color: AppColors
                            .colorBaseBlack),
              ),
            ],
          )
        ],
      ),
    );
  }
}
