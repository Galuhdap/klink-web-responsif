import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:klinik_web_responsif/core/assets/assets.gen.dart';
import 'package:klinik_web_responsif/core/components/button_component.dart';
import 'package:klinik_web_responsif/core/components/custom_tabel_component.dart';
import 'package:klinik_web_responsif/core/components/input_data_component.dart';
import 'package:klinik_web_responsif/core/components/list_mobile_component.dart';
import 'package:klinik_web_responsif/core/components/search_new_component.dart';
import 'package:klinik_web_responsif/core/components/show_center_dialog.dart';
import 'package:klinik_web_responsif/core/config/responsive.dart';
import 'package:klinik_web_responsif/core/resources/constans/app_constants.dart';
import 'package:klinik_web_responsif/core/styles/app_colors.dart';
import 'package:klinik_web_responsif/core/styles/app_sizes.dart';
import 'package:klinik_web_responsif/core/utils/extensions/sized_box_ext.dart';
import 'package:klinik_web_responsif/core/utils/helpers/validation_helper.dart';
import 'package:klinik_web_responsif/presentations/apotik/controller/apotik_controller.dart';
import 'package:klinik_web_responsif/presentations/apotik/screen/mobile/medicine_list_mobile.dart';
import 'package:klinik_web_responsif/presentations/apotik/screen/tabel/list_medicine_tabel.dart';
import 'package:klinik_web_responsif/presentations/menu_dashboard/widget/build_app_bar.dart';
import 'package:lottie/lottie.dart';
import 'package:number_paginator/number_paginator.dart';

class MedicineScreen extends StatelessWidget {
  const MedicineScreen({super.key});

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
              isMake: true,
              labelButton: 'Tambah Obat',
              onTapButton: () {
                showModalCenter(
                  context,
                  Obx(
                    () {
                      return controller.isLoadingPostNewMedicine.value
                          ? Center(
                              child: SizedBox(
                                width: 400,
                                height: 400,
                                child: Lottie.asset(Assets.lottie.hospital),
                              ),
                            )
                          : Form(
                              key: controller.formKeyNewPost,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Center(
                                    child: Text(
                                      'Tambah Obat',
                                      style: Get.textTheme.labelMedium!
                                          .copyWith(
                                              fontWeight: FontWeight.bold,
                                              fontSize: AppSizes.s16),
                                    ),
                                  ),
                                  AppSizes.s12.height,
                                  Divider(),
                                  InputDataComponent(
                                    label: 'Nama Obat',
                                    hintText: 'Nama Obat',
                                    controller:
                                        controller.nameMedicineController,
                                    validator: emptyValidation,
                                  ),
                                  // InputDataComponent(
                                  //   label: 'Harga Beli',
                                  //   hintText: 'Harga Beli',
                                  //   controller: controller.priceBuyController,
                                  // ),
                                  InputDataComponent(
                                    label: 'Harga Jual',
                                    hintText: 'Harga Jual',
                                    controller: controller.priceSellController,
                                    validator: emptyValidation,
                                  ),
                                  Row(
                                    children: [
                                      Flexible(
                                        child: Button.outlined(
                                            onPressed: () {
                                              Get.back();
                                            },
                                            label: 'Batal'),
                                      ),
                                      AppSizes.s12.width,
                                      Flexible(
                                        child: Button.filled(
                                            onPressed: () async {
                                              if (controller
                                                  .formKeyNewPost.currentState!
                                                  .validate()) {
                                                controller.postNewMedicine();
                                              }
                                            },
                                            label: 'Simpan'),
                                      ),
                                    ],
                                  )
                                ],
                              ).paddingSymmetric(horizontal: AppSizes.s100),
                            );
                    },
                  ),
                );
              },
            ),
          ),
          body: Obx(
            () {
              return ListView(
                physics: NeverScrollableScrollPhysics(),
                children: [
                  Responsive.isDesktop(context)
                      ? CustomTabelComponent(
                          label: 'Data Obat',
                          sizeRowTabel: MediaQuery.of(context).size.width / 1.1,
                          sizeWidth: MediaQuery.of(context).size.width / 1,
                          border: TableBorder.all(
                            color: AppColors.colorBaseSecondary.withAlpha(50),
                          ),
                          customContentPagination:
                              controller.numberOfPageNewMedicine.value == 0
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
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      AppSizes.s4),
                                            ),
                                            child: Obx(() {
                                              return NumberPaginator(
                                                numberPages: controller
                                                    .numberOfPageNewMedicine
                                                    .value,
                                                onPageChange: (int index) {
                                                  final page = index + 1;

                                                  controller.getNewMedicine(
                                                      page: page,
                                                      name_medicine: controller
                                                          .nameMedicineNew
                                                          .value);
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
                          customContent: Container(
                            width: MediaQuery.of(context).size.width / 1.1,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  offset: const Offset(0, 0),
                                  blurRadius: 15,
                                  spreadRadius: 0,
                                  color:
                                      AppColors.colorNeutrals300.withAlpha(40),
                                ),
                              ],
                            ),
                            child: SearchNewComponent(
                              controller: controller.searchController,
                              keyboardType: TextInputType.name,
                              hintText: AppConstants.LABEL_CARI,
                              suffixIcon: const Icon(
                                Icons.search,
                                color: AppColors.colorSecondary500,
                              ),
                              onChanged: (value) {
                                final name = value.trim();
                                controller.nameMedicineNew.value = name;
                                controller.getNewMedicine(name_medicine: name);
                              },
                            ),
                          ),
                          listColumns: getListMedicineColumns(),
                          listRows: getRowsMedicine(
                            context: context,
                            controller: controller,
                            data: controller.medicineNewList,
                            isLoading:
                                controller.isLoadingHasExpiredMedicine.value,
                          ),
                        )
                      : ListMobileContainerComponent(
                          label: 'Data Obat',
                          height: 480,
                          children: controller.isLoadingExpiredMedicine.value
                              ? Center(
                                  child: CircularProgressIndicator(),
                                )
                              : ListView.builder(
                                  itemCount: controller.medicineNewList.length,
                                  itemBuilder: (BuildContext context, index) {
                                    var datas =
                                        controller.medicineNewList[index];
                                    return MedicineListMobile(
                                      datas: datas,
                                      controller: controller,
                                    );
                                  },
                                ),
                        ),
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
