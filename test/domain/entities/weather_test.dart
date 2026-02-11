import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:weather/domain/entities/weather.dart';

void main() {
  group('Weather entity formatters', () {
    late String? previousLocale;

    setUp(() {
      previousLocale = Intl.defaultLocale;
      Intl.defaultLocale = 'en_US';
    });

    tearDown(() {
      Intl.defaultLocale = previousLocale;
    });

    test('formattedDate returns a readable date for valid dtTxt', () {
      final weather = Weather(
        dtTxt: DateTime(2024, 11, 15, 9, 41),
      );

      expect(weather.formattedDate, startsWith('Friday 15 • 09.41 '));
    });

    test('formattedDate returns fallback when dtTxt is null', () {
      final weather = Weather();

      expect(weather.formattedDate, 'Not available');
    });

    test('formattedAbbreviatedDayOfWeekName returns abbreviated day', () {
      final weather = Weather(
        dtTxt: DateTime(2024, 11, 15, 9, 41),
      );

      expect(weather.formattedAbbreviatedDayOfWeekName, 'Fri');
    });

    test('formattedAbbreviatedDayOfWeekName returns fallback when null', () {
      final weather = Weather();

      expect(weather.formattedAbbreviatedDayOfWeekName, 'Not available');
    });
  });
}
