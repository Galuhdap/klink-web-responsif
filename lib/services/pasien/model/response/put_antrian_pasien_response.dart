// To parse this JSON data, do
//
//     final putAntrianPasienResponse = putAntrianPasienResponseFromJson(jsonString);

import 'dart:convert';

PutAntrianPasienResponse putAntrianPasienResponseFromJson(String str) =>
    PutAntrianPasienResponse.fromJson(json.decode(str));

String putAntrianPasienResponseToJson(PutAntrianPasienResponse data) =>
    json.encode(data.toJson());

class PutAntrianPasienResponse {
  final bool success;
  final int code;
  final String message;
  final Data data;

  PutAntrianPasienResponse({
    required this.success,
    required this.code,
    required this.message,
    required this.data,
  });

  PutAntrianPasienResponse copyWith({
    bool? success,
    int? code,
    String? message,
    Data? data,
  }) =>
      PutAntrianPasienResponse(
        success: success ?? this.success,
        code: code ?? this.code,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory PutAntrianPasienResponse.fromJson(Map<String, dynamic> json) =>
      PutAntrianPasienResponse(
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
  final String id;
  final String nomerAntrian;
  final String status;
  final String waktuTunggu;
  final String idPasien;
  final dynamic createdAt;

  Data({
    required this.id,
    required this.nomerAntrian,
    required this.status,
    required this.waktuTunggu,
    required this.idPasien,
    required this.createdAt,
  });

  Data copyWith({
    String? id,
    String? nomerAntrian,
    String? status,
    String? waktuTunggu,
    String? idPasien,
    dynamic createdAt,
  }) =>
      Data(
        id: id ?? this.id,
        nomerAntrian: nomerAntrian ?? this.nomerAntrian,
        status: status ?? this.status,
        waktuTunggu: waktuTunggu ?? this.waktuTunggu,
        idPasien: idPasien ?? this.idPasien,
        createdAt: createdAt ?? this.createdAt,
      );

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        nomerAntrian: json["nomer_antrian"],
        status: json["status"],
        waktuTunggu: json["waktu_tunggu"],
        idPasien: json["id_pasien"],
        createdAt: json["createdAt"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nomer_antrian": nomerAntrian,
        "status": status,
        "waktu_tunggu": waktuTunggu,
        "id_pasien": idPasien,
        "createdAt": createdAt,
      };

  
}
