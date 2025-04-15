import 'package:dartz/dartz.dart';
import 'package:klinik_web_responsif/core/utils/extensions/datasources/failure.dart';
import 'package:klinik_web_responsif/core/utils/preferences/shared_preferences_utils.dart';
import 'package:klinik_web_responsif/services/lib/api_services.dart';
import 'package:klinik_web_responsif/services/lib/network_constants.dart';
import 'package:klinik_web_responsif/services/pasien/model/request/post_pasient_request.dart';
import 'package:klinik_web_responsif/services/pasien/model/response/get_pasien_by_id_response.dart';
import 'package:klinik_web_responsif/services/pasien/model/response/get_pasien_response.dart';
import 'package:klinik_web_responsif/services/pasien/model/response/post_pasien_response.dart';

class PasienDatasources extends ApiService {
  Future<Either<Failure, GetPasienResponse>> getPasien({
    required int page,
    required int limit,
    required String search,
  }) async {
    final prefs = await SharedPreferencesUtils.getAuthToken();

    try {
      final response = await get(
          NetworkConstants.GET_PASIEN_URL(page, limit, search),
          header: {
            "Content-Type": "application/json",
            "Authorization": "Bearer ${prefs}",
          });

      return Right(GetPasienResponse.fromJson(response));
    } catch (e) {
      return left(Failure(false ,400, 'Data Tidak Masuk'));
    }
  }

  Future<Either<Failure, GetPasienByIdResponse>> getPasienById(
      String id) async {
    final prefs = await SharedPreferencesUtils.getAuthToken();

    try {
      final response =
          await get(NetworkConstants.GET_PASIEN_BYID_URL(id), header: {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${prefs}",
      });
      print(response);
      return Right(GetPasienByIdResponse.fromJson(response));
    } catch (e) {
      return left(Failure(false ,400, 'Data Tidak Masuk'));
    }
  }

  Future<Either<Failures, PostPasienResponse>> postPasien(
      PostPasienRequest data) async {
    final prefs = await SharedPreferencesUtils.getAuthToken();

    try {
      final response =
          await post(NetworkConstants.POST_PASIEN_URL(), body: {
        "name": data.name,
        "nik": data.nik,
        "tgl_lahir": data.tglLahir.toString(),
        "no_telp": data.noTelp,
        "jenis_kelamin": data.jenisKelamin,
        //"umur": data.umur,
        "alamat": data.alamat
      }, header: {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${prefs}",
      });

      return response.fold(
        (failures) => Left(failures),
        (response) => Right(PostPasienResponse.fromJson(response)),
      );
    } catch (e) {
      return Left(Failures(false ,500, {"api" :"Server Not Connection!"}));
    }
  }

  Future<Either<Failures, PostPasienResponse>> putPasien(
      PostPasienRequest data, String id) async {
    final prefs = await SharedPreferencesUtils.getAuthToken();

    try {
      final response =
          await put(NetworkConstants.PUT_PASIEN_URL(id), body: {
        "name": data.name,
        "nik": data.nik,
        "tgl_lahir": data.tglLahir.toString(),
        "no_telp": data.noTelp,
        "jenis_kelamin": data.jenisKelamin,
        //"umur": data.umur,
        "alamat": data.alamat
      }, header: {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${prefs}",
      });

      return response.fold(
        (failures) => Left(failures),
        (response) => Right(PostPasienResponse.fromJson(response)),
      );
    } catch (e) {
      return Left(Failures(false ,500, {"api" :"Server Not Connection!"}));
    }
  }
}
