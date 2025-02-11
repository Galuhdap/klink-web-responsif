// To parse this JSON data, do
//
//     final getErrorMessageResponse = getErrorMessageResponseFromJson(jsonString);

import 'dart:convert';

GetErrorMessageResponse getErrorMessageResponseFromJson(String str) => GetErrorMessageResponse.fromJson(json.decode(str));

String getErrorMessageResponseToJson(GetErrorMessageResponse data) => json.encode(data.toJson());

class GetErrorMessageResponse {
    final bool success;
    final int code;
    final String message;

    GetErrorMessageResponse({
        required this.success,
        required this.code,
        required this.message,
    });

    GetErrorMessageResponse copyWith({
        bool? success,
        int? code,
        String? message,
    }) => 
        GetErrorMessageResponse(
            success: success ?? this.success,
            code: code ?? this.code,
            message: message ?? this.message,
        );

    factory GetErrorMessageResponse.fromJson(Map<String, dynamic> json) => GetErrorMessageResponse(
        success: json["success"],
        code: json["code"],
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "code": code,
        "message": message,
    };
}
