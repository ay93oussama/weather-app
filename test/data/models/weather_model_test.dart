import 'package:flutter_test/flutter_test.dart';
import 'package:weather/data/models/weather_model.dart';

void main() {
  group('WeatherModel.fromJson', () {
    test('parses full payload correctly', () {
      final json = {
        'main': {
          'temp': 21.4,
          'temp_min': 19.8,
          'pressure': 1012,
          'humidity': 77,
        },
        'weather': [
          {
            'id': 800,
            'main': 'Clear',
            'description': 'clear sky',
          }
        ],
        'wind': {'speed': 4.9},
        'dt_txt': '2024-11-15 09:00:00',
      };

      final model = WeatherModel.fromJson(json);

      expect(model.main?.temp, 21.4);
      expect(model.main?.tempMin, 19.8);
      expect(model.main?.pressure, 1012);
      expect(model.main?.humidity, 77);
      expect(model.weather?.first.id, 800);
      expect(model.weather?.first.main, 'Clear');
      expect(model.wind?.speed, 4.9);
      expect(model.dtTxt, DateTime.parse('2024-11-15 09:00:00'));
    });

    test('uses safe defaults when values are missing', () {
      final model = WeatherModel.fromJson({});

      expect(model.main, isNull);
      expect(model.weather, isEmpty);
      expect(model.wind, isNull);
      expect(model.dtTxt, isNull);
    });
  });
}
