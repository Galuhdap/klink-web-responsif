import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:klinik_web_responsif/core/components/custom_tabel_component.dart';
import 'package:klinik_web_responsif/core/components/label_status_antrian_component.dart';
import 'package:klinik_web_responsif/core/components/list_mobile_component.dart';
import 'package:klinik_web_responsif/core/components/search_new_component.dart';
import 'package:klinik_web_responsif/core/config/responsive.dart';
import 'package:klinik_web_responsif/core/resources/constans/app_constants.dart';
import 'package:klinik_web_responsif/core/styles/app_colors.dart';
import 'package:klinik_web_responsif/core/styles/app_sizes.dart';
import 'package:klinik_web_responsif/core/utils/extensions/date_ext.dart';
import 'package:klinik_web_responsif/core/utils/extensions/sized_box_ext.dart';
import 'package:klinik_web_responsif/presentations/apotik/controller/apotik_controller.dart';
import 'package:klinik_web_responsif/presentations/apotik/screen/tabel/list_5_medicine_favorit_tabel.dart';
import 'package:klinik_web_responsif/presentations/apotik/screen/tabel/list_expired_30_days_table.dart';
import 'package:klinik_web_responsif/presentations/home/controllers/home_controller.dart';
import 'package:klinik_web_responsif/presentations/home/screen/tabel/list_queue_tabel.dart';
import 'package:klinik_web_responsif/presentations/home/widgets/card_apotik_dashboard_widget.dart';
import 'package:klinik_web_responsif/presentations/menu_dashboard/widget/build_app_bar.dart';
import 'package:klinik_web_responsif/presentations/patient/controller/rekam_medis_controller.dart';
import 'package:number_paginator/number_paginator.dart';

class ApotikDashboardScreen extends StatelessWidget {
  const ApotikDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controllerHome = Get.put(HomeController());
    var controllerRme = Get.put(RekamMedisController());
    return GetBuilder<ApotikController>(
      init: ApotikController(),
      builder: (controller) {
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
            body: Obx(() {
              return ListView(children: [
                CardApotikDashbordWidget(
                  controller: controller,
                ),
                AppSizes.s30.height,
                Responsive.isDesktop(context)
                    ? Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomTabelComponent(
                                sizeWidth:
                                    MediaQuery.of(context).size.width / 1.6,
                                label: 'Obat Expired Dalam 30 Hari',
                                sizeRowTabel:
                                    MediaQuery.of(context).size.width / 1.6,
                                listColumns:
                                    getListMedicineExpired30DaysColumns(),
                                listRows: getListMedicineExpired30Days(
                                  data: controller.medicineExpiredList,
                                  isLoading: controller
                                      .isLoadingHasExpiredMedicine.value,
                                ),
                              ),
                              CustomTabelComponent(
                                label: '5 Obat Paling Laris',
                                sizeWidth:
                                    MediaQuery.of(context).size.width / 3.8,
                                sizeRowTabel:
                                    MediaQuery.of(context).size.width / 3.8,
                                listColumns: getListMedicineFiveFavoritColumns(
                                  data: controller.topFiveMedicineList,
                                ),
                                listRows: getListMedicineFiveFavoritDays(
                                    data: controller.topFiveMedicineList,
                                    isLoadingExpiredMedicine: controller
                                        .isLoadingExpiredMedicine.value),
                              ),
                            ],
                          ),
                          AppSizes.s20.height,
                          Column(
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
                                                  numberPages: controllerHome
                                                      .numberOfPage.value,
                                                  onPageChange: (int index) {
                                                    final page = index + 1;
                                                    controllerHome.getAntrianPasien(
                                                        page: page,
                                                        name: controllerHome
                                                            .nameQueueController
                                                            .text,
                                                        no_rme: controllerHome
                                                            .noRmeController
                                                            .text,
                                                        nomer_antrian:
                                                            controllerHome
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

                                            controllerHome.nameQueueController
                                                .text = name;
                                            controllerHome.noQueueController
                                                .text = nomerAntrian;
                                            controllerHome
                                                .noRmeController.text = noRme;

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

                                            controllerHome.getAntrianPasien(
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
                                  controller: controllerHome,
                                ),
                                listRows: getRowsQueue(
                                  context: context,
                                  controller: controllerHome,
                                  data: controllerHome.antrianPasienList,
                                  isLoading: controllerHome.isLoading.value,
                                  controllerApotik: controller,
                                  controllerRme: controllerRme,
                                ),
                              ),
                              if (controller.role.value == 'ADMIN' ||
                                  controller.role.value == 'APOTEKER') ...[
                                AppSizes.s50.height,
                                CustomTabelComponent(
                                  label: "Daftar Antrian Selesai",
                                  sizeRowTabel:
                                      MediaQuery.of(context).size.width / 1.1,
                                  sizeWidth:
                                      MediaQuery.of(context).size.width / 1,
                                  customContentPagination: controllerHome
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
                                                    numberPages: controllerHome
                                                        .numberOfPageFinished
                                                        .value,
                                                    onPageChange: (int index) {
                                                      final page = index + 1;
                                                      controllerHome.getAntrianPasienFinished(
                                                          page: page,
                                                          name: controllerHome
                                                              .nameQueueFinishedController
                                                              .text,
                                                          no_rme: controllerHome
                                                              .noRmeFinishedController
                                                              .text,
                                                          nomer_antrian:
                                                              controllerHome
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
                                            controller: controllerHome
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

                                              controllerHome
                                                  .nameQueueFinishedController
                                                  .text = name;
                                              controllerHome
                                                  .noQueueFinishedController
                                                  .text = nomerAntrian;
                                              controllerHome
                                                  .noRmeFinishedController
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

                                              controllerHome
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
                                    controller: controllerHome,
                                    data: "FINISHED",
                                  ),
                                  listRows: getRowsQueue(
                                    context: context,
                                    controller: controllerHome,
                                    data: controllerHome.finishedPatients,
                                    isLoading: controllerHome.isLoading.value,
                                    controllerApotik: controller,
                                    controllerRme: controllerRme,
                                  ),
                                ),
                              ]
                            ],
                          )
                        ],
                      )
                    : Column(
                        spacing: AppSizes.s30,
                        children: [
                          ListMobileContainerComponent(
                            label: '5 Obat Terlaris',
                            children: controller.isLoadingExpiredMedicine.value
                                ? Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : controller.topFiveMedicineList.isEmpty
                                    ? Center(
                                        child: Text('Data Masih Kosong'),
                                      )
                                    : ListView.builder(
                                        itemCount: controller
                                            .topFiveMedicineList.length,
                                        itemBuilder:
                                            (BuildContext context, index) {
                                          var datas = controller
                                              .topFiveMedicineList[index];
                                          return Container(
                                            margin: AppSizes.onlyPadding(
                                              top: AppSizes.s7,
                                              bottom: AppSizes.s7,
                                              left: AppSizes.s15,
                                              right: AppSizes.s15,
                                            ),
                                            padding: AppSizes.symmetricPadding(
                                              vertical: 15,
                                              horizontal: 15,
                                            ),
                                            decoration: BoxDecoration(
                                              color: AppColors.colorBaseWhite,
                                              borderRadius:
                                                  BorderRadius.circular(
                                                AppSizes.s5,
                                              ),
                                              boxShadow: [
                                                BoxShadow(
                                                  color:
                                                      Colors.grey.withAlpha(40),
                                                  spreadRadius: 0,
                                                  blurRadius: 24,
                                                  offset: Offset(0, 0),
                                                ),
                                              ],
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      datas.nameMedicine,
                                                      style: Get
                                                          .textTheme.labelLarge!
                                                          .copyWith(
                                                              fontSize:
                                                                  AppSizes.s15,
                                                              color: AppColors
                                                                  .colorBaseBlack),
                                                    ),
                                                  ],
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'Jumlah ${datas.totalTerjual}',
                                                      style: Get
                                                          .textTheme.labelLarge!
                                                          .copyWith(
                                                              fontSize:
                                                                  AppSizes.s12,
                                                              color: AppColors
                                                                  .colorBaseBlack),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                          ),
                          ListMobileContainerComponent(
                            label: 'Obat Expired Dalam 30 Hari',
                            children: controller.isLoadingExpiredMedicine.value
                                ? Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : ListView.builder(
                                    itemCount:
                                        controller.medicineExpiredList.length,
                                    itemBuilder: (BuildContext context, index) {
                                      var datas =
                                          controller.medicineExpiredList[index];
                                      return Container(
                                        margin: AppSizes.onlyPadding(
                                          top: AppSizes.s7,
                                          bottom: AppSizes.s7,
                                          left: AppSizes.s15,
                                          right: AppSizes.s15,
                                        ),
                                        padding: AppSizes.symmetricPadding(
                                          vertical: 15,
                                          horizontal: 15,
                                        ),
                                        decoration: BoxDecoration(
                                          color: AppColors.colorBaseWhite,
                                          borderRadius: BorderRadius.circular(
                                            AppSizes.s5,
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  datas.nameMedicine,
                                                  style: Get
                                                      .textTheme.labelLarge!
                                                      .copyWith(
                                                          fontSize:
                                                              AppSizes.s15,
                                                          color: AppColors
                                                              .colorBaseBlack),
                                                ),
                                                Text(
                                                  'Stock ${datas.stock}',
                                                  style: Get
                                                      .textTheme.labelLarge!
                                                      .copyWith(
                                                          fontSize:
                                                              AppSizes.s12,
                                                          color: AppColors
                                                              .colorBaseBlack),
                                                ),
                                                Text(
                                                  datas.noBuy,
                                                  style: Get
                                                      .textTheme.labelLarge!
                                                      .copyWith(
                                                          fontSize:
                                                              AppSizes.s12,
                                                          color: AppColors
                                                              .colorBaseBlack),
                                                ),
                                              ],
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Expired ${datas.tanggalExpired.toDateddmmmyyyyFormattedString()}',
                                                  style: Get
                                                      .textTheme.labelLarge!
                                                      .copyWith(
                                                          fontSize:
                                                              AppSizes.s12,
                                                          color: AppColors
                                                              .colorBaseBlack),
                                                ),
                                                Text(
                                                  'Sisa ${datas.sisaHari} Hari',
                                                  style: Get
                                                      .textTheme.labelLarge!
                                                      .copyWith(
                                                          fontSize:
                                                              AppSizes.s12,
                                                          color: AppColors
                                                              .colorBaseBlack),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                          ),
                        ],
                      )
              ]).paddingSymmetric(
                vertical: AppSizes.s41,
                horizontal: AppSizes.s28,
              );
            }));
      },
    );
  }
}
