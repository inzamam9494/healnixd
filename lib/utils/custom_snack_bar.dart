import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

class CustomSnackBar {
  static void success(String message) {
    show(message: message, backgroundColor: Colors.green);
  }

  static void error(String message) {
    show(message: message, backgroundColor: Colors.red);
  }

  static void info(String message) {
    show(message: message, backgroundColor: Colors.blue);
  }

  static void show({
    required String message,
    Color backgroundColor = Colors.blue,
    Color textColor = Colors.white,
    int duration = 2,
    SnackBarBehavior behavior = SnackBarBehavior.floating,
    double borderRadius = 12,
  }) {
    final context = Get.context;
    if (context == null) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(color: textColor, fontWeight: FontWeight.w600),
        ),
        backgroundColor: backgroundColor,
        behavior: behavior,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        duration: Duration(seconds: duration),
      ),
    );
  }
}
