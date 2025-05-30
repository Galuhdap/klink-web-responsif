import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:klinik_web_responsif/core/styles/app_colors.dart';
import 'package:klinik_web_responsif/core/styles/app_sizes.dart';
import 'package:klinik_web_responsif/services/apotik/model/response/get_top_five_medicine_response.dart';

List<DataColumn> getListMedicineFiveFavoritColumns() {
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
        'OBAT',
        style: Get.textTheme.labelLarge!
            .copyWith(fontSize: AppSizes.s14, color: AppColors.colorBaseBlack),
      ),
    ),
    DataColumn(
      label: Text(
        'Jumlah',
        style: Get.textTheme.labelLarge!
            .copyWith(fontSize: AppSizes.s14, color: AppColors.colorBaseBlack),
      ),
    ),
  ];
}

List<DataRow> getListMedicineFiveFavoritDays({
  required List<TopFiveMedicine> data, // ganti dengan model aslimu
  required bool isLoadingExpiredMedicine,
}) {
  if (isLoadingExpiredMedicine) {
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
            spacing: 4,
            children: [
              Icon(Icons.highlight_off),
              //SpaceWidth(4.0),
              Text('Data tidak ditemukan..'),
            ],
          )),
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
        DataCell(
          Text(
            row.no.toString(),
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        DataCell(
          Text(
            row.nameMedicine,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        DataCell(
          Text(
            row.totalTerjual.toString(),
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }).toList();
}
