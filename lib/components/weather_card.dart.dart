import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:skysync/models/weather_model.dart';
import 'package:skysync/resources/color_manager.dart';

class WeatherCard extends StatelessWidget {
  final Weather? weather;
  final String? stateName;

  const WeatherCard({
    super.key,
    required this.weather,
    required this.stateName,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 330,
      margin: const EdgeInsets.all(50),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: ColorManager.sunny,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'SkySync',
            style: TextStyle(
              color: ColorManager.sunnytxt,
              fontSize: 22,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.wb_sunny,
                color: ColorManager.sunnytxt,
                size: 50,
              ),
              const SizedBox(width: 10),
              Text(
                '${weather?.temperature ?? '--'}°',
                style: const TextStyle(
                  fontSize: 100,
                  fontWeight: FontWeight.w500,
                  color: ColorManager.sunnytxt,
                ),
              ),
            ],
          ),
          Text(
            weather?.mainCondition ?? '',
            style: const TextStyle(
              color: ColorManager.sunnytxt,
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            '${weather?.cityName ?? '--'}, ${stateName ?? '--'}',
            style: const TextStyle(
              color: ColorManager.sunnytxt,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            formatDate(weather?.date),
            style: const TextStyle(
              color: ColorManager.sunnytxt,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Feels like ${weather?.feelsLike ?? '--'}° | Sunset ${formatTime(weather?.sunset)}',
            style: const TextStyle(
              color: ColorManager.sunnytxt,
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
}
