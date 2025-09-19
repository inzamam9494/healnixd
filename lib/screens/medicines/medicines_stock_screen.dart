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
        onPressed: () {
          Get.dialog(
            AlertDialog(
              backgroundColor: Colors.white,
              title: Text(
                'Add New Medicine',
                style: AppTextStyles.kCaption12SemiBoldTextStyle,
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  addDialogTextField(labelText : "Medicine Name"),
                  addDialogTextField(labelText : "Current Quantity"),
                  addDialogTextField(labelText : "Potency"),
                  addDialogTextField(labelText : "Bottle Size"),
                  addDialogTextField(labelText : "Expiry Date" ),
                ],
              ),
              actions: [
                dialogButton(
                  text: "Cancel",
                  color: Colors.white,
                  textColor: Colors.grey,
                  onPressed: () {
                    Get.back();
                  },
                ),
                dialogButton(
                  text: "Add",
                  onPressed: () {
                    Get.back();
                  },
                )
              ],
            ),
          );
        },
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
                        vertical: 14,
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
                    onPressed: () {
                      showModalBottomSheet(
                          context: context,
                          isDismissible: true,
                          enableDrag: true,
                          builder: (context) {
                        return Container(
                          padding: EdgeInsets.all(20),
                          height: 250,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Filter By", style: AppTextStyles.kCaption12SemiBoldTextStyle,),
                              SizedBox(height: 10,),
                              DropdownButton(items: [
                                DropdownMenuItem(child: Text("100C"), value: "100C",),
                                DropdownMenuItem(child: Text("200C"), value: "200C",),
                                DropdownMenuItem(child: Text("200C"), value: "200C",),
                                DropdownMenuItem(child: Text("200C"), value: "200C",),
                                DropdownMenuItem(child: Text("200C"), value: "200C",),
                                DropdownMenuItem(child: Text("200C"), value: "200C",),
                                DropdownMenuItem(child: Text("200C"), value: "200C",),
                                DropdownMenuItem(child: Text("200C"), value: "200C",),
                                DropdownMenuItem(child: Text("200C"), value: "200C",),
                              ], onChanged: (val){}),
                              ListTile(
                                contentPadding: EdgeInsets.zero,
                                title: Text("Stock Level", style: AppTextStyles.kSmall10RegularTextStyle,),
                                trailing: Icon(Icons.arrow_forward_ios, size: 16,),
                                onTap: (){},
                              ),
                              ListTile(
                                contentPadding: EdgeInsets.zero,
                                title: Text("Medicine Type", style: AppTextStyles.kSmall10RegularTextStyle,),
                                trailing: Icon(Icons.arrow_forward_ios, size: 16,),
                                onTap: (){},
                              ),
                            ],
                          ),
                        );
                      });
                    },
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
              onTapIncrease: () {
                Get.dialog(AlertDialog(
                  title: Text("Increase Stock"),
                  content: addDialogTextField(labelText : "Enter quantity to increase"),
                  actions: [
                    dialogButton(
                      text: "Cancel",
                      color: Colors.white,
                      textColor: Colors.grey,
                      onPressed: () {
                        Get.back();
                      },
                    ),
                    dialogButton(
                      text: "Increase",
                      onPressed: () {
                        Get.back();
                      },
                    )
                  ],
                ));
              },
              onTapDecrease: () {
                Get.dialog(AlertDialog(
                  title: Text("Decrease Stock"),
                  content: addDialogTextField(labelText : "Enter quantity to decrease"),
                  actions: [
                    dialogButton(
                      text: "Cancel",
                      color: Colors.white,
                      textColor: Colors.grey,
                      onPressed: () {
                        Get.back();
                      },
                    ),
                    dialogButton(
                      text: "Decrease",
                      onPressed: () {
                        Get.back();
                      },
                    )
                  ],
                ));
              },
              onTapEdit: () {
                Get.dialog(AlertDialog(
                  title: Text('Edit Medicine'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      addDialogTextField(labelText : "Medicine Name"),
                      addDialogTextField(labelText : "Current Quantity"),
                      addDialogTextField(labelText : "Potency"),
                      addDialogTextField(labelText : "Bottle Size"),
                      addDialogTextField(labelText : "Expiry Date" ),
                    ],
                  ),
                  actions: [
                    dialogButton(
                      text: "Cancel",
                      color: Colors.white,
                      textColor: Colors.grey,
                      onPressed: () {
                        Get.back();
                      },
                    ),
                    dialogButton(
                      text: "Save",
                      onPressed: () {
                        Get.back();
                      },
                    )
                  ],
                ));
              },
              onTapDelete: () {
                Get.dialog(AlertDialog(
                  title: Container(
                      child: Text("Are you sure you want to delete this medicine?")
                  ),
                  actions: [
                    dialogButton(
                      text: "Cancel",
                      color: Colors.white,
                      textColor: Colors.grey,
                      onPressed: () {
                        Get.back();
                      },
                    ),
                    dialogButton(
                      text: "Delete",
                      color: Colors.red,
                      textColor: Colors.white,
                      onPressed: () {
                        Get.back();
                      },
                    )
                  ],
                ));
              },
            ).marginOnly(bottom: 10, left: 10, right: 10);
          },
        ),
      ),
    );
  }
}
