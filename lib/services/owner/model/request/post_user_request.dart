// To parse this JSON data, do
//
//     final postUserRequest = postUserRequestFromJson(jsonString);

import 'dart:convert';

PostUserRequest postUserRequestFromJson(String str) => PostUserRequest.fromJson(json.decode(str));

String postUserRequestToJson(PostUserRequest data) => json.encode(data.toJson());

class PostUserRequest {
    String username;
    String password;
    String name;
    String email;
    String nik;
    DateTime tglLahir;
    String noTelp;
    String jenisKelamin;
    String alamat;
    String role;

    PostUserRequest({
        required this.username,
        required this.password,
        required this.name,
        required this.email,
        required this.nik,
        required this.tglLahir,
        required this.noTelp,
        required this.jenisKelamin,
        required this.alamat,
        required this.role,
    });

    factory PostUserRequest.fromJson(Map<String, dynamic> json) => PostUserRequest(
        username: json["username"],
        password: json["password"],
        name: json["name"],
        email: json["email"],
        nik: json["nik"],
        tglLahir: DateTime.parse(json["tgl_lahir"]),
        noTelp: json["no_telp"],
        jenisKelamin: json["jenis_kelamin"],
        alamat: json["alamat"],
        role: json["role"],
    );

    Map<String, dynamic> toJson() => {
        "username": username,
        "password": password,
        "name": name,
        "email": email,
        "nik": nik,
        "tgl_lahir": "${tglLahir.year.toString().padLeft(4, '0')}-${tglLahir.month.toString().padLeft(2, '0')}-${tglLahir.day.toString().padLeft(2, '0')}",
        "no_telp": noTelp,
        "jenis_kelamin": jenisKelamin,
        "alamat": alamat,
        "role": role,
    };
}
