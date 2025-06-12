// To parse this JSON data, do
//
//     final postUnitMedicineResponse = postUnitMedicineResponseFromJson(jsonString);

import 'dart:convert';

PostUnitMedicineResponse postUnitMedicineResponseFromJson(String str) => PostUnitMedicineResponse.fromJson(json.decode(str));

String postUnitMedicineResponseToJson(PostUnitMedicineResponse data) => json.encode(data.toJson());

class PostUnitMedicineResponse {
    bool success;
    int code;
    String message;
    Data data;

    PostUnitMedicineResponse({
        required this.success,
        required this.code,
        required this.message,
        required this.data,
    });

    factory PostUnitMedicineResponse.fromJson(Map<String, dynamic> json) => PostUnitMedicineResponse(
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
    String id;
    String name;
    int level;

    Data({
        required this.id,
        required this.name,
        required this.level,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        name: json["name"],
        level: json["level"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "level": level,
    };
}
