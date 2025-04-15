import 'dart:developer';

import 'package:drop_down_search_field/drop_down_search_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:klinik_web_responsif/core/utils/preferences/shared_preferences_utils.dart';
import 'package:klinik_web_responsif/di/application_module.dart';
import 'package:klinik_web_responsif/services/rme/model/response/get_rme_id_response.dart';
import 'package:klinik_web_responsif/services/rme/rme_repository.dart';

class RekamMedisController extends GetxController {
  final RmeRepository pasienRepository = locator();

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

  RxList<TextEditingController> qtyControllers = <TextEditingController>[].obs;

  RxList<RmeData> rmePasientList = <RmeData>[].obs;
  RxList<DataObat> obatList = <DataObat>[].obs;

  RxString role = ''.obs;
  RxBool isLoading = false.obs;
  RxInt numberOfPage = 1.obs;

  @override
  void onInit() {
    super.onInit();
    //getRmePasien();
    //getPasienById();
  }

  Future<void> getRmePasien({
    int page = 1,
    int limit = 10,
    String search = '',
    String id = '',
  }) async {
    isLoading.value = true;
    try {
      final prefs = await SharedPreferencesUtils.getAuthToken();
      var userData = JwtDecoder.decode(prefs!);
      role.value = userData['role'];
      final response = await pasienRepository.getRmeId(
          page: page, limit: limit, search: search, id: id);

      response.fold(
        (failure) {
          inspect(failure.code);
        },
        (response) async {
          inspect(response.data.data);
          rmePasientList.clear();

          obatList.addAll(response.data.data.expand((rme) => rme.obat));
          rmePasientList.addAll(response.data.data);
          numberOfPage.value = response.data.pagination.totalPages;
        },
      );
      isLoading.value = false;
    } catch (e) {
      print('e:$e');
      isLoading.value = false;
    }
  }
}

class GroupObat {
  final int id;
  final String nama;
  final int harga;

  GroupObat({required this.id, required this.nama, required this.harga});
}
