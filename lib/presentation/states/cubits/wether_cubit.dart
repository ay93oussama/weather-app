import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/core/errors/failures.dart';
import 'package:weather/core/helpers/usecase_helper.dart';
import 'package:weather/domain/entities/weather.dart';
import 'package:weather/domain/usecases/get_weather_usecase.dart';
import 'package:weather/presentation/states/cubits/weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  final GetWeatherUseCase _getWeatherUseCase;

  WeatherCubit(this._getWeatherUseCase) : super(WeatherInitialState());

  void fetchWeather() async {
    try {
      emit(WeatherLoadingState());
      final result = await _getWeatherUseCase(NoParams());

      result.fold(
        (failure) => emit(WeatherErrorState(_mapFailureToMessage(failure))),
        (weathers) {
          // Filtering duplicate weather based on dtTxt
          final uniqueWeather = _filterDuplicateWeather(weathers);
          emit(WeatherLoadedState(uniqueWeather));
        },
      );
    } catch (e) {
      emit(WeatherErrorState("An unexpected error occurred. Please try again."));
    }
  }

  List<Weather> _filterDuplicateWeather(List<Weather> weathers) {
    // Create a map to store unique weather entries by date
    Map<String, Weather> uniqueWeatherMap = {};

    for (var weather in weathers) {
      // Assuming dtTxt is of type DateTime
      String dateKey = weather.dtTxt!.day.toString().padLeft(2, '0');

      // Add to the map if the date key does not exist
      if (!uniqueWeatherMap.containsKey(dateKey)) {
        uniqueWeatherMap[dateKey] = weather; // Store the Weather object
      }
    }

    // Return the list of unique weather entries
    return uniqueWeatherMap.values.toList();
  }

  // Method to map Failure types to user-friendly error messages
  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return 'Server error occurred. Please try again later.';
      case NetworkFailure:
        return 'Network connection error. Please check your internet connection.';
      case ExceptionFailure:
        return 'An unexpected error occurred. Please try again.';
      default:
        return 'An unknown error occurred.';
    }
  }
}
