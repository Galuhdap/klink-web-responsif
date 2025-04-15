import 'package:klinik_web_responsif/core/utils/extensions/datasources/failure.dart';
import 'package:klinik_web_responsif/services/lib/error_response.dart';

extension FailureMapper on Failures {
  ErrorResponse toErrorResponse() {
    return ErrorResponse(success: this.succes, code: this.code, message: this.message);
  }
}