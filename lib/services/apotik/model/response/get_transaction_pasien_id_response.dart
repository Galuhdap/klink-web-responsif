// To parse this JSON PasienIdTransaction, do
//
//     final getTransactionPasienIdResponse = getTransactionPasienIdResponseFromJson(jsonString);

import 'dart:convert';

GetTransactionPasienIdResponse getTransactionPasienIdResponseFromJson(
        String str) =>
    GetTransactionPasienIdResponse.fromJson(json.decode(str));

String getTransactionPasienIdResponseToJson(
        GetTransactionPasienIdResponse data) =>
    json.encode(data.toJson());

class GetTransactionPasienIdResponse {
  final bool success;
  final int code;
  final String message;
  final PasienIdTransaction data;

  GetTransactionPasienIdResponse({
    required this.success,
    required this.code,
    required this.message,
    required this.data,
  });

  GetTransactionPasienIdResponse copyWith({
    bool? success,
    int? code,
    String? message,
    PasienIdTransaction? data,
  }) =>
      GetTransactionPasienIdResponse(
        success: success ?? this.success,
        code: code ?? this.code,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory GetTransactionPasienIdResponse.fromJson(Map<String, dynamic> json) =>
      GetTransactionPasienIdResponse(
        success: json["success"],
        code: json["code"],
        message: json["message"],
        data: PasienIdTransaction.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "code": code,
        "message": message,
        "data": data.toJson(),
      };
}

class PasienIdTransaction {
  final String id;
  final DateTime jadwalPeriksa;
  final String keluhan;
  final String terapiTindakan;
  final String dx;
  final int feeDocter;
  final String idPasien;
  final List<DetailObatRekamMedi> detailObatRekamMedis;
  final int totalHargaObat;
  final int totalSemua;

  PasienIdTransaction({
    required this.id,
    required this.jadwalPeriksa,
    required this.keluhan,
    required this.terapiTindakan,
    required this.dx,
    required this.feeDocter,
    required this.idPasien,
    required this.detailObatRekamMedis,
    required this.totalHargaObat,
    required this.totalSemua,
  });

  PasienIdTransaction copyWith({
    String? id,
    DateTime? jadwalPeriksa,
    String? keluhan,
    String? terapiTindakan,
    String? dx,
    int? feeDocter,
    String? idPasien,
    List<DetailObatRekamMedi>? detailObatRekamMedis,
    int? totalHargaObat,
    int? totalSemua,
  }) =>
      PasienIdTransaction(
          id: id ?? this.id,
          jadwalPeriksa: jadwalPeriksa ?? this.jadwalPeriksa,
          keluhan: keluhan ?? this.keluhan,
          terapiTindakan: terapiTindakan ?? this.terapiTindakan,
          dx: dx ?? this.dx,
          feeDocter: feeDocter ?? this.feeDocter,
          idPasien: idPasien ?? this.idPasien,
          detailObatRekamMedis:
              detailObatRekamMedis ?? this.detailObatRekamMedis,
          totalHargaObat: totalHargaObat ?? this.totalHargaObat,
          totalSemua: totalSemua ?? this.totalSemua);

  factory PasienIdTransaction.fromJson(Map<String, dynamic> json) =>
      PasienIdTransaction(
        id: json["id"],
        jadwalPeriksa: DateTime.parse(json["jadwal_periksa"]),
        keluhan: json["keluhan"],
        terapiTindakan: json["terapi_tindakan"],
        dx: json["dx"],
        feeDocter: json["fee_docter"],
        idPasien: json["id_pasien"],
        detailObatRekamMedis: List<DetailObatRekamMedi>.from(
            json["detailObatRekamMedis"]
                .map((x) => DetailObatRekamMedi.fromJson(x))),
        totalHargaObat: json["total_harga_obat"],
        totalSemua: json["total_semua"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "jadwal_periksa": jadwalPeriksa.toIso8601String(),
        "keluhan": keluhan,
        "terapi_tindakan": terapiTindakan,
        "dx": dx,
        "fee_docter": feeDocter,
        "id_pasien": idPasien,
        "detailObatRekamMedis":
            List<dynamic>.from(detailObatRekamMedis.map((x) => x.toJson())),
        "total_harga_obat": totalHargaObat,
        "total_semua": totalSemua,
      };
}

class DetailObatRekamMedi {
  String id;
  String idRekamMedis;
  int qty;
  String medicineId;
  Medicine medicine;

  DetailObatRekamMedi({
    required this.id,
    required this.idRekamMedis,
    required this.medicineId,
    required this.qty,
    required this.medicine,
  });

  DetailObatRekamMedi copyWith({
    String? id,
    String? idRekamMedis,
    String? medicineId,
    int? qty,
    Medicine? medicine,
  }) =>
      DetailObatRekamMedi(
        id: id ?? this.id,
        idRekamMedis: idRekamMedis ?? this.idRekamMedis,
        medicineId: medicineId ?? this.medicineId,
        qty: qty ?? this.qty,
        medicine: medicine ?? this.medicine,
      );

  factory DetailObatRekamMedi.fromJson(Map<String, dynamic> json) =>
      DetailObatRekamMedi(
        id: json["id"],
        idRekamMedis: json["id_rekam_medis"],
        qty: json["qty"],
        medicineId: json["medicineId"],
        medicine: Medicine.fromJson(json["Medicine"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_rekam_medis": idRekamMedis,
        "qty": qty,
        "medicineId": medicineId,
        "Medicine": medicine.toJson(),
      };
}

class Medicine {
  String id;
  String nameMedicine;
  String baseUnitId;
  int priceSell;
  DateTime createdAt;
  BaseUnit baseUnit;

  Medicine({
    required this.id,
    required this.nameMedicine,
    required this.baseUnitId,
    required this.priceSell,
    required this.createdAt,
    required this.baseUnit,
  });

  factory Medicine.fromJson(Map<String, dynamic> json) => Medicine(
        id: json["id"],
        nameMedicine: json["name_medicine"],
        baseUnitId: json["baseUnitId"],
        priceSell: json["price_sell"],
        createdAt: DateTime.parse(json["createdAt"]),
        baseUnit: BaseUnit.fromJson(json["baseUnit"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name_medicine": nameMedicine,
        "baseUnitId": baseUnitId,
        "price_sell": priceSell,
        "createdAt": createdAt.toIso8601String(),
        "baseUnit": baseUnit.toJson(),
      };
}

class BaseUnit {
  String id;
  String name;
  int level;

  BaseUnit({
    required this.id,
    required this.name,
    required this.level,
  });

  factory BaseUnit.fromJson(Map<String, dynamic> json) => BaseUnit(
        id: json["id"],
        name: json["name"],
        level: json["level"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "level": level,
      };
}
