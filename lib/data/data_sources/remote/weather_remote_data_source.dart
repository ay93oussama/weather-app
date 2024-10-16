import 'dart:convert';

import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:weather/core/constants/weather_params.dart';
import 'package:weather/core/errors/exceptions.dart';
import 'package:weather/data/models/weather_model.dart';

abstract class WeatherRemoteDataSource {
  Future<List<WeatherModel>> getWeather();
}

class WeatherRemoteDataSourceImpl implements WeatherRemoteDataSource {
  HttpClientWithMiddleware httpClient;

  WeatherRemoteDataSourceImpl({required this.httpClient});

  @override
  Future<List<WeatherModel>> getWeather() async {
    String passKey = '294f083b167c05c50642e43e2babc299';
    String baseUrl = 'api.openweathermap.org';

    Uri url = Uri.https(baseUrl, '/data/2.5/forecast', {
      'lat': '54.104142',
      'lon': '12.174403',
      'units': WeatherParams.units,
      'appid': passKey,
    });

    final response = await httpClient.get(url);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body)['list'];
      List weathers = json as List;
      return weathers.map((e) => WeatherModel.fromJson(e)).toList();
    } else {
      throw ServerException();
    }
  }
}
