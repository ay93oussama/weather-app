import 'package:dartz/dartz.dart';
import 'package:weather/core/errors/failures.dart';
import 'package:weather/core/network/network_info.dart';
import 'package:weather/data/data_sources/remote/weather_remote_data_source.dart';
import 'package:weather/domain/entities/weather.dart';
import 'package:weather/domain/repositories/weather_repository.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final WeatherRemoteDataSource remoteDataSource;

  final NetworkInfo networkInfo;

  WeatherRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<Weather>>> getWeather() async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDataSource.getWeather();
        return Right(response);
      } on Failure catch (failure) {
        return Left(failure);
      }
    } else {
      return Left(NetworkFailure());
    }
  }
}
