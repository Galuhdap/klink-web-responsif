// To parse this JSON data, do
//
//     final postLetterRmeRequest = postLetterRmeRequestFromJson(jsonString);

import 'dart:convert';

PostLetterRmeRequest postLetterRmeRequestFromJson(String str) => PostLetterRmeRequest.fromJson(json.decode(str));

String postLetterRmeRequestToJson(PostLetterRmeRequest data) => json.encode(data.toJson());

class PostLetterRmeRequest {
    String pekerjaan;
    String keperluan;
    DateTime startDate;
    DateTime endDate;
    String? idPasien;
    String? userId;

    PostLetterRmeRequest({
        required this.pekerjaan,
        required this.keperluan,
        required this.startDate,
        required this.endDate,
        this.idPasien,
        this.userId,
    });

    factory PostLetterRmeRequest.fromJson(Map<String, dynamic> json) => PostLetterRmeRequest(
        pekerjaan: json["pekerjaan"],
        keperluan: json["keperluan"],
        startDate: DateTime.parse(json["start_date"]),
        endDate: DateTime.parse(json["end_date"]),
        idPasien: json["id_pasien"],
        userId: json["userId"],
    );

    Map<String, dynamic> toJson() => {
        "pekerjaan": pekerjaan,
        "keperluan": keperluan,
        "start_date": "${startDate.year.toString().padLeft(4, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
        "end_date": "${endDate.year.toString().padLeft(4, '0')}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}",
        "id_pasien": idPasien,
        "userId": userId,
    };
}
