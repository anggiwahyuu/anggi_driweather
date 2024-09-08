import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:get/get.dart';

class WeatherCodeController extends  GetxController {
  final weatherCode = [].obs;

  @override
  void onInit() async {
    super.onInit();
    readJson();
  }

  Future<void> readJson() async {
    final response = await rootBundle.loadString("assets/json/weather_code.json");
    final encoded = utf8.encode(response);
    final decoded = utf8.decode(encoded);
    final data = await json.decode(decoded);

    weatherCode.value = data["weatherCode"];
  }
}