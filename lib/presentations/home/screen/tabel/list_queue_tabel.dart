import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:klinik_web_responsif/core/components/status_antrian_component.dart';
import 'package:klinik_web_responsif/core/resources/constans/app_constants.dart';
import 'package:klinik_web_responsif/core/styles/app_colors.dart';
import 'package:klinik_web_responsif/core/styles/app_sizes.dart';
import 'package:klinik_web_responsif/presentations/apotik/controller/apotik_controller.dart';
import 'package:klinik_web_responsif/presentations/home/controllers/home_controller.dart';
import 'package:klinik_web_responsif/presentations/home/screen/tabel/role_action/queue_role_admin_action.dart';
import 'package:klinik_web_responsif/presentations/home/screen/tabel/role_action/queue_role_apotik_action.dart';
import 'package:klinik_web_responsif/presentations/home/screen/tabel/role_action/queue_role_doctor_action.dart';
import 'package:klinik_web_responsif/presentations/patient/controller/rekam_medis_controller.dart';
import 'package:klinik_web_responsif/services/pasien/model/response/get_antrian_pasien_response.dart';

List<DataColumn> getListQueueColumns({
  required HomeController controller,
  String? data,
}) {
  return [
    DataColumn(
      headingRowAlignment: MainAxisAlignment.center,
      label: Text(
        AppConstants.LABEL_NO_ANTRIAN,
        style: Get.textTheme.labelLarge!.copyWith(
          fontSize: AppSizes.s14,
          color: AppColors.colorBaseBlack,
        ),
      ),
    ),
    DataColumn(
      label: Text(
        AppConstants.LABEL_NAMA_PASIEN,
        style: Get.textTheme.labelLarge!.copyWith(
          fontSize: AppSizes.s14,
          color: AppColors.colorBaseBlack,
        ),
      ),
    ),
    DataColumn(
      headingRowAlignment: MainAxisAlignment.center,
      label: Text(
        AppConstants.LABEL_STATUS,
        style: Get.textTheme.labelLarge!.copyWith(
          fontSize: AppSizes.s14,
          color: AppColors.colorBaseBlack,
        ),
      ),
    ),
    data != "FINISHED"
        ? DataColumn(
            headingRowAlignment: MainAxisAlignment.center,
            label: Obx(() {
              return Text(
                controller.role.value == "ADMIN"
                    ? 'UBAH STATUS ANTRIAN'
                    : "ACTION",
                style: Get.textTheme.labelLarge!.copyWith(
                  fontSize: AppSizes.s14,
                  color: AppColors.colorBaseBlack,
                ),
              );
            }))
        : DataColumn(
            headingRowAlignment: MainAxisAlignment.center, label: Container()),
  ];
}

List<DataRow> getRowsQueue({
  required HomeController controller,
  required RekamMedisController controllerRme,
  required ApotikController controllerApotik,
  required BuildContext context,
  required List<AntrianData> data, // ganti dengan model aslimu
  required bool isLoading,
}) {
  if (isLoading) {
    return [
      const DataRow(
        cells: [
          DataCell.empty,
          DataCell.empty,
          DataCell(Center(child: CircularProgressIndicator())),
          DataCell.empty,
        ],
      ),
    ];
  }

  if (data.isEmpty) {
    return [
      const DataRow(
        cells: [
          DataCell.empty,
          DataCell.empty,
          DataCell(Row(
            children: [
              Icon(Icons.highlight_off),
              SizedBox(width: 4),
              Text('Data tidak ditemukan..'),
            ],
          )),
          // DataCell.empty,
          DataCell.empty,
        ],
      ),
    ];
  }

  return data.asMap().entries.map((entry) {
    final index = entry.key;
    final row = entry.value;

    return DataRow(
      color: WidgetStateProperty.resolveWith<Color>(
        (Set<WidgetState> states) {
          return index % 2 == 0
              ? Colors.white
              : AppColors.colorBasePrimary.withAlpha(80);
        },
      ),
      cells: [
        DataCell(Center(
          child: Text('0${row.nomerAntrian}',
              style: const TextStyle(fontWeight: FontWeight.bold)),
        )),
        DataCell(Column(
          spacing: 5,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              row.pasien.name,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              row.pasien.noRekamMedis,
              style: Get.textTheme.bodySmall!.copyWith(
                fontSize: AppSizes.s10,
              ),
            ),
          ],
        )),
        DataCell(
          StatusAntrianComponent(
            status: row.status,
          ),
        ),
        row.status != "FINISHED"
            ? DataCell(
                Center(
                  child: Obx(
                    () {
                      return controller.role.value == "ADMIN"
                          ? QueueRoleAdminAction(
                              controller: controller,
                              row: row,
                            )
                          : controller.role.value == "DOKTER"
                              ? QueueRoleDoctorAction(
                                  controllerRme: controllerRme,
                                  row: row,
                                )
                              : QueueRoleApotikAction(
                                  row: row,
                                  controllerApotik: controllerApotik,
                                );
                    },
                  ),
                ),
              )
            : DataCell(Container())
      ],
    );
  }).toList();
}
