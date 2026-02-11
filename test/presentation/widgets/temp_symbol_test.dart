import 'package:flutter_test/flutter_test.dart';
import 'package:weather/core/constants/weather_params.dart';
import 'package:weather/presentation/widgets/temp_symbol.dart';

void main() {
  group('tempSymbol', () {
    setUp(() {
      WeatherParams.units = 'metric';
    });

    tearDown(() {
      WeatherParams.units = 'metric';
    });

    test('returns celsius symbol for metric units', () {
      WeatherParams.units = 'metric';

      expect(tempSymbol(), '°C');
    });

    test('returns fahrenheit symbol for imperial units', () {
      WeatherParams.units = 'imperial';

      expect(tempSymbol(), '°F');
    });
  });
}
