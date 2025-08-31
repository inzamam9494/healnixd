import 'package:flutter/cupertino.dart';

Widget authButton({required String text, required VoidCallback onPressed}) {
  return CupertinoButton(
    color: const Color(0xFF4CAF91),
    borderRadius: BorderRadius.circular(8.0),
    onPressed: onPressed,
    child: Text(
      text,
      style: const TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}