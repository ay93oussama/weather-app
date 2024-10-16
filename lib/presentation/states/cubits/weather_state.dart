import 'package:weather/domain/entities/weather.dart';

abstract class WeatherState {}

class WeatherInitialState extends WeatherState {}

class WeatherLoadingState extends WeatherState {}

class WeatherLoadedState extends WeatherState {
  final List<Weather> weathers;
  WeatherLoadedState(this.weathers);
}

class WeatherErrorState extends WeatherState {
  final String message; // Storing the error message directly
  WeatherErrorState(this.message);
}
