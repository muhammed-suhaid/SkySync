import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:skysync/models/weather_model.dart';
import 'package:skysync/resources/color_manager.dart';

class StatusCard extends StatelessWidget {
  final Weather? weather;
  final String? weatherName;

  const StatusCard({
    super.key,
    required this.weather,
    required this.weatherName,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            height: 130,
            // margin: const EdgeInsets.symmetric(horizontal: 50),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: getContainerColor(weatherName),
              borderRadius: BorderRadius.circular(25),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.water_drop_rounded,
                      color: Colors.white,
                      size: 40,
                    ),
                    Text(
                      "${weather?.humidity ?? '--'}%",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                    const Text(
                      "Humidity",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.air_rounded,
                      color: Colors.white,
                      size: 40,
                    ),
                    Text(
                      " ${weather?.windSpeed ?? '--'} km/h",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                    const Text(
                      "Wind Speed",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.sunny,
                      color: Colors.white,
                      size: 40,
                    ),
                    Text(
                      "${weather?.tempMax ?? '--'}°/${weather?.tempMin ?? '--'}°",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                    const Text(
                      "High/Low",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //Method to change the Container color based on the Weather Name
  Color getContainerColor(String? weatherName) {
    switch (weatherName) {
      case 'sunny':
        return ColorManager.sunny.withOpacity(0.5);
      case 'cloudy':
        return ColorManager.cloudy.withOpacity(0.5);
      case 'rainy':
        return ColorManager.rainy.withOpacity(0.5);
      case 'snowy':
        return ColorManager.snowy.withOpacity(0.5);
      default:
        return ColorManager.cloudy.withOpacity(0.5);
    }
  }
}
