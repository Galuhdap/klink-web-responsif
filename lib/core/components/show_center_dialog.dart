import 'package:flutter/material.dart';
import 'package:klinik_web_responsif/core/config/responsive.dart';

Future<dynamic> showModalCenter(BuildContext context, Widget widget) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        content: Container(
            width: Responsive.isMobile(context)
                ? MediaQuery.of(context).size.width / 1
                : MediaQuery.of(context).size.width / 2,
            height: MediaQuery.of(context).size.height * 0.7,
            child: widget),
        insetPadding: const EdgeInsets.all(10),
      );
    },
  );
}
