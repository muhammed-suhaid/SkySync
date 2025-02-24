import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:skysync/models/weather_model.dart';
import 'package:skysync/resources/color_manager.dart';

class WeatherCard extends StatelessWidget {
  final Weather? weather;
  final String? location;
  final String? weatherName;

  const WeatherCard({
    super.key,
    required this.weather,
    required this.location,
    required this.weatherName,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 330,
      margin: const EdgeInsets.all(50),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: getContainerColor(weatherName),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'SkySync',
            style: TextStyle(
              color: getTextColor(weatherName),
              fontSize: 22,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                getIcon(weatherName),
                color: getTextColor(weatherName),
                size: 50,
              ),
              const SizedBox(width: 10),
              Text(
                '${weather?.temperature ?? '--'}°',
                style: TextStyle(
                  fontSize: 100,
                  fontWeight: FontWeight.w500,
                  color: getTextColor(weatherName),
                ),
              ),
            ],
          ),
          Text(
            weather?.mainCondition ?? '',
            style: TextStyle(
              color: getTextColor(weatherName),
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            weather?.cityName != location
                ? '${weather?.cityName ?? '--'}, ${location ?? '--'}'
                : weather?.cityName ?? '--',
            style: TextStyle(
              color: getTextColor(weatherName),
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            formatDate(weather?.date),
            style: TextStyle(
              color: getTextColor(weatherName),
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Feels like ${weather?.feelsLike ?? '--'}° | Sunset ${formatTime(weather?.sunset)}',
            style: TextStyle(
              color: getTextColor(weatherName),
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  // Method to convert timestamp to "dd mmm yyyy" format
  String formatDate(String? dateString) {
    if (dateString != null) {
      DateTime dateTime = DateTime.parse(dateString);
      return DateFormat("d MMM yyyy").format(dateTime);
    }
    return '--';
  }

  // Method to convert timestamp to 24-hr format
  String formatTime(String? dateString) {
    if (dateString != null) {
      DateTime dateTime = DateTime.parse(dateString);
      return DateFormat("HH:mm").format(dateTime);
    }
    return '--';
  }

  //Method to change the Container color based on the Weather Name
  Color getContainerColor(String? weatherName) {
    switch (weatherName) {
      case 'sunny':
        return ColorManager.sunny;
      case 'cloudy':
        return ColorManager.cloudy;
      case 'rainy':
        return ColorManager.rainy;
      case 'snowy':
        return ColorManager.snowy;
      default:
        return ColorManager.cloudy;
    }
  }

  //Method to change the Icon based on the Weather Name
  IconData getIcon(String? weatherName) {
    switch (weatherName) {
      case 'sunny':
        return Icons.wb_sunny_rounded;
      case 'cloudy':
        return Icons.wb_cloudy;
      case 'rainy':
        return Icons.thunderstorm;
      case 'snowy':
        return Icons.snowing;
      default:
        return Icons.wb_cloudy;
    }
  }

  //Method to change the text color based on the Weather Name
  Color getTextColor(String? weatherName) {
    switch (weatherName) {
      case 'sunny':
        return ColorManager.sunnytxt;
      case 'cloudy':
        return ColorManager.cloudytxt;
      case 'rainy':
        return ColorManager.rainytxt;
      case 'snowy':
        return ColorManager.snowytxt;
      default:
        return ColorManager.cloudytxt;
    }
  }
}
