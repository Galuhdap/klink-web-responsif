import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:klinik_web_responsif/core/styles/app_colors.dart';
import 'package:klinik_web_responsif/di/application_module.dart';
import 'package:klinik_web_responsif/services/doctor/doctor_repository.dart';
import 'package:klinik_web_responsif/services/doctor/model/request/post_letter_rme_request.dart';
import 'package:klinik_web_responsif/services/doctor/model/response/get_doctor_response.dart';
import 'package:klinik_web_responsif/services/doctor/model/response/get_letter_rme_response.dart';
import 'package:klinik_web_responsif/services/doctor/model/response/get_summary_doctor_response.dart';
import 'package:klinik_web_responsif/services/doctor/model/response/post/post_letter_rme_response.dart';
import 'package:klinik_web_responsif/services/doctor/model/response/put/put_letter_rme_response.dart';

class DocterController extends GetxController {
  final searchController = TextEditingController();
  final DoctorRepository doctorRepository = locator();
  final formKeyNewPost = GlobalKey<FormState>();

  RxList<DataDoctor> doctorList = <DataDoctor>[].obs;
  RxList<DatumLetterRme> letterRmeList = <DatumLetterRme>[].obs;
  Rx<GetSummaryDocterResponse?> getSummaryDoctor =
      Rx<GetSummaryDocterResponse?>(null);
  Rx<PostLetterRmeResponse?> postLetterRme = Rx<PostLetterRmeResponse?>(null);
  Rx<PutLetterRmeResponse?> putLetterRme = Rx<PutLetterRmeResponse?>(null);

  var isPatientView = false.obs;
  var isAddLetterRmeView = false.obs;
  var isEditLetterRmeView = false.obs;

  // Rx<DataPasien?> dataPasien = Rx<DataPasien?>(null);

  TextEditingController jobController = TextEditingController();
  TextEditingController keperluanController = TextEditingController();
  Rx<DateTime> tglDigunakanController = DateTime.now().obs;
  RxList<DateTime?> selectedDateRange = <DateTime?>[].obs;

  RxBool isLoading = false.obs;
  RxBool isLoadingSummary = false.obs;
  RxBool isLoadingId = false.obs;
  RxBool isLoadingLetterRme = false.obs;
  RxBool isLoadingPostLetterRme = false.obs;
  RxBool isLoadingUpdateLetterRme = false.obs;
  RxInt numberOfPage = 1.obs;
  RxInt numberOfPageLetterRme = 1.obs;

  get numberOfPageLetterHealt => null;

  RxString noLetterSearch = ''.obs;

  RxString noRekamMedisLetter = ''.obs;
  RxString idPasienLetter = ''.obs;
  RxString namePasienLetter = ''.obs;
  RxString jenisKelaminLetter = ''.obs;
  RxString alamatLetter = ''.obs;
  RxString jobLetter = ''.obs;
  RxString periodLatter = ''.obs;
  RxString idLatter = ''.obs;

  @override
  void onInit() {
    super.onInit();
    getDoctor();
    getSummaryDoctors();
    getLetterRmeById();
    //getDoctorById();
  }

  void showPatient() {
    isPatientView.value = true;
  }

  void showAddLetterRme() {
    isAddLetterRmeView.value = true;
  }

  void showEditLetterRme() {
    isEditLetterRmeView.value = true;
  }

  void backPatient() {
    isPatientView.value = false;
  }

  void backAddLetterRme() {
    isAddLetterRmeView.value = false;
  }

  void backEditLetterRme() {
    isEditLetterRmeView.value = false;
  }

  Future<void> getDoctor({
    int page = 1,
    int limit = 10,
    String name = '',
    String nik = '',
  }) async {
    isLoading.value = true;
    try {
      final response = await doctorRepository.getDoctor(
          page: page, limit: limit, name: name, nik: nik);

      response.fold(
        (failure) {
          inspect(failure.code);
        },
        (response) async {
          doctorList.clear();

          doctorList.addAll(response.data.data);
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

  Future<void> getLetterRmeById({
    int page = 1,
    int limit = 10,
    String no_letter = '',
  }) async {
    isLoadingLetterRme.value = true;
    try {
      final response = await doctorRepository.getLetterRmeById(
          page: page, limit: limit, no_letter: no_letter);

      response.fold(
        (failure) {
          inspect(failure.code);
        },
        (response) async {
          letterRmeList.clear();

          letterRmeList.addAll(response.data.data);
          numberOfPageLetterRme.value = response.data.pagination.totalPages;

          // balanceCustomer.value = response.data;
        },
      );
      isLoadingLetterRme.value = false;
    } catch (e) {
      print('e:$e');
      isLoadingLetterRme.value = false;
    }
  }

  Future<void> getSummaryDoctors() async {
    isLoadingSummary.value = true;
    try {
      final response = await doctorRepository.getSummaryDoctor();

      response.fold(
        (failure) {
          inspect(failure.code);
        },
        (response) async {
          getSummaryDoctor.value = response;
        },
      );
      isLoadingSummary.value = false;
    } catch (e) {
      print('e:$e');
      isLoadingSummary.value = false;
    }
  }

  Future<void> postLatterRme() async {
    isLoadingPostLetterRme.value = true;
    try {
      var data = PostLetterRmeRequest(
        pekerjaan: jobController.text,
        keperluan: keperluanController.text,
        startDate: selectedDateRange[0]!,
        endDate: selectedDateRange[1]!,
        idPasien: idPasienLetter.value,
      );

      final response = await doctorRepository.postLetterRme(data: data);

      response.fold(
        (failures) async {
          await Future.delayed(Duration(seconds: 3));

          isLoadingPostLetterRme.value = false;
          final Map<String, String>? messages = failures.message;

          final errorText =
              messages!.values.map((e) => e.toString()).join('\n');

          Get.snackbar(
            "Gagal Melakukan Penambahakan Surat RME",
            errorText,
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red.withOpacity(0.9),
            colorText: Colors.white,
            duration: Duration(seconds: 2),
          );
          Get.back();
        },
        (response) async {
          postLetterRme.value = response;
          await Future.delayed(Duration(seconds: 2));

          keperluanController.text = '';
          alamatLetter.value = '';
          namePasienLetter.value = '';
          idPasienLetter.value = '';
          jenisKelaminLetter.value = '';
          noRekamMedisLetter.value = '';
          jobController.text = '';

          selectedDateRange.value = [];
          periodLatter.value = '';
          idLatter.value = '';
          getLetterRmeById();
          isLoadingPostLetterRme.value = false;
          Get.back();
          backAddLetterRme();
          backPatient();
          Get.snackbar(
            "Berhasil Melakukan Penambahan Surat RME",
            '',
            snackPosition: SnackPosition.TOP,
            backgroundColor: AppColors.colorBaseSuccess,
            colorText: Colors.white,
            duration: Duration(seconds: 2),
          );
        },
      );
    } catch (e) {
      isLoadingPostLetterRme.value = true;
    }
  }

  Future<void> putLatterRme() async {
    isLoadingUpdateLetterRme.value = true;
    try {
      var data = PostLetterRmeRequest(
        pekerjaan: jobController.text,
        keperluan: keperluanController.text,
        startDate: selectedDateRange[0]!,
        endDate: selectedDateRange[1]!,
      );

      final response =
          await doctorRepository.putLetterRme(data: data, id: idLatter.value);

      response.fold(
        (failures) async {
          await Future.delayed(Duration(seconds: 3));

          isLoadingUpdateLetterRme.value = false;
          final Map<String, String>? messages = failures.message;

          final errorText =
              messages!.values.map((e) => e.toString()).join('\n');

          Get.snackbar(
            "Gagal Melakukan Penambahakan Surat RME",
            errorText,
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red.withOpacity(0.9),
            colorText: Colors.white,
            duration: Duration(seconds: 2),
          );
          Get.back();
        },
        (response) async {
          putLetterRme.value = response;
          await Future.delayed(Duration(seconds: 2));

          keperluanController.text = '';
          alamatLetter.value = '';
          namePasienLetter.value = '';
          idPasienLetter.value = '';
          jenisKelaminLetter.value = '';
          noRekamMedisLetter.value = '';
          jobController.text = '';

          selectedDateRange.value = [];
          periodLatter.value = '';
          idLatter.value = '';
          getLetterRmeById();
          isLoadingUpdateLetterRme.value = false;
          Get.back();

          backEditLetterRme();
          backPatient();
          Get.snackbar(
            "Berhasil Melakukan Penambahan Surat RME",
            '',
            snackPosition: SnackPosition.TOP,
            backgroundColor: AppColors.colorBaseSuccess,
            colorText: Colors.white,
            duration: Duration(seconds: 2),
          );
        },
      );
    } catch (e) {
      isLoadingUpdateLetterRme.value = true;
    }
  }
}
