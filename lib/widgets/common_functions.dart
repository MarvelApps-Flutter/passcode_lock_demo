import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

mixin CommonFunctions
{
  void showRedToast(
    String message,
  ) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white);
  }

  void showGreenToast(
    String message,
  ) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.green,
        textColor: Colors.white);
  }
}