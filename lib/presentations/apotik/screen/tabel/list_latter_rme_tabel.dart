import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:klinik_web_responsif/core/styles/app_colors.dart';
import 'package:klinik_web_responsif/core/styles/app_sizes.dart';
import 'package:klinik_web_responsif/presentations/docter/controller/docter_controller.dart';
import 'package:klinik_web_responsif/presentations/docter/screen/pdf_priview_letter_rme.dart';
import 'package:klinik_web_responsif/presentations/patient/controller/rekam_medis_controller.dart';
import 'package:klinik_web_responsif/services/doctor/model/response/get_letter_rme_response.dart';

List<DataColumn> getListLatterRmeColumns() {
  return [
    DataColumn(
      label: Text(
        'NO',
        style: Get.textTheme.labelLarge!.copyWith(
          fontSize: AppSizes.s14,
          color: AppColors.colorBaseBlack,
        ),
      ),
    ),
    DataColumn(
      label: Text(
        'NO SURAT',
        style: Get.textTheme.labelLarge!.copyWith(
          fontSize: AppSizes.s14,
          color: AppColors.colorBaseBlack,
        ),
      ),
    ),
    DataColumn(
      label: Text(
        'NAMA',
        style: Get.textTheme.labelLarge!.copyWith(
          fontSize: AppSizes.s14,
          color: AppColors.colorBaseBlack,
        ),
      ),
    ),
    DataColumn(
      label: Text(
        'JENIS KELAMIN',
        style: Get.textTheme.labelLarge!.copyWith(
          fontSize: AppSizes.s14,
          color: AppColors.colorBaseBlack,
        ),
      ),
    ),
    DataColumn(
      label: Text(
        'PEKERJAAN',
        style: Get.textTheme.labelLarge!.copyWith(
          fontSize: AppSizes.s14,
          color: AppColors.colorBaseBlack,
        ),
      ),
    ),
    DataColumn(
      headingRowAlignment: MainAxisAlignment.center,
      label: Text(
        'ACTION',
        style: Get.textTheme.labelLarge!.copyWith(
          fontSize: AppSizes.s14,
          color: AppColors.colorBaseBlack,
        ),
      ),
    ),
  ];
}

List<DataRow> getRowsLatterRmeSale({
  required DocterController controller,
  required RekamMedisController controllerRme,
  required List<DatumLetterRme> data, // ganti dengan model aslimu
  required bool isLoading,
}) {
  if (isLoading) {
    return [
      const DataRow(
        cells: [
          DataCell.empty,
          DataCell.empty,
          DataCell.empty,
          DataCell(Center(child: CircularProgressIndicator())),
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
        DataCell(Text(row.no.toString(),
            style: const TextStyle(fontWeight: FontWeight.bold))),
        DataCell(Text(row.noLetter,
            style: const TextStyle(fontWeight: FontWeight.bold))),
        DataCell(Text(row.pasien.name,
            style: const TextStyle(fontWeight: FontWeight.bold))),
        DataCell(Text(row.pasien.jenisKelamin,
            style: const TextStyle(fontWeight: FontWeight.bold))),
        DataCell(Text(row.pekerjaan,
            style: const TextStyle(fontWeight: FontWeight.bold))),
        DataCell(
          Center(
            child: Row(
              spacing: 10,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.colorWarning300,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: IconButton(
                    onPressed: () {
                      // controller.alamatLetter.value = row.pasien.alamat;
                      // controller.namePasienLetter.value = row.pasien.name;
                      // controller.idPasienLetter.value = row.id;
                      // controller.jenisKelaminLetter.value =
                      //     row.pasien.jenisKelamin;
                      // controller.noRekamMedisLetter.value =
                      //     row.pasien.noRekamMedis;
                      // controller.jobController.text = row.job;
                      // controller.perihalController.text = row.perihal;
                      // controller.keluhanController.text = row.complaint;
                      // controller.tdController.text = row.td;
                      // controller.nController.text = row.n;
                      // controller.sController.text = row.s;
                      // controller.idLatter.value = row.id;
                      // controller.backToLetter();
                      // controller.showAddMailHealt();
                      // controller.showEditMedicine();
                      controller.alamatLetter.value = row.pasien.alamat;
                      controller.namePasienLetter.value = row.pasien.name;
                      controller.idPasienLetter.value = row.pasienid;
                      controller.jenisKelaminLetter.value =
                          row.pasien.jenisKelamin;
                      controller.noRekamMedisLetter.value =
                          row.pasien.noRekamMedis;
                      controller.jobController.text = row.pekerjaan;
                      controller.keperluanController.text = row.keperluan;
                      controller.idLatter.value = row.id;
                      controller.selectedDateRange.value = [
                        row.startDate,
                        row.endDate
                      ];
                      controller.showEditLetterRme();
                    },
                    icon: Icon(
                      Icons.edit_square,
                      color: AppColors.colorBaseWhite,
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.colorBasePrimary,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: IconButton(
                    onPressed: () async {
                      await controllerRme.getRmePasien(id: row.pasienid);
                      var datas = DatumLetterRme(
                          no: 1,
                          id: row.id,
                          noLetter: row.noLetter,
                          pekerjaan: row.pekerjaan,
                          keperluan: row.keperluan,
                          startDate: row.startDate,
                          endDate: row.endDate,
                          createdAt: row.createdAt,
                          pasienid: row.pasienid,
                          user: row.user,
                          pasien: row.pasien);
                      Get.to(PdfPriviewLetterRme(
                        datas: datas,
                      ));
                    },
                    icon: Icon(
                      Icons.picture_as_pdf,
                      color: AppColors.colorBaseWhite,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }).toList();
}
