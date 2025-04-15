import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:klinik_web_responsif/core/assets/assets.gen.dart';
import 'package:klinik_web_responsif/core/components/button_component.dart';
import 'package:klinik_web_responsif/core/config/responsive.dart';
import 'package:klinik_web_responsif/core/styles/app_colors.dart';
import 'package:klinik_web_responsif/core/styles/app_sizes.dart';
import 'package:klinik_web_responsif/core/utils/extensions/sized_box_ext.dart';

class SuccesPaymentWidget extends StatelessWidget {
  final String invoice;
  final String totalTagihan;
  final String nominalBayar;
  final String kembalian;
  final String date;
  final String paymentMethod;

  const SuccesPaymentWidget({
    super.key,
    required this.invoice,
    required this.totalTagihan,
    required this.nominalBayar,
    required this.kembalian,
    required this.date,
    required this.paymentMethod,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AppSizes.s25.height,
        SvgPicture.asset(
          Assets.icons.success.path,
          width: Responsive.isMobile(context) ? AppSizes.s80 : AppSizes.s100,
        ),
        AppSizes.s20.height,
        Center(
          child: Text(
            'Pembayaran Sukses!',
            style: Get.textTheme.labelMedium!.copyWith(
              fontWeight: FontWeight.bold,
              fontSize:
                  Responsive.isMobile(context) ? AppSizes.s20 : AppSizes.s28,
            ),
          ),
        ),
        10.height,
        Center(
          child: Text(
            invoice,
            style: Get.textTheme.labelMedium!.copyWith(
              fontWeight: FontWeight.bold,
              fontSize:
                  Responsive.isMobile(context) ? AppSizes.s15 : AppSizes.s20,
            ),
          ),
        ),
        40.height,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Metode Pembayaran',
              style: Get.textTheme.bodyMedium!.copyWith(
                fontSize: AppSizes.s15,
                color: AppColors.colorBaseBlack,
              ),
            ),
            Text(
              paymentMethod,
              style: Get.textTheme.bodyMedium!.copyWith(
                fontSize: AppSizes.s15,
                fontWeight: FontWeight.bold,
                color: AppColors.colorBaseBlack,
              ),
            ),
          ],
        ),
        Divider(),
        AppSizes.s28.height,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Total Tagihan',
              style: Get.textTheme.bodyMedium!.copyWith(
                fontSize: AppSizes.s15,
                color: AppColors.colorBaseBlack,
              ),
            ),
            Text(
              totalTagihan,
              style: Get.textTheme.bodyMedium!.copyWith(
                fontSize: AppSizes.s15,
                fontWeight: FontWeight.bold,
                color: AppColors.colorBaseBlack,
              ),
            ),
          ],
        ),
        AppSizes.s28.height,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Nominal Bayar',
              style: Get.textTheme.bodyMedium!.copyWith(
                fontSize: AppSizes.s15,
                color: AppColors.colorBaseBlack,
              ),
            ),
            Text(
              nominalBayar,
              style: Get.textTheme.bodyMedium!.copyWith(
                fontSize: AppSizes.s15,
                fontWeight: FontWeight.bold,
                color: AppColors.colorBaseBlack,
              ),
            ),
          ],
        ),
        AppSizes.s28.height,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Kembalian Pembayaran',
              style: Get.textTheme.bodyMedium!.copyWith(
                fontSize: AppSizes.s15,
                color: AppColors.colorBaseBlack,
              ),
            ),
            Text(
              kembalian,
              style: Get.textTheme.bodyMedium!.copyWith(
                fontSize: AppSizes.s15,
                fontWeight: FontWeight.bold,
                color: AppColors.colorBaseBlack,
              ),
            ),
          ],
        ),
        AppSizes.s28.height,
        Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Waktu Pembayaran',
              style: Get.textTheme.bodyMedium!.copyWith(
                fontSize: AppSizes.s15,
                color: AppColors.colorBaseBlack,
              ),
            ),
            Text(
              date,
              style: Get.textTheme.bodyMedium!.copyWith(
                fontSize: AppSizes.s15,
                fontWeight: FontWeight.bold,
                color: AppColors.colorBaseBlack,
              ),
            ),
          ],
        ),
        AppSizes.s28.height,
        Flexible(
          child: Button.filled(
              onPressed: () {
                Get.back();
              },
              label: 'Selesai'),
        ),
      ],
    ).paddingSymmetric(
        horizontal: Responsive.isMobile(context) ? AppSizes.s0 : AppSizes.s100);
  }
}
