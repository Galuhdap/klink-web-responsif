import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:klinik_web_responsif/core/assets/assets.gen.dart';
import 'package:klinik_web_responsif/core/components/button_component.dart';
import 'package:klinik_web_responsif/core/components/custom_tabel_component.dart';
import 'package:klinik_web_responsif/core/components/input_data_component.dart';
import 'package:klinik_web_responsif/core/components/modal/show_modal_tanda_tanya_component.dart';
import 'package:klinik_web_responsif/core/components/show_center_dialog.dart';
import 'package:klinik_web_responsif/core/styles/app_colors.dart';
import 'package:klinik_web_responsif/core/styles/app_sizes.dart';
import 'package:klinik_web_responsif/core/utils/extensions/date_ext.dart';
import 'package:klinik_web_responsif/core/utils/extensions/int_ext.dart';
import 'package:klinik_web_responsif/core/utils/extensions/sized_box_ext.dart';
import 'package:klinik_web_responsif/presentations/apotik/controller/apotik_controller.dart';
import 'package:klinik_web_responsif/presentations/apotik/widget/succes_payment_widget.dart';
import 'package:klinik_web_responsif/services/apotik/model/request/post_transaction_request.dart';
import 'package:lottie/lottie.dart';

class CompleteTransactionScreen extends StatelessWidget {
  const CompleteTransactionScreen({
    super.key,
    required this.controller,
  });

  final ApotikController controller;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.colorBaseWhite,
            borderRadius: BorderRadius.circular(
              AppSizes.s10,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withAlpha(40),
                spreadRadius: 0,
                blurRadius: 24,
                offset: Offset(0, 0),
              ),
            ],
          ),
          child: Column(
            children: [
              Container(
                padding: AppSizes.symmetricPadding(
                  vertical: AppSizes.s15,
                  horizontal: AppSizes.s15,
                ),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.colorBasePrimary,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(AppSizes.s10),
                    topRight: Radius.circular(AppSizes.s10),
                  ),
                ),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        controller.backToTransaction();
                      },
                      icon: Icon(Icons.arrow_back_ios_new_rounded,
                          color: AppColors.colorBaseWhite),
                    ),
                    AppSizes.s5.width,
                    Text(
                      'Transaction',
                      style: Get.textTheme.labelLarge!.copyWith(
                          fontSize: AppSizes.s17,
                          color: AppColors.colorBaseWhite),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: AppSizes.symmetricPadding(
                    vertical: AppSizes.s20, horizontal: AppSizes.s20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Nomor Rekam Medis',
                      style: Get.textTheme.bodyMedium!.copyWith(
                          fontSize: AppSizes.s17,
                          color: AppColors.colorBaseBlack),
                    ),
                    AppSizes.s10.height,
                    Text(
                      'RME NO',
                      style: Get.textTheme.labelLarge!.copyWith(
                          fontSize: AppSizes.s17,
                          color: AppColors.colorBaseBlack),
                    ),
                    Divider(
                      color: AppColors.colorBasePrimary,
                    ),
                    Text(
                      'NAME',
                      style: Get.textTheme.labelLarge!.copyWith(
                          fontSize: AppSizes.s20,
                          color: AppColors.colorBaseBlack),
                    ),
                    // Text(
                    //   DateTime.now().toFormattedDateDayTimeString(),
                    //   style: Get.textTheme.labelLarge!.copyWith(
                    //       fontSize: AppSizes.s20,
                    //       color: AppColors.colorBaseBlack),
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ),
        AppSizes.s20.height,
        Obx(
          () {
            return Row(
              children: [
                Flexible(
                  child: InkWell(
                    onTap: () {
                      controller.setPaymentMethod(PaymentMethod.tunai);
                    },
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: controller.selectedPaymentMethod.value ==
                                PaymentMethod.tunai
                            ? AppColors.colorBasePrimary
                            : AppColors.colorFillBorder,
                        borderRadius: BorderRadius.circular(AppSizes.s4),
                        border: Border.all(
                          color: AppColors.colorBasePrimary,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          'Tunai',
                          style: Get.textTheme.labelMedium!.copyWith(
                            fontSize: AppSizes.s14,
                            color: controller.selectedPaymentMethod.value ==
                                    PaymentMethod.tunai
                                ? AppColors.colorBaseWhite
                                : AppColors.colorBaseBlack,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                // AppSizes.s17.width,
                // Flexible(
                //   child: InkWell(
                //     onTap: () {
                //       controllerApotik.setPaymentMethod(PaymentMethod.qris);
                //     },
                //     child: Container(
                //       height: 50,
                //       decoration: BoxDecoration(
                //         color: controllerApotik.selectedPaymentMethod.value == PaymentMethod.qris ? AppColors.colorBasePrimary : AppColors.colorFillBorder,
                //         borderRadius: BorderRadius.circular(AppSizes.s4),
                //         border: Border.all(
                //           color: AppColors.colorBasePrimary,
                //         ),
                //       ),
                //       child: Center(
                //         child: Text(
                //           'Qris',
                //           style: Get.textTheme.labelMedium!.copyWith(
                //             fontSize: AppSizes.s14,
                //             color: controllerApotik.selectedPaymentMethod.value == PaymentMethod.qris ? AppColors.colorBaseWhite : AppColors.colorBaseBlack,
                //           ),
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
              ],
            );
          },
        ),
        AppSizes.s20.height,
        Obx(
          () {
            return CustomTabelComponent(
              label: 'Obat Yang Diberikan',
              sizeWidth: MediaQuery.of(context).size.width / 1,
              sizeRowTabel: MediaQuery.of(context).size.width / 1.1,
              customContentBottom: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppSizes.s10.height,
                  Container(
                    width: MediaQuery.of(context).size.width / 1,
                    height: 1,
                    color: AppColors.colorBaseSecondary,
                  ),
                  AppSizes.s10.height,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(),
                      Text(
                        'Total Biaya Obat : ',
                        style: Get.textTheme.bodyMedium!.copyWith(
                          fontSize: AppSizes.s15,
                          fontWeight: FontWeight.bold,
                          color: AppColors.colorBaseBlack,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            '${controller.dataPasienIdRme.value!.totalHargaObat.currencyFormatRp}',
                            style: Get.textTheme.bodyMedium!.copyWith(
                              fontSize: AppSizes.s15,
                              fontWeight: FontWeight.bold,
                              color: AppColors.colorBaseBlack,
                            ),
                          ),
                          70.width,
                        ],
                      ),
                    ],
                  ),
                  AppSizes.s10.height,
                  Container(
                    width: MediaQuery.of(context).size.width / 1,
                    height: 1,
                    color: AppColors.colorBaseSecondary,
                  ),
                  AppSizes.s10.height,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(),
                      Row(
                        children: [
                          Text(
                            'Biaya Dokter : ${controller.dataPasienIdRme.value!.feeDocter.currencyFormatRp}',
                            style: Get.textTheme.bodyMedium!.copyWith(
                              fontSize: AppSizes.s15,
                              fontWeight: FontWeight.bold,
                              color: AppColors.colorBaseBlack,
                            ),
                          ),
                          70.width,
                        ],
                      )
                    ],
                  ),
                  AppSizes.s10.height,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(),
                      Row(
                        children: [
                          Obx(
                            () => Text(
                              'Total Tagihan : ${controller.dataPasienIdRme.value!.totalSemua.currencyFormatRp}',
                              style: Get.textTheme.labelLarge!.copyWith(
                                  fontSize: AppSizes.s17,
                                  color: AppColors.colorBaseBlack),
                            ),
                          ),
                          70.width,
                        ],
                      )
                    ],
                  ),
                  AppSizes.s10.height,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(),
                      Row(
                        children: [
                          Container(
                            width: 200,
                            child: InputDataComponent(
                              label: 'Nominal Bayar',
                              hintText: 'Masukan nominal Bayar',
                              controller: controller.nominalController,
                              onChanged: controller.hitungKembalian,
                              // inputFormatters: <TextInputFormatter>[
                              //   CurrencyTextInputFormatter.currency(
                              //     locale: 'id',
                              //     symbol: 'Rp ',
                              //     decimalDigits: 0,
                              //   ),
                              // ],
                              textInputType: TextInputType.number,
                            ),
                          ),
                          70.width,
                        ],
                      ),
                    ],
                  ),
                  AppSizes.s10.height,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(),
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                'Uang Kembali : ',
                                style: Get.textTheme.bodyMedium!.copyWith(
                                  fontSize: AppSizes.s15,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.colorBaseBlack,
                                ),
                              ),
                              Text(
                                ' ${controller.kembalian.value >= 0 ? controller.kembalian.value.currencyFormatRp : 0.currencyFormatRp}',
                                style: Get.textTheme.bodyMedium!.copyWith(
                                  fontSize: AppSizes.s15,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.colorBaseBlack,
                                ),
                              ),
                            ],
                          ),
                          70.width,
                        ],
                      )
                    ],
                  ),
                  AppSizes.s10.height,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(),
                      Row(
                        children: [
                          Container(
                            width: 170,
                            child: Button.filled(
                                onPressed: () async {
                                  showModalCenter(
                                      context,
                                      ShowModalTandaTanyaComponent(
                                        label: 'Apakah anda sudah yakin ?',
                                        onTapNo: () {
                                          Get.back();
                                        },
                                        onTapYes: () async {
                                          if (controller.selectedPaymentMethod
                                                  .value ==
                                              PaymentMethod.tunai) {
                                            var data = PostTransactionRequest(
                                              paymentMethod: 'tunai',
                                              amountPaid: int.parse(controller
                                                  .nominalController.text),
                                              idRekamMedis: controller
                                                  .dataPasienIdRme
                                                  .value!
                                                  .detailObatRekamMedis[0]
                                                  .idRekamMedis,
                                            );
                                            await controller.postTransaction(
                                                data: data, context: context);
                                            Get.back();
                                          } else if (controller
                                                  .selectedPaymentMethod
                                                  .value ==
                                              PaymentMethod.qris) {
                                            var data = PostTransactionRequest(
                                              paymentMethod: 'qris',
                                              amountPaid: int.parse(controller
                                                  .nominalController.text),
                                              idRekamMedis: controller
                                                  .dataPasienIdRme
                                                  .value!
                                                  .detailObatRekamMedis[0]
                                                  .idRekamMedis,
                                            );
                                            await controller.postTransaction(
                                                data: data, context: context);
                                          }
                                          showModalCenter(
                                            context,
                                            Obx(
                                              () {
                                                return controller
                                                        .isLoadingPostTransaction
                                                        .value
                                                    ? Center(
                                                        child: SizedBox(
                                                          width: 400,
                                                          height: 400,
                                                          child: Lottie.asset(
                                                              Assets.lottie
                                                                  .hospital),
                                                        ),
                                                      )
                                                    : Obx(() {
                                                        return SuccesPaymentWidget(
                                                          paymentMethod: controller
                                                              .createTransaction
                                                              .value!
                                                              .data
                                                              .paymentMethod,
                                                          invoice: controller
                                                              .createTransaction
                                                              .value!
                                                              .data
                                                              .invoice,
                                                          totalTagihan: controller
                                                              .createTransaction
                                                              .value!
                                                              .data
                                                              .totalPayment
                                                              .currencyFormatRp,
                                                          nominalBayar: controller
                                                              .nominalController
                                                              .text,
                                                          kembalian: controller
                                                              .kembalian
                                                              .value
                                                              .currencyFormatRp,
                                                          date: controller
                                                              .createTransaction
                                                              .value!
                                                              .data
                                                              .createdAt
                                                              .toDateddmmmyyyyFormattedString(),
                                                          // paymentMethod: controllerApotik.createTransaction.value!.data.paymentMethod ,
                                                          // invoice: controllerApotik.createTransaction.value!.data.invoce,
                                                          // totalTagihan: controllerApotik.createTransaction.value!.data.nominalPayment.currencyFormatRp,
                                                          // nominalBayar: controllerApotik.createTransaction.value!.data.amountPaid.currencyFormatRp,
                                                          // kembalian: controllerApotik.kembalian.value >= 0 ? controllerApotik.kembalian.value.currencyFormatRp : 0.currencyFormatRp,
                                                          // date: controllerApotik.createTransaction.value!.data.createdAt.toDateTimePartString(),
                                                        );
                                                      });
                                              },
                                            ),
                                          );
                                        },
                                      ));
                                },
                                label: 'Lanjutkan'),
                          ),
                          70.width,
                        ],
                      )
                    ],
                  )
                ],
              ),
              listColumns: [
                DataColumn(
                  label: Text(
                    'NAMA OBAT',
                    style: Get.textTheme.labelLarge!.copyWith(
                        fontSize: AppSizes.s14,
                        color: AppColors.colorBaseBlack),
                  ),
                ),
                DataColumn(
                  headingRowAlignment: MainAxisAlignment.center,
                  label: Text(
                    'JUMLAH',
                    style: Get.textTheme.labelLarge!.copyWith(
                        fontSize: AppSizes.s14,
                        color: AppColors.colorBaseBlack),
                  ),
                ),
                DataColumn(
                  headingRowAlignment: MainAxisAlignment.center,
                  label: Text(
                    'SATUAN',
                    style: Get.textTheme.labelLarge!.copyWith(
                        fontSize: AppSizes.s14,
                        color: AppColors.colorBaseBlack),
                  ),
                ),
                DataColumn(
                  headingRowAlignment: MainAxisAlignment.end,
                  label: Text(
                    'HARGA',
                    style: Get.textTheme.labelLarge!.copyWith(
                        fontSize: AppSizes.s14,
                        color: AppColors.colorBaseBlack),
                  ),
                ),
              ],
              listRows: controller.isLoadingPasienIdRme.value
                  ? [
                      const DataRow(
                        cells: [
                          DataCell.empty,
                          DataCell.empty,
                          DataCell(
                            Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                          DataCell.empty,
                        ],
                      ),
                    ]
                  : controller
                          .dataPasienIdRme.value!.detailObatRekamMedis.isEmpty
                      ? [
                          const DataRow(
                            cells: [
                              DataCell.empty,
                              DataCell.empty,
                              DataCell(
                                Row(
                                  spacing: 4,
                                  children: [
                                    Icon(Icons.highlight_off),
                                    //SpaceWidth(4.0),
                                    Text('Data tidak ditemukan..'),
                                  ],
                                ),
                              ),
                              DataCell.empty,
                            ],
                          ),
                        ]
                      : controller.dataPasienIdRme.value!.detailObatRekamMedis
                          .asMap()
                          .entries
                          .map(
                          (entry) {
                            final row = entry.value;
                            return DataRow(
                              cells: [
                                DataCell(
                                  Text(
                                    row.medicine.nameMedicine,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                DataCell(Center(
                                  child: Text(
                                    row.qty.toString(),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                )),
                                DataCell(Center(
                                  child: Text(
                                    row.medicine.baseUnit.name,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                )),
                                DataCell(
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      row.medicine.priceSell.currencyFormatRp,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ).toList(),
            );
          },
        ),
      ],
    ).paddingSymmetric(
      vertical: AppSizes.s41,
      horizontal: AppSizes.s28,
    );
  }
}
