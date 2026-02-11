import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weather/presentation/widgets/divider_widget.dart';
import 'package:weather/presentation/widgets/loading_widget.dart';

void main() {
  testWidgets('LoadingWidget renders image', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(body: LoadingWidget()),
      ),
    );

    expect(find.byType(Image), findsOneWidget);
  });

  testWidgets('DividerWidget renders divider', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(body: DividerWidget()),
      ),
    );

    expect(find.byType(Divider), findsOneWidget);
  });
}
