// To parse this JSON data, do
//
//     final getInOutReportMedicineResponse = getInOutReportMedicineResponseFromJson(jsonString);

import 'dart:convert';

GetInOutReportMedicineResponse getInOutReportMedicineResponseFromJson(String str) => GetInOutReportMedicineResponse.fromJson(json.decode(str));

String getInOutReportMedicineResponseToJson(GetInOutReportMedicineResponse data) => json.encode(data.toJson());

class GetInOutReportMedicineResponse {
    bool success;
    int code;
    String message;
    Data data;

    GetInOutReportMedicineResponse({
        required this.success,
        required this.code,
        required this.message,
        required this.data,
    });

    factory GetInOutReportMedicineResponse.fromJson(Map<String, dynamic> json) => GetInOutReportMedicineResponse(
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
    List<DatumReportInOutMedicine> data;
    Pagination pagination;
    int totalMasuk;
    int totalKeluar;

    Data({
        required this.data,
        required this.pagination,
        required this.totalMasuk,
        required this.totalKeluar,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        data: List<DatumReportInOutMedicine>.from(json["data"].map((x) => DatumReportInOutMedicine.fromJson(x))),
        pagination: Pagination.fromJson(json["pagination"]),
        totalMasuk: json["total_masuk"],
        totalKeluar: json["total_keluar"],
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "pagination": pagination.toJson(),
        "total_masuk": totalMasuk,
        "total_keluar": totalKeluar,
    };
}

class DatumReportInOutMedicine {
    int no;
    String namaObat;
    String satuan;
    int masuk;
    int keluar;

    DatumReportInOutMedicine({
        required this.no,
        required this.namaObat,
        required this.satuan,
        required this.masuk,
        required this.keluar,
    });

    factory DatumReportInOutMedicine.fromJson(Map<String, dynamic> json) => DatumReportInOutMedicine(
        no: json["no"],
        namaObat: json["nama_obat"],
        satuan: json["satuan"],
        masuk: json["masuk"],
        keluar: json["keluar"],
    );

    Map<String, dynamic> toJson() => {
        "no": no,
        "nama_obat": namaObat,
        "satuan": satuan,
        "masuk": masuk,
        "keluar": keluar,
    };
}

class Pagination {
    int total;
    int page;
    int limit;
    int totalPages;

    Pagination({
        required this.total,
        required this.page,
        required this.limit,
        required this.totalPages,
    });

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
