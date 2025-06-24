// import 'package:flutter/services.dart';
// import 'package:intl/intl.dart';
// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart';

// class PdfInvoiceApi {
//   Future<Uint8List> generate(
//       List<DataReportTrash> invoiceTrash, String date) async {
//     final pdf = Document();

//     pdf.addPage(
//       MultiPage(
//         pageFormat: PdfPageFormat.legal,
//         build: (context) => [
//           //buildHeader(image),
//           // buildTitle(),
//           buildJudul(),
//           SizedBox(height: 1 * PdfPageFormat.cm),
//           buildTabelSampah(invoiceTrash, date),
//           //buildTable(),
//           SizedBox(height: 2 * PdfPageFormat.cm),
//           buildTabelTotalSampah(invoiceTrash, date),
//           // daclaresTable(),
//           // SizedBox(height: 10),
//           // boadTable(),
//           // SizedBox(height: 40),
//           // signature()
//         ],
//         //footer: (context) => buildFooter(),
//       ),
//     );

//     return pdf.save();
//   }

//   static Widget buildJudul() => Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text('Laporan Sampah Desa Minggirsari Kab. Blitar',
//                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
//             Text(
//                 DateFormat(' dd MMMM yyyy', 'id_ID')
//                     .format(DateTime.now())
//                     .toString(),
//                 style: TextStyle(fontSize: 15)),
//           ],
//         ),
//       );

//   static Widget buildTabelSampah(
//       List<DataReportTrash> invoiceTrash, String date) {
//     final headers = [
//       'Tanggal',
//       'Nama Warga',
//       'Sampah',
//       'Berat',
//     ];
//     // final data = invoiceTrash.map((item) {
//     //   return [
//     //     //'2023-10',
//     //     DateFormat('yyyy-MM', 'id_ID').format(DateTime.parse(date)),
//     //     item.deposits[0].customer,
//     //     item.trashName,
//     //     item.deposits[0].weight
//     //     // item.deposits[0].customer,
//     //     // item.deposits[0].weight,
//     //   ];
//     // }).toList();
//     final data = invoiceTrash.expand((item) {
//       // Setiap `item.deposits` akan di-looping
//       return item.deposits.map((deposit) {
//         return [
//           DateFormat('yyyy-MM', 'id_ID').format(DateTime.parse(deposit.createdAt)),
//           deposit.customer,
//           item.trashName,
//           '${deposit.weight} Kg'
//         ];
//       });
//     }).toList();

//     return Table.fromTextArray(
//       headers: headers,
//       data: data,
//       border: null,
//       headerStyle: TextStyle(fontWeight: FontWeight.bold),
//       headerDecoration: BoxDecoration(color: PdfColors.grey300),
//       cellHeight: 30,
//       cellAlignments: {
//         0: Alignment.centerLeft,
//         1: Alignment.centerLeft,
//         2: Alignment.centerLeft,
//         3: Alignment.centerRight,
//       },
//     );
//   }

//   static Widget buildTabelTotalSampah(
//       List<DataReportTrash> invoiceTrash, String date) {
//     final headers = [
//       'Sampah',
//       'Berat',
//     ];
//     final data = invoiceTrash.map((item) {
//       return [
//         //'2023-10',

//         item.trashName,
//         '${item.totalWeight} Kg'
//         // item.deposits[0].customer,
//         // item.deposits[0].weight,
//       ];
//     }).toList();

//     final totalWeight =
//         invoiceTrash.fold<double>(0, (sum, item) => sum + item.totalWeight);

//     // Menambahkan baris total ke dalam tabel
//     data.add([
//       'Total Berat',
//       '${totalWeight.toStringAsFixed(1)} Kg',
//     ]);

//     return Table.fromTextArray(
//       headers: headers,
//       data: data,
//       border: null,
//       headerStyle: TextStyle(fontWeight: FontWeight.bold),
//       headerDecoration: BoxDecoration(color: PdfColors.grey300),
//       cellHeight: 30,
//       cellAlignments: {
//         0: Alignment.centerLeft,
//         1: Alignment.centerLeft,
//       },
//     );
//   }
// }
