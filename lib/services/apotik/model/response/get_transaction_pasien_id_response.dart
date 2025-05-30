// To parse this JSON PasienIdTransaction, do
//
//     final getTransactionPasienIdResponse = getTransactionPasienIdResponseFromJson(jsonString);

import 'dart:convert';

GetTransactionPasienIdResponse getTransactionPasienIdResponseFromJson(String str) => GetTransactionPasienIdResponse.fromJson(json.decode(str));

String getTransactionPasienIdResponseToJson(GetTransactionPasienIdResponse data) => json.encode(data.toJson());

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

    factory GetTransactionPasienIdResponse.fromJson(Map<String, dynamic> json) => GetTransactionPasienIdResponse(
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
    final int total;
    final String idPasien;
    final List<DetailObatRekamMedi> detailObatRekamMedis;

    PasienIdTransaction({
        required this.id,
        required this.jadwalPeriksa,
        required this.keluhan,
        required this.terapiTindakan,
        required this.dx,
        required this.total,
        required this.idPasien,
        required this.detailObatRekamMedis,
    });

    PasienIdTransaction copyWith({
        String? id,
        DateTime? jadwalPeriksa,
        String? keluhan,
        String? terapiTindakan,
        String? dx,
        int? total,
        String? idPasien,
        List<DetailObatRekamMedi>? detailObatRekamMedis,
    }) => 
        PasienIdTransaction(
            id: id ?? this.id,
            jadwalPeriksa: jadwalPeriksa ?? this.jadwalPeriksa,
            keluhan: keluhan ?? this.keluhan,
            terapiTindakan: terapiTindakan ?? this.terapiTindakan,
            dx: dx ?? this.dx,
            total: total ?? this.total,
            idPasien: idPasien ?? this.idPasien,
            detailObatRekamMedis: detailObatRekamMedis ?? this.detailObatRekamMedis,
        );

    factory PasienIdTransaction.fromJson(Map<String, dynamic> json) => PasienIdTransaction(
        id: json["id"],
        jadwalPeriksa: DateTime.parse(json["jadwal_periksa"]),
        keluhan: json["keluhan"],
        terapiTindakan: json["terapi_tindakan"],
        dx: json["dx"],
        total: json["total"],
        idPasien: json["id_pasien"],
        detailObatRekamMedis: List<DetailObatRekamMedi>.from(json["detailObatRekamMedis"].map((x) => DetailObatRekamMedi.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "jadwal_periksa": jadwalPeriksa.toIso8601String(),
        "keluhan": keluhan,
        "terapi_tindakan": terapiTindakan,
        "dx": dx,
        "total": total,
        "id_pasien": idPasien,
        "detailObatRekamMedis": List<dynamic>.from(detailObatRekamMedis.map((x) => x.toJson())),
    };
}

class DetailObatRekamMedi {
    final String id;
    final String idRekamMedis;
    final String idObat;
    final int qty;
    final Obat obat;

    DetailObatRekamMedi({
        required this.id,
        required this.idRekamMedis,
        required this.idObat,
        required this.qty,
        required this.obat,
    });

    DetailObatRekamMedi copyWith({
        String? id,
        String? idRekamMedis,
        String? idObat,
        int? qty,
        Obat? obat,
    }) => 
        DetailObatRekamMedi(
            id: id ?? this.id,
            idRekamMedis: idRekamMedis ?? this.idRekamMedis,
            idObat: idObat ?? this.idObat,
            qty: qty ?? this.qty,
            obat: obat ?? this.obat,
        );

    factory DetailObatRekamMedi.fromJson(Map<String, dynamic> json) => DetailObatRekamMedi(
        id: json["id"],
        idRekamMedis: json["id_rekam_medis"],
        idObat: json["id_obat"],
        qty: json["qty"],
        obat: Obat.fromJson(json["obat"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "id_rekam_medis": idRekamMedis,
        "id_obat": idObat,
        "qty": qty,
        "obat": obat.toJson(),
    };
}

class Obat {
    final String id;
    final String namaObat;
    final DateTime tglKadaluarsa;
    final int stock;
    final String statusObat;

    Obat({
        required this.id,
        required this.namaObat,
        required this.tglKadaluarsa,
        required this.stock,
        required this.statusObat,
    });

    Obat copyWith({
        String? id,
        String? namaObat,
        DateTime? tglKadaluarsa,
        int? stock,
        String? statusObat,
    }) => 
        Obat(
            id: id ?? this.id,
            namaObat: namaObat ?? this.namaObat,
            tglKadaluarsa: tglKadaluarsa ?? this.tglKadaluarsa,
            stock: stock ?? this.stock,
            statusObat: statusObat ?? this.statusObat,
        );

    factory Obat.fromJson(Map<String, dynamic> json) => Obat(
        id: json["id"],
        namaObat: json["nama_obat"],
        tglKadaluarsa: DateTime.parse(json["tgl_kadaluarsa"]),
        stock: json["stock"],
        statusObat: json["status_obat"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nama_obat": namaObat,
        "tgl_kadaluarsa": "${tglKadaluarsa.year.toString().padLeft(4, '0')}-${tglKadaluarsa.month.toString().padLeft(2, '0')}-${tglKadaluarsa.day.toString().padLeft(2, '0')}",
        "stock": stock,
        "status_obat": statusObat,
    };
}
