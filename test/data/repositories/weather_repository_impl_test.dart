import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weather/core/errors/exceptions.dart';
import 'package:weather/core/errors/failures.dart';
import 'package:weather/core/network/network_info.dart';
import 'package:weather/data/data_sources/remote/weather_remote_data_source.dart';
import 'package:weather/data/models/weather_model.dart';
import 'package:weather/data/repositories/weather_repository_impl.dart';
import 'package:weather/domain/entities/weather.dart';

class FakeWeatherRemoteDataSource implements WeatherRemoteDataSource {
  Future<List<WeatherModel>> Function()? getWeatherHandler;
  int calls = 0;

  @override
  Future<List<WeatherModel>> getWeather() async {
    calls++;
    return getWeatherHandler!.call();
  }
}

class FakeNetworkInfo implements NetworkInfo {
  bool connected = true;

  @override
  Future<bool> get isConnected async => connected;
}

void main() {
  group('WeatherRepositoryImpl', () {
    late FakeWeatherRemoteDataSource remoteDataSource;
    late FakeNetworkInfo networkInfo;
    late WeatherRepositoryImpl repository;

    setUp(() {
      remoteDataSource = FakeWeatherRemoteDataSource();
      networkInfo = FakeNetworkInfo();
      repository = WeatherRepositoryImpl(
        remoteDataSource: remoteDataSource,
        networkInfo: networkInfo,
      );
    });

    test('returns weather list when online and remote call succeeds', () async {
      final expected = <WeatherModel>[
        WeatherModel(dtTxt: DateTime(2024, 1, 1)),
      ];
      remoteDataSource.getWeatherHandler = () async => expected;

      final result = await repository.getWeather();

      expect(remoteDataSource.calls, 1);
      expect(result.isRight(), isTrue);
      result.fold(
        (_) => fail('Expected Right result.'),
        (weathers) => expect(weathers, expected),
      );
    });

    test('returns NetworkFailure when offline', () async {
      networkInfo.connected = false;
      remoteDataSource.getWeatherHandler = () async => [];

      final result = await repository.getWeather();

      expect(remoteDataSource.calls, 0);
      expect(result.isLeft(), isTrue);
      result.fold(
        (failure) => expect(failure, isA<NetworkFailure>()),
        (_) => fail('Expected Left result.'),
      );
    });

    test('maps ServerException to ServerFailure', () async {
      remoteDataSource.getWeatherHandler = () async => throw ServerException();

      final result = await repository.getWeather();

      expect(result.isLeft(), isTrue);
      result.fold(
        (failure) => expect(failure, isA<ServerFailure>()),
        (_) => fail('Expected Left result.'),
      );
    });

    test('returns Failure directly when thrown by data source', () async {
      remoteDataSource.getWeatherHandler = () async => throw NetworkFailure();

      final result = await repository.getWeather();

      expect(result.isLeft(), isTrue);
      result.fold(
        (failure) => expect(failure, isA<NetworkFailure>()),
        (_) => fail('Expected Left result.'),
      );
    });

    test('maps unexpected exception to ExceptionFailure', () async {
      remoteDataSource.getWeatherHandler = () async => throw Exception('boom');

      final result = await repository.getWeather();

      expect(result.isLeft(), isTrue);
      result.fold(
        (failure) => expect(failure, isA<ExceptionFailure>()),
        (_) => fail('Expected Left result.'),
      );
    });
  });
}
