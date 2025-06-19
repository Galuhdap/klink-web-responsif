import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:klinik_web_responsif/core/utils/preferences/shared_preferences_utils.dart';
import 'package:klinik_web_responsif/di/application_module.dart';
import 'package:klinik_web_responsif/services/apotik/apotik_repository.dart';
import 'package:klinik_web_responsif/services/apotik/model/response/get_group_stock_notempty_medicine_response.dart';
import 'package:klinik_web_responsif/services/apotik/model/response/get_medicine_response.dart';
import 'package:klinik_web_responsif/services/rme/model/request/post_rme_request.dart';
import 'package:klinik_web_responsif/services/rme/model/response/get_rme_id_response.dart';
import 'package:klinik_web_responsif/services/rme/model/response/post_rme_response.dart';
import 'package:klinik_web_responsif/services/rme/rme_repository.dart';

class RekamMedisController extends GetxController {
  final RmeRepository rmeRepository = locator();
  final ApotikRepository apotikRepository = locator();

  //RxList<TextEditingController> qtyController = <TextEditingController>[].obs;

  RxList<RmeData> rmePasientList = <RmeData>[].obs;
  RxList<DataMedicine> medicineList = <DataMedicine>[].obs;
  Rx<PostRmeResponse?> createRme = Rx<PostRmeResponse?>(null);
  RxList<DateTime?> selectedDateRange = <DateTime?>[].obs;
  RxList<DatumGroupStockNotEmptyMedicine> medicineGroupStockList =
      <DatumGroupStockNotEmptyMedicine>[].obs;

  final TextEditingController keluhanController = TextEditingController();
  final TextEditingController terapiTindakanController =
      TextEditingController();
  final TextEditingController dxController = TextEditingController();
  final TextEditingController idPasienController = TextEditingController();
  final TextEditingController feeDocterController = TextEditingController();
  RxList<DatumGroupStockNotEmptyMedicine> selectedMedicineListRme =
      <DatumGroupStockNotEmptyMedicine>[].obs;
  RxList<TextEditingController> stockControllersRme =
      <TextEditingController>[].obs;
  List<RxInt> totalSelectedMedicineListRme = <RxInt>[].obs;
  RxInt grandTotalRme = 0.obs;

  final searchController = TextEditingController();
  final namesearchController = TextEditingController();
  final niksearchController = TextEditingController();
  final umursearchController = TextEditingController();
  final normeearchController = TextEditingController();

  RxString role = ''.obs;
  RxBool isLoading = false.obs;
  RxBool isLoadingRMEId = false.obs;
  RxBool isLoadingCreate = false.obs;
  RxInt numberOfPage = 1.obs;
  RxString selectedObatId = ''.obs;
  RxBool isLoadingGroupStock = false.obs;
  RxInt numberOfPageMedicineStock = 0.obs;

  final keluhanSearch = ''.obs;
  var isDetailView = false.obs;

  @override
  void onInit() {
    super.onInit();
    getMedicine();
    getGroupStockZeroMedicine();
    //getRmePasien();
    //getPasienById();
  }

  void showDetail() {
    isDetailView.value = true;
  }

  void backToList() {
    isDetailView.value = false;
  }

  Future getRmePasien({
    int page = 1,
    int limit = 10,
    String start_date = '',
    String end_date = '',
    String keluhan = '',
    String id = '',
  }) async {
    isLoadingRMEId.value = true;
    try {
      final response = await rmeRepository.getRmeId(
          page: page,
          limit: limit,
          start_date: start_date,
          end_date: end_date,
          keluhan: keluhan,
          id: id);
      print(id);
      response.fold(
        (failure) {
          inspect(failure.code);
        },
        (response) async {
          rmePasientList.clear();

          inspect(response.data.data);
          rmePasientList.addAll(response.data.data);
          numberOfPage.value = response.data.pagination.totalPages;
          print(start_date);
          print(end_date);
          print(id);
        },
      );
      isLoadingRMEId.value = false;
    } catch (e) {
      print('e:$e');
      isLoadingRMEId.value = false;
    }
  }

  Future<void> postRme(String idPasien) async {
    isLoadingCreate.value = true;
    try {
      List<ObatRequest> datas = [];

      for (int i = 0; i < stockControllersRme.length; i++) {
        String qtyText = stockControllersRme[i].value.text;
        int qty = int.tryParse(qtyText) ?? 0;

        if (qty > 0) {
          ObatRequest item = ObatRequest(
            medicineId: selectedMedicineListRme[i].id,
            qty: qty,
            unitId: selectedMedicineListRme[i].unitId,
          );
          datas.add(item);
        }
      }

      final data = PostRmeRequest(
          keluhan: keluhanController.text,
          terapiTindakan: terapiTindakanController.text,
          dx: dxController.text,
          idPasien: idPasien,
          feeDocter: int.tryParse(feeDocterController.text) ?? 0,
          obat: datas);
      final response = await rmeRepository.postRme(data);

      inspect(data);

      response.fold(
        (failures) async {
          inspect(failures.code);
          await Future.delayed(Duration(seconds: 3));
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
          medicineList.clear();
          selectedMedicineListRme.clear();
          keluhanController.clear();
          terapiTindakanController.clear();
          dxController.clear();
          idPasienController.clear();
          feeDocterController.clear();
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

  Future<void> getGroupStockZeroMedicine({
    int page = 1,
    int limit = 5,
    String name_medicine = '',
  }) async {
    isLoadingGroupStock.value = true;
    try {
      final response = await rmeRepository.getGroupStockMedicineZero(
          page: page, limit: limit, name_medicine: name_medicine);

      response.fold(
        (failure) {
          inspect(failure.code);
        },
        (response) async {
          medicineGroupStockList.clear();
          medicineGroupStockList.addAll(response.data.data);
          numberOfPageMedicineStock.value = response.data.pagination.totalPages;
        },
      );
      isLoadingGroupStock.value = false;
    } catch (e) {
      print('e:$e');
      isLoadingGroupStock.value = false;
    }
  }

  void addSelectedMedicineRme(String medicineId) {
    bool isAlreadySelected =
        selectedMedicineListRme.any((med) => med.id == medicineId);
    if (!isAlreadySelected) {
      final selected =
          medicineGroupStockList.firstWhere((med) => med.id == medicineId);
      selectedMedicineListRme.add(selected);

      final stockController = TextEditingController(text: '1');
      stockControllersRme.add(stockController);

      final total = (selected.priceSell * 1).obs;
      totalSelectedMedicineListRme.add(total);

      updateGrandTotalRme();

      // Dengarkan perubahan pada stok untuk update total
      void updateRowTotal() {
        final stock = int.tryParse(stockController.text) ?? 0;
        total.value = selected.priceSell * stock;
        updateGrandTotalRme(); // Tambahkan ini agar grand total ikut terupdate
      }

      stockController.addListener(updateRowTotal);
    }
  }

  void removeSelectedMedicineRme(String medicineId) {
    final index =
        selectedMedicineListRme.indexWhere((item) => item.id == medicineId);

    if (index != -1) {
      // Hapus semua data terkait di index tersebut
      selectedMedicineListRme.removeAt(index);
      stockControllersRme.removeAt(index);
      totalSelectedMedicineListRme.removeAt(index);
      if (selectedMedicineListRme.isEmpty) {
        feeDocterController.text = "";
      }
      // Update grand total setelah penghapusan
      updateGrandTotalRme();
    }
  }

  void updateTotalForIndexRme(int index) {
    final stockText = stockControllersRme[index].text;
    final stock = int.tryParse(stockText) ?? 0;
    final price = selectedMedicineListRme[index].priceSell;
    totalSelectedMedicineListRme[index].value = price * stock;

    updateGrandTotalRme();
  }

  void updateGrandTotalRme() {
    final total = totalSelectedMedicineListRme.fold<int>(
      0,
      (sum, item) => sum + item.value,
    );
    final extraFee = int.tryParse(feeDocterController.text) ?? 0;

    grandTotalRme.value = total + extraFee;
  }
}
