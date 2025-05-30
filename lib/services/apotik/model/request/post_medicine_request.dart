// To parse this JSON data, do
//
//     final postMedicineRequest = postMedicineRequestFromJson(jsonString);

import 'dart:convert';

PostMedicineRequest postMedicineRequestFromJson(String str) => PostMedicineRequest.fromJson(json.decode(str));

String postMedicineRequestToJson(PostMedicineRequest data) => json.encode(data.toJson());

class PostMedicineRequest {
    String namaObat;
    String tglKadaluarsa;
    int stock;
    String? statusObat;

    PostMedicineRequest({
        required this.namaObat,
        required this.tglKadaluarsa,
        required this.stock,
         this.statusObat,
    });

    factory PostMedicineRequest.fromJson(Map<String, dynamic> json) => PostMedicineRequest(
        namaObat: json["nama_obat"],
        tglKadaluarsa: json["tgl_kadaluarsa"],
        stock: json["stock"],
        statusObat: json["status_obat"],
    );

    Map<String, dynamic> toJson() => {
        "nama_obat": namaObat,
        "tgl_kadaluarsa": tglKadaluarsa,
        "stock": stock,
        "status_obat": statusObat,
    };
}
