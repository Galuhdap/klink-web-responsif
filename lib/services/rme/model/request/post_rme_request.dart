// To parse this JSON data, do
//
//     final postRmeRequest = postRmeRequestFromJson(jsonString);

import 'dart:convert';

PostRmeRequest postRmeRequestFromJson(String str) => PostRmeRequest.fromJson(json.decode(str));

String postRmeRequestToJson(PostRmeRequest data) => json.encode(data.toJson());

class PostRmeRequest {
    final String keluhan;
    final String terapiTindakan;
    final String dx;
    final String idPasien;
    final List<ObatRequest> obat;
    final int total;

    PostRmeRequest({
        required this.keluhan,
        required this.terapiTindakan,
        required this.dx,
        required this.idPasien,
        required this.obat,
        required this.total,
    });

    PostRmeRequest copyWith({
        String? keluhan,
        String? terapiTindakan,
        String? dx,
        String? idPasien,
        List<ObatRequest>? obat,
        int? total,
    }) => 
        PostRmeRequest(
            keluhan: keluhan ?? this.keluhan,
            terapiTindakan: terapiTindakan ?? this.terapiTindakan,
            dx: dx ?? this.dx,
            idPasien: idPasien ?? this.idPasien,
            obat: obat ?? this.obat,
            total: total ?? this.total,
        );

    factory PostRmeRequest.fromJson(Map<String, dynamic> json) => PostRmeRequest(
        keluhan: json["keluhan"],
        terapiTindakan: json["terapi_tindakan"],
        dx: json["dx"],
        idPasien: json["id_pasien"],
        obat: List<ObatRequest>.from(json["obat"].map((x) => ObatRequest.fromJson(x))),
        total: json["total"],
    );

    Map<String, dynamic> toJson() => {
        "keluhan": keluhan,
        "terapi_tindakan": terapiTindakan,
        "dx": dx,
        "id_pasien": idPasien,
        "obat": List<dynamic>.from(obat.map((x) => x.toJson())),
        "total": total,
    };
}

class ObatRequest {
    final String idObat;
    final int qty;

    ObatRequest({
        required this.idObat,
        required this.qty,
    });

    ObatRequest copyWith({
        String? idObat,
        int? qty,
    }) => 
        ObatRequest(
            idObat: idObat ?? this.idObat,
            qty: qty ?? this.qty,
        );

    factory ObatRequest.fromJson(Map<String, dynamic> json) =>ObatRequest(
        idObat: json["id_obat"],
        qty: json["qty"],
    );

    Map<String, dynamic> toJson() => {
        "id_obat": idObat,
        "qty": qty,
    };
}
