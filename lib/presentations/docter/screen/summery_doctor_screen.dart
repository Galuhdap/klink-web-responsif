import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:klinik_web_responsif/core/components/card_dashboard_component.dart';
import 'package:klinik_web_responsif/core/config/responsive.dart';
import 'package:klinik_web_responsif/core/styles/app_sizes.dart';
import 'package:klinik_web_responsif/core/utils/extensions/int_ext.dart';
import 'package:klinik_web_responsif/core/utils/extensions/sized_box_ext.dart';
import 'package:klinik_web_responsif/presentations/docter/controller/docter_controller.dart';
import 'package:klinik_web_responsif/presentations/menu_dashboard/widget/build_app_bar.dart';

class SummeryDoctorScreen extends StatelessWidget {
  const SummeryDoctorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DocterController>(
      init: DocterController(),
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
              return Expanded(
                child: ListView(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      spacing: AppSizes.s16,
                      children: [
                        Flexible(
                          child: CardDashbordComponent(
                            title: 'Total Fee Dokter',
                            count: controller.isLoadingSummary.value
                                ? 'Load....'
                                : controller.getSummaryDoctor.value!.data
                                            .totalFeeDokter ==
                                        0
                                    ? 0.currencyFormatRp
                                    : controller.getSummaryDoctor.value!.data
                                        .totalFeeDokter.currencyFormatRp,
                          ),
                        ),
                        Flexible(
                          child: CardDashbordComponent(
                            title: 'Total Pasien Di Periksa',
                            changeIcon: false,
                            iconSaxChange: Iconsax.dollar_circle4,
                            count: controller.isLoadingSummary.value
                                ? 'Load....'
                                : controller.getSummaryDoctor.value!.data
                                            .totalPasienDiperiksa ==
                                        ''
                                    ? ''
                                    : controller.getSummaryDoctor.value!.data
                                        .totalPasienDiperiksa
                                        .toString(),
                          ),
                        ),
                      ],
                    ),
                    AppSizes.s20.height,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      spacing: AppSizes.s16,
                      children: [
                        Flexible(
                            child: CardDashbordComponent(
                          title: 'Fee Dokter Hari Ini',
                          count: controller.isLoadingSummary.value
                              ? 'Load....'
                              : controller.getSummaryDoctor.value!.data
                                          .totalFeeDokterHariIni ==
                                      0
                                  ? 0.currencyFormatRp
                                  : controller.getSummaryDoctor.value!.data
                                      .totalFeeDokterHariIni.currencyFormatRp,
                        )),
                        Flexible(
                          child: CardDashbordComponent(
                              title: 'Total Pasien Di Periksa Hari Ini',
                              changeIcon: false,
                              iconSaxChange: Iconsax.dollar_circle4,
                              count: controller.isLoadingSummary.value
                                  ? 'Load....'
                                  : controller.getSummaryDoctor.value!.data
                                              .totalPasienHariIni ==
                                          ''
                                      ? ''
                                      : controller.getSummaryDoctor.value!.data
                                          .totalPasienHariIni
                                          .toString()),
                        ),
                      ],
                    ),
                    AppSizes.s20.height,
                  ],
                ).paddingSymmetric(
                  vertical: AppSizes.s41,
                  horizontal: AppSizes.s28,
                ),
              );
            },
          ),
        );
      },
    );
  }
}
