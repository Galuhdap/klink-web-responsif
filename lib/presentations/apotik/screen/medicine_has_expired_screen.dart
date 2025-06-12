import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:klinik_web_responsif/core/components/custom_tabel_component.dart';
import 'package:klinik_web_responsif/core/components/list_mobile_component.dart';
import 'package:klinik_web_responsif/core/config/responsive.dart';
import 'package:klinik_web_responsif/core/styles/app_colors.dart';
import 'package:klinik_web_responsif/core/styles/app_sizes.dart';
import 'package:klinik_web_responsif/presentations/apotik/controller/apotik_controller.dart';
import 'package:klinik_web_responsif/presentations/apotik/screen/mobile/meidicine_has_expired_list_mobile.dart';
import 'package:klinik_web_responsif/presentations/apotik/screen/tabel/list_has_expired_tabel.dart';
import 'package:klinik_web_responsif/presentations/menu_dashboard/widget/build_app_bar.dart';
import 'package:number_paginator/number_paginator.dart';

class MedicineHasExpiredScreen extends StatelessWidget {
  const MedicineHasExpiredScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ApotikController>(
      init: ApotikController(),
      builder: (controller) {
        // var controllerRme = Get.put(RekamMedisController());
        // var controllerApotik = Get.put(ApotikController());
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
          body: Obx(
            () {
              return ListView(
                children: [
                  Responsive.isDesktop(context)
                      ? CustomTabelComponent(
                          label: 'Obat Expired',
                          border: TableBorder.all(
                            color: AppColors.colorBaseSecondary.withAlpha(50),
                          ),
                          sizeRowTabel: MediaQuery.of(context).size.width / 1.1,
                          sizeWidth: MediaQuery.of(context).size.width / 1,
                          customContentPagination: controller
                                      .numberOfPageReportPurchase.value ==
                                  0
                              ? Container()
                              : Container(
                                  width: double.infinity,
                                  padding: AppSizes.onlyPadding(
                                      bottom: AppSizes.s50),
                                  child: Column(
                                    children: [
                                      Container(
                                        //width: 400,
                                        decoration: BoxDecoration(
                                          color: AppColors.colorBaseWhite,
                                          borderRadius: BorderRadius.circular(
                                              AppSizes.s4),
                                        ),
                                        child: Obx(() {
                                          return NumberPaginator(
                                            numberPages: controller
                                                .numberOfPageReportPurchase
                                                .value,
                                            onPageChange: (int index) {
                                              final page = index + 1;

                                              controller.getHasExpiredMedicines(
                                                page: page,
                                              );
                                            },
                                            child: const SizedBox(
                                              height: 48,
                                              width: 300,
                                              child: Row(
                                                children: [
                                                  PrevButton(),
                                                  Expanded(
                                                    child: NumberContent(),
                                                  ),
                                                  NextButton(),
                                                ],
                                              ),
                                            ),
                                          );
                                        }),
                                      ),
                                    ],
                                  ),
                                ),
                          // customContent: Container(
                          //   width: MediaQuery.of(context).size.width / 1.1,
                          //   decoration: BoxDecoration(
                          //     boxShadow: [
                          //       BoxShadow(
                          //         offset: const Offset(0, 0),
                          //         blurRadius: 15,
                          //         spreadRadius: 0,
                          //         color:
                          //             AppColors.colorNeutrals300.withAlpha(40),
                          //       ),
                          //     ],
                          //   ),
                          //   child: SearchNewComponent(
                          //     controller: controller.searchController,
                          //     keyboardType: TextInputType.name,
                          //     hintText: AppConstants.LABEL_CARI,
                          //     suffixIcon: const Icon(
                          //       Icons.search,
                          //       color: AppColors.colorSecondary500,
                          //     ),
                          //     onChanged: (value) {
                          //       final name = value.trim();
                          //       controller.getMedicine(nama_obat: name);
                          //     },
                          //   ),
                          // ),
                          listColumns: getListMedicineExpiredColumns(),
                          listRows: getRowsMedicineExpired(
                            data: controller.medicineHasExpiredList,
                            isLoading:
                                controller.isLoadingHasExpiredMedicine.value,
                            context: context,
                            controller: controller,
                          ),
                        )
                      : Column(
                          spacing: AppSizes.s30,
                          children: [
                            ListMobileContainerComponent(
                              label: 'Obat Expired',
                              height: 480,
                              children: controller
                                      .isLoadingExpiredMedicine.value
                                  ? Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  : ListView.builder(
                                      itemCount:
                                          controller.medicineExpiredList.length,
                                      itemBuilder:
                                          (BuildContext context, index) {
                                        var datas = controller
                                            .medicineExpiredList[index];
                                        return MedicineHasExpiredListMobile(
                                            datas: datas);
                                      },
                                    ),
                            ),
                          ],
                        )
                ],
              ).paddingSymmetric(
                vertical: AppSizes.s41,
                horizontal: AppSizes.s28,
              );
            },
          ),
        );
      },
    );
  }
}
