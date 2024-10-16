import 'package:dartz/dartz.dart';
import 'package:weather/core/errors/failures.dart';
import 'package:weather/core/helpers/usecase_helper.dart';
import 'package:weather/domain/entities/weather.dart';
import 'package:weather/domain/repositories/weather_repository.dart';

class GetWeatherUseCase implements UseCase<List<Weather>, NoParams> {
  final WeatherRepository repository;
  GetWeatherUseCase(this.repository);

  @override
  Future<Either<Failure, List<Weather>>> call(NoParams params) async {
    return await repository.getWeather();
  }
}
