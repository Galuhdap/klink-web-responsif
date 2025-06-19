import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:klinik_web_responsif/core/assets/assets.gen.dart';
import 'package:klinik_web_responsif/core/components/modal/show_modal_tanda_tanya_component.dart';
import 'package:klinik_web_responsif/core/components/show_center_dialog.dart';
import 'package:klinik_web_responsif/core/styles/app_colors.dart';
import 'package:klinik_web_responsif/core/styles/app_sizes.dart';
import 'package:klinik_web_responsif/core/utils/extensions/date_ext.dart';
import 'package:klinik_web_responsif/presentations/apotik/controller/apotik_controller.dart';
import 'package:klinik_web_responsif/services/apotik/model/response/get_has_expired_medicine_response.dart';
import 'package:lottie/lottie.dart';

List<DataColumn> getListMedicineExpiredColumns() {
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
        'NO PEMBELIAN',
        style: Get.textTheme.labelLarge!.copyWith(
          fontSize: AppSizes.s14,
          color: AppColors.colorBaseBlack,
        ),
      ),
    ),
    DataColumn(
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
        'TANGGAL EXPIRE',
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

List<DataRow> getRowsMedicineExpired({
  required List<DatumHasExpiredMedicine> data, // ganti dengan model aslimu
  required bool isLoading,
  required BuildContext context,
  required ApotikController controller,
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
        DataCell(Text(row.noBuy,
            style: const TextStyle(fontWeight: FontWeight.bold))),
        DataCell(Text(row.stock.toString(),
            style: const TextStyle(fontWeight: FontWeight.bold))),
        DataCell(Center(
          child: Text(row.tanggalExpired.toDateddmmmyyyyFormattedString(),
              style: const TextStyle(fontWeight: FontWeight.bold)),
        )),
        DataCell(
          Center(
            child: Container(
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
                        return controller.isLoadingHasExpiredMedicine.value
                            ? Center(
                                child: SizedBox(
                                  width: 400,
                                  height: 400,
                                  child: Lottie.asset(Assets.lottie.hospital),
                                ),
                              )
                            : ShowModalTandaTanyaComponent(
                                label:
                                    'Apakah Anda Akan Menghapus Obat ${row.nameMedicine} Expired?',
                                onTapNo: () {
                                  Get.back();
                                },
                                onTapYes: () async {
                                  await controller
                                      .deleteHasMedicineExpired(row.id);
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
          ),
        ), // Ganti sesuai kebutuhan
      ],
    );
  }).toList();
}
