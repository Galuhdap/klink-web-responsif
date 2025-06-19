import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:klinik_web_responsif/core/components/input_data_component.dart';
import 'package:klinik_web_responsif/core/components/show_modal_right_component.dart';
import 'package:klinik_web_responsif/core/resources/constans/app_constants.dart';
import 'package:klinik_web_responsif/core/styles/app_colors.dart';
import 'package:klinik_web_responsif/core/styles/app_sizes.dart';
import 'package:klinik_web_responsif/core/utils/extensions/date_ext.dart';
import 'package:klinik_web_responsif/core/utils/extensions/sized_box_ext.dart';
import 'package:klinik_web_responsif/core/utils/extensions/string_casing_ext.dart';
import 'package:klinik_web_responsif/presentations/patient/controller/rekam_medis_controller.dart';
import 'package:klinik_web_responsif/presentations/patient/widget/patient_action_widget.dart';
import 'package:klinik_web_responsif/services/rme/model/response/get_rme_id_response.dart';

List<DataColumn> getListRMEColumns() {
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
        AppConstants.LABEL_JADWAL_PERIKSA,
        style: Get.textTheme.labelLarge!.copyWith(
          fontSize: AppSizes.s14,
          color: AppColors.colorBaseBlack,
        ),
      ),
    ),
    DataColumn(
      headingRowAlignment: MainAxisAlignment.center,
      label: Text(
        AppConstants.LABEL_KELUHAN,
        style: Get.textTheme.labelLarge!.copyWith(
          fontSize: AppSizes.s14,
          color: AppColors.colorBaseBlack,
        ),
      ),
    ),
    DataColumn(
      headingRowAlignment: MainAxisAlignment.center,
      label: Text(
        AppConstants.LABEL_TERAPI_TINDAKAN,
        style: Get.textTheme.labelLarge!.copyWith(
          fontSize: AppSizes.s14,
          color: AppColors.colorBaseBlack,
        ),
      ),
    ),
    DataColumn(
      headingRowAlignment: MainAxisAlignment.center,
      label: Text(
        AppConstants.LABEL_DX,
        style: Get.textTheme.labelLarge!.copyWith(
          fontSize: AppSizes.s14,
          color: AppColors.colorBaseBlack,
        ),
      ),
    ),
    DataColumn(
      label: Text(
        'DOKTER',
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

List<DataRow> getRowsRME({
  required RekamMedisController controller,
  required BuildContext context,
  required List<RmeData> data, // ganti dengan model aslimu
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
          row.jadwalPeriksa.toDateddmmmyyyyFormattedString(),
          style: const TextStyle(fontWeight: FontWeight.bold),
        )),
        DataCell(Center(
          child: Text(
            row.keluhan.toTitleCase(),
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        )),
        DataCell(Center(
          child: Text(
            row.terapiTindakan.toTitleCase(),
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        )),
        DataCell(Center(
          child: Text(
            row.dx.toTitleCase(),
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        )),
        DataCell(Text(
          row.user.name.toTitleCase(),
          style: const TextStyle(fontWeight: FontWeight.bold),
        )),
        DataCell(
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 10,
            children: [
              PatientActionWidget(
                onTap: () {
                  showRightModal(
                    context,
                    Row(
                      children: [
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      Get.back();
                                    },
                                    icon: const Icon(
                                      Icons.arrow_back,
                                      size: 24,
                                      color: AppColors.colorBaseBlack,
                                    ),
                                  ),
                                  Text(
                                    'Rekam Medis',
                                    style: Get.textTheme.labelMedium!.copyWith(
                                        fontWeight: FontWeight.bold,
                                        fontSize: AppSizes.s24),
                                  ),
                                ],
                              ),
                              Divider(),
                              AppSizes.s48.height,
                              InputDataComponent(
                                label: 'No Rekam Medis',
                                hintText: row.noRekamMedis,
                                controller: TextEditingController(),
                                readOnly: true,
                              ),
                              InputDataComponent(
                                label: 'Nama Pasien',
                                hintText: row.namaPasien,
                                controller: TextEditingController(),
                                readOnly: true,
                              ),
                              InputDataComponent(
                                label: 'Jadwal Periksa',
                                hintText: '12/09/2019',
                                controller: TextEditingController(),
                                readOnly: true,
                              ),
                              InputDataComponent(
                                label: 'Keluhan',
                                hintText: row.keluhan,
                                controller: TextEditingController(),
                                readOnly: true,
                              ),
                              InputDataComponent(
                                label: 'Dx',
                                hintText: row.dx,
                                controller: TextEditingController(),
                                readOnly: true,
                              ),
                            ],
                          ),
                        ),
                        AppSizes.s46.width,
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              105.height,
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    AppConstants.LABEL_TERAPI_TINDAKAN,
                                    style: Get.textTheme.bodyMedium!.copyWith(
                                        fontWeight: FontWeight.w700,
                                        fontSize: AppSizes.s14,
                                        color: AppColors.colorBaseBlack),
                                  ),
                                  AppSizes.s12.height,
                                  Container(
                                    padding: AppSizes.symmetricPadding(
                                      vertical: AppSizes.s20,
                                      horizontal: AppSizes.s12,
                                    ),
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: Color(0xfffF6F7FB),
                                      borderRadius:
                                          BorderRadius.circular(AppSizes.s4),
                                    ),
                                    child: Text(
                                      row.terapiTindakan,
                                      style: Get.textTheme.bodyMedium!.copyWith(
                                        fontSize: AppSizes.s14,
                                        color: AppColors.colorBaseBlack,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              AppSizes.s31.height,
                              Expanded(
                                child: ListView.builder(
                                  itemCount: row.obat.length,
                                  itemBuilder: (BuildContext context, index) {
                                    var data = row.obat[index];
                                    return Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          data.namaObat,
                                          style: Get.textTheme.bodyMedium!
                                              .copyWith(
                                            fontSize: AppSizes.s16,
                                            fontWeight: FontWeight.w500,
                                            color: AppColors.colorBaseBlack,
                                          ),
                                        ),
                                        Row(
                                          spacing: 10,
                                          children: [
                                            Text(
                                              data.qty.toString(),
                                              style: Get.textTheme.bodyMedium!
                                                  .copyWith(
                                                fontSize: AppSizes.s14,
                                                fontWeight: FontWeight.w500,
                                                color: AppColors.colorBaseBlack,
                                              ),
                                            ),
                                            Text(
                                              'Tablet',
                                              style: Get.textTheme.bodyMedium!
                                                  .copyWith(
                                                fontSize: AppSizes.s14,
                                                fontWeight: FontWeight.w500,
                                                color: AppColors.colorBaseBlack,
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ).paddingOnly(bottom: AppSizes.s10);
                                  },
                                ),
                              ),
                              // Row(
                              //   mainAxisAlignment:
                              //       MainAxisAlignment.spaceBetween,
                              //   children: [
                              //     Text(
                              //       'Fee Docter',
                              //       style: Get.textTheme.bodyMedium!.copyWith(
                              //         fontSize: AppSizes.s20,
                              //         fontWeight: FontWeight.bold,
                              //         color: AppColors.colorBaseBlack,
                              //       ),
                              //     ),
                              //     Text(
                              //       row.total.currencyFormatRp,
                              //       style: Get.textTheme.bodyMedium!.copyWith(
                              //         fontSize: AppSizes.s20,
                              //         fontWeight: FontWeight.bold,
                              //         color: AppColors.colorBaseBlack,
                              //       ),
                              //     ),
                              //   ],
                              // )
                            ],
                          ),
                        ),
                      ],
                    ).paddingSymmetric(
                      vertical: AppSizes.s53,
                      horizontal: AppSizes.s40,
                    ),
                  );
                },
                colorBackground: AppColors.colorBasePrimary,
                label: 'Detail',
                vertical: 10,
                horizontal: 10,
              ),
            ],
          ),
        ),
      ],
    );
  }).toList();
}
