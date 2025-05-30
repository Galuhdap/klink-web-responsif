import 'package:dartz/dartz.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:klinik_web_responsif/core/utils/extensions/datasources/failure.dart';
import 'package:klinik_web_responsif/core/utils/preferences/shared_preferences_utils.dart';
import 'package:klinik_web_responsif/services/lib/api_services.dart';
import 'package:klinik_web_responsif/services/lib/network_constants.dart';
import 'package:klinik_web_responsif/services/rme/model/request/post_rme_request.dart';
import 'package:klinik_web_responsif/services/rme/model/response/get_rme_id_response.dart';
import 'package:klinik_web_responsif/services/rme/model/response/post_rme_response.dart';

class RmeDatasources extends ApiService {
  Future<Either<Failure, GetRmeIdResponse>> getRmeId({
    required int page,
    required int limit,
    required String start_date,
    required String end_date,
    required String keluhan,
    required String id,
  }) async {
    final prefs = await SharedPreferencesUtils.getAuthToken();

    try {
      final response = await get(
          NetworkConstants.GET_RME_ID_URL(
            page,
            limit,
            start_date,
            end_date,
            keluhan,
            id,
          ),
          header: {
            "Content-Type": "application/json",
            "Authorization": "Bearer ${prefs}",
          });

      return Right(GetRmeIdResponse.fromJson(response));
    } catch (e) {
      return left(Failure(false, 400, 'Data Tidak Masuk'));
    }
  }

  Future<Either<Failures, PostRmeResponse>> postRme(PostRmeRequest data) async {
    final prefs = await SharedPreferencesUtils.getAuthToken();
    var userData = JwtDecoder.decode(prefs!);
    try {
      final response = await post(NetworkConstants.POST_RME_URL(), body: {
        "keluhan": data.keluhan,
        "terapi_tindakan": data.terapiTindakan,
        "dx": data.dx,
        "id_pasien": data.idPasien,
        "obat": data.obat,
        "total": data.total,
        "id_user": userData['id']
      }, header: {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${prefs}",
      });
      return response.fold(
        (failures) => Left(failures),
        (response) => Right(PostRmeResponse.fromJson(response)),
      );
    } catch (e) {
      return left(Failures(false, 400, {"api": "Server Not Connection!"}));
    }
  }
}
