import 'package:get/get.dart';
import 'package:klinik_web_responsif/presentations/docter/screen/docter_screen.dart';
import 'package:klinik_web_responsif/presentations/home/screen/staff/staff_screen.dart';
import 'package:klinik_web_responsif/presentations/menu_dashboard/screen/responive_dashboard.dart';
import 'package:klinik_web_responsif/presentations/login/screen/login_screen.dart';
import 'package:klinik_web_responsif/presentations/patient/screen/data_patient_page.dart';
import 'package:klinik_web_responsif/presentations/patient/screen/rekam_medis_screen.dart';


class AppRoutes {
  static const String main = "/";

  static const String login = "/login";
  static const String dashboardWeb = "/dashboardWeb";
  static const String patien = "/patient";
  static const String dashboardMobile = "/dashboardMobile";
  static const String responsiveDashboard = "/responsiveDashboard";
  static const String staffHome = "/staf-home";
  static const String rekamMedis = "/rekam-medis";
  static const String docter = "/docter";
  

  static final routes = [
    GetPage(name: main, page: () => LoginScreen()),
    //GetPage(name: dashboardWeb, page: () => DashboardScreen()),
    //GetPage(name: dashboardMobile, page: () => DashboardMobileScreen()),
    GetPage(name: patien, page: () => DataPatientScreen()),
    GetPage(name: responsiveDashboard, page: () => ResponsiveDashboard()),
    GetPage(name: staffHome, page: () => StaffScreen()),
    GetPage(name: rekamMedis, page: () => RekamMedisScreen()),
    GetPage(name: docter, page: () => DocterScreen()),
    //cara menggunakan Binding
    //GetPage(name: login, page : () => LoginScreen(), binding: LoginBinding()),
  ];
}
