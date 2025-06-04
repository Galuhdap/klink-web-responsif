import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:klinik_web_responsif/core/assets/assets.gen.dart';
import 'package:klinik_web_responsif/core/components/button_component.dart';
import 'package:klinik_web_responsif/core/components/input_component.dart';
import 'package:klinik_web_responsif/core/components/input_data_component.dart';
import 'package:klinik_web_responsif/core/components/show_center_dialog.dart';
import 'package:klinik_web_responsif/core/components/show_modal_right_component.dart';
import 'package:klinik_web_responsif/core/resources/constans/app_constants.dart';
import 'package:klinik_web_responsif/core/styles/app_colors.dart';
import 'package:klinik_web_responsif/core/styles/app_sizes.dart';
import 'package:klinik_web_responsif/core/utils/extensions/int_ext.dart';
import 'package:klinik_web_responsif/core/utils/extensions/sized_box_ext.dart';
import 'package:klinik_web_responsif/presentations/apotik/controller/apotik_controller.dart';
import 'package:klinik_web_responsif/presentations/apotik/widget/succes_payment_widget.dart';
import 'package:klinik_web_responsif/services/apotik/model/request/post_transaction_request.dart';
import 'package:klinik_web_responsif/services/pasien/model/response/get_antrian_pasien_response.dart';
import 'package:lottie/lottie.dart';

class QueueRoleApotikAction extends StatelessWidget {
  const QueueRoleApotikAction({
    super.key,
    required this.row,
    required this.controllerApotik,
  });

  final AntrianData row;
  final ApotikController controllerApotik;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: () async {
            await controllerApotik.getTransactionPasienIdRme(id: row.idPasien);
            showRightModal(
              context,
              controllerApotik.isLoadingPasienIdRme.value
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Row(
                      children: [
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      Get.back();
                                    },
                                    icon: const Icon(
                                      Icons.arrow_back,
                                      size: 24,
                                      color: AppColors.colorBaseBlack,
                                    ),
                                  ),
                                  Text(
                                    'Transaksi',
                                    style: Get.textTheme.labelMedium!.copyWith(
                                        fontWeight: FontWeight.bold,
                                        fontSize: AppSizes.s24),
                                  ),
                                ],
                              ),
                              Divider(),
                              AppSizes.s15.height,
                              InputDataComponent(
                                label: 'No Rekam Medis',
                                hintText: row.pasien.noRekamMedis,
                                controller: TextEditingController(),
                                readOnly: true,
                              ),
                              InputDataComponent(
                                label: 'Nama Pasien',
                                hintText: row.pasien.name,
                                controller: TextEditingController(),
                                readOnly: true,
                              ),
                              InputDataComponent(
                                label: 'Alamat',
                                hintText: row.pasien.alamat,
                                controller: TextEditingController(),
                                readOnly: true,
                              ),
                              InputDataComponent(
                                label: 'Keluhan',
                                hintText: controllerApotik
                                    .dataPasienIdRme.value!.keluhan,
                                controller: TextEditingController(),
                                readOnly: true,
                              ),
                              AppSizes.s20.height,
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    AppConstants.LABEL_OBAT,
                                    style: Get.textTheme.bodyMedium!.copyWith(
                                        fontWeight: FontWeight.w700,
                                        fontSize: AppSizes.s14,
                                        color: AppColors.colorBaseBlack),
                                  ),
                                  SizedBox(
                                    width: double.infinity,
                                    height:
                                        AppSizes.setResponsiveHeight(context) *
                                            0.23,
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: controllerApotik
                                          .dataPasienIdRme
                                          .value!
                                          .detailObatRekamMedis
                                          .length,
                                      itemBuilder: (context, index) {
                                        var obat = controllerApotik
                                            .dataPasienIdRme
                                            .value!
                                            .detailObatRekamMedis[index];
                                        return Flexible(
                                          child: Container(
                                            margin: AppSizes.symmetricPadding(
                                                vertical: AppSizes.s5),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      obat.obat.namaObat,
                                                      style: Get
                                                          .textTheme.bodyMedium!
                                                          .copyWith(
                                                        fontSize: AppSizes.s15,
                                                        color: AppColors
                                                            .colorBaseBlack,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Container(
                                                  width: 60,
                                                  height: 50,
                                                  child: CustomTextField(
                                                    hintText:
                                                        obat.qty.toString(),
                                                    controller:
                                                        TextEditingController(),
                                                    readOnly: true,
                                                    keyboardType:
                                                        TextInputType.number,
                                                    //textInputType: TextInputType.name,
                                                    hintStyle: Get
                                                        .textTheme.titleMedium!
                                                        .copyWith(
                                                            color: AppColors
                                                                .colorSecondary600,
                                                            fontSize:
                                                                AppSizes.s10),
                                                    onChanged: (value) {},
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              AppSizes.s20.height,
                            ],
                          ),
                        ),
                        AppSizes.s46.width,
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              70.height,
                              InputDataComponent(
                                maxLines: 10,
                                label: AppConstants.LABEL_TERAPI_TINDAKAN,
                                hintText: controllerApotik
                                    .dataPasienIdRme.value!.terapiTindakan,
                                controller: TextEditingController(),
                                readOnly: true,
                                textInputType: TextInputType.multiline,
                              ),
                              AppSizes.s10.height,
                              Text(
                                'Metode Pembayaran',
                                style: Get.textTheme.bodyMedium!.copyWith(
                                    fontWeight: FontWeight.w700,
                                    fontSize: AppSizes.s14,
                                    color: AppColors.colorBaseBlack),
                              ),
                              AppSizes.s12.height,
                              Obx(
                                () {
                                  return Row(
                                    children: [
                                      Flexible(
                                        child: InkWell(
                                          onTap: () {
                                            controllerApotik.setPaymentMethod(
                                                PaymentMethod.tunai);
                                          },
                                          child: Container(
                                            height: 50,
                                            decoration: BoxDecoration(
                                              color: controllerApotik
                                                          .selectedPaymentMethod
                                                          .value ==
                                                      PaymentMethod.tunai
                                                  ? AppColors.colorBasePrimary
                                                  : AppColors.colorFillBorder,
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      AppSizes.s4),
                                              border: Border.all(
                                                color:
                                                    AppColors.colorBasePrimary,
                                              ),
                                            ),
                                            child: Center(
                                              child: Text(
                                                'Tunai',
                                                style: Get
                                                    .textTheme.labelMedium!
                                                    .copyWith(
                                                  fontSize: AppSizes.s14,
                                                  color: controllerApotik
                                                              .selectedPaymentMethod
                                                              .value ==
                                                          PaymentMethod.tunai
                                                      ? AppColors.colorBaseWhite
                                                      : AppColors
                                                          .colorBaseBlack,
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
                              AppSizes.s12.height,
                              InputDataComponent(
                                label: 'Total Tagihan',
                                hintText: controllerApotik.dataPasienIdRme
                                    .value!.total.currencyFormatRp,
                                readOnly: true,
                                controller: TextEditingController(),
                              ),
                              AppSizes.s10.height,
                              InputDataComponent(
                                label: 'Nominal Bayar',
                                hintText: 'Masukan nominal Bayar',
                                controller: controllerApotik.nominalController,
                                onChanged: controllerApotik.hitungKembalian,
                                // inputFormatters: <TextInputFormatter>[
                                //   CurrencyTextInputFormatter.currency(
                                //     locale: 'id',
                                //     symbol: 'Rp ',
                                //     decimalDigits: 0,
                                //   ),
                                // ],
                                textInputType: TextInputType.number,
                              ),
                              AppSizes.s10.height,
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Uang Kembali',
                                    style: Get.textTheme.bodyMedium!.copyWith(
                                      fontSize: AppSizes.s15,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.colorBaseBlack,
                                    ),
                                  ),
                                  Obx(() {
                                    return Text(
                                        controllerApotik.kembalian.value >= 0
                                            ? controllerApotik.kembalian.value
                                                .currencyFormatRp
                                            : 0.currencyFormatRp,
                                        style:
                                            Get.textTheme.bodyMedium!.copyWith(
                                          fontSize: AppSizes.s15,
                                          color: AppColors.colorBaseBlack,
                                        ));
                                  })
                                ],
                              ),
                              AppSizes.s10.height,
                              Flexible(
                                child: Button.filled(
                                    onPressed: () async {
                                      if (controllerApotik
                                              .selectedPaymentMethod.value ==
                                          PaymentMethod.tunai) {
                                        var data = PostTransactionRequest(
                                          paymentMethod: 'tunai',
                                          nominalPayment: controllerApotik
                                              .dataPasienIdRme.value!.total,
                                          amountPaid: int.parse(controllerApotik
                                              .nominalController.text),
                                          changeGiven: controllerApotik
                                                      .kembalian.value >=
                                                  0
                                              ? controllerApotik.kembalian.value
                                              : 0,
                                          idRekamMedis: controllerApotik
                                              .dataPasienIdRme
                                              .value!
                                              .detailObatRekamMedis[0]
                                              .idRekamMedis,
                                        );
                                        await controllerApotik.postTransaction(
                                            data: data);
                                        Get.back();
                                      } else if (controllerApotik
                                              .selectedPaymentMethod.value ==
                                          PaymentMethod.qris) {
                                        var data = PostTransactionRequest(
                                          paymentMethod: 'qris',
                                          nominalPayment: controllerApotik
                                              .dataPasienIdRme.value!.total,
                                          amountPaid: int.parse(controllerApotik
                                              .nominalController.text),
                                          changeGiven: controllerApotik
                                                      .kembalian.value >=
                                                  0
                                              ? controllerApotik.kembalian.value
                                              : 0,
                                          idRekamMedis: controllerApotik
                                              .dataPasienIdRme
                                              .value!
                                              .detailObatRekamMedis[0]
                                              .idRekamMedis,
                                        );
                                        await controllerApotik.postTransaction(
                                            data: data);
                                        Get.back();
                                      }
                                      showModalCenter(context, Obx(() {
                                        return controllerApotik
                                                .isLoadingPostTransaction.value
                                            ? Center(
                                                child: SizedBox(
                                                  width: 400,
                                                  height: 400,
                                                  child: Lottie.asset(
                                                      Assets.lottie.hospital),
                                                ),
                                              )
                                            : SuccesPaymentWidget(
                                                paymentMethod: '',
                                                invoice: '',
                                                totalTagihan: '',
                                                nominalBayar: '',
                                                kembalian: '',
                                                date: '',
                                                // paymentMethod: controllerApotik.createTransaction.value!.data.paymentMethod ,
                                                // invoice: controllerApotik.createTransaction.value!.data.invoce,
                                                // totalTagihan: controllerApotik.createTransaction.value!.data.nominalPayment.currencyFormatRp,
                                                // nominalBayar: controllerApotik.createTransaction.value!.data.amountPaid.currencyFormatRp,
                                                // kembalian: controllerApotik.kembalian.value >= 0 ? controllerApotik.kembalian.value.currencyFormatRp : 0.currencyFormatRp,
                                                // date: controllerApotik.createTransaction.value!.data.createdAt.toDateTimePartString(),
                                              );
                                      }));
                                    },
                                    label: 'Lanjutkan'),
                              )
                            ],
                          ),
                        ),
                      ],
                    ).paddingSymmetric(
                      vertical: AppSizes.s53,
                      horizontal: AppSizes.s40,
                    ),
            );
          },
          child: Container(
            padding: AppSizes.symmetricPadding(
              vertical: AppSizes.s5,
              horizontal: AppSizes.s10,
            ),
            decoration: BoxDecoration(
              color: AppColors.colorSuccess300,
              borderRadius: BorderRadius.circular(AppSizes.s5),
            ),
            child: Row(
              spacing: AppSizes.s5,
              children: [
                Icon(
                  Icons.payments_rounded,
                  color: AppColors.colorBaseWhite,
                ),
                Text(
                  'Proses Transaksi',
                  style: Get.textTheme.labelLarge!.copyWith(
                    fontSize: AppSizes.s11,
                    color: AppColors.colorBaseWhite,
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}