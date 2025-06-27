import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:klinik_web_responsif/core/styles/app_colors.dart';
import 'package:klinik_web_responsif/core/styles/app_sizes.dart';
import 'package:klinik_web_responsif/presentations/patient/controller/rekam_medis_controller.dart';
import 'package:klinik_web_responsif/presentations/pdf/letter_rme_pdf.dart';
import 'package:klinik_web_responsif/services/doctor/model/response/get_letter_rme_response.dart';
import 'package:printing/printing.dart';


class PdfPriviewLetterRme extends StatelessWidget {
  final DatumLetterRme datas;
  const PdfPriviewLetterRme({super.key, required this.datas});

  @override
  Widget build(BuildContext context) {

    RekamMedisController controller = Get.put(RekamMedisController());
    PdfLetterRme pdfLetterRme = PdfLetterRme();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.colorBasePrimary,
        title: Text(
          'Surat Rekam Medis',
          style: Get.textTheme.labelMedium!.copyWith(
              fontSize: AppSizes.s20,
              fontWeight: FontWeight.bold,
              color: AppColors.colorBaseWhite),
        ),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Iconsax.arrow_left_2,
            color: AppColors.colorBaseWhite,
          ),
        ),
      ),
      body: PdfPreview(
        build: (context) => pdfLetterRme.generate(datas, controller.rmePasientList),
        pdfFileName: 'surat.rme.${datas.pasien.name}.pdf',
      ),
    );
  }
}
