// import 'package:flutter/services.dart';
// import 'package:image/image.dart' as img;
// import 'dart:io';

import 'package:esc_pos_utils_plus/esc_pos_utils_plus.dart';
import 'package:intl/intl.dart';
import 'package:klinik_web_responsif/core/utils/extensions/int_ext.dart';


class CwbPrint {
  CwbPrint._init();

  static final CwbPrint instance = CwbPrint._init();

  // Future printOrder(){
    
  // }
  Future<List<int>> printOrder() async{
  final List<int> bytes = [];
  // Using default profile
  // final profile = await CapabilityProfile.load();
  // final generator = Generator(PaperSize.mm80, profile);
 
  return bytes;
}

  // Future<List<int>> printOrder(
  //   // List<TransactionProduct> products,
  //   //int totalQuantity,
  //   int totalPrice,
  //   // String paymentMethod,
  //   int nominalBayar,
  //   String nameCustomer,
  //   String noTelp,
  //   String alamat,
  // ) async {
  //   List<int> bytes = [];

  //   final profile = await CapabilityProfile.load();
  //   final generator = Generator(PaperSize.mm58, profile);
  //   bytes += generator.reset();

  //   // final ByteData data = await rootBundle.load('assets/images/logo_bs.png');
  //   // final Uint8List bytess = data.buffer.asUint8List();
  //   // final img.Image? image = img.decodeImage(bytess);

  //   // bytes += generator.image(img.copyResize(image!, width: 150));

  //   bytes += generator.text('Koprasi Minggirsari',
  //       styles: const PosStyles(
  //         bold: true,
  //         align: PosAlign.center,
  //         height: PosTextSize.size1,
  //         width: PosTextSize.size1,
  //       ));
  //   // bytes += generator.text('Code with Bahri',
  //   //     styles: const PosStyles(
  //   //       bold: true,
  //   //       align: PosAlign.center,
  //   //       height: PosTextSize.size1,
  //   //       width: PosTextSize.size1,
  //   //     ));

  //   bytes += generator.text('Desa Minggarsari',
  //       styles: const PosStyles(bold: true, align: PosAlign.center));
  //   bytes += generator.text(
  //       'Date : ${DateFormat('dd-MM-yyyy HH:mm').format(DateTime.now())}',
  //       styles: const PosStyles(bold: false, align: PosAlign.center));
  //   // bytes += generator.text('Start 12 Desember 2023',
  //   //     styles: const PosStyles(bold: false, align: PosAlign.center));
  //   bytes += generator.feed(1);
  //   bytes += generator.row([
  //     PosColumn(
  //       text: 'Nama Customer',
  //       width: 8,
  //       styles: const PosStyles(align: PosAlign.left),
  //     ),
  //     PosColumn(
  //       text: 'Galuh',
  //       width: 4,
  //       styles: const PosStyles(align: PosAlign.right),
  //     ),
  //   ]);
  //   // bytes += generator.row([
  //   //   PosColumn(
  //   //     text: 'No Telp',
  //   //     width: 8,
  //   //     styles: const PosStyles(
  //   //       align: PosAlign.left,
  //   //     ),
  //   //   ),
  //   //   PosColumn(
  //   //     text: '${noTelp}',
  //   //     width: 4,
  //   //     styles: const PosStyles(align: PosAlign.right),
  //   //   ),
  //   // ]);

  //   // bytes += generator.row([
  //   //   PosColumn(
  //   //     text: 'Alamat',
  //   //     width: 8,
  //   //     styles: const PosStyles(align: PosAlign.left),
  //   //   ),
  //   //   PosColumn(
  //   //     text: '${alamat}',
  //   //     width: 4,
  //   //     styles: const PosStyles(align: PosAlign.right),
  //   //   ),
  //   // ]);

  //   bytes += generator.feed(1);
  //   bytes += generator.text('Pesanan:',
  //       styles: const PosStyles(bold: false, align: PosAlign.center));
  //   //for from data
  //   // for (final product in products) {
  //   //   bytes += generator.text(product.product.name,
  //   //       styles: const PosStyles(align: PosAlign.left));

  //   //   bytes += generator.row([
  //   //     PosColumn(
  //   //       text: '${product.product.price} x ${product.quantity}',
  //   //       width: 8,
  //   //       styles: const PosStyles(align: PosAlign.left),
  //   //     ),
  //   //     PosColumn(
  //   //       text: '${product.product.price * product.quantity}',
  //   //       width: 4,
  //   //       styles: const PosStyles(align: PosAlign.right),
  //   //     ),
  //   //   ]);
  //   // }

  //   bytes += generator.feed(1);

  //   bytes += generator.row([
  //     PosColumn(
  //       text: 'Total',
  //       width: 6,
  //       styles: const PosStyles(align: PosAlign.left),
  //     ),
  //     PosColumn(
  //       text: totalPrice.currencyFormatRp,
  //       width: 6,
  //       styles: const PosStyles(align: PosAlign.right),
  //     ),
  //   ]);

  //   bytes += generator.row([
  //     PosColumn(
  //       text: 'Bayar',
  //       width: 6,
  //       styles: const PosStyles(align: PosAlign.left),
  //     ),
  //     PosColumn(
  //       text: nominalBayar.currencyFormatRp,
  //       width: 6,
  //       styles: const PosStyles(align: PosAlign.right),
  //     ),
  //   ]);

  //   // bytes += generator.row([
  //   //   PosColumn(
  //   //     text: 'Pembayaran',
  //   //     width: 8,
  //   //     styles: const PosStyles(align: PosAlign.left),
  //   //   ),
  //   //   PosColumn(
  //   //     text: paymentMethod,
  //   //     width: 4,
  //   //     styles: const PosStyles(align: PosAlign.right),
  //   //   ),
  //   // ]);

  //   bytes += generator.feed(1);
  //   bytes += generator.text('Terima kasih\nSudah Berbelanja',
  //       styles: const PosStyles(bold: false, align: PosAlign.center));
  //   bytes += generator.feed(3);

  //   return bytes;
  // }
}
