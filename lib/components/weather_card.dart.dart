import 'package:flutter/material.dart';

class WeatherCard extends StatelessWidget {
  const WeatherCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 330,
      margin: const EdgeInsets.all(50),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFFAE2BD), // Peach color
        borderRadius: BorderRadius.circular(25),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'SkySync',
            style: TextStyle(
              color: Color(0xFFEFAA82),
              fontSize: 22,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.wb_sunny,
                color: Color(0xFFEFAA82),
                size: 50,
              ),
              SizedBox(width: 10),
              Text(
                '32°',
                style: TextStyle(
                  fontSize: 100,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFFEFAA82),
                ),
              ),
            ],
          ),
          Text(
            'Sunny',
            style: TextStyle(
              color: Color(0xFFEFAA82),
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 20),
          Text(
            'Angamaly, Ernakulam',
            style: TextStyle(
              color: Color(0xFFEFAA82),
              fontSize: 14,
            ),
          ),
          SizedBox(height: 10),
          Text(
            '21 Feb 2025',
            style: TextStyle(
              color: Color(0xFFEFAA82),
              fontSize: 14,
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Feels like 30 | Sunset 18:20',
            style: TextStyle(
              color: Color(0xFFEFAA82),
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
