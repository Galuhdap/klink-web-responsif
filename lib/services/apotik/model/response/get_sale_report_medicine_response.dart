// To parse this JSON data, do
//
//     final getSaleReportMedicineResponse = getSaleReportMedicineResponseFromJson(jsonString);

import 'dart:convert';

GetSaleReportMedicineResponse getSaleReportMedicineResponseFromJson(
        String str) =>
    GetSaleReportMedicineResponse.fromJson(json.decode(str));

String getSaleReportMedicineResponseToJson(
        GetSaleReportMedicineResponse data) =>
    json.encode(data.toJson());

class GetSaleReportMedicineResponse {
  bool success;
  int code;
  String message;
  Data data;

  GetSaleReportMedicineResponse({
    required this.success,
    required this.code,
    required this.message,
    required this.data,
  });

  factory GetSaleReportMedicineResponse.fromJson(Map<String, dynamic> json) =>
      GetSaleReportMedicineResponse(
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
  List<DatumReportSale> data;
  Pagination pagination;
  int totalNominal;

  Data({
    required this.data,
    required this.pagination,
    required this.totalNominal,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        data: List<DatumReportSale>.from(
            json["data"].map((x) => DatumReportSale.fromJson(x))),
        pagination: Pagination.fromJson(json["pagination"]),
        totalNominal: json["total_nominal"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "pagination": pagination.toJson(),
        "total_nominal": totalNominal,
      };
}

class DatumReportSale {
  int no;
  String noRekamMedis;
  String namaPasien;
  String alamat;
  String diagnosa;
  int nominal;
  DateTime tanggalTransaksi;
  String invoice;
  String petugasApotik;
  int feeDocter;
  List<DetailObat> detailObat;

  DatumReportSale({
    required this.no,
    required this.noRekamMedis,
    required this.namaPasien,
    required this.alamat,
    required this.diagnosa,
    required this.nominal,
    required this.tanggalTransaksi,
    required this.invoice,
    required this.petugasApotik,
    required this.feeDocter,
    required this.detailObat,
  });

  factory DatumReportSale.fromJson(Map<String, dynamic> json) =>
      DatumReportSale(
        no: json["no"],
        noRekamMedis: json["no_rekam_medis"],
        namaPasien: json["nama_pasien"],
        alamat: json["alamat"],
        diagnosa: json["diagnosa"],
        nominal: json["nominal"],
        tanggalTransaksi: DateTime.parse(json["tanggal_transaksi"]),
        invoice: json["invoice"],
        petugasApotik: json["petugas_apotik"],
        feeDocter: json["fee_docter"],
        detailObat: List<DetailObat>.from(
            json["detail_obat"].map((x) => DetailObat.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "no": no,
        "no_rekam_medis": noRekamMedis,
        "nama_pasien": namaPasien,
        "alamat": alamat,
        "diagnosa": diagnosa,
        "nominal": nominal,
        "tanggal_transaksi":
            "${tanggalTransaksi.year.toString().padLeft(4, '0')}-${tanggalTransaksi.month.toString().padLeft(2, '0')}-${tanggalTransaksi.day.toString().padLeft(2, '0')}",
        "invoice": invoice,
        "petugas_apotik": petugasApotik,
        "fee_docter": feeDocter,
        "detail_obat": List<dynamic>.from(detailObat.map((x) => x.toJson())),
      };
}

class DetailObat {
  String namaObat;
  int jumlah;
  String satuan;
  int totalHarga;

  DetailObat({
    required this.namaObat,
    required this.jumlah,
    required this.satuan,
    required this.totalHarga,
  });

  factory DetailObat.fromJson(Map<String, dynamic> json) => DetailObat(
        namaObat: json["nama_obat"],
        jumlah: json["jumlah"],
        satuan: json["satuan"],
        totalHarga: json["total_harga"],
      );

  Map<String, dynamic> toJson() => {
        "nama_obat": namaObat,
        "jumlah": jumlah,
        "satuan": satuan,
        "total_harga": totalHarga,
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
