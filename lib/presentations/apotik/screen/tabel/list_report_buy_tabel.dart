import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:klinik_web_responsif/core/styles/app_colors.dart';
import 'package:klinik_web_responsif/core/styles/app_sizes.dart';
import 'package:klinik_web_responsif/core/utils/extensions/date_ext.dart';
import 'package:klinik_web_responsif/core/utils/extensions/int_ext.dart';
import 'package:klinik_web_responsif/presentations/apotik/controller/apotik_controller.dart';
import 'package:klinik_web_responsif/services/apotik/model/response/get_purchase_report_medicine_response.dart';

List<DataColumn> getListMedicineReportBuyColumns() {
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
        'NO PEMBELIAN',
        style: Get.textTheme.labelLarge!.copyWith(
          fontSize: AppSizes.s14,
          color: AppColors.colorBaseBlack,
        ),
      ),
    ),
    DataColumn(
      label: Text(
        'SUPPLIER',
        style: Get.textTheme.labelLarge!.copyWith(
          fontSize: AppSizes.s14,
          color: AppColors.colorBaseBlack,
        ),
      ),
    ),
    DataColumn(
      label: Text(
        'TANGGAL',
        style: Get.textTheme.labelLarge!.copyWith(
          fontSize: AppSizes.s14,
          color: AppColors.colorBaseBlack,
        ),
      ),
    ),
    DataColumn(
      label: Text(
        'USER',
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

List<DataRow> getRowsMedicineReportBuy({
  required ApotikController controller,
  required List<DatumReportPurchase> data, // ganti dengan model aslimu
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
        DataCell(Text(row.noPembelian,
            style: const TextStyle(fontWeight: FontWeight.bold))),
        DataCell(Text(row.supplier,
            style: const TextStyle(fontWeight: FontWeight.bold))),
        DataCell(Text(row.tanggalPembelian.toDateddmmmyyyyFormattedString(),
            style: const TextStyle(fontWeight: FontWeight.bold))),
        DataCell(Text(row.userInput,
            style: const TextStyle(fontWeight: FontWeight.bold))),
        DataCell(Text(row.total.currencyFormatRp,
            style: const TextStyle(fontWeight: FontWeight.bold))),
        DataCell(
          Center(
            child: InkWell(
              onTap: () {
                controller.noPurchaseReport.value = row.no;
                controller.noBuyDetailPurchaseReport.value = row.noPembelian;
                controller.dateBuyDetailPurchaseReport.value =
                    row.tanggalPembelian.toDateddmmmyyyyFormattedString();
                controller.supplierBuyDetailPurchaseReport.value = row.supplier;
                controller.petugasBuyDetailPurchaseReport.value = row.userInput;
                controller.showDetail(row.detail);
              },
              child: Container(
                width: 100,
                height: 30,
                decoration: BoxDecoration(
                  color: AppColors.colorBasePrimary,
                  borderRadius: BorderRadius.circular(
                    AppSizes.s5,
                  ),
                ),
                child: Center(
                  child: Text(
                    'Detail',
                    style: Get.textTheme.labelMedium!.copyWith(
                      fontSize: AppSizes.s14,
                      fontWeight: FontWeight.w100,
                      color: AppColors.colorBaseWhite,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ), // Ganti sesuai kebutuhan
      ],
    );
  }).toList();
}
