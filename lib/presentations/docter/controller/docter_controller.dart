import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:klinik_web_responsif/di/application_module.dart';
import 'package:klinik_web_responsif/services/doctor/doctor_repository.dart';
import 'package:klinik_web_responsif/services/doctor/model/response/get_doctor_response.dart';

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
  final DoctorRepository doctorRepository = locator();

  RxList<DataDoctor> doctorList = <DataDoctor>[].obs;
  
  // Rx<DataPasien?> dataPasien = Rx<DataPasien?>(null);

  RxBool isLoading = false.obs;
  RxBool isLoadingId = false.obs;
  RxInt numberOfPage = 1.obs;

  @override
  void onInit() {
    super.onInit();
    getDoctor();
    //getDoctorById();
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
}
