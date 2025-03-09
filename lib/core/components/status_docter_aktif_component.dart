import 'package:flutter/material.dart';
import 'package:klinik_web_responsif/core/styles/app_sizes.dart';
import 'package:klinik_web_responsif/core/utils/helpers/status_docter_aktif_helper.dart';

class StatusDoctorAktifComponent extends StatelessWidget {
  final String status;
  const StatusDoctorAktifComponent({
    super.key,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 103,
        height: 29,
        decoration: BoxDecoration(
          color: setStatusDoctorColorFill(status.labelDocterAktifStatus),
          borderRadius: BorderRadius.circular(AppSizes.s5),
        ),
        child: Center(child: setStatusNameDoctor(status.labelDocterAktifStatus)),
      ),
    );
  }
}
