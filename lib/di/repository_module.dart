import 'package:get_it/get_it.dart';
import 'package:klinik_web_responsif/services/auth/auth_repository.dart';
import 'package:klinik_web_responsif/services/doctor/doctor_repository.dart';
import 'package:klinik_web_responsif/services/pasien/pasien_repository.dart';
import 'package:klinik_web_responsif/services/rme/rme_repository.dart';

void initRepositoriesModule(GetIt locator) {
  locator
      .registerLazySingleton<AuthRepository>(() => AuthRepository(locator()));
  locator.registerLazySingleton<PasienRepository>(
      () => PasienRepository(locator()));
  locator.registerLazySingleton<RmeRepository>(
      () => RmeRepository(locator()));
  locator.registerLazySingleton<DoctorRepository>(
      () => DoctorRepository(locator()));
}
