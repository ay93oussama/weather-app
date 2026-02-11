import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weather/core/errors/failures.dart';
import 'package:weather/domain/entities/weather.dart';
import 'package:weather/domain/repositories/weather_repository.dart';
import 'package:weather/domain/usecases/get_weather_usecase.dart';
import 'package:weather/presentation/states/cubits/weather_state.dart';
import 'package:weather/presentation/states/cubits/wether_cubit.dart';

class FakeWeatherRepository implements WeatherRepository {
  Either<Failure, List<Weather>>? nextResult;
  Object? throwable;

  @override
  Future<Either<Failure, List<Weather>>> getWeather() async {
    if (throwable != null) {
      throw throwable!;
    }
    return nextResult!;
  }
}

void main() {
  group('WeatherCubit', () {
    late FakeWeatherRepository repository;
    late WeatherCubit cubit;

    setUp(() {
      repository = FakeWeatherRepository();
      cubit = WeatherCubit(GetWeatherUseCase(repository));
    });

    tearDown(() async {
      await cubit.close();
    });

    test('starts with WeatherInitialState', () {
      expect(cubit.state, isA<WeatherInitialState>());
    });

    test('emits loading then loaded with unique days', () async {
      repository.nextResult = Right([
        Weather(
          dtTxt: DateTime(2024, 11, 15, 9, 0),
          main: Main(temp: 20),
          weather: [WeatherElement(id: 800, main: 'Clear')],
        ),
        Weather(
          dtTxt: DateTime(2024, 11, 15, 12, 0),
          main: Main(temp: 22),
          weather: [WeatherElement(id: 801, main: 'Clouds')],
        ),
        Weather(
          dtTxt: DateTime(2024, 11, 16, 9, 0),
          main: Main(temp: 18),
          weather: [WeatherElement(id: 500, main: 'Rain')],
        ),
      ]);

      final expectation = expectLater(
        cubit.stream,
        emitsInOrder([
          isA<WeatherLoadingState>(),
          predicate<WeatherLoadedState>(
            (state) =>
                state.weathers.length == 2 &&
                state.weathers.first.dtTxt?.day == 15 &&
                state.weathers.last.dtTxt?.day == 16,
          ),
        ]),
      );

      cubit.fetchWeather();

      await expectation;
    });

    test('emits loading then mapped network error message', () async {
      repository.nextResult = Left(NetworkFailure());

      final expectation = expectLater(
        cubit.stream,
        emitsInOrder([
          isA<WeatherLoadingState>(),
          predicate<WeatherErrorState>(
            (state) =>
                state.message ==
                'Network connection error. Please check your internet connection.',
          ),
        ]),
      );

      cubit.fetchWeather();

      await expectation;
    });

    test('emits loading then generic error when exception is thrown', () async {
      repository.throwable = Exception('unexpected');

      final expectation = expectLater(
        cubit.stream,
        emitsInOrder([
          isA<WeatherLoadingState>(),
          predicate<WeatherErrorState>(
            (state) =>
                state.message ==
                'An unexpected error occurred. Please try again.',
          ),
        ]),
      );

      cubit.fetchWeather();

      await expectation;
    });
  });
}
