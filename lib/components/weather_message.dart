import 'package:flutter/material.dart';

class WeatherMessage extends StatelessWidget {
  const WeatherMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(left: 50, top: 50, right: 50),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Weather Advisory",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 15),
          Text(
            "The weather in Angamaly is currently misty with a temperature of 27.9°C, though it feels like 31°C. The air is quite humid at 74%, and visibility is slightly reduced to 4km. A gentle breeze is blowing at 1.03 m/s. It's a warm and slightly foggy day—stay hydrated and drive safely if you're heading out!",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }
}
