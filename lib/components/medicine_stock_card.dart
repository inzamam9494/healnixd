import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healnixd/style/text_style.dart';

Widget medicineStockCard({
  String? medicineName,
  String? medicineScale,
  String? medicineType,
  String? stock,
  String? expiryDate,
}) {
  return Card(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    elevation: 2,
    child: Padding(
      padding: EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    medicineName ?? 'Arnica Montana',
                    style: AppTextStyles.kBody15SemiBoldTextStyle,
                  ),
                  Text(
                    medicineScale ?? '  (30C)',
                    style: AppTextStyles.kBody15SemiBoldTextStyle.copyWith(
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.red.shade100,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Icon(Icons.error_outline, color: Colors.red, size: 10),
                    Text(
                      "  Expired",
                      style: AppTextStyles.kSmall8RegularTextStyle.copyWith(
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(Icons.circle, color: Colors.grey, size: 16),
                    Text(
                      " Quantity : ",
                      style: AppTextStyles.kCaption12RegularTextStyle,
                    ),
                    Text(
                      "20ML",
                      style: AppTextStyles.kCaption12RegularTextStyle,
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.circle, color: Colors.grey, size: 16),
                    Text(
                      " Expiry Date : ",
                      style: AppTextStyles.kCaption12RegularTextStyle,
                    ),
                    Text(
                      "10/12/2023",
                      style: AppTextStyles.kCaption12RegularTextStyle,
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.circle, color: Colors.grey, size: 16),
                    Text(
                      " Bottle Size : ",
                      style: AppTextStyles.kCaption12RegularTextStyle,
                    ),
                    Text(
                      "100ML",
                      style: AppTextStyles.kCaption12RegularTextStyle,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Card(
                margin: EdgeInsets.all(4),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                color: Colors.green.shade100,
                child: InkWell(
                  borderRadius: BorderRadius.circular(20),
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Icon(Icons.arrow_circle_up, color: Colors.green, size: 30),
                  ),
                ),
              ),
              Card(
                margin: EdgeInsets.all(4),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                color: Colors.orange.shade100,
                child: InkWell(
                  borderRadius: BorderRadius.circular(20),
                  highlightColor: Colors.blue,
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Icon(Icons.arrow_circle_down, color: Colors.orange, size: 30),
                  ),
                ),
              ),
              Card(
                margin: EdgeInsets.all(4),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                color: Colors.blue.shade100,
                child: InkWell(
                  onTap: () {},
                  borderRadius: BorderRadius.circular(20),
                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Icon(Icons.mode_edit_outlined, color: Colors.blue, size: 30),
                  ),
                ),
              ),
              Card(
                margin: EdgeInsets.all(4),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                color: Colors.red.shade100,
                child: InkWell(
                  onTap: () {},
                  borderRadius: BorderRadius.circular(20),
                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Icon(Icons.delete_outline, color: Colors.red, size: 30),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
