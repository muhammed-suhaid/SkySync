import 'package:flutter/material.dart';
import 'package:skysync/components/status_card.dart';
import 'package:skysync/components/my_snackbar.dart';
import 'package:skysync/components/weather_card.dart.dart';
import 'package:skysync/components/weather_message.dart';
import 'package:skysync/models/weather_model.dart';
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
      String cityName = await _weatherService.getCurrentCity();
      debugPrint(cityName);

      final weather = await _weatherService.getWeather(cityName);

      if (weather != null) {
        setState(() {
          _weather = weather;
          debugPrint(_weather.toString());
          MySnackbar.show(context, 'Weather updated successfully!', isError: false);
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
              'assets/images/Sunny.png',
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
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const WeatherCard(),
                    const StatusCard(),
                    const WeatherMessage(),
                    Text(
                      _weather?.cityName ?? 'Loading city...',
                      style: const TextStyle(color: Colors.white),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      _weather?.temperature.toString() ?? 'Loading temperature...',
                      style: const TextStyle(color: Colors.white),
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
