import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:klinik_web_responsif/core/components/list_mobile_component.dart';
import 'package:klinik_web_responsif/core/config/responsive.dart';
import 'package:klinik_web_responsif/core/styles/app_sizes.dart';
import 'package:klinik_web_responsif/core/utils/extensions/sized_box_ext.dart';
import 'package:klinik_web_responsif/presentations/apotik/controller/apotik_controller.dart';
import 'package:klinik_web_responsif/presentations/apotik/screen/mobile/transaksi_buy/confirm_payment_mobile.dart';
import 'package:klinik_web_responsif/presentations/apotik/screen/mobile/transaksi_buy/header_input_transaction_mobile.dart';
import 'package:klinik_web_responsif/presentations/apotik/screen/mobile/transaksi_buy/select_detail_medicine_list_mobile.dart';
import 'package:klinik_web_responsif/presentations/apotik/screen/mobile/transaksi_buy/select_medicine_list_mobile.dart';
import 'package:klinik_web_responsif/presentations/apotik/screen/tab_menu/tab_menu_buy_screen.dart';
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
                          ? Expanded(
                              child: ListView(
                              children: [
                                HeaderInputTransactionMobile(
                                  controller: controller,
                                ),
                                AppSizes.s20.height,
                                Obx(() => ListMobileContainerComponent(
                                      label: 'Data Obat',
                                      height: 480,
                                      children: controller
                                              .isLoadingGroupStock.value
                                          ? Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            )
                                          : ListView.builder(
                                              scrollDirection: Axis.vertical,
                                              itemCount: controller
                                                  .medicineGroupStockList
                                                  .length,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      index) {
                                                var datas = controller
                                                        .medicineGroupStockList[
                                                    index];
                                                return SelectMedicineListMobile(
                                                  datas: datas,
                                                  controller: controller,
                                                );
                                              },
                                            ),
                                    )),
                                AppSizes.s20.height,
                                Obx(
                                  () => ListMobileContainerComponent(
                                    label: 'Detail Pembelian',
                                    height: 480,
                                    children: controller
                                            .isLoadingHasExpiredMedicine.value
                                        ? Center(
                                            child: CircularProgressIndicator(),
                                          )
                                        : controller
                                                .selectedMedicineList.isEmpty
                                            ? Center(
                                                child: Text(
                                                  'Silakan Memilih Obat',
                                                ),
                                              )
                                            : ListView.builder(
                                                scrollDirection: Axis.vertical,
                                                itemCount: controller
                                                    .selectedMedicineList
                                                    .length,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        index) {
                                                  var datas = controller
                                                          .selectedMedicineList[
                                                      index];
                                                  return SelectDetailMedicineListMobile(
                                                      datas: datas,
                                                      controller: controller,
                                                      index: index);
                                                },
                                              ),
                                  ),
                                ),
                                AppSizes.s20.height,
                                ListMobileContainerComponent(
                                    label: 'Lanjutkan Pembelian',
                                    height: 180,
                                    children: ConfirmPaymentMobile(
                                      controller: controller,
                                    )),
                              ],
                            ))
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
