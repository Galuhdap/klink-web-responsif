import 'dart:developer';

import 'package:drop_down_search_field/drop_down_search_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:klinik_web_responsif/core/styles/app_colors.dart';
import 'package:klinik_web_responsif/core/utils/extensions/datasources/failure.dart';
import 'package:klinik_web_responsif/di/application_module.dart';
import 'package:klinik_web_responsif/services/owner/model/request/post_user_request.dart';
import 'package:klinik_web_responsif/services/owner/model/response/get_role_response.dart';
import 'package:klinik_web_responsif/services/owner/model/response/get_user_id_response.dart';
import 'package:klinik_web_responsif/services/owner/model/response/get_user_response.dart';
import 'package:klinik_web_responsif/services/owner/model/response/post_user_response.dart';
import 'package:klinik_web_responsif/services/owner/model/response/put_reset_password_user_response.dart';
import 'package:klinik_web_responsif/services/owner/owner_repository.dart';

class UserManajemenController extends GetxController {
  final searchController = TextEditingController();

  final OwnerRepository ownerRepository = locator();
  var selectedIndex = 0.obs;

  RxList<UserData> userAdmin = <UserData>[].obs;
  RxList<UserData> userDokter = <UserData>[].obs;
  RxList<UserData> userApotik = <UserData>[].obs;
  RxList<UserData> userOwner = <UserData>[].obs;
  RxList<RoleData> roleList = <RoleData>[].obs;
  Rx<PostUserResponse?> createUser = Rx<PostUserResponse?>(null);
  Rx<PutResetPasswordResponse?> resetPasswordUser =
      Rx<PutResetPasswordResponse?>(null);
  Rx<GetUserIdResponse?> userId = Rx<GetUserIdResponse?>(null);
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

  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  var isAddUser = false.obs;
  var isEditUser = false.obs;
  var isRessetPasswordUser = false.obs;
  RxString idUser = ''.obs;

  RxBool isLoading = false.obs;
  RxBool isLoadingResetPassword = false.obs;
  RxBool isLoadingCreate = false.obs;
  RxBool isLoadingUpdate = false.obs;
  RxBool isLoadingRole = false.obs;
  RxBool isLoadingUserId = false.obs;
  RxInt numberOfPage = 1.obs;

  RxString name = ''.obs;
  final errorMessages = <String, String?>{}.obs;

  get isLoadingPostNewMedicine => null;

  @override
  void onInit() {
    super.onInit();
    getUser();
    getRole();
    getUserId();
  }

  void resetErrors() {
    errorMessages.clear();
  }

  bool validate() {
    resetErrors();

    final oldPassword = oldPasswordController.text.trim();
    final newPassword = newPasswordController.text.trim();
    final confirmPassword = confirmPasswordController.text.trim();

    if (oldPassword.isEmpty) {
      errorMessages['oldPassword'] = 'Password lama wajib diisi';
    }

    if (newPassword.isEmpty) {
      errorMessages['newPassword'] = 'Password baru wajib diisi';
    } else if (newPassword == oldPassword) {
      errorMessages['newPassword'] =
          'Password baru tidak boleh sama dengan password lama';
    }

    if (confirmPassword.isEmpty) {
      errorMessages['confirmPassword'] = 'Konfirmasi password wajib diisi';
    } else if (confirmPassword != newPassword) {
      errorMessages['confirmPassword'] = 'Konfirmasi password tidak cocok';
    }

    return errorMessages.isEmpty;
  }

  void selectTab(int index) {
    selectedIndex.value = index;
  }

  void showAddUser() {
    isAddUser.value = true;
  }

  void showRessetPassword() {
    isRessetPasswordUser.value = true;
  }

  void showEditUser() {
    isEditUser.value = true;
  }

  void backToAddUser() {
    isAddUser.value = false;
  }

  void backToEditUser() {
    isEditUser.value = false;
  }

  void backToRessetPassword() {
    oldPasswordController.text = '';
    newPasswordController.text = '';
    confirmPasswordController.text = '';
    isRessetPasswordUser.value = false;
  }

  Future<void> getUser({
    int page = 1,
    int limit = 10,
    String name = '',
  }) async {
    isLoading.value = true;
    try {
      final response = await ownerRepository.getUser(
        page: page,
        limit: limit,
        name: name,
      );

      response.fold(
        (failure) {
          inspect(failure.code);
        },
        (response) async {
          userAdmin.clear();
          userDokter.clear();
          userApotik.clear();
          userOwner.clear();
          for (var user in response.data.data) {
            switch (user.role.name) {
              case 'ADMIN':
                user.no = userAdmin.length + 1;
                userAdmin.add(user);
                break;
              case 'DOKTER':
                userDokter.add(user);
                break;
              case 'APOTEKER':
                userApotik.add(user);
                break;
              case 'PEMILIK':
                userOwner.add(user);
                break;
            }
          }
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

  Future<void> getUserId() async {
    isLoadingUserId.value = true;
    try {
      final response = await ownerRepository.getUserId();

      response.fold(
        (failure) {
          inspect(failure.code);
        },
        (response) async {
          roleList.clear();
          userId.value = response;
        },
      );
      isLoadingUserId.value = false;
    } catch (e) {
      print('e:$e');
      isLoadingUserId.value = false;
    }
  }

  List<RoleData> getRoleSuggestions(String pattern) {
    return roleList
        .where(
            (role) => role.name.toLowerCase().contains(pattern.toLowerCase()))
        .toList();
  }

  Future<void> postUser() async {
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

  Future<void> putUser(String id) async {
    isLoadingUpdate.value = true;
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
          isLoadingUpdate.value = false;
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
          isLoadingUpdate.value = false;
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
      isLoadingUpdate.value = false;
    }
  }

  Future<void> putResetPasswordUser() async {
    if (!validate()) return;
    isLoadingResetPassword.value = true;
    try {
      final response = await ownerRepository.resetPasswordUser(
          oldPasswordController.text, newPasswordController.text);
      response.fold(
        (failures) async {
          inspect(failures);
          errorCreateUser.value = failures;
          await Future.delayed(Duration(seconds: 3));
          isLoadingResetPassword.value = false;
          Get.back();
          final Map<String, String>? messages = failures.message;
          final errorText =
              messages!.values.map((e) => e.toString()).join('\n');
          Get.snackbar(
            "Gagal Mereset Password User",
            errorText,
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red.withOpacity(0.9),
            colorText: Colors.white,
            duration: Duration(seconds: 5),
          );
        },
        (response) async {
          inspect(response.data);
          resetPasswordUser.value = response;
          oldPasswordController.text = '';
          newPasswordController.text = '';
          confirmPasswordController.text = '';

          await Future.delayed(Duration(seconds: 3));
          getUser();
          isLoadingResetPassword.value = false;
          backToRessetPassword();
          Get.back();
          Get.snackbar(
            "Berhasil Mengubah Password User",
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
      isLoadingResetPassword.value = false;
    }
  }

  Future<void> submitResetPassword() async {
    if (!validate()) return;

    isLoadingResetPassword.value = true;

    try {
      // Contoh request ke backend
      // Ganti dengan API service kamu
      final response = await Future.delayed(Duration(seconds: 2), () {
        return true;
      });

      if (response == true) {
        Get.snackbar("Sukses", "Password berhasil diubah");
        oldPasswordController.clear();
        newPasswordController.clear();
        confirmPasswordController.clear();
      } else {
        Get.snackbar("Error", "Gagal mengubah password");
      }
    } catch (e) {
      Get.snackbar("Error", "Terjadi kesalahan server");
    } finally {
      isLoadingResetPassword.value = false;
    }
  }
}
