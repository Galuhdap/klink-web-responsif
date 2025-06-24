import 'package:drop_down_search_field/drop_down_search_field.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:klinik_web_responsif/core/assets/assets.gen.dart';
import 'package:klinik_web_responsif/core/components/button_component.dart';
import 'package:klinik_web_responsif/core/components/input_data_component.dart';
import 'package:klinik_web_responsif/core/components/modal/show_modal_tanda_tanya_component.dart';
import 'package:klinik_web_responsif/core/components/show_center_dialog.dart';
import 'package:klinik_web_responsif/core/config/responsive.dart';
import 'package:klinik_web_responsif/core/styles/app_colors.dart';
import 'package:klinik_web_responsif/core/styles/app_sizes.dart';
import 'package:klinik_web_responsif/core/utils/extensions/date_ext.dart';
import 'package:klinik_web_responsif/core/utils/extensions/sized_box_ext.dart';
import 'package:klinik_web_responsif/core/utils/helpers/validation_helper.dart';
import 'package:klinik_web_responsif/presentations/menu_dashboard/widget/build_app_bar.dart';
import 'package:klinik_web_responsif/presentations/user/controller/user_manajemen_controller.dart';
import 'package:klinik_web_responsif/presentations/user/validasi/widget_validasi.dart';
import 'package:klinik_web_responsif/presentations/user/widget/tab_menu_user_widget.dart';
import 'package:klinik_web_responsif/services/owner/model/response/get_role_response.dart';
import 'package:lottie/lottie.dart';

class UserManajemenScreen extends StatelessWidget {
  const UserManajemenScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserManajemenController>(
      init: UserManajemenController(),
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
              labelButton: 'Tambah Data',
              onTapButton: () => controller.showAddUser(),
            ),
          ),
          body: Expanded(
            child: Obx(
              () {
                return controller.isAddUser.value
                    ? InputUserComponent(
                        controller: controller,
                      )
                    : controller.isEditUser.value
                        ? InputUserComponent(
                            controller: controller,
                            id: controller.idUser.value,
                          )
                        : Column(
                            children: [
                              Row(
                                children: [
                                  Flexible(
                                    child: TabMenuUserWidget(
                                      label: 'Admin',
                                      controller: controller,
                                      index: 0,
                                      indexSelect:
                                          controller.selectedIndex.value.obs,
                                      onTap: () => controller.selectTab(0),
                                    ),
                                  ),
                                  Flexible(
                                    child: TabMenuUserWidget(
                                      label: 'Dokter',
                                      controller: controller,
                                      index: 1,
                                      indexSelect:
                                          controller.selectedIndex.value.obs,
                                      onTap: () => controller.selectTab(1),
                                    ),
                                  ),
                                  Flexible(
                                    child: TabMenuUserWidget(
                                      label: 'Apoteker',
                                      controller: controller,
                                      index: 2,
                                      indexSelect:
                                          controller.selectedIndex.value.obs,
                                      onTap: () => controller.selectTab(2),
                                    ),
                                  ),
                                ],
                              ),
                              AppSizes.s20.height,
                              Responsive.isDesktop(context)
                                  ? Obx(
                                      () {
                                        return controller.selectedIndex.value ==
                                                0
                                            ? WidgetValidasi(
                                                controller: controller,
                                                label: 'Admin',
                                                data: controller.userAdmin,
                                              )
                                            : controller.selectedIndex.value ==
                                                    1
                                                ? WidgetValidasi(
                                                    controller: controller,
                                                    label: 'Dokter',
                                                    data: controller.userDokter,
                                                  )
                                                : WidgetValidasi(
                                                    controller: controller,
                                                    label: 'Apoteker',
                                                    data: controller.userApotik,
                                                  );
                                      },
                                    )
                                  : Container()
                            ],
                          ).paddingSymmetric(
                            vertical: AppSizes.s41,
                            horizontal: AppSizes.s28,
                          );
              },
            ),
          ),
        );
      },
    );
  }
}

class InputUserComponent extends StatelessWidget {
  const InputUserComponent({super.key, required this.controller, this.id = ""});
  final UserManajemenController controller;
  final String id;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        children: [
          Obx(
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
                            onPressed: id.isNotEmpty
                                ? () {
                                    controller.backToEditUser();
                                  }
                                : () {
                                    controller.backToAddUser();
                                  },
                            icon: Icon(
                              Icons.arrow_back,
                              color: AppColors.colorBaseWhite,
                            ),
                          ),
                          Text(
                            id.isNotEmpty ? 'Edit User' : 'Tambah User',
                            style: Get.textTheme.labelLarge!.copyWith(
                                fontSize: AppSizes.s17,
                                color: AppColors.colorBackground),
                          ),
                        ],
                      ),
                    ),
                    Form(
                      key: controller.formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InputDataComponent(
                            label: 'NIK',
                            hintText: 'NIK',
                            controller: controller.nikController,
                            validator: emptyValidation,
                          ),
                          InputDataComponent(
                            label: 'Nama',
                            hintText: 'Nama',
                            controller: controller.nameController,
                            validator: emptyValidation,
                          ),
                          InputDataComponent(
                            label: 'Email',
                            hintText: 'Email',
                            controller: controller.emailController,
                            validator: emptyValidation,
                          ),
                          InputDataComponent(
                            label: 'Usernmae',
                            hintText: 'Usernmae',
                            controller: controller.usernameController,
                            validator: emptyValidation,
                          ),
                          InputDataComponent(
                            label: 'No Telp',
                            hintText: 'No Telp',
                            controller: controller.noTelpController,
                          ),
                          InputDataComponent(
                            label: 'Alamat',
                            hintText: 'Alamat',
                            controller: controller.alamatController,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Pilih Role',
                                style: Get.textTheme.bodyMedium!.copyWith(
                                    fontWeight: FontWeight.w700,
                                    fontSize: AppSizes.s14,
                                    color: AppColors.colorBaseBlack),
                              ),
                              AppSizes.s12.height,
                              DropDownSearchFormField(
                                textFieldConfiguration: TextFieldConfiguration(
                                  decoration: InputDecoration(
                                    hintText: 'Pilih Role',
                                    suffixIcon: Icon(Iconsax.arrow_down_1),
                                    hintStyle:
                                        Get.textTheme.bodySmall!.copyWith(
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
                                    fontSize: AppSizes.s16,
                                    color: Colors.black,
                                  ),
                                  controller: controller.dropdownRoleController,
                                ),
                                suggestionsCallback: (pattern) {
                                  return controller.getRoleSuggestions(pattern);
                                },
                                itemBuilder: (context, RoleData suggestion) {
                                  return ListTile(
                                    title: Text(
                                      suggestion.name,
                                      style: TextStyle(
                                        fontSize: AppSizes.s16,
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
                                onSuggestionSelected: (RoleData suggestion) {
                                  controller.dropdownRoleController.text =
                                      suggestion.name;
                                },
                                suggestionsBoxController:
                                    controller.suggestionBoxController,
                                validator: (value) =>
                                    value!.isEmpty ? '' : null,
                                onSaved: (value) {},
                                displayAllSuggestionWhenTap: true,
                              ),
                              AppSizes.s20.height,
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Tanggal Lahir',
                                    style: Get.textTheme.bodyMedium!.copyWith(
                                        fontWeight: FontWeight.w700,
                                        fontSize: AppSizes.s14,
                                        color: AppColors.colorBaseBlack),
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
                                          color: AppColors.colorSecondary400,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(AppSizes.s4),
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
                                            controller.tglLahirController.value
                                                .toDateyyyymmddFormattedString(),
                                            style: Get.textTheme.bodySmall!
                                                .copyWith(
                                              fontSize: AppSizes.s14,
                                              color: AppColors.colorNeutrals400,
                                            ),
                                          ),
                                        ],
                                      ).paddingSymmetric(vertical: AppSizes.s5),
                                    );
                                  })),
                                  AppSizes.s12.height,
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Jenis Kelamin',
                                    style: Get.textTheme.bodyMedium!.copyWith(
                                        fontWeight: FontWeight.w700,
                                        fontSize: AppSizes.s14,
                                        color: AppColors.colorBaseBlack),
                                  ),
                                  AppSizes.s12.height,
                                  DropdownSearch<String>(
                                    items: (f, cs) => [
                                      "Laki-laki",
                                      "Perempuan",
                                    ],
                                    dropdownBuilder: (context, selectedItem) {
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
                                        fit: FlexFit.loose),
                                    onChanged: (String? selectedValue) {
                                      controller.jenisKelaminController.value =
                                          selectedValue!;
                                    },
                                  ),
                                  AppSizes.s12.height,
                                ],
                              ),
                            ],
                          ),
                          Divider(),
                          Container(
                            width: 150,
                            child: Button.filled(
                                onPressed: controller.idUser.isNotEmpty
                                    ? () {
                                        showModalCenter(
                                          context,
                                          Obx(
                                            () {
                                              return controller
                                                      .isLoadingUpdate.value
                                                  ? Center(
                                                      child: SizedBox(
                                                        width: 400,
                                                        height: 400,
                                                        child: Lottie.asset(
                                                            Assets.lottie
                                                                .hospital),
                                                      ),
                                                    )
                                                  : ShowModalTandaTanyaComponent(
                                                      label:
                                                          'Apakah Anda Yakin Untuk Mengubah Data User ?',
                                                      onTapNo: () {
                                                        Get.back();
                                                      },
                                                      onTapYes: () async {
                                                        if (controller.formKey
                                                            .currentState!
                                                            .validate()) {
                                                          controller.putUser(
                                                              controller.idUser
                                                                  .value);
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
                                                      .isLoadingCreate.value
                                                  ? Center(
                                                      child: SizedBox(
                                                        width: 400,
                                                        height: 400,
                                                        child: Lottie.asset(
                                                            Assets.lottie
                                                                .hospital),
                                                      ),
                                                    )
                                                  : ShowModalTandaTanyaComponent(
                                                      label:
                                                          'Apakah Anda Yakin Untuk Menambahkan User Baru ?',
                                                      onTapNo: () {
                                                        Get.back();
                                                      },
                                                      onTapYes: () async {
                                                        if (controller.formKey
                                                            .currentState!
                                                            .validate()) {
                                                          await controller
                                                              .postUser();
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
          ),
        ],
      ).paddingSymmetric(vertical: AppSizes.s20, horizontal: AppSizes.s20),
    );
  }
}


