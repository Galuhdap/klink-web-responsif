// To parse this JSON data, do
//
//     final getTransactionResponse = getTransactionResponseFromJson(jsonString);

import 'dart:convert';

GetTransactionResponse getTransactionResponseFromJson(String str) => GetTransactionResponse.fromJson(json.decode(str));

String getTransactionResponseToJson(GetTransactionResponse data) => json.encode(data.toJson());

class GetTransactionResponse {
    final bool success;
    final int code;
    final String message;
    final Data data;

    GetTransactionResponse({
        required this.success,
        required this.code,
        required this.message,
        required this.data,
    });

    GetTransactionResponse copyWith({
        bool? success,
        int? code,
        String? message,
        Data? data,
    }) => 
        GetTransactionResponse(
            success: success ?? this.success,
            code: code ?? this.code,
            message: message ?? this.message,
            data: data ?? this.data,
        );

    factory GetTransactionResponse.fromJson(Map<String, dynamic> json) => GetTransactionResponse(
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
    final List<TransactionData> data;
    final Pagination pagination;

    Data({
        required this.data,
        required this.pagination,
    });

    Data copyWith({
        List<TransactionData>? data,
        Pagination? pagination,
    }) => 
        Data(
            data: data ?? this.data,
            pagination: pagination ?? this.pagination,
        );

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        data: List<TransactionData>.from(json["data"].map((x) => TransactionData.fromJson(x))),
        pagination: Pagination.fromJson(json["pagination"]),
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "pagination": pagination.toJson(),
    };
}

class TransactionData {
    final String id;
    final String invoice;
    final String paymentMethod;
    final int nominalPayment;
    final int changeGiven;
    final int amountPaid;
    final String rekamMedisid;
    final DateTime createdAt;
    final String userId;
    final RekamMedis rekamMedis;
    final User user;

    TransactionData({
        required this.id,
        required this.invoice,
        required this.paymentMethod,
        required this.nominalPayment,
        required this.changeGiven,
        required this.amountPaid,
        required this.rekamMedisid,
        required this.createdAt,
        required this.userId,
        required this.rekamMedis,
        required this.user,
    });

    TransactionData copyWith({
        String? id,
        String? invoice,
        String? paymentMethod,
        int? nominalPayment,
        int? changeGiven,
        int? amountPaid,
        String? rekamMedisid,
        DateTime? createdAt,
        String? userId,
        RekamMedis? rekamMedis,
        User? user,
    }) => 
        TransactionData(
            id: id ?? this.id,
            invoice: invoice ?? this.invoice,
            paymentMethod: paymentMethod ?? this.paymentMethod,
            nominalPayment: nominalPayment ?? this.nominalPayment,
            changeGiven: changeGiven ?? this.changeGiven,
            amountPaid: amountPaid ?? this.amountPaid,
            rekamMedisid: rekamMedisid ?? this.rekamMedisid,
            createdAt: createdAt ?? this.createdAt,
            userId: userId ?? this.userId,
            rekamMedis: rekamMedis ?? this.rekamMedis,
            user: user ?? this.user,
        );

    factory TransactionData.fromJson(Map<String, dynamic> json) => TransactionData(
        id: json["id"],
        invoice: json["invoice"],
        paymentMethod: json["payment_method"],
        nominalPayment: json["nominal_payment"],
        changeGiven: json["change_given"],
        amountPaid: json["amount_paid"],
        rekamMedisid: json["rekam_medisid"],
        createdAt: DateTime.parse(json["createdAt"]),
        userId: json["userId"],
        rekamMedis: RekamMedis.fromJson(json["rekam_medis"]),
        user: User.fromJson(json["user"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "invoice": invoice,
        "payment_method": paymentMethod,
        "nominal_payment": nominalPayment,
        "change_given": changeGiven,
        "amount_paid": amountPaid,
        "rekam_medisid": rekamMedisid,
        "createdAt": createdAt.toIso8601String(),
        "userId": userId,
        "rekam_medis": rekamMedis.toJson(),
        "user": user.toJson(),
    };
}

class RekamMedis {
    final String keluhan;
    final Pasien pasien;

    RekamMedis({
        required this.keluhan,
        required this.pasien,
    });

    RekamMedis copyWith({
        String? keluhan,
        Pasien? pasien,
    }) => 
        RekamMedis(
            keluhan: keluhan ?? this.keluhan,
            pasien: pasien ?? this.pasien,
        );

    factory RekamMedis.fromJson(Map<String, dynamic> json) => RekamMedis(
        keluhan: json["keluhan"],
        pasien: Pasien.fromJson(json["pasien"]),
    );

    Map<String, dynamic> toJson() => {
        "keluhan": keluhan,
        "pasien": pasien.toJson(),
    };
}

class Pasien {
    final String name;
    final String noRekamMedis;
    final String alamat;

    Pasien({
        required this.name,
        required this.noRekamMedis,
        required this.alamat,
    });

    Pasien copyWith({
        String? name,
        String? noRekamMedis,
        String? alamat,
    }) => 
        Pasien(
            name: name ?? this.name,
            noRekamMedis: noRekamMedis ?? this.noRekamMedis,
            alamat: alamat ?? this.alamat,
        );

    factory Pasien.fromJson(Map<String, dynamic> json) => Pasien(
        name: json["name"],
        noRekamMedis: json["no_rekam_medis"],
        alamat: json["alamat"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "no_rekam_medis": noRekamMedis,
        "alamat": alamat,
    };
}

class User {
    final String name;
    final String noTelp;

    User({
        required this.name,
        required this.noTelp,
    });

    User copyWith({
        String? name,
        String? noTelp,
    }) => 
        User(
            name: name ?? this.name,
            noTelp: noTelp ?? this.noTelp,
        );

    factory User.fromJson(Map<String, dynamic> json) => User(
        name: json["name"],
        noTelp: json["no_telp"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "no_telp": noTelp,
    };
}

class Pagination {
    final int total;
    final int page;
    final int limit;
    final int totalPages;

    Pagination({
        required this.total,
        required this.page,
        required this.limit,
        required this.totalPages,
    });

    Pagination copyWith({
        int? total,
        int? page,
        int? limit,
        int? totalPages,
    }) => 
        Pagination(
            total: total ?? this.total,
            page: page ?? this.page,
            limit: limit ?? this.limit,
            totalPages: totalPages ?? this.totalPages,
        );

    factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
        total: json["total"],
        page: json["page"],
        limit: json["limit"],
        totalPages: json["totalPages"],
    );

    Map<String, dynamic> toJson() => {
        "total": total,
        "page": page,
        "limit": limit,
        "totalPages": totalPages,
    };
}
