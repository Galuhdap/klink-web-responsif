import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:klinik_web_responsif/core/assets/assets.gen.dart';
import 'package:klinik_web_responsif/core/components/button_component.dart';
import 'package:klinik_web_responsif/core/components/input_data_component.dart';
import 'package:klinik_web_responsif/core/components/modal/show_modal_tanda_tanya_component.dart';
import 'package:klinik_web_responsif/core/components/show_center_dialog.dart';
import 'package:klinik_web_responsif/core/styles/app_colors.dart';
import 'package:klinik_web_responsif/core/styles/app_sizes.dart';
import 'package:klinik_web_responsif/core/utils/extensions/date_ext.dart';
import 'package:klinik_web_responsif/core/utils/extensions/sized_box_ext.dart';
import 'package:klinik_web_responsif/core/utils/helpers/validation_helper.dart';
import 'package:klinik_web_responsif/presentations/apotik/controller/apotik_controller.dart';
import 'package:lottie/lottie.dart';

class AddLetterSickValidation extends StatelessWidget {
  const AddLetterSickValidation({
    super.key,
    required this.controller,
    this.id = '',
  });

  final ApotikController controller;
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
                        onPressed: id.isEmpty
                            ? () {
                                controller.selectedIndexMail.value = 0;
                                controller.alamatLetter.value = '';
                                controller.namePasienLetter.value = '';
                                controller.idPasienLetter.value = '';
                                controller.jenisKelaminLetter.value = '';
                                controller.noRekamMedisLetter.value = '';
                                controller.jobController.text = '';
                                controller.diagnosaController.text = '';
                                controller.keluhanController.text = '';
                                controller.selectedDateRangeLetterSick.value =
                                    [];
                                controller.periodLatter.value = '';
                              //  controller.idLatter.value = '';
                                controller.backToAddMailSick();
                              }
                            : () {
                                controller.selectedIndexMail.value = 0;
                                controller.alamatLetter.value = '';
                                controller.namePasienLetter.value = '';
                                controller.idPasienLetter.value = '';
                                controller.jenisKelaminLetter.value = '';
                                controller.noRekamMedisLetter.value = '';
                                controller.jobController.text = '';
                                controller.diagnosaController.text = '';
                                controller.keluhanController.text = '';
                                controller.selectedDateRangeLetterSick.value =
                                    [];
                                controller.periodLatter.value = '';
                               // controller.idLatter.value = '';
                                controller.backToLetter();
                              },
                        icon: Icon(Icons.arrow_back_ios_new_rounded,
                            color: AppColors.colorBaseWhite),
                      ),
                      AppSizes.s5.width,
                      Text(
                        'Surat Sakit',
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
          Row(
            spacing: 20,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Obx(
              //   () {
              //     return CustomTabelComponent(
              //       label: 'Pilih Dokter',
              //       sizeWidth: MediaQuery.of(context).size.width / 3.2,
              //       border: TableBorder.all(
              //         color: AppColors.colorBaseSecondary.withAlpha(50),
              //       ),
              //       sizeRowTabel: MediaQuery.of(context).size.width / 3.2,
              //       customContentPagination: controller
              //                   .numberOfPageUnit.value ==
              //               0
              //           ? Container()
              //           : Center(
              //               child: Container(
              //                 width: MediaQuery.of(context).size.width / 3.2,
              //                 padding: AppSizes.onlyPadding(
              //                   bottom: AppSizes.s20,
              //                 ),
              //                 child: Column(
              //                   children: [
              //                     Container(
              //                       //width: 400,
              //                       decoration: BoxDecoration(
              //                         color: AppColors.colorBaseWhite,
              //                         borderRadius:
              //                             BorderRadius.circular(AppSizes.s4),
              //                       ),
              //                       child: Obx(() {
              //                         return NumberPaginator(
              //                           numberPages:
              //                               controller.numberOfPageUnit.value,
              //                           onPageChange: (int index) {
              //                             final page = index + 1;

              //                             controller.getUnit(
              //                                 page: page,
              //                                 name: controller.nameUnit.value);
              //                           },
              //                           child: const SizedBox(
              //                             height: 48,
              //                             width: 300,
              //                             child: Row(
              //                               children: [
              //                                 PrevButton(),
              //                                 Expanded(
              //                                   child: NumberContent(),
              //                                 ),
              //                                 NextButton(),
              //                               ],
              //                             ),
              //                           ),
              //                         );
              //                       }),
              //                     ),
              //                   ],
              //                 ),
              //               ),
              //             ),
              //       customContent: Container(
              //         width: MediaQuery.of(context).size.width / 3.2,
              //         decoration: BoxDecoration(
              //           boxShadow: [
              //             BoxShadow(
              //               offset: const Offset(0, 0),
              //               blurRadius: 15,
              //               spreadRadius: 0,
              //               color: AppColors.colorNeutrals300.withAlpha(40),
              //             ),
              //           ],
              //         ),
              //         child: SearchNewComponent(
              //           controller: controller.searchController,
              //           keyboardType: TextInputType.name,
              //           hintText: AppConstants.LABEL_CARI,
              //           suffixIcon: const Icon(
              //             Icons.search,
              //             color: AppColors.colorSecondary500,
              //           ),
              //           onChanged: (value) {
              //             final name = value.trim();
              //             controller.nameUnit.value = name;
              //             controller.getUnit(name: name);
              //           },
              //         ),
              //       ),
              //       listColumns: getListDocterColumns(),
              //       listRows: getListDocterRow(
              //         data: controller.unitList,
              //         isLoading: controller.isLoadingUnit.value,
              //         controller: controller,
              //         context: context,
              //       ),
              //     );
              //   },
              // ),
              Flexible(
                child: Obx(
                  () {
                    return Container(
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
                                  label: 'Keluhan',
                                  hintText: 'Keluhan',
                                  controller: controller.keluhanController,
                                  validator: emptyValidation,
                                ),
                                InputDataComponent(
                                  label: 'Diagnosa',
                                  hintText: 'Diagnosa',
                                  controller: controller.diagnosaController,
                                  validator: emptyValidation,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Pilih Periode Istirahat',
                                      style: Get.textTheme.bodyMedium!.copyWith(
                                          fontWeight: FontWeight.w700,
                                          fontSize: AppSizes.s14,
                                          color: AppColors.colorBaseBlack),
                                    ),
                                    AppSizes.s12.height,
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
                                            lastDate: DateTime(2045),
                                          ),
                                          dialogSize: const Size(325, 400),
                                          value: controller
                                              .selectedDateRangeLetterSick,
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        );

                                        if (selectedDates != null) {
                                          controller.selectedDateRangeLetterSick
                                              .value = selectedDates;

                                          if (controller
                                                      .selectedDateRangeLetterSick
                                                      .length ==
                                                  2 &&
                                              controller.selectedDateRangeLetterSick[
                                                      0] !=
                                                  null &&
                                              controller.selectedDateRangeLetterSick[
                                                      1] !=
                                                  null) {
                                            final start = controller
                                                .selectedDateRangeLetterSick[0]!;
                                            final end = controller
                                                .selectedDateRangeLetterSick[1]!;

                                            final duration =
                                                end.difference(start).inDays +
                                                    1;
                                            controller.periodLatter.value =
                                                duration.toString();
                                          }
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
                                              controller.selectedDateRangeLetterSick
                                                          .isNotEmpty &&
                                                      controller.selectedDateRangeLetterSick[
                                                              0] !=
                                                          null
                                                  ? '${controller.selectedDateRangeLetterSick[0]!.toDateddmmFormattedString()} - ${controller.selectedDateRangeLetterSick[1]!.toDateddmmFormattedString()}'
                                                  : 'Pilih Range Tanggal',
                                              style: Get.textTheme.labelMedium!
                                                  .copyWith(
                                                fontSize: AppSizes.s14,
                                                fontWeight: FontWeight.w100,
                                                color: AppColors.colorBaseBlack,
                                              ),
                                            ),
                                            AppSizes.s10.width,
                                            controller
                                                    .selectedDateRangeLetterSick
                                                    .isNotEmpty
                                                ? IconButton(
                                                    onPressed: () {
                                                      controller
                                                          .selectedDateRangeLetterSick
                                                          .value = [];
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
                                AppSizes.s20.height,
                                Center(
                                  child: Text(
                                    'Periode Istirahat Selama ${controller.selectedDateRangeLetterSick.isNotEmpty ? controller.periodLatter.value : '________'} hari Dimulai Tanggal ${controller.selectedDateRangeLetterSick.isNotEmpty && controller.selectedDateRangeLetterSick[0] != null ? controller.selectedDateRangeLetterSick[0]!.toDateddmmFormattedString() : '________'} Sampai ${controller.selectedDateRangeLetterSick.isNotEmpty && controller.selectedDateRangeLetterSick[0] != null ? controller.selectedDateRangeLetterSick[1]!.toDateddmmFormattedString() : '________'}',
                                    style: Get.textTheme.bodyMedium!.copyWith(
                                        fontWeight: FontWeight.w700,
                                        fontSize: AppSizes.s14,
                                        color: AppColors.colorBaseBlack),
                                  ),
                                ),
                                AppSizes.s20.height,
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
                                                            .isLoadingPostSickLetter
                                                            .value
                                                        ? Center(
                                                            child: SizedBox(
                                                              width: 400,
                                                              height: 400,
                                                              child: Lottie
                                                                  .asset(Assets
                                                                      .lottie
                                                                      .hospital),
                                                            ),
                                                          )
                                                        : ShowModalTandaTanyaComponent(
                                                            label:
                                                                'Apakah Anda Yakin Untuk Mengubah Surat Sakit ?',
                                                            onTapNo: () {
                                                              Get.back();
                                                            },
                                                            onTapYes: () async {
                                                              if (controller
                                                                  .formKeyNewPost
                                                                  .currentState!
                                                                  .validate()) {
                                                                controller
                                                                    .putLatterSick();
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
                                                            .isLoadingPostSickLetter
                                                            .value
                                                        ? Center(
                                                            child: SizedBox(
                                                              width: 400,
                                                              height: 400,
                                                              child: Lottie
                                                                  .asset(Assets
                                                                      .lottie
                                                                      .hospital),
                                                            ),
                                                          )
                                                        : ShowModalTandaTanyaComponent(
                                                            label:
                                                                'Apakah Anda Yakin Untuk Menambahkan Surat Sakit Baru ?',
                                                            onTapNo: () {
                                                              Get.back();
                                                            },
                                                            onTapYes: () async {
                                                              if (controller
                                                                  .formKeyNewPost
                                                                  .currentState!
                                                                  .validate()) {
                                                                controller
                                                                    .postLatterSick();
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
                                vertical: AppSizes.s20,
                                horizontal: AppSizes.s20),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
