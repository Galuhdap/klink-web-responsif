// To parse this JSON data, do
//
//     final postLetterRmeResponse = postLetterRmeResponseFromJson(jsonString);

import 'dart:convert';

PostLetterRmeResponse postLetterRmeResponseFromJson(String str) => PostLetterRmeResponse.fromJson(json.decode(str));

String postLetterRmeResponseToJson(PostLetterRmeResponse data) => json.encode(data.toJson());

class PostLetterRmeResponse {
    bool success;
    int code;
    String message;
    Data data;

    PostLetterRmeResponse({
        required this.success,
        required this.code,
        required this.message,
        required this.data,
    });

    factory PostLetterRmeResponse.fromJson(Map<String, dynamic> json) => PostLetterRmeResponse(
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
    String noLetter;
    String pekerjaan;
    String keperluan;
    DateTime startDate;
    DateTime endDate;
    DateTime createdAt;
    String pasienid;
    String userId;

    Data({
        required this.id,
        required this.noLetter,
        required this.pekerjaan,
        required this.keperluan,
        required this.startDate,
        required this.endDate,
        required this.createdAt,
        required this.pasienid,
        required this.userId,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        noLetter: json["no_letter"],
        pekerjaan: json["pekerjaan"],
        keperluan: json["keperluan"],
        startDate: DateTime.parse(json["start_date"]),
        endDate: DateTime.parse(json["end_date"]),
        createdAt: DateTime.parse(json["createdAt"]),
        pasienid: json["pasienid"],
        userId: json["userId"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "no_letter": noLetter,
        "pekerjaan": pekerjaan,
        "keperluan": keperluan,
        "start_date": startDate.toIso8601String(),
        "end_date": endDate.toIso8601String(),
        "createdAt": createdAt.toIso8601String(),
        "pasienid": pasienid,
        "userId": userId,
    };
}
