import 'package:flutter/services.dart';
import 'package:klinik_web_responsif/core/utils/extensions/date_ext.dart';
import 'package:klinik_web_responsif/core/utils/extensions/int_ext.dart';
import 'package:klinik_web_responsif/services/apotik/model/response/get_purchase_report_medicine_response.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

class PdfReportBuy {
  Future<Uint8List> generate(
      List<DatumReportPurchase> datas, int grandTotal) async {
    final pdf = Document();

    pdf.addPage(
      MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (context) => [
          buildJudul(),
          SizedBox(height: 0.5 * PdfPageFormat.cm),
          buildTabelReportBuy(datas),
          SizedBox(height: 1 * PdfPageFormat.cm),
          Divider(),
          buildFooter(grandTotal),
          SizedBox(height: 1 * PdfPageFormat.cm),
        ],
      ),
    );

    return pdf.save();
  }

  static Widget buildJudul() => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('CHANIA CARE CENTER',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
            Text('Dsn. Bulu Ds. Mukuh Kec. Kayen Kidul - Kediri',
                style: TextStyle(fontSize: 12)),
            Text('081217952437/085736701718', style: TextStyle(fontSize: 12)),
            Divider(),
          ],
        ),
      );

  static Widget buildTabelReportBuy(List<DatumReportPurchase> datas) {
    final headers = [
      'No',
      'NO PEMBELIAN',
      'SUPLIER',
      'TANGGAL',
      'PETUGAS',
      'TOTAL',
    ];
    final data = datas.map((item) {
      return [
        //'2023-10',
        item.no,
        item.noPembelian,
        item.supplier,
        item.tanggalPembelian.toDateddmmmyyyyFormattedString(),
        item.userInput,
        item.total
      ];
    }).toList();

    return Table.fromTextArray(
      headerStyle: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 7, // Ukuran font header diubah menjadi 12
      ),
      cellStyle: TextStyle(
        fontSize: 7, // Ukuran font data diubah menjadi 10
      ),
      oddRowDecoration: BoxDecoration(
        color: PdfColor.fromInt(0xFFEEE5E2), // Warna baris ganjil (soft red)
      ),
      headers: headers,
      data: data,
      border: null,
      headerDecoration: BoxDecoration(color: PdfColors.grey300),
      cellHeight: 30,
      cellAlignments: {
        0: Alignment.centerLeft,
        1: Alignment.centerLeft,
        2: Alignment.centerLeft,
        3: Alignment.center,
        4: Alignment.center,
        5: Alignment.centerRight,
      },
    );
  }

  static Widget buildFooter(int grandTotal) =>
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Container(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            Text('Total Keseluruhan Pembelian ${grandTotal.currencyFormatRp}',
                style: TextStyle(fontSize: 10)),
          ],
        )
      ]);
}
