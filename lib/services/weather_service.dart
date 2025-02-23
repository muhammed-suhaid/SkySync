import 'dart:convert';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:skysync/models/weather_model.dart';
import 'package:http/http.dart' as http;
import 'package:skysync/resources/url_paths.dart';

class WeatherService {
  Future<Weather?> getWeather(String cityName) async {
    String url =
        '${AppUrl.baseUrl}?q=$cityName&appid=${AppUrl.apiKey}&units=metric';
    final response = await http.get(Uri.parse(url));
    final data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return Weather.fromJson(data);
    } else {
      return null;
    }
  } 

  Future<dynamic> getCurrentPlacemark() async {
    //get the location permission from user
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    //fetch the current location
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    //convert the location into a list of placemark objects
    List<Placemark> placemark =
        await placemarkFromCoordinates(position.latitude, position.longitude);

    return placemark;
  }
}
