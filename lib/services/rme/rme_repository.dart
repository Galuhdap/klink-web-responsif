import 'package:dartz/dartz.dart';
import 'package:klinik_web_responsif/core/utils/extensions/datasources/failure.dart';
import 'package:klinik_web_responsif/services/apotik/model/response/get_group_stock_notempty_medicine_response.dart';
import 'package:klinik_web_responsif/services/rme/model/request/post_rme_request.dart';
import 'package:klinik_web_responsif/services/rme/model/response/get_rme_id_response.dart';
import 'package:klinik_web_responsif/services/rme/model/response/post_rme_response.dart';
import 'package:klinik_web_responsif/services/rme/rme_datasources.dart';

class RmeRepository {
  final RmeDatasources source;

  RmeRepository(this.source);

  Future<Either<Failure, GetRmeIdResponse>> getRmeId({
    required int page,
    required int limit,
    required String start_date,
    required String end_date,
    required String keluhan,
    required String id,
  }) async {
    return source.getRmeId(
        page: page,
        limit: limit,
        start_date: start_date,
        end_date: end_date,
        keluhan: keluhan,
        id: id);
  }

  Future<Either<Failures, PostRmeResponse>> postRme(PostRmeRequest data) async {
    return source.postRme(data);
  }

   Future<Either<Failure, GetGroupStockNotEmptyMedicineResponse>> getGroupStockMedicineZero(
      {required int page,
      required int limit,
      required String name_medicine}) async {
    return source.getGroupStockMedicineZero(
        page: page, limit: limit, name_medicine: name_medicine);
  }
}
