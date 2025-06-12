import 'dart:developer';
import 'dart:math';

import 'package:drop_down_search_field/drop_down_search_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:klinik_web_responsif/core/styles/app_colors.dart';
import 'package:klinik_web_responsif/core/utils/extensions/datasources/failure.dart';
import 'package:klinik_web_responsif/core/utils/preferences/shared_preferences_utils.dart';
import 'package:klinik_web_responsif/di/application_module.dart';
import 'package:klinik_web_responsif/services/apotik/apotik_repository.dart';
import 'package:klinik_web_responsif/services/apotik/model/request/post_buy_medicine_request.dart';
import 'package:klinik_web_responsif/services/apotik/model/request/post_medicine_request.dart';
import 'package:klinik_web_responsif/services/apotik/model/request/post_transaction_request.dart';
import 'package:klinik_web_responsif/services/apotik/model/response/delete/delete_medicine_response.dart';
import 'package:klinik_web_responsif/services/apotik/model/response/get_expired_medicines_response.dart';
import 'package:klinik_web_responsif/services/apotik/model/response/get_group_stock_medicine_response.dart';
import 'package:klinik_web_responsif/services/apotik/model/response/get_has_expired_medicine_response.dart';
import 'package:klinik_web_responsif/services/apotik/model/response/get_medicine_response.dart';
import 'package:klinik_web_responsif/services/apotik/model/response/get_monthly_summary_response.dart';
import 'package:klinik_web_responsif/services/apotik/model/response/get_new_medicine_response.dart';
import 'package:klinik_web_responsif/services/apotik/model/response/get_purchase_report_medicine_response.dart';
import 'package:klinik_web_responsif/services/apotik/model/response/get_top_five_medicine_response.dart';
import 'package:klinik_web_responsif/services/apotik/model/response/get_transaction_pasien_id_response.dart';
import 'package:klinik_web_responsif/services/apotik/model/response/get_transaction_response.dart';
import 'package:klinik_web_responsif/services/apotik/model/response/get_unit_response.dart';
import 'package:klinik_web_responsif/services/apotik/model/response/post/post_unit_medicine_response.dart';
import 'package:klinik_web_responsif/services/apotik/model/response/post_buy_medicine_response.dart';
import 'package:klinik_web_responsif/services/apotik/model/response/post_medicine_response.dart';
import 'package:klinik_web_responsif/services/apotik/model/response/post_new_medicine_response.dart';
import 'package:klinik_web_responsif/services/apotik/model/response/post_transaction_response.dart';

enum PaymentMethod { tunai, qris }

class ApotikController extends GetxController {
  RxBool actionPay = true.obs;

  void ButtonActionPay() {
    actionPay.value = !actionPay.value;
  }

  final searchController = TextEditingController();

  final ApotikRepository apotikRepository = locator();

  RxList<DataMedicine> medicineList = <DataMedicine>[].obs;
  RxList<TransactionData> transactionList = <TransactionData>[].obs;
  Rx<PasienIdTransaction?> dataPasienIdRme = Rx<PasienIdTransaction?>(null);
  Rx<PostTransactionResponse?> createTransaction =
      Rx<PostTransactionResponse?>(null);
  Rx<PosMedicineResponse?> createMedicine = Rx<PosMedicineResponse?>(null);

  //new system apotik
  RxList<DatumNewMedicine> medicineNewList = <DatumNewMedicine>[].obs;
  RxList<DatumExpiredMedicine> medicineExpiredList =
      <DatumExpiredMedicine>[].obs;
  RxList<DatumHasExpiredMedicine> medicineHasExpiredList =
      <DatumHasExpiredMedicine>[].obs;
  RxList<DatumGroupStockMedicine> medicineGroupStockList =
      <DatumGroupStockMedicine>[].obs;
  RxList<DatumGroupStockMedicine> medicineGroupStockNotEmptyList =
      <DatumGroupStockMedicine>[].obs;
  RxList<DatumReportPurchase> reportPurchaseMedicineList =
      <DatumReportPurchase>[].obs;
  RxList<TopFiveMedicine> topFiveMedicineList = <TopFiveMedicine>[].obs;
  Rx<DeleteMedicineResponse?> deleteMedicine =
      Rx<DeleteMedicineResponse?>(null);
  Rx<DataSummaryMontlyMedicine?> summaryMonthlyMedicine =
      Rx<DataSummaryMontlyMedicine?>(null);
  RxList<DatumGroupStockMedicine> selectedMedicineList =
      <DatumGroupStockMedicine>[].obs;
  RxList<TextEditingController> priceBuyControllers =
      <TextEditingController>[].obs;
  RxList<TextEditingController> stockControllers =
      <TextEditingController>[].obs;
  List<RxInt> totalSelectedMedicineList = <RxInt>[].obs;
  Rx<PostBuyMedicineResponse?> postBuyMedicineRequest =
      Rx<PostBuyMedicineResponse?>(null);
  Rx<PostNewMedicineResponse?> postNewMedicineResponse =
      Rx<PostNewMedicineResponse?>(null);
  Rx<PostUnitMedicineResponse?> postUnitNewMedicineResponse =
      Rx<PostUnitMedicineResponse?>(null);
  Rx<PostNewMedicineResponse?> putNewMedicineResponse =
      Rx<PostNewMedicineResponse?>(null);
  RxList<DatumUnit> unitList = <DatumUnit>[].obs;

  RxBool isLoading = false.obs;
  RxBool isLoadingTransaction = false.obs;
  RxBool isLoadingPostMeicine = false.obs;
  RxBool isLoadingPasienIdRme = false.obs;
  RxBool isLoadingPostTransaction = false.obs;
  RxBool isLoadingUnit = false.obs;
  RxInt numberOfPage = 1.obs;
  RxInt numberOfPageTransaction = 1.obs;
  RxInt numberOfPageUnit = 1.obs;
  RxBool readOnly = true.obs;
  RxBool buttonTransaksi = true.obs;
  var totalBayar = 0.obs; // contoh total
  var kembalian = 0.obs;
  RxString role = ''.obs;
  RxInt grandTotalRme = 0.obs;

  //new system apotik
  RxBool isLoadingExpiredMedicine = false.obs;
  RxBool isLoadingHasExpiredMedicine = false.obs;
  RxBool isLoadingSummaryMonthMedicine = false.obs;
  RxBool isLoadingGroupStock = false.obs;
  RxBool isLoadingReportPurchase = false.obs;
  RxBool isLoadingNewMedicine = false.obs;
  RxBool isLoadingPostBuyMedicine = false.obs;
  RxBool isLoadingPostNewMedicine = false.obs;
  RxBool isLoadingPostUnitNewMedicine = false.obs;
  var selectedIndex = 0.obs;
  var selectedIndexReport = 0.obs;
  RxInt selectedIndexMedicine = 0.obs;

  final TextEditingController dropdownObatController = TextEditingController();
  final nominalController = TextEditingController();
  final paymentMethodController = TextEditingController();
  final returnPayment = TextEditingController();
  final idRekamMedis = TextEditingController();
  Rx<Failures?> errorCreateTransaction = Rx<Failures?>(null);

  TextEditingController nameObatController = TextEditingController();
  TextEditingController stockController = TextEditingController();
  Rx<DateTime> tglKadalursaController = DateTime.now().obs;
  RxList<DateTime> tglKadaluarsaList = <DateTime>[].obs;

  SuggestionsBoxController suggestionBoxController = SuggestionsBoxController();
  final formKey = GlobalKey<FormState>();
  final formKeyNewPost = GlobalKey<FormState>();
  final ScrollController scrollController = ScrollController();
  Rx<DateTime> tglLahirController = DateTime.now().obs;
  RxInt grandTotal = 0.obs;
  var isDetailView = false.obs;

  final purchaseNumber = ''.obs;

  //New System Apotik
  TextEditingController supplierController = TextEditingController();
  TextEditingController nameMedicineController = TextEditingController();
  TextEditingController nameUnitMedicineController = TextEditingController();
  TextEditingController priceBuyController = TextEditingController();
  TextEditingController priceSellController = TextEditingController();
  final TextEditingController dropdownUnitController = TextEditingController();
  Rx<DateTime> dateBuyMedicineController = DateTime.now().obs;
  RxInt numberOfPageReportPurchase = 0.obs;
  RxInt numberOfPageNewMedicine = 0.obs;
  RxInt numberOfPageMedicineStock = 0.obs;
  RxInt totalPurchaseReport = 0.obs;
  RxInt noPurchaseReport = 0.obs;
  RxInt grandTotalDetailPurchaseReport = 0.obs;
  RxList<DateTime?> selectedDateRange = <DateTime?>[].obs;
  RxString noBuyDetailPurchaseReport = ''.obs;
  RxString dateBuyDetailPurchaseReport = ''.obs;
  RxString supplierBuyDetailPurchaseReport = ''.obs;
  RxString petugasBuyDetailPurchaseReport = ''.obs;
  var isLightOn = false.obs;
  var isAddMedicineView = false.obs;
  var isAddUnitMedicineView = false.obs;
  var isEditMedicineView = false.obs;
  var isEditUnitMedicineView = false.obs;

  //How To Search With Pagination
  final nameSupplierSearch = ''.obs;
  final noBuySearch = ''.obs;
  final nameMedicineStock = ''.obs;
  final nameUnit = ''.obs;
  final nameMedicineNew = ''.obs;
  final nameUnitMedicineNew = ''.obs;
  RxString selectedUnitId = ''.obs;
  RxString idMedicine = ''.obs;
  RxString idUnitMedicine = ''.obs;

  // Simpan data detail yang diklik

  void showDetail() {
    isDetailView.value = true;
  }

  void showAddMedicine() {
    isAddMedicineView.value = true;
  }

  void showAddUnitMedicine() {
    isAddUnitMedicineView.value = true;
  }

  void showEditMedicine() {
    isEditMedicineView.value = true;
  }

  void showEditUnitMedicine() {
    isEditUnitMedicineView.value = true;
  }

  void backToList() {
    isDetailView.value = false;
  }

  void backToAddMedicine() {
    isAddMedicineView.value = false;
  }

  void backToAddUnitMedicine() {
    isAddUnitMedicineView.value = false;
  }

  void backToEditMedicine() {
    isEditMedicineView.value = false;
  }

  void backToEditUnitMedicine() {
    isEditUnitMedicineView.value = false;
  }

  void toggleLight(bool value) {
    isLightOn.value = value;
  }

  @override
  void onInit() {
    super.onInit();
    getMedicine();
    getTransaction();
    getRole();
    getExpiredMedicines();
    getTopFiveMedicines();
    getMonthlySummaryMedicine();
    getHasExpiredMedicines();
    getGroupStockMedicine();
    getPurchaseReportMedicine();
    getNewMedicine();
    getUnit();
    purchaseNumber.value = generatePurchaseNumber();
  }

  String generatePurchaseNumber() {
    final now = DateTime.now();
    final formattedDate =
        "${now.year}${now.month.toString().padLeft(2, '0')}${now.day.toString().padLeft(2, '0')}";
    final random = Random().nextInt(90) + 10; // Angka random 10 - 99
    return 'BUY-$formattedDate$random';
  }

  void addSelectedMedicine(String medicineId) {
    bool isAlreadySelected =
        selectedMedicineList.any((med) => med.id == medicineId);
    if (!isAlreadySelected) {
      final selected =
          medicineGroupStockList.firstWhere((med) => med.id == medicineId);
      selectedMedicineList.add(selected);

      final priceController = TextEditingController();
      final stockController = TextEditingController();

      priceBuyControllers.add(TextEditingController());
      stockControllers.add(TextEditingController());
      tglKadaluarsaList.add(DateTime.now());
      totalSelectedMedicineList.add(0.obs);

      // Dengarkan perubahan untuk update total
      void updateRowTotal() {
        final price = int.tryParse(priceController.text) ?? 0;
        final stock = int.tryParse(stockController.text) ?? 0;
        totalSelectedMedicineList.last.value = price * stock;
      }

      priceController.addListener(updateRowTotal);
      stockController.addListener(updateRowTotal);
    }
  }

  void removeSelectedMedicine(String medicineId) {
    final index =
        selectedMedicineList.indexWhere((item) => item.id == medicineId);

    if (index != -1) {
      // Hapus semua data terkait di index tersebut
      selectedMedicineList.removeAt(index);
      priceBuyControllers.removeAt(index);
      stockControllers.removeAt(index);
      tglKadaluarsaList.removeAt(index);
      totalSelectedMedicineList.removeAt(index);

      // Update grand total setelah penghapusan
      updateGrandTotal();
    }
  }

  void updateTotalForIndex(int index) {
    final priceText = priceBuyControllers[index].text;
    final stockText = stockControllers[index].text;

    final price = int.tryParse(priceText) ?? 0;
    final stock = int.tryParse(stockText) ?? 0;

    totalSelectedMedicineList[index].value = price * stock;

    updateGrandTotal();
  }

  void updateGrandTotal() {
    final total = totalSelectedMedicineList.fold<int>(
      0,
      (sum, item) => sum + item.value,
    );
    grandTotal.value = total;
  }

  void selectTab(int index) {
    selectedIndex.value = index;
  }

  void selectTabReport(int index) {
    selectedIndexReport.value = index;
  }

  void selectTabMedicine(int index) {
    selectedIndexMedicine.value = index;
  }

  void getRole() async {
    final prefs = await SharedPreferencesUtils.getAuthToken();
    var userData = JwtDecoder.decode(prefs!);
    role.value = userData['role'];
  }

  void changeReadOnly(PostMedicineRequest medicine) {
    readOnly.toggle();

    if (!readOnly.value) {
      // Masuk mode edit, scroll ke atas
      nameObatController.text = medicine.namaObat;
      stockController.text = medicine.stock.toString();
      tglKadalursaController.value = DateTime.parse(medicine.tglKadaluarsa);
    }
  }

  void hitungKembalian(String input) {
    final bayar =
        int.tryParse(input.replaceAll('.', '').replaceAll(',', '')) ?? 0;
    kembalian.value = bayar - totalBayar.value;
  }

  Rx<PaymentMethod?> selectedPaymentMethod = Rx<PaymentMethod?>(null);

  // Fungsi untuk mengubah metode pembayaran
  void setPaymentMethod(PaymentMethod method) {
    selectedPaymentMethod.value = method;
  }

  // Fungsi untuk mendapatkan nilai sebagai string (opsional)
  String get paymentMethodString {
    switch (selectedPaymentMethod.value) {
      case PaymentMethod.tunai:
        return 'Tunai';
      case PaymentMethod.qris:
        return 'Qris';
      default:
        return 'Belum dipilih';
    }
  }

  List<DataMedicine> getMedicineSuggestions(String pattern) {
    return medicineList
        .where((obat) =>
            obat.namaObat.toLowerCase().contains(pattern.toLowerCase()))
        .toList();
  }

  List<DatumUnit> getUnitSuggestions(String pattern) {
    return unitList
        .where(
            (obat) => obat.name.toLowerCase().contains(pattern.toLowerCase()))
        .toList();
  }

  Future<void> getMedicine({
    int page = 1,
    int limit = 10,
    String nama_obat = '',
  }) async {
    isLoading.value = true;
    try {
      final response = await apotikRepository.getMedicine(
        page: page,
        limit: limit,
        nama_obat: nama_obat,
      );

      response.fold(
        (failure) {
          inspect(failure.code);
        },
        (response) async {
          medicineList.clear();
          medicineList.addAll(response.data.data);
          numberOfPage.value = response.data.pagination.totalPages;
        },
      );
      isLoading.value = false;
    } catch (e) {
      print('e:$e');
      isLoading.value = false;
    }
  }

  Future<void> getTransaction({
    int page = 1,
    int limit = 10,
    String inv = '',
    String name = '',
  }) async {
    isLoadingTransaction.value = true;
    try {
      final response = await apotikRepository.getTransaction(
          page: page, limit: limit, inv: inv, name: name);

      response.fold(
        (failure) {
          inspect(failure.code);
        },
        (response) async {
          inspect(response.data.data);
          transactionList.clear();

          transactionList.addAll(response.data.data);
          numberOfPageTransaction.value = response.data.pagination.totalPages;
        },
      );
      isLoadingTransaction.value = false;
    } catch (e) {
      print('e:$e');
      isLoadingTransaction.value = false;
    }
  }

  Future<void> getTransactionPasienIdRme({
    String id = '',
  }) async {
    isLoadingPasienIdRme.value = true;
    try {
      final response = await apotikRepository.getTransactionIdPasienRme(
        id: id,
      );

      response.fold(
        (failure) {
          inspect(failure.code);
        },
        (response) async {
          //  medicineList.clear();
          inspect(response.data);
          dataPasienIdRme.value = response.data;
          totalBayar.value = response.data.total;
        },
      );
      isLoadingPasienIdRme.value = false;
    } catch (e) {
      print('e:$e');
      isLoadingPasienIdRme.value = false;
    }
  }

  Future<void> postTransaction({required PostTransactionRequest data}) async {
    isLoadingPostTransaction.value = true;
    try {
      final response = await apotikRepository.postTransaction(data);

      response.fold((failures) async {
        inspect(failures);
        errorCreateTransaction.value = failures;
        await Future.delayed(Duration(seconds: 3));
        isLoadingPostTransaction.value = false;
      }, (response) async {
        inspect(response);
        createTransaction.value = response;
        await Future.delayed(Duration(seconds: 3));
        isLoadingPostTransaction.value = false;
      });
    } catch (e) {
      print('e:$e');
      isLoadingPostTransaction.value = false;
    }
  }

  Future<void> postMedicine({required PostMedicineRequest data}) async {
    isLoadingPostMeicine.value = true;
    try {
      final response = await apotikRepository.postMedicine(data);

      response.fold((failures) async {
        inspect(failures);
        errorCreateTransaction.value = failures;
        nameObatController.clear();
        stockController.clear();
        tglKadalursaController.value = DateTime.now();
        await Future.delayed(Duration(seconds: 3));
        isLoadingPostMeicine.value = false;
        Get.back();
        final Map<String, String>? messages = failures.message;

        final errorText = messages!.values.map((e) => e.toString()).join('\n');

        Get.snackbar(
          "Gagal Menambah Obat",
          errorText,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red.withOpacity(0.9),
          colorText: Colors.white,
          duration: Duration(seconds: 5),
        );
      }, (response) async {
        inspect(response);
        createMedicine.value = response;
        nameObatController.clear();
        stockController.clear();
        tglKadalursaController.value = DateTime.now();
        await Future.delayed(Duration(seconds: 3));
        getMedicine();
        isLoadingPostMeicine.value = false;
        Get.back();
        Get.snackbar(
          "Berhasil Menambah Obat",
          'Obat berhasil ditambahkan !',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppColors.colorBaseSuccess,
          colorText: Colors.white,
          duration: Duration(seconds: 5),
        );
      });
    } catch (e) {
      print('e:$e');
      isLoadingPostMeicine.value = false;
    }
  }

  Future<void> putMedicine(
      {required PostMedicineRequest data, required String id}) async {
    isLoadingPostMeicine.value = true;
    try {
      final response = await apotikRepository.putMedicine(data, id);

      response.fold((failures) async {
        inspect(failures);
        errorCreateTransaction.value = failures;
        nameObatController.clear();
        stockController.clear();
        tglKadalursaController.value = DateTime.now();
        await Future.delayed(Duration(seconds: 3));
        isLoadingPostMeicine.value = false;
        Get.back();
        final Map<String, String>? messages = failures.message;

        final errorText = messages!.values.map((e) => e.toString()).join('\n');

        Get.snackbar(
          "Gagal Menambah Obat",
          errorText,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red.withOpacity(0.9),
          colorText: Colors.white,
          duration: Duration(seconds: 5),
        );
      }, (response) async {
        inspect(response);
        createMedicine.value = response;
        nameObatController.clear();
        stockController.clear();
        tglKadalursaController.value = DateTime.now();
        await Future.delayed(Duration(seconds: 3));
        getMedicine();
        isLoadingPostMeicine.value = false;
        Get.back();
        Get.snackbar(
          "Berhasil Menambah Obat",
          'Obat berhasil ditambahkan !',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppColors.colorBaseSuccess,
          colorText: Colors.white,
          duration: Duration(seconds: 5),
        );
      });
    } catch (e) {
      print('e:$e');
      isLoadingPostMeicine.value = false;
    }
  }

  Future<void> putStatusMedicine(
      {required String status, required String id}) async {
    isLoadingPostMeicine.value = true;
    try {
      final response = await apotikRepository.putStatusMedicine(status, id);

      response.fold((failures) async {
        inspect(failures);
        errorCreateTransaction.value = failures;
        await Future.delayed(Duration(seconds: 3));
        isLoadingPostMeicine.value = false;
        Get.back();
        final Map<String, String>? messages = failures.message;

        final errorText = messages!.values.map((e) => e.toString()).join('\n');

        Get.snackbar(
          "Gagal Mengubah Status Obat",
          errorText,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red.withOpacity(0.9),
          colorText: Colors.white,
          duration: Duration(seconds: 5),
        );
      }, (response) async {
        inspect(response);
        createMedicine.value = response;
        await Future.delayed(Duration(seconds: 3));
        getMedicine();
        isLoadingPostMeicine.value = false;
        Get.back();
        Get.snackbar(
          "Berhasil Mengubah Status Obat",
          'Status Obat berhasil diUbah !',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppColors.colorBaseSuccess,
          colorText: Colors.white,
          duration: Duration(seconds: 5),
        );
      });
    } catch (e) {
      print('e:$e');
      isLoadingPostMeicine.value = false;
    }
  }

  //new system apotik
  Future<void> getExpiredMedicines({
    int page = 1,
    int limit = 5,
  }) async {
    isLoadingExpiredMedicine.value = true;
    try {
      final response = await apotikRepository.getExpiredMedicine(
        page: page,
        limit: limit,
      );

      response.fold(
        (failure) {
          inspect(failure.code);
        },
        (response) async {
          // medicineExpiredList.clear();
          medicineExpiredList.addAll(response.data.data);
          inspect(medicineExpiredList);
          numberOfPage.value = response.data.pagination.totalPages;
        },
      );
      isLoadingExpiredMedicine.value = false;
    } catch (e) {
      print('e:$e');
      isLoadingExpiredMedicine.value = false;
    }
  }

  Future<void> getHasExpiredMedicines({
    int page = 1,
    int limit = 10,
  }) async {
    isLoadingHasExpiredMedicine.value = true;
    try {
      final response = await apotikRepository.getMedicineHasExpired(
        page: page,
        limit: limit,
      );

      response.fold(
        (failure) {
          inspect(failure.code);
        },
        (response) async {
          medicineHasExpiredList.clear();
          medicineHasExpiredList.addAll(response.data.data);
          numberOfPage.value = response.data.pagination.totalPages;
        },
      );
      isLoadingHasExpiredMedicine.value = false;
    } catch (e) {
      print('e:$e');
      isLoadingHasExpiredMedicine.value = false;
    }
  }

  Future<void> getTopFiveMedicines() async {
    isLoadingExpiredMedicine.value = true;
    try {
      final response = await apotikRepository.getTopFiveMedicine();

      response.fold(
        (failure) {
          inspect(failure.code);
        },
        (response) async {
          // medicineExpiredList.clear();
          topFiveMedicineList.addAll(response.data);
          inspect(topFiveMedicineList);
          //  numberOfPage.value = response.data.pagination.totalPages;
        },
      );
      isLoadingExpiredMedicine.value = false;
    } catch (e) {
      print('e:$e');
      isLoadingExpiredMedicine.value = false;
    }
  }

  Future<void> getMonthlySummaryMedicine() async {
    isLoadingSummaryMonthMedicine.value = true;
    try {
      final response = await apotikRepository.getMonthlySummaryMedicine();

      response.fold(
        (failure) {
          inspect(failure.code);
        },
        (response) async {
          // medicineExpiredList.clear();
          summaryMonthlyMedicine.value = response.data;
          inspect(summaryMonthlyMedicine);
          //  numberOfPage.value = response.data.pagination.totalPages;
        },
      );
      isLoadingSummaryMonthMedicine.value = false;
    } catch (e) {
      print('e:$e');
      isLoadingSummaryMonthMedicine.value = false;
    }
  }

  Future<void> getGroupStockMedicine({
    int page = 1,
    int limit = 5,
    String name_medicine = '',
  }) async {
    isLoadingGroupStock.value = true;
    try {
      final response = await apotikRepository.getGroupStockMedicine(
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

  Future<void> postBuyMedicine() async {
    isLoadingPostBuyMedicine.value = true;
    try {
      List<MedicineRequest> datas = [];

      for (int i = 0; i < selectedMedicineList.length; i++) {
        int priceBuy = int.tryParse(priceBuyControllers[i].text) ?? 0;
        int stock = int.tryParse(stockControllers[i].text) ?? 0;
        DateTime expireDate = tglKadaluarsaList[i];

        if (stock > 0) {
          MedicineRequest item = MedicineRequest(
            medicineId: selectedMedicineList[i].id,
            priceBuy: priceBuy,
            stock: stock,
            dateExpired: expireDate,
          );
          datas.add(item);
        }
      }

      final data = PostBuyMedicineRequest(
        nameSupplier: supplierController.text,
        noBuy: purchaseNumber.value,
        dateBuy: dateBuyMedicineController.value,
        medicines: datas,
      );
      final response = await apotikRepository.postBuyeMedicine(data);

      response.fold(
        (failures) async {
          inspect(failures.code);
          await Future.delayed(Duration(seconds: 3));
          selectedMedicineList.clear();
          priceBuyControllers.value = [];
          stockControllers.value = [];
          tglKadaluarsaList.value = [];
          totalSelectedMedicineList = [];
          grandTotal.value = 0;
          dateBuyMedicineController.value = DateTime.now();
          supplierController.text = "";
          isLoadingPostBuyMedicine.value = false;
          final Map<String, String>? messages = failures.message;

          final errorText =
              messages!.values.map((e) => e.toString()).join('\n');

          Get.snackbar(
            "Gagal Melakukan Pembelian Obat",
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
          postBuyMedicineRequest.value = response;
          selectedMedicineList.clear();
          priceBuyControllers.value = [];
          stockControllers.value = [];
          tglKadaluarsaList.value = [];
          totalSelectedMedicineList = [];
          grandTotal.value = 0;
          dateBuyMedicineController.value = DateTime.now();
          supplierController.text = "";
          await Future.delayed(Duration(seconds: 3));
          getGroupStockMedicine();
          isLoadingPostBuyMedicine.value = false;
          Get.back();
          Get.snackbar(
            "Berhasil Melakukan Pembelian Obat",
            '',
            snackPosition: SnackPosition.TOP,
            backgroundColor: AppColors.colorBaseSuccess,
            colorText: Colors.white,
            duration: Duration(seconds: 5),
          );
        },
      );
    } catch (e) {
      isLoadingPostBuyMedicine.value = true;
    }
  }

  Future<void> getPurchaseReportMedicine({
    int page = 1,
    int limit = 10,
    String start_date = "",
    String end_date = "",
    String no_buy = "",
    String name_supplier = "",
  }) async {
    isLoadingReportPurchase.value = true;
    try {
      final response = await apotikRepository.getPurchaseReportMedicine(
          page: page,
          limit: limit,
          start_date: start_date,
          end_date: end_date,
          no_buy: no_buy,
          name_supplier: name_supplier);

      response.fold(
        (failure) {
          inspect(failure.code);
        },
        (response) async {
          reportPurchaseMedicineList.clear();
          reportPurchaseMedicineList.addAll(response.data.data);
          totalPurchaseReport.value = response.data.totalKeseluruhan;
          numberOfPageReportPurchase.value =
              response.data.pagination.totalPages;
        },
      );
      isLoadingReportPurchase.value = false;
    } catch (e) {
      print('e:$e');
      isLoadingReportPurchase.value = false;
    }
  }

  Future<void> getNewMedicine({
    int page = 1,
    int limit = 10,
    String name_medicine = "",
  }) async {
    isLoadingNewMedicine.value = true;
    try {
      final response = await apotikRepository.getNewMedicine(
          page: page, limit: limit, name_medicine: name_medicine);

      response.fold(
        (failure) {
          inspect(failure.code);
        },
        (response) async {
          medicineNewList.clear();
          medicineNewList.addAll(response.data.data);

          numberOfPageNewMedicine.value = response.data.pagination.totalPages;
        },
      );
      isLoadingNewMedicine.value = false;
    } catch (e) {
      print('e:$e');
      isLoadingNewMedicine.value = false;
    }
  }

  Future<void> postNewMedicine() async {
    isLoadingPostNewMedicine.value = true;
    try {
      List<Map<String, dynamic>> conversions = [];
      for (int i = 0; i < selectedMedicineListUnit.length; i++) {
        int unitMultiplier = int.tryParse(unitControllers[i].text) ?? 0;
        conversions.add({
          "unitId": selectedMedicineListUnit[i].id,
          "multiplier": unitMultiplier,
        });
      }

      final response = await apotikRepository.postNewMedicine(
          name_medicine: nameMedicineController.text,
          price_sell: int.parse(priceSellController.text),
          baseUnitId: selectedUnitId.value,
          conversions: conversions);

      response.fold(
        (failures) async {
          await Future.delayed(Duration(seconds: 3));

          isLoadingPostNewMedicine.value = false;
          final Map<String, String>? messages = failures.message;

          final errorText =
              messages!.values.map((e) => e.toString()).join('\n');

          Get.snackbar(
            "Gagal Melakukan Penambahakan Obat",
            errorText,
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red.withOpacity(0.9),
            colorText: Colors.white,
            duration: Duration(seconds: 2),
          );
          Get.back();
        },
        (response) async {
          postNewMedicineResponse.value = null;
          postNewMedicineResponse.value = response;
          await Future.delayed(Duration(seconds: 2));
          nameMedicineController.text = "";
          priceSellController.text = "";
          selectedMedicineListUnit.value = [];
          unitControllers.value = [];
          selectedUnitId.value = "";
          dropdownUnitController.text = "";
          isLightOn.value = false;
          getNewMedicine();
          isLoadingPostNewMedicine.value = false;
          Get.back();
          Get.snackbar(
            "Berhasil Melakukan Penambahan Obat",
            '',
            snackPosition: SnackPosition.TOP,
            backgroundColor: AppColors.colorBaseSuccess,
            colorText: Colors.white,
            duration: Duration(seconds: 2),
          );
        },
      );
    } catch (e) {
      isLoadingPostNewMedicine.value = true;
    }
  }

  Future<void> putNewMedicine(String id) async {
    isLoadingPostNewMedicine.value = true;
    try {
      List<Map<String, dynamic>> conversions = [];
      for (int i = 0; i < selectedMedicineListUnit.length; i++) {
        int unitMultiplier = int.tryParse(unitControllers[i].text) ?? 0;
        conversions.add({
          "unitId": selectedMedicineListUnit[i].id,
          "multiplier": unitMultiplier,
        });
      }

      final response = await apotikRepository.putNewMedicine(
        name_medicine: nameMedicineController.text,
        price_sell: int.parse(priceSellController.text),
        baseUnitId: selectedUnitId.value,
        conversions: conversions,
        id: id,
      );

      response.fold(
        (failures) async {
          await Future.delayed(Duration(seconds: 2));

          isLoadingPostNewMedicine.value = false;
          final Map<String, String>? messages = failures.message;

          final errorText =
              messages!.values.map((e) => e.toString()).join('\n');
          Get.back();
          Get.snackbar(
            "Gagal Melakukan Pengeditan Obat",
            errorText,
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red.withOpacity(0.9),
            colorText: Colors.white,
            duration: Duration(seconds: 2),
          );
        },
        (response) async {
          putNewMedicineResponse.value = null;
          putNewMedicineResponse.value = response;
          await Future.delayed(Duration(seconds: 2));
          getNewMedicine();
          backToEditMedicine();
          isLoadingPostNewMedicine.value = false;
          Get.back();
          Get.snackbar(
            "Berhasil Melakukan Pengeditan Obat",
            '',
            snackPosition: SnackPosition.TOP,
            backgroundColor: AppColors.colorBaseSuccess,
            colorText: Colors.white,
            duration: Duration(seconds: 3),
          );
        },
      );
    } catch (e) {
      isLoadingPostNewMedicine.value = true;
    }
  }

  Future<void> deleteNewMedicine(String id) async {
    isLoadingPostNewMedicine.value = true;
    try {
      final response = await apotikRepository.deleteNewMedicine(
        id: id,
      );

      response.fold(
        (failures) async {
          await Future.delayed(Duration(seconds: 2));

          isLoadingPostNewMedicine.value = false;
          final Map<String, String>? messages = failures.message;

          final errorText =
              messages!.values.map((e) => e.toString()).join('\n');
          Get.back();
          Get.snackbar(
            "Gagal Melakukan Penghapusan Obat",
            errorText,
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red.withOpacity(0.9),
            colorText: Colors.white,
            duration: Duration(seconds: 2),
          );
        },
        (response) async {
          deleteMedicine.value = null;
          deleteMedicine.value = response;
          await Future.delayed(Duration(seconds: 2));
          await getNewMedicine();
          isLoadingPostNewMedicine.value = false;
          Get.back();
          Get.back();
          Get.snackbar(
            "Berhasil Melakukan Penghapusan Obat",
            '',
            snackPosition: SnackPosition.TOP,
            backgroundColor: AppColors.colorBaseSuccess,
            colorText: Colors.white,
            duration: Duration(seconds: 3),
          );
        },
      );
    } catch (e) {
      isLoadingPostNewMedicine.value = true;
    }
  }

  Future<void> getUnit({
    int page = 1,
    int limit = 10,
    String name = "",
  }) async {
    isLoadingUnit.value = true;
    try {
      final response =
          await apotikRepository.getUnit(page: page, limit: limit, name: name);

      response.fold(
        (failure) {
          inspect(failure.code);
        },
        (response) async {
          unitList.clear();
          unitList.addAll(response.data.data);

          numberOfPageUnit.value = response.data.pagination.totalPages;
        },
      );
      isLoadingUnit.value = false;
    } catch (e) {
      print('e:$e');
      isLoadingUnit.value = false;
    }
  }

  Future<void> postUnitNewMedicine() async {
    isLoadingPostUnitNewMedicine.value = true;
    try {
      final response = await apotikRepository.postUnitNewMedicine(
          name: nameUnitMedicineController.text);

      response.fold(
        (failures) async {
          await Future.delayed(Duration(seconds: 3));

          isLoadingPostUnitNewMedicine.value = false;
          final Map<String, String>? messages = failures.message;

          final errorText =
              messages!.values.map((e) => e.toString()).join('\n');

          Get.snackbar(
            "Gagal Melakukan Penambahakan Satuan Obat",
            errorText,
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red.withOpacity(0.9),
            colorText: Colors.white,
            duration: Duration(seconds: 2),
          );
          Get.back();
        },
        (response) async {
          postUnitNewMedicineResponse.value = response;
          await Future.delayed(Duration(seconds: 2));
          nameUnitMedicineController.text = "";
          getUnit();
          isLoadingPostUnitNewMedicine.value = false;
          Get.back();
          Get.snackbar(
            "Berhasil Melakukan Penambahan Satuan Obat",
            '',
            snackPosition: SnackPosition.TOP,
            backgroundColor: AppColors.colorBaseSuccess,
            colorText: Colors.white,
            duration: Duration(seconds: 2),
          );
        },
      );
    } catch (e) {
      isLoadingPostUnitNewMedicine.value = true;
    }
  }

  Future<void> putUnitNewMedicine(String id) async {
    isLoadingPostUnitNewMedicine.value = true;
    try {
      final response = await apotikRepository.putUnitNewMedicine(
        name: nameUnitMedicineController.text,
        id: id,
      );

      response.fold(
        (failures) async {
          await Future.delayed(Duration(seconds: 2));

          isLoadingPostUnitNewMedicine.value = false;
          final Map<String, String>? messages = failures.message;

          final errorText =
              messages!.values.map((e) => e.toString()).join('\n');
          Get.back();
          Get.snackbar(
            "Gagal Melakukan Pengeditan Satuan Obat",
            errorText,
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red.withOpacity(0.9),
            colorText: Colors.white,
            duration: Duration(seconds: 2),
          );
        },
        (response) async {
          postUnitNewMedicineResponse.value = response;
          await Future.delayed(Duration(seconds: 2));
          getUnit();
          backToEditUnitMedicine();
          isLoadingPostUnitNewMedicine.value = false;
          Get.back();

          Get.snackbar(
            "Berhasil Melakukan Pengeditan Satuan Obat",
            '',
            snackPosition: SnackPosition.TOP,
            backgroundColor: AppColors.colorBaseSuccess,
            colorText: Colors.white,
            duration: Duration(seconds: 3),
          );
        },
      );
    } catch (e) {
      isLoadingPostUnitNewMedicine.value = true;
    }
  }

  Future<void> deleteUnitNewMedicine(String id) async {
    isLoadingPostUnitNewMedicine.value = true;
    try {
      final response = await apotikRepository.deleteUnitNewMedicine(
        id: id,
      );

      response.fold(
        (failures) async {
          await Future.delayed(Duration(seconds: 2));

          isLoadingPostUnitNewMedicine.value = false;
          final Map<String, String>? messages = failures.message;

          final errorText =
              messages!.values.map((e) => e.toString()).join('\n');
          Get.back();
          Get.snackbar(
            "Gagal Melakukan Penghapusan Satuan Obat",
            errorText,
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red.withOpacity(0.9),
            colorText: Colors.white,
            duration: Duration(seconds: 2),
          );
        },
        (response) async {
          deleteMedicine.value = response;
          await Future.delayed(Duration(seconds: 2));
          getUnit();
          isLoadingPostUnitNewMedicine.value = false;
          Get.back();
          Get.back();
          Get.snackbar(
            "Berhasil Melakukan Penghapusan Satuan Obat",
            '',
            snackPosition: SnackPosition.TOP,
            backgroundColor: AppColors.colorBaseSuccess,
            colorText: Colors.white,
            duration: Duration(seconds: 3),
          );
        },
      );
    } catch (e) {
      isLoadingPostUnitNewMedicine.value = true;
    }
  }

  //ArrayMedicineNewSystem

  RxList<DatumGroupStockMedicine> selectedMedicineListRme =
      <DatumGroupStockMedicine>[].obs;
  RxList<DatumUnit> selectedMedicineListUnit = <DatumUnit>[].obs;
  RxList<TextEditingController> stockControllersRme =
      <TextEditingController>[].obs;
  RxList<TextEditingController> unitControllers = <TextEditingController>[].obs;
  List<RxInt> totalSelectedMedicineListRme = <RxInt>[].obs;

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

      // Dengarkan perubahan pada stok untuk update total
      void updateRowTotal() {
        final stock = int.tryParse(stockController.text) ?? 0;
        total.value = selected.priceSell * stock;
        updateGrandTotalRme(); // Tambahkan ini agar grand total ikut terupdate
      }

      stockController.addListener(updateRowTotal);
    }
  }

  void addSelectedMedicineUnit(String unitId) {
    bool isAlreadySelected =
        selectedMedicineListUnit.any((med) => med.id == unitId);
    if (!isAlreadySelected) {
      final selected = unitList.firstWhere((med) => med.id == unitId);
      selectedMedicineListUnit.add(selected);

      final unitControlller = TextEditingController();
      unitControllers.add(unitControlller);
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

      // Update grand total setelah penghapusan
      updateGrandTotal();
    }
  }

  void removeSelectedMedicineUnit(String medicineId) {
    final index =
        selectedMedicineListUnit.indexWhere((item) => item.id == medicineId);

    if (index != -1) {
      // Hapus semua data terkait di index tersebut
      selectedMedicineListUnit.removeAt(index);
      unitControllers.removeAt(index);
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
    grandTotalRme.value = total;
  }
}
