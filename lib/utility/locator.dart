import 'package:get_it/get_it.dart';
import 'package:askMu/components/service/album_service.dart';
import 'package:askMu/components/service/auth_service.dart';
import 'package:askMu/components/service/task_service.dart';
import 'package:askMu/components/service/user_service.dart';

GetIt getIt = GetIt.instance;

void setupLocator() {
  getIt.registerLazySingleton(() => AuthService());
  getIt.registerLazySingleton(() => UserService());
  getIt.registerLazySingleton(() => TaskService());
  getIt.registerLazySingleton(() => AlbumService());
}
