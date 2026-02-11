import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:weather/core/constants/weather_params.dart';
import 'package:weather/core/errors/exceptions.dart';
import 'package:weather/data/data_sources/remote/weather_remote_data_source.dart';

void main() {
  group('WeatherRemoteDataSourceImpl', () {
    setUp(() {
      WeatherParams.units = 'metric';
    });

    test('returns weather models on status 200', () async {
      final client = MockClient((request) async {
        expect(request.url.host, 'api.openweathermap.org');
        expect(request.url.path, '/data/2.5/forecast');
        expect(request.url.queryParameters['lat'], '49.057187');
        expect(request.url.queryParameters['lon'], '8.471033');
        expect(request.url.queryParameters['units'], 'metric');
        expect(request.url.queryParameters['appid'], isNotEmpty);

        return http.Response(
          jsonEncode({
            'list': [
              {
                'main': {
                  'temp': 22.0,
                  'temp_min': 20.0,
                  'pressure': 1010,
                  'humidity': 60,
                },
                'weather': [
                  {
                    'id': 800,
                    'main': 'Clear',
                    'description': 'clear sky',
                  }
                ],
                'wind': {'speed': 3.5},
                'dt_txt': '2024-11-15 09:00:00',
              }
            ]
          }),
          200,
        );
      });
      final dataSource = WeatherRemoteDataSourceImpl(httpClient: client);

      final result = await dataSource.getWeather();

      expect(result, hasLength(1));
      expect(result.first.main?.temp, 22.0);
      expect(result.first.weather?.first.id, 800);
    });

    test('throws ServerException on non-200 status', () async {
      final client = MockClient(
        (_) async => http.Response('{}', 500),
      );
      final dataSource = WeatherRemoteDataSourceImpl(httpClient: client);

      expect(
        dataSource.getWeather,
        throwsA(isA<ServerException>()),
      );
    });
  });
}
