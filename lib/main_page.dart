
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:klinik_web_responsif/core/config/theme_config.dart';
import 'package:klinik_web_responsif/routes/app_routes.dart';


class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Bank Sampah Rebuild',
      initialRoute: AppRoutes.main,
      theme: ThemeConfig.lightMode,
      debugShowCheckedModeBanner: false,
      getPages: AppRoutes.routes,
    );
  }
}
