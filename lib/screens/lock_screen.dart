import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:passcode_lock_demo/constants/app_constants.dart';
import '../models/location.dart';
import '../models/weather.dart';
import '../widgets/circle.dart';
import '../widgets/keyboard.dart';
import '../widgets/passcode_screen.dart';

const storedPasscode = AppConstants.validationString;

class LockScreen extends StatefulWidget {
  final WeatherData? weatherData;
  const LockScreen({Key? key, this.weatherData}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LockScreenState();
}

class _LockScreenState extends State<LockScreen> {
  final StreamController<bool> _verificationNotifier =
      StreamController<bool>.broadcast();

  bool isAuthenticated = false;
  DateTime? date;
  DateFormat? timeFormatter;
  DateFormat? dateFormatter;
  String? timeFormattedResult;
  String? dateFormattedResult;
  int? temperature;
  LocationHelper? locationData;

  void updateDisplayInfo(WeatherData weatherData) {
    setState(() {
      temperature = weatherData.currentTemperature!.round();
      WeatherDisplayData weatherDisplayData =
          weatherData.getWeatherDisplayData();
      
    });
  }

  init() {
    timeFormatter = DateFormat('H:m');
    dateFormatter = DateFormat('yyyy-MM-dd');
    timeFormattedResult = timeFormatter!.format(DateTime.now());
    dateFormattedResult = DateFormat.MMMMEEEEd().format(DateTime.now());
    if(widget.weatherData != null)
    {
        updateDisplayInfo(widget.weatherData!);
    }
    print("temperature is $temperature");
  }

  @override
  void initState() {
    init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff0943C9),
      body: GestureDetector(
        onTap: () {
        },
        onVerticalDragUpdate: (details) {
          int sensitivity = 8;
          if (details.delta.dy > sensitivity) {
            // Down Swipe
           
          } else if (details.delta.dy < -sensitivity) {
           
            _showLockScreen(
              context,
              opaque: false,
              cancelButton: const Text(
                AppConstants.cancel,
                style: TextStyle(fontSize: 16, color: Colors.white),
                semanticsLabel: AppConstants.cancel,
              ),
            );
            // Up Swipe
          }
        },
        child: Stack(
          children: [
            Positioned(
                top: 0,
                bottom: 0,
                left: 0,
                right: 0,
                child: Image.asset(
                 AppConstants.weather,
                  fit: BoxFit.cover,
                )),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: FractionallySizedBox(
                widthFactor: 0.8,
                child: Column(
                 
                  children: <Widget>[
                    const SizedBox(
                      height: 50,
                    ),
                    Text(timeFormattedResult.toString(),
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              fontFamily: AppConstants.inter,
                              fontWeight: FontWeight.w300,
                              fontSize: 64,
                              color: Colors.white,
                            )),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(dateFormattedResult.toString(),
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              fontFamily: AppConstants.inter,
                              fontWeight: FontWeight.w300,
                              fontSize: 24,
                              color: Colors.white,
                            )),
                    isAuthenticated
                        ? Text(AppConstants.authenticated,
                            textAlign: TextAlign.center,
                            style:
                                Theme.of(context).textTheme.bodyText1!.copyWith(
                                      fontFamily: AppConstants.inter,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 24,
                                      color: Colors.white,
                                    ))
                        : Container(),
                    const SizedBox(
                      height: 4,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    GestureDetector(
                        child: Image.asset(
                     AppConstants.lock,
                      height: 150,
                      width: 150,
                    )),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    temperature != null ? Center(
                      child: Text(
                        ' $temperature°',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 80.0,
                          letterSpacing: -5,
                        ),
                      ),
                    ) : Container(),
                    Image.asset(
                     AppConstants.swipe,
                      height: 80,
                      width: 60,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _showLockScreen(
    BuildContext context, {
    required bool opaque,
    CircleUIConfig? circleUIConfig,
    KeyboardUIConfig? keyboardUIConfig,
    required Widget cancelButton,
    List<String>? digits,
  }) {
    Navigator.push(
        context,
        PageRouteBuilder(
          opaque: opaque,
          pageBuilder: (context, animation, secondaryAnimation) =>
              PasscodeScreen(
            title: Text(AppConstants.enterYourPass,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontFamily: AppConstants.inter,
                      fontWeight: FontWeight.w300,
                      fontSize: 22,
                      color: Colors.white,
                    )),
            circleUIConfig: circleUIConfig,
            keyboardUIConfig: keyboardUIConfig,
            passwordEnteredCallback: _onPasscodeEntered,
            cancelButton: cancelButton,
            deleteButton: const Text(
              AppConstants.delete,
              style: TextStyle(fontSize: 16, color: Colors.white),
              semanticsLabel: AppConstants.delete,
            ),
            shouldTriggerVerification: _verificationNotifier.stream,
            backgroundColor: Colors.black.withOpacity(0.8),
            cancelCallback: _onPasscodeCancelled,
            digits: digits,
            passwordDigits: 6,
            bottomWidget: _buildPasscodeRestoreButton(),
          ),
        ));
  }

  _onPasscodeEntered(String enteredPasscode) {
    bool isValid = storedPasscode == enteredPasscode;
    _verificationNotifier.add(isValid);
    if (isValid) {
      setState(() {
        isAuthenticated = isValid;
        //Navigator.push(context, MaterialPageRoute(builder: (context)=> HomeScreen()));
      });
    }
  }

  _onPasscodeCancelled() {
    Navigator.maybePop(context);
  }

  @override
  void dispose() {
    _verificationNotifier.close();
    super.dispose();
  }

  _buildPasscodeRestoreButton() => Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          margin: const EdgeInsets.only(bottom: 10.0, top: 20.0),
          child: TextButton(
            onPressed: _resetAppPassword,
            child: const Text(
             AppConstants.resetPass,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.w300),
            ),
          ),
        ),
      );

  _resetAppPassword() {
    Navigator.maybePop(context).then((result) {
      if (!result) {
        return;
      }
      _showRestoreDialog(() {
        Navigator.maybePop(context);

      });
    });
  }

  _showRestoreDialog(VoidCallback onAccepted) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
           AppConstants.resetPass,
            style: TextStyle(color: Colors.black87),
          ),
          content: const Text(
           AppConstants.passReset,
            style: TextStyle(color: Colors.black87),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
               AppConstants.cancel,
                style: TextStyle(fontSize: 18),
              ),
              onPressed: () {
                Navigator.maybePop(context);
              },
            ),
            TextButton(
              onPressed: onAccepted,
              child: const Text(
                AppConstants.iUnderStand,
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        );
      },
    );
  }
}
