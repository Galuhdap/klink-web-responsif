import 'package:flutter/material.dart';

void showRightModal(BuildContext context, Widget widget) {
  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
    transitionDuration: Duration(milliseconds: 300),
    pageBuilder: (context, animation, secondaryAnimation) {
      return Align(
        alignment: Alignment.centerRight,
        child: Material(
          child: Container(
            width: 973,
            height: double.infinity,
            color: Colors.white,
            child: widget,
          ),
        ),
      );
    },
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      return SlideTransition(
        position: Tween<Offset>(
          begin: Offset(1, 0), // Mulai dari kanan
          end: Offset(0, 0),
        ).animate(animation),
        child: child,
      );
    },
  );
}
