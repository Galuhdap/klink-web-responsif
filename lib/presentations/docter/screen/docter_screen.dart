import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:klinik_web_responsif/core/components/button_component.dart';
import 'package:klinik_web_responsif/core/components/input_data_component.dart';
import 'package:klinik_web_responsif/core/components/modal/show_modal_tanda_tanya_componenet.dart';
import 'package:klinik_web_responsif/core/components/popup_menu_component.dart';
import 'package:klinik_web_responsif/core/components/search_new_component.dart';
import 'package:klinik_web_responsif/core/components/show_bottom_dialog.dart';
import 'package:klinik_web_responsif/core/components/show_center_dialog.dart';
import 'package:klinik_web_responsif/core/components/status_docter_aktif_component.dart';
import 'package:klinik_web_responsif/core/config/responsive.dart';
import 'package:klinik_web_responsif/core/resources/constans/app_constants.dart';
import 'package:klinik_web_responsif/core/styles/app_colors.dart';
import 'package:klinik_web_responsif/core/styles/app_sizes.dart';
import 'package:klinik_web_responsif/core/utils/extensions/sized_box_ext.dart';
import 'package:klinik_web_responsif/presentations/docter/controller/docter_controller.dart';
import 'package:klinik_web_responsif/presentations/menu_dashboard/widget/build_app_bar.dart';

class DocterScreen extends StatelessWidget {
  const DocterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DocterController>(
      init: DocterController(),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          AppConstants.LABEL_DAFTAR_DATA_DOKTER,
                          style: Get.textTheme.labelMedium!.copyWith(
                              fontSize: AppSizes.s16,
                              color: AppColors.colorBaseBlack,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
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
                                  color:
                                      AppColors.colorNeutrals300.withAlpha(40),
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
                                color: AppColors.colorNeutrals300.withAlpha(40),
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
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  height: 500,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppSizes.s4),
                    color: AppColors.colorBaseWhite,
                  ),
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
                                    AppConstants.LABEL_NO,
                                    style: Get.textTheme.labelLarge!.copyWith(
                                        fontSize: AppSizes.s14,
                                        color: AppColors.colorBaseBlack),
                                  ),
                                ),
                                DataColumn(
                                  label: Padding(
                                    padding: EdgeInsets.only(
                                      left: MediaQuery.of(context).size.width *
                                          0.02,
                                    ),
                                    child: Text(
                                      AppConstants.LABEL_NAMA_DOKTER,
                                      style: Get.textTheme.labelLarge!.copyWith(
                                          fontSize: AppSizes.s14,
                                          color: AppColors.colorBaseBlack),
                                    ),
                                  ),
                                ),
                                DataColumn(
                                  label: Center(
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                        left:
                                            MediaQuery.of(context).size.width *
                                                0.1,
                                      ),
                                      child: Text(
                                        AppConstants.LABEL_ADDRESS,
                                        style: Get.textTheme.labelLarge!
                                            .copyWith(
                                                fontSize: AppSizes.s14,
                                                color:
                                                    AppColors.colorBaseBlack),
                                      ),
                                    ),
                                  ),
                                ),
                                DataColumn(
                                  label: Padding(
                                    padding: EdgeInsets.only(
                                      left: MediaQuery.of(context).size.width *
                                          0.08,
                                    ),
                                    child: Text(
                                      AppConstants.LABEL_NO_TELP,
                                      style: Get.textTheme.labelLarge!.copyWith(
                                          fontSize: AppSizes.s14,
                                          color: AppColors.colorBaseBlack),
                                    ),
                                  ),
                                ),
                                DataColumn(
                                  label: Padding(
                                    padding: EdgeInsets.only(
                                      left: MediaQuery.of(context).size.width *
                                          0.05,
                                    ),
                                    child: Text(
                                      AppConstants.LABEL_STATUS,
                                      style: Get.textTheme.labelLarge!.copyWith(
                                          fontSize: AppSizes.s14,
                                          color: AppColors.colorBaseBlack),
                                    ),
                                  ),
                                ),
                                DataColumn(
                                  label: Padding(
                                    padding: EdgeInsets.only(
                                      left: MediaQuery.of(context).size.width *
                                          0.02,
                                    ),
                                    child: Text(
                                      AppConstants.LABEL_ACTION,
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
                                                  patient["no"],
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
                                                      0.02,
                                                  right: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.04,
                                                ),
                                                child: Text(
                                                  patient["nama_docter"],
                                                  style: Get
                                                      .textTheme.labelLarge!
                                                      .copyWith(
                                                    fontSize: AppSizes.s16,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            DataCell(
                                              Padding(
                                                padding: EdgeInsets.only(
                                                  left: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.1,
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    patient["alamat"],
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            DataCell(
                                              Padding(
                                                padding: EdgeInsets.only(
                                                  left: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.08,
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    patient["no_telp"],
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            DataCell(
                                              Padding(
                                                padding: EdgeInsets.only(
                                                  left: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.03,
                                                ),
                                                child:
                                                    StatusDoctorAktifComponent(
                                                  status: patient['status'],
                                                ),
                                              ),
                                            ),
                                            DataCell(
                                              Padding(
                                                padding: EdgeInsets.only(
                                                  left: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.02,
                                                ),
                                                child:
                                                    Responsive.isMobile(context)
                                                        ? IconButton(
                                                            onPressed: () {
                                                              showModalBottom(
                                                                  context,
                                                                  Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      AppSizes
                                                                          .s8
                                                                          .height,
                                                                      Center(
                                                                        child:
                                                                            Container(
                                                                          width:
                                                                              AppSizes.s56,
                                                                          height:
                                                                              AppSizes.s4,
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            borderRadius:
                                                                                BorderRadius.circular(AppSizes.s8),
                                                                            color:
                                                                                AppColors.colorNeutrals100,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      AppSizes
                                                                          .s11
                                                                          .height,
                                                                      Column(
                                                                        spacing:
                                                                            24,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          InkWell(
                                                                            onTap:
                                                                                () {
                                                                              showModalCenter(
                                                                                context,
                                                                                Column(
                                                                                  // crossAxisAlignment:
                                                                                  //     CrossAxisAlignment.start,
                                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                                  children: [
                                                                                    Center(
                                                                                      child: Text(
                                                                                        'Detail',
                                                                                        style: Get.textTheme.labelMedium!.copyWith(fontWeight: FontWeight.bold, fontSize: AppSizes.s28),
                                                                                      ),
                                                                                    ),
                                                                                    AppSizes.s12.height,
                                                                                    Divider(),
                                                                                    InputDataComponent(
                                                                                      label: 'Nama Docter',
                                                                                      hintText: 'Muklas',
                                                                                      controller: TextEditingController(),
                                                                                      readOnly: true,
                                                                                    ),
                                                                                    InputDataComponent(
                                                                                      label: 'Tanggal Lahir',
                                                                                      hintText: '12/12/2020',
                                                                                      controller: TextEditingController(),
                                                                                      readOnly: true,
                                                                                    ),
                                                                                    InputDataComponent(
                                                                                      label: 'Alamat',
                                                                                      hintText: 'Desa Nguwok',
                                                                                      controller: TextEditingController(),
                                                                                      readOnly: true,
                                                                                    ),
                                                                                    InputDataComponent(
                                                                                      label: 'No Telpon',
                                                                                      hintText: '09939949293',
                                                                                      controller: TextEditingController(),
                                                                                      readOnly: true,
                                                                                    ),
                                                                                    Flexible(
                                                                                      child: Button.filled(
                                                                                          onPressed: () {
                                                                                            Get.back();
                                                                                            Get.back();
                                                                                          },
                                                                                          label: 'Kembali'),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              );
                                                                            },
                                                                            child:
                                                                                Text(
                                                                              'Detail',
                                                                              style: Get.textTheme.labelLarge!.copyWith(
                                                                                fontSize: AppSizes.s14,
                                                                                color: AppColors.colorBaseBlack,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          InkWell(
                                                                            onTap:
                                                                                () {
                                                                              showModalCenter(
                                                                                context,
                                                                                ShowModalTandaTanyaComponent(
                                                                                  label: 'Apakah anda yakin ingin menghapus data Farhan ?',
                                                                                  onTapNo: () {
                                                                                    Get.back();
                                                                                  },
                                                                                  onTapYes: () {},
                                                                                ),
                                                                              );
                                                                            },
                                                                            child:
                                                                                Text(
                                                                              'Hapus',
                                                                              style: Get.textTheme.labelLarge!.copyWith(
                                                                                fontSize: AppSizes.s14,
                                                                                color: AppColors.colorBaseBlack,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ).paddingOnly(
                                                                        left: AppSizes
                                                                            .s24,
                                                                        bottom:
                                                                            AppSizes.s20,
                                                                      ),
                                                                    ],
                                                                  ));
                                                            },
                                                            icon: Icon(
                                                              Icons.more_horiz,
                                                              size: 24,
                                                              color: Color(
                                                                  0xfff828282),
                                                            ),
                                                          )
                                                        : Center(
                                                            child:
                                                                PopupMenuButton(
                                                              icon: const Icon(
                                                                Icons
                                                                    .more_horiz,
                                                                size: 24,
                                                                color: Color(
                                                                    0xfff828282),
                                                              ),
                                                              onSelected:
                                                                  (value) {
                                                                value();
                                                              },
                                                              itemBuilder:
                                                                  (context) => [
                                                                PopupMenuItem(
                                                                  child:
                                                                      PopupMenuActionComponent(
                                                                    label:
                                                                        'Detail',
                                                                  ),
                                                                  value: () {
                                                                    debugPrint(
                                                                        'Detial');
                                                                  },
                                                                  onTap: () {
                                                                    showModalCenter(
                                                                      context,
                                                                      Column(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        children: [
                                                                          Center(
                                                                            child:
                                                                                Text(
                                                                              'Detail',
                                                                              style: Get.textTheme.labelMedium!.copyWith(fontWeight: FontWeight.bold, fontSize: AppSizes.s28),
                                                                            ),
                                                                          ),
                                                                          AppSizes
                                                                              .s12
                                                                              .height,
                                                                          Divider(),
                                                                          InputDataComponent(
                                                                            label:
                                                                                'Nama Docter',
                                                                            hintText:
                                                                                'Muklas',
                                                                            controller:
                                                                                TextEditingController(),
                                                                            readOnly:
                                                                                true,
                                                                          ),
                                                                          InputDataComponent(
                                                                            label:
                                                                                'Tanggal Lahir',
                                                                            hintText:
                                                                                '12/12/2020',
                                                                            controller:
                                                                                TextEditingController(),
                                                                            readOnly:
                                                                                true,
                                                                          ),
                                                                          InputDataComponent(
                                                                            label:
                                                                                'Alamat',
                                                                            hintText:
                                                                                'Desa Nguwok',
                                                                            controller:
                                                                                TextEditingController(),
                                                                            readOnly:
                                                                                true,
                                                                          ),
                                                                          InputDataComponent(
                                                                            label:
                                                                                'No Telpon',
                                                                            hintText:
                                                                                '09939949293',
                                                                            controller:
                                                                                TextEditingController(),
                                                                            readOnly:
                                                                                true,
                                                                          ),
                                                                          Flexible(
                                                                            child: Button.filled(
                                                                                onPressed: () {
                                                                                  Get.back();
                                                                                },
                                                                                label: 'Kembali'),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    );
                                                                  },
                                                                ),
                                                                PopupMenuItem(
                                                                  child:
                                                                      PopupMenuActionComponent(
                                                                    label:
                                                                        'Hapus',
                                                                  ),
                                                                  value: () {
                                                                    debugPrint(
                                                                        'Hapus');
                                                                  },
                                                                  onTap: () {
                                                                    showModalCenter(
                                                                      context,
                                                                      ShowModalTandaTanyaComponent(
                                                                        label:
                                                                            'Apakah anda yakin ingin menghapus data Dokter ?',
                                                                        onTapNo:
                                                                            () {
                                                                          Get.back();
                                                                        },
                                                                        onTapYes:
                                                                            () {},
                                                                      ),
                                                                    );
                                                                  },
                                                                ),
                                                              ],
                                                            ),
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
      },
    );
  }
}
