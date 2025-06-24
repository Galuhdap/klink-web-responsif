// To parse this JSON data, do
//
//     final getLetterHealtResponse = getLetterHealtResponseFromJson(jsonString);

import 'dart:convert';

GetLetterHealtResponse getLetterHealtResponseFromJson(String str) =>
    GetLetterHealtResponse.fromJson(json.decode(str));

String getLetterHealtResponseToJson(GetLetterHealtResponse data) =>
    json.encode(data.toJson());

class GetLetterHealtResponse {
  bool success;
  int code;
  String message;
  Data data;

  GetLetterHealtResponse({
    required this.success,
    required this.code,
    required this.message,
    required this.data,
  });

  factory GetLetterHealtResponse.fromJson(Map<String, dynamic> json) =>
      GetLetterHealtResponse(
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
  List<DatumLetterHealt> data;
  Pagination pagination;

  Data({
    required this.data,
    required this.pagination,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        data: List<DatumLetterHealt>.from(
            json["data"].map((x) => DatumLetterHealt.fromJson(x))),
        pagination: Pagination.fromJson(json["pagination"]),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "pagination": pagination.toJson(),
      };
}

class DatumLetterHealt {
  int no;
  String id;
  String noLetter;
  String job;
  String complaint;
  String perihal;
  String td;
  String n;
  String s;
  DateTime createdAt;
  String pasienid;
  Pasien pasien;

  DatumLetterHealt({
    required this.no,
    required this.id,
    required this.noLetter,
    required this.job,
    required this.complaint,
    required this.perihal,
    required this.td,
    required this.n,
    required this.s,
    required this.createdAt,
    required this.pasienid,
    required this.pasien,
  });

  factory DatumLetterHealt.fromJson(Map<String, dynamic> json) =>
      DatumLetterHealt(
        no: json["no"],
        id: json["id"],
        noLetter: json["no_letter"],
        job: json["job"],
        complaint: json["complaint"],
        perihal: json["perihal"],
        td: json["td"],
        n: json["n"],
        s: json["s"],
        createdAt: DateTime.parse(json["createdAt"]),
        pasienid: json["pasienid"],
        pasien: Pasien.fromJson(json["pasien"]),
      );

  Map<String, dynamic> toJson() => {
        "no": no,
        "id": id,
        "no_letter": noLetter,
        "job": job,
        "complaint": complaint,
        "perihal": perihal,
        "td": td,
        "n": n,
        "s": s,
        "createdAt": createdAt.toIso8601String(),
        "pasienid": pasienid,
        "pasien": pasien.toJson(),
      };
}

class Pasien {
  String id;
  String name;
  String nik;
  DateTime tglLahir;
  String noTelp;
  String jenisKelamin;
  String umur;
  String alamat;
  String noRekamMedis;
  DateTime createdAt;

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
    required this.createdAt,
  });

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
        createdAt: DateTime.parse(json["createdAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "nik": nik,
        "tgl_lahir": tglLahir.toIso8601String(),
        "no_telp": noTelp,
        "jenis_kelamin": jenisKelamin,
        "umur": umur,
        "alamat": alamat,
        "no_rekam_medis": noRekamMedis,
        "createdAt": createdAt.toIso8601String(),
      };
}

class Pagination {
  int total;
  int page;
  int limit;
  int totalPages;

  Pagination({
    required this.total,
    required this.page,
    required this.limit,
    required this.totalPages,
  });

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
