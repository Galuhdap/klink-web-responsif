import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:klinik_web_responsif/core/styles/app_colors.dart';
import 'package:klinik_web_responsif/core/styles/app_sizes.dart';
import 'package:klinik_web_responsif/presentations/pdf/letter_sick_pdf.dart';
import 'package:klinik_web_responsif/services/apotik/model/response/get_letter_sick_response.dart';
import 'package:printing/printing.dart';

class PdfPriviewLetterSick extends StatelessWidget {
  final String date;
  final DatumLetterSick datas;
  const PdfPriviewLetterSick(
      {super.key, required this.date, required this.datas});

  @override
  Widget build(BuildContext context) {
    PdfLetterSick pdfLetterSick = PdfLetterSick();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.colorBasePrimary,
        title: Text(
          'Surat Sakit',
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
        build: (context) => pdfLetterSick.generate(datas),
        pdfFileName: 'surat.sakit.${datas.pasien.name}.pdf',
      ),
    );
  }
}
