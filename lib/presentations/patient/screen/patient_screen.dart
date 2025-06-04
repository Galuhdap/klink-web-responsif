import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:klinik_web_responsif/core/assets/assets.gen.dart';
import 'package:klinik_web_responsif/core/components/button_component.dart';
import 'package:klinik_web_responsif/core/components/custom_tabel_component.dart';
import 'package:klinik_web_responsif/core/components/input_data_component.dart';
import 'package:klinik_web_responsif/core/components/list_mobile_component.dart';
import 'package:klinik_web_responsif/core/components/search_new_component.dart';
import 'package:klinik_web_responsif/core/components/show_center_dialog.dart';
import 'package:klinik_web_responsif/core/config/responsive.dart';
import 'package:klinik_web_responsif/core/resources/constans/app_constants.dart';
import 'package:klinik_web_responsif/core/styles/app_colors.dart';
import 'package:klinik_web_responsif/core/styles/app_sizes.dart';
import 'package:klinik_web_responsif/core/utils/extensions/date_ext.dart';
import 'package:klinik_web_responsif/core/utils/extensions/sized_box_ext.dart';
import 'package:klinik_web_responsif/core/utils/helpers/validation_helper.dart';
import 'package:klinik_web_responsif/presentations/home/controllers/home_controller.dart';
import 'package:klinik_web_responsif/presentations/menu_dashboard/widget/build_app_bar.dart';
import 'package:klinik_web_responsif/presentations/patient/controller/patient_controller.dart';
import 'package:klinik_web_responsif/presentations/patient/screen/mobile/patient_list_mobile.dart';
import 'package:klinik_web_responsif/presentations/patient/screen/tabel/list_patient_tabel.dart';
import 'package:lottie/lottie.dart';
import 'package:number_paginator/number_paginator.dart';

class PatientScreen extends StatelessWidget {
  const PatientScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PatientController>(
        init: PatientController(),
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
                isMake: true,
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
                            : controller.postPasiens.value != null
                                ? Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    spacing: 20,
                                    children: [
                                      Container(
                                        width: 200,
                                        height: 200,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                                AppSizes.s100),
                                            color: AppColors.colorBasePrimary),
                                        child: Center(
                                          child: Text(
                                            controller.postPasiens.value!.data
                                                .nomerAntrian,
                                            style: Get.textTheme.labelLarge!
                                                .copyWith(
                                              fontSize: AppSizes.s100,
                                              color: AppColors.colorBaseWhite,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Center(
                                        child: Text(
                                          'Nomor Antrian Ditambahkan',
                                          style: Get.textTheme.labelLarge!
                                              .copyWith(
                                            fontSize: AppSizes.s24,
                                            color: AppColors.colorNeutrals200,
                                          ),
                                        ),
                                      ),
                                      Center(
                                        child: Button.filled(
                                          onPressed: () {
                                            controller.postPasiens.value = null;
                                            Get.put(HomeController());
                                            Get.back();
                                            Get.back();
                                            Get.back();
                                          },
                                          label: 'Selesai',
                                        ).paddingSymmetric(
                                          horizontal: AppSizes.s300,
                                        ),
                                      ),
                                    ],
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
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontSize: AppSizes.s14,
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
                                                  (context, selectedItem) {
                                                return Text(
                                                  selectedItem ??
                                                      "Jenis Kelamin",
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
                                              onChanged:
                                                  (String? selectedValue) {
                                                controller
                                                    .jenisKelaminController
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
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontSize: AppSizes.s14,
                                                      color: AppColors
                                                          .colorBaseBlack),
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
                                                controller.tglLahirController
                                                    .value = pickedDate;
                                              }
                                            }, child: Obx(() {
                                              return Container(
                                                padding:
                                                    AppSizes.symmetricPadding(
                                                        vertical: AppSizes.s5,
                                                        horizontal:
                                                            AppSizes.s20),
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color: AppColors
                                                        .colorSecondary400,
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
                                                          .tglLahirController
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
                                            })),
                                            AppSizes.s12.height,
                                          ],
                                        ),
                                        InputDataComponent(
                                          label: 'Alamat',
                                          hintText: 'Alamat',
                                          controller:
                                              controller.alamatController,
                                          validator: emptyValidation,
                                        ),
                                        InputDataComponent(
                                          label: 'No Telpon',
                                          hintText: 'No Telpon',
                                          controller:
                                              controller.noTelpController,
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
                                                  onPressed: () async {
                                                    if (controller
                                                        .formKey.currentState!
                                                        .validate()) {
                                                      await controller
                                                          .postPasien();
                                                      // await controller
                                                      //     .postAntrianPasien(
                                                      //         controller
                                                      //             .createPasien
                                                      //             .value!
                                                      //             .data
                                                      //             .id);
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
            body: Obx(
              () {
                return ListView(
                  children: [
                    Responsive.isDesktop(context)
                        ? CustomTabelComponent(
                            label: AppConstants.LABEL_DATA_PASIEN,
                            sizeRowTabel:
                                MediaQuery.of(context).size.width / 1.1,
                            sizeWidth: MediaQuery.of(context).size.width / 1,
                            border: TableBorder.all(
                              color: AppColors.colorBaseSecondary.withAlpha(50),
                            ),
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
                                            borderRadius: BorderRadius.circular(
                                                AppSizes.s4),
                                          ),
                                          child: Obx(() {
                                            return NumberPaginator(
                                              numberPages:
                                                  controller.numberOfPage.value,
                                              onPageChange: (int index) {
                                                final page = index + 1;
                                                controller.getPasien(
                                                  page: page,
                                                  name: controller
                                                      .namesearchController
                                                      .text,
                                                  nik: controller
                                                      .niksearchController.text,
                                                  umur: controller
                                                      .umursearchController
                                                      .text,
                                                  norme: controller
                                                      .normeearchController
                                                      .text,
                                                );
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
                            customContent: Container(
                              width: MediaQuery.of(context).size.width / 1.1,
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
                                        String nik = '';
                                        String umur = '';
                                        String norme = '';

                                        for (var part in parts) {
                                          if (RegExp(r'^\d{16}$')
                                              .hasMatch(part)) {
                                            nik = part;
                                          } else if (RegExp(
                                                  r'^(RM-\d+|\d{3,})$')
                                              .hasMatch(part)) {
                                            // cocokkan format RM-0001 atau 000001 (6 digit atau lebih)
                                            norme = part;
                                          } else if (int.tryParse(part) !=
                                                  null &&
                                              int.parse(part) <= 200) {
                                            umur = part;
                                          } else {
                                            name += '$part ';
                                          }
                                        }

                                        name = name.trim();

                                        controller.namesearchController.text =
                                            name;
                                        controller.niksearchController.text =
                                            nik;
                                        controller.umursearchController.text =
                                            umur;
                                        controller.normeearchController.text =
                                            norme;

                                        controller.getPasien(
                                          name: name.isNotEmpty ? name : '',
                                          nik: nik.isNotEmpty ? nik : '',
                                          umur: umur.isNotEmpty ? umur : '',
                                          norme: norme.isNotEmpty ? norme : '',
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            listColumns: getListPatientColumns(),
                            listRows: getRowsPatient(
                              context: context,
                              controller: controller,
                              data: controller.pasienList,
                              isLoading: controller.isLoading.value,
                            ),
                          )
                        : RefreshIndicator(
                            onRefresh: () async {
                              // await controller.getPasien();
                            },
                            child: ListMobileContainerComponent(
                              label: AppConstants.LABEL_DATA_PASIEN,
                              height: 480,
                              customSearch: Container(
                                padding: AppSizes.symmetricPadding(
                                  horizontal: AppSizes.s20,
                                ),
                                width: MediaQuery.of(context).size.width / 1.1,
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
                                          String nik = '';
                                          String umur = '';
                                          String norme = '';

                                          for (var part in parts) {
                                            if (RegExp(r'^\d{16}$')
                                                .hasMatch(part)) {
                                              nik = part;
                                            } else if (RegExp(
                                                    r'^(RM-\d+|\d{3,})$')
                                                .hasMatch(part)) {
                                              // cocokkan format RM-0001 atau 000001 (6 digit atau lebih)
                                              norme = part;
                                            } else if (int.tryParse(part) !=
                                                    null &&
                                                int.parse(part) <= 200) {
                                              umur = part;
                                            } else {
                                              name += '$part ';
                                            }
                                          }

                                          name = name.trim();

                                          controller.namesearchController.text =
                                              name;
                                          controller.niksearchController.text =
                                              nik;
                                          controller.umursearchController.text =
                                              umur;
                                          controller.normeearchController.text =
                                              norme;

                                          controller.getPasien(
                                            name: name.isNotEmpty ? name : '',
                                            nik: nik.isNotEmpty ? nik : '',
                                            umur: umur.isNotEmpty ? umur : '',
                                            norme:
                                                norme.isNotEmpty ? norme : '',
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              children: controller.isLoading.value
                                  ? Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  : ListView.builder(
                                      itemCount: controller.pasienList.length,
                                      // controller:
                                      //     controller.scrollControllerNew,
                                      // itemCount: controller.hasMore.value
                                      //     ? controller.pasienList.length + 1
                                      //     : controller.pasienList.length,
                                      itemBuilder:
                                          (BuildContext context, index) {
                                        var datas =
                                            controller.pasienList[index];
                                       return PatientListMobile(
                                          datas: datas,
                                          controller: controller,
                                        );
                                        // if (index <
                                        //     controller.pasienList.length) {
                                        //   return PatientListMobile(
                                        //     datas: datas,
                                        //     controller: controller,
                                        //   );
                                        // } else {
                                        //   return const Padding(
                                        //     padding: EdgeInsets.all(15),
                                        //     child: Center(
                                        //       child: CircularProgressIndicator(
                                        //         color: Colors.black,
                                        //       ),
                                        //     ),
                                        //   );
                                        // }
                                      },
                                    ),
                            ),
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
