import 'package:flutter/material.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';

import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:klinik_web_responsif/core/components/button_component.dart';
import 'package:klinik_web_responsif/core/components/card_dashboard_component.dart';
import 'package:klinik_web_responsif/core/components/label_status_antrian_component.dart';
import 'package:klinik_web_responsif/core/components/search_new_component.dart';
import 'package:klinik_web_responsif/core/components/status_antrian_component.dart';
import 'package:klinik_web_responsif/core/config/responsive.dart';
import 'package:klinik_web_responsif/core/resources/constans/app_constants.dart';
import 'package:klinik_web_responsif/core/styles/app_colors.dart';
import 'package:klinik_web_responsif/core/styles/app_sizes.dart';
import 'package:klinik_web_responsif/core/utils/extensions/sized_box_ext.dart';
import 'package:klinik_web_responsif/presentations/home/controllers/home_controller.dart';
import 'package:klinik_web_responsif/presentations/menu_dashboard/widget/build_app_bar.dart';
import 'package:klinik_web_responsif/routes/app_routes.dart';

class StaffScreen extends StatelessWidget {
  const StaffScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        init: HomeController(),
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
            body: ListView(
              children: [
                Responsive.isMobile(context)
                    ? Column(
                        spacing: AppSizes.s16,
                        children: [
                          Row(
                            spacing: AppSizes.s10,
                            children: [
                              Flexible(
                                child: CardDashbordComponent(
                                  title: AppConstants
                                      .LABEL_PASIEN_ANTRIAN_SAAT_INI,
                                  count: '18, 19, 20',
                                  isIconActive: false,
                                ),
                              ),
                              Flexible(
                                child: CardDashbordComponent(
                                  title: AppConstants
                                      .LABEL_PASIEN_ANTRIAN_SELANJUTNYA,
                                  count: '21, 22, 23',
                                  isIconActive: false,
                                ),
                              ),
                            ],
                          ),
                          CardDashbordComponent(
                            title: AppConstants.LABEL_PASIEN_BULAN_INI,
                            count: '20',
                          ),
                          CardDashbordComponent(
                            title: AppConstants.LABEL_PASIEN_TERDAFTAR,
                            count: '20',
                          ),
                        ],
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        spacing: AppSizes.s16,
                        children: [
                          Flexible(
                            child: CardDashbordComponent(
                              title: AppConstants.LABEL_PASIEN_BULAN_INI,
                              count: '20',
                            ),
                          ),
                          Flexible(
                            child: CardDashbordComponent(
                              title: AppConstants.LABEL_PASIEN_TERDAFTAR,
                              count: '20',
                            ),
                          ),
                          Flexible(
                            child: CardDashbordComponent(
                              title: AppConstants.LABEL_PASIEN_ANTRIAN_SAAT_INI,
                              count: '18, 19, 20',
                              isIconActive: false,
                            ),
                          ),
                          Flexible(
                            child: CardDashbordComponent(
                              title:
                                  AppConstants.LABEL_PASIEN_ANTRIAN_SELANJUTNYA,
                              count: '21, 22, 23',
                              isIconActive: false,
                            ),
                          ),
                        ],
                      ),
                AppSizes.s32.height,
                Container(
                  width: double.infinity,
                  padding: AppSizes.symmetricPadding(
                      vertical: AppSizes.s35, horizontal: AppSizes.s41),
                  decoration: BoxDecoration(
                    color: AppColors.colorBaseWhite,
                    borderRadius: BorderRadius.circular(AppSizes.s4),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppConstants.LABEL_DAFTAR_ANTRIAN,
                        style: Get.textTheme.labelMedium!.copyWith(
                            fontSize: AppSizes.s16,
                            color: AppColors.colorBaseBlack,
                            fontWeight: FontWeight.bold),
                      ),
                      AppSizes.s24.height,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                controller: TextEditingController(),
                                keyboardType: TextInputType.name,
                                hintText: AppConstants.LABEL_CARI,
                                suffixIcon: const Icon(
                                  Icons.search,
                                  color: AppColors.colorSecondary500,
                                ),
                              ),
                            ),
                          ),
                          AppSizes.s17.width,
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(AppSizes.s4),
                              border: Border.all(color: Color(0xfffF0F0F0)),
                              color: AppColors.colorBaseWhite,
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
                            child: Center(
                              child: Icon(
                                Iconsax.filter,
                                color: AppColors.colorSecondary500,
                              ),
                            ),
                          ),
                          if (Responsive.isDesktop(context)) ...[
                            AppSizes.s36.width,
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
                    height: 500,
                    color: AppColors.colorBaseWhite,
                    child: ListView(
                      padding: AppSizes.symmetricPadding(
                        horizontal: AppSizes.s30,
                      ),
                      children: [
                        SingleChildScrollView(
                          padding: const EdgeInsets.symmetric(vertical: 20.0),
                          scrollDirection: Axis.horizontal,
                          child: Center(
                            child: Theme(
                              data: Theme.of(context)
                                  .copyWith(dividerColor: Colors.transparent),
                              child: DataTable(
                                dividerThickness: 0.0,
                                dataRowMinHeight: 20.0,
                                dataRowMaxHeight: 50.0,
                                columns: [
                                  DataColumn(
                                    label: Text(
                                      AppConstants.LABEL_NO_ANTRIAN,
                                      style: Get.textTheme.labelLarge!.copyWith(
                                          fontSize: AppSizes.s14,
                                          color: AppColors.colorBaseBlack),
                                    ),
                                  ),
                                  DataColumn(
                                    label: Padding(
                                      padding: EdgeInsets.only(
                                          left: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.07,
                                          right: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.201),
                                      child: Text(
                                        AppConstants.LABEL_NAMA_PASIEN,
                                        style: Get.textTheme.labelLarge!
                                            .copyWith(
                                                fontSize: AppSizes.s14,
                                                color:
                                                    AppColors.colorBaseBlack),
                                      ),
                                    ),
                                  ),
                                  DataColumn(
                                      label: Center(
                                    child: Text(
                                      AppConstants.LABEL_STATUS,
                                      style: Get.textTheme.labelLarge!.copyWith(
                                          fontSize: AppSizes.s14,
                                          color: AppColors.colorBaseBlack),
                                    ),
                                  ).paddingOnly(left: 30)),
                                  DataColumn(
                                    label: Padding(
                                      padding: EdgeInsets.only(
                                        left:
                                            MediaQuery.of(context).size.width *
                                                0.07,
                                        right:
                                            MediaQuery.of(context).size.width *
                                                0.07,
                                      ),
                                      child: Text(
                                        AppConstants.LABEL_WAKTU_TUNGGU,
                                        style: Get.textTheme.labelLarge!
                                            .copyWith(
                                                fontSize: AppSizes.s14,
                                                color:
                                                    AppColors.colorBaseBlack),
                                      ),
                                    ),
                                  ),
                                  DataColumn(
                                    label: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        AppConstants.LABEL_ACTION,
                                        style: Get.textTheme.labelLarge!
                                            .copyWith(
                                                fontSize: AppSizes.s14,
                                                color:
                                                    AppColors.colorBaseBlack),
                                      ),
                                    ),
                                  ),
                                ],
                                rows: controller.patient.isEmpty
                                    ? [
                                        const DataRow(
                                          cells: [
                                            DataCell.empty,
                                            DataCell.empty,
                                            DataCell(Row(
                                              spacing: 4,
                                              children: [
                                                Icon(Icons.highlight_off),
                                                //SpaceWidth(4.0),
                                                Text('Data tidak ditemukan..'),
                                              ],
                                            )),
                                            DataCell.empty,
                                            DataCell.empty,
                                          ],
                                        ),
                                        DataRow(
                                          cells: [
                                            DataCell.empty,
                                            DataCell.empty,
                                            DataCell(
                                              Button.filled(
                                                onPressed: () {
                                                  // showDialog(
                                                  //   context: context,
                                                  //   barrierDismissible: false,
                                                  //   builder: (context) =>
                                                  //       const CreatePatientDialog(),
                                                  // );
                                                },
                                                label: 'Pasien Baru',
                                                width: 250,
                                              ),
                                            ),
                                            DataCell.empty,
                                            DataCell.empty,
                                          ],
                                        ),
                                      ]
                                    : controller.patient
                                        .map(
                                          (patient) => DataRow(
                                            cells: [
                                              DataCell(
                                                Center(
                                                  child: Text(
                                                    patient["nomor_antrian"],
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ),
                                              DataCell(
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                    left: MediaQuery.of(context)
                                                            .size
                                                            .width *
                                                        0.07,
                                                  ),
                                                  child: Column(
                                                    spacing: 5,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        patient["nama_pasien"],
                                                        style: Get.textTheme
                                                            .labelLarge!
                                                            .copyWith(
                                                          fontSize:
                                                              AppSizes.s16,
                                                        ),
                                                      ),
                                                      Text(
                                                        patient['rm'],
                                                        style: Get.textTheme
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
                                                  status: patient['status'],
                                                ),
                                              ),
                                              DataCell(
                                                Center(
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                      left:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.07,
                                                      right:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.07,
                                                    ),
                                                    child: TimerCountdown(
                                                      format: CountDownTimerFormat
                                                          .hoursMinutesSeconds,
                                                      endTime: DateTime.now()
                                                          .add(Duration(
                                                              minutes: 15)),
                                                      enableDescriptions: false,
                                                      onEnd: () {
                                                        print("Timer finished");
                                                      },
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              DataCell(
                                                Center(
                                                  child: PopupMenuButton(
                                                    icon: const Icon(
                                                      Icons.more_horiz,
                                                      size: 24,
                                                      color: Color(0xfff828282),
                                                    ),
                                                    onSelected: (value) {
                                                      value();
                                                    },
                                                    itemBuilder: (context) => [
                                                      if (controller
                                                              .role.value ==
                                                          'admin') ...[
                                                        PopupMenuItem(
                                                          child:
                                                              StatusAntrianComponent(
                                                            status: 'proses',
                                                          ),
                                                          value: () {
                                                            debugPrint(
                                                                'open Proses');
                                                          },
                                                        ),
                                                        PopupMenuItem(
                                                          child:
                                                              StatusAntrianComponent(
                                                            status: 'pending',
                                                          ),
                                                          value: () {
                                                            debugPrint(
                                                                'open Pending');
                                                          },
                                                        ),
                                                        PopupMenuItem(
                                                          child:
                                                              StatusAntrianComponent(
                                                            status:
                                                                'dibatalkan',
                                                          ),
                                                          value: () {
                                                            debugPrint(
                                                                'open Dibatalkan');
                                                          },
                                                        ),
                                                      ],
                                                      PopupMenuItem(
                                                        child: Center(
                                                          child: Text(
                                                            'Detail',
                                                            style: Get.textTheme
                                                                .labelLarge!
                                                                .copyWith(
                                                              fontSize:
                                                                  AppSizes.s14,
                                                            ),
                                                          ),
                                                        ),
                                                        value: () {
                                                          debugPrint(
                                                              'open Detail');
                                                        },
                                                      ),
                                                      if (controller
                                                              .role.value ==
                                                          'docter') ...[
                                                        PopupMenuItem(
                                                          child: Center(
                                                            child: Text(
                                                              'Rekam Medis',
                                                              style: Get
                                                                  .textTheme
                                                                  .labelLarge!
                                                                  .copyWith(
                                                                fontSize:
                                                                    AppSizes
                                                                        .s14,
                                                              ),
                                                            ),
                                                          ),
                                                          value: () {
                                                            debugPrint(
                                                                'open Detail');
                                                          },
                                                          onTap: () {
                                                            Get.toNamed(AppRoutes
                                                                .rekamMedis);
                                                          },
                                                        ),
                                                      ],
                                                      PopupMenuItem(
                                                        child: Center(
                                                          child: Text(
                                                            'Hapus',
                                                            style: Get.textTheme
                                                                .labelLarge!
                                                                .copyWith(
                                                              fontSize:
                                                                  AppSizes.s14,
                                                            ),
                                                          ),
                                                        ),
                                                        value: () {
                                                          debugPrint('Hapus');
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
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
              ],
            ).paddingSymmetric(
              vertical: AppSizes.s41,
              horizontal: AppSizes.s28,
            ),
          );
        });
  }
}
