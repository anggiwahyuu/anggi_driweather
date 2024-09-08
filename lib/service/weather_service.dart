import 'package:anggi_driweather/model/weather_model.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';

class WeatherService extends GetxService {
  Dio dio = Dio();
  static const String apiKey = "POm1qzcDaj5HVBVBMqsYSuz9Fc0YTrIu";

  final isLoading = true.obs;

  Future<List<WeatherResult>> fetchWeatherData(double latitude, double longitude) async {
    String url = "https://api.tomorrow.io/v4/weather/forecast?location=$latitude,$longitude&apikey=$apiKey";
    try {
      isLoading(true);
      final response = await dio.get(url);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final jsonResponse = response.data;
        final data = jsonResponse['timelines']["hourly"];

        List<WeatherResult> result = List.from(data.map((x) => WeatherResult.fromJson(x)));

        return result;
      } else {
        throw Exception();
      }
    } catch(e) {
      rethrow;
    } finally{
      isLoading(false);
    }
  }
}