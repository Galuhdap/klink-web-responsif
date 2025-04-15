// To parse this JSON data, do
//
//     final errorResponse = errorResponseFromJson(jsonString);

import 'dart:convert';

ErrorResponse errorResponseFromJson(String str) => ErrorResponse.fromJson(json.decode(str));

String errorResponseToJson(ErrorResponse data) => json.encode(data.toJson());

class ErrorResponse {
    final bool success;
    final int code;
   final Map<String, String>? message;

    ErrorResponse({
        required this.success,
        required this.code,
        required this.message,
    });

    // ErrorResponse copyWith({
    //     bool? success,
    //     int? code,
    //     String? message,
    // }) => 
    //     ErrorResponse(
    //         success: success ?? this.success,
    //         code: code ?? this.code,
    //         message: message ?? this.message,
    //     );

    factory ErrorResponse.fromJson(Map<String, dynamic> json) => ErrorResponse(
        success: json["success"],
        code: json["code"],
        message: Map<String, String>.from(json["message"]),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "code": code,
        "message": message,
    };
}
