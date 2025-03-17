import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:klinik_web_responsif/core/resources/enum/status_antrian_enum.dart';
import 'package:klinik_web_responsif/core/styles/app_colors.dart';
import 'package:klinik_web_responsif/core/styles/app_sizes.dart';

Color setStatusColorFill(LabelAntrianStatus labelAntrianStatus) {
  switch (labelAntrianStatus) {
    case LabelAntrianStatus.menunggu:
      return AppColors.colorMenungguFill;
    case LabelAntrianStatus.proses:
      return AppColors.colorProsesFill;
    case LabelAntrianStatus.pending:
      return AppColors.colorPendingFill;
    case LabelAntrianStatus.selesai:
      return AppColors.colorSelesaiFill;
    case LabelAntrianStatus.dibatalkan:
      return AppColors.colorDibatalkanFill;
    case LabelAntrianStatus.ambil_obat:
      return AppColors.colorMenungguFill;
  }
}

Widget setStatusName(LabelAntrianStatus labelAntrianStatus) {
  switch (labelAntrianStatus) {
    case LabelAntrianStatus.menunggu:
      return Text(
        'Menunggu',
        style: Get.textTheme.labelLarge!.copyWith(
          fontSize: AppSizes.s11,
          color: AppColors.colorMenungguText,
        ),
      );
    case LabelAntrianStatus.proses:
      return Text(
        'Proses',
        style: Get.textTheme.labelLarge!.copyWith(
          fontSize: AppSizes.s11,
          color: AppColors.colorProsesText,
        ),
      );
    case LabelAntrianStatus.pending:
      return Text(
        'Pending',
        style: Get.textTheme.labelLarge!.copyWith(
          fontSize: AppSizes.s11,
          color: AppColors.colorPendingText,
        ),
      );
    case LabelAntrianStatus.selesai:
      return Text(
        'Selesai',
        style: Get.textTheme.labelLarge!.copyWith(
          fontSize: AppSizes.s11,
          color: AppColors.colorSelesaiText,
        ),
      );
    case LabelAntrianStatus.dibatalkan:
      return Text(
        'Dibatalkan',
        style: Get.textTheme.labelLarge!.copyWith(
          fontSize: AppSizes.s11,
          color: AppColors.colorDibatalkanText,
        ),
      );
    case LabelAntrianStatus.ambil_obat:
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
    if (this == 'menunggu') {
      return LabelAntrianStatus.menunggu;
    } else if (this == 'proses') {
      return LabelAntrianStatus.proses;
    } else if (this == 'pending') {
      return LabelAntrianStatus.pending;
    } else if (this == 'selesai') {
      return LabelAntrianStatus.selesai;
    } else if (this == 'ambil_obat') {
      return LabelAntrianStatus.ambil_obat;
    } else {
      return LabelAntrianStatus.dibatalkan;
    }
  }
}
