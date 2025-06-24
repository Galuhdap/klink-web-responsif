// To parse this JSON data, do
//
//     final postLetterHealtResponse = postLetterHealtResponseFromJson(jsonString);

import 'dart:convert';

PostLetterHealtResponse postLetterHealtResponseFromJson(String str) => PostLetterHealtResponse.fromJson(json.decode(str));

String postLetterHealtResponseToJson(PostLetterHealtResponse data) => json.encode(data.toJson());

class PostLetterHealtResponse {
    bool success;
    int code;
    String message;
    Data data;

    PostLetterHealtResponse({
        required this.success,
        required this.code,
        required this.message,
        required this.data,
    });

    factory PostLetterHealtResponse.fromJson(Map<String, dynamic> json) => PostLetterHealtResponse(
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
    String noLetter;
    String job;
    String complaint;
    String perihal;
    String td;
    String n;
    String s;
    DateTime createdAt;
    String pasienid;

    Data({
        required this.id,
        required this.noLetter,
        required this.job,
        required this.complaint,
        required this.perihal,
        required this.td,
        required this.n,
        required this.s,
        required this.createdAt,
        required this.pasienid,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        noLetter: json["no_letter"],
        job: json["job"],
        complaint: json["complaint"],
        perihal: json["perihal"],
        td: json["td"],
        n: json["n"],
        s: json["s"],
        createdAt: DateTime.parse(json["createdAt"]),
        pasienid: json["pasienid"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "no_letter": noLetter,
        "job": job,
        "complaint": complaint,
        "perihal": perihal,
        "td": td,
        "n": n,
        "s": s,
        "createdAt": createdAt.toIso8601String(),
        "pasienid": pasienid,
    };
}
