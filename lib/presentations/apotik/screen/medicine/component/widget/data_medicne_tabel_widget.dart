import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:klinik_web_responsif/core/components/custom_tabel_component.dart';
import 'package:klinik_web_responsif/core/components/search_new_component.dart';
import 'package:klinik_web_responsif/core/resources/constans/app_constants.dart';
import 'package:klinik_web_responsif/core/styles/app_colors.dart';
import 'package:klinik_web_responsif/core/styles/app_sizes.dart';
import 'package:klinik_web_responsif/presentations/apotik/controller/apotik_controller.dart';
import 'package:klinik_web_responsif/presentations/apotik/screen/tabel/list_medicine_tabel.dart';
import 'package:number_paginator/number_paginator.dart';

class DataMedicineTableWidget extends StatelessWidget {
  const DataMedicineTableWidget({
    super.key,
    required this.controller,
  });

  final ApotikController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return CustomTabelComponent(
        label: 'Data Obat',
        sizeRowTabel: MediaQuery.of(context).size.width / 1.1,
        sizeWidth: MediaQuery.of(context).size.width / 1,
        border: TableBorder.all(
          color: AppColors.colorBaseSecondary.withAlpha(50),
        ),
        customContentPagination: controller.numberOfPageNewMedicine.value <= 1
            ? Container()
            : Container(
                width: double.infinity,
                padding: AppSizes.onlyPadding(bottom: AppSizes.s50),
                child: Column(
                  children: [
                    Container(
                      //width: 400,
                      decoration: BoxDecoration(
                        color: AppColors.colorBaseWhite,
                        borderRadius: BorderRadius.circular(AppSizes.s4),
                      ),
                      child: Obx(() {
                        return NumberPaginator(
                          numberPages: controller.numberOfPageNewMedicine.value,
                          onPageChange: (int index) {
                            final page = index + 1;

                            controller.getNewMedicine(
                                page: page,
                                name_medicine:
                                    controller.nameMedicineNew.value);
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
        customContent: Container(
          width: MediaQuery.of(context).size.width / 1.1,
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
              final name = value.trim();
              controller.nameMedicineNew.value = name;
              controller.getNewMedicine(name_medicine: name);
            },
          ),
        ),
        listColumns: getListMedicineColumns(),
        listRows: getRowsMedicine(
          context: context,
          controller: controller,
          data: controller.medicineNewList,
          isLoading: controller.isLoadingHasExpiredMedicine.value,
        ),
      );
    });
  }
}
