import 'package:anggi_driweather/detail/detail_view.dart';
import 'package:anggi_driweather/home/home_view.dart';
import 'package:anggi_driweather/maps/maps_view.dart';
import 'package:anggi_driweather/onboard/onboard_view.dart';
import 'package:anggi_driweather/service/weather_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(WeatherService());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: "/",
      getPages: [
        GetPage(name: "/", page: () => const OnBoardView()),
        GetPage(name: "/home", page: () => HomeView()),
        GetPage(name: "/detail", page: () => DetailView()),
        GetPage(name: "/maps", page: () => MapsView())
      ],
    );
  }
}