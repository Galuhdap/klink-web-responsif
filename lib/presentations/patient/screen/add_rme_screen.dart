import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:klinik_web_responsif/core/assets/assets.gen.dart';
import 'package:klinik_web_responsif/core/components/button_component.dart';
import 'package:klinik_web_responsif/core/components/custom_tabel_component.dart';
import 'package:klinik_web_responsif/core/components/input_component.dart';
import 'package:klinik_web_responsif/core/components/input_data_component.dart';
import 'package:klinik_web_responsif/core/components/modal/show_modal_tanda_tanya_component.dart';
import 'package:klinik_web_responsif/core/components/search_new_component.dart';
import 'package:klinik_web_responsif/core/components/show_center_dialog.dart';
import 'package:klinik_web_responsif/core/resources/constans/app_constants.dart';
import 'package:klinik_web_responsif/core/styles/app_colors.dart';
import 'package:klinik_web_responsif/core/styles/app_sizes.dart';
import 'package:klinik_web_responsif/core/utils/extensions/int_ext.dart';
import 'package:klinik_web_responsif/core/utils/extensions/sized_box_ext.dart';
import 'package:klinik_web_responsif/core/utils/extensions/string_casing_ext.dart';
import 'package:klinik_web_responsif/core/utils/helpers/validation_helper.dart';
import 'package:klinik_web_responsif/presentations/apotik/controller/apotik_controller.dart';
import 'package:klinik_web_responsif/presentations/patient/controller/rekam_medis_controller.dart';
import 'package:lottie/lottie.dart';
import 'package:number_paginator/number_paginator.dart';

class AddRmeScreen extends StatelessWidget {
  final ApotikController controller;
  final RekamMedisController controllerRme;
  final String norme;
  final String name;
  final String idPasien;
  const AddRmeScreen({
    super.key,
    required this.controller,
    required this.controllerRme,
    required this.norme,
    required this.name,
    required this.idPasien,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.formKey,
      child: Column(
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.colorBaseWhite,
              borderRadius: BorderRadius.circular(
                AppSizes.s10,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withAlpha(40),
                  spreadRadius: 0,
                  blurRadius: 24,
                  offset: Offset(0, 0),
                ),
              ],
            ),
            child: Column(
              children: [
                Container(
                  padding: AppSizes.symmetricPadding(
                    vertical: AppSizes.s15,
                    horizontal: AppSizes.s15,
                  ),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.colorBasePrimary,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(AppSizes.s10),
                      topRight: Radius.circular(AppSizes.s10),
                    ),
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          controllerRme.backToList();
                        },
                        icon: Icon(Icons.arrow_back_ios_new_rounded,
                            color: AppColors.colorBaseWhite),
                      ),
                      AppSizes.s5.width,
                      Text(
                        'Rekam Medis',
                        style: Get.textTheme.labelLarge!.copyWith(
                            fontSize: AppSizes.s17,
                            color: AppColors.colorBaseWhite),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: AppSizes.symmetricPadding(
                      vertical: AppSizes.s20, horizontal: AppSizes.s20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Nomor Rekam Medis',
                        style: Get.textTheme.bodyMedium!.copyWith(
                            fontSize: AppSizes.s17,
                            color: AppColors.colorBaseBlack),
                      ),
                      AppSizes.s10.height,
                      Text(
                        norme,
                        style: Get.textTheme.labelLarge!.copyWith(
                            fontSize: AppSizes.s17,
                            color: AppColors.colorBaseBlack),
                      ),
                      Divider(
                        color: AppColors.colorBasePrimary,
                      ),
                      Text(
                        name,
                        style: Get.textTheme.labelLarge!.copyWith(
                            fontSize: AppSizes.s20,
                            color: AppColors.colorBaseBlack),
                      ),
                      // Text(
                      //   DateTime.now().toFormattedDateDayTimeString(),
                      //   style: Get.textTheme.labelLarge!.copyWith(
                      //       fontSize: AppSizes.s20,
                      //       color: AppColors.colorBaseBlack),
                      // ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          AppSizes.s20.height,
          Container(
            padding: AppSizes.symmetricPadding(
                vertical: AppSizes.s20, horizontal: AppSizes.s20),
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.colorBaseWhite,
              borderRadius: BorderRadius.circular(
                AppSizes.s10,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withAlpha(40),
                  spreadRadius: 0,
                  blurRadius: 24,
                  offset: Offset(0, 0),
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  spacing: 10,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: InputDataComponent(
                        maxLines: 2,
                        label: 'Keluhan',
                        hintText: 'Keluhan',
                        controller: controllerRme.keluhanController,
                        textInputType: TextInputType.multiline,
                        validator: emptyValidation,
                      ),
                    ),
                    Flexible(
                      child: InputDataComponent(
                        maxLines: 2,
                        label: 'Dx',
                        hintText: 'Dx',
                        controller: controllerRme.dxController,
                        textInputType: TextInputType.multiline,
                        validator: emptyValidation,
                      ),
                    ),
                  ],
                ),
                InputDataComponent(
                  maxLines: 10,
                  label: AppConstants.LABEL_TERAPI_TINDAKAN,
                  hintText: 'Tindakan',
                  controller: controllerRme.terapiTindakanController,
                  textInputType: TextInputType.multiline,
                  validator: emptyValidation,
                ),
              ],
            ),
          ),
          AppSizes.s20.height,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(
                () {
                  return CustomTabelComponent(
                    label: 'Pilih Obat',
                    sizeWidth: MediaQuery.of(context).size.width / 3.1,
                    border: TableBorder.all(
                      color: AppColors.colorBaseSecondary.withAlpha(50),
                    ),
                    sizeRowTabel: MediaQuery.of(context).size.width / 3.1,
                    customContentPagination: controller
                                .numberOfPageMedicineStock.value ==
                            0
                        ? Container()
                        : Center(
                            child: Container(
                              width: MediaQuery.of(context).size.width / 3.2,
                              padding: AppSizes.onlyPadding(
                                bottom: AppSizes.s20,
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    //width: 400,
                                    decoration: BoxDecoration(
                                      color: AppColors.colorBaseWhite,
                                      borderRadius:
                                          BorderRadius.circular(AppSizes.s4),
                                    ),
                                    child: Obx(() {
                                      return NumberPaginator(
                                        numberPages: controller
                                            .numberOfPageMedicineStock.value,
                                        onPageChange: (int index) {
                                          final page = index + 1;

                                          controller.getGroupStockMedicine(
                                              page: page,
                                              name_medicine: controller
                                                  .nameMedicineStock.value);
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
                            color: AppColors.colorNeutrals300.withAlpha(40),
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
                          final input = value.trim();

                          String name = '';

                          controller.nameMedicineStock.value = name;

                          name = input.trim();
                          controllerRme.getGroupStockZeroMedicine(name_medicine: name);
                        },
                      ),
                    ),
                    listColumns: [
                      DataColumn(
                        label: Text(
                          'NO',
                          style: Get.textTheme.labelLarge!.copyWith(
                              fontSize: AppSizes.s14,
                              color: AppColors.colorBaseBlack),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'NAMA OBAT',
                          style: Get.textTheme.labelLarge!.copyWith(
                              fontSize: AppSizes.s14,
                              color: AppColors.colorBaseBlack),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'STOCK',
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
                    listRows: controllerRme.isLoadingGroupStockZero.value
                        ? [
                            const DataRow(
                              cells: [
                                DataCell.empty,
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
                        : controllerRme.medicineGroupStockZeroList.isEmpty
                            ? [
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
                                    DataCell.empty,
                                  ],
                                ),
                              ]
                            : controllerRme.medicineGroupStockZeroList
                                .asMap()
                                .entries
                                .map(
                                (entry) {
                                  final index = entry.key;
                                  final row = entry.value;

                                  return DataRow(
                                    color:
                                        WidgetStateProperty.resolveWith<Color>(
                                            (Set<WidgetState> states) {
                                      if (index % 2 == 0) {
                                        return AppColors.colorBasePrimary
                                            .withAlpha(80);
                                      }
                                      return Colors.white;
                                    }),
                                    cells: [
                                      DataCell(
                                        Text(
                                          row.no.toString(),
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      DataCell(
                                        Text(
                                          row.nameMedicine,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      DataCell(
                                        Text(
                                          "${row.totalStock.toString()} ${row.nameUnit.toTitleCase()}",
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      DataCell(
                                        Center(
                                          child: IconButton(
                                            onPressed: () {
                                              // controllerRme.idPasienRme.value =
                                              //     row.id;
                                              controllerRme
                                                  .addSelectedMedicineRme(
                                                      row.id);
                                            },
                                            icon: Icon(
                                              Iconsax.add_circle5,
                                            ),
                                            color: AppColors.colorBasePrimary,
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
              Obx(
                () {
                  return CustomTabelComponent(
                    label: 'Obat Yang Diberikan',
                    sizeWidth: MediaQuery.of(context).size.width / 1.7,
                    sizeRowTabel: MediaQuery.of(context).size.width / 1.7,
                    customContentBottom: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppSizes.s10.height,
                        Container(
                          width: MediaQuery.of(context).size.width / 1.8,
                          height: 1,
                          color: AppColors.colorBaseSecondary,
                        ),
                        AppSizes.s10.height,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Biaya Dokter',
                              style: Get.textTheme.bodyMedium!.copyWith(
                                fontSize: AppSizes.s15,
                                fontWeight: FontWeight.bold,
                                color: AppColors.colorBaseBlack,
                              ),
                            ),
                            10.width,
                            Container(
                              width: 200,
                              height: 60,
                              child: CustomTextField(
                                hintText: 'Masukan Biaya',
                                readOnly: controllerRme
                                        .selectedMedicineListRme.isEmpty
                                    ? true
                                    : false,
                                controller: controllerRme.feeDocterController,
                                keyboardType: TextInputType.text,
                                horizontal: 10,
                                vertical: 10,
                                validator: emptyValidation,
                                onChanged: (value) {
                                  controllerRme.updateGrandTotalRme();
                                },
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),
                        10.height,
                        Obx(() => Text(
                              'Grand Total : ${controllerRme.grandTotalRme.value.currencyFormatRp}',
                              style: Get.textTheme.labelLarge!.copyWith(
                                  fontSize: AppSizes.s17,
                                  color: AppColors.colorBaseBlack),
                            )),
                        AppSizes.s10.height,
                        Container(
                          width: 150,
                          child: Button.filled(
                              onPressed: () {
                                if (controller.formKey.currentState!
                                    .validate()) {
                                  showModalCenter(
                                    context,
                                    Obx(
                                      () {
                                        return controllerRme
                                                .isLoadingCreate.value
                                            ? Center(
                                                child: SizedBox(
                                                  width: 400,
                                                  height: 400,
                                                  child: Lottie.asset(
                                                      Assets.lottie.hospital),
                                                ),
                                              )
                                            : ShowModalTandaTanyaComponent(
                                                label:
                                                    'Apakah anda sudah yakin ?',
                                                onTapNo: () {
                                                  Get.back();
                                                },
                                                onTapYes: () async {
                                                  await controllerRme
                                                      .postRme(idPasien);
                                                },
                                              );
                                      },
                                    ),
                                  );
                                }
                              },
                              label: 'Simpan'),
                        ),
                      ],
                    ),
                    listColumns: [
                      DataColumn(
                        label: Text(
                          'NAMA OBAT',
                          style: Get.textTheme.labelLarge!.copyWith(
                              fontSize: AppSizes.s14,
                              color: AppColors.colorBaseBlack),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'HARGA',
                          style: Get.textTheme.labelLarge!.copyWith(
                              fontSize: AppSizes.s14,
                              color: AppColors.colorBaseBlack),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'JUMLAH',
                          style: Get.textTheme.labelLarge!.copyWith(
                              fontSize: AppSizes.s14,
                              color: AppColors.colorBaseBlack),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'SATUAN',
                          style: Get.textTheme.labelLarge!.copyWith(
                              fontSize: AppSizes.s14,
                              color: AppColors.colorBaseBlack),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'TOTAL',
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
                    listRows: controllerRme.isLoadingGroupStock.value
                        ? [
                            const DataRow(
                              cells: [
                                DataCell.empty,
                                DataCell.empty,
                                DataCell(
                                  Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                ),
                                DataCell.empty,
                                DataCell.empty,
                                DataCell.empty,
                              ],
                            ),
                          ]
                        : controllerRme.selectedMedicineListRme.isEmpty
                            ? [
                                const DataRow(
                                  cells: [
                                    DataCell.empty,
                                    DataCell.empty,
                                    DataCell(
                                      Row(
                                        spacing: 4,
                                        children: [
                                          Icon(Icons.highlight_off),
                                          //SpaceWidth(4.0),
                                          Text('Data tidak ditemukan..'),
                                        ],
                                      ),
                                    ),
                                    DataCell.empty,
                                    DataCell.empty,
                                    DataCell.empty,
                                  ],
                                ),
                              ]
                            : controllerRme.selectedMedicineListRme
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
                                          row.nameMedicine,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      DataCell(Text(
                                        controllerRme
                                            .selectedMedicineListRme[index]
                                            .priceSell
                                            .currencyFormatRp,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      )),
                                      DataCell(
                                        Padding(
                                          padding: AppSizes.symmetricPadding(
                                            vertical: AppSizes.s5,
                                          ),
                                          child: CustomTextField(
                                            controller: controllerRme
                                                .stockControllersRme[index],
                                            keyboardType: TextInputType.text,
                                            horizontal: 10,
                                            vertical: 10,
                                            validator: emptyValidation,
                                            onChanged: (value) {
                                              controllerRme
                                                  .updateTotalForIndexRme(
                                                      index);
                                            },
                                            fontSize: 10,
                                          ),
                                        ),
                                      ),
                                      DataCell(
                                        Text(
                                          row.nameUnit.toTitleCase(),
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      DataCell(
                                        Obx(
                                          () {
                                            return Container(
                                              width: 100,
                                              child: Text(
                                                controllerRme
                                                    .totalSelectedMedicineListRme[
                                                        index]
                                                    .value
                                                    .currencyFormatRp,
                                                style: const TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                      DataCell(
                                        Center(
                                          child: IconButton(
                                            onPressed: () {
                                              controllerRme
                                                  .removeSelectedMedicineRme(
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
          )
        ],
      ),
    );
  }
}
