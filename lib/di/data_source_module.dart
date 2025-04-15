import 'package:get_it/get_it.dart';
import 'package:klinik_web_responsif/services/auth/auth_datasources.dart';
import 'package:klinik_web_responsif/services/doctor/doctor_datasources.dart';
import 'package:klinik_web_responsif/services/pasien/pasien_datasources.dart';
import 'package:klinik_web_responsif/services/rme/rme_datasources.dart';


void initDataSourcesModule(GetIt locator) {
 locator.registerLazySingleton<AuthDatasources>(() => AuthDatasources());
 locator.registerLazySingleton<PasienDatasources>(() => PasienDatasources());
 locator.registerLazySingleton<RmeDatasources>(() => RmeDatasources());
 locator.registerLazySingleton<DoctorDatasources>(() => DoctorDatasources());

}
