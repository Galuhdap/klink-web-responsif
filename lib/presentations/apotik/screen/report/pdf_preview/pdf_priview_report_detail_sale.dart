import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:klinik_web_responsif/core/styles/app_colors.dart';
import 'package:klinik_web_responsif/core/styles/app_sizes.dart';
import 'package:klinik_web_responsif/presentations/apotik/controller/apotik_controller.dart';
import 'package:klinik_web_responsif/presentations/pdf/report_detail_sell_pdf.dart';
import 'package:printing/printing.dart';

class PdfPriviewReportDetailSale extends StatelessWidget {
  const PdfPriviewReportDetailSale({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    PdfReportDetialSell pdfReportDetialSell = PdfReportDetialSell();
    final ApotikController controller = Get.put(ApotikController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.colorBasePrimary,
        title: Text(
          'Laporan Transaksi',
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
        build: (context) => pdfReportDetialSell.generate(
            datas: controller.showDetailSellList,
            grandTotal: controller.grandTotalSell.value,
            noInvoice: controller.invoice.value,
            namaPasien: controller.name_pasien.value,
            noRme: controller.noRekamMedis.value,
            feeDokter: controller.fee_docter.value,
            alamat: controller.alamatPasien.value,
            tanggal: controller.date_transaction.value,
            petugas: controller.petugas_apotik.value),
        pdfFileName: 'report.buy.${DateTime.now()}.pdf',
      ),
    );
  }
}
