import 'package:dartz/dartz.dart';
import 'package:klinik_web_responsif/core/utils/extensions/datasources/failure.dart';
import 'package:klinik_web_responsif/core/utils/preferences/shared_preferences_utils.dart';
import 'package:klinik_web_responsif/services/lib/api_services.dart';
import 'package:klinik_web_responsif/services/lib/network_constants.dart';
import 'package:klinik_web_responsif/services/rme/model/response/get_rme_id_response.dart';

class RmeDatasources extends ApiService {

  Future<Either<Failure, GetRmeIdResponse>> getRmeId({
    required int page,
    required int limit,
    required String search,
    required String id,
  }) async {
    final prefs = await SharedPreferencesUtils.getAuthToken();

    try {
      final response = await get(
          NetworkConstants.GET_RME_ID_URL(page, limit, search, id),
          header: {
            "Content-Type": "application/json",
            "Authorization": "Bearer ${prefs}",
          });

      return Right(GetRmeIdResponse.fromJson(response));
    } catch (e) {
      return left(Failure(false,400, 'Data Tidak Masuk'));
    }
  }
}
