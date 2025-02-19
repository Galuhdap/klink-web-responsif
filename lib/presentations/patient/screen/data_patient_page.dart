import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:klinik_web_responsif/core/components/button_component.dart';
import 'package:klinik_web_responsif/core/components/search_input.dart';
import 'package:klinik_web_responsif/core/components/show_center_dialog.dart';
import 'package:klinik_web_responsif/core/config/responsive.dart';
import 'package:klinik_web_responsif/core/styles/app_colors.dart';
import 'package:klinik_web_responsif/core/styles/app_sizes.dart';
import 'package:klinik_web_responsif/core/utils/extensions/sized_box_ext.dart';
import 'package:klinik_web_responsif/presentations/menu_dashboard/widget/build_app_bar.dart';
import 'package:klinik_web_responsif/presentations/patient/controller/patient_controller.dart';

class DataPatientScreen extends StatelessWidget {
  const DataPatientScreen({super.key});

  // @override
  @override
  Widget build(BuildContext context) {
    return GetBuilder<PatientController>(
      init: PatientController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: AppColors.colorNeutrals0,
          appBar: PreferredSize(
            preferredSize: Responsive.isMobile(context)
                ? Size.fromHeight(85.0)
                : Size.fromHeight(100.0),
            child: BuildAppBar(
              title: 'Data Pasien',
              withSearchInput: true,
              searchController: controller.searchController,
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
          body: Column(
            children: [
              AppSizes.s18.height,
              Responsive.isMobile(context)
                  ? Container(
                      width: double.infinity,
                      height: 190,
                      color: AppColors.colorBaseWhite,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: AppSizes.s13,
                        children: [
                          Text(
                            'Daftar Pasien',
                            style: Get.textTheme.titleLarge!
                                .copyWith(fontSize: AppSizes.s16),
                          ),
                          SearchInput(
                            onChanged: (_) {},
                            controller: controller.searchController,
                            hintText: 'Cari Pasien',
                          ),
                          Center(
                            child: InkWell(
                              onTap: () {
                                showModalCenter(
                                  context,
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Center(
                                        child: Text(
                                          'asdass',
                                          style: Get.textTheme.labelMedium!
                                              .copyWith(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: AppSizes.s16),
                                        ),
                                      ),
                                      AppSizes.s12.height,
                                      Divider(),
                                    ],
                                  ),
                                );
                              },
                              child: Container(
                                width: 137,
                                height: 45,
                                decoration: BoxDecoration(
                                  color: AppColors.colorBasePrimary,
                                  borderRadius:
                                      BorderRadius.circular(AppSizes.s10),
                                ),
                                child: Center(
                                  child: Text(
                                    'Daftar Pasien',
                                    style: Get.textTheme.bodyMedium!.copyWith(
                                        fontSize: AppSizes.s16,
                                        color: AppColors.colorBaseWhite),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ).paddingSymmetric(
                          vertical: AppSizes.s10, horizontal: AppSizes.s30),
                    )
                  : Container(),
              Expanded(
                child: Container(
                  width: double.infinity,
                  height: 230,
                  color: AppColors.colorBaseWhite,
                  child: ListView(
                    padding: AppSizes.symmetricPadding(
                      horizontal: AppSizes.s30,
                    ),
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border:
                              Border.all(color: AppColors.colorBaseSecondary),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.symmetric(vertical: 20.0),
                          scrollDirection: Axis.horizontal,
                          child: DataTable(
                            columnSpacing:
                                MediaQuery.of(context).size.width * 0.05,
                            dataRowMinHeight: 30.0,
                            dataRowMaxHeight: 60.0,
                            columns: [
                              DataColumn(
                                label: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'No',
                                    style: Get.textTheme.labelLarge!.copyWith(
                                        fontSize: AppSizes.s14,
                                        color: AppColors.colorBaseBlack),
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Nama Pasien',
                                    style: Get.textTheme.labelLarge!.copyWith(
                                        fontSize: AppSizes.s14,
                                        color: AppColors.colorBaseBlack),
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Tanggal Lahir',
                                    style: Get.textTheme.labelLarge!.copyWith(
                                        fontSize: AppSizes.s14,
                                        color: AppColors.colorBaseBlack),
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Alamat',
                                    style: Get.textTheme.labelLarge!.copyWith(
                                        fontSize: AppSizes.s14,
                                        color: AppColors.colorBaseBlack),
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'RM',
                                    style: Get.textTheme.labelLarge!.copyWith(
                                        fontSize: AppSizes.s14,
                                        color: AppColors.colorBaseBlack),
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'NIK',
                                    style: Get.textTheme.labelLarge!.copyWith(
                                        fontSize: AppSizes.s14,
                                        color: AppColors.colorBaseBlack),
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Telepon',
                                    style: Get.textTheme.labelLarge!.copyWith(
                                        fontSize: AppSizes.s14,
                                        color: AppColors.colorBaseBlack),
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Action',
                                    style: Get.textTheme.labelLarge!.copyWith(
                                        fontSize: AppSizes.s14,
                                        color: AppColors.colorBaseBlack),
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
                                                '1',
                                              ),
                                            ),
                                          ),
                                          DataCell(Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                'Yukya',
                                                style: const TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text('Laki-laki'),
                                            ],
                                          )),
                                          DataCell(Center(
                                              child: Text('20 Januari 1998'))),
                                          DataCell(
                                            Center(
                                              child: Text(
                                                'SINGGAHAN KAMPUNG INGGRIS',
                                              ),
                                            ),
                                          ),
                                          DataCell(
                                            Center(
                                              child: Text('00200'),
                                            ),
                                          ),
                                          DataCell(
                                            Center(
                                              child: Text('1234567891011'),
                                            ),
                                          ),
                                          DataCell(
                                            Center(
                                              child: Text('089514599819'),
                                            ),
                                          ),
                                          DataCell(
                                            Center(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  IconButton(
                                                    onPressed: () {},
                                                    icon: Icon(Iconsax
                                                        .more_circle_copy),
                                                  ),
                                                  //Icon(Iconsax.more_circle_copy),
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
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
