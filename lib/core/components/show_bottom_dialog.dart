import 'package:flutter/material.dart';

Future<dynamic> showModalBottom(BuildContext context, Widget widget) {
  return showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    backgroundColor: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadiusDirectional.only(
        topEnd: Radius.circular(25),
        topStart: Radius.circular(25),
      ),
    ),
    builder: (context) {
      return SingleChildScrollView(
        padding: EdgeInsetsDirectional.only(
          // start: 20,
          // end: 10,
          //bottom: MediaQuery.of(context).viewInsets.bottom + 30,
          // top: 8,
        ),
        child: widget,
      );
    },
  );
}
