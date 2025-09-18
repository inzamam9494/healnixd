import 'package:flutter/material.dart';
import 'package:healnixd/style/text_style.dart';

class CustomTextField extends StatelessWidget {
  final String? labelText;
  final TextEditingController? controller;
  final bool? obscureText;
  final IconData? suffixIcon;


  const CustomTextField({
    this.labelText,
    super.key,
    this.controller,
    this.obscureText = false,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextField(
        controller: controller,
        obscureText: obscureText!,
        style: AppTextStyles.kBody15RegularTextStyle.copyWith(
          color: Colors.blue,
        ),
        cursorColor: Colors.blue,
        decoration: InputDecoration(
          labelText: labelText,
          fillColor: Colors.blue.withValues(alpha: 0.1),
          filled: true,
          suffix: Icon(suffixIcon, color: Colors.blue,),
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
