import 'package:drop_down_search_field/drop_down_search_field.dart';
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
import 'package:klinik_web_responsif/core/utils/extensions/date_ext.dart';
import 'package:klinik_web_responsif/core/utils/extensions/int_ext.dart';
import 'package:klinik_web_responsif/core/utils/extensions/sized_box_ext.dart';
import 'package:klinik_web_responsif/core/utils/extensions/string_casing_ext.dart';
import 'package:klinik_web_responsif/presentations/apotik/controller/apotik_controller.dart';
import 'package:klinik_web_responsif/services/apotik/model/response/get_unit_response.dart';
import 'package:lottie/lottie.dart';
import 'package:number_paginator/number_paginator.dart';

class TabMenuBuyScreen extends StatelessWidget {
  final ApotikController controller;
  const TabMenuBuyScreen({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        children: [
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'No Pembelian',
                      style: Get.textTheme.bodyMedium!.copyWith(
                          fontSize: AppSizes.s17,
                          color: AppColors.colorBaseBlack),
                    ),
                    AppSizes.s10.height,
                    Obx(() => Text(
                          controller.purchaseNumber.value,
                          style: Get.textTheme.labelLarge!.copyWith(
                              fontSize: AppSizes.s17,
                              color: AppColors.colorBaseBlack),
                        )),
                  ],
                ),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Tanggal Pembelian',
                          style: Get.textTheme.bodyMedium!.copyWith(
                              fontWeight: FontWeight.w700,
                              fontSize: AppSizes.s14,
                              color: AppColors.colorBaseBlack),
                        ),
                        AppSizes.s12.height,
                        InkWell(
                          onTap: () async {
                            final DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1950),
                              lastDate: DateTime
                                  .now(), // ⛔ hanya sampai hari ini, tidak bisa pilih besok
                            );
                            if (pickedDate != null) {
                              controller.dateBuyMedicineController.value =
                                  pickedDate;
                            }
                          },
                          child: Container(
                              padding: AppSizes.symmetricPadding(
                                  vertical: AppSizes.s5,
                                  horizontal: AppSizes.s20),
                              width: 200,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: AppColors.colorSecondary400,
                                ),
                                borderRadius:
                                    BorderRadius.circular(AppSizes.s4),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.calendar_month,
                                    weight: AppSizes.s20,
                                    size: AppSizes.s30,
                                    color: AppColors.colorNeutrals100,
                                  ),
                                  AppSizes.s10.width,
                                  Text(
                                    controller.dateBuyMedicineController.value
                                        .toDateyyyymmddFormattedString(),
                                    style: Get.textTheme.bodySmall!.copyWith(
                                      fontSize: AppSizes.s14,
                                      color: AppColors.colorNeutrals400,
                                    ),
                                  ),
                                ],
                              ).paddingSymmetric(vertical: AppSizes.s5)),
                        ),
                        AppSizes.s12.height,
                      ],
                    ),
                    AppSizes.s20.width,
                    Container(
                      width: 200,
                      child: InputDataComponent(
                          label: 'Supplier',
                          hintText: 'Masukan Nama Supplier',
                          controller: controller.supplierController),
                    ),
                  ],
                ),
              ],
            ),
          ),
          AppSizes.s20.height,
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(
                () {
                  return CustomTabelComponent(
                    label: 'Pilih Obat',
                    sizeRowTabel: MediaQuery.of(context).size.width / 1.1,
                    sizeWidth: MediaQuery.of(context).size.width / 1,
                    border: TableBorder.all(
                      color: AppColors.colorBaseSecondary.withAlpha(50),
                    ),
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
                          final parts =
                              input.split(',').map((e) => e.trim()).toList();

                          String name = '';
                          String no_buy = '';

                          for (var part in parts) {
                            if (RegExp(r'^(BUY-\d+|\d{3,})$').hasMatch(part)) {
                              no_buy = part;
                            } else {
                              name += '$part ';
                            }
                          }
                          controller.nameMedicineStock.value = name;
                          no_buy = no_buy.trim();
                          name = name.trim();
                          controller.getGroupStockMedicine(name_medicine: name);
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
                          'SATUAN',
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
                    listRows: controller.isLoadingGroupStock.value
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
                              ],
                            ),
                          ]
                        : controller.medicineGroupStockList.isEmpty
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
                                    DataCell.empty,
                                  ],
                                ),
                              ]
                            : controller.medicineGroupStockList
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
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                        ),
                                      ),
                                      DataCell(
                                        Text(
                                          row.totalStock.toString(),
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      DataCell(
                                        Center(
                                          child: Text(
                                            row.nameUnit
                                                .split(' ')
                                                .map((word) => word.isNotEmpty
                                                    ? '${word[0].toUpperCase()}${word.substring(1)}'
                                                    : '')
                                                .join(' '),
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                          ),
                                        ),
                                      ),
                                      DataCell(
                                        Center(
                                          child: IconButton(
                                            onPressed: () {
                                              controller
                                                  .addSelectedMedicine(row.id);
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
              AppSizes.s20.height,
              Obx(
                () {
                  return CustomTabelComponent(
                    label: 'Detail Pembelian',
                    sizeRowTabel: MediaQuery.of(context).size.width / 1.1,
                    sizeWidth: MediaQuery.of(context).size.width / 1,
                    border: TableBorder.all(
                      color: AppColors.colorBaseSecondary.withAlpha(50),
                    ),
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
                        Obx(() => Text(
                              'Grand Total : ${controller.grandTotal.value.currencyFormatRp}',
                              style: Get.textTheme.labelLarge!.copyWith(
                                  fontSize: AppSizes.s17,
                                  color: AppColors.colorBaseBlack),
                            )),
                        AppSizes.s10.height,
                        Container(
                          width: 150,
                          child: Button.filled(
                              onPressed: () {
                                showModalCenter(
                                  context,
                                  Obx(
                                    () {
                                      return controller
                                              .isLoadingPostBuyMedicine.value
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
                                                await controller
                                                    .postBuyMedicine();
                                              },
                                            );
                                    },
                                  ),
                                );
                              },
                              label: 'Simpan'),
                        ),
                      ],
                    ),
                    listColumns: [
                      DataColumn(
                        label: Text(
                          'Nama Obat',
                          style: Get.textTheme.labelLarge!.copyWith(
                              fontSize: AppSizes.s14,
                              color: AppColors.colorBaseBlack),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'HARGA BELI',
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
                          'TANGGAL EXPIRE',
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
                    listRows: controller.isLoadingHasExpiredMedicine.value
                        ? [
                            const DataRow(
                              cells: [
                                DataCell.empty,
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
                        : controller.selectedMedicineList.isEmpty
                            ? [
                                const DataRow(
                                  cells: [
                                    DataCell.empty,
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
                            : controller.selectedMedicineList
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
                                          // overflow: TextOverflow.ellipsis,
                                          // maxLines: 1,
                                        ),
                                      ),
                                      DataCell(
                                        Padding(
                                          padding: AppSizes.symmetricPadding(
                                            vertical: AppSizes.s5,
                                          ),
                                          child: CustomTextField(
                                            controller: controller
                                                .priceBuyControllers[index],
                                            keyboardType: TextInputType.text,
                                            onChanged: (value) {
                                              controller
                                                  .updateTotalForIndex(index);
                                            },
                                            horizontal: 10,
                                            vertical: 10,
                                            fontSize: 10,
                                          ),
                                        ),
                                      ),
                                      DataCell(
                                        Padding(
                                          padding: AppSizes.symmetricPadding(
                                            vertical: AppSizes.s5,
                                          ),
                                          child: CustomTextField(
                                            controller: controller
                                                .stockControllers[index],
                                            keyboardType: TextInputType.text,
                                            horizontal: 10,
                                            vertical: 10,
                                            onChanged: (value) {
                                              controller
                                                  .updateTotalForIndex(index);
                                            },
                                            fontSize: 10,
                                          ),
                                        ),
                                      ),
                                      DataCell(
                                        row.conversion.isEmpty
                                            ? Text(
                                                row.nameUnit.toTitleCase(),
                                                style: const TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )
                                            : Padding(
                                                padding:
                                                    AppSizes.symmetricPadding(
                                                  vertical: AppSizes.s5,
                                                ),
                                                child: DropDownSearchFormField(
                                                  textFieldConfiguration:
                                                      TextFieldConfiguration(
                                                          decoration:
                                                              InputDecoration(
                                                            contentPadding:
                                                                EdgeInsets
                                                                    .symmetric(
                                                                        vertical:
                                                                            12,
                                                                        horizontal:
                                                                            12),
                                                            suffixIcon: Icon(
                                                                Iconsax
                                                                    .arrow_down_1),
                                                            enabledBorder:
                                                                OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          AppSizes
                                                                              .s4),
                                                              borderSide:
                                                                  BorderSide(
                                                                color: AppColors
                                                                    .colorSecondary400,
                                                                width:
                                                                    AppSizes.s1,
                                                              ),
                                                            ),
                                                            focusedBorder:
                                                                OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          AppSizes
                                                                              .s4),
                                                              borderSide: BorderSide(
                                                                  color: AppColors
                                                                      .colorSecondary400,
                                                                  width:
                                                                      AppSizes
                                                                          .s2),
                                                            ),
                                                          ),
                                                          style: TextStyle(
                                                            fontSize:
                                                                AppSizes.s14,
                                                            color: Colors.black,
                                                          ),
                                                          controller: controller
                                                                  .unitTextControllers[
                                                              index]),
                                                  suggestionsCallback:
                                                      (pattern) {
                                                    return row.conversion
                                                        .map((conv) =>
                                                            DatumUnit.fromUnit(
                                                                conv.unit))
                                                        .where(
                                                          (unit) => unit.name
                                                              .toLowerCase()
                                                              .contains(
                                                                pattern
                                                                    .toLowerCase(),
                                                              ),
                                                        )
                                                        .toList();
                                                  },
                                                  itemBuilder: (context,
                                                      DatumUnit suggestion) {
                                                    return ListTile(
                                                      title: Text(
                                                        suggestion.name
                                                            .split(' ')
                                                            .map((word) => word
                                                                    .isNotEmpty
                                                                ? '${word[0].toUpperCase()}${word.substring(1)}'
                                                                : '')
                                                            .join(' '),
                                                        style: TextStyle(
                                                          fontSize:
                                                              AppSizes.s14,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                  itemSeparatorBuilder:
                                                      (context, index) {
                                                    return const Divider();
                                                  },
                                                  transitionBuilder: (context,
                                                      suggestionsBox,
                                                      controller) {
                                                    return suggestionsBox;
                                                  },
                                                  onSuggestionSelected:
                                                      (DatumUnit suggestion) {
                                                    controller
                                                            .selectedUnitsPerRow[
                                                        index] = [suggestion];
                                                    controller
                                                        .unitTextControllers[
                                                            index]
                                                        .text = suggestion.name;
                                                    controller
                                                            .unitTextControllers[
                                                                index]
                                                            .text =
                                                        suggestion.name
                                                            .toTitleCase();

                                                    // ✅ Update ID juga
                                                    controller.selectedUnitIds[
                                                        index] = suggestion.id;
                                                  },
                                                  suggestionsBoxController:
                                                      controller
                                                          .suggestionBoxController,
                                                  validator: (value) =>
                                                      value!.isEmpty
                                                          ? ''
                                                          : null,
                                                  onSaved: (value) {},
                                                  displayAllSuggestionWhenTap:
                                                      true,
                                                ),
                                              ),
                                      ),
                                      DataCell(
                                        Padding(
                                          padding: AppSizes.symmetricPadding(
                                            vertical: AppSizes.s5,
                                          ),
                                          child: InkWell(
                                            onTap: () async {
                                              final DateTime? pickedDate =
                                                  await showDatePicker(
                                                context: context,
                                                initialDate: DateTime.now(),
                                                firstDate: DateTime.now(),
                                                lastDate: DateTime(
                                                    2045), // ⛔ hanya sampai hari ini, tidak bisa pilih besok
                                              );
                                              if (pickedDate != null) {
                                                controller.tglKadaluarsaList[
                                                    index] = pickedDate;
                                              }
                                            },
                                            child: Container(
                                              padding:
                                                  AppSizes.symmetricPadding(
                                                vertical: AppSizes.s10,
                                                horizontal: AppSizes.s16,
                                              ),
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: AppColors
                                                      .colorSecondary400,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        AppSizes.s4),
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Icon(
                                                    Icons.calendar_month,
                                                    weight: AppSizes.s20,
                                                    size: AppSizes.s20,
                                                    color: AppColors
                                                        .colorNeutrals100,
                                                  ),
                                                  AppSizes.s5.width,
                                                  Text(
                                                    controller.tglKadaluarsaList[
                                                                index] !=
                                                            []
                                                        ? controller
                                                            .tglKadaluarsaList[
                                                                index]
                                                            .toDateyyyymmddFormattedString()
                                                        : 'Pilih Tanggal',
                                                    style: Get
                                                        .textTheme.bodySmall!
                                                        .copyWith(
                                                      fontSize: AppSizes.s12,
                                                      color: AppColors
                                                          .colorNeutrals400,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      DataCell(
                                        Obx(
                                          () {
                                            return Container(
                                              width: 100,
                                              child: Text(
                                                controller
                                                    .totalSelectedMedicineList[
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
                                              controller.removeSelectedMedicine(
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
