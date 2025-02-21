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
            "The weather is just right—warm, but not too hot! ☀️ It's a good time to head outdoors, whether for a walk in the park or a casual outing. If you're out in the sun, wear sunscreen and stay hydrated to keep yourself refreshed.",
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
