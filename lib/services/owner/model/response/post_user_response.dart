// To parse this JSON data, do
//
//     final postUserResponse = postUserResponseFromJson(jsonString);

import 'dart:convert';

PostUserResponse postUserResponseFromJson(String str) => PostUserResponse.fromJson(json.decode(str));

String postUserResponseToJson(PostUserResponse data) => json.encode(data.toJson());

class PostUserResponse {
    final bool success;
    final int code;
    final String message;
    final Data data;

    PostUserResponse({
        required this.success,
        required this.code,
        required this.message,
        required this.data,
    });

    PostUserResponse copyWith({
        bool? success,
        int? code,
        String? message,
        Data? data,
    }) => 
        PostUserResponse(
            success: success ?? this.success,
            code: code ?? this.code,
            message: message ?? this.message,
            data: data ?? this.data,
        );

    factory PostUserResponse.fromJson(Map<String, dynamic> json) => PostUserResponse(
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
    final String username;
    final String email;
    final String password;
    final String name;
    final String nik;
    final DateTime tglLahir;
    final String noTelp;
    final String jenisKelamin;
    final String alamat;
    final String roleId;

    Data({
        required this.id,
        required this.username,
        required this.email,
        required this.password,
        required this.name,
        required this.nik,
        required this.tglLahir,
        required this.noTelp,
        required this.jenisKelamin,
        required this.alamat,
        required this.roleId,
    });

    Data copyWith({
        String? id,
        String? username,
        String? email,
        String? password,
        String? name,
        String? nik,
        DateTime? tglLahir,
        String? noTelp,
        String? jenisKelamin,
        String? alamat,
        String? roleId,
    }) => 
        Data(
            id: id ?? this.id,
            username: username ?? this.username,
            email: email ?? this.email,
            password: password ?? this.password,
            name: name ?? this.name,
            nik: nik ?? this.nik,
            tglLahir: tglLahir ?? this.tglLahir,
            noTelp: noTelp ?? this.noTelp,
            jenisKelamin: jenisKelamin ?? this.jenisKelamin,
            alamat: alamat ?? this.alamat,
            roleId: roleId ?? this.roleId,
        );

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        username: json["username"],
        email: json["email"],
        password: json["password"],
        name: json["name"],
        nik: json["nik"],
        tglLahir: DateTime.parse(json["tgl_lahir"]),
        noTelp: json["no_telp"],
        jenisKelamin: json["jenis_kelamin"],
        alamat: json["alamat"],
        roleId: json["roleId"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "email": email,
        "password": password,
        "name": name,
        "nik": nik,
        "tgl_lahir": "${tglLahir.year.toString().padLeft(4, '0')}-${tglLahir.month.toString().padLeft(2, '0')}-${tglLahir.day.toString().padLeft(2, '0')}",
        "no_telp": noTelp,
        "jenis_kelamin": jenisKelamin,
        "alamat": alamat,
        "roleId": roleId,
    };
}
