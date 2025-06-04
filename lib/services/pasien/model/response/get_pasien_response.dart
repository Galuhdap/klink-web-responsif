// To parse this JSON data, do
//
//     final getPasienResponse = getPasienResponseFromJson(jsonString);

import 'dart:convert';

GetPasienResponse getPasienResponseFromJson(String str) => GetPasienResponse.fromJson(json.decode(str));

String getPasienResponseToJson(GetPasienResponse data) => json.encode(data.toJson());

class GetPasienResponse {
    final bool success;
    final int code;
    final String message;
    final Pasien data;

    GetPasienResponse({
        required this.success,
        required this.code,
        required this.message,
        required this.data,
    });

    GetPasienResponse copyWith({
        bool? success,
        int? code,
        String? message,
        Pasien? data,
    }) => 
        GetPasienResponse(
            success: success ?? this.success,
            code: code ?? this.code,
            message: message ?? this.message,
            data: data ?? this.data,
        );

    factory GetPasienResponse.fromJson(Map<String, dynamic> json) => GetPasienResponse(
        success: json["success"],
        code: json["code"],
        message: json["message"],
        data: Pasien.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "code": code,
        "message": message,
        "data": data.toJson(),
    };
}

class Pasien {
    final List<ListPasien> data;
    final Pagination pagination;

    Pasien({
        required this.data,
        required this.pagination,
    });

    Pasien copyWith({
        List<ListPasien>? data,
        Pagination? pagination,
    }) => 
        Pasien(
            data: data ?? this.data,
            pagination: pagination ?? this.pagination,
        );

    factory Pasien.fromJson(Map<String, dynamic> json) => Pasien(
        data: List<ListPasien>.from(json["data"].map((x) => ListPasien.fromJson(x))),
        pagination: Pagination.fromJson(json["pagination"]),
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "pagination": pagination.toJson(),
    };
}

class ListPasien {
    final int no;
    final String id;
    final String name;
    final String nik;
    final DateTime tglLahir;
    final String noTelp;
    final String jenisKelamin;
    final String umur;
    final String alamat;
    final String noRekamMedis;

    ListPasien({
        required this.no,
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

    ListPasien copyWith({
        int? no,
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
        ListPasien(
            no: no ?? this.no,
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

    factory ListPasien.fromJson(Map<String, dynamic> json) => ListPasien(
        no: json["no"],
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
        "no": no,
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
