import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:klinik_web_responsif/core/resources/enum/status_antrian_enum.dart';
import 'package:klinik_web_responsif/core/styles/app_colors.dart';
import 'package:klinik_web_responsif/core/styles/app_sizes.dart';

Color setStatusColorFill(LabelAntrianStatus labelAntrianStatus) {
  switch (labelAntrianStatus) {
    case LabelAntrianStatus.WAITING:
      return AppColors.colorMenungguFill;
    case LabelAntrianStatus.PROCESSING:
      return AppColors.colorProsesFill;
    case LabelAntrianStatus.PENDING:
      return AppColors.colorPendingFill;
    case LabelAntrianStatus.FINISHED:
      return AppColors.colorSelesaiFill;
    case LabelAntrianStatus.CANCEL:
      return AppColors.colorDibatalkanFill;
    case LabelAntrianStatus.TAKE_MEDICINE:
      return AppColors.colorMenungguFill;
  }
}

Widget setStatusName(LabelAntrianStatus labelAntrianStatus) {
  switch (labelAntrianStatus) {
    case LabelAntrianStatus.WAITING:
      return Text(
        'Menunggu',
        style: Get.textTheme.labelLarge!.copyWith(
          fontSize: AppSizes.s11,
          color: AppColors.colorMenungguText,
        ),
      );
    case LabelAntrianStatus.PROCESSING:
      return Text(
        'Proses',
        style: Get.textTheme.labelLarge!.copyWith(
          fontSize: AppSizes.s11,
          color: AppColors.colorProsesText,
        ),
      );
    case LabelAntrianStatus.PENDING:
      return Text(
        'Pending',
        style: Get.textTheme.labelLarge!.copyWith(
          fontSize: AppSizes.s11,
          color: AppColors.colorPendingText,
        ),
      );
    case LabelAntrianStatus.FINISHED:
      return Text(
        'Selesai',
        style: Get.textTheme.labelLarge!.copyWith(
          fontSize: AppSizes.s11,
          color: AppColors.colorSelesaiText,
        ),
      );
    case LabelAntrianStatus.CANCEL:
      return Text(
        'Dibatalkan',
        style: Get.textTheme.labelLarge!.copyWith(
          fontSize: AppSizes.s11,
          color: AppColors.colorDibatalkanText,
        ),
      );
    case LabelAntrianStatus.TAKE_MEDICINE:
      return Text(
        'Ambil Obat',
        style: Get.textTheme.labelLarge!.copyWith(
          fontSize: AppSizes.s11,
          color: AppColors.colorMenungguText,
        ),
      );
  }
}

extension InflationExt on String {
  LabelAntrianStatus get labelAntrianStatus {
    if (this == 'WAITING') {
      return LabelAntrianStatus.WAITING;
    } else if (this == 'PROCESSING') {
      return LabelAntrianStatus.PROCESSING;
    } else if (this == 'PENDING') {
      return LabelAntrianStatus.PENDING;
    } else if (this == 'FINISHED') {
      return LabelAntrianStatus.FINISHED;
    } else if (this == 'TAKE_MEDICINE') {
      return LabelAntrianStatus.TAKE_MEDICINE;
    } else {
      return LabelAntrianStatus.CANCEL;
    }
  }
}
