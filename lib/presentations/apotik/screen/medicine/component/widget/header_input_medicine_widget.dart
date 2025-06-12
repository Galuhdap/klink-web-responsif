import 'package:drop_down_search_field/drop_down_search_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
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
import 'package:klinik_web_responsif/services/apotik/model/response/get_unit_response.dart';
import 'package:lottie/lottie.dart';

class HeaderInputMedicineWidget extends StatelessWidget {
  const HeaderInputMedicineWidget(
      {super.key, required this.controller, this.id = ''});

  final ApotikController controller;
  final String id;

  @override
  Widget build(BuildContext context) {
    return Obx(
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
                      onPressed:  id.isNotEmpty  ? (){
                        controller.backToEditMedicine();
                      } :() {
                        controller.backToAddMedicine();
                      },
                      icon: Icon(
                        Icons.arrow_back,
                        color: AppColors.colorBaseWhite,
                      ),
                    ),
                    Text(
                      id.isNotEmpty ? 'Edit Obat' : 'Tambah Obat',
                      style: Get.textTheme.labelLarge!.copyWith(
                          fontSize: AppSizes.s17,
                          color: AppColors.colorBackground),
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
                      label: 'Nama Obat',
                      hintText: 'Nama Obat',
                      controller: controller.nameMedicineController,
                      validator: emptyValidation,
                    ),
                    InputDataComponent(
                      label: 'Harga Jual',
                      hintText: 'Harga Jual',
                      controller: controller.priceSellController,
                      validator: emptyValidation,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Pilih Satuan Obat',
                          style: Get.textTheme.bodyMedium!.copyWith(
                              fontWeight: FontWeight.w700,
                              fontSize: AppSizes.s14,
                              color: AppColors.colorBaseBlack),
                        ),
                        AppSizes.s12.height,
                        DropDownSearchFormField(
                          textFieldConfiguration: TextFieldConfiguration(
                            decoration: InputDecoration(
                              hintText: 'Pilih Jenis Satuan Obat',
                              suffixIcon: Icon(Iconsax.arrow_down_1),
                              hintStyle: Get.textTheme.bodySmall!.copyWith(
                                fontSize: AppSizes.s14,
                                color: AppColors.colorNeutrals400,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.circular(AppSizes.s4),
                                borderSide: BorderSide(
                                  color: AppColors.colorSecondary400,
                                  width: AppSizes.s1,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.circular(AppSizes.s10),
                                borderSide: BorderSide(
                                    color: AppColors.colorSecondary400,
                                    width: AppSizes.s2),
                              ),
                            ),
                            style: TextStyle(
                              fontSize: AppSizes.s14,
                              color: Colors.black,
                            ),
                            controller: controller.dropdownUnitController,
                          ),
                          suggestionsCallback: (pattern) {
                            return controller.getUnitSuggestions(pattern);
                          },
                          itemBuilder: (context, DatumUnit suggestion) {
                            return ListTile(
                              title: Text(
                                suggestion.name
                                    .split(' ')
                                    .map((word) => word.isNotEmpty
                                        ? '${word[0].toUpperCase()}${word.substring(1)}'
                                        : '')
                                    .join(' '),
                                style: TextStyle(
                                  fontSize: AppSizes.s14,
                                  color: Colors.black,
                                ),
                              ),
                            );
                          },
                          itemSeparatorBuilder: (context, index) {
                            return const Divider();
                          },
                          transitionBuilder:
                              (context, suggestionsBox, controller) {
                            return suggestionsBox;
                          },
                          onSuggestionSelected: (DatumUnit suggestion) {
                            controller.dropdownUnitController.text =
                                suggestion.name;
                            controller.selectedUnitId.value = suggestion.id;
                          },
                          suggestionsBoxController:
                              controller.suggestionBoxController,
                          validator: (value) => value!.isEmpty ? '' : null,
                          onSaved: (value) {},
                          displayAllSuggestionWhenTap: true,
                        ),
                      ],
                    ),
                    if (controller.selectedUnitId.value.isNotEmpty) ...[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          12.height,
                          Text(
                            'Tambahkan Turunan Untuk Satuan',
                            style: Get.textTheme.bodyMedium!.copyWith(
                                fontWeight: FontWeight.w700,
                                fontSize: AppSizes.s14,
                                color: AppColors.colorBaseBlack),
                          ),
                          12.height,
                          Obx(
                            () => Switch(
                              value: controller.isLightOn.value,
                              activeColor: AppColors.colorBasePrimary,
                              onChanged: controller.toggleLight,
                            ),
                          ),
                        ],
                      ),
                    ],
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
                                                .isLoadingPostNewMedicine.value
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
                                                    'Apakah Anda Yakin Untuk Mengubah Data Obat ?',
                                                onTapNo: () {
                                                  Get.back();
                                                },
                                                onTapYes: () async {
                                                  if (controller.formKeyNewPost
                                                      .currentState!
                                                      .validate()) {
                                                    controller
                                                        .putNewMedicine(id);
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
                                                .isLoadingPostNewMedicine.value
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
                                                    'Apakah Anda Yakin Untuk Menambahkan Obat Baru ?',
                                                onTapNo: () {
                                                  Get.back();
                                                },
                                                onTapYes: () async {
                                                  if (controller.formKeyNewPost
                                                      .currentState!
                                                      .validate()) {
                                                    controller
                                                        .postNewMedicine();
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
      },
    );
  }
}
