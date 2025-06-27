// To parse this JSON data, do
//
//     final getArchiveQueueResponse = getArchiveQueueResponseFromJson(jsonString);

import 'dart:convert';

GetArchiveQueueResponse getArchiveQueueResponseFromJson(String str) => GetArchiveQueueResponse.fromJson(json.decode(str));

String getArchiveQueueResponseToJson(GetArchiveQueueResponse data) => json.encode(data.toJson());

class GetArchiveQueueResponse {
    bool success;
    int code;
    String message;
    List<Datum> data;

    GetArchiveQueueResponse({
        required this.success,
        required this.code,
        required this.message,
        required this.data,
    });

    factory GetArchiveQueueResponse.fromJson(Map<String, dynamic> json) => GetArchiveQueueResponse(
        success: json["success"],
        code: json["code"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "code": code,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Datum {
    String nomerAntrian;
    String status;
    String idPasien;
    String pasienNama;
    DateTime createdAt;

    Datum({
        required this.nomerAntrian,
        required this.status,
        required this.idPasien,
        required this.pasienNama,
        required this.createdAt,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        nomerAntrian: json["nomer_antrian"],
        status: json["status"],
        idPasien: json["id_pasien"],
        pasienNama: json["pasien_nama"],
        createdAt: DateTime.parse(json["createdAt"]),
    );

    Map<String, dynamic> toJson() => {
        "nomer_antrian": nomerAntrian,
        "status": status,
        "id_pasien": idPasien,
        "pasien_nama": pasienNama,
        "createdAt": createdAt.toIso8601String(),
    };
}
