import 'package:dartz/dartz.dart';
import 'package:klinik_web_responsif/core/utils/extensions/datasources/failure.dart';
import 'package:klinik_web_responsif/services/owner/model/request/post_user_request.dart';
import 'package:klinik_web_responsif/services/owner/model/response/get_role_response.dart';
import 'package:klinik_web_responsif/services/owner/model/response/get_user_response.dart';
import 'package:klinik_web_responsif/services/owner/model/response/post_user_response.dart';
import 'package:klinik_web_responsif/services/owner/owner_datasources.dart';

class OwnerRepository {
  final OwnerDatasources source;

  OwnerRepository(this.source);

  Future<Either<Failure, GetUserResponse>> getUser({
    required int page,
    required int limit,
    required String name,
    required String nik,
  }) async {
    return source.getUser(page: page, limit: limit, name: name, nik: nik);
  }

  Future<Either<Failure, GetRoleResponse>> getRole() async {
    return source.getRole();
  }

  Future<Either<Failures, PostUserResponse>> postUser(
      PostUserRequest data) async {
    return source.postUser(data);
  }

  Future<Either<Failures, PostUserResponse>> putUser(
      PostUserRequest data, String id) async {
    return source.putUser(data, id);
  }
}
