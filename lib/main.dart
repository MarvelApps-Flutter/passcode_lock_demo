import 'dart:async';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'models/location.dart';
import 'models/weather.dart';
import 'screens/loading_screen.dart';
import 'screens/splash_screen.dart';
import 'screens/test_screen.dart';

void main() => runApp(MyApp());


class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  LocationHelper? locationData;

  Future<void> getLocationData() async {
    locationData = LocationHelper();
    await locationData!.getCurrentLocation();

    if (locationData!.latitude == null || locationData!.longitude == null) {
      // todo: Handle no location
    }
  }

  void getWeatherData() async {
    // Fetch the location
    await getLocationData();

    // Fetch the current weather
    WeatherData weatherData = WeatherData(locationData: locationData);
    await weatherData.getCurrentTemperature();

    if (weatherData.currentTemperature == null ||
        weatherData.currentCondition == null) {
      // todo: Handle no weather
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) {
          return ExampleHomePage(
            weatherData: weatherData,
          );
        },
      ),
    );
  }

  init()
  {
     getWeatherData();
  }

  @override
  void initState() {
    //init();
    super.initState();
  }
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Passcode Lock Screen Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:
          //HomeScreen()
          //LoadingScreen(),
          SplashScreen()
    );
  }
}



