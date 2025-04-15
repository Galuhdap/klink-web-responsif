import 'package:dropdown_search/dropdown_search.dart';
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
import 'package:klinik_web_responsif/core/config/responsive.dart';
import 'package:klinik_web_responsif/core/resources/constans/app_constants.dart';
import 'package:klinik_web_responsif/core/styles/app_colors.dart';
import 'package:klinik_web_responsif/core/styles/app_sizes.dart';
import 'package:klinik_web_responsif/core/utils/extensions/date_ext.dart';
import 'package:klinik_web_responsif/core/utils/extensions/sized_box_ext.dart';
import 'package:klinik_web_responsif/core/utils/helpers/validation_helper.dart';
import 'package:klinik_web_responsif/presentations/menu_dashboard/widget/build_app_bar.dart';
import 'package:klinik_web_responsif/presentations/patient/controller/patient_controller.dart';
import 'package:klinik_web_responsif/presentations/patient/controller/rekam_medis_controller.dart';
import 'package:klinik_web_responsif/presentations/patient/screen/rekam_medis_screen.dart';
import 'package:klinik_web_responsif/services/pasien/model/request/post_pasient_request.dart';
import 'package:lottie/lottie.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class DataPatientScreen extends StatelessWidget {
  const DataPatientScreen({
    super.key,
  });

  // @override
  @override
  Widget build(BuildContext context) {
    return GetBuilder<PatientController>(
      init: PatientController(),
      builder: (controller) {
        var controllerRme = Get.put(RekamMedisController());
        return Scaffold(
          backgroundColor: Color(0xfffF8F8F8),
          appBar: PreferredSize(
            preferredSize: Responsive.isMobile(context)
                ? Size.fromHeight(90.0)
                : Size.fromHeight(100.0),
            child: BuildAppBar(
              title: 'Klinik Chania Care Center',
              isMake: true,
              withSearchInput: true,
              searchController: TextEditingController(),
              searchHint: 'Cari Pasien',
              searchChanged: (_) {},
              onTapButton: () {
                showModalCenter(
                  context,
                  Obx(
                    () {
                      return controller.isLoadingCreate.value
                          ? Center(
                              child: SizedBox(
                                width: 400,
                                height: 400,
                                child: Lottie.asset(Assets.lottie.hospital),
                              ),
                            )
                          : Form(
                              key: controller.formKey,
                              child: ListView(
                                children: [
                                  Center(
                                    child: Text(
                                      'Tambah Data',
                                      style: Get.textTheme.labelMedium!
                                          .copyWith(
                                              fontWeight: FontWeight.bold,
                                              fontSize: AppSizes.s16),
                                    ),
                                  ),
                                  AppSizes.s12.height,
                                  Divider(),
                                  InputDataComponent(
                                    label: 'Nama Pasien',
                                    hintText: 'Nama Pasien',
                                    controller: controller.nameController,
                                    validator: emptyValidation,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Jenis Kelamin',
                                        style: Get.textTheme.bodyMedium!
                                            .copyWith(
                                                fontWeight: FontWeight.w700,
                                                fontSize: AppSizes.s14,
                                                color:
                                                    AppColors.colorBaseBlack),
                                      ),
                                      AppSizes.s12.height,
                                      DropdownSearch<String>(
                                        items: (f, cs) => [
                                          "Laki-laki",
                                          "Perempuan",
                                        ],
                                        dropdownBuilder:
                                            (context, selectedItem) {
                                          return Text(
                                            selectedItem ?? "Jenis Kelamin",
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: selectedItem == null
                                                  ? Colors.grey
                                                  : Colors.black,
                                            ),
                                          );
                                        },
                                        popupProps: PopupProps.menu(
                                          disabledItemFn: (item) =>
                                              item == 'Item 3',
                                          fit: FlexFit.loose,
                                        ),
                                        onChanged: (String? selectedValue) {
                                          controller.jenisKelaminController
                                              .value = selectedValue!;
                                        },
                                      ),
                                      AppSizes.s12.height,
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Tanggal Lahir',
                                        style: Get.textTheme.bodyMedium!
                                            .copyWith(
                                                fontWeight: FontWeight.w700,
                                                fontSize: AppSizes.s14,
                                                color:
                                                    AppColors.colorBaseBlack),
                                      ),
                                      AppSizes.s12.height,
                                      InkWell(onTap: () async {
                                        final DateTime? pickedDate =
                                            await showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime(1950),
                                          lastDate: DateTime
                                              .now(), // ⛔ hanya sampai hari ini, tidak bisa pilih besok
                                        );

                                        if (pickedDate != null) {
                                          controller.tglLahirController.value =
                                              pickedDate;
                                        }
                                      }, child: Obx(() {
                                        return Container(
                                          padding: AppSizes.symmetricPadding(
                                              vertical: AppSizes.s5,
                                              horizontal: AppSizes.s20),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color:
                                                  AppColors.colorSecondary400,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                                AppSizes.s4),
                                          ),
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.calendar_month,
                                                weight: AppSizes.s20,
                                                size: AppSizes.s30,
                                                color:
                                                    AppColors.colorNeutrals100,
                                              ),
                                              AppSizes.s10.width,
                                              Text(
                                                controller
                                                    .tglLahirController.value
                                                    .toDateyyyymmddFormattedString(),
                                                style: Get.textTheme.bodySmall!
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
                                      })),
                                      AppSizes.s12.height,
                                    ],
                                  ),
                                  InputDataComponent(
                                    label: 'Alamat',
                                    hintText: 'Alamat',
                                    controller: controller.alamatController,
                                    validator: emptyValidation,
                                  ),
                                  InputDataComponent(
                                    label: 'No Telpon',
                                    hintText: 'No Telpon',
                                    controller: controller.noTelpController,
                                    validator: emptyValidation,
                                    // validator: (value) => controller.errorCreatePasien.value!.message?['no_telp'],
                                  ),
                                  InputDataComponent(
                                    label: 'NIK',
                                    hintText: 'NIK',
                                    controller: controller.nikController,
                                    validator: emptyValidation,
                                    // validator: (value) => controller.errorCreatePasien.value!.message?["nik"],
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
                                            onPressed: () {
                                              if (controller
                                                  .formKey.currentState!
                                                  .validate()) {
                                                controller.postPasien();
                                              }
                                            },
                                            label: 'Simpan'),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            );
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
                          AppConstants.LABEL_DATA_PASIEN,
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
                                        return controller.isLoadingCreate.value
                                            ? Center(
                                                child: SizedBox(
                                                  width: 400,
                                                  height: 400,
                                                  child: Lottie.asset(
                                                      Assets.lottie.hospital),
                                                ),
                                              )
                                            : Form(
                                                key: controller.formKey,
                                                child: ListView(
                                                  children: [
                                                    Center(
                                                      child: Text(
                                                        'Tambah Data',
                                                        style: Get.textTheme
                                                            .labelMedium!
                                                            .copyWith(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize:
                                                                    AppSizes
                                                                        .s16),
                                                      ),
                                                    ),
                                                    AppSizes.s12.height,
                                                    Divider(),
                                                    InputDataComponent(
                                                      label: 'Nama Pasien',
                                                      hintText: 'Nama Pasien',
                                                      controller: controller
                                                          .nameController,
                                                      validator:
                                                          emptyValidation,
                                                    ),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          'Jenis Kelamin',
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
                                                        DropdownSearch<String>(
                                                          items: (f, cs) => [
                                                            "Laki-laki",
                                                            "Perempuan",
                                                          ],
                                                          dropdownBuilder:
                                                              (context,
                                                                  selectedItem) {
                                                            return Text(
                                                              selectedItem ??
                                                                  "Jenis Kelamin",
                                                              style: TextStyle(
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                color: selectedItem ==
                                                                        null
                                                                    ? Colors
                                                                        .grey
                                                                    : Colors
                                                                        .black,
                                                              ),
                                                            );
                                                          },
                                                          popupProps:
                                                              PopupProps.menu(
                                                                  disabledItemFn:
                                                                      (item) =>
                                                                          item ==
                                                                          'Item 3',
                                                                  fit: FlexFit
                                                                      .loose),
                                                          onChanged: (String?
                                                              selectedValue) {
                                                            controller
                                                                    .jenisKelaminController
                                                                    .value =
                                                                selectedValue!;
                                                          },
                                                        ),
                                                        AppSizes.s12.height,
                                                      ],
                                                    ),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          'Tanggal Lahir',
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
                                                          final DateTime?
                                                              pickedDate =
                                                              await showDatePicker(
                                                            context: context,
                                                            initialDate:
                                                                DateTime.now(),
                                                            firstDate:
                                                                DateTime(1950),
                                                            lastDate: DateTime
                                                                .now(), // ⛔ hanya sampai hari ini, tidak bisa pilih besok
                                                          );
                                                          if (pickedDate !=
                                                              null) {
                                                            controller
                                                                .tglLahirController
                                                                .value = pickedDate;
                                                          }
                                                        }, child: Obx(() {
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
                                                                  BorderRadius
                                                                      .circular(
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
                                                                  size: AppSizes
                                                                      .s30,
                                                                  color: AppColors
                                                                      .colorNeutrals100,
                                                                ),
                                                                AppSizes
                                                                    .s10.width,
                                                                Text(
                                                                  controller
                                                                      .tglLahirController
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
                                                        })),
                                                        AppSizes.s12.height,
                                                      ],
                                                    ),
                                                    InputDataComponent(
                                                      label: 'Alamat',
                                                      hintText: 'Alamat',
                                                      controller: controller
                                                          .alamatController,
                                                      validator:
                                                          emptyValidation,
                                                    ),
                                                    InputDataComponent(
                                                      label: 'No Telpon',
                                                      hintText: 'No Telpon',
                                                      controller: controller
                                                          .noTelpController,
                                                      validator:
                                                          emptyValidation,
                                                    ),
                                                    InputDataComponent(
                                                      label: 'NIK',
                                                      hintText: 'NIK',
                                                      controller: controller
                                                          .nikController,
                                                      validator:
                                                          emptyValidation,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Flexible(
                                                          child:
                                                              Button.outlined(
                                                                  onPressed:
                                                                      () {
                                                                    Get.back();
                                                                  },
                                                                  label:
                                                                      'Batal'),
                                                        ),
                                                        AppSizes.s12.width,
                                                        Flexible(
                                                          child: Button.filled(
                                                              onPressed: () {
                                                                if (controller
                                                                    .formKey
                                                                    .currentState!
                                                                    .validate()) {
                                                                  controller
                                                                      .postPasien();
                                                                }
                                                              },
                                                              label: 'Simpan'),
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                ),
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
                                      'Daftar Pasien',
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
                                controller.getPasien(search: value);
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
                          : controller.pasienList.isEmpty
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
                                                    AppConstants.LABEL_NIK,
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
                                                    AppConstants.LABEL_UMUR,
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
                                                    AppConstants
                                                        .LABEL_JENIS_KELAMIN,
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
                                                    AppConstants
                                                        .LABEL_TGL_LAHIR,
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
                                                : controller.pasienList.isEmpty
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
                                                    : controller.pasienList
                                                        .asMap()
                                                        .entries
                                                        .map((entry) {
                                                        final index = entry.key;
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
                                                                          FontWeight
                                                                              .bold),
                                                                ),
                                                              ),
                                                            ),
                                                            DataCell(
                                                              Padding(
                                                                padding:
                                                                    EdgeInsets
                                                                        .only(
                                                                  left: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width *
                                                                      0.02,
                                                                  right: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width *
                                                                      0.04,
                                                                ),
                                                                child: Text(
                                                                  patient.name,
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
                                                                  left: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width *
                                                                      0.02,
                                                                ),
                                                                child: Center(
                                                                  child: Text(
                                                                    patient
                                                                        .noRekamMedis,
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
                                                                        .only(),
                                                                child: Center(
                                                                  child: Text(
                                                                    patient.nik,
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
                                                                  left: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width *
                                                                      0.02,
                                                                ),
                                                                child: Center(
                                                                  child: Text(
                                                                    patient
                                                                        .umur,
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
                                                                  left: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width *
                                                                      0.02,
                                                                ),
                                                                child: Center(
                                                                  child: Text(
                                                                    patient
                                                                        .jenisKelamin,
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
                                                                  left: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width *
                                                                      0.015,
                                                                ),
                                                                child: Center(
                                                                  child: Center(
                                                                    child: Text(
                                                                      patient
                                                                          .tglLahir
                                                                          .toDateyyyymmddFormattedString(),
                                                                      style: const TextStyle(
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            DataCell(
                                                              Padding(
                                                                padding:
                                                                    EdgeInsets
                                                                        .only(
                                                                  left: MediaQuery.of(
                                                                              context)
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
                                                                                                return controller.isLoadingCreate.value
                                                                                                    ? Center(
                                                                                                        child: SizedBox(
                                                                                                          width: 400,
                                                                                                          height: 400,
                                                                                                          child: Lottie.asset(Assets.lottie.hospital),
                                                                                                        ),
                                                                                                      )
                                                                                                    : Form(
                                                                                                        key: controller.formKey,
                                                                                                        child: ListView(
                                                                                                          controller: controller.scrollController,
                                                                                                          children: [
                                                                                                            Center(
                                                                                                              child: Text(
                                                                                                                controller.readOnly.value ? 'Detail' : 'Edit Pasien',
                                                                                                                style: Get.textTheme.labelMedium!.copyWith(fontWeight: FontWeight.bold, fontSize: AppSizes.s16),
                                                                                                              ),
                                                                                                            ),
                                                                                                            AppSizes.s12.height,
                                                                                                            Divider(),
                                                                                                            InputDataComponent(
                                                                                                              label: 'Nama Pasien',
                                                                                                              hintText: patient.name,
                                                                                                              controller: controller.nameController,
                                                                                                              readOnly: controller.readOnly.value,
                                                                                                            ),
                                                                                                            Column(
                                                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                              children: [
                                                                                                                Text(
                                                                                                                  'Jenis Kelamin',
                                                                                                                  style: Get.textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w700, fontSize: AppSizes.s14, color: AppColors.colorBaseBlack),
                                                                                                                ),
                                                                                                                AppSizes.s12.height,
                                                                                                                DropdownSearch<String>(
                                                                                                                  enabled: !controller.readOnly.value,
                                                                                                                  items: (f, cs) => [
                                                                                                                    "Laki-laki",
                                                                                                                    'Perempuan',
                                                                                                                  ],
                                                                                                                  dropdownBuilder: (context, selectedItem) {
                                                                                                                    return Text(
                                                                                                                      controller.readOnly.value ? patient.jenisKelamin : controller.jenisKelaminController.value,
                                                                                                                      style: TextStyle(
                                                                                                                        fontSize: 14,
                                                                                                                        fontWeight: FontWeight.w500,
                                                                                                                        color: selectedItem == null ? Colors.grey : Colors.black,
                                                                                                                      ),
                                                                                                                    );
                                                                                                                  },
                                                                                                                  popupProps: PopupProps.menu(disabledItemFn: (item) => item == 'Item 3', fit: FlexFit.loose),
                                                                                                                  onChanged: (String? selectedValue) {
                                                                                                                    controller.jenisKelaminController.value = selectedValue!;
                                                                                                                  },
                                                                                                                ),
                                                                                                                AppSizes.s12.height,
                                                                                                              ],
                                                                                                            ),
                                                                                                            Column(
                                                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                              children: [
                                                                                                                Text(
                                                                                                                  'Tanggal Lahir',
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
                                                                                                                            firstDate: DateTime(1950),
                                                                                                                            lastDate: DateTime.now(), // ⛔ hanya sampai hari ini, tidak bisa pilih besok
                                                                                                                          );
                                                                                                                          if (pickedDate != null) {
                                                                                                                            controller.tglLahirController.value = pickedDate;
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
                                                                                                                            controller.readOnly.value ? patient.tglLahir.toDateyyyymmddFormattedString() : controller.tglLahirController.value.toDateyyyymmddFormattedString(),
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
                                                                                                              label: 'Alamat',
                                                                                                              hintText: patient.alamat,
                                                                                                              controller: controller.alamatController,
                                                                                                              readOnly: controller.readOnly.value,
                                                                                                            ),
                                                                                                            InputDataComponent(
                                                                                                              label: 'No Telpon',
                                                                                                              hintText: patient.noTelp,
                                                                                                              controller: controller.noTelpController,
                                                                                                              readOnly: controller.readOnly.value,
                                                                                                            ),
                                                                                                            InputDataComponent(
                                                                                                              label: 'NIK',
                                                                                                              hintText: patient.nik,
                                                                                                              controller: controller.nikController,
                                                                                                              readOnly: controller.readOnly.value,
                                                                                                            ),
                                                                                                            Row(
                                                                                                              children: [
                                                                                                                Flexible(
                                                                                                                  child: Button.outlined(
                                                                                                                      onPressed: controller.readOnly.value
                                                                                                                          ? () {
                                                                                                                              Get.back();
                                                                                                                            }
                                                                                                                          : () {
                                                                                                                              var data = PostPasienRequest(
                                                                                                                                name: patient.name,
                                                                                                                                jenisKelamin: patient.jenisKelamin,
                                                                                                                                alamat: patient.alamat,
                                                                                                                                tglLahir: patient.tglLahir,
                                                                                                                                nik: patient.nik,
                                                                                                                                noTelp: patient.noTelp,
                                                                                                                                // umur: umurController.text,
                                                                                                                              );
                                                                                                                              controller.changeReadOnly(data);
                                                                                                                              controller.nameController.clear();
                                                                                                                              controller.jenisKelaminController.value = '';
                                                                                                                              controller.alamatController.clear();
                                                                                                                              controller.tglLahirController.value = DateTime.now();
                                                                                                                              controller.nikController.clear();
                                                                                                                              controller.noTelpController.clear();
                                                                                                                              controller.umurController.clear();
                                                                                                                              Get.back();
                                                                                                                            },
                                                                                                                      label: 'Batal'),
                                                                                                                ),
                                                                                                                AppSizes.s12.width,
                                                                                                                Flexible(
                                                                                                                  child: Button.filled(
                                                                                                                      onPressed: controller.readOnly.value
                                                                                                                          ? () {
                                                                                                                              var data = PostPasienRequest(
                                                                                                                                name: patient.name,
                                                                                                                                jenisKelamin: patient.jenisKelamin,
                                                                                                                                alamat: patient.alamat,
                                                                                                                                tglLahir: patient.tglLahir,
                                                                                                                                nik: patient.nik,
                                                                                                                                noTelp: patient.noTelp,
                                                                                                                                // umur: umurController.text,
                                                                                                                              );
                                                                                                                              controller.changeReadOnly(data);
                                                                                                                            }
                                                                                                                          : () {
                                                                                                                              var data = PostPasienRequest(
                                                                                                                                name: patient.name,
                                                                                                                                jenisKelamin: patient.jenisKelamin,
                                                                                                                                alamat: patient.alamat,
                                                                                                                                tglLahir: patient.tglLahir,
                                                                                                                                nik: patient.nik,
                                                                                                                                noTelp: patient.noTelp,
                                                                                                                                // umur: umurController.text,
                                                                                                                              );
                                                                                                                              controller.changeReadOnly(data);
                                                                                                                              controller.putPasien(patient.id);
                                                                                                                            },
                                                                                                                      label: controller.readOnly.value ? 'Edit' : "Simpan"),
                                                                                                                ),
                                                                                                              ],
                                                                                                            )
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
                                                                                      InkWell(
                                                                                        onTap: () {
                                                                                          controllerRme.getRmePasien(id: patient.id);
                                                                                          Get.to(RekamMedisScreen(name: patient.name));
                                                                                        },
                                                                                        child: Text(
                                                                                          'Rekam Medis',
                                                                                          style: Get.textTheme.labelLarge!.copyWith(
                                                                                            fontSize: AppSizes.s14,
                                                                                            color: AppColors.colorBaseBlack,
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                      InkWell(
                                                                                        onTap: () {
                                                                                          showModalCenter(
                                                                                            context,
                                                                                            ShowModalTandaTanyaComponent(
                                                                                              label: 'Apakah anda yakin ingin menambahkan Farhan ke antrian ?',
                                                                                              onTapNo: () {
                                                                                                Get.back();
                                                                                              },
                                                                                              onTapYes: () {
                                                                                                showModalCenter(
                                                                                                  context,
                                                                                                  Column(
                                                                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                                                                    spacing: 20,
                                                                                                    children: [
                                                                                                      Container(
                                                                                                        width: 200,
                                                                                                        height: 200,
                                                                                                        decoration: BoxDecoration(
                                                                                                          borderRadius: BorderRadius.circular(AppSizes.s100),
                                                                                                          color: AppColors.colorBasePrimary,
                                                                                                        ),
                                                                                                        child: Center(
                                                                                                          child: Text(
                                                                                                            '19',
                                                                                                            style: Get.textTheme.labelLarge!.copyWith(
                                                                                                              fontSize: AppSizes.s100,
                                                                                                              color: AppColors.colorBaseWhite,
                                                                                                            ),
                                                                                                          ),
                                                                                                        ),
                                                                                                      ),
                                                                                                      Center(
                                                                                                        child: Text(
                                                                                                          'Nomor Antrian Ditambahkan',
                                                                                                          style: Get.textTheme.labelLarge!.copyWith(
                                                                                                            fontSize: AppSizes.s24,
                                                                                                            color: AppColors.colorNeutrals200,
                                                                                                          ),
                                                                                                        ),
                                                                                                      ),
                                                                                                      Center(
                                                                                                          child: Button.filled(
                                                                                                        onPressed: () {
                                                                                                          Get.back();
                                                                                                          Get.back();
                                                                                                        },
                                                                                                        label: 'Selesai',
                                                                                                      )),
                                                                                                    ],
                                                                                                  ),
                                                                                                );
                                                                                              },
                                                                                            ),
                                                                                          );
                                                                                        },
                                                                                        child: Text(
                                                                                          'Tambah Ke Antrian',
                                                                                          style: Get.textTheme.labelLarge!.copyWith(
                                                                                            fontSize: AppSizes.s14,
                                                                                            color: AppColors.colorBaseBlack,
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                      InkWell(
                                                                                        onTap: () {
                                                                                          showModalCenter(
                                                                                            context,
                                                                                            Column(
                                                                                              children: [
                                                                                                Center(
                                                                                                  child: Text(
                                                                                                    'Klinik Chania Care Center',
                                                                                                    style: TextStyle(
                                                                                                      fontSize: Responsive.isMobile(context) ? 20 : 25,
                                                                                                      fontWeight: FontWeight.w600,
                                                                                                      color: AppColors.colorBaseBlack,
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                                Center(
                                                                                                  child: Text(
                                                                                                    'Kartu Berobat',
                                                                                                    style: Get.textTheme.labelMedium!.copyWith(fontWeight: FontWeight.bold, fontSize: AppSizes.s16),
                                                                                                  ),
                                                                                                ),
                                                                                                Column(
                                                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                                                  children: [
                                                                                                    AppSizes.s12.height,
                                                                                                    Divider(),
                                                                                                    InputDataComponent(
                                                                                                      label: 'Nama Pasien',
                                                                                                      hintText: patient.name,
                                                                                                      controller: TextEditingController(),
                                                                                                      readOnly: true,
                                                                                                    ),
                                                                                                    InputDataComponent(
                                                                                                      label: 'No Rekam Medis',
                                                                                                      hintText: patient.noRekamMedis,
                                                                                                      controller: TextEditingController(),
                                                                                                      readOnly: true,
                                                                                                    ),
                                                                                                    InputDataComponent(
                                                                                                      label: 'Alamat',
                                                                                                      hintText: patient.alamat,
                                                                                                      controller: TextEditingController(),
                                                                                                      readOnly: true,
                                                                                                    ),
                                                                                                  ],
                                                                                                ),
                                                                                                AppSizes.s20.width,
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
                                                                                                            final text = Uri.encodeComponent(
                                                                                                              "🏥 🩺 *Kartu Berobat - Klinik Chania Care Center*\n\n"
                                                                                                              "📌 *Nama:* ${patient.name}\n"
                                                                                                              "📌 *Alamat:* ${patient.alamat}\n"
                                                                                                              "📌 *No. Rekam Medis:* ${patient.noRekamMedis}\n\n"
                                                                                                              "Terima kasih telah berobat di Klinik Chania Care Center. Semoga lekas sembuh! 💊\n\n"
                                                                                                              "*Uji Coba!*",
                                                                                                            );
                                                                                                            var whatsappUrl = Uri.parse("whatsapp://send?phone=62${patient.noTelp}&text=$text");
                                                                                                            try {
                                                                                                              launchUrl(whatsappUrl);
                                                                                                            } catch (e) {
                                                                                                              debugPrint(e.toString());
                                                                                                            }
                                                                                                          },
                                                                                                          label: 'Kirim Data'),
                                                                                                    ),
                                                                                                  ],
                                                                                                )
                                                                                              ],
                                                                                            ).paddingSymmetric(horizontal: 50, vertical: AppSizes.s50),
                                                                                          );
                                                                                        },
                                                                                        child: Text(
                                                                                          'Kartu Berobat',
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
                                                                                      //         label: 'Apakah anda yakin ingin menghapus data Farhan ?',
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
                                                                          Icons
                                                                              .more_horiz,
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
                                                                            size:
                                                                                24,
                                                                            color:
                                                                                Color(0xfff828282),
                                                                          ),
                                                                          onSelected:
                                                                              (value) {
                                                                            value();
                                                                          },
                                                                          itemBuilder:
                                                                              (context) => [
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
                                                                                      return controller.isLoadingCreate.value
                                                                                          ? Center(
                                                                                              child: SizedBox(
                                                                                                width: 400,
                                                                                                height: 400,
                                                                                                child: Lottie.asset(Assets.lottie.hospital),
                                                                                              ),
                                                                                            )
                                                                                          : Form(
                                                                                              key: controller.formKey,
                                                                                              child: ListView(
                                                                                                controller: controller.scrollController,
                                                                                                children: [
                                                                                                  Center(
                                                                                                    child: Text(
                                                                                                      controller.readOnly.value ? 'Detail' : 'Edit Pasien',
                                                                                                      style: Get.textTheme.labelMedium!.copyWith(fontWeight: FontWeight.bold, fontSize: AppSizes.s20),
                                                                                                    ),
                                                                                                  ),
                                                                                                  AppSizes.s12.height,
                                                                                                  Divider(),
                                                                                                  InputDataComponent(
                                                                                                    label: 'Nama Pasien',
                                                                                                    hintText: patient.name,
                                                                                                    controller: controller.nameController,
                                                                                                    readOnly: controller.readOnly.value,
                                                                                                  ),
                                                                                                  Column(
                                                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                    children: [
                                                                                                      Text(
                                                                                                        'Jenis Kelamin',
                                                                                                        style: Get.textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w700, fontSize: AppSizes.s14, color: AppColors.colorBaseBlack),
                                                                                                      ),
                                                                                                      AppSizes.s12.height,
                                                                                                      DropdownSearch<String>(
                                                                                                        enabled: !controller.readOnly.value,
                                                                                                        items: (f, cs) => [
                                                                                                          "Laki-laki",
                                                                                                          'Perempuan',
                                                                                                        ],
                                                                                                        dropdownBuilder: (context, selectedItem) {
                                                                                                          return Text(
                                                                                                            controller.readOnly.value ? patient.jenisKelamin : controller.jenisKelaminController.value,
                                                                                                            style: TextStyle(
                                                                                                              fontSize: 14,
                                                                                                              fontWeight: FontWeight.w500,
                                                                                                              color: selectedItem == null ? Colors.grey : Colors.black,
                                                                                                            ),
                                                                                                          );
                                                                                                        },
                                                                                                        popupProps: PopupProps.menu(disabledItemFn: (item) => item == 'Item 3', fit: FlexFit.loose),
                                                                                                        onChanged: (String? selectedValue) {
                                                                                                          controller.jenisKelaminController.value = selectedValue!;
                                                                                                        },
                                                                                                      ),
                                                                                                      AppSizes.s12.height,
                                                                                                    ],
                                                                                                  ),
                                                                                                  Column(
                                                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                    children: [
                                                                                                      Text(
                                                                                                        'Tanggal Lahir',
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
                                                                                                                  firstDate: DateTime(1950),
                                                                                                                  lastDate: DateTime.now(), // ⛔ hanya sampai hari ini, tidak bisa pilih besok
                                                                                                                );
                                                                                                                if (pickedDate != null) {
                                                                                                                  controller.tglLahirController.value = pickedDate;
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
                                                                                                                  controller.readOnly.value ? patient.tglLahir.toDateyyyymmddFormattedString() : controller.tglLahirController.value.toDateyyyymmddFormattedString(),
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
                                                                                                    label: 'Alamat',
                                                                                                    hintText: patient.alamat,
                                                                                                    controller: controller.alamatController,
                                                                                                    readOnly: controller.readOnly.value,
                                                                                                  ),
                                                                                                  InputDataComponent(
                                                                                                    label: 'No Telpon',
                                                                                                    hintText: patient.noTelp,
                                                                                                    controller: controller.noTelpController,
                                                                                                    readOnly: controller.readOnly.value,
                                                                                                  ),
                                                                                                  InputDataComponent(
                                                                                                    label: 'NIK',
                                                                                                    hintText: patient.nik,
                                                                                                    controller: controller.nikController,
                                                                                                    readOnly: controller.readOnly.value,
                                                                                                  ),
                                                                                                  Row(
                                                                                                    children: [
                                                                                                      Flexible(
                                                                                                        child: Button.outlined(
                                                                                                            onPressed: controller.readOnly.value
                                                                                                                ? () {
                                                                                                                    Get.back();
                                                                                                                  }
                                                                                                                : () {
                                                                                                                    var data = PostPasienRequest(
                                                                                                                      name: patient.name,
                                                                                                                      jenisKelamin: patient.jenisKelamin,
                                                                                                                      alamat: patient.alamat,
                                                                                                                      tglLahir: patient.tglLahir,
                                                                                                                      nik: patient.nik,
                                                                                                                      noTelp: patient.noTelp,
                                                                                                                      // umur: umurController.text,
                                                                                                                    );
                                                                                                                    controller.changeReadOnly(data);
                                                                                                                    controller.nameController.clear();
                                                                                                                    controller.jenisKelaminController.value = '';
                                                                                                                    controller.alamatController.clear();
                                                                                                                    controller.tglLahirController.value = DateTime.now();
                                                                                                                    controller.nikController.clear();
                                                                                                                    controller.noTelpController.clear();
                                                                                                                    controller.umurController.clear();
                                                                                                                    Get.back();
                                                                                                                  },
                                                                                                            label: 'Batal'),
                                                                                                      ),
                                                                                                      AppSizes.s12.width,
                                                                                                      Flexible(
                                                                                                        child: Button.filled(
                                                                                                            onPressed: controller.readOnly.value
                                                                                                                ? () {
                                                                                                                    var data = PostPasienRequest(
                                                                                                                      name: patient.name,
                                                                                                                      jenisKelamin: patient.jenisKelamin,
                                                                                                                      alamat: patient.alamat,
                                                                                                                      tglLahir: patient.tglLahir,
                                                                                                                      nik: patient.nik,
                                                                                                                      noTelp: patient.noTelp,
                                                                                                                    );
                                                                                                                    controller.changeReadOnly(data);
                                                                                                                  }
                                                                                                                : () {
                                                                                                                    var data = PostPasienRequest(
                                                                                                                      name: patient.name,
                                                                                                                      jenisKelamin: patient.jenisKelamin,
                                                                                                                      alamat: patient.alamat,
                                                                                                                      tglLahir: patient.tglLahir,
                                                                                                                      nik: patient.nik,
                                                                                                                      noTelp: patient.noTelp,
                                                                                                                      // umur: umurController.text,
                                                                                                                    );
                                                                                                                    controller.changeReadOnly(data);
                                                                                                                    controller.putPasien(patient.id);
                                                                                                                  },
                                                                                                            label: controller.readOnly.value ? 'Edit' : "Simpan"),
                                                                                                      ),
                                                                                                    ],
                                                                                                  )
                                                                                                ],
                                                                                              ),
                                                                                            );
                                                                                    },
                                                                                  ),
                                                                                );
                                                                              },
                                                                            ),
                                                                            // PopupMenuItem(
                                                                            //   child: PopupMenuActionComponent(
                                                                            //     label: 'Hapus',
                                                                            //   ),
                                                                            //   value: () {
                                                                            //     debugPrint('Hapus');
                                                                            //   },
                                                                            //   onTap: () {
                                                                            //     showModalCenter(
                                                                            //       context,
                                                                            //       ShowModalTandaTanyaComponent(
                                                                            //         label: 'Apakah anda yakin ingin menghapus data Farhan ?',
                                                                            //         onTapNo: () {
                                                                            //           Get.back();
                                                                            //         },
                                                                            //         onTapYes: () {},
                                                                            //       ),
                                                                            //     );
                                                                            //   },
                                                                            // ),
                                                                            PopupMenuItem(
                                                                              child: PopupMenuActionComponent(
                                                                                label: 'Rekam Medis',
                                                                              ),
                                                                              value: () {
                                                                                debugPrint('Rekam Medis');
                                                                              },
                                                                              onTap: () {
                                                                                controllerRme.getRmePasien(id: patient.id);
                                                                                Get.to(RekamMedisScreen(name: patient.name));
                                                                              },
                                                                            ),
                                                                            PopupMenuItem(
                                                                              child: PopupMenuActionComponent(
                                                                                label: 'Tambahkan Antrian',
                                                                              ),
                                                                              value: () {
                                                                                debugPrint('Tambah Antrian');
                                                                              },
                                                                              onTap: () {
                                                                                showModalCenter(
                                                                                  context,
                                                                                  ShowModalTandaTanyaComponent(
                                                                                    label: 'Apakah anda yakin ingin menambahkan Farhan ke antrian ?',
                                                                                    onTapNo: () {
                                                                                      Get.back();
                                                                                    },
                                                                                    onTapYes: () {
                                                                                      showModalCenter(
                                                                                        context,
                                                                                        Column(
                                                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                                                          spacing: 20,
                                                                                          children: [
                                                                                            Container(
                                                                                              width: 200,
                                                                                              height: 200,
                                                                                              decoration: BoxDecoration(
                                                                                                borderRadius: BorderRadius.circular(AppSizes.s100),
                                                                                                color: AppColors.colorBasePrimary,
                                                                                              ),
                                                                                              child: Center(
                                                                                                child: Text(
                                                                                                  '19',
                                                                                                  style: Get.textTheme.labelLarge!.copyWith(
                                                                                                    fontSize: AppSizes.s100,
                                                                                                    color: AppColors.colorBaseWhite,
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                            Center(
                                                                                              child: Text(
                                                                                                'Nomor Antrian Ditambahkan',
                                                                                                style: Get.textTheme.labelLarge!.copyWith(
                                                                                                  fontSize: AppSizes.s24,
                                                                                                  color: AppColors.colorNeutrals200,
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                            Center(
                                                                                              child: Button.filled(
                                                                                                onPressed: () {
                                                                                                  Get.back();
                                                                                                  Get.back();
                                                                                                },
                                                                                                label: 'Selesai',
                                                                                              ).paddingSymmetric(
                                                                                                horizontal: AppSizes.s300,
                                                                                              ),
                                                                                            ),
                                                                                          ],
                                                                                        ),
                                                                                      );
                                                                                    },
                                                                                  ),
                                                                                );
                                                                              },
                                                                            ),
                                                                            PopupMenuItem(
                                                                              child: PopupMenuActionComponent(
                                                                                label: 'Kartu Berobat',
                                                                              ),
                                                                              value: () {
                                                                                debugPrint('Kartu Berobat');
                                                                              },
                                                                              onTap: () {
                                                                                showModalCenter(
                                                                                  context,
                                                                                  Column(
                                                                                    children: [
                                                                                      Center(
                                                                                        child: Text(
                                                                                          'Klinik Chania Care Center',
                                                                                          style: TextStyle(
                                                                                            fontSize: Responsive.isMobile(context) ? 20 : 25,
                                                                                            fontWeight: FontWeight.w600,
                                                                                            color: AppColors.colorBaseBlack,
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                      Center(
                                                                                        child: Text(
                                                                                          'Kartu Berobat',
                                                                                          style: Get.textTheme.labelMedium!.copyWith(fontWeight: FontWeight.bold, fontSize: AppSizes.s16),
                                                                                        ),
                                                                                      ),
                                                                                      Row(
                                                                                        children: [
                                                                                          Flexible(
                                                                                            child: Column(
                                                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                                                              children: [
                                                                                                AppSizes.s12.height,
                                                                                                Divider(),
                                                                                                InputDataComponent(
                                                                                                  label: 'Nama Pasien',
                                                                                                  hintText: patient.name,
                                                                                                  controller: TextEditingController(),
                                                                                                  readOnly: true,
                                                                                                ),
                                                                                                InputDataComponent(
                                                                                                  label: 'No Rekam Medis',
                                                                                                  hintText: patient.noRekamMedis,
                                                                                                  controller: TextEditingController(),
                                                                                                  readOnly: true,
                                                                                                ),
                                                                                                InputDataComponent(
                                                                                                  label: 'Alamat',
                                                                                                  hintText: patient.alamat,
                                                                                                  controller: TextEditingController(),
                                                                                                  readOnly: true,
                                                                                                ),
                                                                                              ],
                                                                                            ),
                                                                                          ),
                                                                                          AppSizes.s20.width,
                                                                                          Center(
                                                                                            child: Flexible(
                                                                                              child: QrImageView(
                                                                                                data: patient.noRekamMedis,
                                                                                                version: QrVersions.auto,
                                                                                                size: 200.0,
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                        ],
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
                                                                                                  final text = Uri.encodeComponent(
                                                                                                    "🏥 🩺 *Kartu Berobat - Klinik Chania Care Center*\n\n"
                                                                                                    "📌 *Nama:* ${patient.name}\n"
                                                                                                    "📌 *Alamat:* ${patient.alamat}\n"
                                                                                                    "📌 *No. Rekam Medis:* ${patient.noRekamMedis}\n\n"
                                                                                                    "Terima kasih telah berobat di Klinik Chania Care Center. Semoga lekas sembuh! 💊\n\n"
                                                                                                    "*Uji Coba!*",
                                                                                                  );
                                                                                                  var whatsappUrl = Uri.parse("whatsapp://send?phone=62${patient.noTelp}&text=$text");
                                                                                                  try {
                                                                                                    launchUrl(whatsappUrl);
                                                                                                  } catch (e) {
                                                                                                    debugPrint(e.toString());
                                                                                                  }
                                                                                                },
                                                                                                label: 'Kirim Data'),
                                                                                          ),
                                                                                        ],
                                                                                      )
                                                                                    ],
                                                                                  ).paddingSymmetric(horizontal: 50, vertical: AppSizes.s80),
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
              Container(
                width: double.infinity,
                padding: AppSizes.symmetricPadding(
                    vertical: AppSizes.s20, horizontal: AppSizes.s41),
                child: Column(
                  children: [
                    Container(
                      //width: 400,
                      decoration: BoxDecoration(
                        color: AppColors.colorBaseWhite,
                        borderRadius: BorderRadius.circular(AppSizes.s4),
                      ),
                      child: Obx(() {
                        return NumberPaginator(
                          numberPages: controller.numberOfPage.value,
                          onPageChange: (int index) {
                            final page = index + 1;
                            controller.getPasien(page: page);
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
