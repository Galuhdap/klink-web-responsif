import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:klinik_web_responsif/core/utils/preferences/shared_preferences_utils.dart';

class DashboardController extends GetxController {
  RxBool isLoading = false.obs;
  RxString role = ''.obs;


  @override
  void onInit() {
    super.onInit();
    checkUserData();
  
  }

  void checkUserData() async {
    isLoading.value = true;
    try {
      final prefs = await SharedPreferencesUtils.getAuthToken();
      var userData = JwtDecoder.decode(prefs!);
      role.value = userData['role'];
     
      isLoading.value = false;
    } catch (e) {
      print('e:$e');
      isLoading.value = false;
    }
  }
}
