import 'package:dartz/dartz.dart';
import 'package:klinik_web_responsif/core/utils/extensions/datasources/failure.dart';
import 'package:klinik_web_responsif/services/owner/model/request/post_user_request.dart';
import 'package:klinik_web_responsif/services/owner/model/response/get_role_response.dart';
import 'package:klinik_web_responsif/services/owner/model/response/get_user_id_response.dart';
import 'package:klinik_web_responsif/services/owner/model/response/get_user_response.dart';
import 'package:klinik_web_responsif/services/owner/model/response/post_user_response.dart';
import 'package:klinik_web_responsif/services/owner/model/response/put_reset_password_user_response.dart';
import 'package:klinik_web_responsif/services/owner/owner_datasources.dart';

class OwnerRepository {
  final OwnerDatasources source;

  OwnerRepository(this.source);

  Future<Either<Failure, GetUserResponse>> getUser({
    required int page,
    required int limit,
    required String name,
  }) async {
    return source.getUser(
      page: page,
      limit: limit,
      name: name,
    );
  }

  Future<Either<Failure, GetRoleResponse>> getRole() async {
    return source.getRole();
  }
  Future<Either<Failure, GetUserIdResponse>> getUserId() async {
    return source.getUserId();
  }

  Future<Either<Failures, PostUserResponse>> postUser(
      PostUserRequest data) async {
    return source.postUser(data);
  }

  Future<Either<Failures, PostUserResponse>> putUser(
      PostUserRequest data, String id) async {
    return source.putUser(data, id);
  }

  Future<Either<Failures, PutResetPasswordResponse>> resetPasswordUser(
      String oldPassword, String newPassword) async {
    return source.putResetPasswordUser(oldPassword, newPassword);
  }
}
