// To parse this JSON data, do
//
//     final getLoginResponse = getLoginResponseFromJson(jsonString);

import 'dart:convert';

GetLoginResponse getLoginResponseFromJson(String str) => GetLoginResponse.fromJson(json.decode(str));

String getLoginResponseToJson(GetLoginResponse data) => json.encode(data.toJson());

class GetLoginResponse {
    final bool success;
    final int code;
    final String message;
    final Data data;

    GetLoginResponse({
        required this.success,
        required this.code,
        required this.message,
        required this.data,
    });

    GetLoginResponse copyWith({
        bool? success,
        int? code,
        String? message,
        Data? data,
    }) => 
        GetLoginResponse(
            success: success ?? this.success,
            code: code ?? this.code,
            message: message ?? this.message,
            data: data ?? this.data,
        );

    factory GetLoginResponse.fromJson(Map<String, dynamic> json) => GetLoginResponse(
        success: json["success"],
        code: json["code"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "code": code,
        "message": message,
        "data": data.toJson(),
    };
}

class Data {
    final String token;

    Data({
        required this.token,
    });

    Data copyWith({
        String? token,
    }) => 
        Data(
            token: token ?? this.token,
        );

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        token: json["token"],
    );

    Map<String, dynamic> toJson() => {
        "token": token,
    };
}
