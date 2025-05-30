// To parse this JSON data, do
//
//     final postRmeResponse = postRmeResponseFromJson(jsonString);

import 'dart:convert';

PostRmeResponse postRmeResponseFromJson(String str) => PostRmeResponse.fromJson(json.decode(str));

String postRmeResponseToJson(PostRmeResponse data) => json.encode(data.toJson());

class PostRmeResponse {
    final bool success;
    final int code;
    final String message;
    final MedicineResponse data;

    PostRmeResponse({
        required this.success,
        required this.code,
        required this.message,
        required this.data,
    });

    PostRmeResponse copyWith({
        bool? success,
        int? code,
        String? message,
        MedicineResponse? data,
    }) => 
        PostRmeResponse(
            success: success ?? this.success,
            code: code ?? this.code,
            message: message ?? this.message,
            data: data ?? this.data,
        );

    factory PostRmeResponse.fromJson(Map<String, dynamic> json) => PostRmeResponse(
        success: json["success"],
        code: json["code"],
        message: json["message"],
        data: MedicineResponse.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "code": code,
        "message": message,
        "data": data.toJson(),
    };
}

class MedicineResponse {
    final String id;
    final DateTime jadwalPeriksa;
    final String keluhan;
    final String terapiTindakan;
    final String dx;
    final int total;
    final String idPasien;
    final String userId;

    MedicineResponse({
        required this.id,
        required this.jadwalPeriksa,
        required this.keluhan,
        required this.terapiTindakan,
        required this.dx,
        required this.total,
        required this.idPasien,
        required this.userId,
    });

    MedicineResponse copyWith({
        String? id,
        DateTime? jadwalPeriksa,
        String? keluhan,
        String? terapiTindakan,
        String? dx,
        int? total,
        String? idPasien,
        String? userId,
    }) => 
        MedicineResponse(
            id: id ?? this.id,
            jadwalPeriksa: jadwalPeriksa ?? this.jadwalPeriksa,
            keluhan: keluhan ?? this.keluhan,
            terapiTindakan: terapiTindakan ?? this.terapiTindakan,
            dx: dx ?? this.dx,
            total: total ?? this.total,
            idPasien: idPasien ?? this.idPasien,
            userId: userId ?? this.userId,
        );

    factory MedicineResponse.fromJson(Map<String, dynamic> json) => MedicineResponse(
        id: json["id"],
        jadwalPeriksa: DateTime.parse(json["jadwal_periksa"]),
        keluhan: json["keluhan"],
        terapiTindakan: json["terapi_tindakan"],
        dx: json["dx"],
        total: json["total"],
        idPasien: json["id_pasien"],
        userId: json["userId"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "jadwal_periksa": jadwalPeriksa.toIso8601String(),
        "keluhan": keluhan,
        "terapi_tindakan": terapiTindakan,
        "dx": dx,
        "total": total,
        "id_pasien": idPasien,
        "userId": userId,
    };
}
