import 'package:drop_down_search_field/drop_down_search_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:klinik_web_responsif/core/components/button_component.dart';
import 'package:klinik_web_responsif/core/components/input_component.dart';
import 'package:klinik_web_responsif/core/components/input_data_component.dart';
import 'package:klinik_web_responsif/core/components/popup_menu_component.dart';
import 'package:klinik_web_responsif/core/components/search_new_component.dart';
import 'package:klinik_web_responsif/core/components/show_bottom_dialog.dart';
import 'package:klinik_web_responsif/core/components/show_center_dialog.dart';
import 'package:klinik_web_responsif/core/components/show_modal_right_component.dart';
import 'package:klinik_web_responsif/core/config/responsive.dart';
import 'package:klinik_web_responsif/core/resources/constans/app_constants.dart';
import 'package:klinik_web_responsif/core/styles/app_colors.dart';
import 'package:klinik_web_responsif/core/styles/app_sizes.dart';
import 'package:klinik_web_responsif/core/utils/extensions/date_ext.dart';
import 'package:klinik_web_responsif/core/utils/extensions/int_ext.dart';
import 'package:klinik_web_responsif/core/utils/extensions/sized_box_ext.dart';
import 'package:klinik_web_responsif/presentations/menu_dashboard/widget/build_app_bar.dart';
import 'package:klinik_web_responsif/presentations/patient/controller/rekam_medis_controller.dart';
import 'package:number_paginator/number_paginator.dart';

class RekamMedisScreen extends StatelessWidget {
  final String name;
  const RekamMedisScreen({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RekamMedisController>(
      init: RekamMedisController(),
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
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Responsive.isMobile(context)
                                ? IconButton(
                                    onPressed: () {
                                      Get.back();
                                      Get.back();
                                    },
                                    icon: Icon(Icons.arrow_back_ios),
                                  )
                                : IconButton(
                                    onPressed: () {
                                      Get.back();
                                    },
                                    icon: Icon(Icons.arrow_back_ios),
                                  ),
                            AppSizes.s20.width,
                            Text(
                              AppConstants.LABEL_DAFTAR_REKAM_MEDIS,
                              style: Get.textTheme.labelMedium!.copyWith(
                                  fontSize: Responsive.isMobile(context)
                                      ? AppSizes.s15
                                      : AppSizes.s20,
                                  color: AppColors.colorBaseBlack,
                                  fontWeight: FontWeight.bold),
                            ),
                            AppSizes.s5.width,
                            Icon(Icons.arrow_forward),
                            AppSizes.s5.width,
                            Text(
                              name,
                              style: Get.textTheme.labelMedium!.copyWith(
                                  fontSize: Responsive.isMobile(context)
                                      ? AppSizes.s15
                                      : AppSizes.s20,
                                  color: AppColors.colorBaseBlack,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        controller.role.value == "DOKTER"
                            ? Responsive.isDesktop(context)
                                ? InkWell(
                                    onTap: () {
                                      showRightModal(
                                        context,
                                        Row(
                                          children: [
                                            Flexible(
                                              child: Column(
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
                                                          color: AppColors
                                                              .colorBaseBlack,
                                                        ),
                                                      ),
                                                      Text(
                                                        'Rekam Medis',
                                                        style: Get.textTheme
                                                            .labelMedium!
                                                            .copyWith(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize:
                                                                    AppSizes
                                                                        .s24),
                                                      ),
                                                    ],
                                                  ),
                                                  Divider(),
                                                  AppSizes.s48.height,
                                                  InputDataComponent(
                                                    label: 'No Rekam Medis',
                                                    hintText: 'No Rekam Medis',
                                                    controller:
                                                        TextEditingController(),
                                                  ),
                                                  InputDataComponent(
                                                    label: 'Nama Pasien',
                                                    hintText: 'Nama Pasien',
                                                    controller:
                                                        TextEditingController(),
                                                  ),
                                                  InputDataComponent(
                                                    label: 'Jadwal Periksa',
                                                    hintText: '12/09/2019',
                                                    controller:
                                                        TextEditingController(),
                                                    readOnly: true,
                                                  ),
                                                  InputDataComponent(
                                                    label: 'Keluhan',
                                                    hintText: 'Keluhan',
                                                    controller:
                                                        TextEditingController(),
                                                  ),
                                                  InputDataComponent(
                                                    label: 'Dx',
                                                    hintText: 'Dx',
                                                    controller:
                                                        TextEditingController(),
                                                  ),
                                                  AppSizes.s20.height,
                                                  Row(
                                                    spacing: AppSizes.s10,
                                                    children: [
                                                      Flexible(
                                                        child: Button.outlined(
                                                            onPressed: () {
                                                              Get.back();
                                                            },
                                                            label: 'Batal'),
                                                      ),
                                                      Flexible(
                                                        child: Button.filled(
                                                            onPressed: () {},
                                                            label: 'Simpan'),
                                                      )
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                            AppSizes.s46.width,
                                            Flexible(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  105.height,
                                                  InputDataComponent(
                                                    maxLines: 10,
                                                    label: AppConstants
                                                        .LABEL_TERAPI_TINDAKAN,
                                                    hintText: 'Tindakan',
                                                    controller:
                                                        TextEditingController(),
                                                    textInputType:
                                                        TextInputType.multiline,
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        AppConstants
                                                            .LABEL_TERAPI_TINDAKAN,
                                                        style: Get.textTheme
                                                            .bodyMedium!
                                                            .copyWith(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                fontSize:
                                                                    AppSizes
                                                                        .s14,
                                                                color: AppColors
                                                                    .colorBaseBlack),
                                                      ),
                                                      AppSizes.s12.height,
                                                      DropDownSearchFormField(
                                                        textFieldConfiguration:
                                                            TextFieldConfiguration(
                                                          decoration:
                                                              InputDecoration(
                                                            hintText:
                                                                'Pilih Jenis Obat',
                                                            suffixIcon: Icon(
                                                                Iconsax
                                                                    .arrow_down_1),
                                                            hintStyle: Get
                                                                .textTheme
                                                                .bodySmall!
                                                                .copyWith(
                                                              fontSize:
                                                                  AppSizes.s14,
                                                              color: AppColors
                                                                  .colorNeutrals400,
                                                            ),
                                                            enabledBorder:
                                                                OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          AppSizes
                                                                              .s4),
                                                              borderSide:
                                                                  BorderSide(
                                                                color: AppColors
                                                                    .colorSecondary400,
                                                                width:
                                                                    AppSizes.s1,
                                                              ),
                                                            ),
                                                            focusedBorder:
                                                                OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          AppSizes
                                                                              .s10),
                                                              borderSide: BorderSide(
                                                                  color: AppColors
                                                                      .colorSecondary400,
                                                                  width:
                                                                      AppSizes
                                                                          .s2),
                                                            ),
                                                          ),
                                                          style: TextStyle(
                                                            fontSize:
                                                                AppSizes.s16,
                                                            color: Colors.black,
                                                          ),
                                                          controller: controller
                                                              .dropdownObatController,
                                                        ),
                                                        suggestionsCallback:
                                                            (pattern) {
                                                          return controller
                                                              .getTrashSuggestions(
                                                                  pattern);
                                                        },
                                                        itemBuilder: (context,
                                                            GroupObat
                                                                suggestion) {
                                                          return ListTile(
                                                            title: Text(
                                                              suggestion.nama,
                                                              style: TextStyle(
                                                                fontSize:
                                                                    AppSizes
                                                                        .s16,
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                        itemSeparatorBuilder:
                                                            (context, index) {
                                                          return const Divider();
                                                        },
                                                        transitionBuilder:
                                                            (context,
                                                                suggestionsBox,
                                                                controller) {
                                                          return suggestionsBox;
                                                        },
                                                        onSuggestionSelected:
                                                            (GroupObat
                                                                suggestion) {},
                                                        suggestionsBoxController:
                                                            controller
                                                                .suggestionBoxController,
                                                        validator: (value) =>
                                                            value!.isEmpty
                                                                ? ''
                                                                : null,
                                                        onSaved: (value) {},
                                                        displayAllSuggestionWhenTap:
                                                            true,
                                                      ),
                                                    ],
                                                  ),
                                                  AppSizes.s31.height,
                                                  SizedBox(
                                                    width: double.infinity,
                                                    height: AppSizes
                                                            .setResponsiveHeight(
                                                                context) *
                                                        0.23,
                                                    child: ListView.builder(
                                                      shrinkWrap: true,
                                                      itemCount: controller
                                                          .dummySuggestions
                                                          .length,
                                                      itemBuilder:
                                                          (context, index) {
                                                        // var obat = controller
                                                        //         .dummySuggestions[
                                                        //     index];
                                                        return Flexible(
                                                          child: Container(
                                                            margin: AppSizes
                                                                .symmetricPadding(
                                                                    vertical:
                                                                        AppSizes
                                                                            .s5),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(
                                                                      'Farsevin 400mg',
                                                                      style: Get
                                                                          .textTheme
                                                                          .labelLarge!
                                                                          .copyWith(
                                                                        fontSize:
                                                                            AppSizes.s14,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                Row(
                                                                  children: [
                                                                    Container(
                                                                      width: 60,
                                                                      height:
                                                                          50,
                                                                      child:
                                                                          CustomTextField(
                                                                        hintText:
                                                                            AppConstants.LABEL_QTY,
                                                                        controller:
                                                                            TextEditingController(),
                                                                        // controller
                                                                        //         .weightControllers[
                                                                        //     index],
                                                                        keyboardType:
                                                                            TextInputType.number,
                                                                        //textInputType: TextInputType.name,
                                                                        hintStyle: Get
                                                                            .textTheme
                                                                            .titleMedium!
                                                                            .copyWith(
                                                                                color: AppColors.colorSecondary600,
                                                                                fontSize: AppSizes.s10),
                                                                        onChanged:
                                                                            (value) {},
                                                                      ),
                                                                    ),
                                                                    AppSizes.s15
                                                                        .width,
                                                                    Container(
                                                                      padding: AppSizes.allPadding(
                                                                          AppSizes
                                                                              .s1),
                                                                      decoration: BoxDecoration(
                                                                          borderRadius: BorderRadius.circular(AppSizes
                                                                              .s2),
                                                                          color:
                                                                              AppColors.colorBaseError),
                                                                      child:
                                                                          IconButton(
                                                                        onPressed:
                                                                            () {},
                                                                        icon:
                                                                            Icon(
                                                                          size:
                                                                              20,
                                                                          Icons
                                                                              .delete_outline_rounded,
                                                                          color:
                                                                              AppColors.colorBaseWhite,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                  AppSizes.s10.height,
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        'Total Biaya',
                                                        style: Get.textTheme
                                                            .bodyMedium!
                                                            .copyWith(
                                                          fontSize:
                                                              AppSizes.s15,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: AppColors
                                                              .colorBaseBlack,
                                                        ),
                                                      ),
                                                      Container(
                                                        width: 200,
                                                        height: 50,
                                                        child: CustomTextField(
                                                          hintText:
                                                              'Masukan Biaya',
                                                          controller:
                                                              TextEditingController(),
                                                          // controller
                                                          //         .weightControllers[
                                                          //     index],
                                                          keyboardType:
                                                              TextInputType
                                                                  .number,
                                                          //textInputType: TextInputType.name,
                                                          hintStyle: Get
                                                              .textTheme
                                                              .titleMedium!
                                                              .copyWith(
                                                                  color: AppColors
                                                                      .colorSecondary600,
                                                                  fontSize:
                                                                      AppSizes
                                                                          .s10),
                                                          onChanged: (value) {},
                                                        ),
                                                      ),
                                                    ],
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
                                      width: 180,
                                      height: 41,
                                      decoration: BoxDecoration(
                                        color: AppColors.colorBasePrimary,
                                        borderRadius:
                                            BorderRadius.circular(AppSizes.s4),
                                      ),
                                      child: Center(
                                        child: Text(
                                          'Tambah Rekam Medis',
                                          style: Get.textTheme.bodyMedium!
                                              .copyWith(
                                                  fontSize: AppSizes.s14,
                                                  color:
                                                      AppColors.colorBaseWhite),
                                        ),
                                      ),
                                    ),
                                  )
                                : Container()
                            : Container()
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
                              onChanged: (value) {
                                controller.getRmePasien(search: value);
                              },
                            ),
                          ),
                        ),
                        if (Responsive.isDesktop(context)) ...[
                          AppSizes.s17.width,
                          Container(
                            width: 281,
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
                                  color:
                                      AppColors.colorNeutrals300.withAlpha(40),
                                ),
                              ],
                            ),
                            child: Row(
                              spacing: 20,
                              children: [
                                AppSizes.s10.width,
                                Icon(Icons.calendar_month_rounded),
                                Text(
                                  'Februari 2024',
                                  style: Get.textTheme.labelMedium!.copyWith(
                                    fontSize: AppSizes.s16,
                                    color: AppColors.colorBaseBlack,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ],
                    ),
                    if (Responsive.isMobile(context)) ...[
                      AppSizes.s10.height,
                      if (controller.role.value == "DOKTER") ...[
                        InkWell(
                          onTap: () {
                            showModalCenter(
                              context,
                              ListView(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                            style: Get.textTheme.labelMedium!
                                                .copyWith(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: AppSizes.s24),
                                          ),
                                        ],
                                      ),
                                      Divider(),
                                      AppSizes.s30.height,
                                      InputDataComponent(
                                        label: 'No Rekam Medis',
                                        hintText: 'No Rekam Medis',
                                        controller: TextEditingController(),
                                      ),
                                      InputDataComponent(
                                        label: 'Nama Pasien',
                                        hintText: 'Nama Pasien',
                                        controller: TextEditingController(),
                                      ),
                                      InputDataComponent(
                                        label: 'Jadwal Periksa',
                                        hintText: '12/09/2019',
                                        controller: TextEditingController(),
                                        readOnly: true,
                                      ),
                                      InputDataComponent(
                                        label: 'Keluhan',
                                        hintText: 'Keluhan',
                                        controller: TextEditingController(),
                                      ),
                                      InputDataComponent(
                                        label: 'Dx',
                                        hintText: 'Dx',
                                        controller: TextEditingController(),
                                      ),
                                      InputDataComponent(
                                        maxLines: 10,
                                        label:
                                            AppConstants.LABEL_TERAPI_TINDAKAN,
                                        hintText: 'Tindakan',
                                        controller: TextEditingController(),
                                        textInputType: TextInputType.multiline,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            AppConstants.LABEL_TERAPI_TINDAKAN,
                                            style: Get.textTheme.bodyMedium!
                                                .copyWith(
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: AppSizes.s14,
                                                    color: AppColors
                                                        .colorBaseBlack),
                                          ),
                                          AppSizes.s12.height,
                                          DropDownSearchFormField(
                                            textFieldConfiguration:
                                                TextFieldConfiguration(
                                              decoration: InputDecoration(
                                                hintText: 'Pilih Jenis Obat',
                                                suffixIcon:
                                                    Icon(Iconsax.arrow_down_1),
                                                hintStyle: Get
                                                    .textTheme.bodySmall!
                                                    .copyWith(
                                                  fontSize: AppSizes.s14,
                                                  color: AppColors
                                                      .colorNeutrals400,
                                                ),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          AppSizes.s4),
                                                  borderSide: BorderSide(
                                                    color: AppColors
                                                        .colorSecondary400,
                                                    width: AppSizes.s1,
                                                  ),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          AppSizes.s10),
                                                  borderSide: BorderSide(
                                                      color: AppColors
                                                          .colorSecondary400,
                                                      width: AppSizes.s2),
                                                ),
                                              ),
                                              style: TextStyle(
                                                fontSize: AppSizes.s16,
                                                color: Colors.black,
                                              ),
                                              controller: controller
                                                  .dropdownObatController,
                                            ),
                                            suggestionsCallback: (pattern) {
                                              return controller
                                                  .getTrashSuggestions(pattern);
                                            },
                                            itemBuilder: (context,
                                                GroupObat suggestion) {
                                              return ListTile(
                                                title: Text(
                                                  suggestion.nama,
                                                  style: TextStyle(
                                                    fontSize: AppSizes.s16,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              );
                                            },
                                            itemSeparatorBuilder:
                                                (context, index) {
                                              return const Divider();
                                            },
                                            transitionBuilder: (context,
                                                suggestionsBox, controller) {
                                              return suggestionsBox;
                                            },
                                            onSuggestionSelected:
                                                (GroupObat suggestion) {},
                                            suggestionsBoxController: controller
                                                .suggestionBoxController,
                                            validator: (value) =>
                                                value!.isEmpty ? '' : null,
                                            onSaved: (value) {},
                                            displayAllSuggestionWhenTap: true,
                                          ),
                                        ],
                                      ),
                                      AppSizes.s31.height,
                                      SizedBox(
                                        width: double.infinity,
                                        height: AppSizes.setResponsiveHeight(
                                                context) *
                                            0.25,
                                        child: ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: controller
                                              .dummySuggestions.length,
                                          itemBuilder: (context, index) {
                                            // var obat = controller
                                            //         .dummySuggestions[
                                            //     index];
                                            return Flexible(
                                              child: Container(
                                                margin:
                                                    AppSizes.symmetricPadding(
                                                        vertical: AppSizes.s5),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          'Farsevin 400mg',
                                                          style: Get.textTheme
                                                              .labelLarge!
                                                              .copyWith(
                                                            fontSize:
                                                                AppSizes.s14,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        Container(
                                                          width: 60,
                                                          height: 50,
                                                          child:
                                                              CustomTextField(
                                                            hintText:
                                                                AppConstants
                                                                    .LABEL_QTY,
                                                            controller:
                                                                TextEditingController(),
                                                            // controller
                                                            //         .weightControllers[
                                                            //     index],
                                                            keyboardType:
                                                                TextInputType
                                                                    .number,
                                                            //textInputType: TextInputType.name,
                                                            hintStyle: Get
                                                                .textTheme
                                                                .titleMedium!
                                                                .copyWith(
                                                                    color: AppColors
                                                                        .colorSecondary600,
                                                                    fontSize:
                                                                        AppSizes
                                                                            .s10),
                                                            onChanged:
                                                                (value) {},
                                                          ),
                                                        ),
                                                        AppSizes.s15.width,
                                                        Container(
                                                          padding: AppSizes
                                                              .allPadding(
                                                                  AppSizes.s1),
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          AppSizes
                                                                              .s2),
                                                              color: AppColors
                                                                  .colorBaseError),
                                                          child: IconButton(
                                                            onPressed: () {},
                                                            icon: Icon(
                                                              size: 20,
                                                              Icons
                                                                  .delete_outline_rounded,
                                                              color: AppColors
                                                                  .colorBaseWhite,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                      AppSizes.s10.height,
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Total Biaya',
                                            style: Get.textTheme.bodyMedium!
                                                .copyWith(
                                              fontSize: AppSizes.s15,
                                              fontWeight: FontWeight.bold,
                                              color: AppColors.colorBaseBlack,
                                            ),
                                          ),
                                          Container(
                                            width: 200,
                                            height: 50,
                                            child: CustomTextField(
                                              hintText: 'Masukan Biaya',
                                              controller:
                                                  TextEditingController(),
                                              // controller
                                              //         .weightControllers[
                                              //     index],
                                              keyboardType:
                                                  TextInputType.number,
                                              //textInputType: TextInputType.name,
                                              hintStyle: Get
                                                  .textTheme.titleMedium!
                                                  .copyWith(
                                                      color: AppColors
                                                          .colorSecondary600,
                                                      fontSize: AppSizes.s10),
                                              onChanged: (value) {},
                                            ),
                                          ),
                                        ],
                                      ),
                                      AppSizes.s15.height,
                                      Row(
                                        spacing: AppSizes.s10,
                                        children: [
                                          Flexible(
                                            child: Button.outlined(
                                                onPressed: () {
                                                  Get.back();
                                                },
                                                label: 'Batal'),
                                          ),
                                          Flexible(
                                            child: Button.filled(
                                                onPressed: () {},
                                                label: 'Simpan'),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                          child: Container(
                            width: 180,
                            height: 41,
                            decoration: BoxDecoration(
                              color: AppColors.colorBasePrimary,
                              borderRadius: BorderRadius.circular(AppSizes.s4),
                            ),
                            child: Center(
                              child: Text(
                                'Tambah Rekam Medis',
                                style: Get.textTheme.bodyMedium!.copyWith(
                                    fontSize: AppSizes.s14,
                                    color: AppColors.colorBaseWhite),
                              ),
                            ),
                          ),
                        ),
                      ],
                      AppSizes.s10.height,
                      Container(
                        width: double.infinity,
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
                        child: Row(
                          spacing: 20,
                          children: [
                            AppSizes.s10.width,
                            Icon(Icons.calendar_month_rounded),
                            Text(
                              'Februari 2024',
                              style: Get.textTheme.labelMedium!.copyWith(
                                fontSize: AppSizes.s16,
                                color: AppColors.colorBaseBlack,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              Obx(
                () {
                  return Expanded(
                    child: Container(
                      width: double.infinity,
                      height: 500,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(AppSizes.s4),
                        color: AppColors.colorBaseWhite,
                      ),
                      child: controller.isLoading.value
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : controller.rmePasientList.isEmpty
                              ? Center(
                                  child: CircularProgressIndicator(),
                                )
                              : ListView(
                                  padding: AppSizes.symmetricPadding(
                                    horizontal: AppSizes.s30,
                                  ),
                                  children: [
                                    SingleChildScrollView(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 20.0),
                                      scrollDirection: Axis.horizontal,
                                      child: Center(
                                        child: Theme(
                                          data: Theme.of(context).copyWith(
                                              dividerColor: Colors.transparent),
                                          child: DataTable(
                                            dividerThickness: 0.0,
                                            dataRowMinHeight: 20.0,
                                            dataRowMaxHeight: 50.0,
                                            columns: [
                                              DataColumn(
                                                label: Text(
                                                  AppConstants.LABEL_NO,
                                                  style: Get
                                                      .textTheme.labelLarge!
                                                      .copyWith(
                                                          fontSize:
                                                              AppSizes.s14,
                                                          color: AppColors
                                                              .colorBaseBlack),
                                                ),
                                              ),
                                              DataColumn(
                                                label: Padding(
                                                  padding: EdgeInsets.only(
                                                    left: MediaQuery.of(context)
                                                            .size
                                                            .width *
                                                        0.02,
                                                    right:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.04,
                                                  ),
                                                  child: Text(
                                                    AppConstants
                                                        .LABEL_JADWAL_PERIKSA,
                                                    style: Get
                                                        .textTheme.labelLarge!
                                                        .copyWith(
                                                            fontSize:
                                                                AppSizes.s14,
                                                            color: AppColors
                                                                .colorBaseBlack),
                                                  ),
                                                ),
                                              ),
                                              DataColumn(
                                                label: Center(
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                      left:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.02,
                                                    ),
                                                    child: Text(
                                                      AppConstants
                                                          .LABEL_KELUHAN,
                                                      style: Get
                                                          .textTheme.labelLarge!
                                                          .copyWith(
                                                              fontSize:
                                                                  AppSizes.s14,
                                                              color: AppColors
                                                                  .colorBaseBlack),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              DataColumn(
                                                label: Padding(
                                                  padding: EdgeInsets.only(
                                                    left: MediaQuery.of(context)
                                                            .size
                                                            .width *
                                                        0.02,
                                                  ),
                                                  child: Text(
                                                    AppConstants
                                                        .LABEL_TERAPI_TINDAKAN,
                                                    style: Get
                                                        .textTheme.labelLarge!
                                                        .copyWith(
                                                            fontSize:
                                                                AppSizes.s14,
                                                            color: AppColors
                                                                .colorBaseBlack),
                                                  ),
                                                ),
                                              ),
                                              DataColumn(
                                                label: Padding(
                                                  padding: EdgeInsets.only(
                                                    left: MediaQuery.of(context)
                                                            .size
                                                            .width *
                                                        0.02,
                                                  ),
                                                  child: Text(
                                                    AppConstants.LABEL_DX,
                                                    style: Get
                                                        .textTheme.labelLarge!
                                                        .copyWith(
                                                            fontSize:
                                                                AppSizes.s14,
                                                            color: AppColors
                                                                .colorBaseBlack),
                                                  ),
                                                ),
                                              ),
                                              DataColumn(
                                                label: Padding(
                                                  padding: EdgeInsets.only(
                                                    left: MediaQuery.of(context)
                                                            .size
                                                            .width *
                                                        0.02,
                                                  ),
                                                  child: Text(
                                                    AppConstants.LABEL_ACTION,
                                                    style: Get
                                                        .textTheme.labelLarge!
                                                        .copyWith(
                                                            fontSize:
                                                                AppSizes.s14,
                                                            color: AppColors
                                                                .colorBaseBlack),
                                                  ),
                                                ),
                                              ),
                                            ],
                                            rows:
                                                controller
                                                        .rmePasientList.isEmpty
                                                    ? [
                                                        const DataRow(
                                                          cells: [
                                                            DataCell.empty,
                                                            DataCell.empty,
                                                            DataCell(Row(
                                                              spacing: 4,
                                                              children: [
                                                                Icon(Icons
                                                                    .highlight_off),
                                                                //SpaceWidth(4.0),
                                                                Text(
                                                                    'Data tidak ditemukan..'),
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
                                                                label:
                                                                    'Pasien Baru',
                                                                width: 250,
                                                              ),
                                                            ),
                                                            DataCell.empty,
                                                            DataCell.empty,
                                                          ],
                                                        ),
                                                      ]
                                                    : controller.rmePasientList
                                                        .map(
                                                          (patient) => DataRow(
                                                            cells: [
                                                              DataCell(
                                                                Center(
                                                                  child: Text(
                                                                    '1',
                                                                    style: const TextStyle(
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                                  ),
                                                                ),
                                                              ),
                                                              DataCell(
                                                                Padding(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .only(
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
                                                                    patient
                                                                        .jadwalPeriksa
                                                                        .toDateddmmmyyyyFormattedString(),
                                                                    style: Get
                                                                        .textTheme
                                                                        .labelLarge!
                                                                        .copyWith(
                                                                      fontSize:
                                                                          AppSizes
                                                                              .s16,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              DataCell(
                                                                Padding(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .only(
                                                                    left: MediaQuery.of(context)
                                                                            .size
                                                                            .width *
                                                                        0.02,
                                                                  ),
                                                                  child: Text(
                                                                    patient
                                                                        .keluhan,
                                                                    style: const TextStyle(
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                                  ),
                                                                ),
                                                              ),
                                                              DataCell(
                                                                Padding(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .only(
                                                                    left: MediaQuery.of(context)
                                                                            .size
                                                                            .width *
                                                                        0.02,
                                                                  ),
                                                                  child: Text(
                                                                    patient
                                                                        .terapiTindakan,
                                                                    style: const TextStyle(
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                                  ),
                                                                ),
                                                              ),
                                                              DataCell(
                                                                Padding(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .only(
                                                                    left: MediaQuery.of(context)
                                                                            .size
                                                                            .width *
                                                                        0.02,
                                                                  ),
                                                                  child: Text(
                                                                    patient.dx,
                                                                    style: const TextStyle(
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                                  ),
                                                                ),
                                                              ),
                                                              DataCell(
                                                                Padding(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .only(
                                                                    left: MediaQuery.of(context)
                                                                            .size
                                                                            .width *
                                                                        0.02,
                                                                  ),
                                                                  child: Responsive
                                                                          .isMobile(
                                                                              context)
                                                                      ? IconButton(
                                                                          onPressed:
                                                                              () {
                                                                            showModalBottom(
                                                                                context,
                                                                                Column(
                                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                                  children: [
                                                                                    AppSizes.s8.height,
                                                                                    Center(
                                                                                      child: Container(
                                                                                        width: AppSizes.s56,
                                                                                        height: AppSizes.s4,
                                                                                        decoration: BoxDecoration(
                                                                                          borderRadius: BorderRadius.circular(AppSizes.s8),
                                                                                          color: AppColors.colorNeutrals100,
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                    AppSizes.s11.height,
                                                                                    Column(
                                                                                      spacing: 24,
                                                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                                                      children: [
                                                                                        InkWell(
                                                                                          onTap: () {
                                                                                            showModalCenter(
                                                                                              context,
                                                                                              ListView(
                                                                                                children: [
                                                                                                  Column(
                                                                                                    crossAxisAlignment: CrossAxisAlignment.start,
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
                                                                                                      AppSizes.s30.height,
                                                                                                      InputDataComponent(
                                                                                                        label: 'No Rekam Medis',
                                                                                                        hintText: patient.noRekamMedis,
                                                                                                        controller: TextEditingController(),
                                                                                                        readOnly: true,
                                                                                                      ),
                                                                                                      InputDataComponent(
                                                                                                        label: 'Nama Pasien',
                                                                                                        hintText: name,
                                                                                                        controller: TextEditingController(),
                                                                                                        readOnly: true,
                                                                                                      ),
                                                                                                      InputDataComponent(
                                                                                                        label: 'Jadwal Periksa',
                                                                                                        hintText: '12/09/2019',
                                                                                                        controller: TextEditingController(),
                                                                                                        readOnly: true,
                                                                                                      ),
                                                                                                      InputDataComponent(
                                                                                                        label: 'Keluhan',
                                                                                                        hintText: patient.keluhan,
                                                                                                        controller: TextEditingController(),
                                                                                                        readOnly: true,
                                                                                                      ),
                                                                                                      InputDataComponent(
                                                                                                        label: 'Dx',
                                                                                                        hintText: patient.dx,
                                                                                                        controller: TextEditingController(),
                                                                                                        readOnly: true,
                                                                                                      ),
                                                                                                      Column(
                                                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                        children: [
                                                                                                          Text(
                                                                                                            AppConstants.LABEL_TERAPI_TINDAKAN,
                                                                                                            style: Get.textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w700, fontSize: AppSizes.s14, color: AppColors.colorBaseBlack),
                                                                                                          ),
                                                                                                          AppSizes.s12.height,
                                                                                                          Container(
                                                                                                            padding: AppSizes.symmetricPadding(
                                                                                                              vertical: AppSizes.s20,
                                                                                                              horizontal: AppSizes.s12,
                                                                                                            ),
                                                                                                            width: double.infinity,
                                                                                                            decoration: BoxDecoration(
                                                                                                              color: Color(0xfffF6F7FB),
                                                                                                              borderRadius: BorderRadius.circular(AppSizes.s4),
                                                                                                            ),
                                                                                                            child: Text(
                                                                                                              patient.terapiTindakan,
                                                                                                              style: Get.textTheme.bodyMedium!.copyWith(
                                                                                                                fontSize: AppSizes.s14,
                                                                                                                color: AppColors.colorBaseBlack,
                                                                                                              ),
                                                                                                            ),
                                                                                                          )
                                                                                                        ],
                                                                                                      ),
                                                                                                      AppSizes.s31.height,
                                                                                                      SizedBox(
                                                                                                        height: 200,
                                                                                                        child: ListView.builder(
                                                                                                          scrollDirection: Axis.vertical,
                                                                                                          itemCount: controller.obatList.length,
                                                                                                          itemBuilder: (BuildContext context, index) {
                                                                                                            var data = controller.obatList[index];
                                                                                                            return Row(
                                                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                                              children: [
                                                                                                                Text(
                                                                                                                  data.namaObat,
                                                                                                                  style: Get.textTheme.bodyMedium!.copyWith(
                                                                                                                    fontSize: AppSizes.s16,
                                                                                                                    fontWeight: FontWeight.w500,
                                                                                                                    color: AppColors.colorBaseBlack,
                                                                                                                  ),
                                                                                                                ),
                                                                                                                Row(
                                                                                                                  spacing: 10,
                                                                                                                  children: [
                                                                                                                    Text(
                                                                                                                      '1',
                                                                                                                      style: Get.textTheme.bodyMedium!.copyWith(
                                                                                                                        fontSize: AppSizes.s14,
                                                                                                                        fontWeight: FontWeight.w500,
                                                                                                                        color: AppColors.colorBaseBlack,
                                                                                                                      ),
                                                                                                                    ),
                                                                                                                    Text(
                                                                                                                      'Tablet',
                                                                                                                      style: Get.textTheme.bodyMedium!.copyWith(
                                                                                                                        fontSize: AppSizes.s14,
                                                                                                                        fontWeight: FontWeight.w500,
                                                                                                                        color: AppColors.colorBaseBlack,
                                                                                                                      ),
                                                                                                                    ),
                                                                                                                  ],
                                                                                                                )
                                                                                                              ],
                                                                                                            ).paddingOnly(bottom: AppSizes.s10);
                                                                                                          },
                                                                                                        ),
                                                                                                      ),
                                                                                                      Row(
                                                                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                                        children: [
                                                                                                          Text(
                                                                                                            'Total',
                                                                                                            style: Get.textTheme.bodyMedium!.copyWith(
                                                                                                              fontSize: AppSizes.s20,
                                                                                                              fontWeight: FontWeight.bold,
                                                                                                              color: AppColors.colorBaseBlack,
                                                                                                            ),
                                                                                                          ),
                                                                                                          Text(
                                                                                                            patient.total.currencyFormatRp,
                                                                                                            style: Get.textTheme.bodyMedium!.copyWith(
                                                                                                              fontSize: AppSizes.s20,
                                                                                                              fontWeight: FontWeight.bold,
                                                                                                              color: AppColors.colorBaseBlack,
                                                                                                            ),
                                                                                                          ),
                                                                                                        ],
                                                                                                      )
                                                                                                    ],
                                                                                                  ),
                                                                                                ],
                                                                                              ),
                                                                                            );
                                                                                          },
                                                                                          child: Text(
                                                                                            'Detail',
                                                                                            style: Get.textTheme.labelLarge!.copyWith(
                                                                                              fontSize: AppSizes.s14,
                                                                                              color: AppColors.colorBaseBlack,
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      ],
                                                                                    ).paddingOnly(
                                                                                      left: AppSizes.s24,
                                                                                      bottom: AppSizes.s20,
                                                                                    ),
                                                                                  ],
                                                                                ));
                                                                          },
                                                                          icon:
                                                                              Icon(
                                                                            Icons.more_horiz,
                                                                            size:
                                                                                24,
                                                                            color:
                                                                                Color(0xfff828282),
                                                                          ),
                                                                        )
                                                                      : Center(
                                                                          child:
                                                                              PopupMenuButton(
                                                                            icon:
                                                                                const Icon(
                                                                              Icons.more_horiz,
                                                                              size: 24,
                                                                              color: Color(0xfff828282),
                                                                            ),
                                                                            onSelected:
                                                                                (value) {
                                                                              value();
                                                                            },
                                                                            itemBuilder: (context) =>
                                                                                [
                                                                              PopupMenuItem(
                                                                                child: PopupMenuActionComponent(
                                                                                  label: 'Detail',
                                                                                ),
                                                                                value: () {
                                                                                  debugPrint('Detial');
                                                                                },
                                                                                onTap: () {
                                                                                  showRightModal(
                                                                                    context,
                                                                                    Row(
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
                                                                                                    'Rekam Medis',
                                                                                                    style: Get.textTheme.labelMedium!.copyWith(fontWeight: FontWeight.bold, fontSize: AppSizes.s24),
                                                                                                  ),
                                                                                                ],
                                                                                              ),
                                                                                              Divider(),
                                                                                              AppSizes.s48.height,
                                                                                              InputDataComponent(
                                                                                                label: 'No Rekam Medis',
                                                                                                hintText: patient.noRekamMedis,
                                                                                                controller: TextEditingController(),
                                                                                                readOnly: true,
                                                                                              ),
                                                                                              InputDataComponent(
                                                                                                label: 'Nama Pasien',
                                                                                                hintText: name,
                                                                                                controller: TextEditingController(),
                                                                                                readOnly: true,
                                                                                              ),
                                                                                              InputDataComponent(
                                                                                                label: 'Jadwal Periksa',
                                                                                                hintText: '12/09/2019',
                                                                                                controller: TextEditingController(),
                                                                                                readOnly: true,
                                                                                              ),
                                                                                              InputDataComponent(
                                                                                                label: 'Keluhan',
                                                                                                hintText: patient.keluhan,
                                                                                                controller: TextEditingController(),
                                                                                                readOnly: true,
                                                                                              ),
                                                                                              InputDataComponent(
                                                                                                label: 'Dx',
                                                                                                hintText: patient.dx,
                                                                                                controller: TextEditingController(),
                                                                                                readOnly: true,
                                                                                              ),
                                                                                            ],
                                                                                          ),
                                                                                        ),
                                                                                        AppSizes.s46.width,
                                                                                        Flexible(
                                                                                          child: Column(
                                                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                                                            children: [
                                                                                              105.height,
                                                                                              Column(
                                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                children: [
                                                                                                  Text(
                                                                                                    AppConstants.LABEL_TERAPI_TINDAKAN,
                                                                                                    style: Get.textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w700, fontSize: AppSizes.s14, color: AppColors.colorBaseBlack),
                                                                                                  ),
                                                                                                  AppSizes.s12.height,
                                                                                                  Container(
                                                                                                    padding: AppSizes.symmetricPadding(
                                                                                                      vertical: AppSizes.s20,
                                                                                                      horizontal: AppSizes.s12,
                                                                                                    ),
                                                                                                    width: double.infinity,
                                                                                                    decoration: BoxDecoration(
                                                                                                      color: Color(0xfffF6F7FB),
                                                                                                      borderRadius: BorderRadius.circular(AppSizes.s4),
                                                                                                    ),
                                                                                                    child: Text(
                                                                                                      patient.terapiTindakan,
                                                                                                      style: Get.textTheme.bodyMedium!.copyWith(
                                                                                                        fontSize: AppSizes.s14,
                                                                                                        color: AppColors.colorBaseBlack,
                                                                                                      ),
                                                                                                    ),
                                                                                                  )
                                                                                                ],
                                                                                              ),
                                                                                              AppSizes.s31.height,
                                                                                              Expanded(
                                                                                                child: ListView.builder(
                                                                                                  itemCount: controller.obatList.length,
                                                                                                  itemBuilder: (BuildContext context, index) {
                                                                                                    var data = controller.obatList[index];
                                                                                                    return Row(
                                                                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                                      children: [
                                                                                                        Text(
                                                                                                          data.namaObat,
                                                                                                          style: Get.textTheme.bodyMedium!.copyWith(
                                                                                                            fontSize: AppSizes.s16,
                                                                                                            fontWeight: FontWeight.w500,
                                                                                                            color: AppColors.colorBaseBlack,
                                                                                                          ),
                                                                                                        ),
                                                                                                        Row(
                                                                                                          spacing: 10,
                                                                                                          children: [
                                                                                                            Text(
                                                                                                              '1',
                                                                                                              style: Get.textTheme.bodyMedium!.copyWith(
                                                                                                                fontSize: AppSizes.s14,
                                                                                                                fontWeight: FontWeight.w500,
                                                                                                                color: AppColors.colorBaseBlack,
                                                                                                              ),
                                                                                                            ),
                                                                                                            Text(
                                                                                                              'Tablet',
                                                                                                              style: Get.textTheme.bodyMedium!.copyWith(
                                                                                                                fontSize: AppSizes.s14,
                                                                                                                fontWeight: FontWeight.w500,
                                                                                                                color: AppColors.colorBaseBlack,
                                                                                                              ),
                                                                                                            ),
                                                                                                          ],
                                                                                                        )
                                                                                                      ],
                                                                                                    ).paddingOnly(bottom: AppSizes.s10);
                                                                                                  },
                                                                                                ),
                                                                                              ),
                                                                                              Row(
                                                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                                children: [
                                                                                                  Text(
                                                                                                    'Total',
                                                                                                    style: Get.textTheme.bodyMedium!.copyWith(
                                                                                                      fontSize: AppSizes.s20,
                                                                                                      fontWeight: FontWeight.bold,
                                                                                                      color: AppColors.colorBaseBlack,
                                                                                                    ),
                                                                                                  ),
                                                                                                  Text(
                                                                                                    patient.total.currencyFormatRp,
                                                                                                    style: Get.textTheme.bodyMedium!.copyWith(
                                                                                                      fontSize: AppSizes.s20,
                                                                                                      fontWeight: FontWeight.bold,
                                                                                                      color: AppColors.colorBaseBlack,
                                                                                                    ),
                                                                                                  ),
                                                                                                ],
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
                  );
                },
              ),
              Container(
                width: double.infinity,
                padding: AppSizes.symmetricPadding(
                    vertical: AppSizes.s20, horizontal: AppSizes.s41),
                child: Column(
                  children: [
                    Container(
                      //width: 400,
                      decoration: BoxDecoration(
                        color: AppColors.colorBaseWhite,
                        borderRadius: BorderRadius.circular(AppSizes.s4),
                      ),
                      child: Obx(() {
                        return NumberPaginator(
                          numberPages: controller.numberOfPage.value,
                          onPageChange: (int index) {
                            final page = index + 1;
                            controller.getRmePasien(page: page);
                          },
                          child: const SizedBox(
                            height: 48,
                            width: 300,
                            child: Row(
                              children: [
                                PrevButton(),
                                Expanded(
                                  child: NumberContent(),
                                ),
                                NextButton(),
                              ],
                            ),
                          ),
                        );
                      }),
                    ),
                  ],
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
