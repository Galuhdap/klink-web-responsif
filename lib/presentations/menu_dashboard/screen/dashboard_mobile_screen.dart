import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:klinik_web_responsif/core/resources/enum/role_user_enum.dart';
import 'package:klinik_web_responsif/core/styles/app_colors.dart';
import 'package:klinik_web_responsif/presentations/apotik/screen/obat_screen.dart';
import 'package:klinik_web_responsif/presentations/apotik/screen/riwayat_transaksi_screen.dart';
import 'package:klinik_web_responsif/presentations/apotik/screen/take_drug_screen.dart';
import 'package:klinik_web_responsif/presentations/docter/screen/docter_screen.dart';
import 'package:klinik_web_responsif/presentations/home/screen/staff/staff_screen.dart';
import 'package:klinik_web_responsif/presentations/menu_dashboard/widget/nav_item.dart';
import 'package:klinik_web_responsif/presentations/patient/screen/data_patient_page.dart';
import 'package:klinik_web_responsif/presentations/user/screen/user_manajemen_screen.dart';

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
      case UserRole.admin:
        return [
          const StaffScreen(),
          const DataPatientScreen(),
          const DocterScreen(),
        ];
      case UserRole.dokter:
        return [
          const StaffScreen(),
          //const DataAntrianPasienDocterScreen(),
        ];
      case UserRole.apotek:
        return [
          const StaffScreen(),
          const ObatScreen(),
          const TakeDrugScreen(),
          const RiwayatTransaksiScreen(),
        ];
      case UserRole.pemilik:
        return [
          const Center(child: Text('This is page 1')),
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
      case UserRole.admin:
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
          NavItem(
            iconPath: Assets.icons.doctor.path,
            isActive: _selectedIndex == 2,
            onTap: () => _onItemTapped(2),
          ),
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(Assets.icons.logOut.path),
          )
        ];
      case UserRole.dokter:
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
            onPressed: () {},
            icon: SvgPicture.asset(Assets.icons.logOut.path),
          )
        ];
      case UserRole.apotek:
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
            iconPath: Assets.icons.transaksi.path,
            isActive: _selectedIndex == 2,
            onTap: () => _onItemTapped(2),
          ),
          NavItem(
            iconPath: Assets.icons.chartPie.path,
            isActive: _selectedIndex == 3,
            onTap: () => _onItemTapped(3),
          ),
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(Assets.icons.logOut.path),
          )
        ];
      case UserRole.pemilik:
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
            onPressed: () {},
            icon: SvgPicture.asset(Assets.icons.logOut.path),
          )
        ];
    }
  }
}
