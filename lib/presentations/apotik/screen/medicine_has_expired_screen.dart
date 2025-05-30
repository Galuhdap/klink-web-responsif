import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:klinik_web_responsif/core/components/custom_tabel_component.dart';
import 'package:klinik_web_responsif/core/components/list_mobile_component.dart';
import 'package:klinik_web_responsif/core/config/responsive.dart';
import 'package:klinik_web_responsif/core/styles/app_colors.dart';
import 'package:klinik_web_responsif/core/styles/app_sizes.dart';
import 'package:klinik_web_responsif/core/utils/extensions/date_ext.dart';
import 'package:klinik_web_responsif/presentations/apotik/controller/apotik_controller.dart';
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
                          ),
                        )
                      : Column(
                          spacing: AppSizes.s30,
                          children: [
                            ListMobileContainerComponent(
                              label: 'Obat Expired',
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
                                                color:
                                                    Colors.grey.withAlpha(40),
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
