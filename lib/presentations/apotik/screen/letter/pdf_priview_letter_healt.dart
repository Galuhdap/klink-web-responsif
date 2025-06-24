import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:klinik_web_responsif/core/styles/app_colors.dart';
import 'package:klinik_web_responsif/core/styles/app_sizes.dart';
import 'package:klinik_web_responsif/services/apotik/model/response/get_letter_healt_response.dart';
import 'package:printing/printing.dart';

import '../../../pdf/letter_healt_pdf.dart';

class PdfPriviewLetterHealt extends StatelessWidget {
  final DatumLetterHealt datas;
  const PdfPriviewLetterHealt({super.key, required this.datas});

  @override
  Widget build(BuildContext context) {
    PdfLetterHealt pdfLetterHealt = PdfLetterHealt();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.colorBasePrimary,
        title: Text(
          'Surat Sehat',
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
        build: (context) => pdfLetterHealt.generate(datas),
        pdfFileName: 'surat.sehat.${datas.pasien.name}.pdf',
      ),
    );
  }
}
