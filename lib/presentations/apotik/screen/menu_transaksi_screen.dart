import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:klinik_web_responsif/core/config/responsive.dart';
import 'package:klinik_web_responsif/core/styles/app_sizes.dart';
import 'package:klinik_web_responsif/core/utils/extensions/sized_box_ext.dart';
import 'package:klinik_web_responsif/presentations/apotik/controller/apotik_controller.dart';
import 'package:klinik_web_responsif/presentations/apotik/screen/tab_menu/tab_menu_buy_screen.dart';
import 'package:klinik_web_responsif/presentations/apotik/widget/tab_transaksi_widget.dart';
import 'package:klinik_web_responsif/presentations/menu_dashboard/widget/build_app_bar.dart';

class MenuTransaksiScreen extends StatelessWidget {
  const MenuTransaksiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ApotikController>(
      init: ApotikController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: Color(0xfffF8F8F8),
          appBar: PreferredSize(
            preferredSize: Responsive.isMobile(context)
                ? Size.fromHeight(90.0)
                : Size.fromHeight(110.0),
            child: BuildAppBar(
              title: 'Klinik Chania Care Center',
              withSearchInput: true,
              searchController: TextEditingController(),
              searchHint: 'Cari Pasien',
              searchChanged: (_) {},
            ),
          ),
          body: Column(
            children: [
              Row(
                children: [
                  Flexible(
                    child: TabTransaksiWidget(
                      label: 'Pembelian',
                      controller: controller,
                      index: 0,
                      onTap: () => controller.selectTab(0),
                    ),
                  ),
                  Flexible(
                    child: TabTransaksiWidget(
                      label: 'Penjualan',
                      controller: controller,
                      index: 1,
                      onTap: () => controller.selectTab(1),
                    ),
                  ),
                ],
              ),
              AppSizes.s20.height,
              Responsive.isDesktop(context)
                  ? Obx(() {
                      return controller.selectedIndex.value == 0
                          ? TabMenuBuyScreen(
                              controller: controller,
                            )
                          : Center(
                              child: Text('Penjualan'),
                            );
                    })
                  : Obx(() {
                      return controller.selectedIndex.value == 0
                          ? Center(
                              child: Text('Pembelian'),
                            )
                          : Center(
                              child: Text('Penjualan'),
                            );
                    })
            ],
          ).paddingSymmetric(
            vertical: AppSizes.s41,
            horizontal: AppSizes.s28,
          ),
        );
      },
    );
  }
}
