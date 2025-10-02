import 'package:flutter/material.dart';
import 'package:healnixd/style/text_style.dart';

class CustomTextField extends StatelessWidget {
  final String? labelText;
  final TextEditingController? controller;
  final bool? obscureText;
  final IconData? suffixIcon;
  final VoidCallback? iconTap;
  final String? Function(String?)? validator;

  const CustomTextField({
    this.labelText,
    super.key,
    this.controller,
    this.obscureText = false,
    this.suffixIcon,
    this.iconTap,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
        controller: controller,
        obscureText: obscureText!,
        textAlign: TextAlign.center,
        style: AppTextStyles.kBody15RegularTextStyle.copyWith(
          color: Colors.blue,
        ),
        cursorColor: Colors.blue,
        validator: validator,
        decoration: InputDecoration(
          labelText: labelText,
          fillColor: Colors.blue.withValues(alpha: 0.1),
          filled: true,
          suffixIcon: IconButton(
            onPressed: iconTap,
            icon: Icon(suffixIcon, color: Colors.blue),
          ),
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
