import 'package:get_it/get_it.dart';
import 'package:klinik_web_responsif/di/data_source_module.dart';
import 'package:klinik_web_responsif/di/repository_module.dart';

final locator = GetIt.instance;

Future<void> init() async {
  initDataSourcesModule(locator);
  initRepositoriesModule(locator);
}
