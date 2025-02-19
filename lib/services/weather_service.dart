import 'dart:convert';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:skysync/models/weather_model.dart';
import 'package:http/http.dart' as http;
import 'package:skysync/resources/url_paths.dart';

class WeatherService {
  // WeatherService(this.apiKey);
  Future<Weather> getWeather(String cityName) async {
    String url =
        '${AppUrl.baseUrl}?q=$cityName&appid=${AppUrl.apiKey}&units=metric';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return Weather.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load weather data');
    }
  }

  Future<String> getCurrentCity() async {
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

    //extract the city name from the first placemark
    String? city = placemark[0].locality;

    return city ?? '';
  }
}
