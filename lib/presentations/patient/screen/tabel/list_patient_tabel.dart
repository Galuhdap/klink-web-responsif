import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:klinik_web_responsif/core/components/show_center_dialog.dart';
import 'package:klinik_web_responsif/core/resources/constans/app_constants.dart';
import 'package:klinik_web_responsif/core/styles/app_colors.dart';
import 'package:klinik_web_responsif/core/styles/app_sizes.dart';
import 'package:klinik_web_responsif/core/utils/extensions/date_ext.dart';
import 'package:klinik_web_responsif/presentations/patient/controller/patient_controller.dart';
import 'package:klinik_web_responsif/presentations/patient/screen/tabel/action/add_queue_patient_action.dart';
import 'package:klinik_web_responsif/presentations/patient/screen/tabel/action/edit_patient_action.dart';
import 'package:klinik_web_responsif/presentations/patient/screen/tabel/action/mobile/card_clinic_patient_action_mobile.dart';
import 'package:klinik_web_responsif/presentations/patient/widget/patient_action_widget.dart';
import 'package:klinik_web_responsif/services/pasien/model/response/get_pasien_response.dart';

List<DataColumn> getListPatientColumns() {
  return [
    DataColumn(
      headingRowAlignment: MainAxisAlignment.center,
      label: Text(
        AppConstants.LABEL_NO,
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
        AppConstants.LABEL_NO_REKAM_MEDIS,
        style: Get.textTheme.labelLarge!.copyWith(
          fontSize: AppSizes.s14,
          color: AppColors.colorBaseBlack,
        ),
      ),
    ),
    DataColumn(
      headingRowAlignment: MainAxisAlignment.center,
      label: Text(
        AppConstants.LABEL_NIK,
        style: Get.textTheme.labelLarge!.copyWith(
          fontSize: AppSizes.s14,
          color: AppColors.colorBaseBlack,
        ),
      ),
    ),
    DataColumn(
      headingRowAlignment: MainAxisAlignment.center,
      label: Text(
        AppConstants.LABEL_UMUR,
        style: Get.textTheme.labelLarge!.copyWith(
          fontSize: AppSizes.s14,
          color: AppColors.colorBaseBlack,
        ),
      ),
    ),
    DataColumn(
      label: Text(
        AppConstants.LABEL_JENIS_KELAMIN,
        style: Get.textTheme.labelLarge!.copyWith(
          fontSize: AppSizes.s14,
          color: AppColors.colorBaseBlack,
        ),
      ),
    ),
    DataColumn(
      headingRowAlignment: MainAxisAlignment.center,
      label: Text(
        AppConstants.LABEL_TGL_LAHIR,
        style: Get.textTheme.labelLarge!.copyWith(
          fontSize: AppSizes.s14,
          color: AppColors.colorBaseBlack,
        ),
      ),
    ),
    DataColumn(
      headingRowAlignment: MainAxisAlignment.center,
      label: Text(
        "ACTION",
        style: Get.textTheme.labelLarge!.copyWith(
          fontSize: AppSizes.s14,
          color: AppColors.colorBaseBlack,
        ),
      ),
    ),
  ];
}

List<DataRow> getRowsPatient({
  required PatientController controller,
  required BuildContext context,
  required List<ListPasien> data, // ganti dengan model aslimu
  required bool isLoading,
}) {
  if (isLoading) {
    return [
      const DataRow(
        cells: [
          DataCell.empty,
          DataCell.empty,
          DataCell.empty,
          DataCell.empty,
          DataCell(Center(child: CircularProgressIndicator())),
          DataCell.empty,
          DataCell.empty,
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
          DataCell.empty,
          DataCell.empty,
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
          child: Text(row.no.toString(),
              style: const TextStyle(fontWeight: FontWeight.bold)),
        )),
        DataCell(Text(
          row.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        )),
        DataCell(Center(
          child: Text(
            row.noRekamMedis,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        )),
        DataCell(Center(
          child: Text(
            row.nik,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        )),
        DataCell(Center(
          child: Text(
            row.umur,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        )),
        DataCell(Text(
          row.jenisKelamin,
          style: const TextStyle(fontWeight: FontWeight.bold),
        )),
        DataCell(Center(
          child: Text(
            row.tglLahir.toDateyyyymmddFormattedString(),
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        )),
        DataCell(
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 10,
            children: [
              PatientActionWidget(
                onTap: () {
                  showModalCenter(
                    context,
                    EditPatientAction(
                      datas: row,
                      controller: controller,
                    ),
                  );
                },
                colorBackground: AppColors.colorBasePrimary,
                label: 'Detail',
                vertical: 10,
                horizontal: 10,
              ),
              PatientActionWidget(
                onTap: () {
                  showModalCenter(
                    context,
                    AddQueuePatientAction(
                      datas: row,
                      controller: controller,
                    ),
                  );
                },
                colorBackground: AppColors.colorWarning300,
                iconData: Icons.add_outlined,
                label: 'Tambahkan Ke Antrian',
              ),
              PatientActionWidget(
                onTap: () {
                  showModalCenter(
                    context,
                    CardClinicPatientActionMobile(
                      datas: row,
                      controller: controller,
                    ),
                  );
                },
                colorBackground: AppColors.colorSuccess300,
                iconData: Icons.wallet,
                label: 'Kartu Berobat',
              ),
            ],
          ),
        ),
      ],
    );
  }).toList();
}
