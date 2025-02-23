class Weather {
  final String cityName;
  final int temperature;
  final int feelsLike;
  final String mainCondition;
  final String date;
  final String sunset;
  final int humidity;
  final double windSpeed;
  final int tempMax;
  final int tempMin;

  Weather({
    required this.cityName,
    required this.temperature,
    required this.feelsLike,
    required this.mainCondition,
    required this.date,
    required this.sunset,
    required this.humidity,
    required this.windSpeed,
    required this.tempMax,
    required this.tempMin,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      cityName: json['name'],
      temperature: json['main']['temp'].toDouble().toInt(),
      feelsLike: json['main']['feels_like'].toDouble().toInt(),
      mainCondition: json['weather'][0]['main'],
      date: _formatDate(json['dt']),
      sunset: _formatDate(json['sys']['sunset']),
      humidity: json['main']['humidity'],
      windSpeed: json['wind']['speed'].toDouble(),
      tempMax: json['main']['temp_max'].toDouble().toInt(),
      tempMin: json['main']['temp_min'].toDouble().toInt(),
    );
  }

  //function to format Unix timestamp into a readable date
  static String _formatDate(int timestamp) {
    DateTime date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000, isUtc: true);
    return "${date.toLocal()}";
  }
}
