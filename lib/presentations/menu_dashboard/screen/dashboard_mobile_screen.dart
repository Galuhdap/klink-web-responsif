import 'package:flutter/material.dart';
import 'package:klinik_web_responsif/core/styles/app_colors.dart';
import 'package:klinik_web_responsif/presentations/menu_dashboard/widget/nav_item.dart';
import 'package:klinik_web_responsif/presentations/patient/screen/data_patient_page.dart';

import '../../../core/assets/assets.gen.dart';

class DashboardMobileScreen extends StatefulWidget {
  const DashboardMobileScreen({super.key});

  @override
  State<DashboardMobileScreen> createState() => _DashboardMobileScreenState();
}

class _DashboardMobileScreenState extends State<DashboardMobileScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const Center(child: Text('This is page 1')),
    const Center(child: Text('This is page 2')),
    //MasterPage(onTap: (_) {}),
    // const Center(child: Text('This is page 3')),
    const DataPatientScreen(),
    const Center(child: Text('This is page 4')),
    // const PatientSchedulePage(),
    const Center(child: Text('This is page 5')),
  ];

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
          children: [
            NavItem(
              iconPath: Assets.icons.logo.path,
              isActive: _selectedIndex == 0,
              onTap: () => _onItemTapped(0),
            ),
            NavItem(
              iconPath: Assets.icons.folderOpen.path,
              isActive: _selectedIndex == 1,
              onTap: () => _onItemTapped(1),
            ),
            NavItem(
              iconPath: Assets.icons.chartPie.path,
              isActive: _selectedIndex == 2,
              onTap: () => _onItemTapped(2),
            ),
            NavItem(
              iconPath: Assets.icons.shoppingBagProduct.path,
              isActive: _selectedIndex == 3,
              onTap: () => _onItemTapped(3),
            ),
            NavItem(
              iconPath: Assets.icons.setting.path,
              isActive: _selectedIndex == 4,
              onTap: () => _onItemTapped(4),
            ),
            NavItem(
              iconPath: Assets.icons.logOut.path,
              isActive: false,
              onTap: () {
                // context
                //     .read<LogoutBloc>()
                //     .add(const LogoutEvent.logout());
              },
            ),
          ],
        ),
      ),
    );
  }
}
