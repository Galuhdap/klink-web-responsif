import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:klinik_web_responsif/core/styles/app_colors.dart';
import 'package:klinik_web_responsif/core/styles/app_sizes.dart';
import 'package:klinik_web_responsif/presentations/patient/controller/rekam_medis_controller.dart';
import 'package:klinik_web_responsif/presentations/patient/screen/rekam_medis_screen.dart';
import 'package:klinik_web_responsif/services/pasien/model/response/get_antrian_pasien_response.dart';

class QueueRoleDoctorAction extends StatelessWidget {
  const QueueRoleDoctorAction({
    super.key,
    required this.controllerRme,
    required this.row,
  });

  final RekamMedisController controllerRme;
  final AntrianData row;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: () {
            controllerRme.getRmePasien(id: row.idPasien);
            Get.to(
              RekamMedisScreen(
                name: row.pasien.name,
                rme: row.pasien.noRekamMedis,
                id_pasien: row.pasien.id,
              ),
            );
          },
          child: Container(
            padding: AppSizes.symmetricPadding(
              vertical: AppSizes.s5,
              horizontal: AppSizes.s10,
            ),
            decoration: BoxDecoration(
              color: AppColors.colorBasePrimary,
              borderRadius: BorderRadius.circular(AppSizes.s5),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.add_outlined,
                  color: AppColors.colorBaseWhite,
                ),
                Text(
                  'Catat Rekam Medis',
                  style: Get.textTheme.labelLarge!.copyWith(
                    fontSize: AppSizes.s11,
                    color: AppColors.colorBaseWhite,
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
