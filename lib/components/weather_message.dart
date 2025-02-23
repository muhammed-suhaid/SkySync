import 'package:flutter/material.dart';
import 'package:skysync/models/weather_model.dart';

class WeatherMessage extends StatelessWidget {
  final Weather? weather;

  const WeatherMessage({
    super.key,
    required this.weather,
  });

  @override
  Widget build(BuildContext context) {
    final bool nightTime = isNight(weather?.date);
    return Padding(
      padding: const EdgeInsets.only(left: 50, top: 50, right: 50),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Weather Advisory",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 15),
          Text(
            "The weather in ${weather?.cityName} is currently ${weather?.mainCondition} with a temperature of ${weather?.temperature}°C, though it feels like ${weather?.feelsLike}°C. The air is quite humid at ${weather?.humidity}%. A gentle breeze is blowing at ${weather?.windSpeed} km/h.${getWeatherMessage(weather?.mainCondition, nightTime)}",
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  // Method to convert timestamp to 24-hr format
  bool isNight(String? dateString) {
    if (dateString != null) {
      DateTime dateTime = DateTime.parse(dateString);
      int hour = dateTime.hour;

      return hour >= 18 || hour < 6;
    }
    return false;
  }

  // Method to get dynamic message according to time and main condition
  String getWeatherMessage(String? condition, bool isNight) {
    if (condition != null) {
      switch (condition.toLowerCase()) {
        case "clear":
          return isNight
              ? "The sky is clear and calm tonight. A perfect time to stargaze!"
              : "It's a bright and sunny day! Enjoy the warmth but don’t forget sunscreen.";
        case "clouds":
          return isNight
              ? "The night sky is cloudy, giving a cooler atmosphere."
              : "The sky is covered with clouds, keeping the heat in check.";
        case "mist":
        case "fog":
          return isNight
              ? "A misty night with reduced visibility. Drive safely if you're heading out."
              : "A foggy morning, making visibility low. Be cautious on the roads.";
        case "smoke":
        case "haze":
        case "dust":
          return isNight
              ? "The air quality is low tonight due to haze or dust. Consider staying indoors."
              : "The air is hazy, reducing visibility. Wear a mask if you're sensitive to dust.";
        case "rain":
        case "drizzle":
        case "shower rain":
          return isNight
              ? "It's raining tonight. A cozy night to stay in with a warm drink!"
              : "Rain showers ahead! Carry an umbrella if you're stepping out.";
        case "thunderstorm":
          return isNight
              ? "A stormy night ahead. Stay indoors and stay safe!"
              : "Thunderstorms expected today. Be prepared for heavy rain and winds.";
        default:
          return "The weather is quite unpredictable today. Stay prepared for anything!";
      }
    }
    return "The weather is quite unpredictable today. Stay prepared for anything!";
  }
}
