import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:klinik_web_responsif/core/styles/app_colors.dart';
import 'package:klinik_web_responsif/core/styles/app_sizes.dart';
import 'package:klinik_web_responsif/presentations/apotik/controller/apotik_controller.dart';
import 'package:klinik_web_responsif/services/apotik/model/response/get_unit_response.dart';

List<DataColumn> getListBaseUnitColumns() {
  return [
    DataColumn(
      label: Text(
        'NO',
        style: Get.textTheme.labelLarge!
            .copyWith(fontSize: AppSizes.s14, color: AppColors.colorBaseBlack),
      ),
    ),
    DataColumn(
      label: Text(
        'SATUAN',
        style: Get.textTheme.labelLarge!
            .copyWith(fontSize: AppSizes.s14, color: AppColors.colorBaseBlack),
      ),
    ),
    DataColumn(
      label: Text(
        'ACTION',
        style: Get.textTheme.labelLarge!
            .copyWith(fontSize: AppSizes.s14, color: AppColors.colorBaseBlack),
      ),
    ),
  ];
}

List<DataRow> getListBaseUnitRow({
  required List<DatumUnit> data, // ganti dengan model aslimu
  required bool isLoading,
  required ApotikController controller,
  required BuildContext context,
}) {
  if (isLoading) {
    return [
      const DataRow(
        cells: [
          DataCell.empty,
          DataCell(
            Center(
              child: CircularProgressIndicator(),
            ),
          ),
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
          DataCell(Row(
            children: [
              Icon(Icons.highlight_off),
              SizedBox(width: 1),
              //SpaceWidth(4.0),
              Text('Data'),
            ],
          )),
          DataCell(Text('tidak Ditemukan')),
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
        DataCell(
          Text(
            row.no.toString(),
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        DataCell(
          Text(
            row.name.toUpperCase(),
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        DataCell(
          Center(
              child: MouseRegion(
            cursor: SystemMouseCursors.basic,
            child: Theme(
              data: Theme.of(context).copyWith(
                hoverColor: Colors.transparent,
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
              ),
              child: IconButton(
                onPressed: controller.selectedUnitId.value == row.id
                    ? () {}
                    : () {
                        controller.addSelectedMedicineUnit(row.id);
                      },
                icon: const Icon(Iconsax.add_circle5),
                color: controller.selectedUnitId.value == row.id
                    ? AppColors.colorBaseSecondary
                    : AppColors.colorBasePrimary,
              ),
            ),
          )),
        ),
      ],
    );
  }).toList();
}
