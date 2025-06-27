import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:klinik_web_responsif/core/assets/assets.gen.dart';
import 'package:klinik_web_responsif/core/components/modal/show_modal_tanda_tanya_component.dart';
import 'package:klinik_web_responsif/core/components/show_center_dialog.dart';
import 'package:klinik_web_responsif/core/components/status_antrian_component.dart';
import 'package:klinik_web_responsif/presentations/home/controllers/home_controller.dart';
import 'package:klinik_web_responsif/services/pasien/model/response/get_antrian_pasien_response.dart';
import 'package:lottie/lottie.dart';

class QueueRoleAdminAction extends StatelessWidget {
  const QueueRoleAdminAction({
    super.key,
    required this.row,
    required this.controller,
  });

  final AntrianData row;
  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 5,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        row.status == "PROCESSING"
            ? Container()
            : InkWell(
                onTap: () {
                  showModalCenter(
                    context,
                    Obx(
                      () {
                        return controller.isPutLoading.value
                            ? Center(
                                child: SizedBox(
                                  width: 400,
                                  height: 400,
                                  child: Lottie.asset(Assets.lottie.hospital),
                                ),
                              )
                            : ShowModalTandaTanyaComponent(
                                label:
                                    'Ubah Antrian Pasien ${row.pasien.name} ke Proses ?',
                                onTapNo: () {
                                  Get.back();
                                },
                                onTapYes: () {
                                  controller.putAntrianPasien(
                                    "PROCESSING",
                                    row.id,
                                  );
                                  // controller.putAntrianPasien(
                                  //     "PROCESSING", row.id);
                                },
                              );
                      },
                    ),
                  );
                },
                child: StatusAntrianComponent(
                  status: 'PROCESSING',
                ),
              ),
        InkWell(
          onTap: () {
            showModalCenter(
              context,
              Obx(
                () {
                  return controller.isPutLoading.value
                      ? Center(
                          child: SizedBox(
                            width: 400,
                            height: 400,
                            child: Lottie.asset(Assets.lottie.hospital),
                          ),
                        )
                      : ShowModalTandaTanyaComponent(
                          label:
                              'Ubah Antrian Pasien ${row.pasien.name} ke Pending ?',
                          onTapNo: () {
                            Get.back();
                          },
                          onTapYes: () {
                            controller.putAntrianPasien(
                              "PENDING",
                              row.id,
                            );
                            //controller.putAntrianPasien("PENDING", row.id);
                          },
                        );
                },
              ),
            );
          },
          child: StatusAntrianComponent(
            status: 'PENDING',
          ),
        ),
        InkWell(
          onTap: () {
            showModalCenter(
              context,
              Obx(
                () {
                  return controller.isPutLoading.value
                      ? Center(
                          child: SizedBox(
                            width: 400,
                            height: 400,
                            child: Lottie.asset(Assets.lottie.hospital),
                          ),
                        )
                      : ShowModalTandaTanyaComponent(
                          label:
                              'Ubah Antrian Pasien ${row.pasien.name} ke Cencel ?',
                          onTapNo: () {
                            Get.back();
                          },
                          onTapYes: () {
                            controller.putAntrianPasien(
                              "CANCEL",
                              row.id,
                            );
                            // controller.putAntrianPasien("CANCEL", row.id);
                          },
                        );
                },
              ),
            );
          },
          child: StatusAntrianComponent(
            status: 'Dibatalkan',
          ),
        ),
      ],
    );
  }
}
