// To parse this JSON data, do
//
//     final putLetterRmeResponse = putLetterRmeResponseFromJson(jsonString);

import 'dart:convert';

PutLetterRmeResponse putLetterRmeResponseFromJson(String str) =>
    PutLetterRmeResponse.fromJson(json.decode(str));

String putLetterRmeResponseToJson(PutLetterRmeResponse data) =>
    json.encode(data.toJson());

class PutLetterRmeResponse {
  bool success;
  int code;
  String message;
  Data data;

  PutLetterRmeResponse({
    required this.success,
    required this.code,
    required this.message,
    required this.data,
  });

  factory PutLetterRmeResponse.fromJson(Map<String, dynamic> json) =>
      PutLetterRmeResponse(
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
