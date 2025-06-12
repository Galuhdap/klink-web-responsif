import 'package:flutter/material.dart';
import 'package:klinik_web_responsif/core/styles/app_sizes.dart';
import 'package:klinik_web_responsif/core/utils/extensions/sized_box_ext.dart';
import 'package:klinik_web_responsif/presentations/apotik/controller/apotik_controller.dart';
import 'package:klinik_web_responsif/presentations/apotik/screen/medicine/component/widget/content_choose_unit_medicine_widget.dart';
import 'package:klinik_web_responsif/presentations/apotik/screen/medicine/component/widget/header_input_medicine_widget.dart';

class InputNewMedicineComponent extends StatelessWidget {
  const InputNewMedicineComponent({
    super.key,
    required this.controller,
  });

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
          ContentChooseUnitMedicineWidget(controller: controller)
        ],
      ),
    );
  }
}
