import 'package:drop_down_search_field/drop_down_search_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RekamMedisController extends GetxController {
  RxList patient = [
    {
      "nomor_antrian": "20",
      "jadwal_periksa": "12/09/2000",
      "keluhan": "Meriang",
      "terapi_tindakan": "Kasih Obat",
      "dx": "140/90",
    },
    {
      "nomor_antrian": "20",
      "jadwal_periksa": "20/09/2000",
      "keluhan": "Meriang",
      "terapi_tindakan": "Kasih Obat",
      "dx": "140/90",
    },
    {
      "nomor_antrian": "20",
      "jadwal_periksa": "30/09/2000",
      "keluhan": "Masuk Angin",
      "terapi_tindakan": "Kasih Obat",
      "dx": "140/90",
    },
    {
      "nomor_antrian": "20",
      "jadwal_periksa": "12/08/2000",
      "keluhan": "Sakit Gigis",
      "terapi_tindakan": "Kasih Obat",
      "dx": "140/90",
    },
  ].obs;

  final TextEditingController controller = TextEditingController();
  RxList<GroupObat> dummySuggestions = [
    GroupObat(id: 1, nama: 'Paracetamol', harga: 10000),
    GroupObat(id: 2, nama: 'Bodrek', harga: 20000),
    GroupObat(id: 3, nama: 'Farsevin 400mg', harga: 30000),
    GroupObat(id: 4, nama: 'Solinefec Ketoconazol 200mg', harga: 40000),
  ].obs;

  SuggestionsBoxController suggestionBoxController = SuggestionsBoxController();
  final TextEditingController dropdownSearchFieldController =
      TextEditingController();
  final TextEditingController dropdownObatController = TextEditingController();

  List<GroupObat> getTrashSuggestions(String pattern) {
    return dummySuggestions
        .where(
            (obat) => obat.nama.toLowerCase().contains(pattern.toLowerCase()))
        .toList();
  }

  RxList<TextEditingController> qtyControllers =
      <TextEditingController>[].obs;
}

class GroupObat {
  final int id;
  final String nama;
  final int harga;

  GroupObat({required this.id, required this.nama, required this.harga});
}
