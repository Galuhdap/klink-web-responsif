import 'package:get/get.dart';
import 'package:klinik_web_responsif/core/utils/preferences/shared_preferences_utils.dart';
import 'package:klinik_web_responsif/routes/app_routes.dart';

class SplashController extends GetxController {
 // RxString role = ''.obs;

  @override
  void onInit() {
    super.onInit();
    checkUserData();
  }

  void checkUserData() async {
    await Future.delayed(Duration(seconds: 2));
    final prefs = await SharedPreferencesUtils.getAuthToken();
    if (prefs != null) {
      // Get.put(HomeController());
      Get.offAllNamed(AppRoutes.responsiveDashboard);
    } else {
      Get.offAllNamed(AppRoutes.login);
    }
  }

}
