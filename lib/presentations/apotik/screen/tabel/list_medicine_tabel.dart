import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:klinik_web_responsif/core/assets/assets.gen.dart';
import 'package:klinik_web_responsif/core/components/modal/show_modal_tanda_tanya_component.dart';
import 'package:klinik_web_responsif/core/components/show_center_dialog.dart';
import 'package:klinik_web_responsif/core/styles/app_colors.dart';
import 'package:klinik_web_responsif/core/styles/app_sizes.dart';
import 'package:klinik_web_responsif/core/utils/extensions/int_ext.dart';
import 'package:klinik_web_responsif/presentations/apotik/controller/apotik_controller.dart';
import 'package:klinik_web_responsif/services/apotik/model/response/get_new_medicine_response.dart';
import 'package:klinik_web_responsif/services/apotik/model/response/get_unit_response.dart';
import 'package:lottie/lottie.dart';

List<DataColumn> getListMedicineColumns() {
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
        'NAMA OBAT',
        style: Get.textTheme.labelLarge!.copyWith(
          fontSize: AppSizes.s14,
          color: AppColors.colorBaseBlack,
        ),
      ),
    ),
    // DataColumn(
    //   label: Text(
    //     'Harga Beli',
    //     style: Get.textTheme.labelLarge!.copyWith(
    //       fontSize: AppSizes.s14,
    //       color: AppColors.colorBaseBlack,
    //     ),
    //   ),
    // ),
    DataColumn(
      label: Text(
        'HARGA JUAL',
        style: Get.textTheme.labelLarge!.copyWith(
          fontSize: AppSizes.s14,
          color: AppColors.colorBaseBlack,
        ),
      ),
    ),
    DataColumn(
      headingRowAlignment: MainAxisAlignment.center,
      label: Text(
        'STOCK',
        style: Get.textTheme.labelLarge!.copyWith(
          fontSize: AppSizes.s14,
          color: AppColors.colorBaseBlack,
        ),
      ),
    ),
    DataColumn(
      headingRowAlignment: MainAxisAlignment.center,
      label: Text(
        'SATUAN',
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

List<DataRow> getRowsMedicine({
  required ApotikController controller,
  required BuildContext context,
  required List<DatumNewMedicine> data, // ganti dengan model aslimu
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
          DataCell(Row(
            children: [
              Icon(Icons.highlight_off),
              SizedBox(width: 4),
              Text('Data tidak ditemukan..'),
            ],
          )),
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
        DataCell(Text(row.no.toString(),
            style: const TextStyle(fontWeight: FontWeight.bold))),
        DataCell(Text(row.nameMedicine,
            style: const TextStyle(fontWeight: FontWeight.bold))),
        DataCell(Text(row.priceSell.currencyFormatRp,
            style: const TextStyle(fontWeight: FontWeight.bold))),
        DataCell(Center(
          child: Text(row.stock.toString(),
              style: const TextStyle(fontWeight: FontWeight.bold)),
        )),
        DataCell(Center(
          child: Text(row.baseUnit.toUpperCase(),
              style: const TextStyle(fontWeight: FontWeight.bold)),
        )),
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
                      List<DatumUnit> data =
                          row.conversions.map<DatumUnit>((conv) {
                        return DatumUnit(
                          id: conv.id,
                          name: conv.unitName,
                          level: conv.multiplier,
                        );
                      }).toList();
                      controller.idMedicine.value = row.id;
                      controller.nameMedicineController.text = row.nameMedicine;
                      controller.priceSellController.text =
                          row.priceSell.toString();
                      controller.dropdownUnitController.text = row.baseUnit;
                      controller.selectedUnitId.value = row.idBaseUnit;
                      controller.selectedMedicineListUnit.value = data;
                      controller.unitControllers.value = data
                          .map((unit) => TextEditingController(
                              text: unit.level.toString()))
                          .toList();
                      if (controller.selectedMedicineListUnit.isNotEmpty) {
                        controller.isLightOn.value = true;
                      } else {
                        controller.isLightOn.value = false;
                      }

                      controller.showEditMedicine();
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
                            return controller.isLoadingPostNewMedicine.value
                                ? Center(
                                    child: SizedBox(
                                      width: 400,
                                      height: 400,
                                      child:
                                          Lottie.asset(Assets.lottie.hospital),
                                    ),
                                  )
                                : ShowModalTandaTanyaComponent(
                                    label:
                                        'Apakah Anda Akan Menghapus Obat ${row.nameMedicine} ?',
                                    onTapNo: () {
                                      Get.back();
                                    },
                                    onTapYes: () async {
                                      await controller
                                          .deleteNewMedicine(row.id);
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
          ),
        ),
      ],
    );
  }).toList();
}
