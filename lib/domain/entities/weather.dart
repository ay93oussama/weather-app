import 'package:intl/intl.dart';

class Weather {
  Main? main;
  List<WeatherElement>? weather;
  Wind? wind;
  DateTime? dtTxt;

  // Getter to format the date
  String get formattedDate {
    if (dtTxt == null) {
      return 'Not available';
    }

    final date = dtTxt!;

    String dayOfWeek = DateFormat('EEEE').format(date); // e.g., Friday
    String dayOfMonth = DateFormat('d').format(date); // e.g., 16
    String time = DateFormat('hh.mm a').format(date); // e.g., 09.41 am

    return '$dayOfWeek $dayOfMonth • $time';
  }

  String get formattedAbbreviatedDayOfWeekName {
    if (dtTxt == null) {
      return 'Not available';
    }

    final date = dtTxt!;

    String abbreviatedDayOfWeek = DateFormat('EEE').format(date); // e.g., Fri

    return abbreviatedDayOfWeek;
  }

  Weather({
    this.main,
    this.weather,
    this.wind,
    this.dtTxt,
  });
}

class Main {
  double? temp;
  double? tempMin;
  int? pressure;
  int? humidity;

  Main({
    this.temp,
    this.tempMin,
    this.pressure,
    this.humidity,
  });
}

class WeatherElement {
  int? id;
  String? main;
  String? description;

  WeatherElement({
    this.id,
    this.main,
    this.description,
  });
}

class Wind {
  double? speed;

  Wind({
    this.speed,
  });
}
