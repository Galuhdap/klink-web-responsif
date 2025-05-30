// To parse this JSON data, do
//
//     final posMedicineResponse = posMedicineResponseFromJson(jsonString);

import 'dart:convert';

PosMedicineResponse posMedicineResponseFromJson(String str) => PosMedicineResponse.fromJson(json.decode(str));

String posMedicineResponseToJson(PosMedicineResponse data) => json.encode(data.toJson());

class PosMedicineResponse {
    final bool success;
    final int code;
    final String message;
    final PostMedicineData data;

    PosMedicineResponse({
        required this.success,
        required this.code,
        required this.message,
        required this.data,
    });

    PosMedicineResponse copyWith({
        bool? success,
        int? code,
        String? message,
        PostMedicineData? data,
    }) => 
        PosMedicineResponse(
            success: success ?? this.success,
            code: code ?? this.code,
            message: message ?? this.message,
            data: data ?? this.data,
        );

    factory PosMedicineResponse.fromJson(Map<String, dynamic> json) => PosMedicineResponse(
        success: json["success"],
        code: json["code"],
        message: json["message"],
        data: PostMedicineData.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "code": code,
        "message": message,
        "data": data.toJson(),
    };
}

class PostMedicineData {
    final String id;
    final String namaObat;
    final DateTime tglKadaluarsa;
    final int stock;
    final String statusObat;

    PostMedicineData({
        required this.id,
        required this.namaObat,
        required this.tglKadaluarsa,
        required this.stock,
        required this.statusObat,
    });

    PostMedicineData copyWith({
        String? id,
        String? namaObat,
        DateTime? tglKadaluarsa,
        int? stock,
        String? statusObat,
    }) => 
        PostMedicineData(
            id: id ?? this.id,
            namaObat: namaObat ?? this.namaObat,
            tglKadaluarsa: tglKadaluarsa ?? this.tglKadaluarsa,
            stock: stock ?? this.stock,
            statusObat: statusObat ?? this.statusObat,
        );

    factory PostMedicineData.fromJson(Map<String, dynamic> json) => PostMedicineData(
        id: json["id"],
        namaObat: json["nama_obat"],
        tglKadaluarsa: DateTime.parse(json["tgl_kadaluarsa"]),
        stock: json["stock"],
        statusObat: json["status_obat"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nama_obat": namaObat,
        "tgl_kadaluarsa": tglKadaluarsa.toIso8601String(),
        "stock": stock,
        "status_obat": statusObat,
    };
}
