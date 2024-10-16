import 'package:dartz/dartz.dart';
import 'package:weather/core/errors/failures.dart';
import 'package:weather/domain/entities/weather.dart';

abstract class WeatherRepository {
  Future<Either<Failure, List<Weather>>> getWeather();
}
