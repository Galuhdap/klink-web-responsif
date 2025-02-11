
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class LoginController extends GetxController {
  var isBusy = false.obs;

  //final AuthRepository authRepository = locator();
  final formKey = GlobalKey<FormState>();

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  final userController = TextEditingController();
  final newPasswordController = TextEditingController();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController noKtpController = TextEditingController();
  final TextEditingController alamatController = TextEditingController();
  final TextEditingController usernamesController = TextEditingController();
  final TextEditingController passwordsController = TextEditingController();
  final TextEditingController telpController = TextEditingController();

  RxBool isloadingLogin = false.obs;
  RxBool isloadingForgotPassword = false.obs;
  RxBool isLoadingAddUser = false.obs;

  // Future<void> userLogin() async {
  //   isloadingLogin.value = true;
  //   try {
  //     FocusManager.instance.primaryFocus?.unfocus();

  //     final userData = LoginRequest(
  //         username: usernameController.text, password: passwordController.text);
  //     var response = await authRepository.loginUser(userData);

  //     response.fold(
  //       (failure) {
  //         MessageComponent.snackbar(
  //             title: '${failure.code}',
  //             message: failure.message,
  //             isError: true);
  //       },
  //       (response) async {
  //         await SharedPreferencesUtils.addUser(jsonEncode(response.toJson()));
  //         await SharedPreferencesUtils.addAuthToken(response.data.accessToken);

  //         Get.offAllNamed(AppRoutes.home);
  //       },
  //     );

  //     Future.delayed(
  //       Duration(seconds: 1),
  //       () {
  //         isloadingLogin.value = false;
  //       },
  //     );
  //   } catch (e) {
  //     print('e:$e');
  //     isloadingLogin.value = false;
  //   }
  // }

  // Future<void> forgotPassword() async {
  //   isloadingForgotPassword.value = true;
  //   try {
  //     final response = await authRepository.forgotPassword(
  //         userController.text, newPasswordController.text);

  //     response.fold(
  //       (failure) {
  //         MessageComponent.snackbar(
  //           title: '${failure.code}',
  //           message: failure.message,
  //           isError: true,
  //         );

  //         update();
  //       },
  //       (response) async {
  //         MessageComponent.snackbarTop(
  //           title: 'Success',
  //           message: 'Ubah Password Successfully',
  //           isError: false,
  //         );

  //         Get.to(LoadingForgotPasswordScreen(
  //           label: 'Password Telah Di Ubah',
  //         ));
  //         userController.text = '';

  //         newPasswordController.text = '';
  //         formKey.currentState?.reset();

  //         update();
  //       },
  //     );

  //     isloadingForgotPassword.value = false;
  //   } catch (e) {
  //     print('e:$e');
  //     isloadingForgotPassword.value = false;
  //   }
  // }

  // Future<void> postRegister(BuildContext context) async {
  //   isLoadingAddUser.value = true;
  //   try {
  //     final data = RegisterRequest(
  //         username: usernamesController.text,
  //         password: passwordsController.text,
  //         name: nameController.text,
  //         identityType: 'KTP',
  //         identityNumber: noKtpController.text,
  //         address: alamatController.text,
  //         telp: telpController.text);

  //     final response = await authRepository.registerUser(data);

  //     response.fold(
  //       (response) {
  //         MessageComponent.snackbar(
  //           title: '${response.code}',
  //           message: response.message,
  //           isError: true,
  //         );
  //         update();
  //       },
  //       (response) async {
  //         MessageComponent.snackbarTop(
  //           title: 'Success',
  //           message: 'User added successfully',
  //           isError: false,
  //         );
  //         Get.to(LoadingRegisterCustomerScreen(
  //           label:
  //               'Success Untuk Register',
  //         ));
  //         nameController.text = '';
  //         alamatController.text = '';
  //         noKtpController.text = '';
  //         telpController.text = '';
  //         usernamesController.text = '';
  //         passwordsController.text = '';
  //         formKey.currentState?.reset();
  //         update();
  //       },
  //     );

  //     isLoadingAddUser.value = false;
  //   } catch (e) {
  //     print('e:$e');
  //     isLoadingAddUser.value = false;
  //   }
  // }
}
