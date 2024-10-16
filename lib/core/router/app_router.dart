import 'package:flutter/material.dart';
import 'package:weather/core/errors/exceptions.dart';
import 'package:weather/presentation/views/main_view.dart';
import 'package:weather/presentation/views/week_weather_view.dart';

class AppRouter {
  // Define unique route paths for each view
  static const String mainView = '/';
  static const String weekWeatherView = '/weekWeather';

  static Route<dynamic> onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case mainView:
        return MaterialPageRoute(builder: (_) => const MainView());
      case weekWeatherView:
        return MaterialPageRoute(builder: (_) => const WeekWeatherView());
      default:
        throw const RouteException('Route not found!');
    }
  }
}
