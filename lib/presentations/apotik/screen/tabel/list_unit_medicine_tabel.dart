import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:klinik_web_responsif/core/assets/assets.gen.dart';
import 'package:klinik_web_responsif/core/components/modal/show_modal_tanda_tanya_component.dart';
import 'package:klinik_web_responsif/core/components/show_center_dialog.dart';
import 'package:klinik_web_responsif/core/styles/app_colors.dart';
import 'package:klinik_web_responsif/core/styles/app_sizes.dart';
import 'package:klinik_web_responsif/presentations/apotik/controller/apotik_controller.dart';
import 'package:klinik_web_responsif/services/apotik/model/response/get_unit_response.dart';
import 'package:lottie/lottie.dart';

List<DataColumn> getListUnitMedicineColumns() {
  return [
    DataColumn(
      headingRowAlignment: MainAxisAlignment.center,
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
        'NAMA SATUAN',
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

List<DataRow> getRowsUnitMedicine({
  required ApotikController controller,
  required BuildContext context,
  required List<DatumUnit> data, // ganti dengan model aslimu
  required bool isLoading,
}) {
  if (isLoading) {
    return [
      const DataRow(
        cells: [
          // DataCell.empty,
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
        DataCell(Text(row.name,
            style: const TextStyle(fontWeight: FontWeight.bold))),

        DataCell(Center(
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
                    controller.idUnitMedicine.value = row.id;
                    controller.nameUnitMedicineController.text = row.name;
                    controller.showEditUnitMedicine();
                  },
                  icon: Icon(
                    Icons.edit_square,
                    color: AppColors.colorBaseWhite,
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.colorError300,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: IconButton(
                  onPressed: () async {
                    showModalCenter(
                      context,
                      Obx(
                        () {
                          return controller.isLoadingPostUnitNewMedicine.value
                              ? Center(
                                  child: SizedBox(
                                    width: 400,
                                    height: 400,
                                    child: Lottie.asset(Assets.lottie.hospital),
                                  ),
                                )
                              : ShowModalTandaTanyaComponent(
                                  label:
                                      'Apakah Anda Akan Menghapus Satuan ${row.name} ?',
                                  onTapNo: () {
                                    Get.back();
                                  },
                                  onTapYes: () async {
                                    await controller
                                        .deleteUnitNewMedicine(row.id);
                                  },
                                );
                        },
                      ),
                    );
                  },
                  icon: Icon(
                    Icons.delete_rounded,
                    color: AppColors.colorBaseWhite,
                  ),
                ),
              ),
            ],
          ),
        )), // Ganti sesuai kebutuhan
      ],
    );
  }).toList();
}
