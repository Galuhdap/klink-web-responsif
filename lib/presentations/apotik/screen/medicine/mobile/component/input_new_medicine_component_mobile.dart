import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:klinik_web_responsif/core/components/list_mobile_component.dart';
import 'package:klinik_web_responsif/core/styles/app_sizes.dart';
import 'package:klinik_web_responsif/core/utils/extensions/sized_box_ext.dart';
import 'package:klinik_web_responsif/presentations/apotik/controller/apotik_controller.dart';
import 'package:klinik_web_responsif/presentations/apotik/screen/medicine/component/widget/header_input_medicine_widget.dart';
import 'package:klinik_web_responsif/presentations/apotik/screen/medicine/mobile/content_choose_unit_medicine_mobile.dart';
import 'package:klinik_web_responsif/presentations/apotik/screen/medicine/mobile/detail_content_unit_medicine_mobile.dart';

class InputNewMedicineComponentMobile extends StatelessWidget {
  const InputNewMedicineComponentMobile({super.key, required this.controller});

  final ApotikController controller;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          HeaderInputMedicineWidget(
            controller: controller,
            id: controller.idMedicine.value,
          ),
          AppSizes.s20.height,
          Obx(
            () {
              return controller.isLightOn.value
                  ? Column(
                      children: [
                        ListMobileContainerComponent(
                          label: 'Pilih Satuan Turunan Obat',
                          height: 480,
                          children: controller.isLoadingUnit.value
                              ? Center(
                                  child: CircularProgressIndicator(),
                                )
                              : controller.unitList.isEmpty
                                  ? Center(
                                      child: Text('Data Kosong'),
                                    )
                                  : ListView.builder(
                                      scrollDirection: Axis.vertical,
                                      itemCount: controller.unitList.length,
                                      itemBuilder:
                                          (BuildContext context, index) {
                                        var datas = controller.unitList[index];
                                        return ContentUnitChooseMedicineMobile(
                                          datas: datas,
                                          controller: controller,
                                        );
                                      },
                                    ),
                        ),
                        AppSizes.s20.height,
                        ListMobileContainerComponent(
                          label: 'Detail Pilihan Satuan Turunan Obat',
                          height: 480,
                          children: controller.isLoadingHasExpiredMedicine.value
                              ? Center(
                                  child: CircularProgressIndicator(),
                                )
                              : controller.selectedMedicineListUnit.isEmpty
                                  ? Center(
                                      child: Text('Data Kosong'),
                                    )
                                  : ListView.builder(
                                      scrollDirection: Axis.vertical,
                                      itemCount: controller
                                          .selectedMedicineListUnit.length,
                                      itemBuilder:
                                          (BuildContext context, index) {
                                        var datas = controller
                                            .selectedMedicineListUnit[index];
                                        return DetailContentUnitMedicineMobile(
                                          datas: datas,
                                          controller: controller,
                                          index: index,
                                        );
                                      },
                                    ),
                        ),
                      ],
                    )
                  : Container();
            },
          ),
          // ContentChooseUnitMedicineWidget(controller: controller)
        ],
      ),
    );
  }
}
