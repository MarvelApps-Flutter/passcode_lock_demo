import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import '../constants/constants.dart';
import 'location.dart';

class WeatherDisplayData {
  Icon? weatherIcon;
  AssetImage? weatherImage;

  WeatherDisplayData({ this.weatherIcon,  this.weatherImage});
}

class WeatherData {
  
  LocationHelper? locationData;
  double? currentTemperature;
  int? currentCondition;

  WeatherData({ this.locationData});


  Future<void> getCurrentTemperature() async {
    var url = Uri.parse('http://api.openweathermap.org/data/2.5/weather?lat=${locationData!.latitude}&lon=${locationData!.longitude}&appid=bf3a2060f20086610dd0184c16965bda&units=metric');
    var response = await http.get(
        url);

    if (response.statusCode == 200) {
      String data = response.body;
      var currentWeather = jsonDecode(data);

      try {
        currentTemperature = currentWeather['main']['temp'];
        currentCondition = currentWeather['weather'][0]['id'];
      } catch (e) {
        print(e);
      }
    } else {
      print('Could not fetch temperature!');
    }
  }

  WeatherDisplayData getWeatherDisplayData() {
    if (currentCondition! < 600) {
      return WeatherDisplayData(
        weatherIcon: kCloudIcon,
        weatherImage: AssetImage('assets/cloud.png'),
      );
    } else {
      var now = new DateTime.now();

      if (now.hour >= 15) {
        return WeatherDisplayData(
          weatherImage: AssetImage('assets/night.png'),
          weatherIcon: kMoonIcon,
        );
      } else {
        return WeatherDisplayData(
          weatherIcon: kSunIcon,
          weatherImage: AssetImage('assets/sunny.png'),
        );
      }
    }
  }
}