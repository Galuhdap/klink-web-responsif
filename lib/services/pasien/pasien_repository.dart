import 'package:dartz/dartz.dart';
import 'package:klinik_web_responsif/core/utils/extensions/datasources/failure.dart';
import 'package:klinik_web_responsif/services/pasien/model/request/post_pasient_request.dart';
import 'package:klinik_web_responsif/services/pasien/model/response/get_pasien_by_id_response.dart';
import 'package:klinik_web_responsif/services/pasien/model/response/get_pasien_response.dart';
import 'package:klinik_web_responsif/services/pasien/model/response/post_pasien_response.dart';
import 'package:klinik_web_responsif/services/pasien/pasien_datasources.dart';

class PasienRepository {
  final PasienDatasources source;

  PasienRepository(this.source);

  Future<Either<Failure, GetPasienResponse>> getPasien({
    required int page,
    required int limit,
    required String search,
  }) async {
    return source.getPasien(page: page, limit: limit, search: search);
  }

  Future<Either<Failure, GetPasienByIdResponse>> getPasienById(
      String id) async {
    return source.getPasienById(id);
  }

  Future<Either<Failures, PostPasienResponse>> postPasien(
      PostPasienRequest data) async {
    return source.postPasien(data);
  }

  Future<Either<Failures, PostPasienResponse>> putPasien(
      PostPasienRequest data, String id) async {
    return source.putPasien(data, id);
  }
}
