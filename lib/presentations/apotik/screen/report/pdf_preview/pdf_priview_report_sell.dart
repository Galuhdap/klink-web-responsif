import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:klinik_web_responsif/core/styles/app_colors.dart';
import 'package:klinik_web_responsif/core/styles/app_sizes.dart';
import 'package:klinik_web_responsif/presentations/apotik/controller/apotik_controller.dart';
import 'package:klinik_web_responsif/presentations/pdf/report_sell_pdf.dart';
import 'package:printing/printing.dart';

class PdfPriviewReportSale extends StatelessWidget {
  const PdfPriviewReportSale({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    PdfReportSale pdfReportSale = PdfReportSale();
    final ApotikController controller = Get.put(ApotikController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.colorBasePrimary,
        title: Text(
          'Laporan Transaksi Keluar',
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
        build: (context) => pdfReportSale.generate(
            controller.reportSaleMedicineList,
            controller.totalSaleReport.value),
        pdfFileName: 'report.sell.${DateTime.now()}.pdf',
      ),
    );
  }
}
