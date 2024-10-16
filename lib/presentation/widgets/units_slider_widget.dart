import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather/core/constants/weather_params.dart';

class UnitsSliderWidget extends StatefulWidget {
  const UnitsSliderWidget({super.key});

  @override
  State<UnitsSliderWidget> createState() => _UnitsSliderWidgetState();
}

class _UnitsSliderWidgetState extends State<UnitsSliderWidget> {
  int _selectedSegment = 0;
  final Map<int, Widget> _segments = const <int, Widget>{
    0: Text(
      '°C',
      style: TextStyle(fontWeight: FontWeight.bold),
    ),
    1: Text(
      '°F',
      style: TextStyle(fontWeight: FontWeight.bold),
    ),
  };

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: CupertinoSlidingSegmentedControl<int>(
        backgroundColor: Colors.white.withOpacity(0.6),
        groupValue: _selectedSegment,
        children: _segments,
        onValueChanged: (int? newValue) {
          if (newValue != null) {
            WeatherParams.switchUnits(context);
            setState(() => _selectedSegment = newValue);
          }
        },
      ),
    );
  }
}
