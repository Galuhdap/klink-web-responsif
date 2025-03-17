import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ApotikController extends GetxController {
  RxBool actionPay = true.obs;

  void ButtonActionPay() {
    actionPay.value = !actionPay.value;
  }

  RxList obat = [
    {
      "no": "1",
      "nama_obat": "Farsevin 400mg",
      "tgl_kadaluarsa": "06/03/2027",
      "stock": "100",
      "status": "aktif",
    },
  ].obs;

  final searchController = TextEditingController();

  RxList patient = [
    {
      "nomor_antrian": "20",
      "nama_pasien": "Sabah",
      "jenis_kelamin": "Laki-Laki",
      "tanggal_lahir": "sdasdas",
      "alamat": "sdasdas",
      "rm": "RM-110",
      "nik": "sdasdas",
      "no_telp": "sdasdas",
      "action": "sdasdas",
      "status": "ambil_obat"
    },
    {
      "nomor_antrian": "12",
      "nama_pasien": "Yukya",
      "jenis_kelamin": "Laki-Laki",
      "tanggal_lahir": "sdasdas",
      "alamat": "sdasdas",
      "rm": "RM-112",
      "nik": "sdasdas",
      "no_telp": "sdasdas",
      "action": "sdasdas",
      "status": "ambil_obat"
    },
    {
      "nomor_antrian": "13",
      "nama_pasien": "Moni",
      "jenis_kelamin": "Perempuan",
      "tanggal_lahir": "sdasdas",
      "alamat": "sdasdas",
      "rm": "RM-330",
      "nik": "sdasdas",
      "no_telp": "sdasdas",
      "action": "sdasdas",
      "status": "ambil_obat"
    },
    {
      "nomor_antrian": "09",
      "nama_pasien": "Sizuka",
      "jenis_kelamin": "Perempuan",
      "tanggal_lahir": "sdasdas",
      "alamat": "sdasdas",
      "rm": "RM-9900",
      "nik": "sdasdas",
      "no_telp": "sdasdas",
      "action": "sdasdas",
      "status": "ambil_obat"
    },
    {
      "nomor_antrian": "02",
      "nama_pasien": "monaji",
      "jenis_kelamin": "Laki-Laki",
      "tanggal_lahir": "sdasdas",
      "alamat": "sdasdas",
      "rm": "RM-1203",
      "nik": "sdasdas",
      "no_telp": "sdasdas",
      "action": "sdasdas",
      "status": "ambil_obat"
    },
  ].obs;

  RxList riwayatTransaksi = [
    {
      "no": "1",
      "norekamMedis": "333002",
      "nama_pasien": "monaji",
      "tanggal_transaksi": "12/09/2000",
      "nominal": "Rp. 50.000",
      "inovice": "INV-1223002121",
    },
    {
      "no": "2",
      "norekamMedis": "333002",
      "nama_pasien": "monaji",
      "tanggal_transaksi": "12/09/2000",
      "nominal": "Rp. 5.000.000",
      "inovice": "INV-122300",
    },
    {
      "no": "3",
      "norekamMedis": "333002",
      "nama_pasien": "monaji",
      "tanggal_transaksi": "12/09/2000",
      "nominal": "Rp. 50.000",
      "inovice": "INV-122300",
    },
  ].obs;
}
