import 'package:flutter/services.dart';
import 'package:klinik_web_responsif/core/utils/extensions/date_ext.dart';
import 'package:klinik_web_responsif/services/apotik/model/response/get_letter_healt_response.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

class PdfLetterHealt {
  Future<Uint8List> generate(DatumLetterHealt datas) async {
    final pdf = Document();

    pdf.addPage(
      MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (context) => [
          buildJudul(),
          SizedBox(height: 0.5 * PdfPageFormat.cm),
          buildIsi(datas),
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

  static Widget buildIsi(DatumLetterHealt datas) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
              child: Text('Surat Keterangan',
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
          Text('Pekerjaan       : ${datas.job}',
              style: TextStyle(fontSize: 10)),
          SizedBox(height: 10),
          Text('Alamat            : ${datas.pasien.alamat}',
              style: TextStyle(fontSize: 10)),
          SizedBox(height: 10),
          Text('Perihal            :  ${datas.perihal}',
              style: TextStyle(fontSize: 10)),
          SizedBox(height: 10),
          Text('Keluhan          : ${datas.complaint}',
              style: TextStyle(fontSize: 10)),
          SizedBox(height: 10),
          Row(
            children: [
              Text('TTV                 : ', style: TextStyle(fontSize: 10)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('TD:   ${datas.td}       ',
                      style: TextStyle(fontSize: 10)),
                  Text('N:   ${datas.n}        ',
                      style: TextStyle(fontSize: 10)),
                  Text('S:   ${datas.s}        ',
                      style: TextStyle(fontSize: 10)),
                ],
              ),
            ],
          ),
          SizedBox(height: 10),
          Text(
              'Berdasarkan hasil pemeriksaan yang telah dilakukan, pasien tersebut dalam kondisi sehat.',
              style: TextStyle(fontSize: 10)),
          SizedBox(height: 10),
          Text(
              'Demikian surat Keterangan ini diberikan untuk diketahui dan di pergunkan sebagai mana mestinya. ',
              style: TextStyle(fontSize: 10)),
        ],
      );

  static Widget buildFooter(DatumLetterHealt datas) =>
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Container(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            Text('Kediri, ${datas.createdAt.toDateddmmmyyyyFormattedString()}',
                style: TextStyle(fontSize: 10)),
            SizedBox(height: 10),
            Text('Pemeriksa', style: TextStyle(fontSize: 10)),
            SizedBox(height: 40),
            Text('.........................................',
                style: TextStyle(fontSize: 10)),
            SizedBox(height: 10),
            Text('${datas.noLetter}', style: TextStyle(fontSize: 10)),
          ],
        )
      ]);
}
