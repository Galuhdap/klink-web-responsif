import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:klinik_web_responsif/core/components/custom_tabel_component.dart';
import 'package:klinik_web_responsif/core/components/search_new_component.dart';
import 'package:klinik_web_responsif/core/resources/constans/app_constants.dart';
import 'package:klinik_web_responsif/core/styles/app_colors.dart';
import 'package:klinik_web_responsif/core/styles/app_sizes.dart';
import 'package:klinik_web_responsif/presentations/apotik/controller/apotik_controller.dart';
import 'package:klinik_web_responsif/presentations/apotik/screen/tabel/list_latter_sick_tabel.dart';
import 'package:number_paginator/number_paginator.dart';

class LatterSickValidasi extends StatelessWidget {
  const LatterSickValidasi({super.key, required this.controller});

  final ApotikController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return Expanded(
          child: ListView(
            children: [
              CustomTabelComponent(
                label: 'Surat Sakit',
                sizeRowTabel: MediaQuery.of(context).size.width / 1.1,
                sizeWidth: MediaQuery.of(context).size.width / 1,
                border: TableBorder.all(
                  color: AppColors.colorBaseSecondary.withAlpha(50),
                ),
                customContentPagination:
                    controller.numberOfPageLetterSick.value <= 1
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
                                    borderRadius:
                                        BorderRadius.circular(AppSizes.s4),
                                  ),
                                  child: Obx(() {
                                    return NumberPaginator(
                                      numberPages: controller
                                          .numberOfPageLetterSick.value,
                                      onPageChange: (int index) {
                                        final page = index + 1;

                                        controller.getLetterSick(
                                            page: page,
                                            no_latter: controller
                                                .noLetterSickSearch.value);
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
                customContent: Row(
                  children: [
                    Flexible(
                      child: Container(
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
                              name = input.trim();
                              controller.noLetterSickSearch.value = name;
                              controller.getLetterSick(no_latter: name);
                            }),
                      ),
                    ),
                  ],
                ),
                listColumns: getListLatterSickColumns(),
                listRows: getRowsLatterSickSale(
                    data: controller.sickLetterList,
                    isLoading: controller.isLoadingSickLetter.value,
                    controller: controller),
              ),
            ],
          ),
        );
      },
    );
  }
}
