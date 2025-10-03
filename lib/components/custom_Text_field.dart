import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:healnixd/style/text_style.dart';

class CustomTextField extends StatelessWidget {
  final String? labelText;
  final TextEditingController? controller;
  final bool? obscureText;
  final IconData? suffixIcon;
  final VoidCallback? iconTap;
  final String? Function(String?)? validator;
  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  final int? maxLength;
  final Function(String)? onChanged;

  const CustomTextField({
    this.labelText,
    super.key,
    this.controller,
    this.obscureText = false,
    this.suffixIcon,
    this.iconTap,
    this.validator,
    this.focusNode,
    this.keyboardType,
    this.maxLength,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
        controller: controller,
        obscureText: obscureText!,
        focusNode: focusNode,
        keyboardType: keyboardType,
        maxLength: maxLength,
        onChanged: onChanged,
        inputFormatters: maxLength == 1
            ? [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(1),
              ]
            : null,
        style: AppTextStyles.kBody15RegularTextStyle.copyWith(
          color: Colors.blue,
        ),
        cursorColor: Colors.blue,
        validator: validator,
        decoration: InputDecoration(
          labelText: labelText,
          fillColor: Colors.blue.withValues(alpha: 0.1),
          filled: true,
          counterText: '',
          suffixIcon: suffixIcon != null
              ? IconButton(
            onPressed: iconTap,
            icon: Icon(suffixIcon, color: Colors.blue),
          )
              : null,
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
