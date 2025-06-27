import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:klinik_web_responsif/core/assets/assets.gen.dart';
import 'package:klinik_web_responsif/core/components/button_component.dart';
import 'package:klinik_web_responsif/core/config/responsive.dart';
import 'package:klinik_web_responsif/core/styles/app_colors.dart';
import 'package:klinik_web_responsif/core/styles/app_sizes.dart';
import 'package:klinik_web_responsif/core/utils/extensions/int_ext.dart';
import 'package:klinik_web_responsif/core/utils/extensions/sized_box_ext.dart';
import 'package:klinik_web_responsif/services/apotik/model/response/post_transaction_response.dart';

class SuccesPaymentWidget extends StatelessWidget {
  final String invoice;
  final String totalTagihan;
  final String nominalBayar;
  final String kembalian;
  final String date;
  final String paymentMethod;
  final Function() onPressed;
  final List<Obat> datas;

  const SuccesPaymentWidget({
    super.key,
    required this.invoice,
    required this.totalTagihan,
    required this.nominalBayar,
    required this.kembalian,
    required this.date,
    required this.paymentMethod,
    required this.onPressed,
    required this.datas,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppSizes.s25.height,
            SvgPicture.asset(
              Assets.icons.success.path,
              width:
                  Responsive.isMobile(context) ? AppSizes.s80 : AppSizes.s100,
            ),
            AppSizes.s20.height,
            Center(
              child: Text(
                'Pembayaran Sukses!',
                style: Get.textTheme.labelMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: Responsive.isMobile(context)
                      ? AppSizes.s20
                      : AppSizes.s28,
                ),
              ),
            ),
            10.height,
            Center(
              child: Text(
                invoice,
                style: Get.textTheme.labelMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: Responsive.isMobile(context)
                      ? AppSizes.s15
                      : AppSizes.s20,
                ),
              ),
            ),
            40.height,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Metode Pembayaran',
                  style: Get.textTheme.bodyMedium!.copyWith(
                    fontSize: AppSizes.s15,
                    color: AppColors.colorBaseBlack,
                  ),
                ),
                Text(
                  paymentMethod,
                  style: Get.textTheme.bodyMedium!.copyWith(
                    fontSize: AppSizes.s15,
                    fontWeight: FontWeight.bold,
                    color: AppColors.colorBaseBlack,
                  ),
                ),
              ],
            ),
            Divider(),
            Theme(
              data: Theme.of(context)
                  .copyWith(dividerColor: Colors.transparent),
              child: Container(
                child: DataTable(
                  //border: border,
                  columns: [
                    DataColumn(
                      label: Text(
                        'NAMA OBAT',
                        style: Get.textTheme.labelLarge!.copyWith(
                            fontSize: AppSizes.s14,
                            color: AppColors.colorBaseBlack),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'QTY',
                        style: Get.textTheme.labelLarge!.copyWith(
                            fontSize: AppSizes.s14,
                            color: AppColors.colorBaseBlack),
                      ),
                    ),
                    DataColumn(
                      headingRowAlignment: MainAxisAlignment.center,
                      label: Text(
                        'HARGA',
                        style: Get.textTheme.labelLarge!.copyWith(
                            fontSize: AppSizes.s14,
                            color: AppColors.colorBaseBlack),
                      ),
                    ),
                  ],
                  rows: datas.isEmpty
                      ? [
                          const DataRow(
                            cells: [
                              DataCell.empty,
                              DataCell(Row(
                                children: [
                                  Icon(Icons.highlight_off),
                                  SizedBox(width: 1),
                                  //SpaceWidth(4.0),
                                  Text('Data'),
                                ],
                              )),
                              DataCell(Text('tidak Ditemukan')),
                            ],
                          ),
                        ]
                      : datas.asMap().entries.map(
                          (entry) {
                            final row = entry.value;
    
                            return DataRow(
                              cells: [
                                DataCell(
                                  Text(
                                    row.namaObat,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                DataCell(
                                  Text(
                                    row.jumlah.toString(),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                DataCell(
                                  Text(
                                    row.total.currencyFormatRp,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            );
                          },
                        ).toList(),
                ),
              ),
            ),
            AppSizes.s28.height,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total Tagihan',
                  style: Get.textTheme.bodyMedium!.copyWith(
                    fontSize: AppSizes.s15,
                    color: AppColors.colorBaseBlack,
                  ),
                ),
                Text(
                  totalTagihan,
                  style: Get.textTheme.bodyMedium!.copyWith(
                    fontSize: AppSizes.s15,
                    fontWeight: FontWeight.bold,
                    color: AppColors.colorBaseBlack,
                  ),
                ),
              ],
            ),
            AppSizes.s28.height,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Nominal Bayar',
                  style: Get.textTheme.bodyMedium!.copyWith(
                    fontSize: AppSizes.s15,
                    color: AppColors.colorBaseBlack,
                  ),
                ),
                Text(
                  nominalBayar,
                  style: Get.textTheme.bodyMedium!.copyWith(
                    fontSize: AppSizes.s15,
                    fontWeight: FontWeight.bold,
                    color: AppColors.colorBaseBlack,
                  ),
                ),
              ],
            ),
            AppSizes.s28.height,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Kembalian Pembayaran',
                  style: Get.textTheme.bodyMedium!.copyWith(
                    fontSize: AppSizes.s15,
                    color: AppColors.colorBaseBlack,
                  ),
                ),
                Text(
                  kembalian,
                  style: Get.textTheme.bodyMedium!.copyWith(
                    fontSize: AppSizes.s15,
                    fontWeight: FontWeight.bold,
                    color: AppColors.colorBaseBlack,
                  ),
                ),
              ],
            ),
            AppSizes.s28.height,
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Waktu Pembayaran',
                  style: Get.textTheme.bodyMedium!.copyWith(
                    fontSize: AppSizes.s15,
                    color: AppColors.colorBaseBlack,
                  ),
                ),
                Text(
                  date,
                  style: Get.textTheme.bodyMedium!.copyWith(
                    fontSize: AppSizes.s15,
                    fontWeight: FontWeight.bold,
                    color: AppColors.colorBaseBlack,
                  ),
                ),
              ],
            ),
            AppSizes.s28.height,
            Flexible(
              child: Button.filled(onPressed: onPressed, label: 'Selesai'),
            ),
          ],
        ).paddingSymmetric(
            horizontal:
                Responsive.isMobile(context) ? AppSizes.s0 : AppSizes.s100),
      ],
    );
  }
}
