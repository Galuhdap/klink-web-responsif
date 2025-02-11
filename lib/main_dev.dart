import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:klinik_web_responsif/core/config/flavor_config.dart';
import 'package:klinik_web_responsif/di/application_module.dart';
import 'package:klinik_web_responsif/main_page.dart';
import 'package:klinik_web_responsif/services/lib/network_constants.dart';

class MyHttpoverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {
  await initializeDateFormatting('id_ID', null);
  await init();
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = new MyHttpoverrides();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  ConfigApps(
      flavor: Flavor.DEVELOPMENT,
      baseUrl: NetworkConstants.BASE_URL,);
  runZonedGuarded(() async {
      runApp(new MainPage());
  }, (error, stack) => print(error));
}