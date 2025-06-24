import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:klinik_web_responsif/core/assets/assets.gen.dart';
import 'package:klinik_web_responsif/core/components/button_component.dart';
import 'package:klinik_web_responsif/core/components/input_data_component.dart';
import 'package:klinik_web_responsif/core/components/modal/show_modal_tanda_tanya_component.dart';
import 'package:klinik_web_responsif/core/components/show_center_dialog.dart';
import 'package:klinik_web_responsif/core/styles/app_colors.dart';
import 'package:klinik_web_responsif/core/styles/app_sizes.dart';
import 'package:klinik_web_responsif/core/utils/extensions/sized_box_ext.dart';
import 'package:klinik_web_responsif/core/utils/helpers/validation_helper.dart';
import 'package:klinik_web_responsif/presentations/apotik/controller/apotik_controller.dart';
import 'package:lottie/lottie.dart';

class AddLetterHealtValidation extends StatelessWidget {
  const AddLetterHealtValidation({
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
                        onPressed: id.isNotEmpty
                            ? () {
                                controller.selectedIndexMail.value = 0;
                                controller.perihalController.text = '';
                                controller.keluhanController.text = '';
                                controller.tdController.text = '';
                                controller.nController.text = '';
                                controller.sController.text = '';
                                controller.alamatLetter.value = '';
                                controller.namePasienLetter.value = '';
                                controller.idPasienLetter.value = '';
                                controller.jenisKelaminLetter.value = '';
                                controller.noRekamMedisLetter.value = '';
                                controller.jobController.text = '';
                                controller.keluhanController.text = '';

                                controller.backToAddMailHealt();
                                controller.backToLetter();
                                //  print('sadsda');
                              }
                            : () {
                                controller.selectedIndexMail.value = 0;
                                controller.perihalController.text = '';
                                controller.keluhanController.text = '';
                                controller.tdController.text = '';
                                controller.nController.text = '';
                                controller.sController.text = '';
                                controller.alamatLetter.value = '';
                                controller.namePasienLetter.value = '';
                                controller.idPasienLetter.value = '';
                                controller.jenisKelaminLetter.value = '';
                                controller.noRekamMedisLetter.value = '';
                                controller.jobController.text = '';
                                controller.keluhanController.text = '';
                                // controller.idLatter.value = '';
                                // controller.showAddLetter();
                                // print('1111');
                                controller.backToLetter();
                              },
                        icon: Icon(Icons.arrow_back_ios_new_rounded,
                            color: AppColors.colorBaseWhite),
                      ),
                      AppSizes.s5.width,
                      Text(
                        'Surat Sehat',
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
                        label: 'Keluhan',
                        hintText: 'Keluhan',
                        controller: controller.keluhanController,
                        validator: emptyValidation,
                      ),
                      InputDataComponent(
                        label: 'Perihal',
                        hintText: 'Perihal',
                        controller: controller.perihalController,
                        validator: emptyValidation,
                      ),
                      Row(
                        spacing: 10,
                        children: [
                          Flexible(
                            child: InputDataComponent(
                              label: 'TD',
                              hintText: 'TD',
                              controller: controller.tdController,
                              validator: emptyValidation,
                            ),
                          ),
                          Flexible(
                            child: InputDataComponent(
                              label: 'N',
                              hintText: 'N',
                              controller: controller.nController,
                              validator: emptyValidation,
                            ),
                          ),
                          Flexible(
                            child: InputDataComponent(
                              label: 'S',
                              hintText: 'S',
                              controller: controller.sController,
                              validator: emptyValidation,
                            ),
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
                                                  .isLoadingUpdateHealtLetter
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
                                                      'Apakah Anda Yakin Untuk Mengubah Surat Sehat ?',
                                                  onTapNo: () {
                                                    Get.back();
                                                  },
                                                  onTapYes: () async {
                                                    if (controller
                                                        .formKeyNewPost
                                                        .currentState!
                                                        .validate()) {
                                                      controller
                                                          .putLatterHealt();
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
                                                  .isLoadingPostHealtLetter
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
                                                      'Apakah Anda Yakin Untuk Menambahkan Surat Sehat Baru ?',
                                                  onTapNo: () {
                                                    Get.back();
                                                  },
                                                  onTapYes: () async {
                                                    if (controller
                                                        .formKeyNewPost
                                                        .currentState!
                                                        .validate()) {
                                                      controller
                                                          .postLatterHealt();
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
