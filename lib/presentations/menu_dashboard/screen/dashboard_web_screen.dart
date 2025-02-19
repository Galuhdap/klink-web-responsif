import 'package:flutter/material.dart';
import 'package:klinik_web_responsif/core/assets/assets.gen.dart';
import 'package:klinik_web_responsif/core/styles/app_colors.dart';
import 'package:klinik_web_responsif/core/styles/app_sizes.dart';
import 'package:klinik_web_responsif/presentations/patient/screen/data_patient_page.dart';

import '../widget/nav_item.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
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
                        // BlocListener<LogoutBloc, LogoutState>(
                        //   listener: (context, state) {
                        //     state.maybeWhen(
                        //       success: () {
                        //         Navigator.pushReplacement(
                        //           context,
                        //           MaterialPageRoute(
                        //             builder: (context) => const LoginPage(),
                        //           ),
                        //         );
                        //       },
                        //       error: (message) {
                        //         ScaffoldMessenger.of(context).showSnackBar(
                        //           SnackBar(
                        //             content: Text(message),
                        //             backgroundColor: AppColors.red,
                        //           ),
                        //         );
                        //       },
                        //       orElse: () {},
                        //     );
                        //   },
                        //   child: NavItem(
                        //     iconPath: Assets.icons.logOut.path,
                        //     isActive: false,
                        //     onTap: () {
                        //       context
                        //           .read<LogoutBloc>()
                        //           .add(const LogoutEvent.logout());
                        //     },
                        //   ),
                        // ),
                      ],
                    ),
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

  void _onItemTapped(int index) {
    _selectedIndex = index;
    setState(() {});
  }
}
