import 'package:flutter/material.dart';
import 'package:klinik_web_responsif/core/config/responsive.dart';
import 'package:klinik_web_responsif/core/resources/enum/role_user_enum.dart';
import 'package:klinik_web_responsif/presentations/menu_dashboard/screen/dashboard_mobile_screen.dart';
import 'package:klinik_web_responsif/presentations/menu_dashboard/screen/dashboard_web_screen.dart';

class ResponsiveDashboard extends StatelessWidget {
  const ResponsiveDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (Responsive.isMobile(context)) {
          // Jika layar kecil (mobile)
          return const DashboardMobileScreen(userRole: UserRole.pemilik,);
        } else {
          // Jika layar besar (web atau tablet)
          return const DashboardScreen(userRole: UserRole.pemilik,);
        }
      },
    );
  }
}