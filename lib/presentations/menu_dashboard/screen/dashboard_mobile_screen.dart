import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:klinik_web_responsif/core/resources/enum/role_user_enum.dart';
import 'package:klinik_web_responsif/core/styles/app_colors.dart';
import 'package:klinik_web_responsif/core/utils/preferences/shared_preferences_utils.dart';
import 'package:klinik_web_responsif/presentations/apotik/screen/medicine_has_expired_screen.dart';
import 'package:klinik_web_responsif/presentations/apotik/screen/medicine_screen.dart';
import 'package:klinik_web_responsif/presentations/apotik/screen/menu_report_screen.dart';
import 'package:klinik_web_responsif/presentations/apotik/screen/menu_transaksi_screen.dart';
import 'package:klinik_web_responsif/presentations/apotik/screen/riwayat_transaksi_screen.dart';
import 'package:klinik_web_responsif/presentations/home/screen/stackholder/stackholder_screen.dart';
import 'package:klinik_web_responsif/presentations/home/screen/staff/apotik_dashboard_screen.dart';
import 'package:klinik_web_responsif/presentations/home/screen/staff/queue_screen.dart';
import 'package:klinik_web_responsif/presentations/home/screen/staff/staff_screen.dart';
import 'package:klinik_web_responsif/presentations/menu_dashboard/widget/nav_item.dart';
import 'package:klinik_web_responsif/presentations/patient/screen/patient_screen.dart';
import 'package:klinik_web_responsif/presentations/user/screen/user_manajemen_screen.dart';
import 'package:klinik_web_responsif/routes/app_routes.dart';

import '../../../core/assets/assets.gen.dart';

class DashboardMobileScreen extends StatefulWidget {
  final UserRole userRole;
  const DashboardMobileScreen({super.key, required this.userRole});

  @override
  State<DashboardMobileScreen> createState() => _DashboardMobileScreenState();
}

class _DashboardMobileScreenState extends State<DashboardMobileScreen> {
  int _selectedIndex = 0;

  List<Widget> get _pages {
    switch (widget.userRole) {
      case UserRole.ADMIN:
        return [
          const QueueScreen(),
          const PatientScreen(),
          //const DataPatientScreen(),
          // const DocterScreen(),
        ];
      case UserRole.DOKTER:
        return [
          const StaffScreen(),
          //const DataAntrianPasienDocterScreen(),
        ];
      case UserRole.APOTEKER:
        return [
          const ApotikDashboardScreen(),
          const MedicineScreen(),
          // const ObatScreen(),
          const MedicineHasExpiredScreen(),
          const MenuTransaksiScreen(),
          // const TakeDrugScreen(),
          // const RiwayatTransaksiScreen(),
          const MenuReportScreen(),
        ];
      case UserRole.PEMILIK:
        return [
          const StackholderScreen(),
          const UserManajemenScreen(),
          const RiwayatTransaksiScreen(),
        ];
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: AppColors.colorBasePrimary,
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, -2),
              blurRadius: 30.0,
              blurStyle: BlurStyle.outer,
              spreadRadius: 0,
              color: AppColors.colorBaseBlack.withOpacity(0.08),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: _buildNavItems(),
        ),
      ),
    );
  }

  List<Widget> _buildNavItems() {
    switch (widget.userRole) {
      case UserRole.ADMIN:
        return [
          NavItem(
            iconPath: Assets.icons.rsDashboard.path,
            isActive: _selectedIndex == 0,
            onTap: () => _onItemTapped(0),
          ),
          NavItem(
            iconPath: Assets.icons.pasien.path,
            isActive: _selectedIndex == 1,
            onTap: () => _onItemTapped(1),
          ),
          // NavItem(
          //   iconPath: Assets.icons.doctor.path,
          //   isActive: _selectedIndex == 2,
          //   onTap: () => _onItemTapped(2),
          // ),
          IconButton(
            onPressed: () async {
              await SharedPreferencesUtils.deleteAuthToken();
              Get.offAllNamed(AppRoutes.login);
            },
            icon: SvgPicture.asset(Assets.icons.logOut.path),
          )
        ];
      case UserRole.DOKTER:
        return [
          NavItem(
            iconPath: Assets.icons.rsDashboard.path,
            isActive: _selectedIndex == 0,
            onTap: () => _onItemTapped(0),
          ),
          // NavItem(
          //   iconPath: Assets.icons.pasien.path,
          //   isActive: _selectedIndex == 1,
          //   onTap: () => _onItemTapped(1),
          // ),
          IconButton(
            onPressed: () async {
              await SharedPreferencesUtils.deleteAuthToken();
              Get.offAllNamed(AppRoutes.login);
            },
            icon: SvgPicture.asset(Assets.icons.logOut.path),
          )
        ];
      case UserRole.APOTEKER:
        return [
          NavItem(
            iconPath: Assets.icons.rsDashboard.path,
            isActive: _selectedIndex == 0,
            onTap: () => _onItemTapped(0),
          ),
          NavItem(
            iconPath: Assets.icons.obat.path,
            isActive: _selectedIndex == 1,
            onTap: () => _onItemTapped(1),
          ),
          NavItem(
            iconPath: Assets.icons.tablerArchiveFilled.path,
            isActive: _selectedIndex == 2,
            onTap: () => _onItemTapped(2),
          ),
          NavItem(
            iconPath: Assets.icons.vaadinCart.path,
            isActive: _selectedIndex == 3,
            onTap: () => _onItemTapped(3),
          ),
          NavItem(
            iconPath: Assets.icons.transaksi.path,
            isActive: _selectedIndex == 4,
            onTap: () => _onItemTapped(4),
          ),
          // NavItem(
          //   iconPath: Assets.icons.chartPie.path,
          //   isActive: _selectedIndex == 3,
          //   onTap: () => _onItemTapped(3),
          // ),
          IconButton(
            onPressed: () async {
              await SharedPreferencesUtils.deleteAuthToken();
              Get.offAllNamed(AppRoutes.login);
            },
            icon: SvgPicture.asset(Assets.icons.logOut.path),
          )
        ];
      case UserRole.PEMILIK:
        return [
          NavItem(
            iconPath: Assets.icons.rsDashboard.path,
            isActive: _selectedIndex == 0,
            onTap: () => _onItemTapped(0),
          ),
          NavItem(
            iconPath: Assets.icons.folder.path,
            isActive: _selectedIndex == 1,
            onTap: () => _onItemTapped(1),
          ),
          NavItem(
            iconPath: Assets.icons.transaksi.path,
            isActive: _selectedIndex == 2,
            onTap: () => _onItemTapped(2),
          ),
          IconButton(
            onPressed: () async {
              await SharedPreferencesUtils.deleteAuthToken();
              Get.offAllNamed(AppRoutes.login);
            },
            icon: SvgPicture.asset(Assets.icons.logOut.path),
          )
        ];
    }
  }
}
