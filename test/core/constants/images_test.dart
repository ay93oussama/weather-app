import 'package:flutter_test/flutter_test.dart';
import 'package:weather/core/constants/images.dart';

void main() {
  group('UIImages.getWeatherIcon', () {
    test('returns thunderstorm rain icon for code 200', () {
      expect(UIImages.getWeatherIcon(200), UIImages.cloudWithLightningAndRain);
    });

    test('returns clear sky icon for code 800', () {
      expect(UIImages.getWeatherIcon(800), UIImages.sun);
    });

    test('returns broken clouds icon for code 803', () {
      expect(UIImages.getWeatherIcon(803), UIImages.sunBehindLargeCloud);
    });

    test('returns default icon for unknown code', () {
      expect(UIImages.getWeatherIcon(-1), UIImages.sunWithHappyFace);
    });
  });
}
