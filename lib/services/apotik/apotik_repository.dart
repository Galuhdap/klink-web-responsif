import 'package:dartz/dartz.dart';
import 'package:klinik_web_responsif/core/utils/extensions/datasources/failure.dart';
import 'package:klinik_web_responsif/services/apotik/apotik_datasources.dart';
import 'package:klinik_web_responsif/services/apotik/model/request/post_buy_medicine_request.dart';
import 'package:klinik_web_responsif/services/apotik/model/request/post_medicine_request.dart';
import 'package:klinik_web_responsif/services/apotik/model/request/post_transaction_request.dart';
import 'package:klinik_web_responsif/services/apotik/model/response/delete/delete_medicine_response.dart';
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
import 'package:klinik_web_responsif/services/apotik/model/response/get_unit_response.dart';
import 'package:klinik_web_responsif/services/apotik/model/response/post/post_unit_medicine_response.dart';
import 'package:klinik_web_responsif/services/apotik/model/response/post_buy_medicine_response.dart';
import 'package:klinik_web_responsif/services/apotik/model/response/post_medicine_response.dart';
import 'package:klinik_web_responsif/services/apotik/model/response/post_new_medicine_response.dart';
import 'package:klinik_web_responsif/services/apotik/model/response/post_transaction_response.dart';

class ApotikRepository {
  final ApotikDatasources source;

  ApotikRepository(this.source);

  Future<Either<Failure, GetMedicineResponse>> getMedicine(
      {required int page,
      required int limit,
      required String nama_obat}) async {
    return source.getMedicine(page: page, limit: limit, nama_obat: nama_obat);
  }

  Future<Either<Failures, PosMedicineResponse>> postMedicine(
      PostMedicineRequest data) async {
    return source.postMedicine(data);
  }

  Future<Either<Failures, PosMedicineResponse>> putMedicine(
      PostMedicineRequest data, String id) async {
    return source.putMedicine(data, id);
  }

  Future<Either<Failures, PosMedicineResponse>> putStatusMedicine(
      String status_obat, String id) async {
    return source.putStatusMedicine(status_obat, id);
  }

  Future<Either<Failure, GetTransactionResponse>> getTransaction({
    required int page,
    required int limit,
    required String inv,
    required String name,
  }) async {
    return source.getTransaction(
        page: page, limit: limit, inv: inv, name: name);
  }

  Future<Either<Failure, GetTransactionPasienIdResponse>>
      getTransactionIdPasienRme({
    required String id,
  }) async {
    return source.getTransacionIdPasienRME(id: id);
  }

  Future<Either<Failures, PostTransactionResponse>> postTransaction(
      PostTransactionRequest data) async {
    return source.postTransaction(data);
  }

  //apotik new system

  Future<Either<Failure, GetExpiringMedicinesResponse>> getExpiredMedicine({
    required int page,
    required int limit,
  }) async {
    return source.getMedicineExpired(page: page, limit: limit);
  }

  Future<Either<Failure, GetHasExpiredMedicineResponse>> getMedicineHasExpired({
    required int page,
    required int limit,
  }) async {
    return source.getMedicineHasExpired(page: page, limit: limit);
  }

  Future<Either<Failure, GetTopFiveMedicineResponse>>
      getTopFiveMedicine() async {
    return source.getMedicineTopFive();
  }

  Future<Either<Failure, GetMonthlySummaryMedicineResponse>>
      getMonthlySummaryMedicine() async {
    return source.getMonthlySummaryMedicine();
  }

  Future<Either<Failure, GetGroupStockMedicineResponse>> getGroupStockMedicine(
      {required int page,
      required int limit,
      required String name_medicine}) async {
    return source.getGroupStockMedicine(
        page: page, limit: limit, name_medicine: name_medicine);
  }

  Future<Either<Failures, PostBuyMedicineResponse>> postBuyeMedicine(
      PostBuyMedicineRequest data) async {
    return source.postBuyMedicine(data);
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
    return source.getPurchaseReportMedicine(
        page: page,
        limit: limit,
        start_date: start_date,
        end_date: end_date,
        no_buy: no_buy,
        name_supplier: name_supplier);
  }

  Future<Either<Failure, GetNewMedicineResponse>> getNewMedicine(
      {required int page,
      required int limit,
      required String name_medicine}) async {
    return source.getNewMedicine(
        page: page, limit: limit, name_medicine: name_medicine);
  }

  Future<Either<Failures, PostNewMedicineResponse>> postNewMedicine({
    required String name_medicine,
    required int price_sell,
    required String baseUnitId,
    required List<Map<String, dynamic>> conversions,
  }) async {
    return source.postNewMedicine(
        name_medicine: name_medicine,
        price_sell: price_sell,
        baseUnitId: baseUnitId,
        conversions: conversions);
  }

  Future<Either<Failures, DeleteMedicineResponse>> deleteNewMedicine({
    required String id,
  }) async {
    return source.deleteNewMedicine(
      id: id,
    );
  }

  Future<Either<Failures, PostNewMedicineResponse>> putNewMedicine(
      {required String name_medicine,
      required int price_sell,
      required String baseUnitId,
      required List<Map<String, dynamic>> conversions,
      required String id}) async {
    return source.putNewMedicine(
        name_medicine: name_medicine,
        price_sell: price_sell,
        baseUnitId: baseUnitId,
        conversions: conversions,
        id: id);
  }

  Future<Either<Failure, GetUnitResponse>> getUnit(
      {required int page,
      required int limit,
      required String name}) async {
    return source.getUnit(page: page, limit: limit, name: name);
  }

  Future<Either<Failures, PostUnitMedicineResponse>> postUnitNewMedicine({
    required String name,
  }) async {
    return source.postUnitNewMedicine(
      name: name,
    );
  }

  Future<Either<Failures, DeleteMedicineResponse>> deleteUnitNewMedicine({
    required String id,
  }) async {
    return source.deleteUnitNewMedicine(
      id: id,
    );
  }

  Future<Either<Failures, PostUnitMedicineResponse>> putUnitNewMedicine(
      {required String name, required String id}) async {
    return source.putUnitNewMedicine(name: name, id: id);
  }
}
