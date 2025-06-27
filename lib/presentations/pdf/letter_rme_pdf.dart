import 'package:flutter/services.dart';
import 'package:klinik_web_responsif/core/utils/extensions/date_ext.dart';
import 'package:klinik_web_responsif/services/doctor/model/response/get_letter_rme_response.dart';
import 'package:klinik_web_responsif/services/rme/model/response/get_rme_id_response.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

class PdfLetterRme {
  Future<Uint8List> generate(DatumLetterRme datas, List<RmeData> data) async {
    final pdf = Document();

    pdf.addPage(
      MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (context) => [
          buildJudul(),
          SizedBox(height: 0.5 * PdfPageFormat.cm),
          buildIsi(datas, data),
          SizedBox(height: 2.5 * PdfPageFormat.cm),
          buildFooter(datas),
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

  static Widget buildIsi(DatumLetterRme datas, List<RmeData> data) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
              child: Text('Surat Keterangan Rekam medis Electronik',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12))),
          SizedBox(height: 20),
          Text('Yang bertanda tangan dibwah ini menerangkan bahwa : ',
              style: TextStyle(fontSize: 10)),
          SizedBox(height: 10),
          Text('Nama              : ${datas.pasien.name}',
              style: TextStyle(fontSize: 10)),
          SizedBox(height: 10),
          Text('Usia                : ${datas.pasien.umur}',
              style: TextStyle(fontSize: 10)),
          SizedBox(height: 10),
          Text('Pekerjaan       : ${datas.pekerjaan}',
              style: TextStyle(fontSize: 10)),
          SizedBox(height: 10),
          Text('Alamat            : ${datas.pasien.alamat}',
              style: TextStyle(fontSize: 10)),
          SizedBox(height: 10),
          Text(
              'Berdasarkan hasil pemeriksaan yang telah dilakukan, menyatakan bahwa nama yang tertera diatas bahwa pasien tersebut telah dirawat jalan di Klinik Chania Care Center Kediri, Berikut untuk Catatan Rekam Medis yang pasien tersebut :',
              style: TextStyle(fontSize: 10)),
          SizedBox(height: 10),
          buildTabelLetterRme(data),
          SizedBox(height: 10),
          Text('Untuk keperluan            : ${datas.keperluan}',
              style: TextStyle(fontSize: 10)),
          SizedBox(height: 10),
          Text(
              'Pada                              : ${datas.startDate.toDateddmmmyyyyFormattedString()} s/d ${datas.endDate.toDateddmmmyyyyFormattedString()}',
              style: TextStyle(fontSize: 10)),
          SizedBox(height: 10),
          Text(
              'Demikian Catatan rekam medis yang bersifat rahasia ini diberikan untuk diketahui dan di pergunakan sebagaimana mestinya. ',
              style: TextStyle(fontSize: 10)),
        ],
      );

  static Widget buildTabelLetterRme(List<RmeData> datas) {
    final headers = [
      'TANGGAL PERIKSA',
      'KELUHAN',
      'DX',
      'TERAPI/TINDAKAN',
    ];
    final data = datas.map((item) {
      return [
        //'2023-10',
        item.jadwalPeriksa.toDateddmmmyyyyFormattedString(),
        item.keluhan,
        item.dx,
        item.terapiTindakan
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
        2: Alignment.centerLeft,
        3: Alignment.centerLeft,
      },
    );
  }

  static Widget buildFooter(DatumLetterRme datas) =>
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Container(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            Text('Kediri, ${datas.createdAt.toDateddmmmyyyyFormattedString()}',
                style: TextStyle(fontSize: 10)),
            SizedBox(height: 10),
            Text('Dokter', style: TextStyle(fontSize: 10)),
            SizedBox(height: 40),
            Text('${datas.user.name}',
                style: TextStyle(fontSize: 10)),
            SizedBox(height: 10),
            Text('${datas.noLetter}', style: TextStyle(fontSize: 10)),
          ],
        )
      ]);
}
