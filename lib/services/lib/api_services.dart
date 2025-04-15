import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:klinik_web_responsif/core/utils/extensions/datasources/datasources_ext.dart';
import 'package:klinik_web_responsif/core/utils/extensions/datasources/failure.dart';
import 'package:klinik_web_responsif/services/lib/error_response.dart';

final dio = new Dio(BaseOptions(
  contentType: 'application/json',
  responseType: ResponseType.plain,
));

abstract class ApiService {
  Future<dynamic> get(
    String endpoint, {
    Map<String, String>? queryParameter,
    Map<String, String>? header,
  }) async {
    try {
      Response response = await dio.get(
        endpoint,
        queryParameters: queryParameter,
        options: Options(headers: header),
      );

      final rawResponse = jsonDecode(response.toString());
      return rawResponse;
    } catch (ex) {
      print(ex.toString());
      throw (Exception("Connection Failed !"));
    }
  }

  Future<Either<Failure, dynamic>> postLogin(
    String endpoint, {
    Map<String, String>? queryParameter,
    Map<String, String>? header,
    Map<String, String>? body,
  }) async {
    try {
      Response response = await dio.post(
        endpoint,
        queryParameters: queryParameter,
        data: body,
        options: Options(headers: header),
      );

      final rawResponse = jsonDecode(response.toString());

      return Right(rawResponse);
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }

  Future<Either<Failures, dynamic>> post(
    String endpoint, {
    Map<String, String>? queryParameter,
    Map<String, String>? header,
    Map<String, String>? body,
  }) async {
    try {
      Response response = await dio.post(
        endpoint,
        queryParameters: queryParameter,
        data: body,
        options: Options(
          headers: header,
          validateStatus: (_) => true,
        ),
      );

      final jsonMap = jsonDecode(response.toString());

      if (response.statusCode != 201 ||
          (jsonMap is Map && jsonMap['success'] == false)) {
        final errorResponse = ErrorResponse.fromJson(jsonMap);
        return Left(Failures(errorResponse.success ,errorResponse.code, errorResponse.message));
      } else {
        return Right(jsonMap);
      }
    } catch (error) {
      return Left(Failures(false ,500, {"api" :"Server Not Connection!"}));
    }
  }

  Future<Either<Failures, dynamic>> put(
    String endpoint, {
    Map<String, String>? queryParameter,
    Map<String, String>? header,
    Map<String, String>? body,
  }) async {
    try {
      Response response = await dio.put(
        endpoint,
        queryParameters: queryParameter,
        data: body,
        options: Options(
          headers: header,
          validateStatus: (_) => true,
        ),
      );

      final jsonMap = jsonDecode(response.toString());

      if (response.statusCode != 201 ||
          (jsonMap is Map && jsonMap['success'] == false)) {
        final errorResponse = ErrorResponse.fromJson(jsonMap);
        return Left(Failures(errorResponse.success ,errorResponse.code, errorResponse.message));
      } else {
        return Right(jsonMap);
      }
    } catch (error) {
      return Left(Failures(false ,500, {"api" :"Server Not Connection!"}));
    }
  }
}
