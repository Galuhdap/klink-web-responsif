// To parse this JSON data, do
//
//     final getAntrianPasienResponse = getAntrianPasienResponseFromJson(jsonString);

import 'dart:convert';

GetAntrianPasienResponse getAntrianPasienResponseFromJson(String str) =>
    GetAntrianPasienResponse.fromJson(json.decode(str));

String getAntrianPasienResponseToJson(GetAntrianPasienResponse data) =>
    json.encode(data.toJson());

class GetAntrianPasienResponse {
  final bool success;
  final int code;
  final String message;
  final Data data;

  GetAntrianPasienResponse({
    required this.success,
    required this.code,
    required this.message,
    required this.data,
  });

  GetAntrianPasienResponse copyWith({
    bool? success,
    int? code,
    String? message,
    Data? data,
  }) =>
      GetAntrianPasienResponse(
        success: success ?? this.success,
        code: code ?? this.code,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory GetAntrianPasienResponse.fromJson(Map<String, dynamic> json) =>
      GetAntrianPasienResponse(
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
  final List<AntrianData> data;
  final Pagination pagination;

  Data({
    required this.data,
    required this.pagination,
  });

  Data copyWith({
    List<AntrianData>? data,
    Pagination? pagination,
  }) =>
      Data(
        data: data ?? this.data,
        pagination: pagination ?? this.pagination,
      );

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        data: List<AntrianData>.from(
            json["data"].map((x) => AntrianData.fromJson(x))),
        pagination: Pagination.fromJson(json["pagination"]),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "pagination": pagination.toJson(),
      };
}

class AntrianData {
  String id;
  String nomerAntrian;
  String status;
  String waktuTunggu;
  int waitingTimeSeconds;
  DateTime lastUpdated;
  String idPasien;
  DateTime createdAt;
  Pasien pasien;
  String waitingTimeFormatted;

  AntrianData({
    required this.id,
    required this.nomerAntrian,
    required this.status,
    required this.waktuTunggu,
    required this.waitingTimeSeconds,
    required this.lastUpdated,
    required this.idPasien,
    required this.createdAt,
    required this.pasien,
    required this.waitingTimeFormatted,
  });

  AntrianData copyWith({
    String? id,
    String? nomerAntrian,
    String? status,
    String? waktuTunggu,
    int? waitingTimeSeconds,
    DateTime? lastUpdated,
    String? idPasien,
    DateTime? createdAt,
    Pasien? pasien,
    String? waitingTimeFormatted,
  }) =>
      AntrianData(
        id: id ?? this.id,
        nomerAntrian: nomerAntrian ?? this.nomerAntrian,
        status: status ?? this.status,
        waktuTunggu: waktuTunggu ?? this.waktuTunggu,
        waitingTimeSeconds: waitingTimeSeconds ?? this.waitingTimeSeconds,
        lastUpdated: lastUpdated ?? this.lastUpdated,
        idPasien: idPasien ?? this.idPasien,
        createdAt: createdAt ?? this.createdAt,
        pasien: pasien ?? this.pasien,
        waitingTimeFormatted: waitingTimeFormatted ?? this.waitingTimeFormatted,
      );

  factory AntrianData.fromJson(Map<String, dynamic> json) => AntrianData(
        id: json["id"],
        nomerAntrian: json["nomer_antrian"],
        status: json["status"],
        waktuTunggu: json["waktu_tunggu"],
        waitingTimeSeconds: json["waitingTimeSeconds"],
        lastUpdated: DateTime.parse(json["lastUpdated"]),
        idPasien: json["id_pasien"],
        createdAt: DateTime.parse(json["createdAt"]),
        pasien: Pasien.fromJson(json["pasien"]),
        waitingTimeFormatted: json["waitingTimeFormatted"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nomer_antrian": nomerAntrian,
        "status": status,
        "waktu_tunggu": waktuTunggu,
        "waitingTimeSeconds": waitingTimeSeconds,
        "lastUpdated": lastUpdated.toIso8601String(),
        "id_pasien": idPasien,
        "createdAt": createdAt.toIso8601String(),
        "pasien": pasien.toJson(),
        "waitingTimeFormatted": waitingTimeFormatted,
      };
}

class Pasien {
  final String id;
  final String name;
  final String nik;
  final DateTime tglLahir;
  final String noTelp;
  final String jenisKelamin;
  final String umur;
  final String alamat;
  final String noRekamMedis;

  Pasien({
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

  Pasien copyWith({
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
      Pasien(
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

  factory Pasien.fromJson(Map<String, dynamic> json) => Pasien(
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
        "tgl_lahir":
            "${tglLahir.year.toString().padLeft(4, '0')}-${tglLahir.month.toString().padLeft(2, '0')}-${tglLahir.day.toString().padLeft(2, '0')}",
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
