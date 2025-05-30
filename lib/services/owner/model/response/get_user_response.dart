// To parse this JSON data, do
//
//     final getUserResponse = getUserResponseFromJson(jsonString);

import 'dart:convert';

GetUserResponse getUserResponseFromJson(String str) => GetUserResponse.fromJson(json.decode(str));

String getUserResponseToJson(GetUserResponse data) => json.encode(data.toJson());

class GetUserResponse {
    final bool success;
    final int code;
    final String message;
    final Data data;

    GetUserResponse({
        required this.success,
        required this.code,
        required this.message,
        required this.data,
    });

    GetUserResponse copyWith({
        bool? success,
        int? code,
        String? message,
        Data? data,
    }) => 
        GetUserResponse(
            success: success ?? this.success,
            code: code ?? this.code,
            message: message ?? this.message,
            data: data ?? this.data,
        );

    factory GetUserResponse.fromJson(Map<String, dynamic> json) => GetUserResponse(
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
    final List<UserData> data;
    final Pagination pagination;

    Data({
        required this.data,
        required this.pagination,
    });

    Data copyWith({
        List<UserData>? data,
        Pagination? pagination,
    }) => 
        Data(
            data: data ?? this.data,
            pagination: pagination ?? this.pagination,
        );

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        data: List<UserData>.from(json["data"].map((x) => UserData.fromJson(x))),
        pagination: Pagination.fromJson(json["pagination"]),
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "pagination": pagination.toJson(),
    };
}

class UserData {
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
    final Role role;

    UserData({
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

    UserData copyWith({
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
        Role? role,
    }) => 
        UserData(
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
            role: role ?? this.role,
        );

    factory UserData.fromJson(Map<String, dynamic> json) => UserData(
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
    final String id;
    final String name;

    Role({
        required this.id,
        required this.name,
    });

    Role copyWith({
        String? id,
        String? name,
    }) => 
        Role(
            id: id ?? this.id,
            name: name ?? this.name,
        );

    factory Role.fromJson(Map<String, dynamic> json) => Role(
        id: json["id"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
    };
}

class Pagination {
    final int total;
    final int page;
    final int limit;
    final int totalPages;

    Pagination({
        required this.total,
        required this.page,
        required this.limit,
        required this.totalPages,
    });

    Pagination copyWith({
        int? total,
        int? page,
        int? limit,
        int? totalPages,
    }) => 
        Pagination(
            total: total ?? this.total,
            page: page ?? this.page,
            limit: limit ?? this.limit,
            totalPages: totalPages ?? this.totalPages,
        );

    factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
        total: json["total"],
        page: json["page"],
        limit: json["limit"],
        totalPages: json["totalPages"],
    );

    Map<String, dynamic> toJson() => {
        "total": total,
        "page": page,
        "limit": limit,
        "totalPages": totalPages,
    };
}
