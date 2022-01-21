import 'package:get_it/get_it.dart';
import 'package:taskmum_flutter/components/service/auth_service.dart';
import 'package:taskmum_flutter/components/service/user_service.dart';

GetIt getIt = GetIt.instance;

void setupLocator() {
  getIt.registerLazySingleton(() => AuthService());
  getIt.registerLazySingleton(() => UserService());
}
