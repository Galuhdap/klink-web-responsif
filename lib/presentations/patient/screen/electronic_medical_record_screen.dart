import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:klinik_web_responsif/core/components/custom_tabel_component.dart';
import 'package:klinik_web_responsif/core/components/search_new_component.dart';
import 'package:klinik_web_responsif/core/config/responsive.dart';
import 'package:klinik_web_responsif/core/resources/constans/app_constants.dart';
import 'package:klinik_web_responsif/core/styles/app_colors.dart';
import 'package:klinik_web_responsif/core/styles/app_sizes.dart';
import 'package:klinik_web_responsif/core/utils/extensions/date_ext.dart';
import 'package:klinik_web_responsif/core/utils/extensions/sized_box_ext.dart';
import 'package:klinik_web_responsif/presentations/apotik/controller/apotik_controller.dart';
import 'package:klinik_web_responsif/presentations/menu_dashboard/widget/build_app_bar.dart';
import 'package:klinik_web_responsif/presentations/patient/controller/rekam_medis_controller.dart';
import 'package:klinik_web_responsif/presentations/patient/screen/add_rme_screen.dart';
import 'package:klinik_web_responsif/presentations/patient/screen/tabel/list_electronic_medical_record_tabel.dart';
import 'package:number_paginator/number_paginator.dart';

class ElectronicMedicalRecordScreen extends StatelessWidget {
  const ElectronicMedicalRecordScreen(
      {super.key,
      required this.name,
      required this.rme,
      this.addRme = true,
      required this.id_pasien});

  final String name;
  final String rme;
  final String id_pasien;
  final bool addRme;

  @override
  Widget build(BuildContext context) {
    var controllerAp = Get.put(ApotikController());
    return GetBuilder<RekamMedisController>(
        init: RekamMedisController(),
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
                onTapButton: () {},
              ),
            ),
            body: Obx(
              () {
                return ListView(
                  children: [
                    Responsive.isDesktop(context)
                        ? controller.isDetailView.value
                            ? AddRmeScreen(
                                controller: controllerAp,
                                controllerRme: controller,
                                norme: rme,
                                name: name,
                                idPasien: id_pasien,
                              )
                            : CustomTabelComponent(
                                label: AppConstants.LABEL_DAFTAR_REKAM_MEDIS,
                                labelName: name,
                                sizeRowTabel:
                                    MediaQuery.of(context).size.width / 1.05,
                                sizeWidth:
                                    MediaQuery.of(context).size.width / 1,
                                border: TableBorder.all(
                                  color: AppColors.colorBaseSecondary
                                      .withAlpha(50),
                                ),
                                arrowBack: IconButton(
                                  onPressed: () {
                                    Get.back();
                                  },
                                  icon: Icon(
                                    Icons.arrow_back_ios_new_rounded,
                                    color: AppColors.colorBaseWhite,
                                  ),
                                ),
                                customContentButton: InkWell(
                                  onTap: addRme
                                      ? () {
                                          controller.showDetail();
                                        }
                                      : () {},
                                  child: Container(
                                    padding: AppSizes.symmetricPadding(
                                      vertical: AppSizes.s5,
                                      horizontal: AppSizes.s10,
                                    ),
                                    decoration: BoxDecoration(
                                      color: AppColors.colorSuccess300,
                                      borderRadius:
                                          BorderRadius.circular(AppSizes.s5),
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(
                                          addRme
                                              ? Icons.add_outlined
                                              : Icons.print,
                                          color: AppColors.colorBaseWhite,
                                        ),
                                        Text(
                                          addRme
                                              ? 'Catat Rekam Medis'
                                              : 'Cetak Rekam Medis',
                                          style: Get.textTheme.labelLarge!
                                              .copyWith(
                                            fontSize: AppSizes.s11,
                                            color: AppColors.colorBaseWhite,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
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
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        AppSizes.s4),
                                              ),
                                              child: Obx(() {
                                                return NumberPaginator(
                                                  numberPages: controller
                                                      .numberOfPage.value,
                                                  onPageChange: (int index) {
                                                    final page = index + 1;
                                                    final dateFormat =
                                                        DateFormat(
                                                            'yyyy-MM-dd');
                                                    controller.getRmePasien(
                                                      page: page,
                                                      keluhan: controller
                                                          .keluhanSearch.value,
                                                      start_date: controller
                                                              .selectedDateRange
                                                              .isNotEmpty
                                                          ? dateFormat.format(
                                                              controller
                                                                  .selectedDateRange[0]!)
                                                          : "",
                                                      end_date: controller
                                                              .selectedDateRange
                                                              .isNotEmpty
                                                          ? dateFormat.format(
                                                              controller
                                                                  .selectedDateRange[1]!)
                                                          : "",
                                                    );
                                                  },
                                                  child: const SizedBox(
                                                    height: 48,
                                                    width: 300,
                                                    child: Row(
                                                      children: [
                                                        PrevButton(),
                                                        Expanded(
                                                          child:
                                                              NumberContent(),
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
                                customContent: Row(
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
                                          controller:
                                              controller.searchController,
                                          keyboardType: TextInputType.name,
                                          hintText: AppConstants.LABEL_CARI,
                                          suffixIcon: const Icon(
                                            Icons.search,
                                            color: AppColors.colorSecondary500,
                                          ),
                                          onChanged: (value) {
                                            String keluhan = '';

                                            controller.keluhanSearch.value =
                                                name;

                                            keluhan = keluhan.trim();
                                            final dateFormat =
                                                DateFormat('yyyy-MM-dd');

                                            controller.getRmePasien(
                                                keluhan: keluhan,
                                                start_date: controller
                                                        .selectedDateRange
                                                        .isNotEmpty
                                                    ? dateFormat.format(controller
                                                        .selectedDateRange[0]!)
                                                    : "",
                                                end_date: controller
                                                        .selectedDateRange
                                                        .isNotEmpty
                                                    ? dateFormat.format(controller
                                                        .selectedDateRange[1]!)
                                                    : "",
                                                id: id_pasien);
                                          },
                                        ),
                                      ),
                                    ),
                                    AppSizes.s10.width,
                                    InkWell(
                                      onTap: () async {
                                        List<DateTime?>? selectedDates =
                                            await showCalendarDatePicker2Dialog(
                                          context: context,
                                          config:
                                              CalendarDatePicker2WithActionButtonsConfig(
                                            calendarType:
                                                CalendarDatePicker2Type.range,
                                            firstDate: DateTime(2000),
                                            lastDate: DateTime.now(),
                                          ),
                                          dialogSize: const Size(325, 400),
                                          value: controller.selectedDateRange,
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        );

                                        if (selectedDates != null) {
                                          controller.selectedDateRange.value =
                                              selectedDates;
                                          final dateFormat =
                                              DateFormat('yyyy-MM-dd');
                                          print(dateFormat.format(controller
                                              .selectedDateRange[0]!));
                                          print(dateFormat.format(controller
                                              .selectedDateRange[1]!));
                                          await controller.getRmePasien(
                                              keluhan: controller
                                                  .keluhanSearch.value,
                                              start_date: dateFormat.format(
                                                  controller
                                                      .selectedDateRange[0]!),
                                              end_date: dateFormat.format(
                                                  controller
                                                      .selectedDateRange[1]!),
                                              id: id_pasien);
                                        }
                                      },
                                      child: Container(
                                        width: 300,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              AppSizes.s4),
                                          border: Border.all(
                                              color: Color(0xfffF0F0F0)),
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
                                              controller.selectedDateRange
                                                          .isNotEmpty &&
                                                      controller.selectedDateRange[
                                                              0] !=
                                                          null
                                                  ? '${controller.selectedDateRange[0]!.toDateddmmFormattedString()} - ${controller.selectedDateRange[1]!.toDateddmmFormattedString()}'
                                                  : 'Pilih Range Tanggal',
                                              style: Get.textTheme.labelMedium!
                                                  .copyWith(
                                                fontSize: AppSizes.s14,
                                                fontWeight: FontWeight.w100,
                                                color: AppColors.colorBaseBlack,
                                              ),
                                            ),
                                            AppSizes.s10.width,
                                            controller.selectedDateRange
                                                    .isNotEmpty
                                                ? IconButton(
                                                    onPressed: () {
                                                      controller
                                                          .selectedDateRange
                                                          .value = [];
                                                      controller.getRmePasien(
                                                          start_date: "",
                                                          end_date: "",
                                                          id: id_pasien);
                                                    },
                                                    icon: Icon(
                                                      Icons.delete,
                                                    ))
                                                : Container(),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                listColumns: getListRMEColumns(),
                                listRows: getRowsRME(
                                  context: context,
                                  controller: controller,
                                  data: controller.rmePasientList,
                                  isLoading: controller.isLoadingRMEId.value,
                                ),
                              )
                        : Container()
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
