import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppTextStyles {
  static const lightTextStyle = TextStyle(
      color: Colors.black54,
      fontWeight: FontWeight.w300,
      fontSize: 16,
      fontFamily: 'Roboto');

  static const lightSmallTextStyle = TextStyle(
      color: Colors.black54,
      fontWeight: FontWeight.w300,
      fontSize: 14,
      fontFamily: 'Roboto');

  static const boldTextStyle = TextStyle(
      fontSize: 20.0, fontWeight: FontWeight.w700, fontFamily: 'Roboto', );

  static const boldWhiteTextStyle = TextStyle(
    fontSize: 18.0, fontWeight: FontWeight.w700, fontFamily: 'Roboto', color: Colors.white);

  static const blackTextStyle = TextStyle(
    color: Colors.black,
    fontFamily: 'Roboto',
    fontSize: 25.0,
    fontWeight: FontWeight.w900,
  );

  static const mediumTextStyle = TextStyle(
    fontSize: 15.0,
    fontWeight: FontWeight.w500,
    fontFamily: 'Roboto',
    color: Color(0xFF0165ff),
  );

  static const mediumWhiteTextStyle = TextStyle(
    fontSize: 13.0,
    fontWeight: FontWeight.w500,
    fontFamily: 'Roboto',
    color: Colors.white,
  );

  static const mediumBlackTextStyle = TextStyle(
    fontSize: 18.0,
    fontWeight: FontWeight.w500,
    fontFamily: 'Roboto',
    color: Colors.black,
  );

  static const regularTextStyle =
  TextStyle(color: Colors.black54, fontFamily: 'Roboto',fontWeight: FontWeight.w400,);

  static const boldColoredTextStyle = TextStyle(
    fontSize: 16.0, fontWeight: FontWeight.w700, fontFamily: 'Roboto', color: Color(0xFF0165ff));

  static const boldSmallColoredTextStyle = TextStyle(
      fontSize: 14.0, fontWeight: FontWeight.w700, fontFamily: 'Roboto', color: Color(0xFF0165ff));
}