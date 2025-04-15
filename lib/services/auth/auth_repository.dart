import 'package:dartz/dartz.dart';
import 'package:klinik_web_responsif/core/utils/extensions/datasources/failure.dart';
import 'package:klinik_web_responsif/services/auth/auth_datasources.dart';
import 'package:klinik_web_responsif/services/auth/model/request/login_request.dart';
import 'package:klinik_web_responsif/services/auth/model/response/get_login_response.dart';

class AuthRepository {
  final AuthDatasources source;

  AuthRepository(this.source);

  Future<Either<Failure, GetLoginResponse>> loginUser(
      LoginRequest loginRequest) async {
    return source.loginUser(loginRequest);
  }
}
