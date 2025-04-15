// To parse this JSON data, do
//
//     final errorCreatePasienResponse = errorCreatePasienResponseFromJson(jsonString);

import 'dart:convert';

ErrorCreatePasienResponse errorCreatePasienResponseFromJson(String str) => ErrorCreatePasienResponse.fromJson(json.decode(str));

String errorCreatePasienResponseToJson(ErrorCreatePasienResponse data) => json.encode(data.toJson());

class ErrorCreatePasienResponse {
    final bool? success;
    final int? code;
    final Message? message;

    ErrorCreatePasienResponse({
        this.success,
        this.code,
        this.message,
    });

    ErrorCreatePasienResponse copyWith({
        bool? success,
        int? code,
        Message? message,
    }) => 
        ErrorCreatePasienResponse(
            success: success ?? this.success,
            code: code ?? this.code,
            message: message ?? this.message,
        );

    factory ErrorCreatePasienResponse.fromJson(Map<String, dynamic> json) => ErrorCreatePasienResponse(
        success: json["success"],
        code: json["code"],
        message: Message.fromJson(json["message"]),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "code": code,
        "message": message!.toJson(),
    };
}

class Message {
    final String? name;
    final String? nik;
    final String? tglLahir;
    final String? noTelp;
    final String? jenisKelamin;
    final String? umur;
    final String? alamat;

    Message({
        this.name,
        this.nik,
        this.tglLahir,
        this.noTelp,
        this.jenisKelamin,
        this.umur,
        this.alamat,
    });

    Message copyWith({
        String? name,
        String? nik,
        String? tglLahir,
        String? noTelp,
        String? jenisKelamin,
        String? umur,
        String? alamat,
    }) => 
        Message(
            name: name ?? this.name,
            nik: nik ?? this.nik,
            tglLahir: tglLahir ?? this.tglLahir,
            noTelp: noTelp ?? this.noTelp,
            jenisKelamin: jenisKelamin ?? this.jenisKelamin,
            umur: umur ?? this.umur,
            alamat: alamat ?? this.alamat,
        );

    factory Message.fromJson(Map<String, dynamic> json) => Message(
        name: json["name"],
        nik: json["nik"],
        tglLahir: json["tgl_lahir"],
        noTelp: json["no_telp"],
        jenisKelamin: json["jenis_kelamin"],
        umur: json["umur"],
        alamat: json["alamat"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "nik": nik,
        "tgl_lahir": tglLahir,
        "no_telp": noTelp,
        "jenis_kelamin": jenisKelamin,
        "umur": umur,
        "alamat": alamat,
    };
}
