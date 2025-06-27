import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:klinik_web_responsif/core/components/button_print_component.dart';
import 'package:klinik_web_responsif/core/components/card_dashboard_component.dart';
import 'package:klinik_web_responsif/core/components/custom_tabel_component.dart';
import 'package:klinik_web_responsif/core/components/search_new_component.dart';
import 'package:klinik_web_responsif/core/config/responsive.dart';
import 'package:klinik_web_responsif/core/resources/constans/app_constants.dart';
import 'package:klinik_web_responsif/core/styles/app_colors.dart';
import 'package:klinik_web_responsif/core/styles/app_sizes.dart';
import 'package:klinik_web_responsif/core/utils/extensions/int_ext.dart';
import 'package:klinik_web_responsif/core/utils/extensions/sized_box_ext.dart';
import 'package:klinik_web_responsif/presentations/apotik/controller/apotik_controller.dart';
import 'package:klinik_web_responsif/presentations/apotik/screen/letter/validasi/list_patient_letter_validsadi.dart';
import 'package:klinik_web_responsif/presentations/apotik/screen/tabel/list_latter_rme_tabel.dart';
import 'package:klinik_web_responsif/presentations/docter/controller/docter_controller.dart';
import 'package:klinik_web_responsif/presentations/docter/screen/add_letter_rme.dart';
import 'package:klinik_web_responsif/presentations/home/controllers/home_controller.dart';
import 'package:klinik_web_responsif/presentations/menu_dashboard/widget/build_app_bar.dart';
import 'package:klinik_web_responsif/presentations/patient/controller/patient_controller.dart';
import 'package:klinik_web_responsif/presentations/patient/controller/rekam_medis_controller.dart';
import 'package:number_paginator/number_paginator.dart';

class SummeryDoctorScreen extends StatelessWidget {
  const SummeryDoctorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DocterController>(
      init: DocterController(),
      builder: (controller) {
        var controllerRme = Get.put(RekamMedisController());
        var controllerApotik = Get.put(ApotikController());
        var controllerHome = Get.put(HomeController());
        var controllerPatient = Get.put(PatientController());
        return Scaffold(
          backgroundColor: Color(0xfffF8F8F8),
          appBar: PreferredSize(
            preferredSize: Responsive.isMobile(context)
                ? Size.fromHeight(90.0)
                : Size.fromHeight(110.0),
            child: BuildAppBar(
              title: 'Klinik Chania Care Center',
              withSearchInput: true,
              searchController: TextEditingController(),
              searchHint: 'Cari Pasien',
              searchChanged: (_) {},
            ),
          ),
          body: Obx(
            () {
              return Expanded(
                child: controller.isPatientView.value
                    ? ListPastientLatterValidation(
                        controllerPatient: controllerPatient,
                        controllerHome: controllerHome,
                        contollerApotik: controllerApotik,
                        controllerRme: controllerRme,
                        controllerDocter: controller,
                        isMakeDokter: true,
                        onPressed: () {
                          controller.backPatient();
                        },
                      ).paddingSymmetric(
                        vertical: AppSizes.s41,
                        horizontal: AppSizes.s28,
                      )
                    : controller.isAddLetterRmeView.value
                        ? AddLetterRmeValidation(
                            controller: controller,
                            controllerRme: controllerRme,
                          ).paddingSymmetric(
                            vertical: AppSizes.s41,
                            horizontal: AppSizes.s28,
                          )
                        : controller.isEditLetterRmeView.value
                            ? AddLetterRmeValidation(
                                controller: controller,
                                controllerRme: controllerRme,
                                id: controller.idPasienLetter.value,
                              ).paddingSymmetric(
                                vertical: AppSizes.s41,
                                horizontal: AppSizes.s28,
                              )
                            : ListView(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    spacing: AppSizes.s16,
                                    children: [
                                      Flexible(
                                        child: CardDashbordComponent(
                                          title: 'Total Fee Dokter',
                                          count:
                                              controller.isLoadingSummary.value
                                                  ? 'Load....'
                                                  : controller
                                                              .getSummaryDoctor
                                                              .value!
                                                              .data
                                                              .totalFeeDokter ==
                                                          0
                                                      ? 0.currencyFormatRp
                                                      : controller
                                                          .getSummaryDoctor
                                                          .value!
                                                          .data
                                                          .totalFeeDokter
                                                          .currencyFormatRp,
                                        ),
                                      ),
                                      Flexible(
                                        child: CardDashbordComponent(
                                          title: 'Total Pasien Di Periksa',
                                          changeIcon: false,
                                          iconSaxChange: Iconsax.dollar_circle4,
                                          count: controller
                                                  .isLoadingSummary.value
                                              ? 'Load....'
                                              : controller
                                                          .getSummaryDoctor
                                                          .value!
                                                          .data
                                                          .totalPasienDiperiksa ==
                                                      ''
                                                  ? ''
                                                  : controller
                                                      .getSummaryDoctor
                                                      .value!
                                                      .data
                                                      .totalPasienDiperiksa
                                                      .toString(),
                                        ),
                                      ),
                                    ],
                                  ),
                                  AppSizes.s20.height,
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    spacing: AppSizes.s16,
                                    children: [
                                      Flexible(
                                          child: CardDashbordComponent(
                                        title: 'Fee Dokter Hari Ini',
                                        count: controller.isLoadingSummary.value
                                            ? 'Load....'
                                            : controller
                                                        .getSummaryDoctor
                                                        .value!
                                                        .data
                                                        .totalFeeDokterHariIni ==
                                                    0
                                                ? 0.currencyFormatRp
                                                : controller
                                                    .getSummaryDoctor
                                                    .value!
                                                    .data
                                                    .totalFeeDokterHariIni
                                                    .currencyFormatRp,
                                      )),
                                      Flexible(
                                        child: CardDashbordComponent(
                                            title:
                                                'Total Pasien Di Periksa Hari Ini',
                                            changeIcon: false,
                                            iconSaxChange:
                                                Iconsax.dollar_circle4,
                                            count: controller
                                                    .isLoadingSummary.value
                                                ? 'Load....'
                                                : controller
                                                            .getSummaryDoctor
                                                            .value!
                                                            .data
                                                            .totalPasienHariIni ==
                                                        ''
                                                    ? ''
                                                    : controller
                                                        .getSummaryDoctor
                                                        .value!
                                                        .data
                                                        .totalPasienHariIni
                                                        .toString()),
                                      ),
                                    ],
                                  ),
                                  AppSizes.s20.height,
                                  CustomTabelComponent(
                                    label: 'Surat Rekam Medis Electronic',
                                    sizeRowTabel:
                                        MediaQuery.of(context).size.width / 1.1,
                                    sizeWidth:
                                        MediaQuery.of(context).size.width / 1,
                                    customContentButton: ButtonPrintComponent(
                                      backgroundColor:
                                          AppColors.colorPendingText,
                                      label: 'Tambah Surat',
                                      icon: Icons.add,
                                      onTap: () {
                                        controller.showPatient();
                                      },
                                    ),
                                    border: TableBorder.all(
                                      color: AppColors.colorBaseSecondary
                                          .withAlpha(50),
                                    ),
                                    customContentPagination: controller
                                                .numberOfPageLetterRme.value <=
                                            1
                                        ? Container()
                                        : Container(
                                            width: double.infinity,
                                            padding: AppSizes.onlyPadding(
                                                bottom: AppSizes.s50),
                                            child: Column(
                                              children: [
                                                Container(
                                                  //width: 400,
                                                  decoration: BoxDecoration(
                                                    color: AppColors
                                                        .colorBaseWhite,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            AppSizes.s4),
                                                  ),
                                                  child: Obx(() {
                                                    return NumberPaginator(
                                                      numberPages: controller
                                                          .numberOfPageLetterHealt
                                                          .value,
                                                      onPageChange:
                                                          (int index) {
                                                        final page = index + 1;

                                                        controller.getLetterRmeById(
                                                            page: page,
                                                            no_letter: controller
                                                                .noLetterSearch
                                                                .value);
                                                      },
                                                      child: const SizedBox(
                                                        height: 48,
                                                        width: 300,
                                                        child: Row(
                                                          children: [
                                                            PrevButton(),
                                                            Expanded(
                                                              child:
                                                                  NumberContent(),
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
                                                  color: AppColors
                                                      .colorNeutrals300
                                                      .withAlpha(40),
                                                ),
                                              ],
                                            ),
                                            child: SearchNewComponent(
                                                controller:
                                                    controller.searchController,
                                                keyboardType:
                                                    TextInputType.name,
                                                hintText:
                                                    AppConstants.LABEL_CARI,
                                                suffixIcon: const Icon(
                                                  Icons.search,
                                                  color: AppColors
                                                      .colorSecondary500,
                                                ),
                                                onChanged: (value) {
                                                  final input = value.trim();
                                                  String name = '';
                                                  name = input.trim();
                                                  controller.noLetterSearch
                                                      .value = name;
                                                  controller.getLetterRmeById(
                                                      no_letter: name);
                                                }),
                                          ),
                                        ),
                                      ],
                                    ),
                                    listColumns: getListLatterRmeColumns(),
                                    listRows: getRowsLatterRmeSale(
                                        data: controller.letterRmeList,
                                        controllerRme: controllerRme,
                                        isLoading:
                                            controller.isLoadingLetterRme.value,
                                        controller: controller),
                                  ),
                                ],
                              ).paddingSymmetric(
                                vertical: AppSizes.s41,
                                horizontal: AppSizes.s28,
                              ),
              );
            },
          ),
        );
      },
    );
  }
}
