import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:klinik_web_responsif/core/assets/assets.gen.dart';
import 'package:klinik_web_responsif/core/components/button_component.dart';
import 'package:klinik_web_responsif/core/components/input_data_component.dart';
import 'package:klinik_web_responsif/core/components/modal/show_modal_tanda_tanya_component.dart';
import 'package:klinik_web_responsif/core/components/show_center_dialog.dart';
import 'package:klinik_web_responsif/core/config/responsive.dart';
import 'package:klinik_web_responsif/core/styles/app_colors.dart';
import 'package:klinik_web_responsif/core/styles/app_sizes.dart';
import 'package:klinik_web_responsif/core/utils/extensions/int_ext.dart';
import 'package:klinik_web_responsif/core/utils/extensions/sized_box_ext.dart';
import 'package:klinik_web_responsif/core/utils/helpers/validation_helper.dart';
import 'package:klinik_web_responsif/presentations/apotik/widget/succes_payment_widget.dart';
import 'package:klinik_web_responsif/presentations/menu_dashboard/widget/build_app_bar.dart';
import 'package:klinik_web_responsif/presentations/user/controller/user_manajemen_controller.dart';
import 'package:lottie/lottie.dart';

class UserSettingScreen extends StatefulWidget {
  const UserSettingScreen({super.key});

  @override
  State<UserSettingScreen> createState() => _UserSettingScreenState();
}

class _UserSettingScreenState extends State<UserSettingScreen> {
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
            ),
          ),
          body: Obx(
            () {
              return controller.isRessetPasswordUser.value
                  ? Container(
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
                                  onPressed: () {
                                    controller.backToRessetPassword();
                                  },
                                  icon: Icon(Icons.arrow_back_ios_new_rounded,
                                      color: AppColors.colorBaseWhite),
                                ),
                                AppSizes.s5.width,
                                Text(
                                  'Reset Password',
                                  style: Get.textTheme.labelLarge!.copyWith(
                                      fontSize: AppSizes.s17,
                                      color: AppColors.colorBaseWhite),
                                ),
                              ],
                            ),
                          ),
                          Obx(() {
                            return Form(
                              key: controller.formKey,
                              child: Column(
                                children: [
                                  InputDataComponent(
                                    label: 'Password Lama',
                                    hintText: 'Masukan Password Lama',
                                    controller:
                                        controller.oldPasswordController,
                                    validator: emptyValidation,
                                    errorText:
                                        controller.errorMessages['oldPassword'],
                                  ),
                                  InputDataComponent(
                                    label: 'Password Baru',
                                    hintText: 'Masukan Password Baru',
                                    controller:
                                        controller.newPasswordController,
                                    validator: emptyValidation,
                                    errorText:
                                        controller.errorMessages['oldPassword'],
                                  ),
                                  InputDataComponent(
                                    label: 'Konfirmasi Password Baru',
                                    hintText:
                                        'Masukan Konfirmasi Password Baru',
                                    controller:
                                        controller.confirmPasswordController,
                                    validator: emptyValidation,
                                    errorText:
                                        controller.errorMessages['oldPassword'],
                                  ),
                                  Container(
                                    width: 150,
                                    child: Button.filled(
                                        onPressed: () {
                                          showModalCenter(
                                            context,
                                            Obx(
                                              () {
                                                return controller
                                                        .isLoadingResetPassword
                                                        .value
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
                                                            'Apakah Anda Yakin Untuk Mengubah Password ?',
                                                        onTapNo: () {
                                                          Get.back();
                                                        },
                                                        onTapYes: () async {
                                                          if (controller.formKey
                                                              .currentState!
                                                              .validate()) {
                                                            controller
                                                                .putResetPasswordUser();
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
                              ),
                            ).paddingSymmetric(
                                vertical: AppSizes.s20,
                                horizontal: AppSizes.s20);
                          })
                        ],
                      ),
                    ).paddingSymmetric(
                      vertical: AppSizes.s41,
                      horizontal: AppSizes.s28,
                    )
                  : controller.isLoadingUserId.value
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : Column(
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
                                    child: Center(
                                      child: Text(
                                        'Setting Account',
                                        style: Get.textTheme.labelLarge!
                                            .copyWith(
                                                fontSize: AppSizes.s17,
                                                color:
                                                    AppColors.colorBaseWhite),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: AppSizes.symmetricPadding(
                                        vertical: AppSizes.s20,
                                        horizontal: AppSizes.s20),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Nama',
                                          style: Get.textTheme.bodyMedium!
                                              .copyWith(
                                                  fontSize: AppSizes.s17,
                                                  color:
                                                      AppColors.colorBaseBlack),
                                        ),
                                        AppSizes.s10.height,
                                        Text(
                                          controller.userId.value!.data.name,
                                          style: Get.textTheme.labelLarge!
                                              .copyWith(
                                                  fontSize: AppSizes.s17,
                                                  color:
                                                      AppColors.colorBaseBlack),
                                        ),
                                        Divider(
                                          color: AppColors.colorBasePrimary,
                                        ),
                                        Text(
                                          'Username',
                                          style: Get.textTheme.bodyMedium!
                                              .copyWith(
                                                  fontSize: AppSizes.s17,
                                                  color:
                                                      AppColors.colorBaseBlack),
                                        ),
                                        AppSizes.s10.height,
                                        Text(
                                          controller
                                              .userId.value!.data.username,
                                          style: Get.textTheme.labelLarge!
                                              .copyWith(
                                                  fontSize: AppSizes.s17,
                                                  color:
                                                      AppColors.colorBaseBlack),
                                        ),
                                        Divider(
                                          color: AppColors.colorBasePrimary,
                                        ),
                                        Text(
                                          'Email',
                                          style: Get.textTheme.bodyMedium!
                                              .copyWith(
                                                  fontSize: AppSizes.s17,
                                                  color:
                                                      AppColors.colorBaseBlack),
                                        ),
                                        AppSizes.s10.height,
                                        Text(
                                          controller.userId.value!.data.email,
                                          style: Get.textTheme.labelLarge!
                                              .copyWith(
                                                  fontSize: AppSizes.s17,
                                                  color:
                                                      AppColors.colorBaseBlack),
                                        ),
                                        Divider(
                                          color: AppColors.colorBasePrimary,
                                        ),
                                        Text(
                                          'Jenis Kelamin',
                                          style: Get.textTheme.bodyMedium!
                                              .copyWith(
                                                  fontSize: AppSizes.s17,
                                                  color:
                                                      AppColors.colorBaseBlack),
                                        ),
                                        AppSizes.s10.height,
                                        Text(
                                          controller
                                              .userId.value!.data.jenisKelamin,
                                          style: Get.textTheme.labelLarge!
                                              .copyWith(
                                                  fontSize: AppSizes.s17,
                                                  color:
                                                      AppColors.colorBaseBlack),
                                        ),
                                        Divider(
                                          color: AppColors.colorBasePrimary,
                                        ),
                                        // Text(
                                        //   DateTime.now().toFormattedDateDayTimeString(),
                                        //   style: Get.textTheme.labelLarge!.copyWith(
                                        //       fontSize: AppSizes.s20,
                                        //       color: AppColors.colorBaseBlack),
                                        // ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            AppSizes.s20.height,
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
                                  Padding(
                                    padding: AppSizes.symmetricPadding(
                                        vertical: AppSizes.s20,
                                        horizontal: AppSizes.s20),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          controller.userId.value!.data.alamat,
                                          style: Get.textTheme.bodyMedium!
                                              .copyWith(
                                                  fontSize: AppSizes.s17,
                                                  color:
                                                      AppColors.colorBaseBlack),
                                        ),
                                        AppSizes.s10.height,
                                        Text(
                                          controller
                                              .userId.value!.data.role.name,
                                          style: Get.textTheme.labelLarge!
                                              .copyWith(
                                                  fontSize: AppSizes.s17,
                                                  color:
                                                      AppColors.colorBaseBlack),
                                        ),
                                        Divider(
                                          color: AppColors.colorBasePrimary,
                                        ),
                                        Button.filled(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              7,
                                          color: AppColors.colorBaseError,
                                          onPressed: () {
                                            // showModalCenter(
                                            //     context,
                                            // SuccesPaymentWidget(
                                            //   kembalian:
                                            //       200000.currencyFormatRp,
                                            //   totalTagihan:
                                            //       200000.currencyFormatRp,
                                            //   nominalBayar:
                                            //       200000.currencyFormatRp,
                                            //   paymentMethod:
                                            //       200000.currencyFormatRp,
                                            //   date: 200000.currencyFormatRp,
                                            //   invoice:
                                            //       200000.currencyFormatRp,
                                            //   onPressed: () {
                                            //     Get.back();
                                            //   },
                                            // ));
                                            controller.showRessetPassword();
                                          },
                                          label: 'Reset Password',
                                        )
                                        // Text(
                                        //   DateTime.now().toFormattedDateDayTimeString(),
                                        //   style: Get.textTheme.labelLarge!.copyWith(
                                        //       fontSize: AppSizes.s20,
                                        //       color: AppColors.colorBaseBlack),
                                        // ),
                                      ],
                                    ),
                                  ),
                                ],
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
      },
    );
  }
}
