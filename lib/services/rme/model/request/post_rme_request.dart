// To parse this JSON data, do
//
//     final postRmeRequest = postRmeRequestFromJson(jsonString);

import 'dart:convert';

PostRmeRequest postRmeRequestFromJson(String str) =>
    PostRmeRequest.fromJson(json.decode(str));

String postRmeRequestToJson(PostRmeRequest data) => json.encode(data.toJson());

class PostRmeRequest {
  final String keluhan;
  final String terapiTindakan;
  final String dx;
  final String idPasien;
  final List<ObatRequest> obat;
  final int feeDocter;

  PostRmeRequest({
    required this.keluhan,
    required this.terapiTindakan,
    required this.dx,
    required this.idPasien,
    required this.obat,
    required this.feeDocter,
  });

  PostRmeRequest copyWith({
    String? keluhan,
    String? terapiTindakan,
    String? dx,
    String? idPasien,
    List<ObatRequest>? obat,
    int? feeDocter,
  }) =>
      PostRmeRequest(
        keluhan: keluhan ?? this.keluhan,
        terapiTindakan: terapiTindakan ?? this.terapiTindakan,
        dx: dx ?? this.dx,
        idPasien: idPasien ?? this.idPasien,
        obat: obat ?? this.obat,
        feeDocter: feeDocter ?? this.feeDocter,
      );

  factory PostRmeRequest.fromJson(Map<String, dynamic> json) => PostRmeRequest(
        keluhan: json["keluhan"],
        terapiTindakan: json["terapi_tindakan"],
        dx: json["dx"],
        idPasien: json["id_pasien"],
        obat: List<ObatRequest>.from(
            json["obat"].map((x) => ObatRequest.fromJson(x))),
        feeDocter: json["fee_docter"],
      );

  Map<String, dynamic> toJson() => {
        "keluhan": keluhan,
        "terapi_tindakan": terapiTindakan,
        "dx": dx,
        "id_pasien": idPasien,
        "obat": List<dynamic>.from(obat.map((x) => x.toJson())),
        "fee_docter": feeDocter,
      };
}

class ObatRequest {
  final String medicineId;
  final int qty;
  final String unitId;

  ObatRequest({
    required this.medicineId,
    required this.qty,
    required this.unitId,
  });

  ObatRequest copyWith({
    String? medicineId,
    int? qty,
    String? unitId,
  }) =>
      ObatRequest(
        medicineId: medicineId ?? this.medicineId,
        qty: qty ?? this.qty,
        unitId: unitId ?? this.unitId,
      );

  factory ObatRequest.fromJson(Map<String, dynamic> json) => ObatRequest(
      medicineId: json["medicineId"], qty: json["qty"], unitId: json["unitId"]);

  Map<String, dynamic> toJson() => {
        "medicineId": medicineId,
        "qty": qty,
        "unitId": unitId,
      };
}
