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
      temperature: _kelvinToCelsius(json['main']['temp']),
      feelsLike: _kelvinToCelsius(json['main']['feels_like']),
      mainCondition: json['weather'][0]['main'],
      date: _formatDate(json['dt']),
      sunset: _formatDate(json['sys']['sunset']),
      humidity: json['main']['humidity'],
      windSpeed: json['wind']['speed'].toDouble(),
      tempMax: _kelvinToCelsius(json['main']['temp_max']),
      tempMin: _kelvinToCelsius(json['main']['temp_min']), 
    );
  }

  // Convert Kelvin to Celsius
  static int _kelvinToCelsius(double kelvin) {
    return (kelvin - 273.15).toInt();
  }

  //function to format Unix timestamp into a readable date
  static String _formatDate(int timestamp) {
    DateTime date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000, isUtc: true);
    return "${date.toLocal()}";
  }
}
