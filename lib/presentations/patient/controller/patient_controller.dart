import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:klinik_web_responsif/core/styles/app_colors.dart';
import 'package:klinik_web_responsif/core/utils/extensions/datasources/failure.dart';
import 'package:klinik_web_responsif/di/application_module.dart';
import 'package:klinik_web_responsif/services/pasien/model/request/post_pasient_request.dart';
import 'package:klinik_web_responsif/services/pasien/model/response/get_pasien_by_id_response.dart';
import 'package:klinik_web_responsif/services/pasien/model/response/get_pasien_response.dart';
import 'package:klinik_web_responsif/services/pasien/model/response/post_pasien_response.dart';
import 'package:klinik_web_responsif/services/pasien/pasien_repository.dart';

class PatientController extends GetxController {
  final searchController = TextEditingController();

  final PasienRepository pasienRepository = locator();

  TextEditingController nameController = TextEditingController();
  RxString jenisKelaminController = ''.obs;
  Rx<DateTime> tglLahirController = DateTime.now().obs;
  TextEditingController alamatController = TextEditingController();
  TextEditingController noTelpController = TextEditingController();
  TextEditingController nikController = TextEditingController();
  TextEditingController umurController = TextEditingController();

  RxList<ListPasien> pasienList = <ListPasien>[].obs;
  Rx<DataPasien?> dataPasien = Rx<DataPasien?>(null);
  Rx<PostPasienResponse?> createPasien = Rx<PostPasienResponse?>(null);
  Rx<Failures?> errorCreatePasien = Rx<Failures?>(null);

  RxBool isLoading = false.obs;
  RxBool isLoadingId = false.obs;
  RxBool isLoadingCreate = false.obs;
  RxBool readOnly = true.obs;
  RxInt numberOfPage = 1.obs;

  final formKey = GlobalKey<FormState>();
  final ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    super.onInit();
    getPasien();
    //getPasienById();
  }

  void changeReadOnly(PostPasienRequest patient) {
    readOnly.toggle();

    if (!readOnly.value) {
      // Masuk mode edit, scroll ke atas
      nameController.text = patient.name;
      jenisKelaminController.value = patient.jenisKelamin;
      tglLahirController.value = patient.tglLahir;
      alamatController.text = patient.alamat;
      noTelpController.text = patient.noTelp;
      nikController.text = patient.nik;

      Future.delayed(Duration(milliseconds: 100), () {
        scrollController.animateTo(
          0.0,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      });
    }
  }

  Future<void> getPasien({
    int page = 1,
    int limit = 10,
    String search = '',
  }) async {
    isLoading.value = true;
    try {
      final response = await pasienRepository.getPasien(
        page: page,
        limit: limit,
        search: search,
      );

      response.fold(
        (failure) {
          inspect(failure.code);
        },
        (response) async {
          pasienList.clear();

          pasienList.addAll(response.data.data);
          numberOfPage.value = response.data.pagination.totalPages;

          // balanceCustomer.value = response.data;
        },
      );
      isLoading.value = false;
    } catch (e) {
      print('e:$e');
      isLoading.value = false;
    }
  }

  Future<void> getPasienById(String id) async {
    isLoadingId.value = true;
    try {
      final response = await pasienRepository.getPasienById(id);

      response.fold(
        (failure) {
          inspect(failure.code);
        },
        (response) async {
          inspect(response.data);
          print(response.data);
          dataPasien.value = response.data;

          // dataPasienId.addAll(response.data);
        },
      );
      isLoadingId.value = false;
    } catch (e) {
      print('e:$e');
      isLoadingId.value = false;
    }
  }

  Future<void> postPasien() async {
    isLoadingCreate.value = true;
    try {
      var data = PostPasienRequest(
        name: nameController.text,
        jenisKelamin: jenisKelaminController.value,
        alamat: alamatController.text,
        tglLahir: tglLahirController.value,
        nik: nikController.text,
        noTelp: noTelpController.text,
        // umur: umurController.text,
      );
      final response = await pasienRepository.postPasien(data);

      response.fold(
        (failures) async {
          inspect(failures);
          errorCreatePasien.value = failures;
          nameController.clear();
          jenisKelaminController.value = '';
          alamatController.clear();
          tglLahirController.value = DateTime.now();
          nikController.clear();
          noTelpController.clear();
          umurController.clear();
          await Future.delayed(Duration(seconds: 3));
          isLoadingCreate.value = false;
          Get.back();
          final Map<String, String>? messages = failures.message;

          final errorText =
              messages!.values.map((e) => e.toString()).join('\n');

          Get.snackbar(
            "Gagal Mendaftar Pasien",
            errorText,
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red.withOpacity(0.9),
            colorText: Colors.white,
            duration: Duration(seconds: 5),
          );
        },
        (response) async {
          inspect(response.data);
          createPasien.value = response;
          nameController.clear();
          jenisKelaminController.value = '';
          alamatController.clear();
          tglLahirController.value = DateTime.now();
          nikController.clear();
          noTelpController.clear();
          umurController.clear();
          await Future.delayed(Duration(seconds: 3));
          getPasien();
          isLoadingCreate.value = false;
          Get.back();
          Get.snackbar(
            "Berhasil Mendaftar Pasien",
            '',
            snackPosition: SnackPosition.TOP,
            backgroundColor: AppColors.colorBaseSuccess,
            colorText: Colors.white,
            duration: Duration(seconds: 5),
          );
        },
      );
    } catch (e) {
      print('e:$e');
      isLoadingCreate.value = false;
    }
  }

  Future<void> putPasien(String id) async {
    isLoadingCreate.value = true;
    try {
      var data = PostPasienRequest(
        name: nameController.text,
        jenisKelamin: jenisKelaminController.value,
        alamat: alamatController.text,
        tglLahir: tglLahirController.value,
        nik: nikController.text,
        noTelp: noTelpController.text,
        // umur: umurController.text,
      );
      final response = await pasienRepository.putPasien(data, id);

      response.fold(
        (failures) async {
          inspect(failures);
          errorCreatePasien.value = failures;
          nameController.clear();
          jenisKelaminController.value = '';
          alamatController.clear();
          tglLahirController.value = DateTime.now();
          nikController.clear();
          noTelpController.clear();
          umurController.clear();
          await Future.delayed(Duration(seconds: 3));
          isLoadingCreate.value = false;
          Get.back();
          final Map<String, String>? messages = failures.message;

          final errorText =
              messages!.values.map((e) => e.toString()).join('\n');

          Get.snackbar(
            "Gagal Mengedit Pasien",
            errorText,
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red.withOpacity(0.9),
            colorText: Colors.white,
            duration: Duration(seconds: 5),
          );
        },
        (response) async {
          inspect(response.data);
          createPasien.value = response;
          nameController.clear();
          jenisKelaminController.value = '';
          alamatController.clear();
          tglLahirController.value = DateTime.now();
          nikController.clear();
          noTelpController.clear();
          umurController.clear();
          await Future.delayed(Duration(seconds: 3));
          getPasien();
          isLoadingCreate.value = false;
          Get.back();
          Get.snackbar(
            "Berhasil Mengedit Pasien",
            '',
            snackPosition: SnackPosition.TOP,
            backgroundColor: AppColors.colorBaseSuccess,
            colorText: Colors.white,
            duration: Duration(seconds: 5),
          );
        },
      );
    } catch (e) {
      print('e:$e');
      isLoadingCreate.value = false;
    }
  }
}
