import 'package:dartz/dartz.dart';
import 'package:klinik_web_responsif/core/utils/extensions/datasources/failure.dart';
import 'package:klinik_web_responsif/services/doctor/doctor_datasources.dart';
import 'package:klinik_web_responsif/services/doctor/model/request/post_letter_rme_request.dart';
import 'package:klinik_web_responsif/services/doctor/model/response/get_doctor_response.dart';
import 'package:klinik_web_responsif/services/doctor/model/response/get_letter_rme_response.dart';
import 'package:klinik_web_responsif/services/doctor/model/response/get_summary_doctor_response.dart';
import 'package:klinik_web_responsif/services/doctor/model/response/post/post_letter_rme_response.dart';
import 'package:klinik_web_responsif/services/doctor/model/response/put/put_letter_rme_response.dart';

class DoctorRepository {
  final DoctorDatasources source;

  DoctorRepository(this.source);

  Future<Either<Failure, GetDoctorResponse>> getDoctor({
    required int page,
    required int limit,
    required String name,
    required String nik,
  }) async {
    return source.getDoctor(page: page, limit: limit, name: name, nik: nik);
  }

  Future<Either<Failure, GetLetterRmeResponse>> getLetterRmeById({
    required int page,
    required int limit,
    required String no_letter,
  }) async {
    return source.getLetterRmeById(
        page: page, limit: limit, no_letter: no_letter);
  }

  Future<Either<Failure, GetSummaryDocterResponse>> getSummaryDoctor() async {
    return source.getSummaryDoctor();
  }

  Future<Either<Failures, PostLetterRmeResponse>> postLetterRme({
    required PostLetterRmeRequest data,
  }) async {
    return source.postLetterRme(data: data);
  }

  Future<Either<Failures, PutLetterRmeResponse>> putLetterRme({
    required PostLetterRmeRequest data,
    required String id,
  }) async {
    return source.putLetterRme(data: data, id: id);
  }
}
