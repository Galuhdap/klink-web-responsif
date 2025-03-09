import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PatientController extends GetxController {
  RxList patient = [
    {
      "nomor_antrian": "20",
      "nama_pasien": "Sabah A Murdaani Setiwan",
      "jenis_kelamin": "Laki-Laki",
      "tgl_lahir": "12/09/2000",
      "alamat": "sdasdas",
      "rm": "RM-110",
      "nik": "357903739279",
      "no_telp": "sdasdas",
      "action": "sdasdas",
      "status": "menunggu",
      "umur": "20"
    },
    {
      "nomor_antrian": "12",
      "nama_pasien": "Yukya",
      "jenis_kelamin": "Laki-Laki",
      "tgl_lahir": "12/09/2000",
      "alamat": "sdasdas",
      "rm": "RM-112",
      "nik": "357903739279",
      "no_telp": "sdasdas",
      "action": "sdasdas",
      "status": "pending",
      "umur": "20"
    },
    {
      "nomor_antrian": "13",
      "nama_pasien": "Moni",
      "jenis_kelamin": "Perempuan",
      "tgl_lahir": "12/09/2000",
      "alamat": "sdasdas",
      "rm": "RM-330",
      "nik": "357903739279",
      "no_telp": "sdasdas",
      "action": "sdasdas",
      "status": "proses",
      "umur": "20"
    },
    {
      "nomor_antrian": "09",
      "nama_pasien": "Sizuka",
      "jenis_kelamin": "Perempuan",
      "tgl_lahir": "12/09/2000",
      "alamat": "sdasdas",
      "rm": "RM-9900",
      "nik": "357903739279",
      "no_telp": "sdasdas",
      "action": "sdasdas",
      "status": "dibatalkan",
      "umur": "20",
    },
    {
      "nomor_antrian": "02",
      "nama_pasien": "monaji",
      "jenis_kelamin": "Laki-Laki",
      "tgl_lahir": "12/09/2000",
      "alamat": "sdasdas",
      "rm": "RM-1203",
      "nik": "357903739279",
      "no_telp": "sdasdas",
      "action": "sdasdas",
      "status": "selesai",
      "umur": "20"
    },
  ].obs;

  final searchController = TextEditingController();
}
