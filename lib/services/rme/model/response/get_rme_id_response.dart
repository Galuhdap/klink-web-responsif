// To parse this JSON data, do
//
//     final getRmeIdResponse = getRmeIdResponseFromJson(jsonString);

import 'dart:convert';

GetRmeIdResponse getRmeIdResponseFromJson(String str) =>
    GetRmeIdResponse.fromJson(json.decode(str));

String getRmeIdResponseToJson(GetRmeIdResponse data) =>
    json.encode(data.toJson());

class GetRmeIdResponse {
  bool success;
  int code;
  String message;
  Data data;

  GetRmeIdResponse({
    required this.success,
    required this.code,
    required this.message,
    required this.data,
  });

  factory GetRmeIdResponse.fromJson(Map<String, dynamic> json) =>
      GetRmeIdResponse(
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
  List<RmeData> data;
  Pagination pagination;

  Data({
    required this.data,
    required this.pagination,
  });

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
  int no;
  String id;
  DateTime jadwalPeriksa;
  String idPasien;
  String namaPasien;
  String noRekamMedis;
  String keluhan;
  String terapiTindakan;
  String dx;
  int feeDocter;
  List<Obat> obat;
  User user;

  RmeData({
    required this.no,
    required this.id,
    required this.jadwalPeriksa,
    required this.idPasien,
    required this.namaPasien,
    required this.noRekamMedis,
    required this.keluhan,
    required this.terapiTindakan,
    required this.dx,
    required this.feeDocter,
    required this.obat,
    required this.user,
  });

  factory RmeData.fromJson(Map<String, dynamic> json) => RmeData(
        no: json["no"],
        id: json["id"],
        jadwalPeriksa: DateTime.parse(json["jadwal_periksa"]),
        idPasien: json["id_pasien"],
        namaPasien: json["nama_pasien"],
        noRekamMedis: json["no_rekam_medis"],
        keluhan: json["keluhan"],
        terapiTindakan: json["terapi_tindakan"],
        dx: json["dx"],
        feeDocter: json["fee_docter"],
        obat: List<Obat>.from(json["obat"].map((x) => Obat.fromJson(x))),
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "no": no,
        "id": id,
        "jadwal_periksa": jadwalPeriksa.toIso8601String(),
        "id_pasien": idPasien,
        "nama_pasien": namaPasien,
        "no_rekam_medis": noRekamMedis,
        "keluhan": keluhan,
        "terapi_tindakan": terapiTindakan,
        "dx": dx,
        "fee_docter": feeDocter,
        "obat": List<dynamic>.from(obat.map((x) => x.toJson())),
        "user": user.toJson(),
      };
}

class Obat {
  String id;
  String namaObat;
  String nameUnit;
  int qty;

  Obat({
    required this.id,
    required this.namaObat,
    required this.nameUnit,
    required this.qty,
  });

  factory Obat.fromJson(Map<String, dynamic> json) => Obat(
        id: json["id"],
        namaObat: json["nama_obat"],
        nameUnit: json["name_unit"],
        qty: json["qty"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nama_obat": namaObat,
        "name_unit": nameUnit,
        "qty": qty,
      };
}

class User {
  String name;
  String email;
  String noTelp;

  User({
    required this.name,
    required this.email,
    required this.noTelp,
  });

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
