// To parse this JSON data, do
//
//     final getStatisticPasienResponse = getStatisticPasienResponseFromJson(jsonString);

import 'dart:convert';

GetStatisticPasienResponse getStatisticPasienResponseFromJson(String str) => GetStatisticPasienResponse.fromJson(json.decode(str));

String getStatisticPasienResponseToJson(GetStatisticPasienResponse data) => json.encode(data.toJson());

class GetStatisticPasienResponse {
    final bool success;
    final int code;
    final String message;
    final TotalPasienData data;

    GetStatisticPasienResponse({
        required this.success,
        required this.code,
        required this.message,
        required this.data,
    });

    GetStatisticPasienResponse copyWith({
        bool? success,
        int? code,
        String? message,
        TotalPasienData? data,
    }) => 
        GetStatisticPasienResponse(
            success: success ?? this.success,
            code: code ?? this.code,
            message: message ?? this.message,
            data: data ?? this.data,
        );

    factory GetStatisticPasienResponse.fromJson(Map<String, dynamic> json) => GetStatisticPasienResponse(
        success: json["success"],
        code: json["code"],
        message: json["message"],
        data: TotalPasienData.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "code": code,
        "message": message,
        "data": data.toJson(),
    };
}

class TotalPasienData {
    final int totalPasien;
    final int pasienBaruBulanIni;

    TotalPasienData({
        required this.totalPasien,
        required this.pasienBaruBulanIni,
    });

    TotalPasienData copyWith({
        int? totalPasien,
        int? pasienBaruBulanIni,
    }) => 
        TotalPasienData(
            totalPasien: totalPasien ?? this.totalPasien,
            pasienBaruBulanIni: pasienBaruBulanIni ?? this.pasienBaruBulanIni,
        );

    factory TotalPasienData.fromJson(Map<String, dynamic> json) => TotalPasienData(
        totalPasien: json["totalPasien"],
        pasienBaruBulanIni: json["pasienBaruBulanIni"],
    );

    Map<String, dynamic> toJson() => {
        "totalPasien": totalPasien,
        "pasienBaruBulanIni": pasienBaruBulanIni,
    };
}
