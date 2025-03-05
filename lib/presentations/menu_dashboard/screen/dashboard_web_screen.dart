import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:klinik_web_responsif/core/assets/assets.gen.dart';
import 'package:klinik_web_responsif/core/resources/enum/role_user_enum.dart';
import 'package:klinik_web_responsif/core/styles/app_colors.dart';
import 'package:klinik_web_responsif/core/styles/app_sizes.dart';
import 'package:klinik_web_responsif/presentations/home/screen/staff/staff_screen.dart';

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
      case UserRole.admin:
        return [
          const StaffScreen(),
          const Center(
            child: Text('This is page 2'),
          ),
          const Center(
            child: Text('This is page 3'),
          )
        ];
      case UserRole.dokter:
        return [
          const Center(
            child: Text('This is page 1'),
          ),
          const Center(
            child: Text('This is page 2'),
          )
        ];
      case UserRole.apotek:
        return [
          const Center(child: Text('This is page 1')),
          const Center(child: Text('This is page 2')),
          const Center(child: Text('This is page 3')),
        ];
      case UserRole.pemilik:
        return [
          const Center(child: Text('This is page 1')),
          const Center(child: Text('This is page 2')),
          const Center(child: Text('This is page 3')),
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
                      )
                      // Column(
                      //   children: [
                      //     NavItem(
                      //       iconPath: Assets.icons.rsDashboard.path,
                      //       isActive: _selectedIndex == 0,
                      //       onTap: () => _onItemTapped(0),
                      //     ),
                      //     NavItem(
                      //       iconPath: Assets.icons.folderOpen.path,
                      //       isActive: _selectedIndex == 1,
                      //       onTap: () => _onItemTapped(1),
                      //     ),
                      //     NavItem(
                      //       iconPath: Assets.icons.chartPie.path,
                      //       isActive: _selectedIndex == 2,
                      //       onTap: () => _onItemTapped(2),
                      //     ),
                      //     NavItem(
                      //       iconPath: Assets.icons.shoppingBagProduct.path,
                      //       isActive: _selectedIndex == 3,
                      //       onTap: () => _onItemTapped(3),
                      //     ),
                      //     NavItem(
                      //       iconPath: Assets.icons.setting.path,
                      //       isActive: _selectedIndex == 4,
                      //       onTap: () => _onItemTapped(4),
                      //     ),
                      //     NavItem(
                      //       iconPath: Assets.icons.logOut.path,
                      //       isActive: false,
                      //       onTap: () {
                      //         // context
                      //         //     .read<LogoutBloc>()
                      //         //     .add(const LogoutEvent.logout());
                      //       },
                      //     ),
                      //   ],
                      // ),
                      ),
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
      case UserRole.admin:
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
              NavItem(
                iconPath: Assets.icons.doctor.path,
                isActive: _selectedIndex == 2,
                onTap: () => _onItemTapped(2),
              ),
            ],
          ),
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(Assets.icons.logOut.path),
          ).paddingOnly(
            bottom: 40,
          ),
        ];
      case UserRole.dokter:
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
            ],
          ),
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(Assets.icons.logOut.path),
          ).paddingOnly(
            bottom: 40,
          ),
        ];
      case UserRole.apotek:
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
                iconPath: Assets.icons.transaksi.path,
                isActive: _selectedIndex == 2,
                onTap: () => _onItemTapped(2),
              ),
            ],
          ),
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(Assets.icons.logOut.path),
          ).paddingOnly(
            bottom: 40,
          ),
        ];
      case UserRole.pemilik:
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
            onPressed: () {},
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
