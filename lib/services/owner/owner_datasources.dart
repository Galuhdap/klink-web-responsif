import 'package:dartz/dartz.dart';
import 'package:klinik_web_responsif/core/utils/extensions/datasources/failure.dart';
import 'package:klinik_web_responsif/core/utils/preferences/shared_preferences_utils.dart';
import 'package:klinik_web_responsif/services/lib/api_services.dart';
import 'package:klinik_web_responsif/services/lib/network_constants.dart';
import 'package:klinik_web_responsif/services/owner/model/request/post_user_request.dart';
import 'package:klinik_web_responsif/services/owner/model/response/get_role_response.dart';
import 'package:klinik_web_responsif/services/owner/model/response/get_user_response.dart';
import 'package:klinik_web_responsif/services/owner/model/response/post_user_response.dart';

class OwnerDatasources extends ApiService {
  Future<Either<Failure, GetUserResponse>> getUser({
    required int page,
    required int limit,
    required String name,
    required String nik,
  }) async {
    final prefs = await SharedPreferencesUtils.getAuthToken();

    try {
      final response = await get(
          NetworkConstants.GET_USER_URL(page, limit, name, nik),
          header: {
            "Content-Type": "application/json",
            "Authorization": "Bearer ${prefs}",
          });

      return Right(GetUserResponse.fromJson(response));
    } catch (e) {
      return left(Failure(false, 400, 'Data Tidak Masuk'));
    }
  }

  Future<Either<Failures, PostUserResponse>> postUser(
      PostUserRequest data) async {
    final prefs = await SharedPreferencesUtils.getAuthToken();

    try {
      final response = await post(NetworkConstants.POST_USER_URL(), body: {
        "username": data.username,
        "password": data.password,
        "name": data.name,
        "email": data.email,
        "nik": data.nik,
        "tgl_lahir": data.tglLahir.toString(),
        "no_telp": data.noTelp,
        "jenis_kelamin": data.jenisKelamin,
        "alamat": data.alamat,
        "role": data.role
      }, header: {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${prefs}",
      });

      return response.fold(
        (failures) => Left(failures),
        (response) => Right(PostUserResponse.fromJson(response)),
      );
    } catch (e) {
      return Left(Failures(false, 500, {"api": "Server Not Connection!"}));
    }
  }

  Future<Either<Failures, PostUserResponse>> putUser(
      PostUserRequest data, String id) async {
    final prefs = await SharedPreferencesUtils.getAuthToken();

    try {
      final response = await put(NetworkConstants.PUT_USER_URL(id), body: {
        "username": data.username,
        "name": data.name,
        "email": data.email,
        "nik": data.nik,
        "tgl_lahir": data.tglLahir.toString(),
        "no_telp": data.noTelp,
        "jenis_kelamin": data.jenisKelamin,
        "alamat": data.alamat,
        "role": data.role
      }, header: {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${prefs}",
      });

      return response.fold(
        (failures) => Left(failures),
        (response) => Right(PostUserResponse.fromJson(response)),
      );
    } catch (e) {
      return Left(Failures(false, 500, {"api": "Server Not Connection!"}));
    }
  }

  Future<Either<Failure, GetRoleResponse>> getRole() async {
    final prefs = await SharedPreferencesUtils.getAuthToken();

    try {
      final response = await get(NetworkConstants.GET_ROLE_URL(), header: {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${prefs}",
      });

      return Right(GetRoleResponse.fromJson(response));
    } catch (e) {
      return left(Failure(false, 400, 'Data Tidak Masuk'));
    }
  }
}
