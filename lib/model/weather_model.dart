import 'dart:convert';

WeatherResult weatherResultFromJson(String str) => WeatherResult.fromJson(json.decode(str));
// String weatherResultToJson(WeatherResult data) =>jsonEncode(data.toJson());

class WeatherResult {
  DateTime time;
  WeatherModel values;

  WeatherResult({
    required this.time,
    required this.values
  });

  factory WeatherResult.fromJson(Map<String, dynamic> json) => WeatherResult(
    time: DateTime.parse(json["time"]), 
    values: WeatherModel.fromJson(json["values"])
  );
}

class WeatherModel {
  num temperature;
  num weatherCode;
  num windSpeed;
  num humidity;

  WeatherModel({
    required this.temperature,
    required this.weatherCode,
    required this.windSpeed,
    required this.humidity
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) => WeatherModel(
    temperature: num.parse(json["temperature"].toString()), 
    weatherCode: num.parse(json["weatherCode"].toString()),
    windSpeed: num.parse(json["windSpeed"].toString()),
    humidity: num.parse(json["humidity"].toString())
  );
}