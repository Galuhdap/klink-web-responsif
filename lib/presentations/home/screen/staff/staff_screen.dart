import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:klinik_web_responsif/core/assets/assets.gen.dart';
import 'package:klinik_web_responsif/core/components/button_component.dart';
import 'package:klinik_web_responsif/core/components/card_dashboard_component.dart';
import 'package:klinik_web_responsif/core/components/input_component.dart';
import 'package:klinik_web_responsif/core/components/input_data_component.dart';
import 'package:klinik_web_responsif/core/components/label_status_antrian_component.dart';
import 'package:klinik_web_responsif/core/components/modal/show_modal_tanda_tanya_component.dart';
import 'package:klinik_web_responsif/core/components/search_new_component.dart';
import 'package:klinik_web_responsif/core/components/show_center_dialog.dart';
import 'package:klinik_web_responsif/core/components/show_modal_right_component.dart';
import 'package:klinik_web_responsif/core/components/status_antrian_component.dart';
import 'package:klinik_web_responsif/core/config/responsive.dart';
import 'package:klinik_web_responsif/core/resources/constans/app_constants.dart';
import 'package:klinik_web_responsif/core/styles/app_colors.dart';
import 'package:klinik_web_responsif/core/styles/app_sizes.dart';
import 'package:klinik_web_responsif/core/utils/extensions/date_ext.dart';
import 'package:klinik_web_responsif/core/utils/extensions/int_ext.dart';
import 'package:klinik_web_responsif/core/utils/extensions/sized_box_ext.dart';
import 'package:klinik_web_responsif/presentations/apotik/controller/apotik_controller.dart';
import 'package:klinik_web_responsif/presentations/apotik/widget/succes_payment_widget.dart';
import 'package:klinik_web_responsif/presentations/home/controllers/home_controller.dart';
import 'package:klinik_web_responsif/presentations/menu_dashboard/widget/build_app_bar.dart';
import 'package:klinik_web_responsif/presentations/patient/controller/rekam_medis_controller.dart';
import 'package:klinik_web_responsif/presentations/patient/screen/rekam_medis_screen.dart';
import 'package:klinik_web_responsif/services/apotik/model/request/post_transaction_request.dart';
import 'package:lottie/lottie.dart';
import 'package:number_paginator/number_paginator.dart';

class StaffScreen extends StatelessWidget {
  const StaffScreen({super.key});

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
                searchChanged: (_) {
                  // if (searchController.text.isNotEmpty &&
                  //     searchController.text.length > 1) {
                  //   context.read<DataPatientsBloc>().add(
                  //       DataPatientsEvent.getPatientByNIK(searchController.text));
                  // } else {
                  //   context
                  //       .read<DataPatientsBloc>()
                  //       .add(const DataPatientsEvent.getPatients());
                  // }
                },
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
                    Container(
                      width: double.infinity,
                      padding: AppSizes.symmetricPadding(
                          vertical: AppSizes.s5, horizontal: AppSizes.s41),
                      decoration: BoxDecoration(
                        color: AppColors.colorBaseWhite,
                        borderRadius: BorderRadius.circular(AppSizes.s4),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppSizes.s20.height,
                          Text(
                            AppConstants.LABEL_DAFTAR_ANTRIAN,
                            style: Get.textTheme.labelMedium!.copyWith(
                                fontSize: AppSizes.s20,
                                color: AppColors.colorBaseBlack,
                                fontWeight: FontWeight.bold),
                          ),
                          AppSizes.s10.height,
                          if (controller.role.value == "ADMIN") ...[
                            if (Responsive.isDesktop(context)) ...[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  // Flexible(
                                  //   child: Row(
                                  //     children: [
                                  //       Flexible(
                                  //         child: Text(
                                  //           'Status Antrian : ',
                                  //           style: Get.textTheme.labelMedium!
                                  //               .copyWith(
                                  //                   fontSize: AppSizes.s14,
                                  //                   color: AppColors
                                  //                       .colorBaseBlack,
                                  //                   fontWeight:
                                  //                       FontWeight.bold),
                                  //         ),
                                  //       ),
                                  //       Flexible(
                                  //         child: Obx(() {
                                  //           return Container(
                                  //             padding:
                                  //                 AppSizes.symmetricPadding(
                                  //                     vertical: AppSizes.s5,
                                  //                     horizontal: AppSizes.s10),
                                  //             decoration: BoxDecoration(
                                  //               borderRadius:
                                  //                   BorderRadius.circular(20),
                                  //               color: controller
                                  //                       .queueActive.value
                                  //                   ? AppColors.colorBaseSuccess
                                  //                   : AppColors.colorBaseError,
                                  //             ),
                                  //             child: Text(
                                  //               controller.queueActive.value
                                  //                   ? 'Aktif'
                                  //                   : 'Tidak Aktif',
                                  //               style: Get
                                  //                   .textTheme.labelMedium!
                                  //                   .copyWith(
                                  //                       fontSize: AppSizes.s12,
                                  //                       color: AppColors
                                  //                           .colorBackground,
                                  //                       fontWeight:
                                  //                           FontWeight.bold),
                                  //             ),
                                  //           );
                                  //         }),
                                  //       ),
                                  //     ],
                                  //   ),
                                  // ),
                                  Flexible(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        // Flexible(
                                        //   child: Obx(() {
                                        //     return Container(
                                        //       padding:
                                        //           AppSizes.symmetricPadding(
                                        //               vertical: AppSizes.s5,
                                        //               horizontal: AppSizes.s10),
                                        //       decoration: BoxDecoration(
                                        //         borderRadius:
                                        //             BorderRadius.circular(20),
                                        //         color: controller
                                        //                     .connectionStatus
                                        //                     .value ==
                                        //                 'Terhubung'
                                        //             ? AppColors.colorBaseSuccess
                                        //             : AppColors.colorBaseError,
                                        //       ),
                                        //       child: Text(
                                        //         controller
                                        //             .connectionStatus.value,
                                        //         style: Get
                                        //             .textTheme.labelMedium!
                                        //             .copyWith(
                                        //                 fontSize: AppSizes.s12,
                                        //                 color: AppColors
                                        //                     .colorBackground,
                                        //                 fontWeight:
                                        //                     FontWeight.bold),
                                        //       ),
                                        //     );
                                        //   }),
                                        // ),
                                        // Flexible(
                                        //   child: Button.filled(
                                        //     onPressed: () {
                                        //       controller.startQueue();
                                        //     },
                                        //     label: 'Mulai',
                                        //     color: AppColors.colorSuccess400,
                                        //   ),
                                        // ),
                                        // Flexible(
                                        //   child: Button.filled(
                                        //     onPressed: () {
                                        //       controller.stopQueue();
                                        //     },
                                        //     label: 'Hentikan',
                                        //     color: AppColors.colorBaseError,
                                        //   ),
                                        // ),
                                        // Flexible(
                                        //   child: Button.filled(
                                        //     onPressed: () {
                                        //       controller.resumeQueue();
                                        //     },
                                        //     label: 'Lanjutkan',
                                        //     color: AppColors.colorBasePrimary,
                                        //   ),
                                        // ),
                                        InkWell(
                                          onTap: () {
                                            controller.clearQueue();
                                          },
                                          child: Container(
                                            width: 150,
                                            height: 40,
                                            decoration: BoxDecoration(
                                              color: AppColors.colorBaseError,
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      AppSizes.s10),
                                            ),
                                            child: Center(
                                              child: Text(
                                                'Hapus Semua Antrian',
                                                style: TextStyle(
                                                  color:
                                                      AppColors.colorBackground,
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        // Flexible(
                                        //   child: Button.filled(
                                        //     onPressed: () {
                                        //       controller.clearQueue();
                                        //     },
                                        //     label: 'Hapus',
                                        //     color: AppColors.colorBaseError,
                                        //   ),
                                        // ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ],
                            if (Responsive.isMobile(context)) ...[
                              // Row(
                              //   mainAxisAlignment:
                              //       MainAxisAlignment.spaceBetween,
                              //   children: [
                              //     Flexible(
                              //       child: Row(
                              //         children: [
                              //           Flexible(
                              //             child: Text(
                              //               'Status Antrian : ',
                              //               style: Get.textTheme.labelMedium!
                              //                   .copyWith(
                              //                       fontSize: AppSizes.s12,
                              //                       color: AppColors
                              //                           .colorBaseBlack,
                              //                       fontWeight:
                              //                           FontWeight.bold),
                              //             ),
                              //           ),
                              //           Flexible(
                              //             child: Obx(() {
                              //               return Container(
                              //                 padding:
                              //                     AppSizes.symmetricPadding(
                              //                         vertical: AppSizes.s5,
                              //                         horizontal: AppSizes.s10),
                              //                 decoration: BoxDecoration(
                              //                   borderRadius:
                              //                       BorderRadius.circular(20),
                              //                   color: controller
                              //                           .queueActive.value
                              //                       ? AppColors.colorBaseSuccess
                              //                       : AppColors.colorBaseError,
                              //                 ),
                              //                 child: Text(
                              //                   controller.queueActive.value
                              //                       ? 'Aktif'
                              //                       : 'Tidak Aktif',
                              //                   style: Get
                              //                       .textTheme.labelMedium!
                              //                       .copyWith(
                              //                           fontSize: AppSizes.s12,
                              //                           color: AppColors
                              //                               .colorBackground,
                              //                           fontWeight:
                              //                               FontWeight.bold),
                              //                 ),
                              //               );
                              //             }),
                              //           ),
                              //         ],
                              //       ),
                              //     ),
                              //     Flexible(
                              //       child: Obx(() {
                              //         return Container(
                              //           padding: AppSizes.symmetricPadding(
                              //               vertical: AppSizes.s5,
                              //               horizontal: AppSizes.s10),
                              //           decoration: BoxDecoration(
                              //             borderRadius:
                              //                 BorderRadius.circular(20),
                              //             color: controller
                              //                         .connectionStatus.value ==
                              //                     'Terhubung'
                              //                 ? AppColors.colorBaseSuccess
                              //                 : AppColors.colorBaseError,
                              //           ),
                              //           child: Text(
                              //             controller.connectionStatus.value,
                              //             style: Get.textTheme.labelMedium!
                              //                 .copyWith(
                              //                     fontSize: AppSizes.s12,
                              //                     color:
                              //                         AppColors.colorBackground,
                              //                     fontWeight: FontWeight.bold),
                              //           ),
                              //         );
                              //       }),
                              //     ),
                              //   ],
                              // ),
                              // AppSizes.s10.height,
                              // Row(
                              //   spacing: 10,
                              //   children: [
                              //     Flexible(
                              //       child: Button.filled(
                              //         onPressed: () {
                              //           controller.startQueue();
                              //         },
                              //         label: 'Mulai',
                              //         color: AppColors.colorSuccess400,
                              //       ),
                              //     ),
                              //     Flexible(
                              //       child: Button.filled(
                              //         onPressed: () {
                              //           controller.stopQueue();
                              //         },
                              //         label: 'Hentikan',
                              //         color: AppColors.colorBaseError,
                              //       ),
                              //     ),
                              //   ],
                              // ),
                              // AppSizes.s10.height,
                              // Row(
                              //   spacing: 10,
                              //   children: [
                              //     Flexible(
                              //       child: Button.filled(
                              //         onPressed: () {
                              //           controller.resumeQueue();
                              //         },
                              //         label: 'Lanjutkan',
                              //         color: AppColors.colorBasePrimary,
                              //       ),
                              //     ),
                              //     Flexible(
                              //       child: Button.filled(
                              //         onPressed: () {
                              //           controller.clearQueue();
                              //         },
                              //         label: 'Hapus',
                              //         color: AppColors.colorBaseError,
                              //       ),
                              //     ),
                              //   ],
                              // )
                              Button.filled(
                                onPressed: () {
                                  controller.clearQueue();
                                },
                                label: 'Hapus Semua Antrian',
                                color: AppColors.colorBaseError,
                              ),
                            ],
                          ],
                          AppSizes.s10.height,
                          Row(
                            children: [
                              Flexible(
                                child: Container(
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
                                      final parts = input
                                          .split(',')
                                          .map((e) => e.trim())
                                          .toList();

                                      String name = '';
                                      String nomerAntrian = '';
                                      String noRme = '';

                                      for (var part in parts) {
                                        if (part
                                            .toUpperCase()
                                            .startsWith('RM-')) {
                                          noRme = part;
                                        } else if (int.tryParse(part) != null) {
                                          nomerAntrian = part;
                                        } else {
                                          name = part;
                                        }
                                      }

                                      controller.getAntrianPasien(
                                        name: name.isNotEmpty ? name : '',
                                        nomer_antrian: nomerAntrian.isNotEmpty
                                            ? nomerAntrian
                                            : '',
                                        no_rme: noRme.isNotEmpty ? noRme : '',
                                      );
                                    },
                                  ),
                                ),
                              ),
                              if (Responsive.isDesktop(context)) ...[
                                AppSizes.s20.width,
                                LabelStatusAntrianComponent()
                              ]
                            ],
                          ),
                          AppSizes.s10.height,
                          Responsive.isMobile(context)
                              ? LabelStatusAntrianComponent()
                              : Container()
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        height: 400,
                        color: AppColors.colorBaseWhite,
                        child: controller.isLoading.value
                            ? Center(
                                child: CircularProgressIndicator(),
                              )
                            : controller.antrianPasienList.isEmpty
                                ? Center(
                                    child: Text('Antrian Pasien Kosong'),
                                  )
                                : ListView(
                                    padding: AppSizes.symmetricPadding(
                                      horizontal: AppSizes.s30,
                                    ),
                                    children: [
                                      SingleChildScrollView(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 0.0),
                                        scrollDirection: Axis.horizontal,
                                        child: Center(
                                          child: Theme(
                                            data: Theme.of(context).copyWith(
                                                dividerColor:
                                                    Colors.transparent),
                                            child: DataTable(
                                              dividerThickness: 0.0,
                                              dataRowMinHeight: 20.0,
                                              dataRowMaxHeight: 50.0,
                                              columns: [
                                                DataColumn(
                                                  label: Text(
                                                    AppConstants
                                                        .LABEL_NO_ANTRIAN,
                                                    style: Get
                                                        .textTheme.labelLarge!
                                                        .copyWith(
                                                            fontSize:
                                                                AppSizes.s14,
                                                            color: AppColors
                                                                .colorBaseBlack),
                                                  ),
                                                ),
                                                DataColumn(
                                                  label: Padding(
                                                    padding: EdgeInsets.only(
                                                        left: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.07,
                                                        right: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.201),
                                                    child: Text(
                                                      AppConstants
                                                          .LABEL_NAMA_PASIEN,
                                                      style: Get
                                                          .textTheme.labelLarge!
                                                          .copyWith(
                                                              fontSize:
                                                                  AppSizes.s14,
                                                              color: AppColors
                                                                  .colorBaseBlack),
                                                    ),
                                                  ),
                                                ),
                                                DataColumn(
                                                    label: Center(
                                                  child: Text(
                                                    AppConstants.LABEL_STATUS,
                                                    style: Get
                                                        .textTheme.labelLarge!
                                                        .copyWith(
                                                            fontSize:
                                                                AppSizes.s14,
                                                            color: AppColors
                                                                .colorBaseBlack),
                                                  ),
                                                ).paddingOnly(left: 30)),
                                                // DataColumn(
                                                //   label: Padding(
                                                //     padding: EdgeInsets.only(
                                                //       left:
                                                //           MediaQuery.of(context)
                                                //                   .size
                                                //                   .width *
                                                //               0.07,
                                                //       right:
                                                //           MediaQuery.of(context)
                                                //                   .size
                                                //                   .width *
                                                //               0.07,
                                                //     ),
                                                //     child: Text(
                                                //       AppConstants
                                                //           .LABEL_WAKTU_TUNGGU,
                                                //       style: Get
                                                //           .textTheme.labelLarge!
                                                //           .copyWith(
                                                //               fontSize:
                                                //                   AppSizes.s14,
                                                //               color: AppColors
                                                //                   .colorBaseBlack),
                                                //     ),
                                                //   ),
                                                // ),
                                                DataColumn(
                                                  label: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 300),
                                                    child: Text(
                                                      AppConstants.LABEL_ACTION,
                                                      style: Get
                                                          .textTheme.labelLarge!
                                                          .copyWith(
                                                              fontSize:
                                                                  AppSizes.s14,
                                                              color: AppColors
                                                                  .colorBaseBlack),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                              rows: controller.isLoading.value
                                                  ? [
                                                      const DataRow(
                                                        cells: [
                                                          DataCell.empty,
                                                          DataCell.empty,
                                                          DataCell(
                                                            Center(
                                                              child:
                                                                  CircularProgressIndicator(),
                                                            ),
                                                          ),
                                                          DataCell.empty,
                                                          DataCell.empty,
                                                        ],
                                                      )
                                                    ]
                                                  : controller.antrianPasienList
                                                          .isEmpty
                                                      ? [
                                                          const DataRow(
                                                            cells: [
                                                              DataCell.empty,
                                                              DataCell.empty,
                                                              DataCell(Row(
                                                                spacing: 4,
                                                                children: [
                                                                  Icon(Icons
                                                                      .highlight_off),
                                                                  //SpaceWidth(4.0),
                                                                  Text(
                                                                      'Data tidak ditemukan..'),
                                                                ],
                                                              )),
                                                              DataCell.empty,
                                                              DataCell.empty,
                                                            ],
                                                          ),
                                                        ]
                                                      : controller
                                                          .antrianPasienList
                                                          .map(
                                                            (patient) =>
                                                                DataRow(
                                                              cells: [
                                                                DataCell(
                                                                  Center(
                                                                    child: Text(
                                                                      '0${patient.nomerAntrian}',
                                                                      style: const TextStyle(
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    ),
                                                                  ),
                                                                ),
                                                                DataCell(
                                                                  Padding(
                                                                    padding:
                                                                        EdgeInsets
                                                                            .only(
                                                                      left: MediaQuery.of(context)
                                                                              .size
                                                                              .width *
                                                                          0.07,
                                                                    ),
                                                                    child:
                                                                        Column(
                                                                      spacing:
                                                                          5,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Text(
                                                                          patient
                                                                              .pasien
                                                                              .name,
                                                                          style: Get
                                                                              .textTheme
                                                                              .labelLarge!
                                                                              .copyWith(
                                                                            fontSize:
                                                                                AppSizes.s16,
                                                                          ),
                                                                        ),
                                                                        Text(
                                                                          patient
                                                                              .pasien
                                                                              .noRekamMedis,
                                                                          style: Get
                                                                              .textTheme
                                                                              .bodySmall!
                                                                              .copyWith(
                                                                            fontSize:
                                                                                AppSizes.s10,
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                                DataCell(
                                                                  StatusAntrianComponent(
                                                                    status: patient
                                                                        .status,
                                                                  ),
                                                                ),
                                                                // DataCell(
                                                                //   Center(
                                                                //     child:
                                                                //         Padding(
                                                                //       padding:
                                                                //           EdgeInsets
                                                                //               .only(
                                                                //         left: MediaQuery.of(context).size.width *
                                                                //             0.07,
                                                                //         right: MediaQuery.of(context).size.width *
                                                                //             0.07,
                                                                //       ),
                                                                //       child: patient.status ==
                                                                //               'WAITING'
                                                                //           ? Text(
                                                                //               patient.waitingTimeFormatted,
                                                                //               style: Get.textTheme.labelLarge!.copyWith(
                                                                //                 fontSize: AppSizes.s16,
                                                                //               ),
                                                                //             )
                                                                //           : Text(
                                                                //               '-',
                                                                //               style: Get.textTheme.labelLarge!.copyWith(
                                                                //                 fontSize: AppSizes.s16,
                                                                //               ),
                                                                //             ),
                                                                //     ),
                                                                //   ),
                                                                // ),
                                                                // patien.status == 'FINISHED' ?
                                                                controller.role
                                                                            .value ==
                                                                        "APOTEKER"
                                                                    ? patient.status ==
                                                                            'TAKE_MEDICINE'
                                                                        ? DataCell(
                                                                            Padding(
                                                                              padding: const EdgeInsets.only(left: 300),
                                                                              child: Center(
                                                                                child: IconButton(
                                                                                  onPressed: Responsive.isDesktop(context)
                                                                                      ? () async {
                                                                                          await controllerApotik.getTransactionPasienIdRme(id: patient.idPasien);
                                                                                          showRightModal(
                                                                                            context,
                                                                                            controllerApotik.isLoadingPasienIdRme.value
                                                                                                ? Center(
                                                                                                    child: CircularProgressIndicator(),
                                                                                                  )
                                                                                                : Row(
                                                                                                    children: [
                                                                                                      Flexible(
                                                                                                        child: Column(
                                                                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                          children: [
                                                                                                            Row(
                                                                                                              children: [
                                                                                                                IconButton(
                                                                                                                  onPressed: () {
                                                                                                                    Get.back();
                                                                                                                  },
                                                                                                                  icon: const Icon(
                                                                                                                    Icons.arrow_back,
                                                                                                                    size: 24,
                                                                                                                    color: AppColors.colorBaseBlack,
                                                                                                                  ),
                                                                                                                ),
                                                                                                                Text(
                                                                                                                  'Transaksi',
                                                                                                                  style: Get.textTheme.labelMedium!.copyWith(fontWeight: FontWeight.bold, fontSize: AppSizes.s24),
                                                                                                                ),
                                                                                                              ],
                                                                                                            ),
                                                                                                            Divider(),
                                                                                                            AppSizes.s15.height,
                                                                                                            InputDataComponent(
                                                                                                              label: 'No Rekam Medis',
                                                                                                              hintText: patient.pasien.noRekamMedis,
                                                                                                              controller: TextEditingController(),
                                                                                                              readOnly: true,
                                                                                                            ),
                                                                                                            InputDataComponent(
                                                                                                              label: 'Nama Pasien',
                                                                                                              hintText: patient.pasien.name,
                                                                                                              controller: TextEditingController(),
                                                                                                              readOnly: true,
                                                                                                            ),
                                                                                                            InputDataComponent(
                                                                                                              label: 'Alamat',
                                                                                                              hintText: patient.pasien.alamat,
                                                                                                              controller: TextEditingController(),
                                                                                                              readOnly: true,
                                                                                                            ),
                                                                                                            InputDataComponent(
                                                                                                              label: 'Keluhan',
                                                                                                              hintText: controllerApotik.dataPasienIdRme.value!.keluhan,
                                                                                                              controller: TextEditingController(),
                                                                                                              readOnly: true,
                                                                                                            ),
                                                                                                            AppSizes.s20.height,
                                                                                                            Column(
                                                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                              children: [
                                                                                                                Text(
                                                                                                                  AppConstants.LABEL_OBAT,
                                                                                                                  style: Get.textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w700, fontSize: AppSizes.s14, color: AppColors.colorBaseBlack),
                                                                                                                ),
                                                                                                                SizedBox(
                                                                                                                  width: double.infinity,
                                                                                                                  height: AppSizes.setResponsiveHeight(context) * 0.23,
                                                                                                                  child: ListView.builder(
                                                                                                                    shrinkWrap: true,
                                                                                                                    itemCount: controllerApotik.dataPasienIdRme.value!.detailObatRekamMedis.length,
                                                                                                                    itemBuilder: (context, index) {
                                                                                                                      var obat = controllerApotik.dataPasienIdRme.value!.detailObatRekamMedis[index];
                                                                                                                      return Flexible(
                                                                                                                        child: Container(
                                                                                                                          margin: AppSizes.symmetricPadding(vertical: AppSizes.s5),
                                                                                                                          child: Row(
                                                                                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                                                            children: [
                                                                                                                              Column(
                                                                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                                                children: [
                                                                                                                                  Text(
                                                                                                                                    obat.obat.namaObat,
                                                                                                                                    style: Get.textTheme.bodyMedium!.copyWith(
                                                                                                                                      fontSize: AppSizes.s15,
                                                                                                                                      color: AppColors.colorBaseBlack,
                                                                                                                                    ),
                                                                                                                                  ),
                                                                                                                                ],
                                                                                                                              ),
                                                                                                                              Container(
                                                                                                                                width: 60,
                                                                                                                                height: 50,
                                                                                                                                child: CustomTextField(
                                                                                                                                  hintText: obat.qty.toString(),
                                                                                                                                  controller: TextEditingController(),
                                                                                                                                  readOnly: true,
                                                                                                                                  keyboardType: TextInputType.number,
                                                                                                                                  //textInputType: TextInputType.name,
                                                                                                                                  hintStyle: Get.textTheme.titleMedium!.copyWith(color: AppColors.colorSecondary600, fontSize: AppSizes.s10),
                                                                                                                                  onChanged: (value) {},
                                                                                                                                ),
                                                                                                                              ),
                                                                                                                            ],
                                                                                                                          ),
                                                                                                                        ),
                                                                                                                      );
                                                                                                                    },
                                                                                                                  ),
                                                                                                                ),
                                                                                                              ],
                                                                                                            ),
                                                                                                            AppSizes.s20.height,
                                                                                                          ],
                                                                                                        ),
                                                                                                      ),
                                                                                                      AppSizes.s46.width,
                                                                                                      Flexible(
                                                                                                        child: Column(
                                                                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                          children: [
                                                                                                            70.height,
                                                                                                            InputDataComponent(
                                                                                                              maxLines: 10,
                                                                                                              label: AppConstants.LABEL_TERAPI_TINDAKAN,
                                                                                                              hintText: controllerApotik.dataPasienIdRme.value!.terapiTindakan,
                                                                                                              controller: TextEditingController(),
                                                                                                              readOnly: true,
                                                                                                              textInputType: TextInputType.multiline,
                                                                                                            ),
                                                                                                            AppSizes.s10.height,
                                                                                                            Text(
                                                                                                              'Metode Pembayaran',
                                                                                                              style: Get.textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w700, fontSize: AppSizes.s14, color: AppColors.colorBaseBlack),
                                                                                                            ),
                                                                                                            AppSizes.s12.height,
                                                                                                            Obx(
                                                                                                              () {
                                                                                                                return Row(
                                                                                                                  children: [
                                                                                                                    Flexible(
                                                                                                                      child: InkWell(
                                                                                                                        onTap: () {
                                                                                                                          controllerApotik.setPaymentMethod(PaymentMethod.tunai);
                                                                                                                        },
                                                                                                                        child: Container(
                                                                                                                          height: 50,
                                                                                                                          decoration: BoxDecoration(
                                                                                                                            color: controllerApotik.selectedPaymentMethod.value == PaymentMethod.tunai ? AppColors.colorBasePrimary : AppColors.colorFillBorder,
                                                                                                                            borderRadius: BorderRadius.circular(AppSizes.s4),
                                                                                                                            border: Border.all(
                                                                                                                              color: AppColors.colorBasePrimary,
                                                                                                                            ),
                                                                                                                          ),
                                                                                                                          child: Center(
                                                                                                                            child: Text(
                                                                                                                              'Tunai',
                                                                                                                              style: Get.textTheme.labelMedium!.copyWith(
                                                                                                                                fontSize: AppSizes.s14,
                                                                                                                                color: controllerApotik.selectedPaymentMethod.value == PaymentMethod.tunai ? AppColors.colorBaseWhite : AppColors.colorBaseBlack,
                                                                                                                              ),
                                                                                                                            ),
                                                                                                                          ),
                                                                                                                        ),
                                                                                                                      ),
                                                                                                                    ),
                                                                                                                    // AppSizes.s17.width,
                                                                                                                    // Flexible(
                                                                                                                    //   child: InkWell(
                                                                                                                    //     onTap: () {
                                                                                                                    //       controllerApotik.setPaymentMethod(PaymentMethod.qris);
                                                                                                                    //     },
                                                                                                                    //     child: Container(
                                                                                                                    //       height: 50,
                                                                                                                    //       decoration: BoxDecoration(
                                                                                                                    //         color: controllerApotik.selectedPaymentMethod.value == PaymentMethod.qris ? AppColors.colorBasePrimary : AppColors.colorFillBorder,
                                                                                                                    //         borderRadius: BorderRadius.circular(AppSizes.s4),
                                                                                                                    //         border: Border.all(
                                                                                                                    //           color: AppColors.colorBasePrimary,
                                                                                                                    //         ),
                                                                                                                    //       ),
                                                                                                                    //       child: Center(
                                                                                                                    //         child: Text(
                                                                                                                    //           'Qris',
                                                                                                                    //           style: Get.textTheme.labelMedium!.copyWith(
                                                                                                                    //             fontSize: AppSizes.s14,
                                                                                                                    //             color: controllerApotik.selectedPaymentMethod.value == PaymentMethod.qris ? AppColors.colorBaseWhite : AppColors.colorBaseBlack,
                                                                                                                    //           ),
                                                                                                                    //         ),
                                                                                                                    //       ),
                                                                                                                    //     ),
                                                                                                                    //   ),
                                                                                                                    // ),
                                                                                                                  ],
                                                                                                                );
                                                                                                              },
                                                                                                            ),
                                                                                                            AppSizes.s12.height,
                                                                                                            InputDataComponent(
                                                                                                              label: 'Total Tagihan',
                                                                                                              hintText: controllerApotik.dataPasienIdRme.value!.total.currencyFormatRp,
                                                                                                              readOnly: true,
                                                                                                              controller: TextEditingController(),
                                                                                                            ),
                                                                                                            AppSizes.s10.height,
                                                                                                            InputDataComponent(
                                                                                                              label: 'Nominal Bayar',
                                                                                                              hintText: 'Masukan nominal Bayar',
                                                                                                              controller: controllerApotik.nominalController,
                                                                                                              onChanged: controllerApotik.hitungKembalian,
                                                                                                              // inputFormatters: <TextInputFormatter>[
                                                                                                              //   CurrencyTextInputFormatter.currency(
                                                                                                              //     locale: 'id',
                                                                                                              //     symbol: 'Rp ',
                                                                                                              //     decimalDigits: 0,
                                                                                                              //   ),
                                                                                                              // ],
                                                                                                              textInputType: TextInputType.number,
                                                                                                            ),
                                                                                                            AppSizes.s10.height,
                                                                                                            Row(
                                                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                                              children: [
                                                                                                                Text(
                                                                                                                  'Uang Kembali',
                                                                                                                  style: Get.textTheme.bodyMedium!.copyWith(
                                                                                                                    fontSize: AppSizes.s15,
                                                                                                                    fontWeight: FontWeight.bold,
                                                                                                                    color: AppColors.colorBaseBlack,
                                                                                                                  ),
                                                                                                                ),
                                                                                                                Obx(() {
                                                                                                                  return Text(controllerApotik.kembalian.value >= 0 ? controllerApotik.kembalian.value.currencyFormatRp : 0.currencyFormatRp,
                                                                                                                      style: Get.textTheme.bodyMedium!.copyWith(
                                                                                                                        fontSize: AppSizes.s15,
                                                                                                                        color: AppColors.colorBaseBlack,
                                                                                                                      ));
                                                                                                                })
                                                                                                              ],
                                                                                                            ),
                                                                                                            AppSizes.s10.height,
                                                                                                            Flexible(
                                                                                                              child: Button.filled(
                                                                                                                  onPressed: () async {
                                                                                                                    if (controllerApotik.selectedPaymentMethod.value == PaymentMethod.tunai) {
                                                                                                                      var data = PostTransactionRequest(
                                                                                                                        paymentMethod: 'tunai',
                                                                                                                        nominalPayment: controllerApotik.dataPasienIdRme.value!.total,
                                                                                                                        amountPaid: int.parse(controllerApotik.nominalController.text),
                                                                                                                        changeGiven: controllerApotik.kembalian.value >= 0 ? controllerApotik.kembalian.value : 0,
                                                                                                                        idRekamMedis: controllerApotik.dataPasienIdRme.value!.detailObatRekamMedis[0].idRekamMedis,
                                                                                                                      );
                                                                                                                      await controllerApotik.postTransaction(data: data);
                                                                                                                      Get.back();
                                                                                                                    } else if (controllerApotik.selectedPaymentMethod.value == PaymentMethod.qris) {
                                                                                                                      var data = PostTransactionRequest(
                                                                                                                        paymentMethod: 'qris',
                                                                                                                        nominalPayment: controllerApotik.dataPasienIdRme.value!.total,
                                                                                                                        amountPaid: int.parse(controllerApotik.nominalController.text),
                                                                                                                        changeGiven: controllerApotik.kembalian.value >= 0 ? controllerApotik.kembalian.value : 0,
                                                                                                                        idRekamMedis: controllerApotik.dataPasienIdRme.value!.detailObatRekamMedis[0].idRekamMedis,
                                                                                                                      );
                                                                                                                      await controllerApotik.postTransaction(data: data);
                                                                                                                      Get.back();
                                                                                                                    }
                                                                                                                    showModalCenter(context, Obx(() {
                                                                                                                      return controllerApotik.isLoadingPostTransaction.value
                                                                                                                          ? Center(
                                                                                                                              child: SizedBox(
                                                                                                                                width: 400,
                                                                                                                                height: 400,
                                                                                                                                child: Lottie.asset(Assets.lottie.hospital),
                                                                                                                              ),
                                                                                                                            )
                                                                                                                          : SuccesPaymentWidget(
                                                                                                                              paymentMethod: '',
                                                                                                                              invoice: '',
                                                                                                                              totalTagihan: '',
                                                                                                                              nominalBayar: '',
                                                                                                                              kembalian: '',
                                                                                                                              date: '',
                                                                                                                              // paymentMethod: controllerApotik.createTransaction.value!.data.paymentMethod ,
                                                                                                                              // invoice: controllerApotik.createTransaction.value!.data.invoce,
                                                                                                                              // totalTagihan: controllerApotik.createTransaction.value!.data.nominalPayment.currencyFormatRp,
                                                                                                                              // nominalBayar: controllerApotik.createTransaction.value!.data.amountPaid.currencyFormatRp,
                                                                                                                              // kembalian: controllerApotik.kembalian.value >= 0 ? controllerApotik.kembalian.value.currencyFormatRp : 0.currencyFormatRp,
                                                                                                                              // date: controllerApotik.createTransaction.value!.data.createdAt.toDateTimePartString(),
                                                                                                                            );
                                                                                                                    }));
                                                                                                                  },
                                                                                                                  label: 'Lanjutkan'),
                                                                                                            )
                                                                                                          ],
                                                                                                        ),
                                                                                                      ),
                                                                                                    ],
                                                                                                  ).paddingSymmetric(
                                                                                                    vertical: AppSizes.s53,
                                                                                                    horizontal: AppSizes.s40,
                                                                                                  ),
                                                                                          );
                                                                                        }
                                                                                      : () async {
                                                                                          await controllerApotik.getTransactionPasienIdRme(id: patient.idPasien);
                                                                                          showModalCenter(
                                                                                            context,
                                                                                            ListView(
                                                                                              children: [
                                                                                                Column(
                                                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                  children: [
                                                                                                    Row(
                                                                                                      children: [
                                                                                                        IconButton(
                                                                                                          onPressed: () {
                                                                                                            Get.back();
                                                                                                            Get.back();
                                                                                                          },
                                                                                                          icon: const Icon(
                                                                                                            Icons.arrow_back,
                                                                                                            size: 24,
                                                                                                            color: AppColors.colorBaseBlack,
                                                                                                          ),
                                                                                                        ),
                                                                                                        Text(
                                                                                                          'Transaksi',
                                                                                                          style: Get.textTheme.labelMedium!.copyWith(fontWeight: FontWeight.bold, fontSize: AppSizes.s24),
                                                                                                        ),
                                                                                                      ],
                                                                                                    ),
                                                                                                    Divider(),
                                                                                                    AppSizes.s30.height,
                                                                                                    InputDataComponent(
                                                                                                      label: 'No Rekam Medis',
                                                                                                      hintText: patient.pasien.noRekamMedis,
                                                                                                      controller: TextEditingController(),
                                                                                                      readOnly: true,
                                                                                                    ),
                                                                                                    InputDataComponent(
                                                                                                      label: 'Nama Pasien',
                                                                                                      hintText: patient.pasien.name,
                                                                                                      controller: TextEditingController(),
                                                                                                      readOnly: true,
                                                                                                    ),
                                                                                                    InputDataComponent(
                                                                                                      label: 'Alamat',
                                                                                                      hintText: patient.pasien.alamat,
                                                                                                      controller: TextEditingController(),
                                                                                                      readOnly: true,
                                                                                                    ),
                                                                                                    InputDataComponent(
                                                                                                      label: 'Keluhan',
                                                                                                      hintText: controllerApotik.dataPasienIdRme.value!.keluhan,
                                                                                                      controller: TextEditingController(),
                                                                                                      readOnly: true,
                                                                                                    ),
                                                                                                    InputDataComponent(
                                                                                                      maxLines: 10,
                                                                                                      label: AppConstants.LABEL_TERAPI_TINDAKAN,
                                                                                                      hintText: controllerApotik.dataPasienIdRme.value!.terapiTindakan,
                                                                                                      controller: TextEditingController(),
                                                                                                      readOnly: true,
                                                                                                      textInputType: TextInputType.multiline,
                                                                                                    ),
                                                                                                    AppSizes.s31.height,
                                                                                                    Column(
                                                                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                      children: [
                                                                                                        Text(
                                                                                                          AppConstants.LABEL_OBAT,
                                                                                                          style: Get.textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w700, fontSize: AppSizes.s14, color: AppColors.colorBaseBlack),
                                                                                                        ),
                                                                                                        SizedBox(
                                                                                                          width: double.infinity,
                                                                                                          height: AppSizes.setResponsiveHeight(context) * 0.25,
                                                                                                          child: ListView.builder(
                                                                                                            shrinkWrap: true,
                                                                                                            itemCount: controllerApotik.dataPasienIdRme.value!.detailObatRekamMedis.length,
                                                                                                            itemBuilder: (context, index) {
                                                                                                              var obat = controllerApotik.dataPasienIdRme.value!.detailObatRekamMedis[index];
                                                                                                              return Flexible(
                                                                                                                child: Container(
                                                                                                                  margin: AppSizes.symmetricPadding(vertical: AppSizes.s5),
                                                                                                                  child: Row(
                                                                                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                                                    children: [
                                                                                                                      Column(
                                                                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                                        children: [
                                                                                                                          Text(
                                                                                                                            obat.obat.namaObat,
                                                                                                                            style: Get.textTheme.bodyMedium!.copyWith(
                                                                                                                              fontSize: AppSizes.s15,
                                                                                                                              color: AppColors.colorBaseBlack,
                                                                                                                            ),
                                                                                                                          ),
                                                                                                                        ],
                                                                                                                      ),
                                                                                                                      Container(
                                                                                                                        width: 60,
                                                                                                                        height: 50,
                                                                                                                        child: CustomTextField(
                                                                                                                          hintText: '2',
                                                                                                                          controller: TextEditingController(),
                                                                                                                          readOnly: true,
                                                                                                                          keyboardType: TextInputType.number,
                                                                                                                          //textInputType: TextInputType.name,
                                                                                                                          hintStyle: Get.textTheme.titleMedium!.copyWith(color: AppColors.colorSecondary600, fontSize: AppSizes.s10),
                                                                                                                          onChanged: (value) {},
                                                                                                                        ),
                                                                                                                      ),
                                                                                                                    ],
                                                                                                                  ),
                                                                                                                ),
                                                                                                              );
                                                                                                            },
                                                                                                          ),
                                                                                                        ),
                                                                                                      ],
                                                                                                    ),
                                                                                                    AppSizes.s10.height,
                                                                                                    Column(
                                                                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                      children: [
                                                                                                        Text(
                                                                                                          'Metode Pembayaran',
                                                                                                          style: Get.textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w700, fontSize: AppSizes.s14, color: AppColors.colorBaseBlack),
                                                                                                        ),
                                                                                                        AppSizes.s10.height,
                                                                                                        Obx(
                                                                                                          () {
                                                                                                            return Row(
                                                                                                              children: [
                                                                                                                Flexible(
                                                                                                                  child: InkWell(
                                                                                                                    onTap: () {
                                                                                                                      controllerApotik.setPaymentMethod(PaymentMethod.tunai);
                                                                                                                    },
                                                                                                                    child: Container(
                                                                                                                      height: 50,
                                                                                                                      decoration: BoxDecoration(
                                                                                                                        color: controllerApotik.selectedPaymentMethod.value == PaymentMethod.tunai ? AppColors.colorBasePrimary : AppColors.colorFillBorder,
                                                                                                                        borderRadius: BorderRadius.circular(AppSizes.s4),
                                                                                                                        border: Border.all(
                                                                                                                          color: AppColors.colorBasePrimary,
                                                                                                                        ),
                                                                                                                      ),
                                                                                                                      child: Center(
                                                                                                                        child: Text(
                                                                                                                          'Tunai',
                                                                                                                          style: Get.textTheme.labelMedium!.copyWith(
                                                                                                                            fontSize: AppSizes.s14,
                                                                                                                            color: controllerApotik.selectedPaymentMethod.value == PaymentMethod.tunai ? AppColors.colorBaseWhite : AppColors.colorBaseBlack,
                                                                                                                          ),
                                                                                                                        ),
                                                                                                                      ),
                                                                                                                    ),
                                                                                                                  ),
                                                                                                                ),
                                                                                                                // AppSizes.s17.width,
                                                                                                                // Flexible(
                                                                                                                //   child: InkWell(
                                                                                                                //     onTap: () {
                                                                                                                //       controllerApotik.setPaymentMethod(PaymentMethod.qris);
                                                                                                                //     },
                                                                                                                //     child: Container(
                                                                                                                //       height: 50,
                                                                                                                //       decoration: BoxDecoration(
                                                                                                                //         color: controllerApotik.selectedPaymentMethod.value == PaymentMethod.qris ? AppColors.colorBasePrimary : AppColors.colorFillBorder,
                                                                                                                //         borderRadius: BorderRadius.circular(AppSizes.s4),
                                                                                                                //         border: Border.all(
                                                                                                                //           color: AppColors.colorBasePrimary,
                                                                                                                //         ),
                                                                                                                //       ),
                                                                                                                //       child: Center(
                                                                                                                //         child: Text(
                                                                                                                //           'Qris',
                                                                                                                //           style: Get.textTheme.labelMedium!.copyWith(
                                                                                                                //             fontSize: AppSizes.s14,
                                                                                                                //             color: controllerApotik.selectedPaymentMethod.value == PaymentMethod.qris ? AppColors.colorBaseWhite : AppColors.colorBaseBlack,
                                                                                                                //           ),
                                                                                                                //         ),
                                                                                                                //       ),
                                                                                                                //     ),
                                                                                                                //   ),
                                                                                                                // ),
                                                                                                              ],
                                                                                                            );
                                                                                                          },
                                                                                                        ),
                                                                                                      ],
                                                                                                    ),
                                                                                                    AppSizes.s10.height,
                                                                                                    InputDataComponent(
                                                                                                      label: 'Total Tagihan',
                                                                                                      hintText: controllerApotik.dataPasienIdRme.value!.total.currencyFormatRp,
                                                                                                      readOnly: true,
                                                                                                      controller: TextEditingController(),
                                                                                                    ),
                                                                                                    AppSizes.s10.height,
                                                                                                    InputDataComponent(
                                                                                                      label: 'Nominal Bayar',
                                                                                                      hintText: 'Masukan nominal Bayar',
                                                                                                      controller: controllerApotik.nominalController,
                                                                                                      onChanged: controllerApotik.hitungKembalian,
                                                                                                      // inputFormatters: <TextInputFormatter>[
                                                                                                      //   CurrencyTextInputFormatter.currency(
                                                                                                      //     locale: 'id',
                                                                                                      //     symbol: 'Rp ',
                                                                                                      //     decimalDigits: 0,
                                                                                                      //   ),
                                                                                                      // ],
                                                                                                      textInputType: TextInputType.number,
                                                                                                    ),
                                                                                                    AppSizes.s10.height,
                                                                                                    Row(
                                                                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                                      children: [
                                                                                                        Text(
                                                                                                          'Uang Kembali',
                                                                                                          style: Get.textTheme.bodyMedium!.copyWith(
                                                                                                            fontSize: AppSizes.s15,
                                                                                                            fontWeight: FontWeight.bold,
                                                                                                            color: AppColors.colorBaseBlack,
                                                                                                          ),
                                                                                                        ),
                                                                                                        Obx(() {
                                                                                                          return Text(controllerApotik.kembalian.value >= 0 ? controllerApotik.kembalian.value.currencyFormatRp : 0.currencyFormatRp,
                                                                                                              style: Get.textTheme.bodyMedium!.copyWith(
                                                                                                                fontSize: AppSizes.s15,
                                                                                                                color: AppColors.colorBaseBlack,
                                                                                                              ));
                                                                                                        })
                                                                                                      ],
                                                                                                    ),
                                                                                                    AppSizes.s15.height,
                                                                                                    Row(
                                                                                                      spacing: AppSizes.s10,
                                                                                                      children: [
                                                                                                        Flexible(
                                                                                                          child: Button.filled(
                                                                                                              onPressed: () async {
                                                                                                                if (controllerApotik.selectedPaymentMethod.value == PaymentMethod.tunai) {
                                                                                                                  var data = PostTransactionRequest(
                                                                                                                    paymentMethod: 'tunai',
                                                                                                                    nominalPayment: controllerApotik.dataPasienIdRme.value!.total,
                                                                                                                    amountPaid: int.parse(controllerApotik.nominalController.text),
                                                                                                                    changeGiven: controllerApotik.kembalian.value >= 0 ? controllerApotik.kembalian.value : 0,
                                                                                                                    idRekamMedis: controllerApotik.dataPasienIdRme.value!.detailObatRekamMedis[0].idRekamMedis,
                                                                                                                  );
                                                                                                                  await controllerApotik.postTransaction(data: data);
                                                                                                                  Get.back();
                                                                                                                } else if (controllerApotik.selectedPaymentMethod.value == PaymentMethod.qris) {
                                                                                                                  var data = PostTransactionRequest(
                                                                                                                    paymentMethod: 'qris',
                                                                                                                    nominalPayment: controllerApotik.dataPasienIdRme.value!.total,
                                                                                                                    amountPaid: int.parse(controllerApotik.nominalController.text),
                                                                                                                    changeGiven: controllerApotik.kembalian.value >= 0 ? controllerApotik.kembalian.value : 0,
                                                                                                                    idRekamMedis: controllerApotik.dataPasienIdRme.value!.detailObatRekamMedis[0].idRekamMedis,
                                                                                                                  );
                                                                                                                  await controllerApotik.postTransaction(data: data);
                                                                                                                  Get.back();
                                                                                                                }
                                                                                                                showModalCenter(context, Obx(() {
                                                                                                                  return controllerApotik.isLoadingPostTransaction.value
                                                                                                                      ? Center(
                                                                                                                          child: SizedBox(
                                                                                                                            width: 400,
                                                                                                                            height: 400,
                                                                                                                            child: Lottie.asset(Assets.lottie.hospital),
                                                                                                                          ),
                                                                                                                        )
                                                                                                                      : SuccesPaymentWidget(
                                                                                                                          paymentMethod: controllerApotik.createTransaction.value!.data.paymentMethod,
                                                                                                                          invoice: controllerApotik.createTransaction.value!.data.invoce,
                                                                                                                          totalTagihan: controllerApotik.createTransaction.value!.data.nominalPayment.currencyFormatRp,
                                                                                                                          nominalBayar: controllerApotik.createTransaction.value!.data.amountPaid.currencyFormatRp,
                                                                                                                          kembalian: controllerApotik.kembalian.value >= 0 ? controllerApotik.kembalian.value.currencyFormatRp : 0.currencyFormatRp,
                                                                                                                          date: controllerApotik.createTransaction.value!.data.createdAt.toDateTimePartString(),
                                                                                                                        );
                                                                                                                }));
                                                                                                              },
                                                                                                              label: 'Lanjutkan'),
                                                                                                        )
                                                                                                      ],
                                                                                                    )
                                                                                                  ],
                                                                                                ),
                                                                                              ],
                                                                                            ),
                                                                                          );
                                                                                        },
                                                                                  icon: const Icon(
                                                                                    Icons.more_horiz,
                                                                                    size: 24,
                                                                                    color: Color(0xfff828282),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          )
                                                                        : DataCell(
                                                                            Container(),
                                                                          )
                                                                    : DataCell(
                                                                        Padding(
                                                                          padding:
                                                                              EdgeInsets.only(left: 300),
                                                                          child:
                                                                              Center(
                                                                            child:
                                                                                PopupMenuButton(
                                                                              icon: const Icon(
                                                                                Icons.more_horiz,
                                                                                size: 24,
                                                                                color: Color(0xfff828282),
                                                                              ),
                                                                              onSelected: (value) {
                                                                                value();
                                                                              },
                                                                              itemBuilder: (context) => [
                                                                                if (controller.role.value == "ADMIN") ...[
                                                                                  // PopupMenuItem(
                                                                                  //   child: StatusAntrianComponent(
                                                                                  //     status: "WAITING",
                                                                                  //   ),
                                                                                  //   onTap: () {
                                                                                  //     showModalCenter(
                                                                                  //       context,
                                                                                  //       Obx(
                                                                                  //         () {
                                                                                  //           return controller.isPutLoading.value
                                                                                  //               ? Center(
                                                                                  //                   child: SizedBox(
                                                                                  //                     width: 400,
                                                                                  //                     height: 400,
                                                                                  //                     child: Lottie.asset(Assets.lottie.hospital),
                                                                                  //                   ),
                                                                                  //                 )
                                                                                  //               : ShowModalTandaTanyaComponent(
                                                                                  //                   label: 'Ubah Antrian Pasien ${patient.pasien.name} ke Menunggu ?',
                                                                                  //                   onTapNo: () {
                                                                                  //                     Get.back();
                                                                                  //                   },
                                                                                  //                   onTapYes: () {
                                                                                  //                     controller.putAntrianPasien("WAITING", patient.id);
                                                                                  //                   },
                                                                                  //                 );
                                                                                  //         },
                                                                                  //       ),
                                                                                  //     );
                                                                                  //   },
                                                                                  //   value: () {
                                                                                  //     debugPrint('open WAITING');
                                                                                  //   },
                                                                                  // ),
                                                                                  PopupMenuItem(
                                                                                    child: StatusAntrianComponent(
                                                                                      status: "PROCESSING",
                                                                                    ),
                                                                                    onTap: () {
                                                                                      print('Le....');
                                                                                      showModalCenter(
                                                                                        context,
                                                                                        Obx(
                                                                                          () {
                                                                                            return controller.isPutLoading.value
                                                                                                ? Center(
                                                                                                    child: SizedBox(
                                                                                                      width: 400,
                                                                                                      height: 400,
                                                                                                      child: Lottie.asset(Assets.lottie.hospital),
                                                                                                    ),
                                                                                                  )
                                                                                                : ShowModalTandaTanyaComponent(
                                                                                                    label: 'Ubah Antrian Pasien ${patient.pasien.name} ke Proses ?',
                                                                                                    onTapNo: () {
                                                                                                      Get.back();
                                                                                                    },
                                                                                                    onTapYes: () {
                                                                                                      controller.putAntrianPasien("PROCESSING", patient.id);
                                                                                                    },
                                                                                                  );
                                                                                          },
                                                                                        ),
                                                                                      );
                                                                                    },
                                                                                    value: () {
                                                                                      debugPrint('open Proses');
                                                                                    },
                                                                                  ),
                                                                                  PopupMenuItem(
                                                                                    child: StatusAntrianComponent(
                                                                                      status: 'PENDING',
                                                                                    ),
                                                                                    onTap: () {
                                                                                      print('Le....');
                                                                                      showModalCenter(
                                                                                        context,
                                                                                        Obx(
                                                                                          () {
                                                                                            return controller.isPutLoading.value
                                                                                                ? Center(
                                                                                                    child: SizedBox(
                                                                                                      width: 400,
                                                                                                      height: 400,
                                                                                                      child: Lottie.asset(Assets.lottie.hospital),
                                                                                                    ),
                                                                                                  )
                                                                                                : ShowModalTandaTanyaComponent(
                                                                                                    label: 'Ubah Antrian Pasien ${patient.pasien.name} ke Pending ?',
                                                                                                    onTapNo: () {
                                                                                                      Get.back();
                                                                                                    },
                                                                                                    onTapYes: () {
                                                                                                      controller.putAntrianPasien("PENDING", patient.id);
                                                                                                    },
                                                                                                  );
                                                                                          },
                                                                                        ),
                                                                                      );
                                                                                    },
                                                                                    value: () {
                                                                                      debugPrint('open Pending');
                                                                                    },
                                                                                  ),
                                                                                  PopupMenuItem(
                                                                                    child: StatusAntrianComponent(
                                                                                      status: 'Dibatalkan',
                                                                                    ),
                                                                                    onTap: () {
                                                                                      print('Le....');
                                                                                      showModalCenter(
                                                                                        context,
                                                                                        Obx(
                                                                                          () {
                                                                                            return controller.isPutLoading.value
                                                                                                ? Center(
                                                                                                    child: SizedBox(
                                                                                                      width: 400,
                                                                                                      height: 400,
                                                                                                      child: Lottie.asset(Assets.lottie.hospital),
                                                                                                    ),
                                                                                                  )
                                                                                                : ShowModalTandaTanyaComponent(
                                                                                                    label: 'Ubah Antrian Pasien ${patient.pasien.name} ke Cencel ?',
                                                                                                    onTapNo: () {
                                                                                                      Get.back();
                                                                                                    },
                                                                                                    onTapYes: () {
                                                                                                      controller.putAntrianPasien("CANCEL", patient.id);
                                                                                                    },
                                                                                                  );
                                                                                          },
                                                                                        ),
                                                                                      );
                                                                                    },
                                                                                    value: () {
                                                                                      debugPrint('open Dibatalkan');
                                                                                    },
                                                                                  ),
                                                                                  PopupMenuItem(
                                                                                    child: Center(
                                                                                      child: Text(
                                                                                        'Hapus',
                                                                                        style: Get.textTheme.labelLarge!.copyWith(
                                                                                          fontSize: AppSizes.s14,
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                    value: () {
                                                                                      debugPrint('Hapus');
                                                                                    },
                                                                                    onTap: () async {
                                                                                      await controller.delAntrianPasien(patient.id);
                                                                                      showModalCenter(
                                                                                        context,
                                                                                        Obx(
                                                                                          () {
                                                                                            return controller.isDelLoading.value
                                                                                                ? Center(
                                                                                                    child: SizedBox(
                                                                                                      width: 400,
                                                                                                      height: 400,
                                                                                                      child: Lottie.asset(Assets.lottie.hospital),
                                                                                                    ),
                                                                                                  )
                                                                                                : Container();
                                                                                          },
                                                                                        ),
                                                                                      );
                                                                                    },
                                                                                  ),
                                                                                ],
                                                                                // PopupMenuItem(
                                                                                //   child:
                                                                                //       Center(
                                                                                //     child:
                                                                                //         Text(
                                                                                //       'Detail',
                                                                                //       style: Get.textTheme.labelLarge!.copyWith(
                                                                                //         fontSize: AppSizes.s14,
                                                                                //       ),
                                                                                //     ),
                                                                                //   ),
                                                                                //   value:
                                                                                //       () {
                                                                                //     debugPrint('open Detail');
                                                                                //   },
                                                                                // ),
                                                                                if (controller.role.value == "DOKTER") ...[
                                                                                  PopupMenuItem(
                                                                                    child: Center(
                                                                                      child: Text(
                                                                                        'Rekam Medis',
                                                                                        style: Get.textTheme.labelLarge!.copyWith(
                                                                                          fontSize: AppSizes.s14,
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                    value: () {
                                                                                      debugPrint('open Detail');
                                                                                    },
                                                                                    onTap: () {
                                                                                      controllerRme.getRmePasien(id: patient.idPasien);
                                                                                      Get.to(
                                                                                        RekamMedisScreen(
                                                                                          name: patient.pasien.name,
                                                                                          rme: patient.pasien.noRekamMedis,
                                                                                          id_pasien: patient.pasien.id,
                                                                                        ),
                                                                                      );
                                                                                    },
                                                                                  ),
                                                                                ],
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      )
                                                              ],
                                                            ),
                                                          )
                                                          .toList(),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                      ),
                    ),
                    Obx(
                      () {
                        return controller.numberOfPage.value < 1
                            ? Container()
                            : Container(
                                width: double.infinity,
                                padding: AppSizes.symmetricPadding(
                                    vertical: AppSizes.s20,
                                    horizontal: AppSizes.s41),
                                child: Column(
                                  children: [
                                    Container(
                                      //width: 400,
                                      decoration: BoxDecoration(
                                        color: AppColors.colorBaseWhite,
                                        borderRadius:
                                            BorderRadius.circular(AppSizes.s4),
                                      ),
                                      child: NumberPaginator(
                                        numberPages:
                                            controller.numberOfPage.value,
                                        onPageChange: (int index) {
                                          final page = index + 1;
                                          controller.getAntrianPasien(
                                              page: page);
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
                                      ),
                                    ),
                                  ],
                                ),
                              );
                      },
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
