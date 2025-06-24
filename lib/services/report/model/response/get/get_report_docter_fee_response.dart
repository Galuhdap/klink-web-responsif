// To parse this JSON data, do
//
//     final getReportDocterFeeResponse = getReportDocterFeeResponseFromJson(jsonString);

import 'dart:convert';

GetReportDocterFeeResponse getReportDocterFeeResponseFromJson(String str) => GetReportDocterFeeResponse.fromJson(json.decode(str));

String getReportDocterFeeResponseToJson(GetReportDocterFeeResponse data) => json.encode(data.toJson());

class GetReportDocterFeeResponse {
    bool success;
    int code;
    String message;
    List<DatumDocterFee> data;

    GetReportDocterFeeResponse({
        required this.success,
        required this.code,
        required this.message,
        required this.data,
    });

    factory GetReportDocterFeeResponse.fromJson(Map<String, dynamic> json) => GetReportDocterFeeResponse(
        success: json["success"],
        code: json["code"],
        message: json["message"],
        data: List<DatumDocterFee>.from(json["data"].map((x) => DatumDocterFee.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "code": code,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class DatumDocterFee {
    String doctorId;
    String doctorName;
    int totalFee;

    DatumDocterFee({
        required this.doctorId,
        required this.doctorName,
        required this.totalFee,
    });

    factory DatumDocterFee.fromJson(Map<String, dynamic> json) => DatumDocterFee(
        doctorId: json["doctorId"],
        doctorName: json["doctorName"],
        totalFee: json["totalFee"],
    );

    Map<String, dynamic> toJson() => {
        "doctorId": doctorId,
        "doctorName": doctorName,
        "totalFee": totalFee,
    };
}
