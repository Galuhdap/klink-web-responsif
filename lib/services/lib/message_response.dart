// To parse this JSON data, do
//
//     final messageResponse = messageResponseFromJson(jsonString);

import 'dart:convert';

MessageResponse messageResponseFromJson(String str) => MessageResponse.fromJson(json.decode(str));

String messageResponseToJson(MessageResponse data) => json.encode(data.toJson());

class MessageResponse {
    bool success;
    int code;
    String message;

    MessageResponse({
        required this.success,
        required this.code,
        required this.message,
    });

    factory MessageResponse.fromJson(Map<String, dynamic> json) => MessageResponse(
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
