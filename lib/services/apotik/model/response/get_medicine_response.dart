// To parse this JSON data, do
//
//     final getMedicineResponse = getMedicineResponseFromJson(jsonString);

import 'dart:convert';

GetMedicineResponse getMedicineResponseFromJson(String str) => GetMedicineResponse.fromJson(json.decode(str));

String getMedicineResponseToJson(GetMedicineResponse data) => json.encode(data.toJson());

class GetMedicineResponse {
    final bool success;
    final int code;
    final String message;
    final Data data;

    GetMedicineResponse({
        required this.success,
        required this.code,
        required this.message,
        required this.data,
    });

    GetMedicineResponse copyWith({
        bool? success,
        int? code,
        String? message,
        Data? data,
    }) => 
        GetMedicineResponse(
            success: success ?? this.success,
            code: code ?? this.code,
            message: message ?? this.message,
            data: data ?? this.data,
        );

    factory GetMedicineResponse.fromJson(Map<String, dynamic> json) => GetMedicineResponse(
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
    final List<DataMedicine> data;
    final Pagination pagination;

    Data({
        required this.data,
        required this.pagination,
    });

    Data copyWith({
        List<DataMedicine>? data,
        Pagination? pagination,
    }) => 
        Data(
            data: data ?? this.data,
            pagination: pagination ?? this.pagination,
        );

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        data: List<DataMedicine>.from(json["data"].map((x) => DataMedicine.fromJson(x))),
        pagination: Pagination.fromJson(json["pagination"]),
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "pagination": pagination.toJson(),
    };
}

class DataMedicine {
    final String id;
    final String namaObat;
    final DateTime tglKadaluarsa;
    final int stock;
    final String statusObat;

    DataMedicine({
        required this.id,
        required this.namaObat,
        required this.tglKadaluarsa,
        required this.stock,
        required this.statusObat,
    });

    DataMedicine copyWith({
        String? id,
        String? namaObat,
        DateTime? tglKadaluarsa,
        int? stock,
        String? statusObat,
    }) => 
        DataMedicine(
            id: id ?? this.id,
            namaObat: namaObat ?? this.namaObat,
            tglKadaluarsa: tglKadaluarsa ?? this.tglKadaluarsa,
            stock: stock ?? this.stock,
            statusObat: statusObat ?? this.statusObat,
        );

    factory DataMedicine.fromJson(Map<String, dynamic> json) => DataMedicine(
        id: json["id"],
        namaObat: json["nama_obat"],
        tglKadaluarsa: DateTime.parse(json["tgl_kadaluarsa"]),
        stock: json["stock"],
        statusObat: json["status_obat"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nama_obat": namaObat,
        "tgl_kadaluarsa": "${tglKadaluarsa.year.toString().padLeft(4, '0')}-${tglKadaluarsa.month.toString().padLeft(2, '0')}-${tglKadaluarsa.day.toString().padLeft(2, '0')}",
        "stock": stock,
        "status_obat": statusObat,
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
