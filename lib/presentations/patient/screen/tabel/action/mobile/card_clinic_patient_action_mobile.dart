import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:klinik_web_responsif/core/components/button_component.dart';
import 'package:klinik_web_responsif/core/components/input_data_component.dart';
import 'package:klinik_web_responsif/core/config/responsive.dart';
import 'package:klinik_web_responsif/core/styles/app_colors.dart';
import 'package:klinik_web_responsif/core/styles/app_sizes.dart';
import 'package:klinik_web_responsif/core/utils/extensions/sized_box_ext.dart';
import 'package:klinik_web_responsif/presentations/patient/controller/patient_controller.dart';
import 'package:klinik_web_responsif/services/pasien/model/response/get_pasien_response.dart';
import 'package:url_launcher/url_launcher.dart';

class CardClinicPatientActionMobile extends StatelessWidget {
  const CardClinicPatientActionMobile(
      {super.key, required this.datas, required this.controller});
  final ListPasien datas;
  final PatientController controller;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Text(
            'Klinik Chania Care Center',
            style: TextStyle(
              fontSize: Responsive.isMobile(context) ? 20 : 25,
              fontWeight: FontWeight.w600,
              color: AppColors.colorBaseBlack,
            ),
          ),
        ),
        Center(
          child: Text(
            'Kartu Berobat',
            style: Get.textTheme.labelMedium!
                .copyWith(fontWeight: FontWeight.bold, fontSize: AppSizes.s16),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppSizes.s12.height,
            Divider(),
            InputDataComponent(
              label: 'Nama Pasien',
              hintText: datas.name,
              controller: TextEditingController(),
              readOnly: true,
            ),
            InputDataComponent(
              label: 'No Rekam Medis',
              hintText: datas.noRekamMedis,
              controller: TextEditingController(),
              readOnly: true,
            ),
            InputDataComponent(
              label: 'Alamat',
              hintText: datas.alamat,
              controller: TextEditingController(),
              readOnly: true,
            ),
          ],
        ),
        AppSizes.s20.width,
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
                    final text = Uri.encodeComponent(
                      "🏥 🩺 *Kartu Berobat - Klinik Chania Care Center*\n\n"
                      "📌 *Nama:* ${datas.name}\n"
                      "📌 *Alamat:* ${datas.alamat}\n"
                      "📌 *No. Rekam Medis:* ${datas.noRekamMedis}\n\n"
                      "Terima kasih telah berobat di Klinik Chania Care Center. Semoga lekas sembuh! 💊\n\n"
                      "*Uji Coba!*",
                    );
                    var whatsappUrl = Uri.parse(
                        "whatsapp://send?phone=629514599817&text=$text");
                    try {
                      launchUrl(whatsappUrl);
                    } catch (e) {
                      debugPrint(e.toString());
                    }
                  },
                  label: 'Kirim Data'),
            ),
          ],
        )
      ],
    ).paddingSymmetric(horizontal: 50, vertical: AppSizes.s50);
  }
}