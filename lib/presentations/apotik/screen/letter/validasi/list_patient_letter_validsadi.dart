import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:klinik_web_responsif/core/components/custom_tabel_component.dart';
import 'package:klinik_web_responsif/core/components/list_mobile_component.dart';
import 'package:klinik_web_responsif/core/components/search_new_component.dart';
import 'package:klinik_web_responsif/core/config/responsive.dart';
import 'package:klinik_web_responsif/core/resources/constans/app_constants.dart';
import 'package:klinik_web_responsif/core/styles/app_colors.dart';
import 'package:klinik_web_responsif/core/styles/app_sizes.dart';
import 'package:klinik_web_responsif/presentations/apotik/controller/apotik_controller.dart';
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
  });

  final PatientController controllerPatient;
  final HomeController controllerHome;
  final RekamMedisController controllerRme;
  final ApotikController contollerApotik;

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
                      onPressed: () {
                        contollerApotik.backToLetter();
                      },
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
                      controller: controllerPatient,
                      apotikController: contollerApotik,
                      homeController: controllerHome,
                      rmeController: controllerRme,
                      data: controllerPatient.pasienList,
                      isLoading: controllerPatient.isLoading.value,
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
