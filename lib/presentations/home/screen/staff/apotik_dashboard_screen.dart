import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:klinik_web_responsif/core/components/custom_tabel_component.dart';
import 'package:klinik_web_responsif/core/components/list_mobile_component.dart';
import 'package:klinik_web_responsif/core/config/responsive.dart';
import 'package:klinik_web_responsif/core/styles/app_colors.dart';
import 'package:klinik_web_responsif/core/styles/app_sizes.dart';
import 'package:klinik_web_responsif/core/utils/extensions/date_ext.dart';
import 'package:klinik_web_responsif/core/utils/extensions/sized_box_ext.dart';
import 'package:klinik_web_responsif/presentations/apotik/controller/apotik_controller.dart';
import 'package:klinik_web_responsif/presentations/apotik/screen/tabel/list_5_medicine_favorit_tabel.dart';
import 'package:klinik_web_responsif/presentations/apotik/screen/tabel/list_expired_30_days_table.dart';
import 'package:klinik_web_responsif/presentations/home/widgets/card_apotik_dashboard_widget.dart';
import 'package:klinik_web_responsif/presentations/menu_dashboard/widget/build_app_bar.dart';

class ApotikDashboardScreen extends StatelessWidget {
  const ApotikDashboardScreen({super.key});

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
            body: Obx(() {
              return ListView(children: [
                CardApotikDashbordWidget(
                  controller: controller,
                ),
                AppSizes.s30.height,
                Responsive.isDesktop(context)
                    ? Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomTabelComponent(
                            sizeWidth: MediaQuery.of(context).size.width / 1.7,
                            label: 'Obat Expired Dalam 30 Hari',
                            sizeRowTabel:
                                MediaQuery.of(context).size.width / 1.7,
                            listColumns: getListMedicineExpired30DaysColumns(),
                            listRows: getListMedicineExpired30Days(
                              data: controller.medicineExpiredList,
                              isLoading:
                                  controller.isLoadingHasExpiredMedicine.value,
                            ),
                          ),
                          CustomTabelComponent(
                            label: '5 Obat Paling Laris',
                            sizeWidth: MediaQuery.of(context).size.width / 3.8,
                            sizeRowTabel:
                                MediaQuery.of(context).size.width / 3.8,
                            listColumns: getListMedicineFiveFavoritColumns(),
                            listRows: getListMedicineFiveFavoritDays(
                                data: controller.topFiveMedicineList,
                                isLoadingExpiredMedicine:
                                    controller.isLoadingExpiredMedicine.value),
                          ),
                        ],
                      )
                    : Column(
                        spacing: AppSizes.s30,
                        children: [
                          ListMobileContainerComponent(
                            label: '5 Obat Terlaris',
                            children: controller.isLoadingExpiredMedicine.value
                                ? Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : ListView.builder(
                                    itemCount:
                                        controller.topFiveMedicineList.length,
                                    itemBuilder: (BuildContext context, index) {
                                      var datas =
                                          controller.topFiveMedicineList[index];
                                      return Container(
                                        margin: AppSizes.onlyPadding(
                                            top: AppSizes.s7),
                                        padding: AppSizes.symmetricPadding(
                                          vertical: 15,
                                          horizontal: 15,
                                        ),
                                        decoration: BoxDecoration(
                                          color: AppColors.colorBaseWhite,
                                          borderRadius: BorderRadius.circular(
                                            AppSizes.s5,
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey.withAlpha(40),
                                              spreadRadius: 0,
                                              blurRadius: 24,
                                              offset: Offset(0, 0),
                                            ),
                                          ],
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  datas.nameMedicine,
                                                  style: Get
                                                      .textTheme.labelLarge!
                                                      .copyWith(
                                                          fontSize:
                                                              AppSizes.s15,
                                                          color: AppColors
                                                              .colorBaseBlack),
                                                ),
                                              ],
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Jumlah ${datas.totalTerjual}',
                                                  style: Get
                                                      .textTheme.labelLarge!
                                                      .copyWith(
                                                          fontSize:
                                                              AppSizes.s12,
                                                          color: AppColors
                                                              .colorBaseBlack),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                          ),
                          ListMobileContainerComponent(
                            label: 'Obat Expired Dalam 30 Hari',
                            children: controller.isLoadingExpiredMedicine.value
                                ? Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : ListView.builder(
                                    itemCount:
                                        controller.medicineExpiredList.length,
                                    itemBuilder: (BuildContext context, index) {
                                      var datas =
                                          controller.medicineExpiredList[index];
                                      return Container(
                                        margin: AppSizes.onlyPadding(
                                            top: AppSizes.s7),
                                        padding: AppSizes.symmetricPadding(
                                          vertical: 15,
                                          horizontal: 15,
                                        ),
                                        decoration: BoxDecoration(
                                          color: AppColors.colorBaseWhite,
                                          borderRadius: BorderRadius.circular(
                                            AppSizes.s5,
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey.withAlpha(40),
                                              spreadRadius: 0,
                                              blurRadius: 24,
                                              offset: Offset(0, 0),
                                            ),
                                          ],
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  datas.nameMedicine,
                                                  style: Get
                                                      .textTheme.labelLarge!
                                                      .copyWith(
                                                          fontSize:
                                                              AppSizes.s15,
                                                          color: AppColors
                                                              .colorBaseBlack),
                                                ),
                                                Text(
                                                  'Stock ${datas.stock}',
                                                  style: Get
                                                      .textTheme.labelLarge!
                                                      .copyWith(
                                                          fontSize:
                                                              AppSizes.s12,
                                                          color: AppColors
                                                              .colorBaseBlack),
                                                ),
                                                Text(
                                                  datas.noBuy,
                                                  style: Get
                                                      .textTheme.labelLarge!
                                                      .copyWith(
                                                          fontSize:
                                                              AppSizes.s12,
                                                          color: AppColors
                                                              .colorBaseBlack),
                                                ),
                                              ],
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Expired ${datas.tanggalExpired.toDateddmmmyyyyFormattedString()}',
                                                  style: Get
                                                      .textTheme.labelLarge!
                                                      .copyWith(
                                                          fontSize:
                                                              AppSizes.s12,
                                                          color: AppColors
                                                              .colorBaseBlack),
                                                ),
                                                Text(
                                                  'Sisa ${datas.sisaHari}',
                                                  style: Get
                                                      .textTheme.labelLarge!
                                                      .copyWith(
                                                          fontSize:
                                                              AppSizes.s12,
                                                          color: AppColors
                                                              .colorBaseBlack),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                          ),
                        ],
                      )
              ]).paddingSymmetric(
                vertical: AppSizes.s41,
                horizontal: AppSizes.s28,
              );
            }));
      },
    );
  }
}
