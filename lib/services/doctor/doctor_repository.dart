import 'package:dartz/dartz.dart';
import 'package:klinik_web_responsif/core/utils/extensions/datasources/failure.dart';
import 'package:klinik_web_responsif/services/doctor/doctor_datasources.dart';
import 'package:klinik_web_responsif/services/doctor/model/response/get_doctor_response.dart';

class DoctorRepository {
  final DoctorDatasources source;

  DoctorRepository(this.source);

  Future<Either<Failure, GetDoctorResponse>> getDoctor({
    required int page,
    required int limit,
    required String search,
  }) async {
    return source.getDoctor(page: page, limit: limit, search: search);
  }
}
