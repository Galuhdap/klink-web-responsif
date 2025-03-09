import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DocterController extends GetxController {
  RxList patient = [
    {
      "no": "1",
      "nama_docter": "Sabah A Murdaani Setiwan",
      "alamat": "Jln. Moro Seneng, Ds Nguwok",
      "no_telp": "089113441223",
      "status": "aktif",
    },
    {
      "no": "2",
      "nama_docter": "Sabah A Murdaani Setiwan",
      "alamat": "Jln. Moro Seneng, Ds Nguwok",
      "no_telp": "089113441223",
      "status": "Aktif",
    },
    {
      "no": "3",
      "nama_docter": "Sabah A Murdaani Setiwan",
      "alamat": "Jln. Moro Seneng, Ds Nguwok",
      "no_telp": "089113441223",
      "status": "Aktif",
    },
    {
      "no": "4",
      "nama_docter": "Sabah A Murdaani Setiwan",
      "alamat": "Jln. Moro Seneng, Ds Nguwok",
      "no_telp": "089113441223",
      "status": "Aktif",
    },
  ].obs;

  final searchController = TextEditingController();
}
