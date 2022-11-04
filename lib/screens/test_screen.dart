import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../main.dart';
import '../models/location.dart';
import '../models/weather.dart';
import '../widgets/circle.dart';
import '../widgets/keyboard.dart';
import '../widgets/passcode_screen.dart';

const storedPasscode = '123456';

class ExampleHomePage extends StatefulWidget {
  final WeatherData? weatherData;
  const ExampleHomePage({Key? key, this.weatherData}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ExampleHomePageState();
}

class _ExampleHomePageState extends State<ExampleHomePage> {
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
      // backgroundImage = weatherDisplayData.weatherImage;
      // weatherDisplayIcon = weatherDisplayData.weatherIcon;
    });
  }

  init() {
    timeFormatter = DateFormat('H:m');
    dateFormatter = DateFormat('yyyy-MM-dd');
    //formatter = DateFormat('yyyy-MM-dd H:m:s');
    timeFormattedResult = timeFormatter!.format(DateTime.now());
    dateFormattedResult = DateFormat.MMMMEEEEd().format(DateTime.now());
    updateDisplayInfo(widget.weatherData!);
  }

  @override
  void initState() {
    init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff0943C9),
      // appBar: AppBar(
      //   backgroundColor: Color(0xff3D14E1),
      //   title: Text(widget.title),
      // ),
      body: GestureDetector(
        onTap: () {
          print("object");
          // Navigator.of(context).push(_createRoute());
        },
        onVerticalDragUpdate: (details) {
          int sensitivity = 8;
          if (details.delta.dy > sensitivity) {
            // Down Swipe
            print("swipe down");
          } else if (details.delta.dy < -sensitivity) {
            print("swipe up");
            _showLockScreen(
              context,
              opaque: false,
              cancelButton: Text(
                'Cancel',
                style: const TextStyle(fontSize: 16, color: Colors.white),
                semanticsLabel: 'Cancel',
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
                  "assets/images/weather.png",
                  fit: BoxFit.cover,
                )),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: FractionallySizedBox(
                widthFactor: 0.8,
                child: Column(
                  //mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 50,
                    ),
                    Text("${timeFormattedResult.toString()}",
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              fontFamily: "Inter",
                              fontWeight: FontWeight.w300,
                              fontSize: 64,
                              color: Colors.white,
                            )),
                    SizedBox(
                      height: 10,
                    ),
                    Text("${dateFormattedResult.toString()}",
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              fontFamily: "Inter",
                              fontWeight: FontWeight.w300,
                              fontSize: 24,
                              color: Colors.white,
                            )),
                    //Text('You are ${isAuthenticated ? '' : 'NOT'} authenticated',
                    isAuthenticated
                        ? Text('You are authenticated',
                            textAlign: TextAlign.center,
                            style:
                                Theme.of(context).textTheme.bodyText1!.copyWith(
                                      fontFamily: "Inter",
                                      fontWeight: FontWeight.w600,
                                      fontSize: 24,
                                      color: Colors.white,
                                    ))
                        : Container(),
                    SizedBox(
                      height: 4,
                    ),
                    //Text("")
                    // isAuthenticated
                    //     ? Text("")
                    //     : Text("Click below for authentication",
                    //         textAlign: TextAlign.center,
                    //         style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    //               fontFamily: "Inter",
                    //               fontWeight: FontWeight.w600,
                    //               fontSize: 26,
                    //               color: Colors.white,
                    //             )),
                    SizedBox(
                      height: 5,
                    ),
                    GestureDetector(
                        // onTap: () {
                        //   _showLockScreen(
                        //     context,
                        //     opaque: false,
                        //     cancelButton: Text(
                        //       'Cancel',
                        //       style: const TextStyle(
                        //           fontSize: 16, color: Colors.white),
                        //       semanticsLabel: 'Cancel',
                        //     ),
                        //   );
                        // },
                        child: Image.asset(
                      "assets/images/lock.png",
                      height: 150,
                      width: 150,
                    )),

                    // _defaultLockScreenButton(context),
                    // _customColorsLockScreenButton(context)
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
                    Center(
                      child: Text(
                        ' $temperature°',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 80.0,
                          letterSpacing: -5,
                        ),
                      ),
                    ),
                    Image.asset(
                      "assets/images/swipe.gif",
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

//   Route _createRoute() {
//   return PageRouteBuilder(
//     pageBuilder: (context, animation, secondaryAnimation) {
//       return
//     },
//     transitionsBuilder: (context, animation, secondaryAnimation, child) {
//       const begin = Offset(0.0, 1.0);
//       const end = Offset.zero;
//       const curve = Curves.ease;

//       var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

//       return SlideTransition(
//         position: animation.drive(tween),
//         child: child,
//       );
//     },
//   );
// }

  _defaultLockScreenButton(BuildContext context) => MaterialButton(
        color: Theme.of(context).primaryColor,
        child: Text('Open Default Lock Screen'),
        onPressed: () {
          _showLockScreen(
            context,
            opaque: false,
            cancelButton: Text(
              'Cancel',
              style: const TextStyle(fontSize: 16, color: Colors.white),
              semanticsLabel: 'Cancel',
            ),
          );
        },
      );

  _customColorsLockScreenButton(BuildContext context) {
    return MaterialButton(
      color: Theme.of(context).primaryColor,
      child: Text('Open Custom Lock Screen'),
      onPressed: () {
        _showLockScreen(context,
            opaque: false,
            circleUIConfig: CircleUIConfig(
                borderColor: Colors.blue,
                fillColor: Colors.blue,
                circleSize: 30),
            keyboardUIConfig: KeyboardUIConfig(
                digitBorderWidth: 2, primaryColor: Colors.blue),
            cancelButton: Icon(
              Icons.arrow_back,
              color: Colors.blue,
            ),
            digits: ['一', '二', '三', '四', '五', '六', '七', '八', '九', '零']);
      },
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
            title: Text('ENTER YOUR \nPASSCODE',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontFamily: "Inter",
                      fontWeight: FontWeight.w300,
                      fontSize: 22,
                      color: Colors.white,
                    )),
            circleUIConfig: circleUIConfig,
            keyboardUIConfig: keyboardUIConfig,
            passwordEnteredCallback: _onPasscodeEntered,
            cancelButton: cancelButton,
            deleteButton: Text(
              'Delete',
              style: const TextStyle(fontSize: 16, color: Colors.white),
              semanticsLabel: 'Delete',
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
        this.isAuthenticated = isValid;
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
            child: Text(
              "Reset passcode",
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.w300),
            ),
            onPressed: _resetAppPassword,
            // splashColor: Colors.white.withOpacity(0.4),
            // highlightColor: Colors.white.withOpacity(0.2),
            // ),
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
        //TODO: Clear your stored passcode here
      });
    });
  }

  _showRestoreDialog(VoidCallback onAccepted) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Reset passcode",
            style: const TextStyle(color: Colors.black87),
          ),
          content: Text(
            "Passcode reset is a non-secure operation!\n\nConsider removing all user data if this action performed.",
            style: const TextStyle(color: Colors.black87),
          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            TextButton(
              child: Text(
                "Cancel",
                style: const TextStyle(fontSize: 18),
              ),
              onPressed: () {
                Navigator.maybePop(context);
              },
            ),
            TextButton(
              child: Text(
                "I understand",
                style: const TextStyle(fontSize: 18),
              ),
              onPressed: onAccepted,
            ),
          ],
        );
      },
    );
  }
}
