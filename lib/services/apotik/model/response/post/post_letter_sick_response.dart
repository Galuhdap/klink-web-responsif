// To parse this JSON data, do
//
//     final postLetterSickResponse = postLetterSickResponseFromJson(jsonString);

import 'dart:convert';

PostLetterSickResponse postLetterSickResponseFromJson(String str) => PostLetterSickResponse.fromJson(json.decode(str));

String postLetterSickResponseToJson(PostLetterSickResponse data) => json.encode(data.toJson());

class PostLetterSickResponse {
    bool success;
    int code;
    String message;
    Data data;

    PostLetterSickResponse({
        required this.success,
        required this.code,
        required this.message,
        required this.data,
    });

    factory PostLetterSickResponse.fromJson(Map<String, dynamic> json) => PostLetterSickResponse(
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
    String id;
    String noLatter;
    String job;
    String complaint;
    String diagnosa;
    String restPeriod;
    DateTime startDate;
    DateTime endDate;
    DateTime createdAt;
    String pasienid;

    Data({
        required this.id,
        required this.noLatter,
        required this.job,
        required this.complaint,
        required this.diagnosa,
        required this.restPeriod,
        required this.startDate,
        required this.endDate,
        required this.createdAt,
        required this.pasienid,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        noLatter: json["no_latter"],
        job: json["job"],
        complaint: json["complaint"],
        diagnosa: json["diagnosa"],
        restPeriod: json["rest_period"],
        startDate: DateTime.parse(json["start_date"]),
        endDate: DateTime.parse(json["end_date"]),
        createdAt: DateTime.parse(json["createdAt"]),
        pasienid: json["pasienid"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "no_latter": noLatter,
        "job": job,
        "complaint": complaint,
        "diagnosa": diagnosa,
        "rest_period": restPeriod,
        "start_date": startDate.toIso8601String(),
        "end_date": endDate.toIso8601String(),
        "createdAt": createdAt.toIso8601String(),
        "pasienid": pasienid,
    };
}
