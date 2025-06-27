import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:klinik_web_responsif/core/utils/extensions/datasources/failure.dart';
import 'package:klinik_web_responsif/core/utils/preferences/shared_preferences_utils.dart';
import 'package:klinik_web_responsif/services/doctor/model/request/post_letter_rme_request.dart';
import 'package:klinik_web_responsif/services/doctor/model/response/get_doctor_response.dart';
import 'package:klinik_web_responsif/services/doctor/model/response/get_letter_rme_response.dart';
import 'package:klinik_web_responsif/services/doctor/model/response/get_summary_doctor_response.dart';
import 'package:klinik_web_responsif/services/doctor/model/response/post/post_letter_rme_response.dart';
import 'package:klinik_web_responsif/services/doctor/model/response/put/put_letter_rme_response.dart';
import 'package:klinik_web_responsif/services/lib/api_services.dart';
import 'package:klinik_web_responsif/services/lib/network_constants.dart';

class DoctorDatasources extends ApiService {
  Future<Either<Failure, GetDoctorResponse>> getDoctor({
    required int page,
    required int limit,
    required String name,
    required String nik,
  }) async {
    final prefs = await SharedPreferencesUtils.getAuthToken();

    try {
      final response = await get(
          NetworkConstants.GET_DOCTOR_URL(page, limit, name, nik),
          header: {
            "Content-Type": "application/json",
            "Authorization": "Bearer ${prefs}",
          });

      return Right(GetDoctorResponse.fromJson(response));
    } catch (e) {
      return left(Failure(false, 400, 'Data Tidak Masuk'));
    }
  }

  Future<Either<Failure, GetLetterRmeResponse>> getLetterRmeById(
      {required int page,
      required int limit,
      required String no_letter}) async {
    final prefs = await SharedPreferencesUtils.getAuthToken();

    var userData = JwtDecoder.decode(prefs!);
    try {
      final response = await get(
          NetworkConstants.GET_LETTER_RME_URL(
              page, limit, no_letter, userData['id']),
          header: {
            "Content-Type": "application/json",
            "Authorization": "Bearer ${prefs}",
          });

      return Right(GetLetterRmeResponse.fromJson(response));
    } catch (e) {
      return left(Failure(false, 400, 'Data Tidak Masuk'));
    }
  }

  Future<Either<Failure, GetSummaryDocterResponse>> getSummaryDoctor() async {
    final prefs = await SharedPreferencesUtils.getAuthToken();
    var userData = JwtDecoder.decode(prefs!);
    try {
      final response = await get(
          NetworkConstants.GET_SUMMARY_DOCTOR_URL(userData['id']),
          header: {
            "Content-Type": "application/json",
            "Authorization": "Bearer ${prefs}",
          });

      return Right(GetSummaryDocterResponse.fromJson(response));
    } catch (e) {
      return left(Failure(false, 400, 'Data Tidak Masuk'));
    }
  }

  Future<Either<Failures, PostLetterRmeResponse>> postLetterRme({
    required PostLetterRmeRequest data,
  }) async {
    final prefs = await SharedPreferencesUtils.getAuthToken();
    var userData = JwtDecoder.decode(prefs!);
    try {
      final response =
          await post(NetworkConstants.POST_LETTER_RME_URL(), body: {
        "pekerjaan": data.pekerjaan,
        "keperluan": data.keperluan,
        "start_date": data.startDate.toString(),
        "end_date": data.endDate.toString(),
        "id_pasien": data.idPasien,
        "userId": userData['id'],
      }, header: {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${prefs}",
      });
      return response.fold(
        (failures) => Left(failures),
        (response) => Right(PostLetterRmeResponse.fromJson(response)),
      );
    } catch (e) {
      return left(Failures(false, 400, {"api": "Server Not Connection!"}));
    }
  }

  Future<Either<Failures, PutLetterRmeResponse>> putLetterRme(
      {required PostLetterRmeRequest data, required String id}) async {
    final prefs = await SharedPreferencesUtils.getAuthToken();
    try {
      final response =
          await put(NetworkConstants.PUT_LETTER_RME_URL(id), body: {
        "pekerjaan": data.pekerjaan,
        "keperluan": data.keperluan,
        "start_date": data.startDate.toString(),
        "end_date": data.endDate.toString()
      }, header: {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${prefs}",
      });

      

      return response.fold(
        (failures) => Left(failures),
        (response) => Right(PutLetterRmeResponse.fromJson(response)),
      );
    } catch (e) {
      return left(Failures(false, 400, {"api": "Server Not Connection!"}));
    }
  }
}
