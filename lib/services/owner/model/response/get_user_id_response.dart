// To parse this JSON data, do
//
//     final getUserIdResponse = getUserIdResponseFromJson(jsonString);

import 'dart:convert';

GetUserIdResponse getUserIdResponseFromJson(String str) => GetUserIdResponse.fromJson(json.decode(str));

String getUserIdResponseToJson(GetUserIdResponse data) => json.encode(data.toJson());

class GetUserIdResponse {
    bool success;
    int code;
    String message;
    Data data;

    GetUserIdResponse({
        required this.success,
        required this.code,
        required this.message,
        required this.data,
    });

    factory GetUserIdResponse.fromJson(Map<String, dynamic> json) => GetUserIdResponse(
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
    String username;
    String email;
    String password;
    String name;
    String nik;
    DateTime tglLahir;
    String noTelp;
    String jenisKelamin;
    String alamat;
    String roleId;
    Role role;

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
        required this.role,
    });

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
        role: Role.fromJson(json["role"]),
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
        "role": role.toJson(),
    };
}

class Role {
    String id;
    String name;

    Role({
        required this.id,
        required this.name,
    });

    factory Role.fromJson(Map<String, dynamic> json) => Role(
        id: json["id"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
    };
}
