import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:klinik_web_responsif/core/utils/preferences/shared_preferences_utils.dart';
import 'package:klinik_web_responsif/di/application_module.dart';
import 'package:klinik_web_responsif/services/apotik/apotik_repository.dart';
import 'package:klinik_web_responsif/services/apotik/model/response/get_medicine_response.dart';
import 'package:klinik_web_responsif/services/rme/model/request/post_rme_request.dart';
import 'package:klinik_web_responsif/services/rme/model/response/get_rme_id_response.dart';
import 'package:klinik_web_responsif/services/rme/model/response/post_rme_response.dart';
import 'package:klinik_web_responsif/services/rme/rme_repository.dart';

class RekamMedisController extends GetxController {
  final RmeRepository pasienRepository = locator();
  final ApotikRepository apotikRepository = locator();

  //RxList<TextEditingController> qtyController = <TextEditingController>[].obs;

  RxList<RmeData> rmePasientList = <RmeData>[].obs;
  RxList<DataMedicine> medicineList = <DataMedicine>[].obs;
  RxList<DataMedicine> selectedMedicineList = <DataMedicine>[].obs;
  Rx<PostRmeResponse?> createRme = Rx<PostRmeResponse?>(null);

  final TextEditingController dropdownObatController = TextEditingController();
  final TextEditingController keluhanController = TextEditingController();
  final TextEditingController terapiTindakanController =
      TextEditingController();
  final TextEditingController dxController = TextEditingController();
  final TextEditingController idPasienController = TextEditingController();
  final TextEditingController totalController = TextEditingController();
  RxList<TextEditingController> qtyControllers = <TextEditingController>[].obs;

  RxString role = ''.obs;
  RxBool isLoading = false.obs;
  RxBool isLoadingCreate = false.obs;
  RxInt numberOfPage = 1.obs;
  RxString selectedObatId = ''.obs;

  @override
  void onInit() {
    super.onInit();
    getMedicine();
    //getRmePasien();
    //getPasienById();
  }

  void addSelectedMedicine(String medicineId) {
    bool isMedicineAlreadySelected =
        selectedMedicineList.any((medicine) => medicine.id == medicineId);

    if (!isMedicineAlreadySelected) {
      var selectedMedicine =
          medicineList.firstWhere((medicine) => medicine.id == medicineId);

      // Tambahkan ke selectedTrashList
      selectedMedicineList.add(
        DataMedicine(
          id: selectedMedicine.id,
          namaObat: selectedMedicine.namaObat,
          stock: selectedMedicine.stock,
          tglKadaluarsa: selectedMedicine.tglKadaluarsa,
          statusObat: selectedMedicine.statusObat,
        ),
      );

      qtyControllers.add(TextEditingController());
      print('selectedMedicineList: ${selectedMedicineList.length}');
      print('qtyControllers: ${qtyControllers.length}');
    } else {
      print('Sampah dengan ID $medicineId sudah dipilih.');
    }
  }

  void removeSelectedMedicine(String medicineId) {
    int index = selectedMedicineList
        .indexWhere((medicine) => medicine.id == medicineId);

    if (index != -1) {
      // Hapus dari selectedTrashList
      selectedMedicineList.removeAt(index);
      qtyControllers.removeAt(index);
    }
  }

  Future<void> getRmePasien({
    int page = 1,
    int limit = 10,
    String start_date = '',
    String end_date = '',
    String keluhan = '',
    String id = '',
  }) async {
    isLoading.value = true;
    try {
      final prefs = await SharedPreferencesUtils.getAuthToken();
      var userData = JwtDecoder.decode(prefs!);
      role.value = userData['role'];
      final response = await pasienRepository.getRmeId(
          page: page,
          limit: limit,
          start_date: start_date,
          end_date: end_date,
          keluhan: keluhan,
          id: id);

      response.fold(
        (failure) {
          inspect(failure.code);
        },
        (response) async {
          rmePasientList.clear();
          inspect(response.data.data);
          // rmePasientList.clear();
          rmePasientList.addAll(response.data.data);
          //  medicineList.addAll(response.data.data.expand((rme) => rme.obat));
          numberOfPage.value = response.data.pagination.totalPages;
        },
      );
      isLoading.value = false;
    } catch (e) {
      print('e:$e');
      isLoading.value = false;
    }
  }

  Future<void> postRme(String idPasien) async {
    isLoadingCreate.value = true;
    try {
      List<ObatRequest> datas = [];

      for (int i = 0; i < qtyControllers.length; i++) {
        String qtyText = qtyControllers[i].value.text;
        int qty = int.tryParse(qtyText) ?? 0;

        if (qty > 0) {
          ObatRequest item = ObatRequest(
            idObat: selectedMedicineList[i].id,
            qty: qty,
          );
          datas.add(item);
        }
      }

      final data = PostRmeRequest(
          keluhan: keluhanController.text,
          terapiTindakan: terapiTindakanController.text,
          dx: dxController.text,
          idPasien: idPasien,
          total: int.tryParse(totalController.text) ?? 0,
          obat: datas);
      final response = await pasienRepository.postRme(data);

      inspect(data);

      response.fold(
        (failures) async {
          inspect(failures.code);
          await Future.delayed(Duration(seconds: 3));
          selectedMedicineList.clear();
          qtyControllers.value = [];
          isLoadingCreate.value = false;
          final Map<String, String>? messages = failures.message;

          final errorText =
              messages!.values.map((e) => e.toString()).join('\n');

          Get.snackbar(
            "Gagal Membuat Rekam Medis Pasien",
            errorText,
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red.withOpacity(0.9),
            colorText: Colors.white,
            duration: Duration(seconds: 5),
          );
          Get.back();
        },
        (response) async {
          inspect(response);
          createRme.value = response;
          await Future.delayed(Duration(seconds: 3));
          qtyControllers.value = [];
          medicineList.clear();
          selectedMedicineList.clear();
          dropdownObatController.clear();
          keluhanController.clear();
          terapiTindakanController.clear();
          dxController.clear();
          idPasienController.clear();
          totalController.clear();
          isLoadingCreate.value = false;
          getRmePasien(id: response.data.idPasien);
          isLoadingCreate.value = false;
          Get.back();
        },
      );
    } catch (e) {
      isLoadingCreate.value = true;
    }
  }

  Future<void> getMedicine({
    int page = 1,
    int limit = 10,
    String search = '',
  }) async {
    isLoading.value = true;
    try {
      final prefs = await SharedPreferencesUtils.getAuthToken();
      var userData = JwtDecoder.decode(prefs!);
      role.value = userData['role'];
      final response = await apotikRepository.getMedicine(
        page: page,
        limit: limit,
        nama_obat: search,
      );

      response.fold(
        (failure) {
          inspect(failure.code);
        },
        (response) async {
          inspect(response.data.data);
          // rmePasientList.clear();
          medicineList.addAll(response.data.data);
        },
      );
      isLoading.value = false;
    } catch (e) {
      print('e:$e');
      isLoading.value = false;
    }
  }
}
