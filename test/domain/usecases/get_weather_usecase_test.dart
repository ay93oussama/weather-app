import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weather/core/errors/failures.dart';
import 'package:weather/core/helpers/usecase_helper.dart';
import 'package:weather/domain/entities/weather.dart';
import 'package:weather/domain/repositories/weather_repository.dart';
import 'package:weather/domain/usecases/get_weather_usecase.dart';

class FakeWeatherRepository implements WeatherRepository {
  Either<Failure, List<Weather>>? nextResult;
  int calls = 0;

  @override
  Future<Either<Failure, List<Weather>>> getWeather() async {
    calls++;
    return nextResult!;
  }
}

void main() {
  group('GetWeatherUseCase', () {
    test('returns weather list from repository', () async {
      final repository = FakeWeatherRepository();
      final useCase = GetWeatherUseCase(repository);
      final weathers = [Weather(dtTxt: DateTime(2024, 1, 1))];

      repository.nextResult = Right(weathers);

      final result = await useCase(NoParams());

      expect(repository.calls, 1);
      expect(result.isRight(), isTrue);
      result.fold(
        (_) => fail('Expected Right result.'),
        (value) => expect(value, weathers),
      );
    });

    test('returns failure from repository', () async {
      final repository = FakeWeatherRepository();
      final useCase = GetWeatherUseCase(repository);

      repository.nextResult = Left(NetworkFailure());

      final result = await useCase(NoParams());

      expect(repository.calls, 1);
      expect(result.isLeft(), isTrue);
      result.fold(
        (failure) => expect(failure, isA<NetworkFailure>()),
        (_) => fail('Expected Left result.'),
      );
    });
  });
}
