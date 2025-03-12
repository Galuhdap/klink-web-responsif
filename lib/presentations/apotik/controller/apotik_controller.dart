import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ApotikController extends GetxController {
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
}
