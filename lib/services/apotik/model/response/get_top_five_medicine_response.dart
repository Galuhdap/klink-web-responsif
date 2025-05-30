// To parse this JSON data, do
//
//     final getTopFiveMedicineResponse = getTopFiveMedicineResponseFromJson(jsonString);

import 'dart:convert';

GetTopFiveMedicineResponse getTopFiveMedicineResponseFromJson(String str) => GetTopFiveMedicineResponse.fromJson(json.decode(str));

String getTopFiveMedicineResponseToJson(GetTopFiveMedicineResponse data) => json.encode(data.toJson());

class GetTopFiveMedicineResponse {
    bool success;
    int code;
    String message;
    List<TopFiveMedicine> data;

    GetTopFiveMedicineResponse({
        required this.success,
        required this.code,
        required this.message,
        required this.data,
    });

    factory GetTopFiveMedicineResponse.fromJson(Map<String, dynamic> json) => GetTopFiveMedicineResponse(
        success: json["success"],
        code: json["code"],
        message: json["message"],
        data: List<TopFiveMedicine>.from(json["data"].map((x) => TopFiveMedicine.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "code": code,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class TopFiveMedicine {
    int no;
    String medicineId;
    String nameMedicine;
    int totalTerjual;

    TopFiveMedicine({
        required this.no,
        required this.medicineId,
        required this.nameMedicine,
        required this.totalTerjual,
    });

    factory TopFiveMedicine.fromJson(Map<String, dynamic> json) => TopFiveMedicine(
        no: json["no"],
        medicineId: json["medicineId"],
        nameMedicine: json["name_medicine"],
        totalTerjual: json["total_terjual"],
    );

    Map<String, dynamic> toJson() => {
        "no": no,
        "medicineId": medicineId,
        "name_medicine": nameMedicine,
        "total_terjual": totalTerjual,
    };
}
