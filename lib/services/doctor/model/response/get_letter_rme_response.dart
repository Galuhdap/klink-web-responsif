// To parse this JSON data, do
//
//     final getLetterRmeResponse = getLetterRmeResponseFromJson(jsonString);

import 'dart:convert';

GetLetterRmeResponse getLetterRmeResponseFromJson(String str) =>
    GetLetterRmeResponse.fromJson(json.decode(str));

String getLetterRmeResponseToJson(GetLetterRmeResponse data) =>
    json.encode(data.toJson());

class GetLetterRmeResponse {
  bool success;
  int code;
  String message;
  Data data;

  GetLetterRmeResponse({
    required this.success,
    required this.code,
    required this.message,
    required this.data,
  });

  factory GetLetterRmeResponse.fromJson(Map<String, dynamic> json) =>
      GetLetterRmeResponse(
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
  List<DatumLetterRme> data;
  Pagination pagination;

  Data({
    required this.data,
    required this.pagination,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        data: List<DatumLetterRme>.from(json["data"].map((x) => DatumLetterRme.fromJson(x))),
        pagination: Pagination.fromJson(json["pagination"]),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "pagination": pagination.toJson(),
      };
}

class DatumLetterRme {
  int no;
  String id;
  String noLetter;
  String pekerjaan;
  String keperluan;
  DateTime startDate;
  DateTime endDate;
  DateTime createdAt;
  String pasienid;
  String? userId;
  Pasien pasien;
  User user;

  DatumLetterRme({
    required this.no,
    required this.id,
    required this.noLetter,
    required this.pekerjaan,
    required this.keperluan,
    required this.startDate,
    required this.endDate,
    required this.createdAt,
    required this.pasienid,
    this.userId,
    required this.pasien,
    required this.user,
  });

  factory DatumLetterRme.fromJson(Map<String, dynamic> json) => DatumLetterRme(
        no: json["no"],
        id: json["id"],
        noLetter: json["no_letter"],
        pekerjaan: json["pekerjaan"],
        keperluan: json["keperluan"],
        startDate: DateTime.parse(json["start_date"]),
        endDate: DateTime.parse(json["end_date"]),
        createdAt: DateTime.parse(json["createdAt"]),
        pasienid: json["pasienid"],
        userId: json["userId"],
        pasien: Pasien.fromJson(json["pasien"]),
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "no": no,
        "id": id,
        "no_letter": noLetter,
        "pekerjaan": pekerjaan,
        "keperluan": keperluan,
        "start_date": startDate.toIso8601String(),
        "end_date": endDate.toIso8601String(),
        "createdAt": createdAt.toIso8601String(),
        "pasienid": pasienid,
        "userId": userId,
        "pasien": pasien.toJson(),
        "user": user.toJson(),
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

class User {
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

  User({
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

  factory User.fromJson(Map<String, dynamic> json) => User(
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
        "tgl_lahir":
            "${tglLahir.year.toString().padLeft(4, '0')}-${tglLahir.month.toString().padLeft(2, '0')}-${tglLahir.day.toString().padLeft(2, '0')}",
        "no_telp": noTelp,
        "jenis_kelamin": jenisKelamin,
        "alamat": alamat,
        "roleId": roleId,
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
