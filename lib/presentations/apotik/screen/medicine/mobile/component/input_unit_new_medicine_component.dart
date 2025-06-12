import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:klinik_web_responsif/core/assets/assets.gen.dart';
import 'package:klinik_web_responsif/core/components/button_component.dart';
import 'package:klinik_web_responsif/core/components/input_data_component.dart';
import 'package:klinik_web_responsif/core/components/modal/show_modal_tanda_tanya_component.dart';
import 'package:klinik_web_responsif/core/components/show_center_dialog.dart';
import 'package:klinik_web_responsif/core/styles/app_colors.dart';
import 'package:klinik_web_responsif/core/styles/app_sizes.dart';
import 'package:klinik_web_responsif/core/utils/helpers/validation_helper.dart';
import 'package:klinik_web_responsif/presentations/apotik/controller/apotik_controller.dart';
import 'package:lottie/lottie.dart';

class InputUnitNewMedicineComponent extends StatelessWidget {
  const InputUnitNewMedicineComponent(
      {super.key, required this.controller, this.id = ''});
  final ApotikController controller;
  final String id;
  @override
  Widget build(BuildContext context) {
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
          Container(
            padding: AppSizes.symmetricPadding(
              vertical: AppSizes.s10,
              horizontal: AppSizes.s10,
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
                          controller.backToEditUnitMedicine();
                        }
                      : () {
                          controller.backToAddUnitMedicine();
                        },
                  icon: Icon(
                    Icons.arrow_back,
                    color: AppColors.colorBaseWhite,
                  ),
                ),
                Text(
                  id.isNotEmpty ? 'Edit Satuan Obat' : 'Tambah Satuan Obat',
                  style: Get.textTheme.labelLarge!.copyWith(
                      fontSize: AppSizes.s17, color: AppColors.colorBackground),
                ),
              ],
            ),
          ),
          Form(
            key: controller.formKeyNewPost,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InputDataComponent(
                  label: 'Nama Satuan Obat',
                  hintText: 'Masukan Nama Satuan Obat',
                  controller: controller.nameUnitMedicineController,
                  validator: emptyValidation,
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
                                            .isLoadingPostUnitNewMedicine.value
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
                                                'Apakah Anda Yakin Untuk Mengubah Satuan Obat ?',
                                            onTapNo: () {
                                              Get.back();
                                            },
                                            onTapYes: () async {
                                              if (controller
                                                  .formKeyNewPost.currentState!
                                                  .validate()) {
                                                controller
                                                    .putUnitNewMedicine(id);
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
                                            .isLoadingPostUnitNewMedicine.value
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
                                                'Apakah Anda Yakin Untuk Menambahkan Satuan Obat Baru ?',
                                            onTapNo: () {
                                              Get.back();
                                            },
                                            onTapYes: () async {
                                              if (controller
                                                  .formKeyNewPost.currentState!
                                                  .validate()) {
                                                controller
                                                    .postUnitNewMedicine();
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
    );
  }
}
