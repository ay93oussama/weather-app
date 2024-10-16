import 'package:weather/core/constants/weather_params.dart';

String tempSymbol() {
  if (WeatherParams.units == 'metric') {
    return '°C';
  } else {
    return '°F';
  }
}
