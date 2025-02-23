import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
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

  // Fetch weather
  Future<void> _fetchWeather() async {
    try {
      List<Placemark> placemark = await _weatherService.getCurrentPlacemark();
      String? cityName=placemark[1].locality;
      String? stateName=placemark[1].administrativeArea;
      debugPrint("City = $cityName");
      debugPrint("State = $stateName");

      final weather = await _weatherService.getWeather(cityName??'');

      if (weather != null) {
        setState(() {
          _weather = weather;
          debugPrint(_weather.toString());
          MySnackbar.show(context, 'Weather updated successfully!',
              isError: false);
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

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              ImageAssets.sunny,
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
                    const WeatherCard(),
                    const StatusCard(),
                    const WeatherMessage(),
                    Text(
                      _weather?.cityName ?? 'Loading city...',
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      _weather?.temperature.toString() ??
                          'Loading temperature...',
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Version 1.0.1",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
