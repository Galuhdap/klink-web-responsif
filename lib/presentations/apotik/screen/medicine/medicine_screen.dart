import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:klinik_web_responsif/core/components/list_mobile_component.dart';
import 'package:klinik_web_responsif/core/config/responsive.dart';
import 'package:klinik_web_responsif/core/styles/app_sizes.dart';
import 'package:klinik_web_responsif/core/utils/extensions/sized_box_ext.dart';
import 'package:klinik_web_responsif/presentations/apotik/controller/apotik_controller.dart';
import 'package:klinik_web_responsif/presentations/apotik/screen/medicine/component/input_new_medicine_component.dart';
import 'package:klinik_web_responsif/presentations/apotik/screen/medicine/component/input_unit_medicine_component.dart';
import 'package:klinik_web_responsif/presentations/apotik/screen/medicine/component/widget/data_medicne_tabel_widget.dart';
import 'package:klinik_web_responsif/presentations/apotik/screen/medicine/component/widget/data_unit_medicine_tabel_widget.dart';
import 'package:klinik_web_responsif/presentations/apotik/screen/medicine/mobile/component/input_new_medicine_component_mobile.dart';
import 'package:klinik_web_responsif/presentations/apotik/screen/medicine/mobile/component/input_unit_new_medicine_component.dart';
import 'package:klinik_web_responsif/presentations/apotik/screen/mobile/medicine_list_mobile.dart';
import 'package:klinik_web_responsif/presentations/apotik/screen/mobile/unit_medicine_list_mobile.dart';
import 'package:klinik_web_responsif/presentations/apotik/widget/tab_medicine_widget.dart';
import 'package:klinik_web_responsif/presentations/menu_dashboard/widget/build_app_bar.dart';

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
            child: Obx(
              () {
                return BuildAppBar(
                  title: 'Klinik Chania Care Center',
                  withSearchInput: true,
                  searchController: TextEditingController(),
                  searchHint: 'Cari Pasien',
                  searchChanged: (_) {},
                  isMake: controller.selectedIndexMedicine.value == 1
                      ? controller.isAddUnitMedicineView.value ||
                              controller.isEditUnitMedicineView.value
                          ? false
                          : true
                      : controller.isAddMedicineView.value ||
                              controller.isEditMedicineView.value
                          ? false
                          : true,
                  labelButton: controller.selectedIndexMedicine.value == 1
                      ? 'Tambah Satuan'
                      : 'Tambah Obat',
                  onTapButton: controller.selectedIndexMedicine.value == 1
                      ? () {
                          controller.showAddUnitMedicine();
                        }
                      : () {
                          controller.showAddMedicine();
                        },
                );
              },
            ),
          ),
          body: Obx(
            () {
              return ListView(
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: TabMedicineWidget(
                            label: 'Data Obat',
                            controller: controller,
                            index: 0,
                            indexSelect:
                                controller.selectedIndexMedicine.value.obs,
                            onTap: () {
                              controller.backToEditUnitMedicine();
                              controller.backToAddUnitMedicine();
                              controller.selectTabMedicine(0);
                            }),
                      ),
                      Flexible(
                        child: TabMedicineWidget(
                            label: 'Satuan Obat',
                            controller: controller,
                            index: 1,
                            indexSelect:
                                controller.selectedIndexMedicine.value.obs,
                            onTap: () {
                              controller.backToEditMedicine();
                              controller.backToAddMedicine();
                              controller.selectTabMedicine(1);
                            }),
                      ),
                    ],
                  ),
                  AppSizes.s25.height,
                  Responsive.isDesktop(context)
                      ? controller.selectedIndexMedicine.value == 0
                          ? controller.isAddMedicineView.value
                              ? InputNewMedicineComponent(
                                  controller: controller,
                                )
                              : controller.isEditMedicineView.value
                                  ? InputNewMedicineComponent(
                                      controller: controller,
                                    )
                                  : DataMedicineTableWidget(
                                      controller: controller,
                                    )
                          : controller.isAddUnitMedicineView.value
                              ? InputUnitMedicineComponent(
                                  controller: controller,
                                  id: controller.idUnitMedicine.value,
                                )
                              : controller.isEditUnitMedicineView.value
                                  ? InputUnitMedicineComponent(
                                      controller: controller,
                                      id: controller.idUnitMedicine.value,
                                    )
                                  : DataUnitMedicineTableWidget(
                                      controller: controller)
                      : controller.selectedIndexMedicine.value == 0
                          ? controller.isAddMedicineView.value
                              ? InputNewMedicineComponentMobile(
                                  controller: controller,
                                )
                              : controller.isEditMedicineView.value
                                  ? InputNewMedicineComponentMobile(
                                      controller: controller,
                                    )
                                  : ListMobileContainerComponent(
                                      label: 'Data Obat',
                                      height: 480,
                                      labelButton: 'Tambah Obat',
                                      onTap: () {
                                        controller.showAddMedicine();
                                      },
                                      children: controller
                                              .isLoadingExpiredMedicine.value
                                          ? Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            )
                                          : controller.medicineNewList.isEmpty
                                              ? Center(
                                                  child:
                                                      Text('Data Masih Kosong'),
                                                )
                                              : ListView.builder(
                                                  itemCount: controller
                                                      .medicineNewList.length,
                                                  itemBuilder:
                                                      (BuildContext context,
                                                          index) {
                                                    var datas = controller
                                                        .medicineNewList[index];
                                                    return MedicineListMobile(
                                                      datas: datas,
                                                      controller: controller,
                                                    );
                                                  },
                                                ),
                                    )
                          : controller.isAddUnitMedicineView.value
                              ? InputUnitNewMedicineComponent(
                                  controller: controller,
                                  id: controller.idUnitMedicine.value,
                                )
                              : controller.isEditUnitMedicineView.value
                                  ? InputUnitNewMedicineComponent(
                                      controller: controller,
                                      id: controller.idUnitMedicine.value,
                                    )
                                  : ListMobileContainerComponent(
                                      label: 'Satuan Obat',
                                      height: 480,
                                      labelButton: 'Tambah Satuan Obat',
                                      onTap: () {
                                        controller.showAddUnitMedicine();
                                      },
                                      children: controller
                                              .isLoadingExpiredMedicine.value
                                          ? Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            )
                                          : controller.unitList.isEmpty
                                              ? Center(
                                                  child:
                                                      Text('Data Masih Kosong'),
                                                )
                                              : ListView.builder(
                                                  itemCount: controller
                                                      .unitList.length,
                                                  itemBuilder:
                                                      (BuildContext context,
                                                          index) {
                                                    var datas = controller
                                                        .unitList[index];
                                                    return UnitMedicineListMobile(
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
