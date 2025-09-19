import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget authButton({
  required String text,
  required VoidCallback? onPressed,
  bool isLoading = false,
}) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.blue,
      borderRadius: BorderRadius.circular(16.0),
    ),
    width: double.infinity,
    child: CupertinoButton(
      onPressed: isLoading ? null : onPressed,
      child: isLoading
          ? CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            )
          : Text(
              text,
              style: const TextStyle(
                color: Color(0xFFECECEC),
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
              ),
            ),
    ),
  );
}
