import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:lottie/lottie.dart';
import 'package:skysync/components/status_card.dart';
import 'package:skysync/components/my_snackbar.dart';
import 'package:skysync/components/weather_card.dart.dart';
import 'package:skysync/components/weather_message.dart';
import 'package:skysync/models/weather_model.dart';
import 'package:skysync/resources/asset_manager.dart';
import 'package:skysync/services/weather_service.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final _weatherService = WeatherService();
  Weather? _weather;
  String? _location;
  String? _weatherName;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 500),
        transitionBuilder: (Widget child, Animation<double> animation) {
          return FadeTransition(opacity: animation, child: child);
        },
        child: _isLoading
            ? Container(
                key: const ValueKey(1),
                color: Colors.black.withOpacity(0.8),
                child: Center(
                  child: Lottie.asset(
                    AnimationAssets.loading,
                    width: 400,
                    height: 400,
                  ),
                ),
              )
            : Stack(
                key: const ValueKey(2),
                children: [
                  Positioned.fill(
                    child: Image.asset(
                      getBackgroundImage(_weatherName),
                      fit: BoxFit.cover,
                      alignment: Alignment.center,
                    ),
                  ),
                  RefreshIndicator(
                    onRefresh: _fetchWeather,
                    child: ListView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      children: [
                        Column(
                          children: [
                            WeatherCard(
                              weather: _weather,
                              location: _location,
                              weatherName: _weatherName,
                            ),
                            StatusCard(
                              weather: _weather,
                              weatherName: _weatherName,
                            ),
                            WeatherMessage(weather: _weather),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  String getBackgroundImage(String? weatherName) {
    switch (weatherName) {
      case 'sunny':
        return ImageAssets.sunny;
      case 'cloudy':
        return ImageAssets.cloudy;
      case 'rainy':
        return ImageAssets.rainy;
      case 'snowy':
        return ImageAssets.snowy;
      default:
        return ImageAssets.cloudy;
    }
  }

// method for getting the Weather Name based on the main condition
  String getWeatherName(String? mainCondition) {
    String weatherName = 'cloudy';
    if (mainCondition != null) {
      switch (mainCondition.toLowerCase()) {
        case 'clear':
          return 'sunny';
        case 'clouds':
        case 'mist':
        case 'fog':
        case 'smoke':
        case 'haze':
        case 'dust':
        case 'sand':
        case 'ash':
          return 'cloudy';
        case 'drizzle':
        case 'rain':
        case 'shower rain':
        case 'thunderstorm':
          return 'rainy';
        case 'snow':
        case 'sleet':
        case 'blizzard':
          return 'snowy';
        default:
          return 'cloudy';
      }
    }
    return weatherName;
  }

  // Fetch weather
  Future<void> _fetchWeather() async {
    setState(() {
      _isLoading = true;
    });
    try {
      // List<Placemark> placemark = await _weatherService.getCurrentPlacemark();
      // String? cityName = placemark[1].locality;
      // String? stateName = placemark[1].administrativeArea;
      // debugPrint("City = $cityName");
      // debugPrint("State = $stateName");

      Position position = await _weatherService.getCurrentPlacemark();
      String? latitude = position.latitude.toString();
      String? longitude = position.longitude.toString();
      debugPrint("Latitude = $latitude");
      debugPrint("longitude = $longitude");

      List<Placemark> placemark =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      String? location = placemark[2].locality;
      debugPrint("City = $location");

      final weather = await _weatherService.getWeather(latitude, longitude);
      final weatherName = getWeatherName(weather?.mainCondition);
      debugPrint("weatherName = $weatherName");

      if (weather != null) {
        setState(() {
          _weather = weather;
          _location = location;
          _weatherName = weatherName;
          _isLoading = false;
          debugPrint(_weather.toString());
          // MySnackbar.show(context, 'Weather updated successfully!',
          // isError: false);
        });
      } else {
        setState(() {
          _weather = null;
          debugPrint('City not found. Please try again.');
          MySnackbar.show(context, 'City not found. Please try again.');
        });
      }
    } catch (e) {
      setState(() {
        _weather = null;
        debugPrint('Something went wrong. Please try again.');
        MySnackbar.show(context, 'Something went wrong. Please try again.');
        _fetchWeather();
      });
    }
    debugPrint("city name = ${_weather?.cityName}");
    debugPrint("temperature = ${_weather?.temperature}");
    debugPrint("High/Low = ${_weather?.tempMax}/${_weather?.tempMin}");
    debugPrint("feels like = ${_weather?.feelsLike}");
    debugPrint("main condition = ${_weather?.mainCondition}");
    debugPrint("date = ${_weather?.date}");
    debugPrint("sunset = ${_weather?.sunset}");
    debugPrint("humidity = ${_weather?.humidity}");
    debugPrint("wind speed = ${_weather?.windSpeed}");
  }
}
