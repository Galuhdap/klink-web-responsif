import 'dart:developer';

import 'package:drop_down_search_field/drop_down_search_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:klinik_web_responsif/core/styles/app_colors.dart';
import 'package:klinik_web_responsif/core/utils/extensions/datasources/failure.dart';
import 'package:klinik_web_responsif/di/application_module.dart';
import 'package:klinik_web_responsif/services/owner/model/request/post_user_request.dart';
import 'package:klinik_web_responsif/services/owner/model/response/get_role_response.dart';
import 'package:klinik_web_responsif/services/owner/model/response/get_user_response.dart';
import 'package:klinik_web_responsif/services/owner/model/response/post_user_response.dart';
import 'package:klinik_web_responsif/services/owner/owner_repository.dart';

class UserManajemenController extends GetxController {
  RxList riwayatTransaksi = [
    {
      "no": "1",
      "nama": "monaji",
      "email": "P@gmail.com",
      "jenis_kelamin": "laki-laki",
      "no_telp": "089647826",
      "role": "Dokter",
    },
    {
      "no": "2",
      "email": "P@gmail.com",
      "nama": "monaji",
      "jenis_kelamin": "laki-laki",
      "no_telp": "089647826",
      "role": "Dokter",
    },
    {
      "no": "3",
      "email": "P@gmail.com",
      "nama": "monaji",
      "jenis_kelamin": "laki-laki",
      "no_telp": "089647826",
      "role": "Dokter",
    },
  ].obs;

  final searchController = TextEditingController();

  final OwnerRepository ownerRepository = locator();

  RxList<UserData> userList = <UserData>[].obs;
  RxList<RoleData> roleList = <RoleData>[].obs;
  Rx<PostUserResponse?> createUser = Rx<PostUserResponse?>(null);
  Rx<Failures?> errorCreateUser = Rx<Failures?>(null);

  final TextEditingController nikController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController alamatController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController noTelpController = TextEditingController();
  RxString jenisKelaminController = ''.obs;
  RxString roleController = ''.obs;
  Rx<DateTime> tglLahirController = DateTime.now().obs;
  TextEditingController dropdownRoleController = TextEditingController();
  SuggestionsBoxController suggestionBoxController = SuggestionsBoxController();
  final formKey = GlobalKey<FormState>();

  RxBool isLoading = false.obs;
  RxBool isLoadingCreate = false.obs;
  RxBool isLoadingRole = false.obs;
  RxInt numberOfPage = 1.obs;

  @override
  void onInit() {
    super.onInit();
    getUser();
    getRole();
  }

  Future<void> getUser({
    int page = 1,
    int limit = 10,
    String name = '',
    String nik = '',
  }) async {
    isLoading.value = true;
    try {
      final response = await ownerRepository.getUser(
        page: page,
        limit: limit,
        name: name,
        nik: nik,
      );

      response.fold(
        (failure) {
          inspect(failure.code);
        },
        (response) async {
          userList.clear();
          userList.addAll(response.data.data);
          numberOfPage.value = response.data.pagination.totalPages;
        },
      );
      isLoading.value = false;
    } catch (e) {
      print('e:$e');
      isLoading.value = false;
    }
  }

  Future<void> getRole() async {
    isLoadingRole.value = true;
    try {
      final response = await ownerRepository.getRole();

      response.fold(
        (failure) {
          inspect(failure.code);
        },
        (response) async {
          roleList.clear();
          roleList.addAll(response.data);
        },
      );
      isLoadingRole.value = false;
    } catch (e) {
      print('e:$e');
      isLoadingRole.value = false;
    }
  }

  List<RoleData> getRoleSuggestions(String pattern) {
    return roleList
        .where(
            (role) => role.name.toLowerCase().contains(pattern.toLowerCase()))
        .toList();
  }

  Future<void> postPasien() async {
    isLoadingCreate.value = true;
    try {
      var data = PostUserRequest(
          username: usernameController.text,
          name: nameController.text,
          email: emailController.text,
          password: 'password123',
          jenisKelamin: jenisKelaminController.value,
          alamat: alamatController.text,
          tglLahir: tglLahirController.value,
          nik: nikController.text,
          noTelp: noTelpController.text,
          role: dropdownRoleController.text);
      final response = await ownerRepository.postUser(data);
      response.fold(
        (failures) async {
          inspect(failures);
          errorCreateUser.value = failures;
          nameController.clear();
          usernameController.clear();
          emailController.clear();
          roleController.value = '';
          jenisKelaminController.value = '';
          alamatController.clear();
          tglLahirController.value = DateTime.now();
          nikController.clear();
          noTelpController.clear();
          await Future.delayed(Duration(seconds: 3));
          isLoadingCreate.value = false;
          Get.back();
          final Map<String, String>? messages = failures.message;
          final errorText =
              messages!.values.map((e) => e.toString()).join('\n');
          Get.snackbar(
            "Gagal Mendaftar User",
            errorText,
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red.withOpacity(0.9),
            colorText: Colors.white,
            duration: Duration(seconds: 5),
          );
        },
        (response) async {
          inspect(response.data);
          createUser.value = response;
          nameController.clear();
          usernameController.clear();
          emailController.clear();
          roleController.value = '';
          jenisKelaminController.value = '';
          alamatController.clear();
          tglLahirController.value = DateTime.now();
          nikController.clear();
          noTelpController.clear();
          await Future.delayed(Duration(seconds: 3));
          getUser();
          isLoadingCreate.value = false;
          Get.back();
          Get.snackbar(
            "Berhasil Mendaftar User",
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
      var data = PostUserRequest(
          username: usernameController.text,
          name: nameController.text,
          email: emailController.text,
          password: 'password123',
          jenisKelamin: jenisKelaminController.value,
          alamat: alamatController.text,
          tglLahir: tglLahirController.value,
          nik: nikController.text,
          noTelp: noTelpController.text,
          role: dropdownRoleController.text);
      final response = await ownerRepository.putUser(data, id);
      response.fold(
        (failures) async {
          inspect(failures);
          errorCreateUser.value = failures;
          nameController.clear();
          usernameController.clear();
          emailController.clear();
          roleController.value = '';
          jenisKelaminController.value = '';
          alamatController.clear();
          tglLahirController.value = DateTime.now();
          nikController.clear();
          noTelpController.clear();
          await Future.delayed(Duration(seconds: 3));
          isLoadingCreate.value = false;
          Get.back();
          final Map<String, String>? messages = failures.message;
          final errorText =
              messages!.values.map((e) => e.toString()).join('\n');
          Get.snackbar(
            "Gagal Mendaftar User",
            errorText,
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red.withOpacity(0.9),
            colorText: Colors.white,
            duration: Duration(seconds: 5),
          );
        },
        (response) async {
          inspect(response.data);
          createUser.value = response;
          nameController.clear();
          usernameController.clear();
          emailController.clear();
          roleController.value = '';
          jenisKelaminController.value = '';
          alamatController.clear();
          tglLahirController.value = DateTime.now();
          nikController.clear();
          noTelpController.clear();
          await Future.delayed(Duration(seconds: 3));
          getUser();
          isLoadingCreate.value = false;
          Get.back();
          Get.snackbar(
            "Berhasil Mendaftar User",
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
