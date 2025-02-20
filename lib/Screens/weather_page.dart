import 'package:flutter/material.dart';
import 'package:skysync/models/weather_model.dart';
import 'package:skysync/services/weather_service.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {

  final _weatherService=WeatherService();
  Weather? _weather;

  //fetch weather
  _fetchWeather() async{
    //get the current city
    String cityName=await _weatherService.getCurrentCity();

    //get weather for city
    try{
      final weather=await _weatherService.getWeather(cityName);
      setState(() {
        _weather=weather;
      });
      debugPrint(_weather.toString());
    }catch(e){
      debugPrint(e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}