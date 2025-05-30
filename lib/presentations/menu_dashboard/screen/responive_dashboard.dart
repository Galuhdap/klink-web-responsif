import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:klinik_web_responsif/core/config/responsive.dart';
import 'package:klinik_web_responsif/core/resources/enum/role_user_enum.dart';
import 'package:klinik_web_responsif/presentations/home/controllers/home_controller.dart';
import 'package:klinik_web_responsif/presentations/menu_dashboard/controllers/dashboard_controller.dart';
import 'package:klinik_web_responsif/presentations/menu_dashboard/screen/dashboard_mobile_screen.dart';
import 'package:klinik_web_responsif/presentations/menu_dashboard/screen/dashboard_web_screen.dart';

class ResponsiveDashboard extends StatelessWidget {
  const ResponsiveDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(HomeController());
    return GetBuilder<DashboardController>(
      init: DashboardController(),
      builder: (controller) {
        return LayoutBuilder(
          builder: (context, constraints) {
            return Obx(
              () {
                if (controller.isLoading.value) {
                  return const Center(
                    child: SizedBox(
                      width: 100,
                      height: 100,
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
                final role = controller.role.value;

                final userRole = getUserRoleFromString(role);

                if (Responsive.isDesktop(context)) {
                  // Mobile view
                  return DashboardScreen(userRole: userRole);
                } else {
                  // Web/Tablet view
                  return DashboardMobileScreen(userRole: userRole);
                }
              },
            );
          },
        );
      },
    );
  }

  UserRole getUserRoleFromString(String role) {
    switch (role) {
      case 'ADMIN':
        return UserRole.ADMIN;
      case 'DOKTER':
        return UserRole.DOKTER;
      case 'APOTEKER':
        return UserRole.APOTEKER;
      default:
        return UserRole.PEMILIK;
    }
  }
}
