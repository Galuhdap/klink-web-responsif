import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:klinik_web_responsif/core/components/list_mobile_component.dart';
import 'package:klinik_web_responsif/core/config/responsive.dart';
import 'package:klinik_web_responsif/core/styles/app_sizes.dart';
import 'package:klinik_web_responsif/presentations/apotik/controller/apotik_controller.dart';
import 'package:klinik_web_responsif/presentations/apotik/screen/letter/validasi/add_latter_sick_validasi.dart';
import 'package:klinik_web_responsif/presentations/apotik/screen/letter/validasi/latter_healt_validasi.dart';
import 'package:klinik_web_responsif/presentations/apotik/screen/letter/validasi/latter_sick_validasi.dart';
import 'package:klinik_web_responsif/presentations/apotik/screen/letter/validasi/list_patient_letter_validsadi.dart';
import 'package:klinik_web_responsif/presentations/apotik/screen/mobile/medicine_menu_report_list_mobile.dart';
import 'package:klinik_web_responsif/presentations/apotik/widget/tab_medicine_widget.dart';
import 'package:klinik_web_responsif/presentations/home/controllers/home_controller.dart';
import 'package:klinik_web_responsif/presentations/menu_dashboard/widget/build_app_bar.dart';
import 'package:klinik_web_responsif/presentations/patient/controller/patient_controller.dart';
import 'package:klinik_web_responsif/presentations/patient/controller/rekam_medis_controller.dart';

import 'validasi/add_latter_healt_validasi.dart';

class LetterScreen extends StatelessWidget {
  const LetterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controllerPatient = Get.put(PatientController());
    var controllerHome = Get.put(HomeController());
    var controllerRme = Get.put(RekamMedisController());
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
                  isMake: controller.selectedIndexMail.value == 1
                      ? controller.isAddMailHealtView.value ||
                              controller.isAddLetterView.value
                          ? false
                          : true
                      : controller.isAddMailSickView.value ||
                              controller.isAddLetterView.value
                          ? false
                          : true,
                  labelButton: 'Tambah Surat',
                  onTapButton: () {
                    controller.showAddLetter();
                  },
                  // onTapButton: controller.selectedIndexMail.value == 1
                  //     ? () {
                  //         controller.showAddMailHealt();
                  //       }
                  //     : () {
                  //         controller.showAddMailSick();
                  //       },
                );
              },
            ),
          ),
          body: Expanded(
            child: Column(
              children: [
                Obx(() {
                  return controller.isAddMailSickView.value ||
                          controller.isAddMailHealtView.value ||
                          controller.isAddLetterView.value
                      ? Container()
                      : Padding(
                          padding: AppSizes.onlyPadding(bottom: 20),
                          child: Row(
                            children: [
                              Flexible(
                                child: TabMedicineWidget(
                                  label: 'Surat Sakit',
                                  controller: controller,
                                  index: 0,
                                  indexSelect:
                                      controller.selectedIndexMail.value.obs,
                                  onTap: () => controller.selectTabMail(0),
                                ),
                              ),
                              Flexible(
                                child: TabMedicineWidget(
                                  label: 'Surat Sehat',
                                  controller: controller,
                                  index: 1,
                                  indexSelect:
                                      controller.selectedIndexMail.value.obs,
                                  onTap: () => controller.selectTabMail(1),
                                ),
                              ),
                            ],
                          ),
                        );
                }),
                Responsive.isDesktop(context)
                    ? Obx(() {
                        return controller.isAddLetterView.value
                            ? ListPastientLatterValidation(
                                controllerPatient: controllerPatient,
                                controllerHome: controllerHome,
                                contollerApotik: controller,
                                controllerRme: controllerRme,
                                onPressed: () {
                                  controller.backToLetter();
                                },
                              )
                            : controller.selectedIndexMail.value == 0
                                ? controller.isAddMailSickView.value
                                    ? AddLetterSickValidation(
                                        controller: controller,
                                        id: controller.idLatter.value,
                                      )
                                    : LatterSickValidasi(
                                        controller: controller,
                                      )
                                : controller.isAddMailHealtView.value
                                    ? AddLetterHealtValidation(
                                        controller: controller,
                                        id: controller.idLatter.value,
                                      )
                                    : LatterHealtValidasi(
                                        controller: controller,
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
