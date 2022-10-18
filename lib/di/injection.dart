import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../data/platform/api.dart';
import '../data/repository/repositories.dart';

final getIt = GetIt.asNewInstance();

configureDependencies() async {
  getIt.registerSingleton(Dio());
  getIt.registerLazySingleton(() => Api(getIt()));
  getIt.registerLazySingleton(() => WeatherRepository(api: getIt()));
}
