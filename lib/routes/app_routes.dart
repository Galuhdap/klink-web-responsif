import 'package:get/get.dart';
import 'package:klinik_web_responsif/presentations/menu_dashboard/screen/dashboard_mobile_screen.dart';
import 'package:klinik_web_responsif/presentations/menu_dashboard/screen/dashboard_web_screen.dart';
import 'package:klinik_web_responsif/presentations/menu_dashboard/screen/responive_dashboard.dart';
import 'package:klinik_web_responsif/presentations/login/screen/login_screen.dart';
import 'package:klinik_web_responsif/presentations/patient/screen/data_patient_page.dart';


class AppRoutes {
  static const String main = "/";

  static const String login = "/login";
  static const String dashboardWeb = "/dashboardWeb";
  static const String patien = "/patient";
  static const String dashboardMobile = "/dashboardMobile";
  static const String responsiveDashboard = "/responsiveDashboard";
  

  static final routes = [
    GetPage(name: main, page: () => LoginScreen()),
    GetPage(name: dashboardWeb, page: () => DashboardScreen()),
    GetPage(name: dashboardMobile, page: () => DashboardMobileScreen()),
    GetPage(name: patien, page: () => DataPatientScreen()),
    GetPage(name: responsiveDashboard, page: () => ResponsiveDashboard()),
    //cara menggunakan Binding
    //GetPage(name: login, page : () => LoginScreen(), binding: LoginBinding()),
  ];
}
