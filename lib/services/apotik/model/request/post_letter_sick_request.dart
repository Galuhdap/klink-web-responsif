// To parse this JSON data, do
//
//     final postLetterSickRequest = postLetterSickRequestFromJson(jsonString);

import 'dart:convert';

PostLetterSickRequest postLetterSickRequestFromJson(String str) => PostLetterSickRequest.fromJson(json.decode(str));

String postLetterSickRequestToJson(PostLetterSickRequest data) => json.encode(data.toJson());

class PostLetterSickRequest {
    String job;
    String complaint;
    String diagnosa;
    String restPeriod;
    DateTime startDate;
    DateTime endDate;
    String? idPasien;

    PostLetterSickRequest({
        required this.job,
        required this.complaint,
        required this.diagnosa,
        required this.restPeriod,
        required this.startDate,
        required this.endDate,
        this.idPasien,
    });

    factory PostLetterSickRequest.fromJson(Map<String, dynamic> json) => PostLetterSickRequest(
        job: json["job"],
        complaint: json["complaint"],
        diagnosa: json["diagnosa"],
        restPeriod: json["rest_period"],
        startDate: DateTime.parse(json["start_date"]),
        endDate: DateTime.parse(json["end_date"]),
        idPasien: json["id_pasien"],
    );

    Map<String, dynamic> toJson() => {
        "job": job,
        "complaint": complaint,
        "diagnosa": diagnosa,
        "rest_period": restPeriod,
        "start_date": startDate.toIso8601String(),
        "end_date": endDate.toIso8601String(),
        "id_pasien": idPasien,
    };
}
