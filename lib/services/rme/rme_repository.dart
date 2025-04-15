import 'package:dartz/dartz.dart';
import 'package:klinik_web_responsif/core/utils/extensions/datasources/failure.dart';
import 'package:klinik_web_responsif/services/rme/model/response/get_rme_id_response.dart';
import 'package:klinik_web_responsif/services/rme/rme_datasources.dart';

class RmeRepository {
  final RmeDatasources source;

  RmeRepository(this.source);

  Future<Either<Failure, GetRmeIdResponse>> getRmeId({
    required int page,
    required int limit,
    required String search,
    required String id,
  }) async {
    return source.getRmeId(page: page, limit: limit, search: search, id: id);
  }
}
