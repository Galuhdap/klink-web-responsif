import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:klinik_web_responsif/core/resources/enum/status_docter_aktif_enum.dart';
import 'package:klinik_web_responsif/core/styles/app_colors.dart';
import 'package:klinik_web_responsif/core/styles/app_sizes.dart';

Color setStatusDoctorColorFill(LabelDocterAktifStatus labelDocterAktifStatus) {
  switch (labelDocterAktifStatus) {
    case LabelDocterAktifStatus.ACTIVE:
      return AppColors.colorMenungguFill;
    case LabelDocterAktifStatus.NON_ACTIVE:
      return AppColors.colorDibatalkanFill;
  }
}

Widget setStatusNameDoctor(LabelDocterAktifStatus labelDocterAktifStatus) {
  switch (labelDocterAktifStatus) {
    case LabelDocterAktifStatus.ACTIVE:
      return Text(
        'Aktif',
        style: Get.textTheme.labelLarge!.copyWith(
          fontSize: AppSizes.s11,
          color: AppColors.colorMenungguText,
        ),
      );
    case LabelDocterAktifStatus.NON_ACTIVE:
      return Text(
        'Tidak Aktif',
        style: Get.textTheme.labelLarge!.copyWith(
          fontSize: AppSizes.s11,
          color: AppColors.colorDibatalkanText,
        ),
      );
  }
}

extension InflationExt on String {
  LabelDocterAktifStatus get labelDocterAktifStatus {
    if (this == 'ACTIVE') {
      return LabelDocterAktifStatus.ACTIVE;
    } else {
      return LabelDocterAktifStatus.NON_ACTIVE;
    }
  }
}
