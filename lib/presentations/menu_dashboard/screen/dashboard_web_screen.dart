import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:klinik_web_responsif/core/assets/assets.gen.dart';
import 'package:klinik_web_responsif/core/resources/enum/role_user_enum.dart';
import 'package:klinik_web_responsif/core/styles/app_colors.dart';
import 'package:klinik_web_responsif/core/styles/app_sizes.dart';
import 'package:klinik_web_responsif/core/utils/preferences/shared_preferences_utils.dart';
import 'package:klinik_web_responsif/presentations/apotik/screen/medicine_has_expired_screen.dart';
import 'package:klinik_web_responsif/presentations/apotik/screen/medicine/medicine_screen.dart';
import 'package:klinik_web_responsif/presentations/apotik/screen/menu_report_screen.dart';
import 'package:klinik_web_responsif/presentations/apotik/screen/menu_transaksi_screen.dart';
import 'package:klinik_web_responsif/presentations/apotik/screen/riwayat_transaksi_screen.dart';
import 'package:klinik_web_responsif/presentations/home/controllers/home_controller.dart';
import 'package:klinik_web_responsif/presentations/home/screen/stackholder/stackholder_screen.dart';
import 'package:klinik_web_responsif/presentations/home/screen/staff/apotik_dashboard_screen.dart';
import 'package:klinik_web_responsif/presentations/home/screen/staff/queue_screen.dart';
import 'package:klinik_web_responsif/presentations/patient/screen/patient_screen.dart';
import 'package:klinik_web_responsif/presentations/user/screen/user_manajemen_screen.dart';
import 'package:klinik_web_responsif/routes/app_routes.dart';

import '../widget/nav_item.dart';

class DashboardScreen extends StatefulWidget {
  final UserRole userRole;
  const DashboardScreen({super.key, required this.userRole});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;

  List<Widget> get _pages {
    switch (widget.userRole) {
      case UserRole.ADMIN:
        return [
          const QueueScreen(),
          const PatientScreen(),
         // const DataPatientScreen(),
          // const DocterScreen(),
        ];
      case UserRole.DOKTER:
        return [
          const QueueScreen(),
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Row(
          children: [
            SingleChildScrollView(
              child: ClipRRect(
                borderRadius:
                    const BorderRadius.horizontal(right: Radius.circular(16.0)),
                child: SizedBox(
                  height: AppSizes.setResponsiveHeight(context),
                  //height: context.d - 20.0,
                  child: ColoredBox(
                      color: AppColors.colorBasePrimary,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: _buildNavItems(),
                      )),
                ),
              ),
            ),
            Expanded(
              child: _pages[_selectedIndex],
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildNavItems() {
    switch (widget.userRole) {
      case UserRole.ADMIN:
        return [
          Column(
            children: [
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
            ],
          ),
          IconButton(
            onPressed: () async {
              await SharedPreferencesUtils.deleteAuthToken();
              Get.offAllNamed(AppRoutes.login);
            },
            icon: SvgPicture.asset(Assets.icons.logOut.path),
          ).paddingOnly(
            bottom: 40,
          ),
        ];
      case UserRole.DOKTER:
        return [
          Column(
            children: [
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
            ],
          ),
          IconButton(
            onPressed: () async {
              await SharedPreferencesUtils.deleteAuthToken();
              Get.delete<HomeController>();
              Get.offAllNamed(AppRoutes.login);
            },
            icon: SvgPicture.asset(Assets.icons.logOut.path),
          ).paddingOnly(
            bottom: 40,
          ),
        ];
      case UserRole.APOTEKER:
        return [
          Column(
            children: [
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
            ],
          ),
          IconButton(
            onPressed: () async {
              await SharedPreferencesUtils.deleteAuthToken();
              Get.offAllNamed(AppRoutes.login);
            },
            icon: SvgPicture.asset(Assets.icons.logOut.path),
          ).paddingOnly(
            bottom: 40,
          ),
        ];
      case UserRole.PEMILIK:
        return [
          Column(
            children: [
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
            ],
          ),
          IconButton(
            onPressed: () async {
              await SharedPreferencesUtils.deleteAuthToken();
              Get.offAllNamed(AppRoutes.login);
            },
            icon: SvgPicture.asset(Assets.icons.logOut.path),
          ).paddingOnly(
            bottom: 40,
          ),
        ];
    }
  }

  void _onItemTapped(int index) {
    _selectedIndex = index;
    setState(() {});
  }
}
