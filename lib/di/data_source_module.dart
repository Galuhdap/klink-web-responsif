import 'package:get_it/get_it.dart';
import 'package:klinik_web_responsif/services/apotik/apotik_datasources.dart';
import 'package:klinik_web_responsif/services/auth/auth_datasources.dart';
import 'package:klinik_web_responsif/services/doctor/doctor_datasources.dart';
import 'package:klinik_web_responsif/services/owner/owner_datasources.dart';
import 'package:klinik_web_responsif/services/pasien/pasien_datasources.dart';
import 'package:klinik_web_responsif/services/report/report_datasources.dart';
import 'package:klinik_web_responsif/services/rme/rme_datasources.dart';


void initDataSourcesModule(GetIt locator) {
 locator.registerLazySingleton<AuthDatasources>(() => AuthDatasources());
 locator.registerLazySingleton<PasienDatasources>(() => PasienDatasources());
 locator.registerLazySingleton<RmeDatasources>(() => RmeDatasources());
 locator.registerLazySingleton<DoctorDatasources>(() => DoctorDatasources());
 locator.registerLazySingleton<ApotikDatasources>(() => ApotikDatasources());
 locator.registerLazySingleton<OwnerDatasources>(() => OwnerDatasources());
 locator.registerLazySingleton<ReportDatasources>(() => ReportDatasources());

}
