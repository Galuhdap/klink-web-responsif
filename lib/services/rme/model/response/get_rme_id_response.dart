// To parse this JSON data, do
//
//     final getRmeIdResponse = getRmeIdResponseFromJson(jsonString);

import 'dart:convert';

GetRmeIdResponse getRmeIdResponseFromJson(String str) => GetRmeIdResponse.fromJson(json.decode(str));

String getRmeIdResponseToJson(GetRmeIdResponse data) => json.encode(data.toJson());

class GetRmeIdResponse {
    final bool success;
    final int code;
    final String message;
    final Data data;

    GetRmeIdResponse({
        required this.success,
        required this.code,
        required this.message,
        required this.data,
    });

    GetRmeIdResponse copyWith({
        bool? success,
        int? code,
        String? message,
        Data? data,
    }) => 
        GetRmeIdResponse(
            success: success ?? this.success,
            code: code ?? this.code,
            message: message ?? this.message,
            data: data ?? this.data,
        );

    factory GetRmeIdResponse.fromJson(Map<String, dynamic> json) => GetRmeIdResponse(
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
    final List<RmeData> data;
    final Pagination pagination;

    Data({
        required this.data,
        required this.pagination,
    });

    Data copyWith({
        List<RmeData>? data,
        Pagination? pagination,
    }) => 
        Data(
            data: data ?? this.data,
            pagination: pagination ?? this.pagination,
        );

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        data: List<RmeData>.from(json["data"].map((x) => RmeData.fromJson(x))),
        pagination: Pagination.fromJson(json["pagination"]),
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "pagination": pagination.toJson(),
    };
}

class RmeData {
    final String id;
    final DateTime jadwalPeriksa;
    final String idPasien;
    final String namaPasien;
    final String noRekamMedis;
    final String keluhan;
    final String terapiTindakan;
    final String dx;
    final int total;
    final List<Obat> obat;
    final User user;

    RmeData({
        required this.id,
        required this.jadwalPeriksa,
        required this.idPasien,
        required this.namaPasien,
        required this.noRekamMedis,
        required this.keluhan,
        required this.terapiTindakan,
        required this.dx,
        required this.total,
        required this.obat,
        required this.user,
    });

    RmeData copyWith({
        String? id,
        DateTime? jadwalPeriksa,
        String? idPasien,
        String? namaPasien,
        String? noRekamMedis,
        String? keluhan,
        String? terapiTindakan,
        String? dx,
        int? total,
        List<Obat>? obat,
        User? user,
    }) => 
        RmeData(
            id: id ?? this.id,
            jadwalPeriksa: jadwalPeriksa ?? this.jadwalPeriksa,
            idPasien: idPasien ?? this.idPasien,
            namaPasien: namaPasien ?? this.namaPasien,
            noRekamMedis: noRekamMedis ?? this.noRekamMedis,
            keluhan: keluhan ?? this.keluhan,
            terapiTindakan: terapiTindakan ?? this.terapiTindakan,
            dx: dx ?? this.dx,
            total: total ?? this.total,
            obat: obat ?? this.obat,
            user: user ?? this.user,
        );

    factory RmeData.fromJson(Map<String, dynamic> json) => RmeData(
        id: json["id"],
        jadwalPeriksa: DateTime.parse(json["jadwal_periksa"]),
        idPasien: json["id_pasien"],
        namaPasien: json["nama_pasien"],
        noRekamMedis: json["no_rekam_medis"],
        keluhan: json["keluhan"],
        terapiTindakan: json["terapi_tindakan"],
        dx: json["dx"],
        total: json["total"],
        obat: List<Obat>.from(json["obat"].map((x) => Obat.fromJson(x))),
        user: User.fromJson(json["user"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "jadwal_periksa": jadwalPeriksa.toIso8601String(),
        "id_pasien": idPasien,
        "nama_pasien": namaPasien,
        "no_rekam_medis": noRekamMedis,
        "keluhan": keluhan,
        "terapi_tindakan": terapiTindakan,
        "dx": dx,
        "total": total,
        "obat": List<dynamic>.from(obat.map((x) => x.toJson())),
        "user": user.toJson(),
    };
}

class Obat {
    final String id;
    final String namaObat;
    final DateTime tglKadaluarsa;
    final int stock;
    final String statusObat;
    final int qty;

    Obat({
        required this.id,
        required this.namaObat,
        required this.tglKadaluarsa,
        required this.stock,
        required this.statusObat,
        required this.qty,
    });

    Obat copyWith({
        String? id,
        String? namaObat,
        DateTime? tglKadaluarsa,
        int? stock,
        String? statusObat,
        int? qty,
    }) => 
        Obat(
            id: id ?? this.id,
            namaObat: namaObat ?? this.namaObat,
            tglKadaluarsa: tglKadaluarsa ?? this.tglKadaluarsa,
            stock: stock ?? this.stock,
            statusObat: statusObat ?? this.statusObat,
            qty: qty ?? this.qty,
        );

    factory Obat.fromJson(Map<String, dynamic> json) => Obat(
        id: json["id"],
        namaObat: json["nama_obat"],
        tglKadaluarsa: DateTime.parse(json["tgl_kadaluarsa"]),
        stock: json["stock"],
        statusObat: json["status_obat"],
        qty: json["qty"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nama_obat": namaObat,
        "tgl_kadaluarsa": "${tglKadaluarsa.year.toString().padLeft(4, '0')}-${tglKadaluarsa.month.toString().padLeft(2, '0')}-${tglKadaluarsa.day.toString().padLeft(2, '0')}",
        "stock": stock,
        "status_obat": statusObat,
        "qty": qty,
    };
}

class User {
    final String name;
    final String email;
    final String noTelp;

    User({
        required this.name,
        required this.email,
        required this.noTelp,
    });

    User copyWith({
        String? name,
        String? email,
        String? noTelp,
    }) => 
        User(
            name: name ?? this.name,
            email: email ?? this.email,
            noTelp: noTelp ?? this.noTelp,
        );

    factory User.fromJson(Map<String, dynamic> json) => User(
        name: json["name"],
        email: json["email"],
        noTelp: json["no_telp"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "no_telp": noTelp,
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
