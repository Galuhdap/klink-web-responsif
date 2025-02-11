import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:klinik_web_responsif/core/components/button_component.dart';
import 'package:klinik_web_responsif/core/config/responsive.dart';
import 'package:klinik_web_responsif/core/resources/constans/app_constants.dart';
import 'package:klinik_web_responsif/core/styles/app_colors.dart';
import 'package:klinik_web_responsif/core/styles/app_sizes.dart';
import 'package:klinik_web_responsif/core/utils/extensions/sized_box_ext.dart';
import 'package:klinik_web_responsif/core/utils/helpers/validation_helper.dart';
import 'package:klinik_web_responsif/presentations/login/controllers/login_controller.dart';
import 'package:klinik_web_responsif/presentations/login/widgets/input_widget.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
      init: LoginController(),
      builder: (controller) {
        return Scaffold(
          body: Center(
              child: Container(
            width: Responsive.isMobile(context) ? 400 : 400,
            height: 300,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  AppConstants.LABEL_IN,
                  style: Get.textTheme.labelLarge!.copyWith(
                      fontSize: AppSizes.s24, color: AppColors.colorBaseBlack),
                ),
                AppSizes.s21.height,
                Form(
                  key: controller.formKey,
                  child: Column(
                    children: [
                      InputWidget(
                        label: '',
                        hintText: AppConstants.HINT_USERNAME,
                        controller: controller.usernameController,
                        textInputType: TextInputType.name,
                        validator: emptyValidation,
                      ),
                      AppSizes.s20.height,
                      InputWidget(
                        label: '',
                        hintText: AppConstants.HINT_PASSWORD,
                        controller: controller.passwordController,
                        textInputType: TextInputType.name,
                        validator: emptyValidation,
                        isObscure: true,
                        suffixIcon: true,
                      ),
                      AppSizes.s36.height,
                      Button.filled(
                        onPressed: () {
                          if (controller.formKey.currentState!.validate()) {
                            // controller.userLogin();
                          }
                        },
                        label: AppConstants.ACTION_LOGIN,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )),
        );
      },
    );
  }
}
