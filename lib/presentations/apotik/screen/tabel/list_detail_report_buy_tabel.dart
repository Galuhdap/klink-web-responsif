import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:klinik_web_responsif/core/styles/app_colors.dart';
import 'package:klinik_web_responsif/core/styles/app_sizes.dart';
import 'package:klinik_web_responsif/core/utils/extensions/date_ext.dart';
import 'package:klinik_web_responsif/core/utils/extensions/int_ext.dart';
import 'package:klinik_web_responsif/presentations/apotik/controller/apotik_controller.dart';
import 'package:klinik_web_responsif/services/apotik/model/response/get_purchase_report_medicine_response.dart';

List<DataColumn> getListDetailMedicineReportBuyColumns() {
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
    DataColumn(
      label: Text(
        'HARGA BELI',
        style: Get.textTheme.labelLarge!.copyWith(
          fontSize: AppSizes.s14,
          color: AppColors.colorBaseBlack,
        ),
      ),
    ),
    DataColumn(
      label: Text(
        'JUMLAH',
        style: Get.textTheme.labelLarge!.copyWith(
          fontSize: AppSizes.s14,
          color: AppColors.colorBaseBlack,
        ),
      ),
    ),
    DataColumn(
      label: Text(
        'TANGGAL EXPIRE',
        style: Get.textTheme.labelLarge!.copyWith(
          fontSize: AppSizes.s14,
          color: AppColors.colorBaseBlack,
        ),
      ),
    ),
    DataColumn(
      label: Text(
        'TOTAL',
        style: Get.textTheme.labelLarge!.copyWith(
          fontSize: AppSizes.s14,
          color: AppColors.colorBaseBlack,
        ),
      ),
    ),
  ];
}

List<DataRow> getRowsDetailMedicineReportBuy({
  required ApotikController controller,
  required List<DatumReportPurchase> data,
  required bool isLoading,
  required int selectedPurchaseNo, // no pembelian yang dipilih
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

  // Filter data berdasarkan no pembelian yang dipilih
  final filteredData =
      data.where((purchase) => purchase.no == selectedPurchaseNo);

  final List<DataRow> rows = [];

  for (final purchase in filteredData) {
    final details = purchase.detail;
    for (final entry in details.asMap().entries) {
      final index = entry.key;
      final detail = entry.value;

      controller.grandTotalDetailPurchaseReport.value += detail.subtotal;

      rows.add(
        DataRow(
          color: WidgetStateProperty.resolveWith<Color>(
            (Set<WidgetState> states) {
              return index % 2 == 0
                  ? Colors.white
                  : AppColors.colorBasePrimary.withAlpha(80);
            },
          ),
          cells: [
            DataCell(Text(detail.no.toString(),
                style: const TextStyle(fontWeight: FontWeight.bold))),
            DataCell(Text(detail.namaObat,
                style: const TextStyle(fontWeight: FontWeight.bold))),
            DataCell(Text(detail.hargaBeli.currencyFormatRp,
                style: const TextStyle(fontWeight: FontWeight.bold))),
            DataCell(Text(detail.jumlah.toString(),
                style: const TextStyle(fontWeight: FontWeight.bold))),
            DataCell(Text(
                detail.tanggalExpired.toDateddmmmyyyyFormattedString(),
                style: const TextStyle(fontWeight: FontWeight.bold))),
            DataCell(Text(detail.subtotal.currencyFormatRp,
                style: const TextStyle(fontWeight: FontWeight.bold))),
          ],
        ),
      );
    }
  }

  // Jika tidak ada pembelian yang cocok, tampilkan pesan kosong
  if (rows.isEmpty) {
    return [
      const DataRow(
        cells: [
          DataCell.empty,
          DataCell.empty,
          DataCell(Text('Detail pembelian tidak ditemukan')),
          DataCell.empty,
          DataCell.empty,
          DataCell.empty,
        ],
      )
    ];
  }

  return rows;
}
