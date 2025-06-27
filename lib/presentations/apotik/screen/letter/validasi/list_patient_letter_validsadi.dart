import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:klinik_web_responsif/core/components/custom_tabel_component.dart';
import 'package:klinik_web_responsif/core/components/list_mobile_component.dart';
import 'package:klinik_web_responsif/core/components/search_new_component.dart';
import 'package:klinik_web_responsif/core/config/responsive.dart';
import 'package:klinik_web_responsif/core/resources/constans/app_constants.dart';
import 'package:klinik_web_responsif/core/styles/app_colors.dart';
import 'package:klinik_web_responsif/core/styles/app_sizes.dart';
import 'package:klinik_web_responsif/core/utils/extensions/date_ext.dart';
import 'package:klinik_web_responsif/core/utils/extensions/sized_box_ext.dart';
import 'package:klinik_web_responsif/presentations/apotik/controller/apotik_controller.dart';
import 'package:klinik_web_responsif/presentations/docter/controller/docter_controller.dart';
import 'package:klinik_web_responsif/presentations/home/controllers/home_controller.dart';
import 'package:klinik_web_responsif/presentations/patient/controller/patient_controller.dart';
import 'package:klinik_web_responsif/presentations/patient/controller/rekam_medis_controller.dart';
import 'package:klinik_web_responsif/presentations/patient/screen/mobile/patient_list_mobile.dart';
import 'package:klinik_web_responsif/presentations/patient/screen/tabel/list_patient_tabel.dart';
import 'package:number_paginator/number_paginator.dart';

class ListPastientLatterValidation extends StatelessWidget {
  const ListPastientLatterValidation({
    super.key,
    required this.controllerPatient,
    required this.controllerHome,
    required this.contollerApotik,
    required this.controllerRme,
    required this.onPressed,
    this.controllerDocter,
    this.isMakeDokter,
  });

  final PatientController controllerPatient;
  final HomeController controllerHome;
  final RekamMedisController controllerRme;
  final ApotikController contollerApotik;
  final DocterController? controllerDocter;
  final bool? isMakeDokter;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return Expanded(
            child: ListView(
          children: [
            Responsive.isDesktop(context)
                ? CustomTabelComponent(
                    label: AppConstants.LABEL_DATA_PASIEN,
                    arrowBack: IconButton(
                      onPressed: onPressed,
                      icon: Icon(
                        Icons.arrow_back,
                        color: AppColors.colorBaseWhite,
                      ),
                    ),
                    sizeRowTabel: MediaQuery.of(context).size.width / 1.1,
                    sizeWidth: MediaQuery.of(context).size.width / 1,
                    border: TableBorder.all(
                      color: AppColors.colorBaseSecondary.withAlpha(50),
                    ),
                    customContentPagination:
                        controllerPatient.numberOfPageGetPasien.value <= 1
                            ? Container()
                            : Container(
                                width: double.infinity,
                                padding:
                                    AppSizes.onlyPadding(bottom: AppSizes.s50),
                                child: Column(
                                  children: [
                                    Container(
                                      //width: 400,
                                      decoration: BoxDecoration(
                                        color: AppColors.colorBaseWhite,
                                        borderRadius:
                                            BorderRadius.circular(AppSizes.s4),
                                      ),
                                      child: Obx(() {
                                        return NumberPaginator(
                                          numberPages: controllerPatient
                                              .numberOfPageGetPasien.value,
                                          onPageChange: (int index) async {
                                            final page = index + 1;

                                            await controllerPatient.getPasien(
                                              page: page,
                                              name: controllerPatient
                                                  .namesearchController.text,
                                              nik: controllerPatient
                                                  .niksearchController.text,
                                              umur: controllerPatient
                                                  .umursearchController.text,
                                              norme: controllerPatient
                                                  .normeearchController.text,
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
                            color: AppColors.colorNeutrals300.withAlpha(40),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Flexible(
                            child: SearchNewComponent(
                              controller: controllerPatient.searchController,
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
                                  if (RegExp(r'^\d{16}$').hasMatch(part)) {
                                    nik = part;
                                  } else if (RegExp(r'^(RM-\d+|\d{3,})$')
                                      .hasMatch(part)) {
                                    // cocokkan format RM-0001 atau 000001 (6 digit atau lebih)
                                    norme = part;
                                  } else if (int.tryParse(part) != null &&
                                      int.parse(part) <= 200) {
                                    umur = part;
                                  } else {
                                    name += '$part ';
                                  }
                                }

                                name = name.trim();

                                controllerPatient.namesearchController.text =
                                    name;
                                controllerPatient.niksearchController.text =
                                    nik;
                                controllerPatient.umursearchController.text =
                                    umur;
                                controllerPatient.normeearchController.text =
                                    norme;

                                controllerPatient.getPasien(
                                    name: controllerPatient
                                        .namesearchController.text,
                                    nik: nik.isNotEmpty ? nik : '',
                                    umur: umur.isNotEmpty ? umur : '',
                                    norme: norme.isNotEmpty ? norme : '',
                                    tahun_lahir:
                                        controllerPatient.selectedYear.value,
                                    tgl_lahir: controllerPatient
                                        .selectedDateString.value);
                              },
                            ),
                          ),
                          AppSizes.s10.width,
                          InkWell(
                            onTap: () async {
                              controllerPatient.selectedYear.value = '';

                              final DateTime? picked = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1900),
                                lastDate: DateTime(2100),
                                initialDatePickerMode: DatePickerMode
                                    .day, // Buka langsung di Year Picker
                              );

                              if (picked != null) {
                                controllerPatient.selectedDateString.value =
                                    picked.toString();
                                await controllerPatient.getPasien(
                                    //page: page,
                                    name: controllerPatient
                                        .namesearchController.text,
                                    nik: controllerPatient
                                        .niksearchController.text,
                                    umur: controllerPatient
                                        .umursearchController.text,
                                    norme: controllerPatient
                                        .normeearchController.text,
                                    tgl_lahir: controllerPatient
                                        .selectedDateString.value);
                              }
                            },
                            child: Container(
                              // width: 250,
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(AppSizes.s4),
                                border: Border.all(color: Color(0xfffF0F0F0)),
                                color: AppColors.colorBaseWhite,
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
                                spacing: 20,
                                children: [
                                  AppSizes.s10.width,
                                  Icon(Icons.calendar_month_rounded),
                                  Text(
                                    controllerPatient
                                                .selectedDateString.value !=
                                            ''
                                        ? '${DateTime.parse(controllerPatient.selectedDateString.value).toDateddmmmyyyyFormattedString()}'
                                        : 'Pilih Berdarakan Tanggal Lahir',
                                    style: Get.textTheme.labelMedium!.copyWith(
                                      fontSize: AppSizes.s14,
                                      fontWeight: FontWeight.w100,
                                      color: AppColors.colorBaseBlack,
                                    ),
                                  ),
                                  AppSizes.s10.width,
                                  controllerPatient.selectedDateString.value !=
                                          ''
                                      ? IconButton(
                                          onPressed: () async {
                                            controllerPatient
                                                .selectedYear.value = '';
                                            controllerPatient
                                                .selectedDateString.value = '';
                                            await controllerPatient.getPasien(
                                                //page: page,
                                                tahun_lahir: '',
                                                tgl_lahir: '');
                                          },
                                          icon: Icon(
                                            Icons.delete,
                                          ))
                                      : Container(),
                                ],
                              ),
                            ),
                          ),
                          AppSizes.s10.width,
                          InkWell(
                            onTap: () async {
                              controllerPatient.selectedDateString.value = '';
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('Pilih Tahun Lahir'),
                                    content: SizedBox(
                                      width: 300,
                                      height: 300,
                                      child: YearPicker(
                                        firstDate: DateTime(1900),
                                        lastDate: DateTime(2050),
                                        selectedDate: DateTime.now(),
                                        onChanged: (DateTime newYear) async {
                                          controllerPatient.selectedYear.value =
                                              newYear.year.toString();
                                          await controllerPatient.getPasien(
                                              //page: page,
                                              name: controllerPatient
                                                  .namesearchController.text,
                                              nik: controllerPatient
                                                  .niksearchController.text,
                                              umur: controllerPatient
                                                  .umursearchController.text,
                                              norme: controllerPatient
                                                  .normeearchController.text,
                                              tahun_lahir: controllerPatient
                                                  .selectedYear.value);
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(AppSizes.s4),
                                border: Border.all(color: Color(0xfffF0F0F0)),
                                color: AppColors.colorBaseWhite,
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
                                spacing: 20,
                                children: [
                                  AppSizes.s10.width,
                                  Icon(Icons.calendar_month_rounded),
                                  Text(
                                    controllerPatient.selectedYear.value != ''
                                        ? '${controllerPatient.selectedYear.value}'
                                        : 'Pilih Berdasarkan Tahun Lahir',
                                    style: Get.textTheme.labelMedium!.copyWith(
                                      fontSize: AppSizes.s14,
                                      fontWeight: FontWeight.w100,
                                      color: AppColors.colorBaseBlack,
                                    ),
                                  ),
                                  AppSizes.s10.width,
                                  Obx(() {
                                    return controllerPatient
                                                .selectedYear.value !=
                                            ''
                                        ? IconButton(
                                            onPressed: () async {
                                              controllerPatient
                                                  .selectedYear.value = '';
                                              await controllerPatient.getPasien(
                                                  name: controllerPatient
                                                      .namesearchController
                                                      .text,
                                                  nik: controllerPatient
                                                      .niksearchController.text,
                                                  umur: controllerPatient
                                                      .umursearchController
                                                      .text,
                                                  norme: controllerPatient
                                                      .normeearchController
                                                      .text,
                                                  tahun_lahir: '',
                                                  tgl_lahir: '');
                                            },
                                            icon: Icon(
                                              Icons.delete,
                                            ))
                                        : Container();
                                  })
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    listColumns: getListPatientColumns(),
                    listRows: getRowsPatient(
                        context: context,
                        controller: controllerPatient,
                        apotikController: contollerApotik,
                        homeController: controllerHome,
                        rmeController: controllerRme,
                        docterController: controllerDocter,
                        data: controllerPatient.pasienList,
                        isLoading: controllerPatient.isLoading.value,
                        isMakeDokter: isMakeDokter),
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
                              color: AppColors.colorNeutrals300.withAlpha(40),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Flexible(
                              child: SearchNewComponent(
                                controller: controllerPatient.searchController,
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
                                    if (RegExp(r'^\d{16}$').hasMatch(part)) {
                                      nik = part;
                                    } else if (RegExp(r'^(RM-\d+|\d{3,})$')
                                        .hasMatch(part)) {
                                      // cocokkan format RM-0001 atau 000001 (6 digit atau lebih)
                                      norme = part;
                                    } else if (int.tryParse(part) != null &&
                                        int.parse(part) <= 200) {
                                      umur = part;
                                    } else {
                                      name += '$part ';
                                    }
                                  }

                                  name = name.trim();

                                  controllerPatient.namesearchController.text =
                                      name;
                                  controllerPatient.niksearchController.text =
                                      nik;
                                  controllerPatient.umursearchController.text =
                                      umur;
                                  controllerPatient.normeearchController.text =
                                      norme;

                                  controllerPatient.getPasien(
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
                      children: controllerPatient.isLoading.value
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : ListView.builder(
                              itemCount: controllerPatient.pasienList.length,
                              // controller:
                              //     controller.scrollControllerNew,
                              // itemCount: controller.hasMore.value
                              //     ? controller.pasienList.length + 1
                              //     : controller.pasienList.length,
                              itemBuilder: (BuildContext context, index) {
                                var datas = controllerPatient.pasienList[index];
                                return PatientListMobile(
                                  datas: datas,
                                  controller: controllerPatient,
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
        ));
      },
    );
  }
}
