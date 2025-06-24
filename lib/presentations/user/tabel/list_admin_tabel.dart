import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:klinik_web_responsif/core/assets/assets.gen.dart';
import 'package:klinik_web_responsif/core/components/show_center_dialog.dart';
import 'package:klinik_web_responsif/core/styles/app_colors.dart';
import 'package:klinik_web_responsif/core/styles/app_sizes.dart';
import 'package:klinik_web_responsif/presentations/user/controller/user_manajemen_controller.dart';
import 'package:klinik_web_responsif/services/owner/model/response/get_user_response.dart';
import 'package:lottie/lottie.dart';

import '../../../core/components/modal/show_modal_tanda_tanya_component.dart';

List<DataColumn> getListAdminColumns() {
  return [
    DataColumn(
      label: Text(
        'NO',
        style: Get.textTheme.labelLarge!.copyWith(
          fontSize: AppSizes.s14,
          color: AppColors.colorBaseBlack,
        ),
      ),
    ),
    DataColumn(
      label: Text(
        'NAMA',
        style: Get.textTheme.labelLarge!.copyWith(
          fontSize: AppSizes.s14,
          color: AppColors.colorBaseBlack,
        ),
      ),
    ),
    DataColumn(
      label: Text(
        'EMAIL',
        style: Get.textTheme.labelLarge!.copyWith(
          fontSize: AppSizes.s14,
          color: AppColors.colorBaseBlack,
        ),
      ),
    ),
    DataColumn(
      label: Text(
        'JANIS KELAMIN',
        style: Get.textTheme.labelLarge!.copyWith(
          fontSize: AppSizes.s14,
          color: AppColors.colorBaseBlack,
        ),
      ),
    ),
    DataColumn(
      headingRowAlignment: MainAxisAlignment.center,
      label: Text(
        'NO TELP',
        style: Get.textTheme.labelLarge!.copyWith(
          fontSize: AppSizes.s14,
          color: AppColors.colorBaseBlack,
        ),
      ),
    ),
    DataColumn(
      headingRowAlignment: MainAxisAlignment.center,
      label: Text(
        'ACTION',
        style: Get.textTheme.labelLarge!.copyWith(
          fontSize: AppSizes.s14,
          color: AppColors.colorBaseBlack,
        ),
      ),
    ),
  ];
}

List<DataRow> getRowsAdmin({
  required List<UserData> data, // ganti dengan model aslimu
  required bool isLoading,
  required BuildContext context,
  required UserManajemenController controller,
}) {
  if (isLoading) {
    return [
      const DataRow(
        cells: [
          DataCell.empty,
          DataCell.empty,
          DataCell(Center(child: CircularProgressIndicator())),
          DataCell.empty,
          DataCell.empty,
          DataCell.empty,
        ],
      ),
    ];
  }

  if (data.isEmpty) {
    return [
      const DataRow(
        cells: [
          DataCell.empty,
          DataCell.empty,
          DataCell(Row(
            children: [
              Icon(Icons.highlight_off),
              SizedBox(width: 4),
              Text('Data tidak ditemukan..'),
            ],
          )),
          DataCell.empty,
          DataCell.empty,
          DataCell.empty,
        ],
      ),
    ];
  }

  return data.asMap().entries.map((entry) {
    final index = entry.key;
    final row = entry.value;
    final number = index + 1;

    return DataRow(
      color: WidgetStateProperty.resolveWith<Color>(
        (Set<WidgetState> states) {
          return index % 2 == 0
              ? Colors.white
              : AppColors.colorBasePrimary.withAlpha(80);
        },
      ),
      cells: [
        DataCell(
            Text(number.toString(), style: const TextStyle(fontWeight: FontWeight.bold))),
        DataCell(Text(row.name,
            style: const TextStyle(fontWeight: FontWeight.bold))),
        DataCell(Text(row.email,
            style: const TextStyle(fontWeight: FontWeight.bold))),
        DataCell(Text(row.jenisKelamin,
            style: const TextStyle(fontWeight: FontWeight.bold))),
        DataCell(Center(
          child: Text(row.noTelp,
              style: const TextStyle(fontWeight: FontWeight.bold)),
        )),
        DataCell(Center(
          child: Row(
            spacing: 10,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: AppColors.colorWarning300,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: IconButton(
                  onPressed: () {
                    controller.usernameController.text = row.username;
                    controller.nameController.text = row.name;
                    controller.emailController.text = row.email;
                    controller.jenisKelaminController.value = row.jenisKelamin;
                    controller.alamatController.text = row.alamat;
                    controller.tglLahirController.value = row.tglLahir;
                    controller.nikController.text = row.nik;
                    controller.noTelpController.text = row.noTelp;
                    controller.dropdownRoleController.text = row.role.name;
                    controller.idUser.value = row.id;
                    controller.showEditUser();
                  },
                  icon: Icon(
                    Icons.edit_square,
                    color: AppColors.colorBaseWhite,
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.colorError300,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: IconButton(
                  onPressed: () async {
                    showModalCenter(
                      context,
                      Obx(
                        () {
                          return controller.isLoadingPostNewMedicine.value
                              ? Center(
                                  child: SizedBox(
                                    width: 400,
                                    height: 400,
                                    child: Lottie.asset(Assets.lottie.hospital),
                                  ),
                                )
                              : ShowModalTandaTanyaComponent(
                                  label: '?',
                                  onTapNo: () {
                                    Get.back();
                                  },
                                  onTapYes: () async {
                                    // await controller.deleteNewMedicine(row.id);
                                  },
                                );
                        },
                      ),
                    );
                  },
                  icon: Icon(
                    Icons.delete_rounded,
                    color: AppColors.colorBaseWhite,
                  ),
                ),
              ),
            ],
          ),
        )),
      ],
    );
  }).toList();
}
