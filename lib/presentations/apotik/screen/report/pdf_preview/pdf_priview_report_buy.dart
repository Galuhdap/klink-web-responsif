import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:klinik_web_responsif/core/styles/app_colors.dart';
import 'package:klinik_web_responsif/core/styles/app_sizes.dart';
import 'package:klinik_web_responsif/presentations/apotik/controller/apotik_controller.dart';
import 'package:klinik_web_responsif/presentations/pdf/report_buy_pdf.dart';
import 'package:printing/printing.dart';

class PdfPriviewReportBuy extends StatelessWidget {
  const PdfPriviewReportBuy({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    PdfReportBuy pdfReportBuy = PdfReportBuy();
    final ApotikController controller = Get.put(ApotikController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.colorBasePrimary,
        title: Text(
          'Laporan Pembelian',
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
        build: (context) => pdfReportBuy.generate(
            controller.reportPurchaseMedicineList,
            controller.totalPurchaseReport.value),
        pdfFileName: 'report.buy.${DateTime.now()}.pdf',
      ),
    );
  }
}
