import 'dart:ui';

import 'package:flutter/material.dart';

class StatusCard extends StatelessWidget {
  const StatusCard({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          height: 130,
          margin: const EdgeInsets.symmetric(horizontal: 50),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color(0xFFFAE2BD),
            borderRadius: BorderRadius.circular(25),
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.water_drop_rounded,
                    color: Color(0xFFEFAA82),
                    size: 40,
                  ),
                  Text(
                    "86%",
                    style: TextStyle(
                      color: Color(0xFFEFAA82),
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    "Humidity",
                    style: TextStyle(
                      color: Color(0xFFEFAA82),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.air_rounded,
                    color: Color(0xFFEFAA82),
                    size: 40,
                  ),
                  Text(
                    "3 km/h",
                    style: TextStyle(
                      color: Color(0xFFEFAA82),
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    "Wind Speed",
                    style: TextStyle(
                      color: Color(0xFFEFAA82),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.sunny,
                    color: Color(0xFFEFAA82),
                    size: 40,
                  ),
                  Text(
                    "25/28",
                    style: TextStyle(
                      color: Color(0xFFEFAA82),
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    "Hign/Low",
                    style: TextStyle(
                      color: Color(0xFFEFAA82),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
