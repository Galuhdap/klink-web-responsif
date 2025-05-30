import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:klinik_web_responsif/core/components/input_data_component.dart';
import 'package:klinik_web_responsif/core/components/popup_menu_component.dart';
import 'package:klinik_web_responsif/core/components/search_new_component.dart';
import 'package:klinik_web_responsif/core/components/show_bottom_dialog.dart';
import 'package:klinik_web_responsif/core/components/show_center_dialog.dart';
import 'package:klinik_web_responsif/core/components/show_modal_right_component.dart';
import 'package:klinik_web_responsif/core/config/responsive.dart';
import 'package:klinik_web_responsif/core/resources/constans/app_constants.dart';
import 'package:klinik_web_responsif/core/styles/app_colors.dart';
import 'package:klinik_web_responsif/core/styles/app_sizes.dart';
import 'package:klinik_web_responsif/core/utils/extensions/date_ext.dart';
import 'package:klinik_web_responsif/core/utils/extensions/int_ext.dart';
import 'package:klinik_web_responsif/core/utils/extensions/sized_box_ext.dart';
import 'package:klinik_web_responsif/presentations/apotik/controller/apotik_controller.dart';
import 'package:klinik_web_responsif/presentations/menu_dashboard/widget/build_app_bar.dart';
import 'package:number_paginator/number_paginator.dart';

class RiwayatTransaksiScreen extends StatelessWidget {
  const RiwayatTransaksiScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                        Obx(() => Text(
                             controller.role.value == 'PEMILIK' ? 'Laporan Transaksi' : AppConstants.LABEL_RIWAYAT,
                              style: Get.textTheme.labelMedium!.copyWith(
                                  fontSize: AppSizes.s20,
                                  color: AppColors.colorBaseBlack,
                                  fontWeight: FontWeight.bold),
                            )),
                        Obx(() {
                          return controller.role.value == 'PEMILIK'
                              ? Flexible(
                                  child: InkWell(
                                    onTap: () {},
                                    child: Container(
                                      width: 134,
                                      height: 41,
                                      decoration: BoxDecoration(
                                        color: AppColors.colorBasePrimary,
                                        borderRadius:
                                            BorderRadius.circular(AppSizes.s4),
                                      ),
                                      child: Center(
                                        child: Text(
                                          'Cetak PDF',
                                          style: Get.textTheme.bodyMedium!
                                              .copyWith(
                                                  fontSize: AppSizes.s16,
                                                  color:
                                                      AppColors.colorBaseWhite),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              : Container();
                        })
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
                                String inv = '';

                                for (var part in parts) {
                                  // Asumsikan invoice mengandung angka atau pola khusus seperti 'INV'
                                  final isInvoice =
                                      RegExp(r'\d').hasMatch(part) ||
                                          part.toUpperCase().contains('INV');

                                  if (isInvoice) {
                                    inv += '$part ';
                                  } else {
                                    name += '$part ';
                                  }
                                }

                                name = name.trim();
                                inv = inv.trim();

                                controller.getTransaction(
                                  name: name,
                                  inv: inv,
                                );
                              },
                            ),
                          ),
                        ),
                        // AppSizes.s17.width,
                        // Container(
                        //   width: 50,
                        //   height: 50,
                        //   decoration: BoxDecoration(
                        //     borderRadius: BorderRadius.circular(AppSizes.s4),
                        //     border: Border.all(color: Color(0xfffF0F0F0)),
                        //     color: AppColors.colorBaseWhite,
                        //     boxShadow: [
                        //       BoxShadow(
                        //         offset: const Offset(0, 0),
                        //         blurRadius: 15,
                        //         spreadRadius: 0,
                        //         color: AppColors.colorNeutrals300.withAlpha(40),
                        //       ),
                        //     ],
                        //   ),
                        //   child: Center(
                        //     child: Icon(
                        //       Iconsax.filter,
                        //       color: AppColors.colorSecondary500,
                        //     ),
                        //   ),
                        // ),
                        if (Responsive.isDesktop(context)) ...[
                          AppSizes.s17.width,
                          Container(
                            width: 281,
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
                            child: Row(
                              spacing: 20,
                              children: [
                                AppSizes.s10.width,
                                Icon(Icons.calendar_month_rounded),
                                Text(
                                  'Februari 2024',
                                  style: Get.textTheme.labelMedium!.copyWith(
                                    fontSize: AppSizes.s16,
                                    color: AppColors.colorBaseBlack,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ],
                    ),
                    if (Responsive.isMobile(context)) ...[
                      AppSizes.s10.height,
                      Container(
                        width: double.infinity,
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
                        child: Row(
                          spacing: 20,
                          children: [
                            AppSizes.s10.width,
                            Icon(Icons.calendar_month_rounded),
                            Text(
                              'Februari 2024',
                              style: Get.textTheme.labelMedium!.copyWith(
                                fontSize: AppSizes.s16,
                                color: AppColors.colorBaseBlack,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              Obx(
                () {
                  return Expanded(
                    child: Container(
                      width: double.infinity,
                      height: 500,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(AppSizes.s4),
                        color: AppColors.colorBaseWhite,
                      ),
                      child: controller.isLoadingTransaction.value
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : controller.transactionList.isEmpty
                              ? Center(
                                  child: Text('Pasien Tidak Ditemukan'),
                                )
                              : ListView(
                                  padding: AppSizes.symmetricPadding(
                                    horizontal: AppSizes.s30,
                                  ),
                                  children: [
                                    SingleChildScrollView(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 20.0),
                                      scrollDirection: Axis.horizontal,
                                      child: Center(
                                        child: Theme(
                                          data: Theme.of(context).copyWith(
                                              dividerColor: Colors.transparent),
                                          child: DataTable(
                                            dividerThickness: 0.0,
                                            dataRowMinHeight: 20.0,
                                            dataRowMaxHeight: 50.0,
                                            columns: [
                                              DataColumn(
                                                label: Text(
                                                  AppConstants.LABEL_NO,
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
                                                    left: MediaQuery.of(context)
                                                            .size
                                                            .width *
                                                        0.02,
                                                    right:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.04,
                                                  ),
                                                  child: Text(
                                                    AppConstants
                                                        .LABEL_NO_REKAM_MEDIS,
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
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                      left:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.02,
                                                    ),
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
                                              ),
                                              DataColumn(
                                                label: Padding(
                                                  padding: EdgeInsets.only(
                                                    left: MediaQuery.of(context)
                                                            .size
                                                            .width *
                                                        0.02,
                                                  ),
                                                  child: Text(
                                                    AppConstants.LABEL_NOMINAL,
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
                                                label: Padding(
                                                  padding: EdgeInsets.only(
                                                    left: MediaQuery.of(context)
                                                            .size
                                                            .width *
                                                        0.025,
                                                  ),
                                                  child: Text(
                                                    AppConstants
                                                        .LABEL_TANGGAL_TRANSAKI,
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
                                                label: Padding(
                                                  padding: EdgeInsets.only(
                                                    left: Responsive.isMobile(
                                                            context)
                                                        ? MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.09
                                                        : MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.04,
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      AppConstants
                                                          .LABEL_INVOICE,
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
                                              ),
                                              DataColumn(
                                                label: Padding(
                                                  padding: EdgeInsets.only(
                                                    left: Responsive.isMobile(
                                                            context)
                                                        ? MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.09
                                                        : MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.04,
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      'Petugas Apotik',
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
                                              ),
                                              DataColumn(
                                                label: Padding(
                                                  padding: EdgeInsets.only(
                                                    left: MediaQuery.of(context)
                                                            .size
                                                            .width *
                                                        0.02,
                                                  ),
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
                                            rows:
                                                controller.isLoadingTransaction
                                                        .value
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
                                                    : controller.transactionList
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
                                                            .transactionList
                                                            .asMap()
                                                            .entries
                                                            .map((entry) {
                                                            final index =
                                                                entry.key;
                                                            final patient =
                                                                entry.value;
                                                            return DataRow(
                                                              cells: [
                                                                DataCell(
                                                                  Center(
                                                                    child: Text(
                                                                      '${index + 1}',
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
                                                                          0.03,
                                                                    ),
                                                                    child: Text(
                                                                      patient
                                                                          .rekamMedis
                                                                          .pasien
                                                                          .noRekamMedis,
                                                                      style: Get
                                                                          .textTheme
                                                                          .labelLarge!
                                                                          .copyWith(
                                                                        fontSize:
                                                                            AppSizes.s16,
                                                                      ),
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
                                                                          0.02,
                                                                      right: MediaQuery.of(context)
                                                                              .size
                                                                              .width *
                                                                          0.1,
                                                                    ),
                                                                    child: Text(
                                                                      patient
                                                                          .rekamMedis
                                                                          .pasien
                                                                          .name,
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
                                                                          0.02,
                                                                    ),
                                                                    child: Text(
                                                                      patient
                                                                          .nominalPayment
                                                                          .currencyFormatRp,
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
                                                                      left: Responsive.isMobile(
                                                                              context)
                                                                          ? MediaQuery.of(context).size.width *
                                                                              0.06
                                                                          : MediaQuery.of(context).size.width *
                                                                              0.04,
                                                                    ),
                                                                    child: Text(
                                                                      patient
                                                                          .createdAt
                                                                          .toDateddmmmyyyyFormattedString(),
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
                                                                          0.02,
                                                                    ),
                                                                    child:
                                                                        Center(
                                                                      child:
                                                                          Text(
                                                                        patient
                                                                            .invoice,
                                                                        style: const TextStyle(
                                                                            fontWeight:
                                                                                FontWeight.bold),
                                                                      ),
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
                                                                          0.02,
                                                                    ),
                                                                    child:
                                                                        Center(
                                                                      child:
                                                                          Text(
                                                                        patient
                                                                            .user
                                                                            .name,
                                                                        style: const TextStyle(
                                                                            fontWeight:
                                                                                FontWeight.bold),
                                                                      ),
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
                                                                          0.02,
                                                                    ),
                                                                    child: Responsive.isMobile(
                                                                            context)
                                                                        ? IconButton(
                                                                            onPressed:
                                                                                () {
                                                                              showModalBottom(
                                                                                  context,
                                                                                  Column(
                                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                                    children: [
                                                                                      AppSizes.s8.height,
                                                                                      Center(
                                                                                        child: Container(
                                                                                          width: AppSizes.s56,
                                                                                          height: AppSizes.s4,
                                                                                          decoration: BoxDecoration(
                                                                                            borderRadius: BorderRadius.circular(AppSizes.s8),
                                                                                            color: AppColors.colorNeutrals100,
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                      AppSizes.s11.height,
                                                                                      Column(
                                                                                        spacing: 24,
                                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                                        children: [
                                                                                          InkWell(
                                                                                            onTap: () {
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
                                                                                                              'Detail Transaksi',
                                                                                                              style: Get.textTheme.labelMedium!.copyWith(fontWeight: FontWeight.bold, fontSize: AppSizes.s24),
                                                                                                            ),
                                                                                                          ],
                                                                                                        ),
                                                                                                        Divider(),
                                                                                                        AppSizes.s30.height,
                                                                                                        InputDataComponent(
                                                                                                          label: 'Invoice',
                                                                                                          hintText: patient.invoice,
                                                                                                          controller: TextEditingController(),
                                                                                                          readOnly: true,
                                                                                                        ),
                                                                                                        InputDataComponent(
                                                                                                          label: 'No Rekam Medis',
                                                                                                          hintText: patient.rekamMedis.pasien.noRekamMedis,
                                                                                                          controller: TextEditingController(),
                                                                                                          readOnly: true,
                                                                                                        ),
                                                                                                        InputDataComponent(
                                                                                                          label: 'Nama Pasien',
                                                                                                          hintText: patient.rekamMedis.pasien.name,
                                                                                                          controller: TextEditingController(),
                                                                                                          readOnly: true,
                                                                                                        ),
                                                                                                        InputDataComponent(
                                                                                                          label: 'Alamat',
                                                                                                          hintText: patient.rekamMedis.pasien.alamat,
                                                                                                          controller: TextEditingController(),
                                                                                                          readOnly: true,
                                                                                                        ),
                                                                                                        InputDataComponent(
                                                                                                          label: 'Tanggal Transaksi',
                                                                                                          hintText: patient.createdAt.toDateddmmmyyyyFormattedString(),
                                                                                                          controller: TextEditingController(),
                                                                                                          readOnly: true,
                                                                                                        ),
                                                                                                        InputDataComponent(
                                                                                                          label: 'Keluhan',
                                                                                                          hintText: patient.rekamMedis.keluhan,
                                                                                                          controller: TextEditingController(),
                                                                                                          readOnly: true,
                                                                                                        ),
                                                                                                        InputDataComponent(
                                                                                                          label: 'Petugas Apotik',
                                                                                                          hintText: patient.user.name,
                                                                                                          controller: TextEditingController(),
                                                                                                          readOnly: true,
                                                                                                        ),
                                                                                                        // Column(
                                                                                                        //   crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                        //   children: [
                                                                                                        //     Text(
                                                                                                        //       AppConstants.LABEL_TERAPI_TINDAKAN,
                                                                                                        //       style: Get.textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w700, fontSize: AppSizes.s14, color: AppColors.colorBaseBlack),
                                                                                                        //     ),
                                                                                                        //     AppSizes.s12.height,
                                                                                                        //     Container(
                                                                                                        //       padding: AppSizes.symmetricPadding(
                                                                                                        //         vertical: AppSizes.s20,
                                                                                                        //         horizontal: AppSizes.s12,
                                                                                                        //       ),
                                                                                                        //       width: double.infinity,
                                                                                                        //       decoration: BoxDecoration(
                                                                                                        //         color: Color(0xfffF6F7FB),
                                                                                                        //         borderRadius: BorderRadius.circular(AppSizes.s4),
                                                                                                        //       ),
                                                                                                        //       child: Text(
                                                                                                        //         'Paracetamol 2x sehari\nUltraflu 2x Sehari',
                                                                                                        //         style: Get.textTheme.bodyMedium!.copyWith(
                                                                                                        //           fontSize: AppSizes.s14,
                                                                                                        //           color: AppColors.colorBaseBlack,
                                                                                                        //         ),
                                                                                                        //       ),
                                                                                                        //     )
                                                                                                        //   ],
                                                                                                        // ),
                                                                                                        // AppSizes.s31.height,
                                                                                                        // Column(
                                                                                                        //   crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                        //   children: [
                                                                                                        //     Text(
                                                                                                        //       AppConstants.LABEL_OBAT,
                                                                                                        //       style: Get.textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w700, fontSize: AppSizes.s14, color: AppColors.colorBaseBlack),
                                                                                                        //     ),
                                                                                                        //     AppSizes.s12.height,
                                                                                                        //     SizedBox(
                                                                                                        //       width: double.infinity,
                                                                                                        //       height: AppSizes.setResponsiveHeight(context) * 0.23,
                                                                                                        //       child: ListView.builder(
                                                                                                        //         itemCount: 3,
                                                                                                        //         itemBuilder: (BuildContext context, index) {
                                                                                                        //           return Row(
                                                                                                        //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                                        //             children: [
                                                                                                        //               Text(
                                                                                                        //                 'Paracetamol',
                                                                                                        //                 style: Get.textTheme.bodyMedium!.copyWith(
                                                                                                        //                   fontSize: AppSizes.s15,
                                                                                                        //                   color: AppColors.colorBaseBlack,
                                                                                                        //                 ),
                                                                                                        //               ),
                                                                                                        //               Row(
                                                                                                        //                 spacing: 10,
                                                                                                        //                 children: [
                                                                                                        //                   Text(
                                                                                                        //                     '1',
                                                                                                        //                     style: Get.textTheme.bodyMedium!.copyWith(
                                                                                                        //                       fontSize: AppSizes.s14,
                                                                                                        //                       fontWeight: FontWeight.w500,
                                                                                                        //                       color: AppColors.colorBaseBlack,
                                                                                                        //                     ),
                                                                                                        //                   ),
                                                                                                        //                   Text(
                                                                                                        //                     'Tablet',
                                                                                                        //                     style: Get.textTheme.bodyMedium!.copyWith(
                                                                                                        //                       fontSize: AppSizes.s14,
                                                                                                        //                       fontWeight: FontWeight.w500,
                                                                                                        //                       color: AppColors.colorBaseBlack,
                                                                                                        //                     ),
                                                                                                        //                   ),
                                                                                                        //                 ],
                                                                                                        //               )
                                                                                                        //             ],
                                                                                                        //           ).paddingOnly(bottom: AppSizes.s10);
                                                                                                        //         },
                                                                                                        //       ),
                                                                                                        //     ),
                                                                                                        //   ],
                                                                                                        // ),
                                                                                                        Row(
                                                                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                                          children: [
                                                                                                            Text(
                                                                                                              'Total Pembayaran',
                                                                                                              style: Get.textTheme.bodyMedium!.copyWith(
                                                                                                                fontSize: AppSizes.s20,
                                                                                                                fontWeight: FontWeight.bold,
                                                                                                                color: AppColors.colorBaseBlack,
                                                                                                              ),
                                                                                                            ),
                                                                                                            Text(
                                                                                                              patient.nominalPayment.currencyFormatRp,
                                                                                                              style: Get.textTheme.bodyMedium!.copyWith(
                                                                                                                fontSize: AppSizes.s20,
                                                                                                                fontWeight: FontWeight.bold,
                                                                                                                color: AppColors.colorBaseBlack,
                                                                                                              ),
                                                                                                            ),
                                                                                                          ],
                                                                                                        )
                                                                                                      ],
                                                                                                    ),
                                                                                                  ],
                                                                                                ),
                                                                                              );
                                                                                            },
                                                                                            child: Text(
                                                                                              'Detail',
                                                                                              style: Get.textTheme.labelLarge!.copyWith(
                                                                                                fontSize: AppSizes.s14,
                                                                                                color: AppColors.colorBaseBlack,
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                        ],
                                                                                      ).paddingOnly(
                                                                                        left: AppSizes.s24,
                                                                                        bottom: AppSizes.s20,
                                                                                      ),
                                                                                    ],
                                                                                  ));
                                                                            },
                                                                            icon:
                                                                                Icon(
                                                                              Icons.more_horiz,
                                                                              size: 24,
                                                                              color: Color(0xfff828282),
                                                                            ),
                                                                          )
                                                                        : Center(
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
                                                                                PopupMenuItem(
                                                                                  child: PopupMenuActionComponent(
                                                                                    label: 'Detail',
                                                                                  ),
                                                                                  value: () {
                                                                                    debugPrint('Detial');
                                                                                  },
                                                                                  onTap: () {
                                                                                    showRightModal(
                                                                                      context,
                                                                                      Row(
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
                                                                                                      'Detail Transaksi',
                                                                                                      style: Get.textTheme.labelMedium!.copyWith(fontWeight: FontWeight.bold, fontSize: AppSizes.s24),
                                                                                                    ),
                                                                                                  ],
                                                                                                ),
                                                                                                Divider(),
                                                                                                AppSizes.s48.height,
                                                                                                InputDataComponent(
                                                                                                  label: 'Invoice',
                                                                                                  hintText: patient.invoice,
                                                                                                  controller: TextEditingController(),
                                                                                                  readOnly: true,
                                                                                                ),
                                                                                                InputDataComponent(
                                                                                                  label: 'No Rekam Medis',
                                                                                                  hintText: patient.rekamMedis.pasien.noRekamMedis,
                                                                                                  controller: TextEditingController(),
                                                                                                  readOnly: true,
                                                                                                ),
                                                                                                InputDataComponent(
                                                                                                  label: 'Nama Pasien',
                                                                                                  hintText: patient.rekamMedis.pasien.name,
                                                                                                  controller: TextEditingController(),
                                                                                                  readOnly: true,
                                                                                                ),
                                                                                                InputDataComponent(
                                                                                                  label: 'Alamat',
                                                                                                  hintText: patient.rekamMedis.pasien.alamat,
                                                                                                  controller: TextEditingController(),
                                                                                                  readOnly: true,
                                                                                                ),
                                                                                                InputDataComponent(
                                                                                                  label: 'Tanggal Transaksi',
                                                                                                  hintText: patient.createdAt.toDateddmmmyyyyFormattedString(),
                                                                                                  controller: TextEditingController(),
                                                                                                  readOnly: true,
                                                                                                ),
                                                                                                InputDataComponent(
                                                                                                  label: 'Keluhan',
                                                                                                  hintText: patient.rekamMedis.keluhan,
                                                                                                  controller: TextEditingController(),
                                                                                                  readOnly: true,
                                                                                                ),
                                                                                              ],
                                                                                            ),
                                                                                          ),
                                                                                          AppSizes.s46.width,
                                                                                          Flexible(
                                                                                            child: Column(
                                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                                              children: [
                                                                                                105.height,
                                                                                                InputDataComponent(
                                                                                                  label: 'Petugas Apotik',
                                                                                                  hintText: patient.user.name,
                                                                                                  controller: TextEditingController(),
                                                                                                  readOnly: true,
                                                                                                ),
                                                                                                // Column(
                                                                                                //   crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                //   children: [
                                                                                                //     Text(
                                                                                                //       AppConstants.LABEL_TERAPI_TINDAKAN,
                                                                                                //       style: Get.textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w700, fontSize: AppSizes.s14, color: AppColors.colorBaseBlack),
                                                                                                //     ),
                                                                                                //     AppSizes.s12.height,
                                                                                                //     Container(
                                                                                                //       padding: AppSizes.symmetricPadding(
                                                                                                //         vertical: AppSizes.s20,
                                                                                                //         horizontal: AppSizes.s12,
                                                                                                //       ),
                                                                                                //       width: double.infinity,
                                                                                                //       decoration: BoxDecoration(
                                                                                                //         color: Color(0xfffF6F7FB),
                                                                                                //         borderRadius: BorderRadius.circular(AppSizes.s4),
                                                                                                //       ),
                                                                                                //       child: Text(
                                                                                                //         'Paracetamol 2x sehari\nUltraflu 2x Sehari',
                                                                                                //         style: Get.textTheme.bodyMedium!.copyWith(
                                                                                                //           fontSize: AppSizes.s14,
                                                                                                //           color: AppColors.colorBaseBlack,
                                                                                                //         ),
                                                                                                //       ),
                                                                                                //     )
                                                                                                //   ],
                                                                                                // ),
                                                                                                // AppSizes.s31.height,
                                                                                                // Column(
                                                                                                //   crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                //   children: [
                                                                                                //     Text(
                                                                                                //       AppConstants.LABEL_OBAT,
                                                                                                //       style: Get.textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w700, fontSize: AppSizes.s14, color: AppColors.colorBaseBlack),
                                                                                                //     ),
                                                                                                //     AppSizes.s12.height,
                                                                                                //     SizedBox(
                                                                                                //       width: double.infinity,
                                                                                                //       height: AppSizes.setResponsiveHeight(context) * 0.23,
                                                                                                //       child: ListView.builder(
                                                                                                //         itemCount: 3,
                                                                                                //         itemBuilder: (BuildContext context, index) {
                                                                                                //           return Row(
                                                                                                //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                                //             children: [
                                                                                                //               Text(
                                                                                                //                 'Paracetamol',
                                                                                                //                 style: Get.textTheme.bodyMedium!.copyWith(
                                                                                                //                   fontSize: AppSizes.s15,
                                                                                                //                   color: AppColors.colorBaseBlack,
                                                                                                //                 ),
                                                                                                //               ),
                                                                                                //               Row(
                                                                                                //                 spacing: 10,
                                                                                                //                 children: [
                                                                                                //                   Text(
                                                                                                //                     '1',
                                                                                                //                     style: Get.textTheme.bodyMedium!.copyWith(
                                                                                                //                       fontSize: AppSizes.s14,
                                                                                                //                       fontWeight: FontWeight.w500,
                                                                                                //                       color: AppColors.colorBaseBlack,
                                                                                                //                     ),
                                                                                                //                   ),
                                                                                                //                   Text(
                                                                                                //                     'Tablet',
                                                                                                //                     style: Get.textTheme.bodyMedium!.copyWith(
                                                                                                //                       fontSize: AppSizes.s14,
                                                                                                //                       fontWeight: FontWeight.w500,
                                                                                                //                       color: AppColors.colorBaseBlack,
                                                                                                //                     ),
                                                                                                //                   ),
                                                                                                //                 ],
                                                                                                //               )
                                                                                                //             ],
                                                                                                //           ).paddingOnly(bottom: AppSizes.s10);
                                                                                                //         },
                                                                                                //       ),
                                                                                                //     ),
                                                                                                //   ],
                                                                                                // ),
                                                                                                Row(
                                                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                                  children: [
                                                                                                    Text(
                                                                                                      'Total Pembayaran',
                                                                                                      style: Get.textTheme.bodyMedium!.copyWith(
                                                                                                        fontSize: AppSizes.s20,
                                                                                                        fontWeight: FontWeight.bold,
                                                                                                        color: AppColors.colorBaseBlack,
                                                                                                      ),
                                                                                                    ),
                                                                                                    Text(
                                                                                                      patient.nominalPayment.currencyFormatRp,
                                                                                                      style: Get.textTheme.bodyMedium!.copyWith(
                                                                                                        fontSize: AppSizes.s20,
                                                                                                        fontWeight: FontWeight.bold,
                                                                                                        color: AppColors.colorBaseBlack,
                                                                                                      ),
                                                                                                    ),
                                                                                                  ],
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
                                                                                  },
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                  ),
                                                                ),
                                                              ],
                                                            );
                                                          }).toList(),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                    ),
                  );
                },
              ),
              Obx(
                () {
                  return controller.numberOfPageTransaction.value < 1
                      ? Container()
                      : Container(
                          width: double.infinity,
                          padding: AppSizes.symmetricPadding(
                              vertical: AppSizes.s20, horizontal: AppSizes.s41),
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
                                  numberPages: controller.numberOfPage.value,
                                  onPageChange: (int index) {
                                    final page = index + 1;
                                    controller.getTransaction(page: page);
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
          ),
        );
      },
    );
  }
}
