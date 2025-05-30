// To parse this JSON data, do
//
//     final delAntrianResponse = delAntrianResponseFromJson(jsonString);

import 'dart:convert';

DelAntrianResponse delAntrianResponseFromJson(String str) => DelAntrianResponse.fromJson(json.decode(str));

String delAntrianResponseToJson(DelAntrianResponse data) => json.encode(data.toJson());

class DelAntrianResponse {
    final bool success;
    final int code;
    final String message;
    final Data data;

    DelAntrianResponse({
        required this.success,
        required this.code,
        required this.message,
        required this.data,
    });

    DelAntrianResponse copyWith({
        bool? success,
        int? code,
        String? message,
        Data? data,
    }) => 
        DelAntrianResponse(
            success: success ?? this.success,
            code: code ?? this.code,
            message: message ?? this.message,
            data: data ?? this.data,
        );

    factory DelAntrianResponse.fromJson(Map<String, dynamic> json) => DelAntrianResponse(
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
    final String id;
    final String nomerAntrian;
    final String status;
    final String waktuTunggu;
    final int waitingTimeSeconds;
    final DateTime lastUpdated;
    final String idPasien;
    final DateTime createdAt;

    Data({
        required this.id,
        required this.nomerAntrian,
        required this.status,
        required this.waktuTunggu,
        required this.waitingTimeSeconds,
        required this.lastUpdated,
        required this.idPasien,
        required this.createdAt,
    });

    Data copyWith({
        String? id,
        String? nomerAntrian,
        String? status,
        String? waktuTunggu,
        int? waitingTimeSeconds,
        DateTime? lastUpdated,
        String? idPasien,
        DateTime? createdAt,
    }) => 
        Data(
            id: id ?? this.id,
            nomerAntrian: nomerAntrian ?? this.nomerAntrian,
            status: status ?? this.status,
            waktuTunggu: waktuTunggu ?? this.waktuTunggu,
            waitingTimeSeconds: waitingTimeSeconds ?? this.waitingTimeSeconds,
            lastUpdated: lastUpdated ?? this.lastUpdated,
            idPasien: idPasien ?? this.idPasien,
            createdAt: createdAt ?? this.createdAt,
        );

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        nomerAntrian: json["nomer_antrian"],
        status: json["status"],
        waktuTunggu: json["waktu_tunggu"],
        waitingTimeSeconds: json["waitingTimeSeconds"],
        lastUpdated: DateTime.parse(json["lastUpdated"]),
        idPasien: json["id_pasien"],
        createdAt: DateTime.parse(json["createdAt"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nomer_antrian": nomerAntrian,
        "status": status,
        "waktu_tunggu": waktuTunggu,
        "waitingTimeSeconds": waitingTimeSeconds,
        "lastUpdated": lastUpdated.toIso8601String(),
        "id_pasien": idPasien,
        "createdAt": createdAt.toIso8601String(),
    };
}
