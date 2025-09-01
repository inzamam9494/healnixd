import 'package:flutter/material.dart';
import 'package:healnixd/style/text_style.dart';

class CustomTextField extends StatelessWidget {
  final String? labelText;

  const CustomTextField({this.labelText, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextField(
        style: AppTextStyles.kCaption12RegularTextStyle.copyWith(color: Colors.blue),
        cursorColor: Colors.blue,
        decoration: InputDecoration(
          labelText: labelText,
          fillColor: Colors.blue.withValues(alpha: 0.1),
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
