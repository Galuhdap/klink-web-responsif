// To parse this JSON data, do
//
//     final postLetterHealtRequest = postLetterHealtRequestFromJson(jsonString);

import 'dart:convert';

PostLetterHealtRequest postLetterHealtRequestFromJson(String str) =>
    PostLetterHealtRequest.fromJson(json.decode(str));

String postLetterHealtRequestToJson(PostLetterHealtRequest data) =>
    json.encode(data.toJson());

class PostLetterHealtRequest {
  String job;
  String complaint;
  String perihal;
  String td;
  String n;
  String s;
  String? idPasien;

  PostLetterHealtRequest({
    required this.job,
    required this.complaint,
    required this.perihal,
    required this.td,
    required this.n,
    required this.s,
    this.idPasien,
  });

  factory PostLetterHealtRequest.fromJson(Map<String, dynamic> json) =>
      PostLetterHealtRequest(
        job: json["job"],
        complaint: json["complaint"],
        perihal: json["perihal"],
        td: json["td"],
        n: json["n"],
        s: json["s"],
        idPasien: json["id_pasien"],
      );

  Map<String, dynamic> toJson() => {
        "job": job,
        "complaint": complaint,
        "perihal": perihal,
        "td": td,
        "n": n,
        "s": s,
        "id_pasien": idPasien,
      };
}
