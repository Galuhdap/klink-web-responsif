import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:klinik_web_responsif/core/components/button_component.dart';
import 'package:klinik_web_responsif/core/components/input_data_component.dart';
import 'package:klinik_web_responsif/core/components/modal/show_modal_tanda_tanya_componenet.dart';
import 'package:klinik_web_responsif/core/components/popup_menu_component.dart';
import 'package:klinik_web_responsif/core/components/search_new_component.dart';
import 'package:klinik_web_responsif/core/components/show_bottom_dialog.dart';
import 'package:klinik_web_responsif/core/components/show_center_dialog.dart';
import 'package:klinik_web_responsif/core/config/responsive.dart';
import 'package:klinik_web_responsif/core/resources/constans/app_constants.dart';
import 'package:klinik_web_responsif/core/styles/app_colors.dart';
import 'package:klinik_web_responsif/core/styles/app_sizes.dart';
import 'package:klinik_web_responsif/core/utils/extensions/sized_box_ext.dart';
import 'package:klinik_web_responsif/presentations/menu_dashboard/widget/build_app_bar.dart';
import 'package:klinik_web_responsif/presentations/patient/controller/patient_controller.dart';
import 'package:klinik_web_responsif/routes/app_routes.dart';

class DataPatientScreen extends StatelessWidget {
  const DataPatientScreen({super.key});

  // @override
  @override
  Widget build(BuildContext context) {
    return GetBuilder<PatientController>(
      init: PatientController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: Color(0xfffF8F8F8),
          appBar: PreferredSize(
            preferredSize: Responsive.isMobile(context)
                ? Size.fromHeight(90.0)
                : Size.fromHeight(110.0),
            child: BuildAppBar(
              isMake: true,
              title: 'Klinik Chania Care Center',
              withSearchInput: true,
              searchController: controller.searchController,
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
                          AppConstants.LABEL_DATA_PASIEN,
                          style: Get.textTheme.labelMedium!.copyWith(
                              fontSize: AppSizes.s16,
                              color: AppColors.colorBaseBlack,
                              fontWeight: FontWeight.bold),
                        ),
                        Responsive.isMobile(context)
                            ? InkWell(
                                onTap: () {
                                  showModalCenter(
                                    context,
                                    ListView(
                                      // crossAxisAlignment:
                                      //     CrossAxisAlignment.start,
                                      children: [
                                        Center(
                                          child: Text(
                                            'Tambah Data',
                                            style: Get.textTheme.labelMedium!
                                                .copyWith(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: AppSizes.s16),
                                          ),
                                        ),
                                        AppSizes.s12.height,
                                        Divider(),
                                        InputDataComponent(
                                          label: 'Nama Pasien',
                                          hintText: 'Nama Pasien',
                                          controller: TextEditingController(),
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Jenis Kelamin',
                                              style: Get.textTheme.bodyMedium!
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontSize: AppSizes.s14,
                                                      color: AppColors
                                                          .colorBaseBlack),
                                            ),
                                            AppSizes.s12.height,
                                            DropdownSearch<String>(
                                              items: (f, cs) => [
                                                "Laki-Laki",
                                                'Perempuan',
                                              ],
                                              dropdownBuilder:
                                                  (context, selectedItem) {
                                                return Text(
                                                  selectedItem ??
                                                      "Jenis Kelamin",
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                    color: selectedItem == null
                                                        ? Colors.grey
                                                        : Colors.black,
                                                  ),
                                                );
                                              },
                                              popupProps: PopupProps.menu(
                                                  disabledItemFn: (item) =>
                                                      item == 'Item 3',
                                                  fit: FlexFit.loose),
                                              onChanged:
                                                  (String? selectedValue) {
                                                print(
                                                    "Selected: $selectedValue");
                                              },
                                            ),
                                            AppSizes.s12.height,
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Tanggal Lahir',
                                              style: Get.textTheme.bodyMedium!
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontSize: AppSizes.s14,
                                                      color: AppColors
                                                          .colorBaseBlack),
                                            ),
                                            AppSizes.s12.height,
                                            InkWell(
                                              onTap: () async {
                                                final DateTime? pickedDate =
                                                    await showDatePicker(
                                                  context: context,
                                                  initialDate:
                                                      DateTime(2021, 7, 25),
                                                  firstDate: DateTime(2021),
                                                  lastDate: DateTime(2022),
                                                );
                                              },
                                              child: Container(
                                                  padding:
                                                      AppSizes.symmetricPadding(
                                                          vertical: AppSizes.s5,
                                                          horizontal:
                                                              AppSizes.s20),
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color: AppColors
                                                          .colorSecondary400,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            AppSizes.s4),
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      Icon(
                                                        Icons.calendar_month,
                                                        weight: AppSizes.s20,
                                                        size: AppSizes.s30,
                                                        color: AppColors
                                                            .colorNeutrals100,
                                                      ),
                                                      AppSizes.s10.width,
                                                      Text(
                                                        '12/12/2020',
                                                        style: Get.textTheme
                                                            .bodySmall!
                                                            .copyWith(
                                                          fontSize:
                                                              AppSizes.s14,
                                                          color: AppColors
                                                              .colorNeutrals400,
                                                        ),
                                                      ),
                                                    ],
                                                  ).paddingSymmetric(
                                                      vertical: AppSizes.s5)),
                                            ),
                                            AppSizes.s12.height,
                                          ],
                                        ),
                                        InputDataComponent(
                                          label: 'Alamat',
                                          hintText: 'Alamat',
                                          controller: TextEditingController(),
                                        ),
                                        InputDataComponent(
                                          label: 'No Telpon',
                                          hintText: 'No Telpon',
                                          controller: TextEditingController(),
                                        ),
                                        InputDataComponent(
                                          label: 'NIK',
                                          hintText: 'NIK',
                                          controller: TextEditingController(),
                                        ),
                                        Row(
                                          children: [
                                            Flexible(
                                              child: Button.outlined(
                                                  onPressed: () {
                                                    Get.back();
                                                  },
                                                  label: 'Batal'),
                                            ),
                                            AppSizes.s12.width,
                                            Flexible(
                                              child: Button.filled(
                                                  onPressed: () {},
                                                  label: 'Simpan'),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  );
                                },
                                child: Container(
                                  width: 97,
                                  height: 26,
                                  decoration: BoxDecoration(
                                    color: AppColors.colorBasePrimary,
                                    borderRadius:
                                        BorderRadius.circular(AppSizes.s4),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Daftar Pasien',
                                      style: Get.textTheme.bodyMedium!.copyWith(
                                          fontSize: AppSizes.s10,
                                          color: AppColors.colorBaseWhite),
                                    ),
                                  ),
                                ),
                              )
                            : Container(),
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
                        AppSizes.s17.width,
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(AppSizes.s4),
                            border: Border.all(color: Color(0xfffF0F0F0)),
                            color: AppColors.colorBaseWhite,
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 0),
                                blurRadius: 15,
                                spreadRadius: 0,
                                color: AppColors.colorNeutrals300.withAlpha(40),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Icon(
                              Iconsax.filter,
                              color: AppColors.colorSecondary500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  height: 500,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppSizes.s4),
                    color: AppColors.colorBaseWhite,
                  ),
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
                                    AppConstants.LABEL_NO,
                                    style: Get.textTheme.labelLarge!.copyWith(
                                        fontSize: AppSizes.s14,
                                        color: AppColors.colorBaseBlack),
                                  ),
                                ),
                                DataColumn(
                                  label: Padding(
                                    padding: EdgeInsets.only(
                                      left: MediaQuery.of(context).size.width *
                                          0.02,
                                      right: MediaQuery.of(context).size.width *
                                          0.04,
                                    ),
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
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                        left:
                                            MediaQuery.of(context).size.width *
                                                0.02,
                                      ),
                                      child: Text(
                                        AppConstants.LABEL_NO_REKAM_MEDIS,
                                        style: Get.textTheme.labelLarge!
                                            .copyWith(
                                                fontSize: AppSizes.s14,
                                                color:
                                                    AppColors.colorBaseBlack),
                                      ),
                                    ),
                                  ),
                                ),
                                DataColumn(
                                  label: Padding(
                                    padding: EdgeInsets.only(
                                      left: MediaQuery.of(context).size.width *
                                          0.02,
                                    ),
                                    child: Text(
                                      AppConstants.LABEL_NIK,
                                      style: Get.textTheme.labelLarge!.copyWith(
                                          fontSize: AppSizes.s14,
                                          color: AppColors.colorBaseBlack),
                                    ),
                                  ),
                                ),
                                DataColumn(
                                  label: Padding(
                                    padding: EdgeInsets.only(
                                      left: MediaQuery.of(context).size.width *
                                          0.02,
                                    ),
                                    child: Text(
                                      AppConstants.LABEL_UMUR,
                                      style: Get.textTheme.labelLarge!.copyWith(
                                          fontSize: AppSizes.s14,
                                          color: AppColors.colorBaseBlack),
                                    ),
                                  ),
                                ),
                                DataColumn(
                                  label: Padding(
                                    padding: EdgeInsets.only(
                                      left: MediaQuery.of(context).size.width *
                                          0.02,
                                    ),
                                    child: Text(
                                      AppConstants.LABEL_JENIS_KELAMIN,
                                      style: Get.textTheme.labelLarge!.copyWith(
                                          fontSize: AppSizes.s14,
                                          color: AppColors.colorBaseBlack),
                                    ),
                                  ),
                                ),
                                DataColumn(
                                  label: Padding(
                                    padding: EdgeInsets.only(
                                      left: MediaQuery.of(context).size.width *
                                          0.02,
                                    ),
                                    child: Text(
                                      AppConstants.LABEL_TGL_LAHIR,
                                      style: Get.textTheme.labelLarge!.copyWith(
                                          fontSize: AppSizes.s14,
                                          color: AppColors.colorBaseBlack),
                                    ),
                                  ),
                                ),
                                DataColumn(
                                  label: Padding(
                                    padding: EdgeInsets.only(
                                      left: MediaQuery.of(context).size.width *
                                          0.02,
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
                                                      0.02,
                                                  right: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.04,
                                                ),
                                                child: Text(
                                                  patient["nama_pasien"],
                                                  style: Get
                                                      .textTheme.labelLarge!
                                                      .copyWith(
                                                    fontSize: AppSizes.s16,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            DataCell(
                                              Padding(
                                                padding: EdgeInsets.only(
                                                  left: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.02,
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    patient["rm"],
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            DataCell(
                                              Padding(
                                                padding: EdgeInsets.only(),
                                                child: Center(
                                                  child: Text(
                                                    patient["nik"],
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            DataCell(
                                              Padding(
                                                padding: EdgeInsets.only(
                                                  left: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.02,
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    patient["umur"],
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            DataCell(
                                              Padding(
                                                padding: EdgeInsets.only(
                                                  left: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.02,
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    patient["jenis_kelamin"],
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            DataCell(
                                              Padding(
                                                padding: EdgeInsets.only(
                                                  left: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.015,
                                                ),
                                                child: Center(
                                                  child: Center(
                                                    child: Text(
                                                      patient["tgl_lahir"],
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            DataCell(
                                              Padding(
                                                padding: EdgeInsets.only(
                                                  left: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.02,
                                                ),
                                                child:
                                                    Responsive.isMobile(context)
                                                        ? IconButton(
                                                            onPressed: () {
                                                              showModalBottom(
                                                                  context,
                                                                  Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      AppSizes
                                                                          .s8
                                                                          .height,
                                                                      Center(
                                                                        child:
                                                                            Container(
                                                                          width:
                                                                              AppSizes.s56,
                                                                          height:
                                                                              AppSizes.s4,
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            borderRadius:
                                                                                BorderRadius.circular(AppSizes.s8),
                                                                            color:
                                                                                AppColors.colorNeutrals100,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      AppSizes
                                                                          .s11
                                                                          .height,
                                                                      Column(
                                                                        spacing:
                                                                            24,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          InkWell(
                                                                            onTap:
                                                                                () {
                                                                              showModalCenter(
                                                                                context,
                                                                                ListView(
                                                                                  // crossAxisAlignment:
                                                                                  //     CrossAxisAlignment.start,
                                                                                  children: [
                                                                                    Center(
                                                                                      child: Text(
                                                                                        'Detail',
                                                                                        style: Get.textTheme.labelMedium!.copyWith(fontWeight: FontWeight.bold, fontSize: AppSizes.s16),
                                                                                      ),
                                                                                    ),
                                                                                    AppSizes.s12.height,
                                                                                    Divider(),
                                                                                    InputDataComponent(
                                                                                      label: 'Nama Pasien',
                                                                                      hintText: 'Nama Pasien',
                                                                                      controller: TextEditingController(),
                                                                                    ),
                                                                                    Column(
                                                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                                                      children: [
                                                                                        Text(
                                                                                          'Jenis Kelamin',
                                                                                          style: Get.textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w700, fontSize: AppSizes.s14, color: AppColors.colorBaseBlack),
                                                                                        ),
                                                                                        AppSizes.s12.height,
                                                                                        DropdownSearch<String>(
                                                                                          items: (f, cs) => [
                                                                                            "Laki-Laki",
                                                                                            'Perempuan',
                                                                                          ],
                                                                                          dropdownBuilder: (context, selectedItem) {
                                                                                            return Text(
                                                                                              selectedItem ?? "Jenis Kelamin",
                                                                                              style: TextStyle(
                                                                                                fontSize: 14,
                                                                                                fontWeight: FontWeight.w500,
                                                                                                color: selectedItem == null ? Colors.grey : Colors.black,
                                                                                              ),
                                                                                            );
                                                                                          },
                                                                                          popupProps: PopupProps.menu(disabledItemFn: (item) => item == 'Item 3', fit: FlexFit.loose),
                                                                                          onChanged: (String? selectedValue) {
                                                                                            print("Selected: $selectedValue");
                                                                                          },
                                                                                        ),
                                                                                        AppSizes.s12.height,
                                                                                      ],
                                                                                    ),
                                                                                    Column(
                                                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                                                      children: [
                                                                                        Text(
                                                                                          'Tanggal Lahir',
                                                                                          style: Get.textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w700, fontSize: AppSizes.s14, color: AppColors.colorBaseBlack),
                                                                                        ),
                                                                                        AppSizes.s12.height,
                                                                                        InkWell(
                                                                                          onTap: () async {
                                                                                            final DateTime? pickedDate = await showDatePicker(
                                                                                              context: context,
                                                                                              initialDate: DateTime(2021, 7, 25),
                                                                                              firstDate: DateTime(2021),
                                                                                              lastDate: DateTime(2022),
                                                                                            );
                                                                                          },
                                                                                          child: Container(
                                                                                              padding: AppSizes.symmetricPadding(vertical: AppSizes.s5, horizontal: AppSizes.s20),
                                                                                              decoration: BoxDecoration(
                                                                                                border: Border.all(
                                                                                                  color: AppColors.colorSecondary400,
                                                                                                ),
                                                                                                borderRadius: BorderRadius.circular(AppSizes.s4),
                                                                                              ),
                                                                                              child: Row(
                                                                                                children: [
                                                                                                  Icon(
                                                                                                    Icons.calendar_month,
                                                                                                    weight: AppSizes.s20,
                                                                                                    size: AppSizes.s30,
                                                                                                    color: AppColors.colorNeutrals100,
                                                                                                  ),
                                                                                                  AppSizes.s10.width,
                                                                                                  Text(
                                                                                                    '12/12/2020',
                                                                                                    style: Get.textTheme.bodySmall!.copyWith(
                                                                                                      fontSize: AppSizes.s14,
                                                                                                      color: AppColors.colorNeutrals400,
                                                                                                    ),
                                                                                                  ),
                                                                                                ],
                                                                                              ).paddingSymmetric(vertical: AppSizes.s5)),
                                                                                        ),
                                                                                        AppSizes.s12.height,
                                                                                      ],
                                                                                    ),
                                                                                    InputDataComponent(
                                                                                      label: 'Alamat',
                                                                                      hintText: 'Alamat',
                                                                                      controller: TextEditingController(),
                                                                                    ),
                                                                                    InputDataComponent(
                                                                                      label: 'No Telpon',
                                                                                      hintText: 'No Telpon',
                                                                                      controller: TextEditingController(),
                                                                                    ),
                                                                                    InputDataComponent(
                                                                                      label: 'NIK',
                                                                                      hintText: 'NIK',
                                                                                      controller: TextEditingController(),
                                                                                    ),
                                                                                    Row(
                                                                                      children: [
                                                                                        Flexible(
                                                                                          child: Button.outlined(
                                                                                              onPressed: () {
                                                                                                Get.back();
                                                                                              },
                                                                                              label: 'Batal'),
                                                                                        ),
                                                                                        AppSizes.s12.width,
                                                                                        Flexible(
                                                                                          child: Button.filled(onPressed: () {}, label: 'Simpan'),
                                                                                        ),
                                                                                      ],
                                                                                    )
                                                                                  ],
                                                                                ),
                                                                              );
                                                                            },
                                                                            child:
                                                                                Text(
                                                                              'Detail',
                                                                              style: Get.textTheme.labelLarge!.copyWith(
                                                                                fontSize: AppSizes.s14,
                                                                                color: AppColors.colorBaseBlack,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          InkWell(
                                                                            onTap:
                                                                                () {
                                                                              Get.toNamed(AppRoutes.rekamMedis);
                                                                            },
                                                                            child:
                                                                                Text(
                                                                              'Rekam Medis',
                                                                              style: Get.textTheme.labelLarge!.copyWith(
                                                                                fontSize: AppSizes.s14,
                                                                                color: AppColors.colorBaseBlack,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          InkWell(
                                                                            onTap:
                                                                                () {
                                                                              showModalCenter(
                                                                                context,
                                                                                ShowModalTandaTanyaComponent(
                                                                                  label: 'Apakah anda yakin ingin menambahkan Farhan ke antrian ?',
                                                                                  onTapNo: () {
                                                                                    Get.back();
                                                                                  },
                                                                                  onTapYes: () {
                                                                                    showModalCenter(
                                                                                      context,
                                                                                      Column(
                                                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                                                        spacing: 20,
                                                                                        children: [
                                                                                          Container(
                                                                                            width: 200,
                                                                                            height: 200,
                                                                                            decoration: BoxDecoration(
                                                                                              borderRadius: BorderRadius.circular(AppSizes.s100),
                                                                                              color: AppColors.colorBasePrimary,
                                                                                            ),
                                                                                            child: Center(
                                                                                              child: Text(
                                                                                                '19',
                                                                                                style: Get.textTheme.labelLarge!.copyWith(
                                                                                                  fontSize: AppSizes.s100,
                                                                                                  color: AppColors.colorBaseWhite,
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                          Center(
                                                                                            child: Text(
                                                                                              'Nomor Antrian Ditambahkan',
                                                                                              style: Get.textTheme.labelLarge!.copyWith(
                                                                                                fontSize: AppSizes.s24,
                                                                                                color: AppColors.colorNeutrals200,
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                          Center(
                                                                                              child: Button.filled(
                                                                                            onPressed: () {
                                                                                              Get.back();
                                                                                              Get.back();
                                                                                            },
                                                                                            label: 'Selesai',
                                                                                          )),
                                                                                        ],
                                                                                      ),
                                                                                    );
                                                                                  },
                                                                                ),
                                                                              );
                                                                            },
                                                                            child:
                                                                                Text(
                                                                              'Tambah Ke Antrian',
                                                                              style: Get.textTheme.labelLarge!.copyWith(
                                                                                fontSize: AppSizes.s14,
                                                                                color: AppColors.colorBaseBlack,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          InkWell(
                                                                            onTap:
                                                                                () {
                                                                              showModalCenter(
                                                                                context,
                                                                                Column(
                                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                                  children: [
                                                                                    Center(
                                                                                      child: Text(
                                                                                        'Kartu Berobat',
                                                                                        style: Get.textTheme.labelMedium!.copyWith(fontWeight: FontWeight.bold, fontSize: AppSizes.s16),
                                                                                      ),
                                                                                    ),
                                                                                    AppSizes.s12.height,
                                                                                    Divider(),
                                                                                    InputDataComponent(
                                                                                      label: 'Nama Pasien',
                                                                                      hintText: 'Farhan',
                                                                                      controller: TextEditingController(),
                                                                                      readOnly: true,
                                                                                    ),
                                                                                    InputDataComponent(
                                                                                      label: 'No Rekam Medis',
                                                                                      hintText: '29837',
                                                                                      controller: TextEditingController(),
                                                                                      readOnly: true,
                                                                                    ),
                                                                                    InputDataComponent(
                                                                                      label: 'Alamat',
                                                                                      hintText: 'Malang',
                                                                                      controller: TextEditingController(),
                                                                                      readOnly: true,
                                                                                    ),
                                                                                    Row(
                                                                                      children: [
                                                                                        Flexible(
                                                                                          child: Button.outlined(
                                                                                              onPressed: () {
                                                                                                Get.back();
                                                                                              },
                                                                                              label: 'Batal'),
                                                                                        ),
                                                                                        AppSizes.s12.width,
                                                                                        Flexible(
                                                                                          child: Button.filled(onPressed: () {}, label: 'Print'),
                                                                                        ),
                                                                                      ],
                                                                                    )
                                                                                  ],
                                                                                ),
                                                                              );
                                                                            },
                                                                            child:
                                                                                Text(
                                                                              'Kartu Berobat',
                                                                              style: Get.textTheme.labelLarge!.copyWith(
                                                                                fontSize: AppSizes.s14,
                                                                                color: AppColors.colorBaseBlack,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          InkWell(
                                                                            onTap:
                                                                                () {
                                                                              showModalCenter(
                                                                                context,
                                                                                ShowModalTandaTanyaComponent(
                                                                                  label: 'Apakah anda yakin ingin menghapus data Farhan ?',
                                                                                  onTapNo: () {
                                                                                    Get.back();
                                                                                  },
                                                                                  onTapYes: () {},
                                                                                ),
                                                                              );
                                                                            },
                                                                            child:
                                                                                Text(
                                                                              'Hapus',
                                                                              style: Get.textTheme.labelLarge!.copyWith(
                                                                                fontSize: AppSizes.s14,
                                                                                color: AppColors.colorBaseBlack,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ).paddingOnly(
                                                                        left: AppSizes
                                                                            .s24,
                                                                        bottom:
                                                                            AppSizes.s20,
                                                                      ),
                                                                    ],
                                                                  ));
                                                            },
                                                            icon: Icon(
                                                              Icons.more_horiz,
                                                              size: 24,
                                                              color: Color(
                                                                  0xfff828282),
                                                            ),
                                                          )
                                                        : Center(
                                                            child:
                                                                PopupMenuButton(
                                                              icon: const Icon(
                                                                Icons
                                                                    .more_horiz,
                                                                size: 24,
                                                                color: Color(
                                                                    0xfff828282),
                                                              ),
                                                              onSelected:
                                                                  (value) {
                                                                value();
                                                              },
                                                              itemBuilder:
                                                                  (context) => [
                                                                PopupMenuItem(
                                                                  child:
                                                                      PopupMenuActionComponent(
                                                                    label:
                                                                        'Detail',
                                                                  ),
                                                                  value: () {
                                                                    debugPrint(
                                                                        'Detial');
                                                                  },
                                                                  onTap: () {
                                                                    showModalCenter(
                                                                      context,
                                                                      ListView(
                                                                        // crossAxisAlignment:
                                                                        //     CrossAxisAlignment.start,
                                                                        children: [
                                                                          Center(
                                                                            child:
                                                                                Text(
                                                                              'Detail',
                                                                              style: Get.textTheme.labelMedium!.copyWith(fontWeight: FontWeight.bold, fontSize: AppSizes.s16),
                                                                            ),
                                                                          ),
                                                                          AppSizes
                                                                              .s12
                                                                              .height,
                                                                          Divider(),
                                                                          InputDataComponent(
                                                                            label:
                                                                                'Nama Pasien',
                                                                            hintText:
                                                                                'Nama Pasien',
                                                                            controller:
                                                                                TextEditingController(),
                                                                          ),
                                                                          Column(
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            children: [
                                                                              Text(
                                                                                'Jenis Kelamin',
                                                                                style: Get.textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w700, fontSize: AppSizes.s14, color: AppColors.colorBaseBlack),
                                                                              ),
                                                                              AppSizes.s12.height,
                                                                              DropdownSearch<String>(
                                                                                items: (f, cs) => [
                                                                                  "Laki-Laki",
                                                                                  'Perempuan',
                                                                                ],
                                                                                dropdownBuilder: (context, selectedItem) {
                                                                                  return Text(
                                                                                    selectedItem ?? "Jenis Kelamin",
                                                                                    style: TextStyle(
                                                                                      fontSize: 14,
                                                                                      fontWeight: FontWeight.w500,
                                                                                      color: selectedItem == null ? Colors.grey : Colors.black,
                                                                                    ),
                                                                                  );
                                                                                },
                                                                                popupProps: PopupProps.menu(disabledItemFn: (item) => item == 'Item 3', fit: FlexFit.loose),
                                                                                onChanged: (String? selectedValue) {
                                                                                  print("Selected: $selectedValue");
                                                                                },
                                                                              ),
                                                                              AppSizes.s12.height,
                                                                            ],
                                                                          ),
                                                                          Column(
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            children: [
                                                                              Text(
                                                                                'Tanggal Lahir',
                                                                                style: Get.textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w700, fontSize: AppSizes.s14, color: AppColors.colorBaseBlack),
                                                                              ),
                                                                              AppSizes.s12.height,
                                                                              InkWell(
                                                                                onTap: () async {
                                                                                  final DateTime? pickedDate = await showDatePicker(
                                                                                    context: context,
                                                                                    initialDate: DateTime(2021, 7, 25),
                                                                                    firstDate: DateTime(2021),
                                                                                    lastDate: DateTime(2022),
                                                                                  );
                                                                                },
                                                                                child: Container(
                                                                                    padding: AppSizes.symmetricPadding(vertical: AppSizes.s5, horizontal: AppSizes.s20),
                                                                                    decoration: BoxDecoration(
                                                                                      border: Border.all(
                                                                                        color: AppColors.colorSecondary400,
                                                                                      ),
                                                                                      borderRadius: BorderRadius.circular(AppSizes.s4),
                                                                                    ),
                                                                                    child: Row(
                                                                                      children: [
                                                                                        Icon(
                                                                                          Icons.calendar_month,
                                                                                          weight: AppSizes.s20,
                                                                                          size: AppSizes.s30,
                                                                                          color: AppColors.colorNeutrals100,
                                                                                        ),
                                                                                        AppSizes.s10.width,
                                                                                        Text(
                                                                                          '12/12/2020',
                                                                                          style: Get.textTheme.bodySmall!.copyWith(
                                                                                            fontSize: AppSizes.s14,
                                                                                            color: AppColors.colorNeutrals400,
                                                                                          ),
                                                                                        ),
                                                                                      ],
                                                                                    ).paddingSymmetric(vertical: AppSizes.s5)),
                                                                              ),
                                                                              AppSizes.s12.height,
                                                                            ],
                                                                          ),
                                                                          InputDataComponent(
                                                                            label:
                                                                                'Alamat',
                                                                            hintText:
                                                                                'Alamat',
                                                                            controller:
                                                                                TextEditingController(),
                                                                          ),
                                                                          InputDataComponent(
                                                                            label:
                                                                                'No Telpon',
                                                                            hintText:
                                                                                'No Telpon',
                                                                            controller:
                                                                                TextEditingController(),
                                                                          ),
                                                                          InputDataComponent(
                                                                            label:
                                                                                'NIK',
                                                                            hintText:
                                                                                'NIK',
                                                                            controller:
                                                                                TextEditingController(),
                                                                          ),
                                                                          Row(
                                                                            children: [
                                                                              Flexible(
                                                                                child: Button.outlined(
                                                                                    onPressed: () {
                                                                                      Get.back();
                                                                                    },
                                                                                    label: 'Batal'),
                                                                              ),
                                                                              AppSizes.s12.width,
                                                                              Flexible(
                                                                                child: Button.filled(onPressed: () {}, label: 'Simpan'),
                                                                              ),
                                                                            ],
                                                                          )
                                                                        ],
                                                                      ),
                                                                    );
                                                                  },
                                                                ),
                                                                PopupMenuItem(
                                                                  child:
                                                                      PopupMenuActionComponent(
                                                                    label:
                                                                        'Hapus',
                                                                  ),
                                                                  value: () {
                                                                    debugPrint(
                                                                        'Hapus');
                                                                  },
                                                                  onTap: () {
                                                                    showModalCenter(
                                                                      context,
                                                                      ShowModalTandaTanyaComponent(
                                                                        label:
                                                                            'Apakah anda yakin ingin menghapus data Farhan ?',
                                                                        onTapNo:
                                                                            () {
                                                                          Get.back();
                                                                        },
                                                                        onTapYes:
                                                                            () {},
                                                                      ),
                                                                    );
                                                                  },
                                                                ),
                                                                PopupMenuItem(
                                                                  child:
                                                                      PopupMenuActionComponent(
                                                                    label:
                                                                        'Rekam Medis',
                                                                  ),
                                                                  value: () {
                                                                    debugPrint(
                                                                        'Rekam Medis');
                                                                  },
                                                                  onTap: () {
                                                                    Get.toNamed(
                                                                        AppRoutes
                                                                            .rekamMedis);
                                                                  },
                                                                ),
                                                                PopupMenuItem(
                                                                  child:
                                                                      PopupMenuActionComponent(
                                                                    label:
                                                                        'Tambahkan Antrian',
                                                                  ),
                                                                  value: () {
                                                                    debugPrint(
                                                                        'Tambah Antrian');
                                                                  },
                                                                  onTap: () {
                                                                    showModalCenter(
                                                                      context,
                                                                      ShowModalTandaTanyaComponent(
                                                                        label:
                                                                            'Apakah anda yakin ingin menambahkan Farhan ke antrian ?',
                                                                        onTapNo:
                                                                            () {
                                                                          Get.back();
                                                                        },
                                                                        onTapYes:
                                                                            () {
                                                                          showModalCenter(
                                                                            context,
                                                                            Column(
                                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                                              spacing: 20,
                                                                              children: [
                                                                                Container(
                                                                                  width: 200,
                                                                                  height: 200,
                                                                                  decoration: BoxDecoration(
                                                                                    borderRadius: BorderRadius.circular(AppSizes.s100),
                                                                                    color: AppColors.colorBasePrimary,
                                                                                  ),
                                                                                  child: Center(
                                                                                    child: Text(
                                                                                      '19',
                                                                                      style: Get.textTheme.labelLarge!.copyWith(
                                                                                        fontSize: AppSizes.s100,
                                                                                        color: AppColors.colorBaseWhite,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                Center(
                                                                                  child: Text(
                                                                                    'Nomor Antrian Ditambahkan',
                                                                                    style: Get.textTheme.labelLarge!.copyWith(
                                                                                      fontSize: AppSizes.s24,
                                                                                      color: AppColors.colorNeutrals200,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                Center(
                                                                                  child: Button.filled(
                                                                                    onPressed: () {
                                                                                      Get.back();
                                                                                      Get.back();
                                                                                    },
                                                                                    label: 'Selesai',
                                                                                  ).paddingSymmetric(
                                                                                    horizontal: AppSizes.s300,
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          );
                                                                        },
                                                                      ),
                                                                    );
                                                                  },
                                                                ),
                                                                PopupMenuItem(
                                                                  child:
                                                                      PopupMenuActionComponent(
                                                                    label:
                                                                        'Kartu Berobat',
                                                                  ),
                                                                  value: () {
                                                                    debugPrint(
                                                                        'Kartu Berobat');
                                                                  },
                                                                  onTap: () {
                                                                    showModalCenter(
                                                                      context,
                                                                      Column(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        children: [
                                                                          Center(
                                                                            child:
                                                                                Text(
                                                                              'Kartu Berobat',
                                                                              style: Get.textTheme.labelMedium!.copyWith(fontWeight: FontWeight.bold, fontSize: AppSizes.s16),
                                                                            ),
                                                                          ),
                                                                          AppSizes
                                                                              .s12
                                                                              .height,
                                                                          Divider(),
                                                                          InputDataComponent(
                                                                            label:
                                                                                'Nama Pasien',
                                                                            hintText:
                                                                                'Farhan',
                                                                            controller:
                                                                                TextEditingController(),
                                                                            readOnly:
                                                                                true,
                                                                          ),
                                                                          InputDataComponent(
                                                                            label:
                                                                                'No Rekam Medis',
                                                                            hintText:
                                                                                '29837',
                                                                            controller:
                                                                                TextEditingController(),
                                                                            readOnly:
                                                                                true,
                                                                          ),
                                                                          InputDataComponent(
                                                                            label:
                                                                                'Alamat',
                                                                            hintText:
                                                                                'Malang',
                                                                            controller:
                                                                                TextEditingController(),
                                                                            readOnly:
                                                                                true,
                                                                          ),
                                                                          Row(
                                                                            children: [
                                                                              Flexible(
                                                                                child: Button.outlined(
                                                                                    onPressed: () {
                                                                                      Get.back();
                                                                                    },
                                                                                    label: 'Batal'),
                                                                              ),
                                                                              AppSizes.s12.width,
                                                                              Flexible(
                                                                                child: Button.filled(onPressed: () {}, label: 'Print'),
                                                                              ),
                                                                            ],
                                                                          )
                                                                        ],
                                                                      ).paddingSymmetric(
                                                                          horizontal:
                                                                              AppSizes.s200),
                                                                    );
                                                                  },
                                                                ),
                                                              ],
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
