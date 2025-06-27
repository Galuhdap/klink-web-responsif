import 'package:flutter/services.dart';
import 'package:klinik_web_responsif/core/utils/extensions/int_ext.dart';
import 'package:klinik_web_responsif/services/apotik/model/response/get_sale_report_medicine_response.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

class PdfReportDetialSell {
  Future<Uint8List> generate({
    required List<DetailObat> datas,
    required String noInvoice,
    required String noRme,
    required String namaPasien,
    required String tanggal,
    required String petugas,
    required int feeDokter,
    required String alamat,
    required int grandTotal,
  }) async {
    final pdf = Document();

    pdf.addPage(
      MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (context) => [
          buildJudul(),
          SizedBox(height: 0.5 * PdfPageFormat.cm),
          buildHeader(
              noInvoice: noInvoice,
              namaPasien: namaPasien,
              noRme: noRme,
              feeDokter: feeDokter,
              alamat: alamat,
              tanggal: tanggal,
              petugas: petugas),
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

  static Widget buildHeader({
    required String noInvoice,
    required String noRme,
    required String namaPasien,
    required String tanggal,
    required String petugas,
    required int feeDokter,
    required String alamat,
  }) =>
      Column(
        children: [
          Center(
              child: Text('${noInvoice}',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12))),
          SizedBox(height: 20),
          Row(
            children: [
              Flexible(
                child: Container(
                  width: double.infinity,
                  child: Text(
                    'No Rekam Medis : ${noRme}',
                    style: TextStyle(fontSize: 8),
                  ),
                ),
              ),
              SizedBox(
                width: 30,
              ),
              Flexible(
                child: Container(
                  width: double.infinity,
                  child: Text(
                    'Nama Pasien : ${namaPasien}',
                    style: TextStyle(fontSize: 8),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 5),
          Row(
            children: [
              Flexible(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(),
                  child: Text(
                    'Tanggal Transaksi : ${tanggal}',
                    style: TextStyle(fontSize: 8),
                  ),
                ),
              ),
              SizedBox(
                width: 30,
              ),
              Flexible(
                child: Container(
                  width: double.infinity,
                  child: Text(
                    'Petugas : ${petugas}',
                    style: TextStyle(fontSize: 8),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 5),
          Row(
            children: [
              Flexible(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(),
                  child: Text(
                    'Fee Dokter : ${feeDokter.currencyFormatRp}',
                    style: TextStyle(fontSize: 8),
                  ),
                ),
              ),
              SizedBox(
                width: 30,
              ),
              Flexible(
                child: Container(
                  width: double.infinity,
                  child: Text(
                    'Alamat : ${alamat}',
                    style: TextStyle(fontSize: 8),
                  ),
                ),
              ),
            ],
          ),
        ],
      );

  static Widget buildTabelReportBuy(List<DetailObat> datas) {
    final headers = [
      'NAMA OBAT',
      'JUMLAH',
      'SATUAN',
      'TOTAL',
    ];
    final data = datas.map((item) {
      return [
        //'2023-10',

        item.namaObat,
        item.jumlah,
        item.satuan,
        item.totalHarga.currencyFormatRp
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
        1: Alignment.center,
        2: Alignment.center,
        3: Alignment.centerRight,
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
            Text('Grand Total ${grandTotal.currencyFormatRp}',
                style: TextStyle(fontSize: 10)),
          ],
        )
      ]);
}
