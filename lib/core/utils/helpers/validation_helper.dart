

import 'package:klinik_web_responsif/core/resources/constans/app_constants.dart';

String? emptyValidation(String? val) {
  if (val!.isEmpty) return AppConstants.TEXT_ERROR_FORMAT;

  return null;
}

String? passwordValidation(String? val) {
  if (val!.isEmpty) return AppConstants.TEXT_ERROR_FORMAT;

  if (val.length < 8) return AppConstants.TEXT_ERROR_PASSWORD;

  return null;
}

String? confirmPasswordValidation(String? val, String? pass) {
  if (val!.isEmpty) return AppConstants.TEXT_ERROR_FORMAT;

  if (val.length < 8) return AppConstants.TEXT_ERROR_PASSWORD;

  if (val != pass) return AppConstants.TEXT_ERROR_CONFIRM_PASSWORD;

  return null;
}
