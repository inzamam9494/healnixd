import 'package:flutter/cupertino.dart';

Widget authButton({required String text, required VoidCallback onPressed}) {
  return Container(
    width: double.infinity,
    child: CupertinoButton(
      color: const Color(0xFF4188E3),
      borderRadius: BorderRadius.circular(16.0),
      onPressed: onPressed,
      child: Text(
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
