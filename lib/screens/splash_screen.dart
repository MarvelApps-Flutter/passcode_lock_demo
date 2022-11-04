import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../constants/app_constants.dart';
import '../models/location.dart';
import '../models/weather.dart';
import 'home_screen.dart';
import 'test_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<Offset> offset;
  late final Animation<double> _animation;
  late AnimationController delayedcontroller;
  late final Animation<double> _delayedAnimation;

  init()
  {
    
      controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..forward();

    _animation = CurvedAnimation(
      parent: controller,
      curve: Curves.fastOutSlowIn,
    );

    _delayedAnimation = CurvedAnimation(
      parent: controller,
      curve: const Interval(0.8, 1, curve: Curves.fastOutSlowIn),
    );

    offset = Tween<Offset>(
            begin: const Offset(0.0, -5), end: const Offset(0.0, 0.0))
        .animate(CurvedAnimation(parent: controller, curve: Curves.bounceOut));
        getWeatherData();
  }

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

    // Navigator.pushReplacement(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) {
    //       return ExampleHomePage(
    //         weatherData: weatherData,
    //       );
    //     },
    //   ),
    // );

    Future.delayed(
        const Duration(seconds: 3), () => Navigator.push(context, MaterialPageRoute(builder: (context)=> ExampleHomePage(
            weatherData: weatherData,
          )
    )));
  }

  @override
  void initState() {
    super.initState();
      init();
    //    Future.delayed(
    //     const Duration(seconds: 3), () => Navigator.push(context, MaterialPageRoute(builder: (context)=> const HomeScreen()
    // )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        _marvelAnimatedLogo(context),
        _animatedText(context),
        Center(
          child: SpinKitRipple(
            color: Colors.deepOrange[600],
            size: 150.0,
            duration: Duration(milliseconds: 1200),
          ),
        ),
        _footer()
      ],
    ));
  }

  Column _footer() {
    return Column(mainAxisAlignment: MainAxisAlignment.end, children: [
      SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                AppConstants.poweredBy,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.black),
              ),
              Image.asset(
                AppConstants.successiveLogo,
                width: 35,
                height: 35,
                fit: BoxFit.scaleDown,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:  [
                  Text(
                    AppConstants.successive,
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 3),
                  ),
                  Text(
                    AppConstants.technologies,
                    style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 1.2),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    ]);
  }

  Center _animatedText(BuildContext context) {
    return Center(
      child: FadeTransition(
        opacity: _delayedAnimation,
        child: Padding(
          padding: const EdgeInsets.only(top: 70, left: 20),
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.85,
            child: ShaderMask(
              shaderCallback: (Rect bounds) {
                return const RadialGradient(
                  center: Alignment.topLeft,
                  radius: 1.0,
                  colors: <Color>[
                    Colors.brown,
                    Colors.black,
                    Colors.brown,
                    Colors.black,
                  ],
                  tileMode: TileMode.mirror,
                ).createShader(bounds);
              },
              child: const Padding(
                padding: EdgeInsets.only(right: 15),
                child: Text(
                  AppConstants.apps,
                  textAlign: TextAlign.right,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Center _marvelAnimatedLogo(BuildContext context) {
    return Center(
      child: FadeTransition(
        opacity: controller,
        child: ScaleTransition(
          scale: _animation,
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.85,
            child: Image.asset(AppConstants.marvelLogo),
          ),
        ),
      ),
    );
  }
}
