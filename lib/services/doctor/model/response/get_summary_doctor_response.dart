// To parse this JSON data, do
//
//     final getSummaryDocterResponse = getSummaryDocterResponseFromJson(jsonString);

import 'dart:convert';

GetSummaryDocterResponse getSummaryDocterResponseFromJson(String str) =>
    GetSummaryDocterResponse.fromJson(json.decode(str));

String getSummaryDocterResponseToJson(GetSummaryDocterResponse data) =>
    json.encode(data.toJson());

class GetSummaryDocterResponse {
  bool success;
  int code;
  String message;
  DataSummaryDoctor data;

  GetSummaryDocterResponse({
    required this.success,
    required this.code,
    required this.message,
    required this.data,
  });

  factory GetSummaryDocterResponse.fromJson(Map<String, dynamic> json) =>
      GetSummaryDocterResponse(
        success: json["success"],
        code: json["code"],
        message: json["message"],
        data: DataSummaryDoctor.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "code": code,
        "message": message,
        "data": data.toJson(),
      };
}

class DataSummaryDoctor {
  int totalFeeDokter;
  int totalFeeDokterHariIni;
  int totalPasienDiperiksa;
  int totalPasienHariIni;

  DataSummaryDoctor({
    required this.totalFeeDokter,
    required this.totalFeeDokterHariIni,
    required this.totalPasienDiperiksa,
    required this.totalPasienHariIni,
  });

  factory DataSummaryDoctor.fromJson(Map<String, dynamic> json) =>
      DataSummaryDoctor(
        totalFeeDokter: json["total_fee_dokter"],
        totalFeeDokterHariIni: json["total_fee_dokter_hari_ini"],
        totalPasienDiperiksa: json["total_pasien_diperiksa"],
        totalPasienHariIni: json["total_pasien_hari_ini"],
      );

  Map<String, dynamic> toJson() => {
        "total_fee_dokter": totalFeeDokter,
        "total_fee_dokter_hari_ini": totalFeeDokterHariIni,
        "total_pasien_diperiksa": totalPasienDiperiksa,
        "total_pasien_hari_ini": totalPasienHariIni,
      };
}
