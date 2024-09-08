import 'package:flutter_map/flutter_map.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';

class MapsController extends GetxController {
  final latitude = (-8.07323580).obs;
  final longitude = (111.90734310).obs;

  final location = "".obs;

  MapController mapController = MapController();

  Future<void> searchLocation(String location) async {
    try {
      List<Location> locations = await locationFromAddress(location);
      if (locations.isNotEmpty) {
        latitude.value = locations[0].latitude;
        longitude.value = locations[0].longitude;

        updateCenter(LatLng(latitude.value, longitude.value));
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  void getTapLocation(LatLng newLocation) {
    latitude.value = newLocation.latitude;
    longitude.value = newLocation.longitude;

    updateCenter(LatLng(latitude.value, longitude.value));
  }

  void getRegency(double latitude, double longitude) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude);

      if (placemarks.isNotEmpty) {
        Placemark placemark = placemarks.first;
        location.value = placemark.subAdministrativeArea ?? "Unknown";
      } else {
        location.value = "Unknown";
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  void updateCenter(LatLng center) {
    mapController.move(center, 10.0);
  }
}