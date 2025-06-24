// To parse this JSON data, do
//
//     final getLetterSickResponse = getLetterSickResponseFromJson(jsonString);

import 'dart:convert';

GetLetterSickResponse getLetterSickResponseFromJson(String str) =>
    GetLetterSickResponse.fromJson(json.decode(str));

String getLetterSickResponseToJson(GetLetterSickResponse data) =>
    json.encode(data.toJson());

class GetLetterSickResponse {
  bool success;
  int code;
  String message;
  Data data;

  GetLetterSickResponse({
    required this.success,
    required this.code,
    required this.message,
    required this.data,
  });

  factory GetLetterSickResponse.fromJson(Map<String, dynamic> json) =>
      GetLetterSickResponse(
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
  List<DatumLetterSick> data;
  Pagination pagination;

  Data({
    required this.data,
    required this.pagination,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        data: List<DatumLetterSick>.from(
            json["data"].map((x) => DatumLetterSick.fromJson(x))),
        pagination: Pagination.fromJson(json["pagination"]),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "pagination": pagination.toJson(),
      };
}

class DatumLetterSick {
  int no;
  String id;
  String noLatter;
  String job;
  String complaint;
  String diagnosa;
  String restPeriod;
  DateTime startDate;
  DateTime endDate;
  DateTime createdAt;
  String pasienid;
  Pasien pasien;

  DatumLetterSick({
    required this.no,
    required this.id,
    required this.noLatter,
    required this.job,
    required this.complaint,
    required this.diagnosa,
    required this.restPeriod,
    required this.startDate,
    required this.endDate,
    required this.createdAt,
    required this.pasienid,
    required this.pasien,
  });

  factory DatumLetterSick.fromJson(Map<String, dynamic> json) =>
      DatumLetterSick(
        no: json["no"],
        id: json["id"],
        noLatter: json["no_latter"],
        job: json["job"],
        complaint: json["complaint"],
        diagnosa: json["diagnosa"],
        restPeriod: json["rest_period"],
        startDate: DateTime.parse(json["start_date"]),
        endDate: DateTime.parse(json["end_date"]),
        createdAt: DateTime.parse(json["createdAt"]),
        pasienid: json["pasienid"],
        pasien: Pasien.fromJson(json["pasien"]),
      );

  Map<String, dynamic> toJson() => {
        "no": no,
        "id": id,
        "no_latter": noLatter,
        "job": job,
        "complaint": complaint,
        "diagnosa": diagnosa,
        "rest_period": restPeriod,
        "start_date": startDate.toIso8601String(),
        "end_date": endDate.toIso8601String(),
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
