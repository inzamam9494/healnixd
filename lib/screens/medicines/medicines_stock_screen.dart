import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healnixd/components/custom_texts.dart';
import 'package:healnixd/components/medicine_stock_card.dart';
import 'package:healnixd/style/color.dart';
import 'package:healnixd/style/text_style.dart';

class MedicinesStockScreen extends StatelessWidget {
  const MedicinesStockScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.blue,
        child: Icon(Icons.medication, color: Colors.white),
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: AppColors.lightBlueBg,
        title: appBarText(text: "Medicines Stock"),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(70),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 12.0,
              horizontal: 12.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  flex: 1,
                  child: TextField(
                    cursorColor: Colors.blue,
                    decoration: InputDecoration(
                      hintText: "Search Medicines",
                      hintStyle: AppTextStyles.kCaption12RegularTextStyle
                          .copyWith(color: Colors.grey),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 18,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40),
                        borderSide: BorderSide(color: Colors.grey.shade50),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40),
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                      suffixIcon: Container(
                        padding: EdgeInsets.all(14),
                        margin: EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                        ),
                        child: Icon(
                          CupertinoIcons.search,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 10),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  child: IconButton(
                    color: Colors.blue,
                    onPressed: () {},
                    icon: Icon(
                      Icons.manage_search,
                      color: Colors.white,
                      size: 25,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      backgroundColor: AppColors.lightBlueBg,
      body: Container(
        child: ListView.builder(
          itemCount: 5,
          itemBuilder: (context, index) {
            return medicineStockCard(
              medicineName: "Arnica Montana",
              medicineType: "Tablet",
              stock: "50",
              expiryDate: "12/2023",
            ).marginOnly(bottom: 10, left: 10, right: 10);
          },
        ),
      ),
    );
  }
}
