import 'package:get/get.dart';
import 'package:klinik_web_responsif/presentations/login/screen/login_screen.dart';


class AppRoutes {
  static const String main = "/";

  static const String login = "/login";
  

  static final routes = [
    GetPage(name: main, page: () => LoginScreen()),
    //cara menggunakan Binding
    //GetPage(name: login, page : () => LoginScreen(), binding: LoginBinding()),
  ];
}
