// To parse this JSON data, do
//
//     final weatherModel = weatherModelFromJson(jsonString);

import 'dart:convert';

import 'package:weather/domain/entities/weather.dart';

WeatherModel weatherModelFromJson(String str) => WeatherModel.fromJson(json.decode(str));

class WeatherModel extends Weather {
  WeatherModel({
    super.main,
    super.weather,
    super.wind,
    super.dtTxt,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) => WeatherModel(
        main: json["main"] == null ? null : MainModel.fromJson(json["main"]),
        weather: json["weather"] == null ? [] : List<WeatherElementModel>.from(json["weather"]!.map((x) => WeatherElementModel.fromJson(x))),
        wind: json["wind"] == null ? null : WindModel.fromJson(json["wind"]),
        dtTxt: json["dt_txt"] == null ? null : DateTime.parse(json["dt_txt"]),
      );
}

class MainModel extends Main {
  MainModel({
    super.temp,
    super.tempMin,
    super.pressure,
    super.humidity,
  });

  factory MainModel.fromJson(Map<String, dynamic> json) => MainModel(
        temp: json["temp"]?.toDouble(),
        tempMin: json["temp_min"]?.toDouble(),
        pressure: json["pressure"],
        humidity: json["humidity"],
      );
}

class WeatherElementModel extends WeatherElement {
  WeatherElementModel({
    super.id,
    super.main,
    super.description,
  });

  factory WeatherElementModel.fromJson(Map<String, dynamic> json) => WeatherElementModel(
        id: json["id"],
        main: json["main"],
        description: json["description"],
      );
}

class WindModel extends Wind {
  WindModel({
    super.speed,
  });

  factory WindModel.fromJson(Map<String, dynamic> json) => WindModel(
        speed: json["speed"]?.toDouble(),
      );
}
