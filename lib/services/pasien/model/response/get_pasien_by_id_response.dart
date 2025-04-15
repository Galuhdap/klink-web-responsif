// To parse this JSON data, do
//
//     final getPasienByIdResponse = getPasienByIdResponseFromJson(jsonString);

import 'dart:convert';

GetPasienByIdResponse getPasienByIdResponseFromJson(String str) => GetPasienByIdResponse.fromJson(json.decode(str));

String getPasienByIdResponseToJson(GetPasienByIdResponse data) => json.encode(data.toJson());

class GetPasienByIdResponse {
    final bool success;
    final int code;
    final String message;
    final DataPasien data;

    GetPasienByIdResponse({
        required this.success,
        required this.code,
        required this.message,
        required this.data,
    });

    GetPasienByIdResponse copyWith({
        bool? success,
        int? code,
        String? message,
        DataPasien? data,
    }) => 
        GetPasienByIdResponse(
            success: success ?? this.success,
            code: code ?? this.code,
            message: message ?? this.message,
            data: data ?? this.data,
        );

    factory GetPasienByIdResponse.fromJson(Map<String, dynamic> json) => GetPasienByIdResponse(
        success: json["success"],
        code: json["code"],
        message: json["message"],
        data: DataPasien.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "code": code,
        "message": message,
        "data": data.toJson(),
    };
}

class DataPasien {
    final String id;
    final String name;
    final String nik;
    final DateTime tglLahir;
    final String noTelp;
    final String jenisKelamin;
    final String umur;
    final String alamat;
    final String noRekamMedis;

    DataPasien({
        required this.id,
        required this.name,
        required this.nik,
        required this.tglLahir,
        required this.noTelp,
        required this.jenisKelamin,
        required this.umur,
        required this.alamat,
        required this.noRekamMedis,
    });

    DataPasien copyWith({
        String? id,
        String? name,
        String? nik,
        DateTime? tglLahir,
        String? noTelp,
        String? jenisKelamin,
        String? umur,
        String? alamat,
        String? noRekamMedis,
    }) => 
        DataPasien(
            id: id ?? this.id,
            name: name ?? this.name,
            nik: nik ?? this.nik,
            tglLahir: tglLahir ?? this.tglLahir,
            noTelp: noTelp ?? this.noTelp,
            jenisKelamin: jenisKelamin ?? this.jenisKelamin,
            umur: umur ?? this.umur,
            alamat: alamat ?? this.alamat,
            noRekamMedis: noRekamMedis ?? this.noRekamMedis,
        );

    factory DataPasien.fromJson(Map<String, dynamic> json) => DataPasien(
        id: json["id"],
        name: json["name"],
        nik: json["nik"],
        tglLahir: DateTime.parse(json["tgl_lahir"]),
        noTelp: json["no_telp"],
        jenisKelamin: json["jenis_kelamin"],
        umur: json["umur"],
        alamat: json["alamat"],
        noRekamMedis: json["no_rekam_medis"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "nik": nik,
        "tgl_lahir": "${tglLahir.year.toString().padLeft(4, '0')}-${tglLahir.month.toString().padLeft(2, '0')}-${tglLahir.day.toString().padLeft(2, '0')}",
        "no_telp": noTelp,
        "jenis_kelamin": jenisKelamin,
        "umur": umur,
        "alamat": alamat,
        "no_rekam_medis": noRekamMedis,
    };
}
