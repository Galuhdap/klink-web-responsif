import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:klinik_web_responsif/core/components/button_component.dart';
import 'package:klinik_web_responsif/core/components/input_component.dart';
import 'package:klinik_web_responsif/core/components/input_data_component.dart';
import 'package:klinik_web_responsif/core/components/search_new_component.dart';
import 'package:klinik_web_responsif/core/components/show_center_dialog.dart';
import 'package:klinik_web_responsif/core/components/show_modal_right_component.dart';
import 'package:klinik_web_responsif/core/components/status_antrian_component.dart';
import 'package:klinik_web_responsif/core/config/responsive.dart';
import 'package:klinik_web_responsif/core/resources/constans/app_constants.dart';
import 'package:klinik_web_responsif/core/styles/app_colors.dart';
import 'package:klinik_web_responsif/core/styles/app_sizes.dart';
import 'package:klinik_web_responsif/core/utils/extensions/sized_box_ext.dart';
import 'package:klinik_web_responsif/presentations/apotik/controller/apotik_controller.dart';
import 'package:klinik_web_responsif/presentations/apotik/widget/succes_payment_widget.dart';
import 'package:klinik_web_responsif/presentations/menu_dashboard/widget/build_app_bar.dart';

class TakeDrugScreen extends StatelessWidget {
  const TakeDrugScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ApotikController>(
      init: ApotikController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: Color(0xfffF8F8F8),
          appBar: PreferredSize(
            preferredSize: Responsive.isMobile(context)
                ? Size.fromHeight(90.0)
                : Size.fromHeight(110.0),
            child: BuildAppBar(
              title: 'Klinik Chania Care Center',
              withSearchInput: true,
              searchController: TextEditingController(),
              searchHint: 'Cari Pasien',
              searchChanged: (_) {
                // if (searchController.text.isNotEmpty &&
                //     searchController.text.length > 1) {
                //   context.read<DataPatientsBloc>().add(
                //       DataPatientsEvent.getPatientByNIK(searchController.text));
                // } else {
                //   context
                //       .read<DataPatientsBloc>()
                //       .add(const DataPatientsEvent.getPatients());
                // }
              },
            ),
          ),
          body: ListView(
            children: [
              Container(
                width: double.infinity,
                padding: AppSizes.symmetricPadding(
                    vertical: AppSizes.s35, horizontal: AppSizes.s41),
                decoration: BoxDecoration(
                  color: AppColors.colorBaseWhite,
                  borderRadius: BorderRadius.circular(AppSizes.s4),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          AppConstants.LABEL_AMBIL_OBAT,
                          style: Get.textTheme.labelMedium!.copyWith(
                              fontSize: AppSizes.s16,
                              color: AppColors.colorBaseBlack,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    AppSizes.s24.height,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Container(
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  offset: const Offset(0, 0),
                                  blurRadius: 15,
                                  spreadRadius: 0,
                                  color:
                                      AppColors.colorNeutrals300.withAlpha(40),
                                ),
                              ],
                            ),
                            child: SearchNewComponent(
                              controller: TextEditingController(),
                              keyboardType: TextInputType.name,
                              hintText: AppConstants.LABEL_CARI,
                              suffixIcon: const Icon(
                                Icons.search,
                                color: AppColors.colorSecondary500,
                              ),
                            ),
                          ),
                        ),
                        // AppSizes.s17.width,
                        // Container(
                        //   width: 50,
                        //   height: 50,
                        //   decoration: BoxDecoration(
                        //     borderRadius: BorderRadius.circular(AppSizes.s4),
                        //     border: Border.all(color: Color(0xfffF0F0F0)),
                        //     color: AppColors.colorBaseWhite,
                        //     boxShadow: [
                        //       BoxShadow(
                        //         offset: const Offset(0, 0),
                        //         blurRadius: 15,
                        //         spreadRadius: 0,
                        //         color: AppColors.colorNeutrals300.withAlpha(40),
                        //       ),
                        //     ],
                        //   ),
                        //   child: Center(
                        //     child: Icon(
                        //       Iconsax.filter,
                        //       color: AppColors.colorSecondary500,
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  height: 500,
                  color: AppColors.colorBaseWhite,
                  child: ListView(
                    padding: AppSizes.symmetricPadding(
                      horizontal: AppSizes.s30,
                    ),
                    children: [
                      SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(vertical: 20.0),
                        scrollDirection: Axis.horizontal,
                        child: Center(
                          child: Theme(
                            data: Theme.of(context)
                                .copyWith(dividerColor: Colors.transparent),
                            child: DataTable(
                              dividerThickness: 0.0,
                              dataRowMinHeight: 20.0,
                              dataRowMaxHeight: 50.0,
                              columns: [
                                DataColumn(
                                  label: Text(
                                    AppConstants.LABEL_NO_ANTRIAN,
                                    style: Get.textTheme.labelLarge!.copyWith(
                                        fontSize: AppSizes.s14,
                                        color: AppColors.colorBaseBlack),
                                  ),
                                ),
                                DataColumn(
                                  label: Padding(
                                    padding: EdgeInsets.only(
                                        left:
                                            MediaQuery.of(context).size.width *
                                                0.07,
                                        right:
                                            MediaQuery.of(context).size.width *
                                                0.201),
                                    child: Text(
                                      AppConstants.LABEL_NAMA_PASIEN,
                                      style: Get.textTheme.labelLarge!.copyWith(
                                          fontSize: AppSizes.s14,
                                          color: AppColors.colorBaseBlack),
                                    ),
                                  ),
                                ),
                                DataColumn(
                                    label: Center(
                                  child: Text(
                                    AppConstants.LABEL_STATUS,
                                    style: Get.textTheme.labelLarge!.copyWith(
                                        fontSize: AppSizes.s14,
                                        color: AppColors.colorBaseBlack),
                                  ),
                                ).paddingOnly(left: 30)),
                                DataColumn(
                                  label: Padding(
                                    padding: EdgeInsets.only(
                                      left: MediaQuery.of(context).size.width *
                                          0.07,
                                      right: MediaQuery.of(context).size.width *
                                          0.07,
                                    ),
                                    child: Text(
                                      AppConstants.LABEL_ACTION,
                                      style: Get.textTheme.labelLarge!.copyWith(
                                          fontSize: AppSizes.s14,
                                          color: AppColors.colorBaseBlack),
                                    ),
                                  ),
                                ),
                              ],
                              rows: controller.patient.isEmpty
                                  ? [
                                      const DataRow(
                                        cells: [
                                          DataCell.empty,
                                          DataCell.empty,
                                          DataCell(Row(
                                            spacing: 4,
                                            children: [
                                              Icon(Icons.highlight_off),
                                              //SpaceWidth(4.0),
                                              Text('Data tidak ditemukan..'),
                                            ],
                                          )),
                                          DataCell.empty,
                                          DataCell.empty,
                                        ],
                                      ),
                                      DataRow(
                                        cells: [
                                          DataCell.empty,
                                          DataCell.empty,
                                          DataCell(
                                            Button.filled(
                                              onPressed: () {
                                                // showDialog(
                                                //   context: context,
                                                //   barrierDismissible: false,
                                                //   builder: (context) =>
                                                //       const CreatePatientDialog(),
                                                // );
                                              },
                                              label: 'Pasien Baru',
                                              width: 250,
                                            ),
                                          ),
                                          DataCell.empty,
                                          DataCell.empty,
                                        ],
                                      ),
                                    ]
                                  : controller.patient
                                      .map(
                                        (patient) => DataRow(
                                          cells: [
                                            DataCell(
                                              Center(
                                                child: Text(
                                                  patient["nomor_antrian"],
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                            ),
                                            DataCell(
                                              Padding(
                                                padding: EdgeInsets.only(
                                                  left: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.07,
                                                ),
                                                child: Column(
                                                  spacing: 5,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      patient["nama_pasien"],
                                                      style: Get
                                                          .textTheme.labelLarge!
                                                          .copyWith(
                                                        fontSize: AppSizes.s16,
                                                      ),
                                                    ),
                                                    Text(
                                                      patient['rm'],
                                                      style: Get
                                                          .textTheme.bodySmall!
                                                          .copyWith(
                                                        fontSize: AppSizes.s10,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            DataCell(
                                              StatusAntrianComponent(
                                                status: patient['status'],
                                              ),
                                            ),
                                            DataCell(
                                              Center(
                                                child: IconButton(
                                                  onPressed:
                                                      Responsive.isDesktop(
                                                              context)
                                                          ? () {
                                                              showRightModal(
                                                                context,
                                                                Row(
                                                                  children: [
                                                                    Flexible(
                                                                      child:
                                                                          Column(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
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
                                                                                'Pembayaran',
                                                                                style: Get.textTheme.labelMedium!.copyWith(fontWeight: FontWeight.bold, fontSize: AppSizes.s24),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          Divider(),
                                                                          AppSizes
                                                                              .s15
                                                                              .height,
                                                                          InputDataComponent(
                                                                            label:
                                                                                'No Rekam Medis',
                                                                            hintText:
                                                                                '099283',
                                                                            controller:
                                                                                TextEditingController(),
                                                                            readOnly:
                                                                                true,
                                                                          ),
                                                                          InputDataComponent(
                                                                            label:
                                                                                'Nama Pasien',
                                                                            hintText:
                                                                                'Bauta',
                                                                            controller:
                                                                                TextEditingController(),
                                                                            readOnly:
                                                                                true,
                                                                          ),
                                                                          InputDataComponent(
                                                                            label:
                                                                                'Alamat',
                                                                            hintText:
                                                                                'Surabaya',
                                                                            controller:
                                                                                TextEditingController(),
                                                                            readOnly:
                                                                                true,
                                                                          ),
                                                                          AppSizes
                                                                              .s20
                                                                              .height,
                                                                          Column(
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            children: [
                                                                              Text(
                                                                                AppConstants.LABEL_OBAT,
                                                                                style: Get.textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w700, fontSize: AppSizes.s14, color: AppColors.colorBaseBlack),
                                                                              ),
                                                                              SizedBox(
                                                                                width: double.infinity,
                                                                                height: AppSizes.setResponsiveHeight(context) * 0.23,
                                                                                child: ListView.builder(
                                                                                  shrinkWrap: true,
                                                                                  itemCount: 2,
                                                                                  itemBuilder: (context, index) {
                                                                                    // var obat = controller
                                                                                    //         .dummySuggestions[
                                                                                    //     index];
                                                                                    return Flexible(
                                                                                      child: Container(
                                                                                        margin: AppSizes.symmetricPadding(vertical: AppSizes.s5),
                                                                                        child: Row(
                                                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                          children: [
                                                                                            Column(
                                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                                              children: [
                                                                                                Text(
                                                                                                  'Farsevin 400mg',
                                                                                                  style: Get.textTheme.bodyMedium!.copyWith(
                                                                                                    fontSize: AppSizes.s15,
                                                                                                    color: AppColors.colorBaseBlack,
                                                                                                  ),
                                                                                                ),
                                                                                              ],
                                                                                            ),
                                                                                            Container(
                                                                                              width: 60,
                                                                                              height: 50,
                                                                                              child: CustomTextField(
                                                                                                hintText: '2',
                                                                                                controller: TextEditingController(),
                                                                                                readOnly: true,
                                                                                                keyboardType: TextInputType.number,
                                                                                                //textInputType: TextInputType.name,
                                                                                                hintStyle: Get.textTheme.titleMedium!.copyWith(color: AppColors.colorSecondary600, fontSize: AppSizes.s10),
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
                                                                          AppSizes
                                                                              .s20
                                                                              .height,
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    AppSizes.s46
                                                                        .width,
                                                                    Flexible(
                                                                      child:
                                                                          Column(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          70.height,
                                                                          InputDataComponent(
                                                                            maxLines:
                                                                                10,
                                                                            label:
                                                                                AppConstants.LABEL_TERAPI_TINDAKAN,
                                                                            hintText:
                                                                                'Tindakan',
                                                                            controller:
                                                                                TextEditingController(),
                                                                            readOnly:
                                                                                true,
                                                                            textInputType:
                                                                                TextInputType.multiline,
                                                                          ),
                                                                          AppSizes
                                                                              .s10
                                                                              .height,
                                                                          Obx(
                                                                            () {
                                                                              return Row(
                                                                                children: [
                                                                                  Flexible(
                                                                                    child: InkWell(
                                                                                      onTap: () {
                                                                                        controller.ButtonActionPay();
                                                                                      },
                                                                                      child: Container(
                                                                                        height: 50,
                                                                                        decoration: BoxDecoration(
                                                                                          color: controller.actionPay.value ? AppColors.colorBasePrimary : AppColors.colorFillBorder,
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
                                                                                              color: controller.actionPay.value ? AppColors.colorBaseWhite : AppColors.colorBaseBlack,
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  AppSizes.s17.width,
                                                                                  Flexible(
                                                                                    child: InkWell(
                                                                                      onTap: () {
                                                                                        controller.ButtonActionPay();
                                                                                      },
                                                                                      child: Container(
                                                                                        height: 50,
                                                                                        decoration: BoxDecoration(
                                                                                          color: controller.actionPay.value ? AppColors.colorFillBorder : AppColors.colorBasePrimary,
                                                                                          borderRadius: BorderRadius.circular(AppSizes.s4),
                                                                                          border: Border.all(
                                                                                            color: AppColors.colorBasePrimary,
                                                                                          ),
                                                                                        ),
                                                                                        child: Center(
                                                                                          child: Text(
                                                                                            'Qris',
                                                                                            style: Get.textTheme.labelMedium!.copyWith(
                                                                                              fontSize: AppSizes.s14,
                                                                                              color: controller.actionPay.value ? AppColors.colorBaseBlack : AppColors.colorBaseWhite,
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              );
                                                                            },
                                                                          ),
                                                                          AppSizes
                                                                              .s10
                                                                              .height,
                                                                          InputDataComponent(
                                                                            label:
                                                                                'Total Tagihan',
                                                                            hintText:
                                                                                'Rp. 50.000',
                                                                            readOnly:
                                                                                true,
                                                                            controller:
                                                                                TextEditingController(),
                                                                          ),
                                                                          AppSizes
                                                                              .s10
                                                                              .height,
                                                                          InputDataComponent(
                                                                            label:
                                                                                'Nominal Bayar',
                                                                            hintText:
                                                                                'Masukan nominal Bayar',
                                                                            controller:
                                                                                TextEditingController(),
                                                                          ),
                                                                          AppSizes
                                                                              .s10
                                                                              .height,
                                                                          Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.spaceBetween,
                                                                            children: [
                                                                              Text(
                                                                                'Kembalian',
                                                                                style: Get.textTheme.bodyMedium!.copyWith(
                                                                                  fontSize: AppSizes.s15,
                                                                                  fontWeight: FontWeight.bold,
                                                                                  color: AppColors.colorBaseBlack,
                                                                                ),
                                                                              ),
                                                                              Text(
                                                                                'Rp. 50.000',
                                                                                style: Get.textTheme.bodyMedium!.copyWith(
                                                                                  fontSize: AppSizes.s15,
                                                                                  color: AppColors.colorBaseBlack,
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          AppSizes
                                                                              .s10
                                                                              .height,
                                                                          Flexible(
                                                                            child: Button.filled(
                                                                                onPressed: () {
                                                                                  Get.back();
                                                                                  showModalCenter(
                                                                                      context,
                                                                                      SuccesPaymentWidget(
                                                                                        paymentMethod: 'Tunai',
                                                                                        invoice: 'INV-122300',
                                                                                        totalTagihan: 'Rp. 50.000',
                                                                                        nominalBayar: 'Rp. 50.000',
                                                                                        kembalian: 'Rp. 0',
                                                                                        date: '22 February, 11.17',
                                                                                      ));
                                                                                },
                                                                                label: 'Selesai'),
                                                                          )
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ).paddingSymmetric(
                                                                  vertical:
                                                                      AppSizes
                                                                          .s53,
                                                                  horizontal:
                                                                      AppSizes
                                                                          .s40,
                                                                ),
                                                              );
                                                            }
                                                          : () {
                                                              showModalCenter(
                                                                context,
                                                                ListView(
                                                                  children: [
                                                                    Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Row(
                                                                          children: [
                                                                            IconButton(
                                                                              onPressed: () {
                                                                                Get.back();
                                                                                Get.back();
                                                                              },
                                                                              icon: const Icon(
                                                                                Icons.arrow_back,
                                                                                size: 24,
                                                                                color: AppColors.colorBaseBlack,
                                                                              ),
                                                                            ),
                                                                            Text(
                                                                              'Rekam Medis',
                                                                              style: Get.textTheme.labelMedium!.copyWith(fontWeight: FontWeight.bold, fontSize: AppSizes.s24),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        Divider(),
                                                                        AppSizes
                                                                            .s30
                                                                            .height,
                                                                        InputDataComponent(
                                                                          label:
                                                                              'No Rekam Medis',
                                                                          hintText:
                                                                              '099283',
                                                                          controller:
                                                                              TextEditingController(),
                                                                          readOnly:
                                                                              true,
                                                                        ),
                                                                        InputDataComponent(
                                                                          label:
                                                                              'Nama Pasien',
                                                                          hintText:
                                                                              'Bauta',
                                                                          controller:
                                                                              TextEditingController(),
                                                                          readOnly:
                                                                              true,
                                                                        ),
                                                                        InputDataComponent(
                                                                          label:
                                                                              'Alamat',
                                                                          hintText:
                                                                              'Surabaya',
                                                                          controller:
                                                                              TextEditingController(),
                                                                          readOnly:
                                                                              true,
                                                                        ),
                                                                        InputDataComponent(
                                                                          maxLines:
                                                                              10,
                                                                          label:
                                                                              AppConstants.LABEL_TERAPI_TINDAKAN,
                                                                          hintText:
                                                                              'Tindakan',
                                                                          controller:
                                                                              TextEditingController(),
                                                                          textInputType:
                                                                              TextInputType.multiline,
                                                                          readOnly:
                                                                              true,
                                                                        ),
                                                                        AppSizes
                                                                            .s31
                                                                            .height,
                                                                        Column(
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children: [
                                                                            Text(
                                                                              AppConstants.LABEL_OBAT,
                                                                              style: Get.textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w700, fontSize: AppSizes.s14, color: AppColors.colorBaseBlack),
                                                                            ),
                                                                            SizedBox(
                                                                              width: double.infinity,
                                                                              height: AppSizes.setResponsiveHeight(context) * 0.25,
                                                                              child: ListView.builder(
                                                                                shrinkWrap: true,
                                                                                itemCount: 3,
                                                                                itemBuilder: (context, index) {
                                                                                  // var obat = controller
                                                                                  //         .dummySuggestions[
                                                                                  //     index];
                                                                                  return Flexible(
                                                                                    child: Container(
                                                                                      margin: AppSizes.symmetricPadding(vertical: AppSizes.s5),
                                                                                      child: Row(
                                                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                        children: [
                                                                                          Column(
                                                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                                                            children: [
                                                                                              Text(
                                                                                                'Farsevin 400mg',
                                                                                                style: Get.textTheme.bodyMedium!.copyWith(
                                                                                                  fontSize: AppSizes.s15,
                                                                                                  color: AppColors.colorBaseBlack,
                                                                                                ),
                                                                                              ),
                                                                                            ],
                                                                                          ),
                                                                                          Container(
                                                                                            width: 60,
                                                                                            height: 50,
                                                                                            child: CustomTextField(
                                                                                              hintText: '2',
                                                                                              controller: TextEditingController(),
                                                                                              readOnly: true,
                                                                                              keyboardType: TextInputType.number,
                                                                                              //textInputType: TextInputType.name,
                                                                                              hintStyle: Get.textTheme.titleMedium!.copyWith(color: AppColors.colorSecondary600, fontSize: AppSizes.s10),
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
                                                                        AppSizes
                                                                            .s10
                                                                            .height,
                                                                        Column(
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children: [
                                                                            Text(
                                                                              'Metode Pembayaran',
                                                                              style: Get.textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w700, fontSize: AppSizes.s14, color: AppColors.colorBaseBlack),
                                                                            ),
                                                                            AppSizes.s10.height,
                                                                            Obx(
                                                                              () {
                                                                                return Row(
                                                                                  children: [
                                                                                    Flexible(
                                                                                      child: InkWell(
                                                                                        onTap: () {
                                                                                          controller.ButtonActionPay();
                                                                                        },
                                                                                        child: Container(
                                                                                          height: 50,
                                                                                          decoration: BoxDecoration(
                                                                                            color: controller.actionPay.value ? AppColors.colorBasePrimary : AppColors.colorFillBorder,
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
                                                                                                color: controller.actionPay.value ? AppColors.colorBaseWhite : AppColors.colorBaseBlack,
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                    AppSizes.s17.width,
                                                                                    Flexible(
                                                                                      child: InkWell(
                                                                                        onTap: () {
                                                                                          controller.ButtonActionPay();
                                                                                        },
                                                                                        child: Container(
                                                                                          height: 50,
                                                                                          decoration: BoxDecoration(
                                                                                            color: controller.actionPay.value ? AppColors.colorFillBorder : AppColors.colorBasePrimary,
                                                                                            borderRadius: BorderRadius.circular(AppSizes.s4),
                                                                                            border: Border.all(
                                                                                              color: AppColors.colorBasePrimary,
                                                                                            ),
                                                                                          ),
                                                                                          child: Center(
                                                                                            child: Text(
                                                                                              'Qris',
                                                                                              style: Get.textTheme.labelMedium!.copyWith(
                                                                                                fontSize: AppSizes.s14,
                                                                                                color: controller.actionPay.value ? AppColors.colorBaseBlack : AppColors.colorBaseWhite,
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                );
                                                                              },
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        AppSizes
                                                                            .s10
                                                                            .height,
                                                                        InputDataComponent(
                                                                          label:
                                                                              'Total Tagihan',
                                                                          hintText:
                                                                              'Rp. 50.000',
                                                                          readOnly:
                                                                              true,
                                                                          controller:
                                                                              TextEditingController(),
                                                                        ),
                                                                        AppSizes
                                                                            .s10
                                                                            .height,
                                                                        InputDataComponent(
                                                                          label:
                                                                              'Nominal Bayar',
                                                                          hintText:
                                                                              'Masukan nominal Bayar',
                                                                          controller:
                                                                              TextEditingController(),
                                                                        ),
                                                                        AppSizes
                                                                            .s10
                                                                            .height,
                                                                        Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.spaceBetween,
                                                                          children: [
                                                                            Text(
                                                                              'Kembalian',
                                                                              style: Get.textTheme.bodyMedium!.copyWith(
                                                                                fontSize: AppSizes.s15,
                                                                                fontWeight: FontWeight.bold,
                                                                                color: AppColors.colorBaseBlack,
                                                                              ),
                                                                            ),
                                                                            Text(
                                                                              'Rp. 50.000',
                                                                              style: Get.textTheme.bodyMedium!.copyWith(
                                                                                fontSize: AppSizes.s15,
                                                                                color: AppColors.colorBaseBlack,
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        AppSizes
                                                                            .s15
                                                                            .height,
                                                                        Row(
                                                                          spacing:
                                                                              AppSizes.s10,
                                                                          children: [
                                                                            Flexible(
                                                                              child: Button.filled(
                                                                                  onPressed: () {
                                                                                    Get.back();
                                                                                    showModalCenter(
                                                                                      context,
                                                                                      SuccesPaymentWidget(
                                                                                        paymentMethod: 'Tunai',
                                                                                        invoice: 'INV-122300',
                                                                                        totalTagihan: 'Rp. 50.000',
                                                                                        nominalBayar: 'Rp. 50.000',
                                                                                        kembalian: 'Rp. 0',
                                                                                        date: '22 February, 11.17',
                                                                                      ),
                                                                                    );
                                                                                  },
                                                                                  label: 'Selesai'),
                                                                            )
                                                                          ],
                                                                        )
                                                                      ],
                                                                    ),
                                                                  ],
                                                                ),
                                                              );
                                                            },
                                                  icon: const Icon(
                                                    Icons.more_horiz,
                                                    size: 24,
                                                    color: Color(0xfff828282),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                      .toList(),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ).paddingSymmetric(
            vertical: AppSizes.s41,
            horizontal: AppSizes.s28,
          ),
        );
      },
    );
  }
}

