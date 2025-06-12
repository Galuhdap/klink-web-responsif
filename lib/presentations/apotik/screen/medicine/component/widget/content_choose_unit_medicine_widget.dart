import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:klinik_web_responsif/core/components/custom_tabel_component.dart';
import 'package:klinik_web_responsif/core/components/input_component.dart';
import 'package:klinik_web_responsif/core/components/search_new_component.dart';
import 'package:klinik_web_responsif/core/resources/constans/app_constants.dart';
import 'package:klinik_web_responsif/core/styles/app_colors.dart';
import 'package:klinik_web_responsif/core/styles/app_sizes.dart';
import 'package:klinik_web_responsif/core/utils/extensions/sized_box_ext.dart';
import 'package:klinik_web_responsif/presentations/apotik/controller/apotik_controller.dart';
import 'package:klinik_web_responsif/presentations/apotik/screen/tabel/list_base_unit_choose_tabel.dart';
import 'package:number_paginator/number_paginator.dart';

class ContentChooseUnitMedicineWidget extends StatelessWidget {
  const ContentChooseUnitMedicineWidget({
    super.key,
    required this.controller,
  });

  final ApotikController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return controller.isLightOn.value
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 30,
              children: [
                Column(
                  children: [
                    Obx(
                      () {
                        return CustomTabelComponent(
                          label: 'Pilih Satuan Turunan Obat',
                          sizeWidth: MediaQuery.of(context).size.width / 3.2,
                          border: TableBorder.all(
                            color: AppColors.colorBaseSecondary.withAlpha(50),
                          ),
                          sizeRowTabel: MediaQuery.of(context).size.width / 3.2,
                          customContentPagination: controller
                                      .numberOfPageUnit.value ==
                                  0
                              ? Container()
                              : Center(
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width / 3.2,
                                    padding: AppSizes.onlyPadding(
                                      bottom: AppSizes.s20,
                                    ),
                                    child: Column(
                                      children: [
                                        Container(
                                          //width: 400,
                                          decoration: BoxDecoration(
                                            color: AppColors.colorBaseWhite,
                                            borderRadius: BorderRadius.circular(
                                                AppSizes.s4),
                                          ),
                                          child: Obx(() {
                                            return NumberPaginator(
                                              numberPages: controller
                                                  .numberOfPageUnit.value,
                                              onPageChange: (int index) {
                                                final page = index + 1;

                                                controller.getUnit(
                                                    page: page,
                                                    name: controller
                                                        .nameUnit.value);
                                              },
                                              child: const SizedBox(
                                                height: 48,
                                                width: 300,
                                                child: Row(
                                                  children: [
                                                    PrevButton(),
                                                    Expanded(
                                                      child: NumberContent(),
                                                    ),
                                                    NextButton(),
                                                  ],
                                                ),
                                              ),
                                            );
                                          }),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                          customContent: Container(
                            width: MediaQuery.of(context).size.width / 3.2,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  offset: const Offset(0, 0),
                                  blurRadius: 15,
                                  spreadRadius: 0,
                                  color:
                                      AppColors.colorNeutrals300.withAlpha(40),
                                ),
                              ],
                            ),
                            child: SearchNewComponent(
                              controller: controller.searchController,
                              keyboardType: TextInputType.name,
                              hintText: AppConstants.LABEL_CARI,
                              suffixIcon: const Icon(
                                Icons.search,
                                color: AppColors.colorSecondary500,
                              ),
                              onChanged: (value) {
                                final name = value.trim();
                                controller.nameUnit.value = name;
                                controller.getUnit(name: name);
                              },
                            ),
                          ),
                          listColumns: getListBaseUnitColumns(),
                          listRows: getListBaseUnitRow(
                            data: controller.unitList,
                            isLoading: controller.isLoadingUnit.value,
                            controller: controller,
                            context: context,
                          ),
                        );
                      },
                    ),
                  ],
                ),
                Flexible(
                  child: Column(
                    children: [
                      Obx(
                        () {
                          return CustomTabelComponent(
                            label: 'Detail Pilihan Satuan Turunan Obat',
                            sizeWidth: MediaQuery.of(context).size.width / 1.7,
                            sizeRowTabel:
                                MediaQuery.of(context).size.width / 1.7,
                            customContentBottom: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AppSizes.s10.height,
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width / 1.8,
                                  height: 1,
                                  color: AppColors.colorBaseSecondary,
                                ),
                                AppSizes.s10.height,
                              ],
                            ),
                            listColumns: [
                              DataColumn(
                                label: Text(
                                  'SATUAN',
                                  style: Get.textTheme.labelLarge!.copyWith(
                                      fontSize: AppSizes.s14,
                                      color: AppColors.colorBaseBlack),
                                ),
                              ),
                              DataColumn(
                                headingRowAlignment: MainAxisAlignment.center,
                                label: Text(
                                  'ISI PER UNIT',
                                  style: Get.textTheme.labelLarge!.copyWith(
                                      fontSize: AppSizes.s14,
                                      color: AppColors.colorBaseBlack),
                                ),
                              ),
                              DataColumn(
                                headingRowAlignment: MainAxisAlignment.center,
                                label: Text(
                                  'ACTION',
                                  style: Get.textTheme.labelLarge!.copyWith(
                                      fontSize: AppSizes.s14,
                                      color: AppColors.colorBaseBlack),
                                ),
                              ),
                            ],
                            listRows: controller
                                    .isLoadingHasExpiredMedicine.value
                                ? [
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
                                  ]
                                : controller.selectedMedicineListUnit.isEmpty
                                    ? [
                                        const DataRow(
                                          cells: [
                                            DataCell.empty,
                                            DataCell(
                                              Row(
                                                spacing: 4,
                                                children: [
                                                  Icon(Icons.highlight_off),
                                                  //SpaceWidth(4.0),
                                                  Text(
                                                      'Data tidak ditemukan..'),
                                                ],
                                              ),
                                            ),
                                            DataCell.empty,
                                          ],
                                        ),
                                      ]
                                    : controller.selectedMedicineListUnit
                                        .asMap()
                                        .entries
                                        .map(
                                        (entry) {
                                          final index = entry.key;
                                          final row = entry.value;
                                          return DataRow(
                                            cells: [
                                              DataCell(
                                                Text(
                                                  row.name,
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              DataCell(
                                                Padding(
                                                  padding:
                                                      AppSizes.symmetricPadding(
                                                    vertical: AppSizes.s5,
                                                  ),
                                                  child: CustomTextField(
                                                    controller: controller
                                                        .unitControllers[index],
                                                    keyboardType:
                                                        TextInputType.number,
                                                    horizontal: 10,
                                                    vertical: 10,
                                                    fontSize: 10,
                                                  ),
                                                ),
                                              ),
                                              DataCell(
                                                Center(
                                                  child: IconButton(
                                                    onPressed: () {
                                                      controller
                                                          .removeSelectedMedicineUnit(
                                                              row.id);
                                                    },
                                                    icon: Icon(Iconsax.trash4),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          );
                                        },
                                      ).toList(),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            )
          : Container();
    });
  }
}
