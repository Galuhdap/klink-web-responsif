import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:klinik_web_responsif/core/assets/assets.gen.dart';
import 'package:klinik_web_responsif/core/components/button_component.dart';
import 'package:klinik_web_responsif/core/components/input_data_component.dart';
import 'package:klinik_web_responsif/core/components/modal/show_modal_tanda_tanya_component.dart';
import 'package:klinik_web_responsif/core/components/popup_menu_component.dart';
import 'package:klinik_web_responsif/core/components/search_new_component.dart';
import 'package:klinik_web_responsif/core/components/show_bottom_dialog.dart';
import 'package:klinik_web_responsif/core/components/show_center_dialog.dart';
import 'package:klinik_web_responsif/core/components/status_docter_aktif_component.dart';
import 'package:klinik_web_responsif/core/config/responsive.dart';
import 'package:klinik_web_responsif/core/resources/constans/app_constants.dart';
import 'package:klinik_web_responsif/core/styles/app_colors.dart';
import 'package:klinik_web_responsif/core/styles/app_sizes.dart';
import 'package:klinik_web_responsif/core/utils/extensions/date_ext.dart';
import 'package:klinik_web_responsif/core/utils/extensions/sized_box_ext.dart';
import 'package:klinik_web_responsif/presentations/apotik/controller/apotik_controller.dart';
import 'package:klinik_web_responsif/presentations/menu_dashboard/widget/build_app_bar.dart';
import 'package:klinik_web_responsif/services/apotik/model/request/post_medicine_request.dart';
import 'package:lottie/lottie.dart';

class ObatScreen extends StatelessWidget {
  const ObatScreen({super.key});

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
              isMake: true,
              labelButton: 'Tambah Obat',
              onTapButton: () {
                showModalCenter(
                  context,
                  Obx(
                    () {
                      return controller.isLoadingPostMeicine.value
                          ? Center(
                              child: SizedBox(
                                width: 400,
                                height: 400,
                                child: Lottie.asset(Assets.lottie.hospital),
                              ),
                            )
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Center(
                                  child: Text(
                                    'Tambah Obat',
                                    style: Get.textTheme.labelMedium!.copyWith(
                                        fontWeight: FontWeight.bold,
                                        fontSize: AppSizes.s16),
                                  ),
                                ),
                                AppSizes.s12.height,
                                Divider(),
                                InputDataComponent(
                                  label: 'Nama Obat',
                                  hintText: 'Nama Obat',
                                  controller: controller.nameObatController,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Tgl Kadaluarsa',
                                      style: Get.textTheme.bodyMedium!.copyWith(
                                          fontWeight: FontWeight.w700,
                                          fontSize: AppSizes.s14,
                                          color: AppColors.colorBaseBlack),
                                    ),
                                    AppSizes.s12.height,
                                    InkWell(
                                      onTap: () async {
                                        //final DateTime? pickedDate =
                                        final DateTime? pickedDate =
                                            await showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime.now(),
                                          lastDate: DateTime(
                                              2045), // ⛔ hanya sampai hari ini, tidak bisa pilih besok
                                        );
                                        if (pickedDate != null) {
                                          controller.tglKadalursaController
                                              .value = pickedDate;
                                        }
                                      },
                                      child: Obx(
                                        () {
                                          return Container(
                                            padding: AppSizes.symmetricPadding(
                                                vertical: AppSizes.s5,
                                                horizontal: AppSizes.s20),
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color:
                                                    AppColors.colorSecondary400,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      AppSizes.s4),
                                            ),
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.calendar_month,
                                                  weight: AppSizes.s20,
                                                  size: AppSizes.s30,
                                                  color: AppColors
                                                      .colorNeutrals100,
                                                ),
                                                AppSizes.s10.width,
                                                Text(
                                                  controller
                                                      .tglKadalursaController
                                                      .value
                                                      .toDateyyyymmddFormattedString(),
                                                  style: Get
                                                      .textTheme.bodySmall!
                                                      .copyWith(
                                                    fontSize: AppSizes.s14,
                                                    color: AppColors
                                                        .colorNeutrals400,
                                                  ),
                                                ),
                                              ],
                                            ).paddingSymmetric(
                                                vertical: AppSizes.s5),
                                          );
                                        },
                                      ),
                                    ),
                                    AppSizes.s12.height,
                                  ],
                                ),
                                InputDataComponent(
                                  label: 'Stock Obat',
                                  hintText: 'Stock Obat',
                                  controller: controller.stockController,
                                ),
                                Row(
                                  children: [
                                    Flexible(
                                      child: Button.outlined(
                                          onPressed: () {
                                            Get.back();
                                          },
                                          label: 'Batal'),
                                    ),
                                    AppSizes.s12.width,
                                    Flexible(
                                      child: Button.filled(
                                          onPressed: () async {
                                            String isoUtc = controller
                                                .tglKadalursaController.value
                                                .toUtc()
                                                .toIso8601String();

                                            print(isoUtc);
                                            var data = PostMedicineRequest(
                                                namaObat: controller
                                                    .nameObatController.text,
                                                tglKadaluarsa: isoUtc,
                                                stock: int.parse(controller
                                                    .stockController.text),
                                                statusObat: "ACTIVE");
                                            await controller.postMedicine(
                                                data: data);
                                          },
                                          label: 'Simpan'),
                                    ),
                                  ],
                                )
                              ],
                            ).paddingSymmetric(horizontal: AppSizes.s100);
                    },
                  ),
                );
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
                          AppConstants.LABEL_DATA_OBAT,
                          style: Get.textTheme.labelMedium!.copyWith(
                              fontSize: AppSizes.s16,
                              color: AppColors.colorBaseBlack,
                              fontWeight: FontWeight.bold),
                        ),
                        Responsive.isMobile(context)
                            ? InkWell(
                                onTap: () {
                                  showModalCenter(
                                    context,
                                    Obx(
                                      () {
                                        return controller
                                                .isLoadingPostMeicine.value
                                            ? Center(
                                                child: SizedBox(
                                                  width: 400,
                                                  height: 400,
                                                  child: Lottie.asset(
                                                      Assets.lottie.hospital),
                                                ),
                                              )
                                            : Column(
                                                // crossAxisAlignment:
                                                //     CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Center(
                                                    child: Text(
                                                      'Tambah Obat',
                                                      style: Get.textTheme
                                                          .labelMedium!
                                                          .copyWith(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize:
                                                                  AppSizes.s16),
                                                    ),
                                                  ),
                                                  AppSizes.s12.height,
                                                  Divider(),
                                                  InputDataComponent(
                                                    label: 'Nama Obat',
                                                    hintText: 'Nama Obat',
                                                    controller: controller
                                                        .nameObatController,
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        'Tgl Kadaluarsa',
                                                        style: Get.textTheme
                                                            .bodyMedium!
                                                            .copyWith(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                fontSize:
                                                                    AppSizes
                                                                        .s14,
                                                                color: AppColors
                                                                    .colorBaseBlack),
                                                      ),
                                                      AppSizes.s12.height,
                                                      InkWell(
                                                        onTap: () async {
                                                          //final DateTime? pickedDate =
                                                          final DateTime?
                                                              pickedDate =
                                                              await showDatePicker(
                                                            context: context,
                                                            initialDate:
                                                                DateTime.now(),
                                                            firstDate:
                                                                DateTime.now(),
                                                            lastDate: DateTime(
                                                                2045), // ⛔ hanya sampai hari ini, tidak bisa pilih besok
                                                          );
                                                          if (pickedDate !=
                                                              null) {
                                                            controller
                                                                .tglKadalursaController
                                                                .value = pickedDate;
                                                          }
                                                        },
                                                        child: Obx(
                                                          () {
                                                            return Container(
                                                              padding: AppSizes
                                                                  .symmetricPadding(
                                                                      vertical:
                                                                          AppSizes
                                                                              .s5,
                                                                      horizontal:
                                                                          AppSizes
                                                                              .s20),
                                                              decoration:
                                                                  BoxDecoration(
                                                                border:
                                                                    Border.all(
                                                                  color: AppColors
                                                                      .colorSecondary400,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius.circular(
                                                                        AppSizes
                                                                            .s4),
                                                              ),
                                                              child: Row(
                                                                children: [
                                                                  Icon(
                                                                    Icons
                                                                        .calendar_month,
                                                                    weight:
                                                                        AppSizes
                                                                            .s20,
                                                                    size:
                                                                        AppSizes
                                                                            .s30,
                                                                    color: AppColors
                                                                        .colorNeutrals100,
                                                                  ),
                                                                  AppSizes.s10
                                                                      .width,
                                                                  Text(
                                                                    controller
                                                                        .tglKadalursaController
                                                                        .value
                                                                        .toDateyyyymmddFormattedString(),
                                                                    style: Get
                                                                        .textTheme
                                                                        .bodySmall!
                                                                        .copyWith(
                                                                      fontSize:
                                                                          AppSizes
                                                                              .s14,
                                                                      color: AppColors
                                                                          .colorNeutrals400,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ).paddingSymmetric(
                                                                  vertical:
                                                                      AppSizes
                                                                          .s5),
                                                            );
                                                          },
                                                        ),
                                                      ),
                                                      AppSizes.s12.height,
                                                    ],
                                                  ),
                                                  InputDataComponent(
                                                    label: 'Stock Obat',
                                                    hintText: 'Stock Obat',
                                                    controller: controller
                                                        .stockController,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Flexible(
                                                        child: Button.outlined(
                                                            onPressed: () {
                                                              Get.back();
                                                            },
                                                            label: 'Batal'),
                                                      ),
                                                      AppSizes.s12.width,
                                                      Flexible(
                                                        child: Button.filled(
                                                            onPressed:
                                                                () async {
                                                              String isoUtc = controller
                                                                  .tglKadalursaController
                                                                  .value
                                                                  .toUtc()
                                                                  .toIso8601String();
                                                              print(isoUtc);
                                                              var data = PostMedicineRequest(
                                                                  namaObat:
                                                                      controller
                                                                          .nameObatController
                                                                          .text,
                                                                  tglKadaluarsa:
                                                                      isoUtc,
                                                                  stock: int.parse(
                                                                      controller
                                                                          .stockController
                                                                          .text),
                                                                  statusObat:
                                                                      "ACTIVE");
                                                              await controller
                                                                  .postMedicine(
                                                                      data:
                                                                          data);
                                                            },
                                                            label: 'Simpan'),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              );
                                      },
                                    ),
                                  );
                                },
                                child: Container(
                                  width: 97,
                                  height: 26,
                                  decoration: BoxDecoration(
                                    color: AppColors.colorBasePrimary,
                                    borderRadius:
                                        BorderRadius.circular(AppSizes.s4),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Tambah Obat',
                                      style: Get.textTheme.bodyMedium!.copyWith(
                                          fontSize: AppSizes.s10,
                                          color: AppColors.colorBaseWhite),
                                    ),
                                  ),
                                ),
                              )
                            : Container(),
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
                                final name = value.trim();
                                controller.getMedicine(nama_obat: name);
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
                      ],
                    ),
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
                      child: controller.isLoading.value
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : controller.medicineList.isEmpty
                              ? Center(
                                  child: Text('Obat Tidak Ditemukan'),
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
                                                  ),
                                                  child: Text(
                                                    AppConstants
                                                        .LABEL_NAMA_OBAT,
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
                                                              0.1,
                                                    ),
                                                    child: Text(
                                                      AppConstants
                                                          .LABEL_TGL_KADALUARSA,
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
                                                        0.08,
                                                  ),
                                                  child: Text(
                                                    AppConstants.LABEL_STOCK,
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
                                                        0.05,
                                                  ),
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
                                                : controller
                                                        .medicineList.isEmpty
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
                                                    : controller.medicineList
                                                        .asMap()
                                                        .entries
                                                        .map(
                                                        (entry) {
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
                                                                        0.02,
                                                                    right: MediaQuery.of(context)
                                                                            .size
                                                                            .width *
                                                                        0.04,
                                                                  ),
                                                                  child: Text(
                                                                    patient
                                                                        .namaObat,
                                                                    style: Get
                                                                        .textTheme
                                                                        .labelLarge!
                                                                        .copyWith(
                                                                      fontSize:
                                                                          AppSizes
                                                                              .s16,
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
                                                                        0.1,
                                                                  ),
                                                                  child: Center(
                                                                    child: Text(
                                                                      patient
                                                                          .tglKadaluarsa
                                                                          .toDateddmmmyyyyFormattedString(),
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
                                                                        0.08,
                                                                  ),
                                                                  child: Center(
                                                                    child: Text(
                                                                      patient
                                                                          .stock
                                                                          .toString(),
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
                                                                        0.03,
                                                                  ),
                                                                  child:
                                                                      StatusDoctorAktifComponent(
                                                                    status: patient
                                                                        .statusObat,
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
                                                                  child: Responsive
                                                                          .isMobile(
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
                                                                                              Obx(
                                                                                                () {
                                                                                                  return Form(
                                                                                                    key: controller.formKey,
                                                                                                    child: Column(
                                                                                                      // crossAxisAlignment:
                                                                                                      //     CrossAxisAlignment.start,
                                                                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                                                                      children: [
                                                                                                        Center(
                                                                                                          child: Text(
                                                                                                            controller.readOnly.value ? 'Detail' : 'Edit Obat',
                                                                                                            style: Get.textTheme.labelMedium!.copyWith(fontWeight: FontWeight.bold, fontSize: AppSizes.s28),
                                                                                                          ),
                                                                                                        ),
                                                                                                        AppSizes.s12.height,
                                                                                                        Divider(),
                                                                                                        InputDataComponent(
                                                                                                          label: 'Nama Obat',
                                                                                                          hintText: patient.namaObat,
                                                                                                          controller: controller.nameObatController,
                                                                                                          readOnly: controller.readOnly.value,
                                                                                                        ),
                                                                                                        Column(
                                                                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                          children: [
                                                                                                            Text(
                                                                                                              'Tanggal Kadaluarsa',
                                                                                                              style: Get.textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w700, fontSize: AppSizes.s14, color: AppColors.colorBaseBlack),
                                                                                                            ),
                                                                                                            AppSizes.s12.height,
                                                                                                            InkWell(
                                                                                                              onTap: controller.readOnly.value
                                                                                                                  ? () {}
                                                                                                                  : () async {
                                                                                                                      final DateTime? pickedDate = await showDatePicker(
                                                                                                                        context: context,
                                                                                                                        initialDate: DateTime.now(),
                                                                                                                        firstDate: DateTime.now(),
                                                                                                                        lastDate: DateTime(2045), // ⛔ hanya sampai hari ini, tidak bisa pilih besok
                                                                                                                      );
                                                                                                                      if (pickedDate != null) {
                                                                                                                        controller.tglKadalursaController.value = pickedDate;
                                                                                                                      }
                                                                                                                    },
                                                                                                              child: Container(
                                                                                                                  padding: AppSizes.symmetricPadding(vertical: AppSizes.s5, horizontal: AppSizes.s20),
                                                                                                                  decoration: BoxDecoration(
                                                                                                                    border: Border.all(
                                                                                                                      color: AppColors.colorSecondary400,
                                                                                                                    ),
                                                                                                                    borderRadius: BorderRadius.circular(AppSizes.s4),
                                                                                                                  ),
                                                                                                                  child: Row(
                                                                                                                    children: [
                                                                                                                      Icon(
                                                                                                                        Icons.calendar_month,
                                                                                                                        weight: AppSizes.s20,
                                                                                                                        size: AppSizes.s30,
                                                                                                                        color: AppColors.colorNeutrals100,
                                                                                                                      ),
                                                                                                                      AppSizes.s10.width,
                                                                                                                      Text(
                                                                                                                        controller.readOnly.value ? patient.tglKadaluarsa.toDateyyyymmddFormattedString() : controller.tglKadalursaController.value.toDateyyyymmddFormattedString(),
                                                                                                                        style: Get.textTheme.bodySmall!.copyWith(
                                                                                                                          fontSize: AppSizes.s14,
                                                                                                                          color: AppColors.colorNeutrals400,
                                                                                                                        ),
                                                                                                                      ),
                                                                                                                    ],
                                                                                                                  ).paddingSymmetric(vertical: AppSizes.s5)),
                                                                                                            ),
                                                                                                            AppSizes.s12.height,
                                                                                                          ],
                                                                                                        ),
                                                                                                        InputDataComponent(
                                                                                                          label: 'Stock Obat',
                                                                                                          hintText: patient.stock.toString(),
                                                                                                          controller: controller.stockController,
                                                                                                          readOnly: controller.readOnly.value,
                                                                                                        ),
                                                                                                        controller.readOnly.value
                                                                                                            ? InputDataComponent(
                                                                                                                label: 'Status Obat',
                                                                                                                hintText: patient.statusObat == 'ACTIVE' ? 'Aktif' : 'Tidak Aktif',
                                                                                                                controller: TextEditingController(),
                                                                                                                readOnly: controller.readOnly.value,
                                                                                                              )
                                                                                                            : Column(
                                                                                                                children: [
                                                                                                                  Text(
                                                                                                                    'Ubah Status Obat',
                                                                                                                    style: Get.textTheme.labelMedium!.copyWith(
                                                                                                                      fontWeight: FontWeight.bold,
                                                                                                                      fontSize: AppSizes.s14,
                                                                                                                    ),
                                                                                                                  ),
                                                                                                                  AppSizes.s12.height,
                                                                                                                  patient.statusObat == 'ACTIVE'
                                                                                                                      ? Button.filled(
                                                                                                                          onPressed: () {
                                                                                                                            showModalCenter(
                                                                                                                              context,
                                                                                                                              ShowModalTandaTanyaComponent(
                                                                                                                                label: 'Apakah anda yakin untuk mengaktifkan Obat ?',
                                                                                                                                onTapNo: () {
                                                                                                                                  Get.back();
                                                                                                                                },
                                                                                                                                onTapYes: () {},
                                                                                                                              ),
                                                                                                                            );
                                                                                                                          },
                                                                                                                          color: AppColors.colorBaseError,
                                                                                                                          label: 'Nonaktifkan Obat')
                                                                                                                      : Button.filled(
                                                                                                                          onPressed: () {
                                                                                                                            showModalCenter(
                                                                                                                              context,
                                                                                                                              ShowModalTandaTanyaComponent(
                                                                                                                                label: 'Apakah anda yakin untuk menonaktifkan Obat ?',
                                                                                                                                onTapNo: () {
                                                                                                                                  Get.back();
                                                                                                                                },
                                                                                                                                onTapYes: () {},
                                                                                                                              ),
                                                                                                                            );
                                                                                                                          },
                                                                                                                          label: 'Aktifkan Obat',
                                                                                                                          color: AppColors.colorMenungguText,
                                                                                                                        ),
                                                                                                                ],
                                                                                                              ),
                                                                                                        AppSizes.s15.height,
                                                                                                        Row(
                                                                                                          children: [
                                                                                                            Flexible(
                                                                                                              child: Button.outlined(
                                                                                                                  onPressed: () {
                                                                                                                    var data = PostMedicineRequest(
                                                                                                                      namaObat: patient.namaObat,
                                                                                                                      tglKadaluarsa: patient.tglKadaluarsa.toString(),
                                                                                                                      stock: patient.stock,
                                                                                                                      statusObat: patient.statusObat,
                                                                                                                    );
                                                                                                                    controller.changeReadOnly(data);
                                                                                                                    controller.nameObatController.clear();
                                                                                                                    controller.tglKadalursaController.value = DateTime.now();
                                                                                                                    controller.stockController.clear();
                                                                                                                    Get.back();
                                                                                                                    Get.back();
                                                                                                                  },
                                                                                                                  label: 'Kembali'),
                                                                                                            ),
                                                                                                            AppSizes.s15.width,
                                                                                                            Flexible(
                                                                                                              child: Button.filled(
                                                                                                                  onPressed: controller.readOnly.value
                                                                                                                      ? () {
                                                                                                                          var data = PostMedicineRequest(
                                                                                                                            namaObat: patient.namaObat,
                                                                                                                            tglKadaluarsa: patient.tglKadaluarsa.toString(),
                                                                                                                            stock: patient.stock,
                                                                                                                            statusObat: patient.statusObat,
                                                                                                                          );
                                                                                                                          controller.changeReadOnly(data);
                                                                                                                        }
                                                                                                                      : () {
                                                                                                                          var data = PostMedicineRequest(
                                                                                                                            namaObat: patient.namaObat,
                                                                                                                            tglKadaluarsa: patient.tglKadaluarsa.toString(),
                                                                                                                            stock: patient.stock,
                                                                                                                            statusObat: patient.statusObat,
                                                                                                                          );
                                                                                                                          controller.changeReadOnly(data);
                                                                                                                        },
                                                                                                                  label: controller.readOnly.value ? 'Edit' : "Simpan"),
                                                                                                            ),
                                                                                                          ],
                                                                                                        ).paddingSymmetric(horizontal: AppSizes.s100),
                                                                                                      ],
                                                                                                    ),
                                                                                                  );
                                                                                                },
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
                                                                                        // InkWell(
                                                                                        //   onTap: () {
                                                                                        //     showModalCenter(
                                                                                        //       context,
                                                                                        //       ShowModalTandaTanyaComponent(
                                                                                        //         label: 'Apakah anda yakin ingin menghapus data obat?',
                                                                                        //         onTapNo: () {
                                                                                        //           Get.back();
                                                                                        //         },
                                                                                        //         onTapYes: () {},
                                                                                        //       ),
                                                                                        //     );
                                                                                        //   },
                                                                                        //   child: Text(
                                                                                        //     'Hapus',
                                                                                        //     style: Get.textTheme.labelLarge!.copyWith(
                                                                                        //       fontSize: AppSizes.s14,
                                                                                        //       color: AppColors.colorBaseBlack,
                                                                                        //     ),
                                                                                        //   ),
                                                                                        // ),
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
                                                                            size:
                                                                                24,
                                                                            color:
                                                                                Color(0xfff828282),
                                                                          ),
                                                                        )
                                                                      : Center(
                                                                          child:
                                                                              PopupMenuButton(
                                                                            icon:
                                                                                const Icon(
                                                                              Icons.more_horiz,
                                                                              size: 24,
                                                                              color: Color(0xfff828282),
                                                                            ),
                                                                            onSelected:
                                                                                (value) {
                                                                              value();
                                                                            },
                                                                            itemBuilder: (context) =>
                                                                                [
                                                                              PopupMenuItem(
                                                                                child: PopupMenuActionComponent(
                                                                                  label: 'Detail',
                                                                                ),
                                                                                value: () {
                                                                                  debugPrint('Detial');
                                                                                },
                                                                                onTap: () {
                                                                                  showModalCenter(
                                                                                    context,
                                                                                    Obx(
                                                                                      () {
                                                                                        return controller.isLoadingPostMeicine.value
                                                                                            ? Center(
                                                                                                child: SizedBox(
                                                                                                  width: 400,
                                                                                                  height: 400,
                                                                                                  child: Lottie.asset(Assets.lottie.hospital),
                                                                                                ),
                                                                                              )
                                                                                            : Form(
                                                                                                key: controller.formKey,
                                                                                                child: Column(
                                                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                                                  children: [
                                                                                                    Center(
                                                                                                      child: Text(
                                                                                                        controller.readOnly.value ? 'Detail' : 'Edit Obat',
                                                                                                        style: Get.textTheme.labelMedium!.copyWith(fontWeight: FontWeight.bold, fontSize: AppSizes.s28),
                                                                                                      ),
                                                                                                    ),
                                                                                                    AppSizes.s12.height,
                                                                                                    Divider(),
                                                                                                    InputDataComponent(
                                                                                                      label: 'Nama Obat',
                                                                                                      hintText: patient.namaObat,
                                                                                                      controller: controller.nameObatController,
                                                                                                      readOnly: controller.readOnly.value,
                                                                                                    ),
                                                                                                    Column(
                                                                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                      children: [
                                                                                                        Text(
                                                                                                          'Tanggal Kadaluarsa',
                                                                                                          style: Get.textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w700, fontSize: AppSizes.s14, color: AppColors.colorBaseBlack),
                                                                                                        ),
                                                                                                        AppSizes.s12.height,
                                                                                                        InkWell(
                                                                                                          onTap: controller.readOnly.value
                                                                                                              ? () {}
                                                                                                              : () async {
                                                                                                                  final DateTime? pickedDate = await showDatePicker(
                                                                                                                    context: context,
                                                                                                                    initialDate: DateTime.now(),
                                                                                                                    firstDate: DateTime.now(),
                                                                                                                    lastDate: DateTime(2045), // ⛔ hanya sampai hari ini, tidak bisa pilih besok
                                                                                                                  );
                                                                                                                  if (pickedDate != null) {
                                                                                                                    controller.tglKadalursaController.value = pickedDate;
                                                                                                                  }
                                                                                                                },
                                                                                                          child: Container(
                                                                                                              padding: AppSizes.symmetricPadding(vertical: AppSizes.s5, horizontal: AppSizes.s20),
                                                                                                              decoration: BoxDecoration(
                                                                                                                border: Border.all(
                                                                                                                  color: AppColors.colorSecondary400,
                                                                                                                ),
                                                                                                                borderRadius: BorderRadius.circular(AppSizes.s4),
                                                                                                              ),
                                                                                                              child: Row(
                                                                                                                children: [
                                                                                                                  Icon(
                                                                                                                    Icons.calendar_month,
                                                                                                                    weight: AppSizes.s20,
                                                                                                                    size: AppSizes.s30,
                                                                                                                    color: AppColors.colorNeutrals100,
                                                                                                                  ),
                                                                                                                  AppSizes.s10.width,
                                                                                                                  Text(
                                                                                                                    controller.readOnly.value ? patient.tglKadaluarsa.toDateyyyymmddFormattedString() : controller.tglKadalursaController.value.toDateyyyymmddFormattedString(),
                                                                                                                    style: Get.textTheme.bodySmall!.copyWith(
                                                                                                                      fontSize: AppSizes.s14,
                                                                                                                      color: AppColors.colorNeutrals400,
                                                                                                                    ),
                                                                                                                  ),
                                                                                                                ],
                                                                                                              ).paddingSymmetric(vertical: AppSizes.s5)),
                                                                                                        ),
                                                                                                        AppSizes.s12.height,
                                                                                                      ],
                                                                                                    ),
                                                                                                    InputDataComponent(
                                                                                                      label: 'Stock Obat',
                                                                                                      hintText: patient.stock.toString(),
                                                                                                      controller: controller.stockController,
                                                                                                      readOnly: controller.readOnly.value,
                                                                                                    ),
                                                                                                    AppSizes.s10.height,
                                                                                                    controller.readOnly.value
                                                                                                        ? InputDataComponent(
                                                                                                            label: 'Status Obat',
                                                                                                            hintText: patient.statusObat == 'ACTIVE' ? 'Aktif' : 'Tidak Aktif',
                                                                                                            controller: TextEditingController(),
                                                                                                            readOnly: controller.readOnly.value,
                                                                                                          )
                                                                                                        : Column(
                                                                                                            children: [
                                                                                                              Text(
                                                                                                                'Ubah Status Obat',
                                                                                                                style: Get.textTheme.labelMedium!.copyWith(
                                                                                                                  fontWeight: FontWeight.bold,
                                                                                                                  fontSize: AppSizes.s14,
                                                                                                                ),
                                                                                                              ),
                                                                                                              AppSizes.s12.height,
                                                                                                              patient.statusObat == 'ACTIVE'
                                                                                                                  ? Button.filled(
                                                                                                                      onPressed: () {
                                                                                                                        showModalCenter(
                                                                                                                          context,
                                                                                                                          ShowModalTandaTanyaComponent(
                                                                                                                            label: 'Apakah anda yakin untuk menonAktifkan Obat ?',
                                                                                                                            onTapNo: () {
                                                                                                                              Get.back();
                                                                                                                            },
                                                                                                                            onTapYes: () async {
                                                                                                                              Get.back();
                                                                                                                              await controller.putStatusMedicine(status: "NON_ACTIVE", id: patient.id);
                                                                                                                            },
                                                                                                                          ),
                                                                                                                        );
                                                                                                                      },
                                                                                                                      color: AppColors.colorBaseError,
                                                                                                                      label: 'Nonaktifkan Obat')
                                                                                                                  : Button.filled(
                                                                                                                      onPressed: () {
                                                                                                                        showModalCenter(
                                                                                                                          context,
                                                                                                                          ShowModalTandaTanyaComponent(
                                                                                                                            label: 'Apakah anda yakin untuk Aktifkan Obat ?',
                                                                                                                            onTapNo: () {
                                                                                                                              Get.back();
                                                                                                                            },
                                                                                                                            onTapYes: () async {
                                                                                                                              Get.back();
                                                                                                                              await controller.putStatusMedicine(status: "ACTIVE", id: patient.id);
                                                                                                                            },
                                                                                                                          ),
                                                                                                                        );
                                                                                                                      },
                                                                                                                      label: 'Aktifkan Obat',
                                                                                                                      color: AppColors.colorMenungguText,
                                                                                                                    ),
                                                                                                            ],
                                                                                                          ),
                                                                                                    AppSizes.s15.height,
                                                                                                    Row(
                                                                                                      children: [
                                                                                                        Flexible(
                                                                                                          child: Button.outlined(
                                                                                                              onPressed: () {
                                                                                                                controller.nameObatController.clear();
                                                                                                                controller.tglKadalursaController.value = DateTime.now();
                                                                                                                controller.stockController.clear();
                                                                                                                var data = PostMedicineRequest(
                                                                                                                  namaObat: patient.namaObat,
                                                                                                                  tglKadaluarsa: patient.tglKadaluarsa.toString(),
                                                                                                                  stock: patient.stock,
                                                                                                                  statusObat: patient.statusObat,
                                                                                                                );
                                                                                                                controller.changeReadOnly(data);

                                                                                                                Get.back();
                                                                                                              },
                                                                                                              label: 'Kembali'),
                                                                                                        ),
                                                                                                        AppSizes.s15.width,
                                                                                                        Flexible(
                                                                                                          child: Button.filled(
                                                                                                              onPressed: controller.readOnly.value
                                                                                                                  ? () {
                                                                                                                      var data = PostMedicineRequest(
                                                                                                                        namaObat: patient.namaObat,
                                                                                                                        tglKadaluarsa: patient.tglKadaluarsa.toString(),
                                                                                                                        stock: patient.stock,
                                                                                                                        statusObat: patient.statusObat,
                                                                                                                      );
                                                                                                                      controller.changeReadOnly(data);
                                                                                                                    }
                                                                                                                  : () async {
                                                                                                                      String isoUtc = controller.tglKadalursaController.value.toUtc().toIso8601String();
                                                                                                                      var data = PostMedicineRequest(
                                                                                                                        namaObat: controller.nameObatController.text,
                                                                                                                        tglKadaluarsa: isoUtc,
                                                                                                                        stock: int.parse(controller.stockController.text),
                                                                                                                      );
                                                                                                                      controller.changeReadOnly(data);
                                                                                                                      await controller.putMedicine(data: data, id: patient.id);
                                                                                                                    },
                                                                                                              label: controller.readOnly.value ? 'Edit' : "Simpan"),
                                                                                                        ),
                                                                                                      ],
                                                                                                    ).paddingSymmetric(horizontal: AppSizes.s100),
                                                                                                  ],
                                                                                                ).paddingSymmetric(horizontal: AppSizes.s100),
                                                                                              );
                                                                                      },
                                                                                    ),
                                                                                  );
                                                                                },
                                                                              ),
                                                                              // PopupMenuItem(
                                                                              //   child:
                                                                              //       PopupMenuActionComponent(
                                                                              //     label:
                                                                              //         'Hapus',
                                                                              //   ),
                                                                              //   value:
                                                                              //       () {
                                                                              //     debugPrint('Hapus');
                                                                              //   },
                                                                              //   onTap:
                                                                              //       () {
                                                                              // showModalCenter(
                                                                              //   context,
                                                                              //   ShowModalTandaTanyaComponent(
                                                                              //     label: 'Apakah anda yakin ingin menghapus data Dokter ?',
                                                                              //     onTapNo: () {
                                                                              //       Get.back();
                                                                              //     },
                                                                              //     onTapYes: () {},
                                                                              //   ),
                                                                              // );
                                                                              //   },
                                                                              // ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                ),
                                                              ),
                                                            ],
                                                          );
                                                        },
                                                      ).toList(),
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
