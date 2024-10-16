import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:weather/data/data_sources/remote/weather_remote_data_source.dart';
import 'package:weather/data/repositories/weather_repository_impl.dart';
import 'package:weather/domain/repositories/weather_repository.dart';
import 'package:weather/domain/usecases/get_weather_usecase.dart';
import 'package:weather/presentation/states/cubits/wether_cubit.dart';

import '../network/network_info.dart';

final sl = GetIt.instance;

Future<void> init() async {
  /// Cubit
  /// Feature - Weather

  sl.registerFactory(() => WeatherCubit(sl()));
  // Use cases

  sl.registerLazySingleton(() => GetWeatherUseCase(sl()));

  // Repository
  sl.registerLazySingleton<WeatherRepository>(() => WeatherRepositoryImpl(
        remoteDataSource: sl(),
        networkInfo: sl(),
      ));
  // Data sources
  sl.registerLazySingleton<WeatherRemoteDataSource>(() => WeatherRemoteDataSourceImpl(httpClient: sl()));

  ///***********************************************
  ///! Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  ///! External

  sl.registerLazySingleton(() => HttpClientWithMiddleware.build(middlewares: [HttpLogger(logLevel: LogLevel.BASIC)]));
  sl.registerLazySingleton(() => InternetConnection());
}
