// To parse this JSON data, do
//
//     final deleteMedicineResponse = deleteMedicineResponseFromJson(jsonString);

import 'dart:convert';

DeleteMedicineResponse deleteMedicineResponseFromJson(String str) => DeleteMedicineResponse.fromJson(json.decode(str));

String deleteMedicineResponseToJson(DeleteMedicineResponse data) => json.encode(data.toJson());

class DeleteMedicineResponse {
    bool success;
    int code;
    String message;

    DeleteMedicineResponse({
        required this.success,
        required this.code,
        required this.message,
    });

    factory DeleteMedicineResponse.fromJson(Map<String, dynamic> json) => DeleteMedicineResponse(
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
