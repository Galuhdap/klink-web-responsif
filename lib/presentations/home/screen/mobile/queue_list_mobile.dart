import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:klinik_web_responsif/core/components/show_bottom_dialog.dart';
import 'package:klinik_web_responsif/core/components/status_antrian_component.dart';
import 'package:klinik_web_responsif/core/styles/app_colors.dart';
import 'package:klinik_web_responsif/core/styles/app_sizes.dart';
import 'package:klinik_web_responsif/core/utils/extensions/sized_box_ext.dart';
import 'package:klinik_web_responsif/presentations/apotik/controller/apotik_controller.dart';
import 'package:klinik_web_responsif/presentations/home/controllers/home_controller.dart';
import 'package:klinik_web_responsif/presentations/home/screen/tabel/role_action/queue_role_admin_action.dart';
import 'package:klinik_web_responsif/presentations/home/screen/tabel/role_action/queue_role_apotik_action.dart';
import 'package:klinik_web_responsif/presentations/home/screen/tabel/role_action/queue_role_doctor_action.dart';
import 'package:klinik_web_responsif/presentations/patient/controller/rekam_medis_controller.dart';
import 'package:klinik_web_responsif/services/pasien/model/response/get_antrian_pasien_response.dart';

class QueueListMobile extends StatelessWidget {
  const QueueListMobile({
    super.key,
    required this.datas,
    required this.controllerRme,
    required this.controllerApotik,
    required this.controller,
    this.inkwell = false,
  });

  final AntrianData datas;
  final RekamMedisController controllerRme;
  final ApotikController controllerApotik;
  final HomeController controller;
  final bool inkwell;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: inkwell == true
          ? () {
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
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Ubah Status Antrian',
                          style: Get.textTheme.labelLarge!.copyWith(
                              fontSize: AppSizes.s15,
                              color: AppColors.colorBaseBlack),
                        ),
                        Center(
                          child: Obx(
                            () {
                              return controller.role.value == "ADMIN"
                                  ? QueueRoleAdminAction(
                                      controller: controller,
                                      row: datas,
                                    )
                                  : controller.role.value == "DOKTER"
                                      ? QueueRoleDoctorAction(
                                          controllerRme: controllerRme,
                                          row: datas,
                                        )
                                      : QueueRoleApotikAction(
                                          row: datas,
                                          controllerApotik: controllerApotik,
                                        );
                            },
                          ),
                        ),
                      ],
                    ).paddingOnly(
                      bottom: AppSizes.s20,
                    ),
                  ],
                ),
              );
            }
          : () {},
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
              'Nomor Antrian',
              style: Get.textTheme.labelLarge!.copyWith(
                  fontSize: AppSizes.s15, color: AppColors.colorBaseBlack),
            ),
            Text(
              '0${datas.nomerAntrian}',
              style: Get.textTheme.labelLarge!.copyWith(
                  fontSize: AppSizes.s18, color: AppColors.colorBaseBlack),
            ),
            Divider(
              color: AppColors.colorBasePrimary,
            ),
            Text(
              datas.pasien.name,
              style: Get.textTheme.labelLarge!.copyWith(
                  fontSize: AppSizes.s15, color: AppColors.colorBaseBlack),
            ),
            Text(
              datas.pasien.noRekamMedis,
              style: Get.textTheme.labelLarge!.copyWith(
                  fontSize: AppSizes.s10, color: AppColors.colorBaseBlack),
            ),
            AppSizes.s10.height,
            StatusAntrianComponent(
              status: datas.status,
            ),
          ],
        ),
      ),
    );
  }
}
