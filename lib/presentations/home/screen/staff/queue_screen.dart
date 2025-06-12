import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:klinik_web_responsif/core/components/card_dashboard_component.dart';
import 'package:klinik_web_responsif/core/components/custom_tabel_component.dart';
import 'package:klinik_web_responsif/core/components/label_status_antrian_component.dart';
import 'package:klinik_web_responsif/core/components/list_mobile_component.dart';
import 'package:klinik_web_responsif/core/components/search_new_component.dart';
import 'package:klinik_web_responsif/core/config/responsive.dart';
import 'package:klinik_web_responsif/core/resources/constans/app_constants.dart';
import 'package:klinik_web_responsif/core/styles/app_colors.dart';
import 'package:klinik_web_responsif/core/styles/app_sizes.dart';
import 'package:klinik_web_responsif/core/utils/extensions/sized_box_ext.dart';
import 'package:klinik_web_responsif/presentations/apotik/controller/apotik_controller.dart';
import 'package:klinik_web_responsif/presentations/home/controllers/home_controller.dart';
import 'package:klinik_web_responsif/presentations/home/screen/mobile/queue_list_mobile.dart';
import 'package:klinik_web_responsif/presentations/home/screen/tabel/list_queue_tabel.dart';
import 'package:klinik_web_responsif/presentations/menu_dashboard/widget/build_app_bar.dart';
import 'package:klinik_web_responsif/presentations/patient/controller/rekam_medis_controller.dart';
import 'package:number_paginator/number_paginator.dart';

class QueueScreen extends StatelessWidget {
  const QueueScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        init: HomeController(),
        builder: (controller) {
          var controllerRme = Get.put(RekamMedisController());
          var controllerApotik = Get.put(ApotikController());
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
                return ListView(
                  children: [
                    Responsive.isMobile(context)
                        ? Column(
                            spacing: AppSizes.s16,
                            children: [
                              Row(
                                spacing: AppSizes.s10,
                                children: [
                                  Flexible(child: Obx(() {
                                    final currentQueue = controller
                                        .processingPatients
                                        .take(3)
                                        .map((e) => e.nomerAntrian)
                                        .join(', ');
                                    return CardDashbordComponent(
                                      title: AppConstants
                                          .LABEL_PASIEN_ANTRIAN_SAAT_INI,
                                      count: currentQueue.isEmpty
                                          ? '-'
                                          : currentQueue,
                                      isIconActive: false,
                                    );
                                  })),
                                  Flexible(
                                    child: Obx(
                                      () {
                                        final nextQueue = controller
                                            .waitingPatients
                                            .take(3)
                                            .map((e) => e.nomerAntrian)
                                            .join(', ');
                                        return CardDashbordComponent(
                                          title: AppConstants
                                              .LABEL_PASIEN_ANTRIAN_SELANJUTNYA,
                                          count: nextQueue.isEmpty
                                              ? '-'
                                              : nextQueue,
                                          isIconActive: false,
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              Obx(
                                () {
                                  return CardDashbordComponent(
                                    title: AppConstants.LABEL_PASIEN_BULAN_INI,
                                    count: controller.isLoadingTotal.value
                                        ? 'Load...'
                                        : controller.totalPasien.value == ''
                                            ? '-'
                                            : controller.totalPasien.value!.data
                                                .pasienBaruBulanIni
                                                .toString(),
                                  );
                                },
                              ),
                              Obx(() {
                                return CardDashbordComponent(
                                  title: AppConstants.LABEL_PASIEN_TERDAFTAR,
                                  count: controller.isLoadingTotal.value
                                      ? 'Load...'
                                      : controller.totalPasien.value == ''
                                          ? '-'
                                          : controller.totalPasien.value!.data
                                              .totalPasien
                                              .toString(),
                                );
                              })
                            ],
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            spacing: AppSizes.s16,
                            children: [
                              Flexible(child: Obx(() {
                                return CardDashbordComponent(
                                  title: AppConstants.LABEL_PASIEN_BULAN_INI,
                                  count: controller.isLoadingTotal.value
                                      ? 'Load...'
                                      : controller.totalPasien.value == ''
                                          ? '-'
                                          : controller.totalPasien.value!.data
                                              .pasienBaruBulanIni
                                              .toString(),
                                );
                              })),
                              Flexible(
                                child: Obx(
                                  () {
                                    return CardDashbordComponent(
                                      title:
                                          AppConstants.LABEL_PASIEN_TERDAFTAR,
                                      count: controller.isLoadingTotal.value
                                          ? 'Load...'
                                          : controller.totalPasien.value == ''
                                              ? '-'
                                              : controller.totalPasien.value!
                                                  .data.totalPasien
                                                  .toString(),
                                    );
                                  },
                                ),
                              ),
                              Flexible(child: Obx(() {
                                final currentQueue = controller
                                    .processingPatients
                                    .take(3)
                                    .map((e) => e.nomerAntrian)
                                    .join(', ');
                                return CardDashbordComponent(
                                  title: AppConstants
                                      .LABEL_PASIEN_ANTRIAN_SAAT_INI,
                                  count:
                                      currentQueue.isEmpty ? '-' : currentQueue,
                                  isIconActive: false,
                                );
                              })),
                              Flexible(
                                child: Obx(
                                  () {
                                    final nextQueue = controller.waitingPatients
                                        .take(3)
                                        .map((e) => e.nomerAntrian)
                                        .join(', ');
                                    return CardDashbordComponent(
                                      title: AppConstants
                                          .LABEL_PASIEN_ANTRIAN_SELANJUTNYA,
                                      count:
                                          nextQueue.isEmpty ? '-' : nextQueue,
                                      isIconActive: false,
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                    AppSizes.s32.height,
                    Responsive.isDesktop(context)
                        ? Column(
                            children: [
                              CustomTabelComponent(
                                label: AppConstants.LABEL_DAFTAR_ANTRIAN,
                                sizeRowTabel:
                                    MediaQuery.of(context).size.width / 1.1,
                                sizeWidth:
                                    MediaQuery.of(context).size.width / 1,
                                customContentPagination: controller
                                            .numberOfPage.value <=
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
                                                color: AppColors.colorBaseWhite,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        AppSizes.s4),
                                              ),
                                              child: Obx(() {
                                                return NumberPaginator(
                                                  numberPages: controller
                                                      .numberOfPage.value,
                                                  onPageChange: (int index) {
                                                    final page = index + 1;
                                                    controller.getAntrianPasien(
                                                        page: page,
                                                        name: controller
                                                            .nameQueueController
                                                            .text,
                                                        no_rme: controller
                                                            .noRmeController
                                                            .text,
                                                        nomer_antrian: controller
                                                            .noQueueController
                                                            .text);
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
                                customContent: Container(
                                  width:
                                      MediaQuery.of(context).size.width / 1.1,
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        offset: const Offset(0, 0),
                                        blurRadius: 15,
                                        spreadRadius: 0,
                                        color: AppColors.colorNeutrals300
                                            .withAlpha(40),
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    children: [
                                      Flexible(
                                        child: SearchNewComponent(
                                          controller:
                                              controller.searchController,
                                          keyboardType: TextInputType.name,
                                          hintText: AppConstants.LABEL_CARI,
                                          suffixIcon: const Icon(
                                            Icons.search,
                                            color: AppColors.colorSecondary500,
                                          ),
                                          onChanged: (value) {
                                            final input = value.trim();
                                            final parts = input
                                                .split(',')
                                                .map((e) => e.trim())
                                                .toList();

                                            String name = '';
                                            String nomerAntrian = '';
                                            String noRme = '';

                                            controller.nameQueueController
                                                .text = name;
                                            controller.noQueueController.text =
                                                nomerAntrian;
                                            controller.noRmeController.text =
                                                noRme;

                                            for (var part in parts) {
                                              if (part
                                                  .toUpperCase()
                                                  .startsWith('RM-')) {
                                                noRme = part;
                                              } else if (int.tryParse(part) !=
                                                  null) {
                                                nomerAntrian = part;
                                              } else {
                                                name = part;
                                              }
                                            }

                                            controller.getAntrianPasien(
                                              name: name.isNotEmpty ? name : '',
                                              nomer_antrian:
                                                  nomerAntrian.isNotEmpty
                                                      ? nomerAntrian
                                                      : '',
                                              no_rme:
                                                  noRme.isNotEmpty ? noRme : '',
                                            );
                                          },
                                        ),
                                      ),
                                      AppSizes.s20.width,
                                      LabelStatusAntrianComponent(),
                                    ],
                                  ),
                                ),
                                listColumns: getListQueueColumns(
                                  controller: controller,
                                ),
                                listRows: getRowsQueue(
                                  context: context,
                                  controller: controller,
                                  data: controller.antrianPasienList,
                                  isLoading: controller.isLoading.value,
                                  controllerApotik: controllerApotik,
                                  controllerRme: controllerRme,
                                ),
                              ),
                              if (controller.role.value == 'ADMIN' &&
                                  controller.role.value == 'APOTIK') ...[
                                AppSizes.s50.height,
                                CustomTabelComponent(
                                  label: "Daftar Antrian Selesai",
                                  sizeRowTabel:
                                      MediaQuery.of(context).size.width / 1.1,
                                  sizeWidth:
                                      MediaQuery.of(context).size.width / 1,
                                  customContentPagination: controller
                                              .numberOfPageFinished.value <=
                                          1
                                      ? Container()
                                      : Container(
                                          width: double.infinity,
                                          padding: AppSizes.onlyPadding(
                                              bottom: AppSizes.s50),
                                          child: Column(
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                  color:
                                                      AppColors.colorBaseWhite,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          AppSizes.s4),
                                                ),
                                                child: Obx(() {
                                                  return NumberPaginator(
                                                    numberPages: controller
                                                        .numberOfPageFinished
                                                        .value,
                                                    onPageChange: (int index) {
                                                      final page = index + 1;
                                                      controller.getAntrianPasienFinished(
                                                          page: page,
                                                          name: controller
                                                              .nameQueueFinishedController
                                                              .text,
                                                          no_rme: controller
                                                              .noRmeFinishedController
                                                              .text,
                                                          nomer_antrian: controller
                                                              .noQueueFinishedController
                                                              .text);
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
                                  customContent: Container(
                                    width:
                                        MediaQuery.of(context).size.width / 1.1,
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          offset: const Offset(0, 0),
                                          blurRadius: 15,
                                          spreadRadius: 0,
                                          color: AppColors.colorNeutrals300
                                              .withAlpha(40),
                                        ),
                                      ],
                                    ),
                                    child: Row(
                                      children: [
                                        Flexible(
                                          child: SearchNewComponent(
                                            controller: controller
                                                .searchControllerFinished,
                                            keyboardType: TextInputType.name,
                                            hintText: AppConstants.LABEL_CARI,
                                            suffixIcon: const Icon(
                                              Icons.search,
                                              color:
                                                  AppColors.colorSecondary500,
                                            ),
                                            onChanged: (value) {
                                              final input = value.trim();
                                              final parts = input
                                                  .split(',')
                                                  .map((e) => e.trim())
                                                  .toList();

                                              String name = '';
                                              String nomerAntrian = '';
                                              String noRme = '';

                                              controller
                                                  .nameQueueFinishedController
                                                  .text = name;
                                              controller
                                                  .noQueueFinishedController
                                                  .text = nomerAntrian;
                                              controller.noRmeFinishedController
                                                  .text = noRme;

                                              for (var part in parts) {
                                                if (part
                                                    .toUpperCase()
                                                    .startsWith('RM-')) {
                                                  noRme = part;
                                                } else if (int.tryParse(part) !=
                                                    null) {
                                                  nomerAntrian = part;
                                                } else {
                                                  name = part;
                                                }
                                              }

                                              controller
                                                  .getAntrianPasienFinished(
                                                name:
                                                    name.isNotEmpty ? name : '',
                                                nomer_antrian:
                                                    nomerAntrian.isNotEmpty
                                                        ? nomerAntrian
                                                        : '',
                                                no_rme: noRme.isNotEmpty
                                                    ? noRme
                                                    : '',
                                              );
                                            },
                                          ),
                                        ),
                                        // AppSizes.s20.width,
                                        // LabelStatusAntrianComponent(),
                                      ],
                                    ),
                                  ),
                                  listColumns: getListQueueColumns(
                                    controller: controller,
                                    data: "FINISHED",
                                  ),
                                  listRows: getRowsQueue(
                                    context: context,
                                    controller: controller,
                                    data: controller.finishedPatients,
                                    isLoading: controller.isLoading.value,
                                    controllerApotik: controllerApotik,
                                    controllerRme: controllerRme,
                                  ),
                                ),
                              ]
                            ],
                          )
                        : Column(
                            children: [
                              ListMobileContainerComponent(
                                label: AppConstants.LABEL_DAFTAR_ANTRIAN,
                                height: 480,
                                customSearch: Container(
                                  padding: AppSizes.symmetricPadding(
                                    horizontal: AppSizes.s20,
                                  ),
                                  width:
                                      MediaQuery.of(context).size.width / 1.1,
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        offset: const Offset(0, 0),
                                        blurRadius: 15,
                                        spreadRadius: 0,
                                        color: AppColors.colorNeutrals300
                                            .withAlpha(40),
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    children: [
                                      Flexible(
                                        child: SearchNewComponent(
                                          controller:
                                              controller.searchController,
                                          keyboardType: TextInputType.name,
                                          hintText: AppConstants.LABEL_CARI,
                                          suffixIcon: const Icon(
                                            Icons.search,
                                            color: AppColors.colorSecondary500,
                                          ),
                                          onChanged: (value) {
                                            final input = value.trim();
                                            final parts = input
                                                .split(',')
                                                .map((e) => e.trim())
                                                .toList();

                                            String name = '';
                                            String nomerAntrian = '';
                                            String noRme = '';

                                            controller.nameQueueController
                                                .text = name;
                                            controller.noQueueController.text =
                                                nomerAntrian;
                                            controller.noRmeController.text =
                                                noRme;

                                            for (var part in parts) {
                                              if (part
                                                  .toUpperCase()
                                                  .startsWith('RM-')) {
                                                noRme = part;
                                              } else if (int.tryParse(part) !=
                                                  null) {
                                                nomerAntrian = part;
                                              } else {
                                                name = part;
                                              }
                                            }

                                            controller.getAntrianPasien(
                                              name: name.isNotEmpty ? name : '',
                                              nomer_antrian:
                                                  nomerAntrian.isNotEmpty
                                                      ? nomerAntrian
                                                      : '',
                                              no_rme:
                                                  noRme.isNotEmpty ? noRme : '',
                                            );
                                          },
                                        ),
                                      ),
                                      AppSizes.s20.width,
                                      LabelStatusAntrianComponent(),
                                    ],
                                  ),
                                ),
                                children: controller.isLoading.value
                                    ? Center(
                                        child: CircularProgressIndicator(),
                                      )
                                    : controller.antrianPasienList.isEmpty
                                        ? Center(
                                            child: Text('Data Tidak DiTemukan'),
                                          )
                                        : ListView.builder(
                                            itemCount: controller
                                                .antrianPasienList.length,
                                            itemBuilder:
                                                (BuildContext context, index) {
                                              var datas = controller
                                                  .antrianPasienList[index];
                                              return QueueListMobile(
                                                datas: datas,
                                                controller: controller,
                                                controllerRme: controllerRme,
                                                controllerApotik:
                                                    controllerApotik,
                                                inkwell: true,
                                              );
                                            },
                                          ),
                              ),
                              AppSizes.s20.height,
                              ListMobileContainerComponent(
                                label: 'Daftar Antrian Selesai',
                                height: 480,
                                customSearch: Container(
                                  padding: AppSizes.symmetricPadding(
                                    horizontal: AppSizes.s20,
                                  ),
                                  width:
                                      MediaQuery.of(context).size.width / 1.1,
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        offset: const Offset(0, 0),
                                        blurRadius: 15,
                                        spreadRadius: 0,
                                        color: AppColors.colorNeutrals300
                                            .withAlpha(40),
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    children: [
                                      Flexible(
                                        child: SearchNewComponent(
                                          controller: controller
                                              .searchControllerFinished,
                                          keyboardType: TextInputType.name,
                                          hintText: AppConstants.LABEL_CARI,
                                          suffixIcon: const Icon(
                                            Icons.search,
                                            color: AppColors.colorSecondary500,
                                          ),
                                          onChanged: (value) {
                                            final input = value.trim();
                                            final parts = input
                                                .split(',')
                                                .map((e) => e.trim())
                                                .toList();

                                            String name = '';
                                            String nomerAntrian = '';
                                            String noRme = '';

                                            controller
                                                .nameQueueFinishedController
                                                .text = name;
                                            controller.noQueueFinishedController
                                                .text = nomerAntrian;
                                            controller.noRmeFinishedController
                                                .text = noRme;

                                            for (var part in parts) {
                                              if (part
                                                  .toUpperCase()
                                                  .startsWith('RM-')) {
                                                noRme = part;
                                              } else if (int.tryParse(part) !=
                                                  null) {
                                                nomerAntrian = part;
                                              } else {
                                                name = part;
                                              }
                                            }

                                            controller.getAntrianPasienFinished(
                                              name: name.isNotEmpty ? name : '',
                                              nomer_antrian:
                                                  nomerAntrian.isNotEmpty
                                                      ? nomerAntrian
                                                      : '',
                                              no_rme:
                                                  noRme.isNotEmpty ? noRme : '',
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                children: controller.isLoadingFinished.value
                                    ? Center(
                                        child: CircularProgressIndicator(),
                                      )
                                    : controller.finishedPatients.isEmpty
                                        ? Center(
                                            child: Text('Data Tidak DiTemukan'),
                                          )
                                        : ListView.builder(
                                            itemCount: controller
                                                .finishedPatients.length,
                                            itemBuilder:
                                                (BuildContext context, index) {
                                              var datas = controller
                                                  .finishedPatients[index];
                                              return QueueListMobile(
                                                datas: datas,
                                                controller: controller,
                                                controllerRme: controllerRme,
                                                controllerApotik:
                                                    controllerApotik,
                                              );
                                            },
                                          ),
                              ),
                            ],
                          ),
                  ],
                ).paddingSymmetric(
                  vertical: AppSizes.s41,
                  horizontal: AppSizes.s28,
                );
              },
            ),
          );
        });
  }
}
