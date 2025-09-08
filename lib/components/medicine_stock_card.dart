import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget medicineStockCard({
  String? medicineName,
  String? medicineType,
  String? stock,
  String? expiryDate,
}) {
  return Card(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
    elevation: 2,
    child: Column(
      children: [
        Row(
          children: [
            Text("")
          ],
        )
      ],
    ),
  );
}