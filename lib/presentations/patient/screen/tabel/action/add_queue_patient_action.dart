import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:klinik_web_responsif/core/assets/assets.gen.dart';
import 'package:klinik_web_responsif/core/components/button_component.dart';
import 'package:klinik_web_responsif/core/components/modal/show_modal_tanda_tanya_component.dart';
import 'package:klinik_web_responsif/core/styles/app_colors.dart';
import 'package:klinik_web_responsif/core/styles/app_sizes.dart';
import 'package:klinik_web_responsif/core/utils/extensions/sized_box_ext.dart';
import 'package:klinik_web_responsif/presentations/patient/controller/patient_controller.dart';
import 'package:klinik_web_responsif/services/pasien/model/response/get_pasien_response.dart';
import 'package:lottie/lottie.dart';

class AddQueuePatientAction extends StatelessWidget {
  const AddQueuePatientAction(
      {super.key,
      required this.datas,
      required this.controller,
      required this.namePasien});

  final ListPasien datas;
  final PatientController controller;
  final String namePasien;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return controller.isLoadingCreate.value
            ? Center(
                child: SizedBox(
                  width: 400,
                  height: 400,
                  child: Lottie.asset(Assets.lottie.hospital),
                ),
              )
            : controller.postPasiens.value != null
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Text(
                          'Klinik Chania Care Center',
                          style: Get.textTheme.labelLarge!.copyWith(
                            fontSize: AppSizes.s24,
                            color: AppColors.colorNeutrals700,
                          ),
                        ),
                      ),
                      Center(
                        child: Text(
                          'Dsn. Bulu Ds. Mukuh Kec. Kayen Kidul - Kediri',
                          style: Get.textTheme.labelLarge!.copyWith(
                            fontSize: AppSizes.s17,
                            color: AppColors.colorNeutrals700,
                          ),
                        ),
                      ),
                      Center(
                        child: Text(
                          '081217952437/085736701718',
                          style: Get.textTheme.labelLarge!.copyWith(
                            fontSize: AppSizes.s17,
                            color: AppColors.colorNeutrals700,
                          ),
                        ),
                      ),
                      AppSizes.s20.height,
                      Center(
                        child: Text(
                          controller.postPasiens.value!.data.nomerAntrian,
                          style: Get.textTheme.labelLarge!.copyWith(
                            fontSize: AppSizes.s100,
                            color: AppColors.colorNeutrals900,
                          ),
                        ),
                      ),
                      AppSizes.s20.height,
                      Center(
                        child: Text(
                          namePasien,
                          style: Get.textTheme.labelLarge!.copyWith(
                            fontSize: AppSizes.s20,
                            color: AppColors.colorNeutrals700,
                          ),
                        ),
                      ),
                      AppSizes.s20.height,
                      // Container(
                      //   width: 200,
                      //   height: 200,
                      //   decoration: BoxDecoration(
                      //       borderRadius: BorderRadius.circular(AppSizes.s100),
                      //       color: AppColors.colorBasePrimary),
                      //   child: Center(
                      //     child: Text(
                      //       controller.postPasiens.value!.data.nomerAntrian,
                      //       style: Get.textTheme.labelLarge!.copyWith(
                      //         fontSize: AppSizes.s100,
                      //         color: AppColors.colorBaseWhite,
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      Center(
                        child: Text(
                          'Nomor Antrian Ditambahkan',
                          style: Get.textTheme.labelLarge!.copyWith(
                            fontSize: AppSizes.s24,
                            color: AppColors.colorNeutrals700,
                          ),
                        ),
                      ),
                      AppSizes.s20.height,
                      Center(
                        child: Button.filled(
                          onPressed: () {
                            controller.postPasiens.value = null;

                            Get.back();
                            Get.back();
                          },
                          label: 'Selesai',
                        ).paddingSymmetric(
                          horizontal: AppSizes.s300,
                        ),
                      ),
                    ],
                  )
                : ShowModalTandaTanyaComponent(
                    label:
                        'Apakah anda yakin ingin menambahkan ${datas.name} ke antrian ?',
                    onTapNo: () {
                      Get.back();
                    },
                    onTapYes: () {
                      controller.postAntrianPasien(datas.id);
                    },
                  );
      },
    );
  }
}
