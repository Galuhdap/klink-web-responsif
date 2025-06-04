import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:klinik_web_responsif/core/components/show_bottom_dialog.dart';
import 'package:klinik_web_responsif/core/components/show_center_dialog.dart';
import 'package:klinik_web_responsif/core/styles/app_colors.dart';
import 'package:klinik_web_responsif/core/styles/app_sizes.dart';
import 'package:klinik_web_responsif/core/utils/extensions/date_ext.dart';
import 'package:klinik_web_responsif/core/utils/extensions/sized_box_ext.dart';
import 'package:klinik_web_responsif/presentations/patient/controller/patient_controller.dart';
import 'package:klinik_web_responsif/presentations/patient/screen/tabel/action/add_queue_patient_action.dart';
import 'package:klinik_web_responsif/presentations/patient/screen/tabel/action/edit_patient_action.dart';
import 'package:klinik_web_responsif/presentations/patient/screen/tabel/action/mobile/card_clinic_patient_action_mobile.dart';
import 'package:klinik_web_responsif/services/pasien/model/response/get_pasien_response.dart';

class PatientListMobile extends StatelessWidget {
  const PatientListMobile(
      {super.key, required this.datas, required this.controller});

  final ListPasien datas;
  final PatientController controller;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showModalBottom(
            context,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppSizes.s8.height,
                Center(
                  child: Container(
                    width: AppSizes.s56,
                    height: AppSizes.s4,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppSizes.s8),
                      color: AppColors.colorNeutrals100,
                    ),
                  ),
                ),
                AppSizes.s11.height,
                Column(
                  spacing: 24,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        showModalCenter(
                          context,
                          EditPatientAction(
                            datas: datas,
                            controller: controller,
                          ),
                        );
                      },
                      child: Text(
                        'Detail',
                        style: Get.textTheme.labelLarge!.copyWith(
                          fontSize: AppSizes.s14,
                          color: AppColors.colorBaseBlack,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        showModalCenter(
                          context,
                          AddQueuePatientAction(
                            datas: datas,
                            controller: controller,
                          ),
                        );
                      },
                      child: Text(
                        'Tambahkan Antrian',
                        style: Get.textTheme.labelLarge!.copyWith(
                          fontSize: AppSizes.s14,
                          color: AppColors.colorBaseBlack,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        showModalCenter(
                          context,
                          CardClinicPatientActionMobile(
                            datas: datas,
                            controller: controller,
                          ),
                        );
                      },
                      child: Text(
                        'Kartu Berobat',
                        style: Get.textTheme.labelLarge!.copyWith(
                          fontSize: AppSizes.s14,
                          color: AppColors.colorBaseBlack,
                        ),
                      ),
                    ),
                  ],
                ).paddingOnly(
                  left: AppSizes.s24,
                  bottom: AppSizes.s20,
                ),
              ],
            ));
      },
      child: Container(
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
            Text(
              datas.noRekamMedis,
              style: Get.textTheme.labelLarge!.copyWith(
                  fontSize: AppSizes.s18, color: AppColors.colorBaseBlack),
            ),
            Divider(
              color: AppColors.colorBasePrimary,
            ),
            AppSizes.s5.height,
            Text(
              datas.name,
              style: Get.textTheme.labelLarge!.copyWith(
                  fontSize: AppSizes.s15, color: AppColors.colorBaseBlack),
            ),
            AppSizes.s5.height,
            Text(
              datas.nik,
              style: Get.textTheme.labelLarge!.copyWith(
                  fontSize: AppSizes.s14, color: AppColors.colorBaseBlack),
            ),
            AppSizes.s5.height,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 10,
              children: [
                Text(
                  datas.umur,
                  style: Get.textTheme.labelLarge!.copyWith(
                      fontSize: AppSizes.s10, color: AppColors.colorBaseBlack),
                ),
                Container(
                  height: 20,
                  width: 1,
                  color: AppColors.colorBasePrimary,
                ),
                Text(
                  datas.jenisKelamin,
                  style: Get.textTheme.labelLarge!.copyWith(
                      fontSize: AppSizes.s10, color: AppColors.colorBaseBlack),
                ),
                Container(
                  height: 20,
                  width: 1,
                  color: AppColors.colorBasePrimary,
                ),
                Text(
                  datas.tglLahir.toDateyyyymmddFormattedString(),
                  style: Get.textTheme.labelLarge!.copyWith(
                      fontSize: AppSizes.s10, color: AppColors.colorBaseBlack),
                ),
              ],
            ),
            AppSizes.s10.height,
          ],
        ),
      ),
    );
  }
}
