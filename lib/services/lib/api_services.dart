import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:klinik_web_responsif/core/utils/extensions/datasources/datasources_ext.dart';
import 'package:klinik_web_responsif/core/utils/extensions/datasources/failure.dart';


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

  Future<Either<Failure, dynamic>> post(
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

  // Future<dynamic> post(
  //     String endpoint, {
  //       Map<String, String>? queryParameter,
  //       Map<String, String>? header,
  //       Map<String, String>? body,
  //     }) async {
  //   try {
  //     Response response = await dio.post(
  //       endpoint,
  //       queryParameters: queryParameter,
  //       data: body,
  //       options: Options(headers: header),
  //     );

  //     inspect(response);

  //     final rawResponse = jsonDecode(response.toString());
  //     return rawResponse;
  //   } on Exception {
  //     throw (Exception("Connection Failed !"));
  //   }
  // }
}
