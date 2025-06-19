import 'package:dartz/dartz.dart';
import 'package:klinik_web_responsif/core/utils/extensions/datasources/failure.dart';
import 'package:klinik_web_responsif/services/doctor/doctor_datasources.dart';
import 'package:klinik_web_responsif/services/doctor/model/response/get_doctor_response.dart';
import 'package:klinik_web_responsif/services/doctor/model/response/get_summary_doctor_response.dart';

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

  Future<Either<Failure, GetSummaryDocterResponse>>
      getSummaryDoctor() async {
    return source.getSummaryDoctor();
  }
}
