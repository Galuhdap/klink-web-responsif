// To parse this JSON data, do
//
//     final getDoctorResponse = getDoctorResponseFromJson(jsonString);

import 'dart:convert';

GetDoctorResponse getDoctorResponseFromJson(String str) => GetDoctorResponse.fromJson(json.decode(str));

String getDoctorResponseToJson(GetDoctorResponse data) => json.encode(data.toJson());

class GetDoctorResponse {
    final bool success;
    final int code;
    final String message;
    final Data data;

    GetDoctorResponse({
        required this.success,
        required this.code,
        required this.message,
        required this.data,
    });

    GetDoctorResponse copyWith({
        bool? success,
        int? code,
        String? message,
        Data? data,
    }) => 
        GetDoctorResponse(
            success: success ?? this.success,
            code: code ?? this.code,
            message: message ?? this.message,
            data: data ?? this.data,
        );

    factory GetDoctorResponse.fromJson(Map<String, dynamic> json) => GetDoctorResponse(
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
    final List<DataDoctor> data;
    final Pagination pagination;

    Data({
        required this.data,
        required this.pagination,
    });

    Data copyWith({
        List<DataDoctor>? data,
        Pagination? pagination,
    }) => 
        Data(
            data: data ?? this.data,
            pagination: pagination ?? this.pagination,
        );

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        data: List<DataDoctor>.from(json["data"].map((x) => DataDoctor.fromJson(x))),
        pagination: Pagination.fromJson(json["pagination"]),
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "pagination": pagination.toJson(),
    };
}

class DataDoctor {
    final String username;
    final String email;
    final String name;
    final String nik;
    final DateTime tglLahir;
    final String noTelp;
    final String alamat;
    final String jenisKelamin;
    final StatusDokter statusDokter;

    DataDoctor({
        required this.username,
        required this.email,
        required this.name,
        required this.nik,
        required this.tglLahir,
        required this.noTelp,
        required this.alamat,
        required this.jenisKelamin,
        required this.statusDokter,
    });

    DataDoctor copyWith({
        String? username,
        String? email,
        String? name,
        String? nik,
        DateTime? tglLahir,
        String? noTelp,
        String? alamat,
        String? jenisKelamin,
        StatusDokter? statusDokter,
    }) => 
        DataDoctor(
            username: username ?? this.username,
            email: email ?? this.email,
            name: name ?? this.name,
            nik: nik ?? this.nik,
            tglLahir: tglLahir ?? this.tglLahir,
            noTelp: noTelp ?? this.noTelp,
            alamat: alamat ?? this.alamat,
            jenisKelamin: jenisKelamin ?? this.jenisKelamin,
            statusDokter: statusDokter ?? this.statusDokter,
        );

    factory DataDoctor.fromJson(Map<String, dynamic> json) => DataDoctor(
        username: json["username"],
        email: json["email"],
        name: json["name"],
        nik: json["nik"],
        tglLahir: DateTime.parse(json["tgl_lahir"]),
        noTelp: json["no_telp"],
        alamat: json["alamat"],
        jenisKelamin: json["jenis_kelamin"],
        statusDokter: StatusDokter.fromJson(json["statusDokter"]),
    );

    Map<String, dynamic> toJson() => {
        "username": username,
        "email": email,
        "name": name,
        "nik": nik,
        "tgl_lahir": "${tglLahir.year.toString().padLeft(4, '0')}-${tglLahir.month.toString().padLeft(2, '0')}-${tglLahir.day.toString().padLeft(2, '0')}",
        "no_telp": noTelp,
        "alamat": alamat,
        "jenis_kelamin": jenisKelamin,
        "statusDokter": statusDokter.toJson(),
    };
}

class StatusDokter {
    final String status;

    StatusDokter({
        required this.status,
    });

    StatusDokter copyWith({
        String? status,
    }) => 
        StatusDokter(
            status: status ?? this.status,
        );

    factory StatusDokter.fromJson(Map<String, dynamic> json) => StatusDokter(
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
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
