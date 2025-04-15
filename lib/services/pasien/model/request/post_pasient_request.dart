// To parse this JSON data, do
//
//     final postPasienRequest = postPasienRequestFromJson(jsonString);

import 'dart:convert';

PostPasienRequest postPasienRequestFromJson(String str) => PostPasienRequest.fromJson(json.decode(str));

String postPasienRequestToJson(PostPasienRequest data) => json.encode(data.toJson());

class PostPasienRequest {
    final String name;
    final String nik;
    final DateTime tglLahir;
    final String noTelp;
    final String jenisKelamin;
    // final String umur;
    final String alamat;

    PostPasienRequest({
        required this.name,
        required this.nik,
        required this.tglLahir,
        required this.noTelp,
        required this.jenisKelamin,
        // required this.umur,
        required this.alamat,
    });

    PostPasienRequest copyWith({
        String? name,
        String? nik,
        DateTime? tglLahir,
        String? noTelp,
        String? jenisKelamin,
        String? umur,
        String? alamat,
    }) => 
        PostPasienRequest(
            name: name ?? this.name,
            nik: nik ?? this.nik,
            tglLahir: tglLahir ?? this.tglLahir,
            noTelp: noTelp ?? this.noTelp,
            jenisKelamin: jenisKelamin ?? this.jenisKelamin,
        //    umur: umur ?? this.umur,
            alamat: alamat ?? this.alamat,
        );

    factory PostPasienRequest.fromJson(Map<String, dynamic> json) => PostPasienRequest(
        name: json["name"],
        nik: json["nik"],
        tglLahir: DateTime.parse(json["tgl_lahir"]),
        noTelp: json["no_telp"],
        jenisKelamin: json["jenis_kelamin"],
      //  umur: json["umur"],
        alamat: json["alamat"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "nik": nik,
        "tgl_lahir": "${tglLahir.year.toString().padLeft(4, '0')}-${tglLahir.month.toString().padLeft(2, '0')}-${tglLahir.day.toString().padLeft(2, '0')}",
        "no_telp": noTelp,
        "jenis_kelamin": jenisKelamin,
      //  "umur": umur,
        "alamat": alamat,
    };
}
