import 'package:flutter/material.dart';
import 'package:skysync/components/status_card.dart';
import 'package:skysync/components/my_snackbar.dart';
import 'package:skysync/components/weather_card.dart.dart';
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
      // Get the current city
      String cityName = await _weatherService.getCurrentCity();
      debugPrint(cityName);

      // Get weather for city
      final weather = await _weatherService.getWeather(cityName);

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
  }

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _fetchWeather,
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          children: [
            // SizedBox(height: MediaQuery.of(context).size.height * 0.4),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const WeatherCard(),
                const StatusCard(),
                Text(
                  _weather?.cityName ?? 'Loading city...',
                ),
                const SizedBox(height: 10),
                Text(
                  _weather?.temperature.toString() ?? 'Loading temperature...',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
