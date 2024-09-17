import 'package:anggi_driweather/ui/components/background.dart';
import 'package:anggi_driweather/controllers/weather_code_controller.dart';
import 'package:anggi_driweather/controllers/weather_controller.dart';
import 'package:anggi_driweather/service/weather_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DetailView extends StatelessWidget {
  DetailView({super.key});

  final imgWeather = "".obs;

  final WeatherCodeController weatherCodeController = Get.put(WeatherCodeController());

  @override
  Widget build(BuildContext context) {
    final WeatherController weatherController = Get.put(WeatherController(weatherService: Get.find<WeatherService>()));

    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leadingWidth: MediaQuery.of(context).size.width,
        leading: IconButton(
          onPressed: () {
            Get.back();
          }, 
          icon: const Row(
            children: [
              Icon(Icons.arrow_back_ios, size: 15, color: Colors.white,),
              Text("Back", style: TextStyle(fontSize: 18, color: Colors.white),)
            ],
          )
        )
      ),
      body: Stack(
        children: [
          const Background(image: "assets/images/bg-home.png"),

          SafeArea(
            child: Obx(() {
              if(weatherController.isLoading.value == true) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Today",
                              style: TextStyle(
                                fontSize: 24,
                                color: Colors.white,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                            Text(DateFormat('MMM, d').format(weatherController.result[0].time), style: const TextStyle(color: Colors.white),)
                          ],
                        ),
                      ),
                  
                      SizedBox(
                        height: 155,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: weatherController.result.length,
                          itemBuilder: (context, index) {
                            if (DateFormat('MMM, d').format(weatherController.result[index].time) == DateFormat('MMM, d').format(weatherController.result[0].time)) {
                              
                              for (int i = 0; i < weatherCodeController.weatherCode.length; i++) {
                                if (weatherController.result[index].values.weatherCode == weatherCodeController.weatherCode[i]["code"]) {
                                  imgWeather.value = weatherCodeController.weatherCode[i]["imageUrl"];
                                }
                              }
                  
                              return Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                child: Column(
                                  children: [
                                    Text("${weatherController.result[index].values.temperature.round()}°C", style: const TextStyle(color: Colors.white),),
                                    
                                    const SizedBox(height: 10,),
                  
                                    Container(
                                      width: 50,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: NetworkImage(imgWeather.value),
                                          fit: BoxFit.cover
                                        )
                                      ),
                                    ),
                  
                                    const SizedBox(height: 10,),
                  
                                    Text(DateFormat('HH.mm').format(weatherController.result[index].time), style: const TextStyle(color: Colors.white),)
                                  ],
                                ),
                              );
                            } else {
                              return Container();
                            }
                          }
                        ),
                      ),
                  
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Next Forecast",
                              style: TextStyle(
                                fontSize: 24,
                                color: Colors.white,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                            Icon(Icons.calendar_month, color: Colors.white,)
                          ],
                        ),
                      ),
                  
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        height: 350,
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: weatherController.result.length,
                          itemBuilder: (context, index) {
                            if (DateFormat('HH').format(weatherController.result[index].time) == DateFormat('HH').format(DateTime.now())) {
                  
                              for (int i = 0; i < weatherCodeController.weatherCode.length; i++) {
                                if (weatherController.result[index].values.weatherCode == weatherCodeController.weatherCode[i]["code"]) {
                                  imgWeather.value = weatherCodeController.weatherCode[i]["imageUrl"];
                                }
                              }
                  
                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(DateFormat('MMM, d').format(weatherController.result[index].time), style: const TextStyle(color: Colors.white),),
                                    Container(
                                      width: 50,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: NetworkImage(imgWeather.value),
                                          fit: BoxFit.cover
                                        )
                                      ),
                                    ),
                                    Text("${weatherController.result[index].values.temperature.round()}°", style: const TextStyle(color: Colors.white),)
                                  ],
                                ),
                              );
                            } else {
                              return Container();
                            }
                          }
                        ),
                      ),
                  
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 20,
                            height: 20,
                            margin: const EdgeInsets.only(right: 10),
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage("assets/images/sun.png"),
                                fit: BoxFit.cover
                              )
                            ),
                          ),
                  
                          const Text("DRI Weather", style: TextStyle(color: Colors.white, fontSize: 18),)
                        ],
                      )
                    ],
                  ),
                );
              }
            })
          )
        ],
      ),
    );
  }
}