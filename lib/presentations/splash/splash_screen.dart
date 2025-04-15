import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:klinik_web_responsif/presentations/splash/splash_controller.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SplashController());
    return Scaffold();
  }
}
