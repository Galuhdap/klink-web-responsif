import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:klinik_web_responsif/core/assets/assets.gen.dart';
import 'package:klinik_web_responsif/core/components/button_component.dart';
import 'package:klinik_web_responsif/core/components/input_data_component.dart';
import 'package:klinik_web_responsif/core/styles/app_colors.dart';
import 'package:klinik_web_responsif/core/styles/app_sizes.dart';
import 'package:klinik_web_responsif/core/utils/extensions/date_ext.dart';
import 'package:klinik_web_responsif/core/utils/extensions/sized_box_ext.dart';
import 'package:klinik_web_responsif/presentations/patient/controller/patient_controller.dart';
import 'package:klinik_web_responsif/services/pasien/model/request/post_pasient_request.dart';
import 'package:klinik_web_responsif/services/pasien/model/response/get_pasien_response.dart';
import 'package:lottie/lottie.dart';

class EditPatientAction extends StatelessWidget {
  const EditPatientAction({
    super.key,
    required this.datas,
    required this.controller,
  });

  final ListPasien datas;
  final PatientController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return controller.isLoadingCreate.value
            ? Center(
                child: SizedBox(
                  width: 400,
                  height: 400,
                  child: Lottie.asset(Assets.lottie.hospital),
                ),
              )
            : Form(
                key: controller.formKey,
                child: ListView(
                  controller: controller.scrollController,
                  children: [
                    Center(
                      child: Text(
                        controller.readOnly.value ? 'Detail' : 'Edit Pasien',
                        style: Get.textTheme.labelMedium!.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: AppSizes.s16),
                      ),
                    ),
                    AppSizes.s12.height,
                    Divider(),
                    InputDataComponent(
                      label: 'Nama Pasien',
                      hintText: datas.name,
                      controller: controller.nameController,
                      readOnly: controller.readOnly.value,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Jenis Kelamin',
                          style: Get.textTheme.bodyMedium!.copyWith(
                              fontWeight: FontWeight.w700,
                              fontSize: AppSizes.s14,
                              color: AppColors.colorBaseBlack),
                        ),
                        AppSizes.s12.height,
                        DropdownSearch<String>(
                          enabled: !controller.readOnly.value,
                          items: (f, cs) => [
                            "Laki-laki",
                            'Perempuan',
                          ],
                          dropdownBuilder: (context, selectedItem) {
                            return Text(
                              controller.readOnly.value
                                  ? datas.jenisKelamin
                                  : controller.jenisKelaminController.value,
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
                              disabledItemFn: (item) => item == 'Item 3',
                              fit: FlexFit.loose),
                          onChanged: (String? selectedValue) {
                            controller.jenisKelaminController.value =
                                selectedValue!;
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
                          style: Get.textTheme.bodyMedium!.copyWith(
                              fontWeight: FontWeight.w700,
                              fontSize: AppSizes.s14,
                              color: AppColors.colorBaseBlack),
                        ),
                        AppSizes.s12.height,
                        InkWell(
                          onTap: controller.readOnly.value
                              ? () {}
                              : () async {
                                  final DateTime? pickedDate =
                                      await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(1950),
                                    lastDate: DateTime
                                        .now(), // ⛔ hanya sampai hari ini, tidak bisa pilih besok
                                  );
                                  if (pickedDate != null) {
                                    controller.tglLahirController.value =
                                        pickedDate;
                                  }
                                },
                          child: Container(
                              padding: AppSizes.symmetricPadding(
                                  vertical: AppSizes.s5,
                                  horizontal: AppSizes.s20),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: AppColors.colorSecondary400,
                                ),
                                borderRadius:
                                    BorderRadius.circular(AppSizes.s4),
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
                                    controller.readOnly.value
                                        ? datas.tglLahir
                                            .toDateyyyymmddFormattedString()
                                        : controller.tglLahirController.value
                                            .toDateyyyymmddFormattedString(),
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
                      hintText: datas.alamat,
                      controller: controller.alamatController,
                      readOnly: controller.readOnly.value,
                    ),
                    InputDataComponent(
                      label: 'No Telpon',
                      hintText: datas.noTelp,
                      controller: controller.noTelpController,
                      readOnly: controller.readOnly.value,
                    ),
                    InputDataComponent(
                      label: 'NIK',
                      hintText: datas.nik,
                      controller: controller.nikController,
                      readOnly: controller.readOnly.value,
                    ),
                    Row(
                      children: [
                        Flexible(
                          child: Button.outlined(
                              onPressed: controller.readOnly.value
                                  ? () {
                                      Get.back();
                                    }
                                  : () {
                                      var data = PostPasienRequest(
                                        name: datas.name,
                                        jenisKelamin: datas.jenisKelamin,
                                        alamat: datas.alamat,
                                        tglLahir: datas.tglLahir,
                                        nik: datas.nik,
                                        noTelp: datas.noTelp,
                                        // umur: umurController.text,
                                      );
                                      controller.changeReadOnly(data);
                                      controller.nameController.clear();
                                      controller.jenisKelaminController.value =
                                          '';
                                      controller.alamatController.clear();
                                      controller.tglLahirController.value =
                                          DateTime.now();
                                      controller.nikController.clear();
                                      controller.noTelpController.clear();
                                      controller.umurController.clear();
                                      Get.back();
                                    },
                              label: 'Kembali'),
                        ),
                        AppSizes.s12.width,
                        Flexible(
                          child: Button.filled(
                              onPressed: controller.readOnly.value
                                  ? () {
                                      var data = PostPasienRequest(
                                        name: datas.name,
                                        jenisKelamin: datas.jenisKelamin,
                                        alamat: datas.alamat,
                                        tglLahir: datas.tglLahir,
                                        nik: datas.nik,
                                        noTelp: datas.noTelp,
                                        // umur: umurController.text,
                                      );
                                      controller.changeReadOnly(data);
                                    }
                                  : () {
                                      var data = PostPasienRequest(
                                        name: datas.name,
                                        jenisKelamin: datas.jenisKelamin,
                                        alamat: datas.alamat,
                                        tglLahir: datas.tglLahir,
                                        nik: datas.nik,
                                        noTelp: datas.noTelp,
                                        // umur: umurController.text,
                                      );
                                      controller.changeReadOnly(data);
                                      controller.putPasien(datas.id);
                                    },
                              label: controller.readOnly.value
                                  ? 'Edit'
                                  : "Simpan"),
                        ),
                      ],
                    )
                  ],
                ),
              );
      },
    );
  }
}
