import 'package:dartz/dartz.dart';
import 'package:klinik_web_responsif/core/utils/extensions/datasources/failure.dart';
import 'package:klinik_web_responsif/services/auth/model/request/login_request.dart';
import 'package:klinik_web_responsif/services/auth/model/response/get_login_response.dart';
import 'package:klinik_web_responsif/services/lib/api_services.dart';
import 'package:klinik_web_responsif/services/lib/network_constants.dart';

class AuthDatasources extends ApiService {

  Future<Either<Failure, GetLoginResponse>> loginUser(
      LoginRequest loginRequest) async {
    final response = await postLogin(NetworkConstants.POST_LOGIN_URL,
        body: loginRequest.toJson());

    return response.fold(
      (failure) => Left(failure),
      (response) => Right(GetLoginResponse.fromJson(response)),
    );
    
  }
 
}
