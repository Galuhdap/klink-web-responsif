import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:klinik_web_responsif/core/styles/app_colors.dart';
import 'package:klinik_web_responsif/core/styles/app_sizes.dart';
import 'package:klinik_web_responsif/presentations/apotik/controller/apotik_controller.dart';
import 'package:klinik_web_responsif/services/pasien/model/response/get_antrian_pasien_response.dart';

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
            controllerApotik.showAddTransaction();
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
