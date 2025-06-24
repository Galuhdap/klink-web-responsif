import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:klinik_web_responsif/core/components/list_mobile_component.dart';
import 'package:klinik_web_responsif/core/config/responsive.dart';
import 'package:klinik_web_responsif/core/styles/app_sizes.dart';
import 'package:klinik_web_responsif/core/utils/extensions/sized_box_ext.dart';
import 'package:klinik_web_responsif/presentations/apotik/controller/apotik_controller.dart';
import 'package:klinik_web_responsif/presentations/apotik/screen/mobile/medicine_menu_report_list_mobile.dart';
import 'package:klinik_web_responsif/presentations/apotik/screen/report/graph_report_screen.dart';
import 'package:klinik_web_responsif/presentations/apotik/screen/report/validasi/detail_buy_validasi.dart';
import 'package:klinik_web_responsif/presentations/apotik/screen/report/validasi/detail_sell_validasi.dart';
import 'package:klinik_web_responsif/presentations/apotik/screen/report/validasi/report_buy_validasi.dart';
import 'package:klinik_web_responsif/presentations/apotik/screen/report/validasi/report_in_out_medicine_validasi.dart';
import 'package:klinik_web_responsif/presentations/apotik/screen/report/validasi/report_transaksi_sell_validasi.dart';
import 'package:klinik_web_responsif/presentations/apotik/widget/tab_medicine_widget.dart';
import 'package:klinik_web_responsif/presentations/menu_dashboard/widget/build_app_bar.dart';
import 'package:klinik_web_responsif/presentations/report/controller/report_controller.dart';

class MenuReportScreen extends StatelessWidget {
  const MenuReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controllerReport = Get.put(ReportController());
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
          body: Expanded(
            child: Column(
              children: [
                Obx(
                  () {
                    return Row(
                      children: [
                        Flexible(
                          child: TabMedicineWidget(
                            label: 'Grafik Laporan',
                            controller: controller,
                            index: 0,
                            indexSelect:
                                controller.selectedIndexReport.value.obs,
                            onTap: () => controller.selectTabReport(0),
                          ),
                        ),
                        Flexible(
                          child: TabMedicineWidget(
                            label: 'Pembelian',
                            controller: controller,
                            index: 1,
                            indexSelect:
                                controller.selectedIndexReport.value.obs,
                            onTap: () => controller.selectTabReport(1),
                          ),
                        ),
                        Flexible(
                          child: TabMedicineWidget(
                            label: 'Penjualan',
                            controller: controller,
                            index: 2,
                            indexSelect:
                                controller.selectedIndexReport.value.obs,
                            onTap: () => controller.selectTabReport(2),
                          ),
                        ),
                        // Obx(() {
                        //   return controller.role.value == "PEMILIK"
                        //       ? Flexible(
                        //           child: TabMedicineWidget(
                        //             label: 'Biaya Dokter',
                        //             controller: controller,
                        //             index: 4,
                        //             indexSelect:
                        //                 controller.selectedIndexReport.value.obs,
                        //             onTap: () => controller.selectTabReport(4),
                        //           ),
                        //         )
                        //       : Container();
                        // })
                      ],
                    );
                  },
                ),
                AppSizes.s20.height,
                Responsive.isDesktop(context)
                    ? Obx(() {
                        return controller.selectedIndexReport.value == 0
                            ? Flexible(
                                child: GraphReportWidget(
                                  controller: controller,
                                  controllerReport: controllerReport,
                                ),
                              )
                            : controller.selectedIndexReport.value == 1
                                ? controller.isDetailView.value
                                    ? DetailBuyValidasi(
                                        controller: controller,
                                      )
                                    : Expanded(
                                        child: ListView(
                                          children: [
                                            ReportBuyValidasi(
                                              controller: controller,
                                              controllerReport:
                                                  controllerReport,
                                              owner: true,
                                            ),
                                          ],
                                        ),
                                      )
                                : controller.selectedIndexReport.value == 2
                                    ? controller.isDetailSellView.value
                                        ? DetailSellValidasi(
                                            controller: controller,
                                          )
                                        : ReportTransactionSellValidasi(
                                            controller: controller,
                                          )
                                    : controller.selectedIndexReport.value == 3
                                        ? ReportInOutMedicineValidasi(
                                            controller: controller,
                                          )
                                        : Center(
                                            child: Text("data"),
                                          );
                      })
                    : Obx(() {
                        return controller.selectedIndexReport.value == 0
                            ? ListMobileContainerComponent(
                                label: 'Laporan Pembelian',
                                height: 480,
                                children:
                                    controller.isLoadingReportPurchase.value
                                        ? Center(
                                            child: CircularProgressIndicator(),
                                          )
                                        : ListView.builder(
                                            itemCount: controller
                                                .reportPurchaseMedicineList
                                                .length,
                                            itemBuilder:
                                                (BuildContext context, index) {
                                              var datas = controller
                                                      .reportPurchaseMedicineList[
                                                  index];
                                              return MedicineMenuReportListMobile(
                                                  datas: datas);
                                            },
                                          ),
                              )
                            : controller.selectedIndexReport.value == 1
                                ? Center(
                                    child: Text('Penjualan'),
                                  )
                                : Center(
                                    child: Text('StockObat'),
                                  );
                      })
              ],
            ).paddingSymmetric(
              vertical: AppSizes.s41,
              horizontal: AppSizes.s28,
            ),
          ),
        );
      },
    );
  }
}
