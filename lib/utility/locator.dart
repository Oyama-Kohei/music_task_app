import 'package:get_it/get_it.dart';
import 'package:taskmum_flutter/components/repository/auth_repository.dart';
import 'package:taskmum_flutter/components/repository/user_repository.dart';
import 'package:taskmum_flutter/components/service/auth_service.dart';
import 'package:taskmum_flutter/components/service/user_service.dart';

GetIt getIt = GetIt.instance;

void setupLocator() {
  getIt.registerLazySingleton(() => AuthRepository());
  getIt.registerLazySingleton(() => AuthService());
  getIt.registerLazySingleton(() => UserRepository());
  getIt.registerLazySingleton(() => UserService());
}
