import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weather/core/errors/exceptions.dart';
import 'package:weather/core/router/app_router.dart';

void main() {
  group('AppRouter.onGenerateRoute', () {
    test('returns route for main view', () {
      final route = AppRouter.onGenerateRoute(
        const RouteSettings(name: AppRouter.mainView),
      );

      expect(route, isA<MaterialPageRoute<dynamic>>());
    });

    test('returns route for week weather view', () {
      final route = AppRouter.onGenerateRoute(
        const RouteSettings(name: AppRouter.weekWeatherView),
      );

      expect(route, isA<MaterialPageRoute<dynamic>>());
    });

    test('throws RouteException for unknown route', () {
      expect(
        () => AppRouter.onGenerateRoute(
          const RouteSettings(name: '/missing'),
        ),
        throwsA(isA<RouteException>()),
      );
    });
  });
}
