// To parse this JSON data, do
//
//     final getMonthlySummaryMedicineResponse = getMonthlySummaryMedicineResponseFromJson(jsonString);

import 'dart:convert';

GetMonthlySummaryMedicineResponse getMonthlySummaryMedicineResponseFromJson(
        String str) =>
    GetMonthlySummaryMedicineResponse.fromJson(json.decode(str));

String getMonthlySummaryMedicineResponseToJson(
        GetMonthlySummaryMedicineResponse data) =>
    json.encode(data.toJson());

class GetMonthlySummaryMedicineResponse {
  bool success;
  int code;
  String message;
  DataSummaryMontlyMedicine data;

  GetMonthlySummaryMedicineResponse({
    required this.success,
    required this.code,
    required this.message,
    required this.data,
  });

  factory GetMonthlySummaryMedicineResponse.fromJson(
          Map<String, dynamic> json) =>
      GetMonthlySummaryMedicineResponse(
        success: json["success"],
        code: json["code"],
        message: json["message"],
        data: DataSummaryMontlyMedicine.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "code": code,
        "message": message,
        "data": data.toJson(),
      };
}

class DataSummaryMontlyMedicine {
  int pembelianObatBulanIni;
  int penjualanObatBulanIni;
  int hppBulanIni;
  int labaKotorBulanIni;
  int labaBersihBulanIni;
  int feeDokterBulanIni;
  int totalPembelianObat;
  int totalPenjualanObat;
  int totalFeeDokter;
  int totalHpp;
  int totalLabaKotor;
  int totalLabaBersih;

  DataSummaryMontlyMedicine({
    required this.pembelianObatBulanIni,
    required this.penjualanObatBulanIni,
    required this.hppBulanIni,
    required this.labaKotorBulanIni,
    required this.labaBersihBulanIni,
    required this.feeDokterBulanIni,
    required this.totalPembelianObat,
    required this.totalPenjualanObat,
    required this.totalFeeDokter,
    required this.totalHpp,
    required this.totalLabaKotor,
    required this.totalLabaBersih,
  });

  factory DataSummaryMontlyMedicine.fromJson(Map<String, dynamic> json) =>
      DataSummaryMontlyMedicine(
        pembelianObatBulanIni: json["pembelian_obat_bulan_ini"],
        penjualanObatBulanIni: json["penjualan_obat_bulan_ini"],
        hppBulanIni: json["hpp_bulan_ini"],
        labaKotorBulanIni: json["laba_kotor_bulan_ini"],
        labaBersihBulanIni: json["laba_bersih_bulan_ini"],
        feeDokterBulanIni: json["fee_dokter_bulan_ini"],
        totalPembelianObat: json["total_pembelian_obat"],
        totalPenjualanObat: json["total_penjualan_obat"],
        totalFeeDokter: json["total_fee_dokter"],
        totalHpp: json["total_hpp"],
        totalLabaKotor: json["total_laba_kotor"],
        totalLabaBersih: json["total_laba_bersih"],
      );

  Map<String, dynamic> toJson() => {
        "pembelian_obat_bulan_ini": pembelianObatBulanIni,
        "penjualan_obat_bulan_ini": penjualanObatBulanIni,
        "hpp_bulan_ini": hppBulanIni,
        "laba_kotor_bulan_ini": labaKotorBulanIni,
        "laba_bersih_bulan_ini": labaBersihBulanIni,
        "fee_dokter_bulan_ini": feeDokterBulanIni,
        "total_pembelian_obat": totalPembelianObat,
        "total_penjualan_obat": totalPenjualanObat,
        "total_fee_dokter": totalFeeDokter,
        "total_hpp": totalHpp,
        "total_laba_kotor": totalLabaKotor,
        "total_laba_bersih": totalLabaBersih,
      };
}
