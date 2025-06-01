import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:klinik_web_responsif/core/assets/assets.gen.dart';
import 'package:klinik_web_responsif/core/components/button_component.dart';
import 'package:klinik_web_responsif/core/components/input_data_component.dart';
import 'package:klinik_web_responsif/core/components/show_center_dialog.dart';
import 'package:klinik_web_responsif/core/styles/app_colors.dart';
import 'package:klinik_web_responsif/core/styles/app_sizes.dart';
import 'package:klinik_web_responsif/core/utils/extensions/int_ext.dart';
import 'package:klinik_web_responsif/core/utils/extensions/sized_box_ext.dart';
import 'package:klinik_web_responsif/presentations/apotik/controller/apotik_controller.dart';
import 'package:klinik_web_responsif/services/apotik/model/response/get_new_medicine_response.dart';
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
          // DataCell.empty,
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
          // DataCell.empty,
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
        // DataCell(Text(row.priceBuy.currencyFormatRp,
        //     style: const TextStyle(fontWeight: FontWeight.bold))),
        DataCell(Text(row.priceSell.currencyFormatRp,
            style: const TextStyle(fontWeight: FontWeight.bold))),
        DataCell(Center(
          child: Text(row.stock.toString(),
              style: const TextStyle(fontWeight: FontWeight.bold)),
        )),
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
                    controller.nameMedicineController.text = row.nameMedicine;
                    controller.priceBuyController.text =
                        row.priceBuy.toString();
                    controller.priceSellController.text =
                        row.priceSell.toString();
                    showModalCenter(
                      context,
                      Obx(
                        () {
                          return controller.isLoadingPostNewMedicine.value
                              ? Center(
                                  child: SizedBox(
                                    width: 400,
                                    height: 400,
                                    child: Lottie.asset(Assets.lottie.hospital),
                                  ),
                                )
                              : Form(
                                  key: controller.formKey,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Center(
                                        child: Text(
                                          'Edit Obat',
                                          style: Get.textTheme.labelMedium!
                                              .copyWith(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: AppSizes.s16),
                                        ),
                                      ),
                                      AppSizes.s12.height,
                                      Divider(),
                                      InputDataComponent(
                                        label: 'Nama Obat',
                                        hintText: 'Nama Obat',
                                        controller:
                                            controller.nameMedicineController,
                                      ),
                                      // InputDataComponent(
                                      //   label: 'Harga Beli',
                                      //   hintText: 'Harga Beli',
                                      //   controller:
                                      //       controller.priceBuyController,
                                      // ),
                                      InputDataComponent(
                                        label: 'Harga Jual',
                                        hintText: 'Harga Jual',
                                        controller:
                                            controller.priceSellController,
                                      ),
                                      Row(
                                        children: [
                                          Flexible(
                                            child: Button.outlined(
                                                onPressed: () {
                                                  controller
                                                      .nameMedicineController
                                                      .text = "";
                                                  controller.priceBuyController
                                                      .text = "";
                                                  controller.priceSellController
                                                      .text = "";
                                                  Get.back();
                                                },
                                                label: 'Batal'),
                                          ),
                                          AppSizes.s12.width,
                                          Flexible(
                                            child: Button.filled(
                                                onPressed: () async {
                                                  if (controller
                                                      .formKey.currentState!
                                                      .validate()) {
                                                    controller
                                                        .putNewMedicine(row.id);
                                                  }
                                                },
                                                label: 'Simpan'),
                                          ),
                                        ],
                                      )
                                    ],
                                  ).paddingSymmetric(horizontal: AppSizes.s100),
                                );
                        },
                      ),
                    );
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
                  onPressed: () {},
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
