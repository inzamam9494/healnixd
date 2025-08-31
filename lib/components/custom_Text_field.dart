import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String? labelText;
  const CustomTextField({
    this.labelText,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextField(
        decoration: InputDecoration(
          labelText: labelText,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}
