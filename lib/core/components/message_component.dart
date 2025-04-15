import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:klinik_web_responsif/core/config/theme_config.dart';
import 'package:klinik_web_responsif/core/styles/app_sizes.dart';
class MessageComponent {
  static SnackbarController snackbar({
    required String title,
    required String message,
    bool isError = false,
  }) {
    return Get.snackbar(
      '',
      message,
      titleText: Container(),
      messageText: Text(
        message,
        style: ThemeConfig.labelMedium,
      ),
      snackPosition: SnackPosition.BOTTOM,
      margin: EdgeInsets.all(AppSizes.s24),
    );
  }
  static SnackbarController snackbarTop({
    required String title,
    required String message,
    bool isError = false,
  }) {
    return Get.snackbar(
      '',
      message,
      titleText: Container(),
      messageText: Text(
        message,
        style: ThemeConfig.labelMedium,
      ),
      snackPosition: SnackPosition.TOP,
      margin: EdgeInsets.all(AppSizes.s24),
    );
  }
}
