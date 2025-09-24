import 'package:flutter/material.dart';
import 'package:healnixd/style/text_style.dart';

class CustomDropDown extends StatelessWidget {
  final List<String> items;
  final Function(String?)? onChanged;
  final String? labelText;
  final String? selectedValue;

  const CustomDropDown({
    super.key,
    required this.items,
    this.onChanged,
    this.labelText,
    this.selectedValue,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4),
      child: DropdownButtonFormField<String>(
        dropdownColor: Colors.white,
        initialValue: selectedValue,
        isDense: true,
        decoration: InputDecoration(
          labelText: labelText ?? 'Enter Text',
          labelStyle: AppTextStyles.kSmall10RegularTextStyle.copyWith(
            color: Colors.blue,
          ),
          fillColor: Colors.blue.withValues(alpha: 0.1),
          filled: true,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(22),
            borderSide: BorderSide(color: Colors.blue),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(22),
            borderSide: BorderSide(color: Colors.blue),
          ),
        ),
        items: items.map((element) {
          return DropdownMenuItem<String>(
            value: element,
            child: Text(
              element,
              style: AppTextStyles.kCaption12SemiBoldTextStyle.copyWith(color: Colors.black),
            ),
          );
        }).toList(),
        onChanged: onChanged,
        style: AppTextStyles.kBody15RegularTextStyle.copyWith(
          color: Colors.black,
        ),
      ),
    );
  }
}
