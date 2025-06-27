import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:klinik_web_responsif/core/assets/assets.gen.dart';
import 'package:klinik_web_responsif/core/components/button_component.dart';
import 'package:klinik_web_responsif/core/components/custom_tabel_component.dart';
import 'package:klinik_web_responsif/core/components/input_data_component.dart';
import 'package:klinik_web_responsif/core/components/modal/show_modal_tanda_tanya_component.dart';
import 'package:klinik_web_responsif/core/components/show_center_dialog.dart';
import 'package:klinik_web_responsif/core/styles/app_colors.dart';
import 'package:klinik_web_responsif/core/styles/app_sizes.dart';
import 'package:klinik_web_responsif/core/utils/extensions/date_ext.dart';
import 'package:klinik_web_responsif/core/utils/extensions/sized_box_ext.dart';
import 'package:klinik_web_responsif/core/utils/helpers/validation_helper.dart';
import 'package:klinik_web_responsif/presentations/docter/controller/docter_controller.dart';
import 'package:klinik_web_responsif/presentations/docter/screen/tabel/list_add_rme_tabel.dart';
import 'package:klinik_web_responsif/presentations/patient/controller/rekam_medis_controller.dart';
import 'package:lottie/lottie.dart';

class AddLetterRmeValidation extends StatelessWidget {
  const AddLetterRmeValidation({
    super.key,
    required this.controller,
    required this.controllerRme,
    this.id = '',
  });

  final DocterController controller;
  final RekamMedisController controllerRme;
  final String id;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.colorBaseWhite,
              borderRadius: BorderRadius.circular(
                AppSizes.s10,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withAlpha(40),
                  spreadRadius: 0,
                  blurRadius: 24,
                  offset: Offset(0, 0),
                ),
              ],
            ),
            child: Column(
              children: [
                Container(
                  padding: AppSizes.symmetricPadding(
                    vertical: AppSizes.s15,
                    horizontal: AppSizes.s15,
                  ),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.colorBasePrimary,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(AppSizes.s10),
                      topRight: Radius.circular(AppSizes.s10),
                    ),
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: id.isNotEmpty
                            ? () {
                                controller.idLatter.value = '';
                                controller.idPasienLetter.value = '';
                                //  print('sadsda');
                                controller.backEditLetterRme();
                                controller.backPatient();
                              }
                            : () {
                                controller.backAddLetterRme();
                              },
                        icon: Icon(Icons.arrow_back_ios_new_rounded,
                            color: AppColors.colorBaseWhite),
                      ),
                      AppSizes.s5.width,
                      Text(
                        'Surat Rekam Medis Electronic',
                        style: Get.textTheme.labelLarge!.copyWith(
                            fontSize: AppSizes.s17,
                            color: AppColors.colorBaseWhite),
                      ),
                    ],
                  ),
                ),
                Obx(
                  () {
                    return Padding(
                      padding: AppSizes.symmetricPadding(
                          vertical: AppSizes.s20, horizontal: AppSizes.s20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Nomor Rekam Medis',
                            style: Get.textTheme.bodyMedium!.copyWith(
                                fontSize: AppSizes.s17,
                                color: AppColors.colorBaseBlack),
                          ),
                          AppSizes.s10.height,
                          Text(
                            controller.noRekamMedisLetter.value,
                            style: Get.textTheme.labelLarge!.copyWith(
                                fontSize: AppSizes.s17,
                                color: AppColors.colorBaseBlack),
                          ),
                          Divider(
                            color: AppColors.colorBasePrimary,
                          ),
                          Text(
                            controller.namePasienLetter.value,
                            style: Get.textTheme.labelLarge!.copyWith(
                                fontSize: AppSizes.s20,
                                color: AppColors.colorBaseBlack),
                          ),
                          Text(
                            controller.jenisKelaminLetter.value,
                            style: Get.textTheme.labelLarge!.copyWith(
                                fontSize: AppSizes.s15,
                                color: AppColors.colorBaseBlack),
                          ),
                          Text(
                            controller.alamatLetter.value,
                            style: Get.textTheme.labelLarge!.copyWith(
                                fontSize: AppSizes.s15,
                                color: AppColors.colorBaseBlack),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          AppSizes.s20.height,
          id.isNotEmpty
              ? Container()
              : CustomTabelComponent(
                  label: "Rekam Medis Yang Diberikan",
                  // labelName: name,
                  sizeRowTabel: MediaQuery.of(context).size.width / 1.1,
                  sizeWidth: MediaQuery.of(context).size.width / 1,
                  border: TableBorder.all(
                    color: AppColors.colorBaseSecondary.withAlpha(50),
                  ),
                  listColumns: getListLetterRMEColumns(),
                  listRows: getRowsLetterRME(
                    context: context,
                    controller: controllerRme,
                    data: controllerRme.rmePasientList,
                    isLoading: controllerRme.isLoadingRMEId.value,
                  ),
                ),
          AppSizes.s20.height,
          Container(
            decoration: BoxDecoration(
              color: AppColors.colorBaseWhite,
              borderRadius: BorderRadius.circular(
                AppSizes.s10,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withAlpha(40),
                  spreadRadius: 0,
                  blurRadius: 24,
                  offset: Offset(0, 0),
                ),
              ],
            ),
            child: Column(
              children: [
                Form(
                  key: controller.formKeyNewPost,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InputDataComponent(
                        label: 'Pekerjaan',
                        hintText: 'Pekerjaan',
                        controller: controller.jobController,
                        validator: emptyValidation,
                      ),
                      InputDataComponent(
                        label: 'Keperluan',
                        hintText: 'Keperluan',
                        controller: controller.keperluanController,
                        validator: emptyValidation,
                      ),
                      AppSizes.s10.height,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Pilih Tanggal Keperluan',
                            style: Get.textTheme.bodyMedium!.copyWith(
                                fontWeight: FontWeight.w700,
                                fontSize: AppSizes.s12,
                                color: AppColors.colorBaseBlack),
                          ),
                          AppSizes.s5.height,
                          Obx(
                            () {
                              return InkWell(
                                onTap: () async {
                                  List<DateTime?>? selectedDates =
                                      await showCalendarDatePicker2Dialog(
                                    context: context,
                                    config:
                                        CalendarDatePicker2WithActionButtonsConfig(
                                      calendarType:
                                          CalendarDatePicker2Type.range,
                                      firstDate: DateTime(2000),
                                      lastDate: DateTime(2050),
                                    ),
                                    dialogSize: const Size(325, 400),
                                    value: controller.selectedDateRange,
                                    borderRadius: BorderRadius.circular(15),
                                  );

                                  if (selectedDates != null) {
                                    controller.selectedDateRange.value =
                                        selectedDates;
                                  }
                                },
                                child: Container(
                                  height: 50,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.circular(AppSizes.s4),
                                    border:
                                        Border.all(color: Color(0xfffF0F0F0)),
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
                                                controller
                                                        .selectedDateRange[0] !=
                                                    null
                                            ? '${controller.selectedDateRange[0]!.toDateddmmFormattedString()} - ${controller.selectedDateRange[1]!.toDateddmmFormattedString()}'
                                            : 'Pilih Range Tanggal',
                                        style:
                                            Get.textTheme.labelMedium!.copyWith(
                                          fontSize: AppSizes.s14,
                                          fontWeight: FontWeight.w100,
                                          color: AppColors.colorBaseBlack,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                      Divider(),
                      Container(
                        width: 150,
                        child: Button.filled(
                            onPressed: id.isNotEmpty
                                ? () {
                                    showModalCenter(
                                      context,
                                      Obx(
                                        () {
                                          return controller
                                                  .isLoadingUpdateLetterRme
                                                  .value
                                              ? Center(
                                                  child: SizedBox(
                                                    width: 400,
                                                    height: 400,
                                                    child: Lottie.asset(
                                                        Assets.lottie.hospital),
                                                  ),
                                                )
                                              : ShowModalTandaTanyaComponent(
                                                  label:
                                                      'Apakah Anda Yakin Untuk Mengubah Surat Rme ?',
                                                  onTapNo: () {
                                                    Get.back();
                                                  },
                                                  onTapYes: () async {
                                                    if (controller
                                                        .formKeyNewPost
                                                        .currentState!
                                                        .validate()) {
                                                      controller.putLatterRme();
                                                    }
                                                  },
                                                );
                                        },
                                      ),
                                    );
                                  }
                                : () {
                                    showModalCenter(
                                      context,
                                      Obx(
                                        () {
                                          return controller
                                                  .isLoadingPostLetterRme.value
                                              ? Center(
                                                  child: SizedBox(
                                                    width: 400,
                                                    height: 400,
                                                    child: Lottie.asset(
                                                        Assets.lottie.hospital),
                                                  ),
                                                )
                                              : ShowModalTandaTanyaComponent(
                                                  label:
                                                      'Apakah Anda Yakin Untuk Menambahkan Surat RME?',
                                                  onTapNo: () {
                                                    Get.back();
                                                  },
                                                  onTapYes: () async {
                                                    if (controller
                                                        .formKeyNewPost
                                                        .currentState!
                                                        .validate()) {
                                                      controller
                                                          .postLatterRme();
                                                      // controller
                                                      //     .postLatterHealt();
                                                    }
                                                  },
                                                );
                                        },
                                      ),
                                    );
                                  },
                            label: 'Simpan'),
                      ),
                    ],
                  ).paddingSymmetric(
                      vertical: AppSizes.s20, horizontal: AppSizes.s20),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
