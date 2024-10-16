import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/presentation/states/cubits/wether_cubit.dart';

class WeatherParams {
  static String units = 'metric';

  static switchUnits(BuildContext context) {
    if (units == 'metric') {
      units = 'imperial';
      BlocProvider.of<WeatherCubit>(context).fetchWeather();
    } else {
      units = 'metric';
      BlocProvider.of<WeatherCubit>(context).fetchWeather();
    }
  }
}
