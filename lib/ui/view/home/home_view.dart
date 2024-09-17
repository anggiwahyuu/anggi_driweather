import 'package:anggi_driweather/ui/components/background.dart';
import 'package:anggi_driweather/controllers/maps_controller.dart';
import 'package:anggi_driweather/controllers/notification_controller.dart';
import 'package:anggi_driweather/controllers/weather_code_controller.dart';
import 'package:anggi_driweather/controllers/weather_controller.dart';
import 'package:anggi_driweather/service/weather_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import  'package:intl/intl.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});

  final imgWeather = "".obs;
  final infoWeather  = "".obs;

  final index = 0.obs;

  final WeatherCodeController weatherCodeController = Get.put(WeatherCodeController());

  final MapsController mapsController = Get.put(MapsController());
  
  final NotificationController notificationController = Get.put(NotificationController());

  final WeatherController weatherController = Get.put(WeatherController(weatherService: Get.find<WeatherService>()));

  Future refreshData() async {
    await Future.delayed(const Duration(seconds: 2));
    weatherController.onInit();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        onLongPress: refreshData,
        child: Stack(
          children: [
            const Background(image: "assets/images/bg-home.png"),
        
            SafeArea(
              child: Obx(() {
                mapsController.getRegency(mapsController.latitude.value, mapsController.longitude.value);
            
                if(weatherController.isLoading.value == true) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  for (int i = 0; i < weatherController.result.length; i++) {
                    if (DateFormat('d MMMM, HH').format(weatherController.result[i].time) == DateFormat('d MMMM, HH').format(DateTime.now())) {
                      index.value = i;
                    }
                  }
            
                  for (int i = 0; i < weatherCodeController.weatherCode.length; i++) {
                    if (weatherController.result[index.value].values.weatherCode == weatherCodeController.weatherCode[i]["code"]) {
                      imgWeather.value = weatherCodeController.weatherCode[i]["imageUrl"];
                      infoWeather.value = weatherCodeController.weatherCode[i]["information"];
                    }
                  }
            
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                Get.toNamed("/maps");
                              },
                              child: SizedBox(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.location_on_outlined, 
                                      color: Colors.white,
                                      size: 25,
                                    ),
                                
                                    const SizedBox(width: 10,),
                                
                                    Text(
                                      mapsController.location.value,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold
                                      ),
                                    ),
                                
                                    const SizedBox(width: 15,),
                                
                                    SizedBox(
                                      child: Image.asset("assets/images/arrow_down.png"),
                                    )
                                  ],
                                ),
                              ),
                            ),
                  
                            IconButton(
                              onPressed: () => notificationController.showNotification(), 
                              icon: Image.asset("assets/images/alarm_notif.png")
                            )
                          ],
                        ),
                  
                        Image.network(imgWeather.value),
                  
                        Container(
                          padding: const EdgeInsets.all(20),
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.width / 1.2,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: const Color.fromRGBO(255, 255, 255, 0.3)
                          ),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Today, ${DateFormat('d MMMM').format(weatherController.result[index.value].time)}",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                                ),
                  
                                Text(
                                  "${weatherController.result[index.value].values.temperature.round()}°",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 80,
                                  ),
                                ),
                  
                                Text(
                                  infoWeather.value,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                  
                                Column(
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width / 2,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            width: 24,
                                            height: 24,
                                            decoration: const BoxDecoration(
                                              image: DecorationImage(
                                                image: AssetImage("assets/images/windy.png"),
                                                fit: BoxFit.fill
                                              )
                                            ),
                                          ),
                                          const Text("Wind", style: TextStyle(color: Colors.white)),
                                          const Text("|", style: TextStyle(color: Colors.white)),
                                          Text("${weatherController.result[index.value].values.windSpeed} km/h", style: const TextStyle(color: Colors.white))
                                        ],
                                      ),
                                    ),
            
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width / 2,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            width: 24,
                                            height: 24,
                                            decoration: const BoxDecoration(
                                              image: DecorationImage(
                                                image: AssetImage("assets/images/hum.png"),
                                                fit: BoxFit.fill
                                              )
                                            ),
                                          ),
                                          const Text("Hum", style: TextStyle(color: Colors.white)),
                                          const Text("|", style: TextStyle(color: Colors.white)),
                                          Text("${weatherController.result[index.value].values.humidity}%", style: const TextStyle(color: Colors.white))
                                        ],
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                  
                        Card(
                          elevation: 5,
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: InkWell(
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width / 1.8,
                              height: 64,
                              child: const Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("Weather Details"),
                                    SizedBox(width: 20,),
                                    Icon(Icons.arrow_forward_ios, size: 15,)
                                  ],
                                ),
                              ),
                            ),
                            onTap: () {
                              Get.toNamed("/detail");
                            },
                          ),
                        )
                      ],
                    ),
                  );
                }
              })
            )
          ],
        ),
      ),
    );
  }
}