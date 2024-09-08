import 'package:anggi_driweather/controllers/maps_controller.dart';
import 'package:anggi_driweather/model/weather_model.dart';
import 'package:anggi_driweather/service/weather_service.dart';
import 'package:get/get.dart';

class WeatherController extends GetxController {
  final result = <WeatherResult>[].obs;

  late WeatherService weatherService;

  final isLoading = true.obs;

  final MapsController mapsController = Get.put(MapsController());

  WeatherController({required this.weatherService});

  @override
  void onInit() {
    super.onInit();
    fetchWeather(mapsController.latitude.value, mapsController.longitude.value);
  }

  void fetchWeather(double latitude, double longitude) async {
    try {
      isLoading(true);
      var weather = await weatherService.fetchWeatherData(latitude, longitude);
      if (weather.isNotEmpty) {
        result.value = weather;
      }
    } finally {
      isLoading(false);
    }
  }
}