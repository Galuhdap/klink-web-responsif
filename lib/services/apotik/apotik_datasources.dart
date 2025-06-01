import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:klinik_web_responsif/core/utils/extensions/datasources/failure.dart';
import 'package:klinik_web_responsif/core/utils/preferences/shared_preferences_utils.dart';
import 'package:klinik_web_responsif/services/apotik/model/request/post_buy_medicine_request.dart';
import 'package:klinik_web_responsif/services/apotik/model/request/post_medicine_request.dart';
import 'package:klinik_web_responsif/services/apotik/model/request/post_transaction_request.dart';
import 'package:klinik_web_responsif/services/apotik/model/response/get_expired_medicines_response.dart';
import 'package:klinik_web_responsif/services/apotik/model/response/get_group_stock_medicine_response.dart';
import 'package:klinik_web_responsif/services/apotik/model/response/get_has_expired_medicine_response.dart';
import 'package:klinik_web_responsif/services/apotik/model/response/get_medicine_response.dart';
import 'package:klinik_web_responsif/services/apotik/model/response/get_monthly_summary_response.dart';
import 'package:klinik_web_responsif/services/apotik/model/response/get_new_medicine_response.dart';
import 'package:klinik_web_responsif/services/apotik/model/response/get_purchase_report_medicine_response.dart';
import 'package:klinik_web_responsif/services/apotik/model/response/get_top_five_medicine_response.dart';
import 'package:klinik_web_responsif/services/apotik/model/response/get_transaction_pasien_id_response.dart';
import 'package:klinik_web_responsif/services/apotik/model/response/get_transaction_response.dart';
import 'package:klinik_web_responsif/services/apotik/model/response/post_buy_medicine_response.dart';
import 'package:klinik_web_responsif/services/apotik/model/response/post_medicine_response.dart';
import 'package:klinik_web_responsif/services/apotik/model/response/post_new_medicine_response.dart';
import 'package:klinik_web_responsif/services/apotik/model/response/post_transaction_response.dart';
import 'package:klinik_web_responsif/services/apotik/model/response/put_new_medicine_response.dart';
import 'package:klinik_web_responsif/services/lib/api_services.dart';
import 'package:klinik_web_responsif/services/lib/network_constants.dart';

class ApotikDatasources extends ApiService {
  Future<Either<Failure, GetMedicineResponse>> getMedicine(
      {required int page,
      required int limit,
      required String nama_obat}) async {
    final prefs = await SharedPreferencesUtils.getAuthToken();

    try {
      final response = await get(
          NetworkConstants.GET_MEDICINE_URL(page, limit, nama_obat),
          header: {
            "Content-Type": "application/json",
            "Authorization": "Bearer ${prefs}",
          });

      return Right(GetMedicineResponse.fromJson(response));
    } catch (e) {
      return left(Failure(false, 400, 'Data Tidak Masuk'));
    }
  }

  Future<Either<Failures, PosMedicineResponse>> postMedicine(
      PostMedicineRequest data) async {
    final prefs = await SharedPreferencesUtils.getAuthToken();

    try {
      final response = await post(NetworkConstants.POST_MEDICINE_URL(), body: {
        "nama_obat": data.namaObat,
        "tgl_kadaluarsa": data.tglKadaluarsa,
        "stock": data.stock,
        "status_obat": data.statusObat
      }, header: {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${prefs}",
      });

      inspect(response);

      return response.fold(
        (failures) => Left(failures),
        (response) => Right(PosMedicineResponse.fromJson(response)),
      );
    } catch (e) {
      return Left(Failures(false, 500, {"api": "Server Not Connection!"}));
    }
  }

  Future<Either<Failures, PosMedicineResponse>> putMedicine(
      PostMedicineRequest data, String id) async {
    final prefs = await SharedPreferencesUtils.getAuthToken();

    try {
      final response = await put(NetworkConstants.PUT_MEDICINE_URL(id), body: {
        "nama_obat": data.namaObat,
        "tgl_kadaluarsa": data.tglKadaluarsa,
        "stock": data.stock
      }, header: {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${prefs}",
      });

      return response.fold(
        (failures) => Left(failures),
        (response) => Right(PosMedicineResponse.fromJson(response)),
      );
    } catch (e) {
      return Left(Failures(false, 500, {"api": "Server Not Connection!"}));
    }
  }

  Future<Either<Failures, PosMedicineResponse>> putStatusMedicine(
      String status_obat, String id) async {
    final prefs = await SharedPreferencesUtils.getAuthToken();

    try {
      final response =
          await put(NetworkConstants.PUT_STATUS_MEDICINE_URL(id), body: {
        "status_obat": status_obat,
      }, header: {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${prefs}",
      });

      return response.fold(
        (failures) => Left(failures),
        (response) => Right(PosMedicineResponse.fromJson(response)),
      );
    } catch (e) {
      return Left(Failures(false, 500, {"api": "Server Not Connection!"}));
    }
  }

  Future<Either<Failure, GetTransactionResponse>> getTransaction({
    required int page,
    required int limit,
    required String inv,
    required String name,
  }) async {
    final prefs = await SharedPreferencesUtils.getAuthToken();

    try {
      final response = await get(
          NetworkConstants.GET_TRANSCATION_URL(page, limit, inv, name),
          header: {
            "Content-Type": "application/json",
            "Authorization": "Bearer ${prefs}",
          });

      return Right(GetTransactionResponse.fromJson(response));
    } catch (e) {
      return left(Failure(false, 400, 'Data Tidak Masuk'));
    }
  }

  Future<Either<Failure, GetTransactionPasienIdResponse>>
      getTransacionIdPasienRME({
    required String id,
  }) async {
    final prefs = await SharedPreferencesUtils.getAuthToken();
    try {
      final response = await get(
          NetworkConstants.GET_TRANSACTION_PASIEN_ID_URL(id),
          header: {
            "Content-Type": "application/json",
            "Authorization": "Bearer ${prefs}",
          });

      return Right(GetTransactionPasienIdResponse.fromJson(response));
    } catch (e) {
      return left(Failure(false, 400, 'Data Tidak Masuk'));
    }
  }

  Future<Either<Failures, PostTransactionResponse>> postTransaction(
      PostTransactionRequest data) async {
    final prefs = await SharedPreferencesUtils.getAuthToken();
    var userData = JwtDecoder.decode(prefs!);

    try {
      final response =
          await post(NetworkConstants.POST_TRANSACTION_PASIEN(), body: {
        "payment_method": data.paymentMethod,
        "nominal_payment": data.nominalPayment,
        "change_given": data.changeGiven,
        "amount_paid": data.amountPaid,
        "id_rekam_medis": data.idRekamMedis,
        "id_user": userData['id']
      }, header: {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${prefs}",
      });

      inspect(response);

      return response.fold(
        (failures) => Left(failures),
        (response) => Right(PostTransactionResponse.fromJson(response)),
      );
    } catch (e) {
      return Left(Failures(false, 500, {"api": "Server Not Connection!"}));
    }
  }

  //NEW SYSTEM APOTIK
  Future<Either<Failure, GetExpiringMedicinesResponse>> getMedicineExpired({
    required int page,
    required int limit,
  }) async {
    final prefs = await SharedPreferencesUtils.getAuthToken();

    try {
      final response = await get(
          NetworkConstants.GET_MEDICINE_EXPIRED_URL(page, limit),
          header: {
            "Content-Type": "application/json",
            "Authorization": "Bearer ${prefs}",
          });

      return Right(GetExpiringMedicinesResponse.fromJson(response));
    } catch (e) {
      return left(Failure(false, 400, 'Data Tidak Masuk'));
    }
  }

  Future<Either<Failure, GetHasExpiredMedicineResponse>> getMedicineHasExpired({
    required int page,
    required int limit,
  }) async {
    final prefs = await SharedPreferencesUtils.getAuthToken();

    try {
      final response = await get(
          NetworkConstants.GET_MEDICINE_HAS_EXPIRED_URL(page, limit),
          header: {
            "Content-Type": "application/json",
            "Authorization": "Bearer ${prefs}",
          });

      return Right(GetHasExpiredMedicineResponse.fromJson(response));
    } catch (e) {
      return left(Failure(false, 400, 'Data Tidak Masuk'));
    }
  }

  Future<Either<Failure, GetTopFiveMedicineResponse>>
      getMedicineTopFive() async {
    final prefs = await SharedPreferencesUtils.getAuthToken();

    try {
      final response =
          await get(NetworkConstants.GET_MEDICINE_TOP_FIVE_URL(), header: {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${prefs}",
      });

      return Right(GetTopFiveMedicineResponse.fromJson(response));
    } catch (e) {
      return left(Failure(false, 400, 'Data Tidak Masuk'));
    }
  }

  Future<Either<Failure, GetMonthlySummaryMedicineResponse>>
      getMonthlySummaryMedicine() async {
    final prefs = await SharedPreferencesUtils.getAuthToken();

    try {
      final response = await get(
          NetworkConstants.GET_MEDICINE_SUMMARY_MONTHLY_URL(),
          header: {
            "Content-Type": "application/json",
            "Authorization": "Bearer ${prefs}",
          });

      return Right(GetMonthlySummaryMedicineResponse.fromJson(response));
    } catch (e) {
      return left(Failure(false, 400, 'Data Tidak Masuk'));
    }
  }

  Future<Either<Failure, GetGroupStockMedicineResponse>> getGroupStockMedicine(
      {required int page,
      required int limit,
      required String name_medicine}) async {
    final prefs = await SharedPreferencesUtils.getAuthToken();

    try {
      final response = await get(
          NetworkConstants.GET_MEDICINE_GROUP_STOCK_URL(
              page, limit, name_medicine),
          header: {
            "Content-Type": "application/json",
            "Authorization": "Bearer ${prefs}",
          });

      return Right(GetGroupStockMedicineResponse.fromJson(response));
    } catch (e) {
      return left(Failure(false, 400, 'Data Tidak Masuk'));
    }
  }

  Future<Either<Failures, PostBuyMedicineResponse>> postBuyMedicine(
      PostBuyMedicineRequest data) async {
    final prefs = await SharedPreferencesUtils.getAuthToken();
    var userData = JwtDecoder.decode(prefs!);
    try {
      final response =
          await post(NetworkConstants.POST_MEDICINE_BUY_URL(), body: {
        "name_supplier": data.nameSupplier,
        "no_buy": data.noBuy,
        "date_buy": data.dateBuy.toString(),
        "user_id": userData['id'],
        "medicines": data.medicines
      }, header: {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${prefs}",
      });

      inspect(data.medicines);
      return response.fold(
        (failures) => Left(failures),
        (response) => Right(PostBuyMedicineResponse.fromJson(response)),
      );
    } catch (e) {
      return left(Failures(false, 400, {"api": "Server Not Connection!"}));
    }
  }

  Future<Either<Failure, GetPurchaseReportMedicineResponse>>
      getPurchaseReportMedicine({
    required int page,
    required int limit,
    required String start_date,
    required String end_date,
    required String no_buy,
    required String name_supplier,
  }) async {
    final prefs = await SharedPreferencesUtils.getAuthToken();

    try {
      final response = await get(
          NetworkConstants.GET_REPORT_MEDICINE_BUY_URL(
              page, limit, start_date, end_date, no_buy, name_supplier),
          header: {
            "Content-Type": "application/json",
            "Authorization": "Bearer ${prefs}",
          });

      return Right(GetPurchaseReportMedicineResponse.fromJson(response));
    } catch (e) {
      return left(Failure(false, 400, 'Data Tidak Masuk'));
    }
  }

  Future<Either<Failure, GetNewMedicineResponse>> getNewMedicine(
      {required int page,
      required int limit,
      required String name_medicine}) async {
    final prefs = await SharedPreferencesUtils.getAuthToken();

    try {
      final response = await get(
          NetworkConstants.GET_NEW_MEDICINE_URL(page, limit, name_medicine),
          header: {
            "Content-Type": "application/json",
            "Authorization": "Bearer ${prefs}",
          });

      return Right(GetNewMedicineResponse.fromJson(response));
    } catch (e) {
      return left(Failure(false, 400, 'Data Tidak Masuk'));
    }
  }

  Future<Either<Failures, PostNewMedicineResponse>> postNewMedicine({
    required String name_medicine,
    required int price_buy,
    required int price_sell,
  }) async {
    final prefs = await SharedPreferencesUtils.getAuthToken();
    try {
      final response =
          await post(NetworkConstants.POST_NEW_MEDICINE_URL(), body: {
        "name_medicine": name_medicine,
        "price_buy": price_buy,
        "price_sell": price_sell
      }, header: {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${prefs}",
      });

      return response.fold(
        (failures) => Left(failures),
        (response) => Right(PostNewMedicineResponse.fromJson(response)),
      );
    } catch (e) {
      return left(Failures(false, 400, {"api": "Server Not Connection!"}));
    }
  }

  Future<Either<Failures, PutNewMedicineResponse>> putNewMedicine({
    required String name_medicine,
    required int price_buy,
    required int price_sell,
    required String id,
  }) async {
    final prefs = await SharedPreferencesUtils.getAuthToken();
    try {
      final response =
          await patch(NetworkConstants.PUT_NEW_MEDICINE_URL(id), body: {
        "name_medicine": name_medicine,
        "price_buy": price_buy,
        "price_sell": price_sell
      }, header: {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${prefs}",
      });
      inspect(response);
      return response.fold(
        (failures) => Left(failures),
        (response) => Right(PutNewMedicineResponse.fromJson(response)),
      );
    } catch (e) {
      return left(Failures(false, 400, {"api": "Server Not Connection!"}));
    }
  }
}
