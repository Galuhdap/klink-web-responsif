import 'package:flutter/material.dart';
import 'package:klinik_web_responsif/core/styles/app_sizes.dart';
import 'package:klinik_web_responsif/core/utils/helpers/status_antrian_helper.dart';

class StatusAntrianComponent extends StatelessWidget {
  final String status;
  const StatusAntrianComponent({
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
          color: setStatusColorFill(status.labelAntrianStatus),
          borderRadius: BorderRadius.circular(AppSizes.s5),
        ),
        child: Center(child: setStatusName(status.labelAntrianStatus)),
      ),
    );
  }
}
