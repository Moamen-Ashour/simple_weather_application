import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/services/weather_services.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  // api key

  // ignore: non_constant_identifier_names
  final _WeatherService = WeatherServices("ae1a0fd2249223fc717e8f095132cdf2");

  Weather? _weather;

  // fetch weather

  _fetchWeather() async {
    // get the current city

    String cityName = await _WeatherService.getCurrentCity();

    // get the weather for city

    try {
      final weather = await _WeatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    } finally {
      print("Error with application Fix it ya moamen ");
    }
  }

// weather animations

  String getWetherAnimation(String? mainCondition) {
    if (mainCondition == null)
      return 'assets/tooRainy.json'; // defualt to sunny

    switch (mainCondition.toLowerCase()) {
      case 'clouds':
      case "mist":
      case "smoke":
      case "haze":
      case "dust":
      case "fog":
        return "assets/cloudy.json";
      case "rain":
      case "drizzle":
      case "shower rain":
        return "assets/rainy.json";
      case "thunderstorm":
        return "assets/tooRainy.json";
      case "clear":
        return "assets/sunny.json";
      default:
        return "assets/sunny.json";
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // fetch weather on startup
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //city name
              Text(_weather?.cityName ?? " Loading City..."),

              // animation
              Lottie.asset(getWetherAnimation(_weather?.mainCondition)),

              // temperature

              Text("${_weather?.temperature.round()} ْC"),

              // weather condition

              Text(_weather?.mainCondition ?? "")
            ],
          ),
        ],
      ),
    );
  }
}
