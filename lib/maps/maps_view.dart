import 'package:anggi_driweather/controllers/maps_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';

class MapsView extends StatelessWidget {
  MapsView({super.key});

  final marker = <Marker>[].obs;

  final MapsController getMapsController = Get.put(MapsController());

  final searchController =  TextEditingController().obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Obx(() =>
        SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: TextFormField(
                  controller: searchController.value,
                  decoration: InputDecoration(
                    prefixIcon: IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: const Icon(Icons.arrow_back)
                    ),
                    hintText: 'Search here',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    suffixIcon: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      child: ElevatedButton(
                        onPressed: () {
                          if (searchController.value.text.isNotEmpty) {
                            getMapsController.searchLocation(searchController.value.text);
                          }
                        }, 
                        child: const Text("Search")
                      ),
                    ),
                  ),
                ),
              ),
          
              Expanded(
                child: FlutterMap(
                  mapController: getMapsController.mapController,
                  options: MapOptions(
                    initialCenter: LatLng(getMapsController.latitude.value, getMapsController.longitude.value),
                    initialZoom: 10.0,
                    onTap: (tapPosition, point) => getMapsController.getTapLocation(point),
                  ),
                  children: [
                    TileLayer(
                      urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      userAgentPackageName: 'com.example.app',
                    ),
          
                    MarkerLayer(
                      markers: [
                        Marker(
                          point: LatLng(getMapsController.latitude.value, getMapsController.longitude.value), 
                          width: 30,
                          height: 30,
                          child: const Icon(Icons.location_on, color: Colors.red,)
                        )
                      ]
                    ),

                    Positioned(
                      bottom: 20,
                      right: 20,
                      child: FloatingActionButton(
                        onPressed: () {
                          getMapsController.updateCenter(LatLng(getMapsController.latitude.value, getMapsController.longitude.value));
                        },
                        backgroundColor: Colors.white,
                        shape: const CircleBorder(),
                        child: const Icon(Icons.location_searching, color: Colors.red,),
                      ),
                    )
                  ]
                )
              )
            ],
          ),
        ),
      ),
    );
  }
}