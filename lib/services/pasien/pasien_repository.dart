import 'package:dartz/dartz.dart';
import 'package:klinik_web_responsif/core/utils/extensions/datasources/failure.dart';
import 'package:klinik_web_responsif/services/lib/message_response.dart';
import 'package:klinik_web_responsif/services/pasien/model/request/post_pasient_request.dart';
import 'package:klinik_web_responsif/services/pasien/model/response/del_antrian_response.dart';
import 'package:klinik_web_responsif/services/pasien/model/response/get_antrian_pasien_response.dart';
import 'package:klinik_web_responsif/services/pasien/model/response/get_archive_queue_response.dart';
import 'package:klinik_web_responsif/services/pasien/model/response/get_pasien_by_id_response.dart';
import 'package:klinik_web_responsif/services/pasien/model/response/get_pasien_response.dart';
import 'package:klinik_web_responsif/services/pasien/model/response/get_statistic_pasien_response.dart';
import 'package:klinik_web_responsif/services/pasien/model/response/post_pasien_response.dart';
import 'package:klinik_web_responsif/services/pasien/model/response/put_antrian_pasien_response.dart';
import 'package:klinik_web_responsif/services/pasien/pasien_datasources.dart';

class PasienRepository {
  final PasienDatasources source;

  PasienRepository(this.source);

  Future<Either<Failure, GetPasienResponse>> getPasien({
    required int page,
    required int limit,
    required String name,
    required String nik,
    required String umur,
    required String norme,
    required String tahun_lahir,
    required String tgl_lahir,
  }) async {
    return source.getPasien(
      page: page,
      limit: limit,
      name: name,
      nik: nik,
      umur: umur,
      norme: norme,
      tahun_lahir: tahun_lahir,
      tgl_lahir:tgl_lahir
    );
  }

  Future<Either<Failure, GetStatisticPasienResponse>>
      getStatisticTotalPasien() async {
    return source.getStatisticTotalPasien();
  }

  Future<Either<Failure, GetPasienByIdResponse>> getPasienById(
      String id) async {
    return source.getPasienById(id);
  }

  Future<Either<Failure, GetArchiveQueueResponse>> postArchiveQueue() async {
    return source.postArchiveQueue();
  }

  Future<Either<Failures, PostPasienResponse>> postPasien(
      PostPasienRequest data) async {
    return source.postPasien(data);
  }

  Future<Either<Failures, DelAntrianResponse>> delAntrianId(String id) async {
    return source.deleteAntrianById(id);
  }

  Future<Either<Failures, PostPasienResponse>> putPasien(
      PostPasienRequest data, String id) async {
    return source.putPasien(data, id);
  }

  Future<Either<Failure, GetAntrianPasienResponse>> getAntrianPasien({
    required int page,
    required int limit,
    required String name,
    required String nomer_antrian,
    required String no_rme,
  }) async {
    return source.getAntrianPasien(
        page: page,
        limit: limit,
        name: name,
        nomer_antrian: nomer_antrian,
        no_rme: no_rme);
  }

  Future<Either<Failure, GetAntrianPasienResponse>> getAntrianPasienFinished({
    required int page,
    required int limit,
    required String name,
    required String nomer_antrian,
    required String no_rme,
  }) async {
    return source.getAntrianPasienFinished(
        page: page,
        limit: limit,
        name: name,
        nomer_antrian: nomer_antrian,
        no_rme: no_rme);
  }

  Future<Either<Failure, GetAntrianPasienResponse>> getAntrianProsesPasien({
    required int page,
    required int limit,
    required String search,
  }) async {
    return source.getAntrianProsessPasien(
        page: page, limit: limit, search: search);
  }

  Future<Either<Failures, PutAntrianPasienResponse>> postAntrianPasien(
      String id) async {
    return source.postAntrianPasien(id);
  }

  Future<Either<Failures, PutAntrianPasienResponse>> putAntrianPasien(
      String status, String id) async {
    return source.putAntrianPasien(status, id);
  }

  Future<Either<Failures, MessageResponse>> putAntrianPasienSocket(
      String status, String id) async {
    return source.putAntrianPasienSocket(status, id);
  }
}
