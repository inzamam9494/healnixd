import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healnixd/components/custom_drop_down.dart';
import 'package:healnixd/components/custom_texts.dart';
import 'package:healnixd/components/medicine_stock_card.dart';
import 'package:healnixd/screens/medicines/controller/medicines_stock_controller.dart';
import 'package:healnixd/style/color.dart';
import 'package:healnixd/style/text_style.dart';

class MedicinesStockScreen extends GetView<MedicinesStockController> {
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
                  addDialogTextField(
                    labelText: "Medicine Name",
                    controller: controller.medicineNameController, // no Obx
                  ),
                  Obx(
                    () => CustomDropDown(
                      labelText: "Select Quantity",
                      items: [(controller.bottleSize.value)],
                      onChanged: null,
                      selectedValue: controller
                          .selectQuantity
                          .value, // make sure dropdown shows current value
                    ),
                  ),
                  Obx(
                    () => CustomDropDown(
                      labelText: "Potency",
                      items: ["30C", "200C", "1000C", "1M"],
                      onChanged: (val) {
                        controller.potency.value = val!;
                      },
                      selectedValue: controller.potency.value,
                    ),
                  ),
                  Obx(
                    () => CustomDropDown(
                      labelText: "Bottle Size",
                      items: ["30", "100", "500"],
                      onChanged: (val) {
                        controller.bottleSize.value = val!;
                        controller.selectQuantity.value = val;
                        controller.unit.value = "ML";
                      },
                      selectedValue: controller.bottleSize.value,
                    ),
                  ),
                  addDialogTextField(
                    controller: controller.expiryDate, // no Obx
                    labelText: "Expiry Date",
                    suffixIcon: Icons.calendar_month,
                    iconTap: () async {
                      DateTime? pickDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                      );
                      if (pickDate != null) {
                        String formattedDate =
                            "${pickDate.day}-${pickDate.month}-${pickDate.year}";
                        controller.expiryDate.text = formattedDate;
                      }
                    },
                  ),
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
                    controller.addMedicine();
                    Get.back();
                  },
                ),
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
                                Text(
                                  "Filter By",
                                  style: AppTextStyles.kBody15SemiBoldTextStyle,
                                ),
                                SizedBox(height: 15),
                                ListTile(
                                  trailing: Icon(Icons.arrow_forward_ios, size: 15),
                                  title: Text(
                                    "Filter by Potency",
                                    style: AppTextStyles.kCaption12RegularTextStyle,
                                  ),
                                  onTap: () {
                                    Get.dialog(
                                      AlertDialog(
                                        backgroundColor: Colors.white,
                                        title: Text("All Potency"),
                                        content: CustomDropDown(
                                          labelText: "Filter By Potency",
                                          items: ["30C", "200C", "1000C", "1M"],
                                          selectedValue: "30C",
                                          onChanged: (val) {},
                                        ),
                                        actions: [
                                          dialogButton(
                                            text: "Close",
                                            color: Colors.white,
                                            textColor: Colors.grey,
                                            onPressed: () {
                                              Get.back();
                                            },
                                          ),
                                          dialogButton(
                                            color: Colors.green,
                                            text: "Apply",
                                            onPressed: () {
                                              Get.back();
                                            },
                                          )
                                        ],
                                      )
                                    );
                                  },
                                ),
                                ListTile(
                                  trailing: Icon(Icons.arrow_forward_ios, size: 15),
                                  title: Text(
                                    "Sorted by :",
                                    style: AppTextStyles.kCaption12RegularTextStyle,
                                  ),
                                  onTap: () {
                                    Get.dialog(
                                      AlertDialog(
                                        backgroundColor: Colors.white,
                                        title: Text("Sorted By"),
                                        content: CustomDropDown(
                                          labelText: "Sorted by :",
                                          items: ["Name (A-Z)", "Bottle Size", "Expiry Date"],
                                          selectedValue: "Name (A-Z)",
                                          onChanged: (val) {},
                                        ),
                                        actions: [
                                          dialogButton(
                                            text: "Close",
                                            color: Colors.white,
                                            textColor: Colors.grey,
                                            onPressed: () {
                                              Get.back();
                                            },
                                          ),
                                          dialogButton(
                                            color: Colors.green,
                                            text: "Apply",
                                            onPressed: () {
                                              Get.back();
                                            },
                                          )
                                        ],
                                      )
                                    );
                                  },
                                ),
                                ListTile(
                                  trailing: Icon(Icons.arrow_forward_ios, size: 15),
                                  title: Text(
                                    "Filter by Order",
                                    style: AppTextStyles.kCaption12RegularTextStyle,
                                  ),
                                  onTap: () {
                                    Get.dialog(
                                      AlertDialog(
                                        backgroundColor: Colors.white,
                                        title: Text("Filter by Order"),
                                        content: CustomDropDown(
                                          labelText: "Filter by Order",
                                          items: ["Ascending", "Descending"],
                                          selectedValue: "Ascending",
                                          onChanged: (val) {},
                                        ),
                                        actions: [
                                          dialogButton(
                                            text: "Close",
                                            color: Colors.white,
                                            textColor: Colors.grey,
                                            onPressed: () {
                                              Get.back();
                                            },
                                          ),
                                          dialogButton(
                                            color: Colors.green,
                                            text: "Apply",
                                            onPressed: () {
                                              Get.back();
                                            },
                                          )
                                        ],
                                      )
                                    );
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      );
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
      body: StreamBuilder(
        stream: controller.getMedicines(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator(color: Colors.blue,));
          }
          var medicines = snapshot.data!.docs;
          if (medicines.isEmpty) {
            return Center(
              child: Text(
                "No medicines found",
                style: AppTextStyles.kCaption12RegularTextStyle,
              ),
            );
          }
          return Container(
            child: ListView.builder(
              itemCount: medicines.length,
              itemBuilder: (context, index) {
                var medicine = medicines[index];
                var docId = medicine.id;
                return medicineStockCard(
                  medicineName: medicine['medicineName'],
                  medicineScale: medicine['potency'],
                  medicineQuantity: medicine['quantity'],
                  expiryDate: medicine['expiryDate'],
                  bottleSize: medicine['bottleSize'],
                  onTapIncrease: () {
                    Get.dialog(
                      AlertDialog(
                        backgroundColor: Colors.white,
                        title: Text(
                          "Arnica Montana \n Increase Stock",
                          style: AppTextStyles.kBody15SemiBoldTextStyle,
                        ),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            addDialogTextField(
                              labelText: "Enter Quantity",
                              keyboardType: TextInputType.number,
                            ),
                            Text(
                              "Current Quantity: 50ML",
                              style: AppTextStyles.kSmall8SemiBoldTextStyle,
                            ).marginAll(2),
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
                            color: Colors.green,
                            text: "Add Stock",
                            onPressed: () {
                              Get.back();
                            },
                          ),
                        ],
                      ),
                    );
                  },
                  onTapDecrease: () {
                    Get.dialog(
                      AlertDialog(
                        backgroundColor: Colors.white,
                        title: Text(
                          "Arnica Montana \n Decrease Stock",
                          style: AppTextStyles.kBody15SemiBoldTextStyle,
                        ),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            addDialogTextField(
                              labelText: "Enter Quantity",
                              keyboardType: TextInputType.number,
                            ),
                            Text(
                              "Current Quantity: 50ML",
                              style: AppTextStyles.kSmall8SemiBoldTextStyle,
                            ).marginAll(2),
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
                            text: "Remove Stock",
                            color: Colors.orange,
                            onPressed: () {
                              Get.back();
                            },
                          ),
                        ],
                      ),
                    );
                  },
                  onTapEdit: () {
                    Get.dialog(
                      AlertDialog(
                        backgroundColor: Colors.white,
                        title: Text(
                          'Edit Medicine',
                          style: AppTextStyles.kCaption12SemiBoldTextStyle,
                        ),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            addDialogTextField(
                              labelText: "Medicine Name",
                              controller:
                                  controller.medicineNameController, // no Obx
                            ),
                            Obx(
                              () => CustomDropDown(
                                labelText: "Select Quantity",
                                items: [(controller.bottleSize.value)],
                                onChanged: null,
                                selectedValue: controller
                                    .selectQuantity
                                    .value, // make sure dropdown shows current value
                              ),
                            ),
                            Obx(
                              () => CustomDropDown(
                                labelText: "Potency",
                                items: ["30C", "200C", "1000C", "1M"],
                                onChanged: (val) {
                                  controller.potency.value = val!;
                                },
                                selectedValue: controller.potency.value,
                              ),
                            ),
                            Obx(
                              () => CustomDropDown(
                                labelText: "Bottle Size",
                                items: ["30ML", "100ML", "500ML"],
                                onChanged: (val) {
                                  controller.bottleSize.value = val!;
                                  controller.selectQuantity.value = val;
                                },
                                selectedValue: controller.bottleSize.value,
                              ),
                            ),
                            addDialogTextField(
                              controller: controller.expiryDate, // no Obx
                              labelText: "Expiry Date",
                              suffixIcon: Icons.calendar_month,
                              iconTap: () async {
                                DateTime? pickDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime(2100),
                                );
                                if (pickDate != null) {
                                  String formattedDate =
                                      "${pickDate.day}-${pickDate.month}-${pickDate.year}";
                                  controller.expiryDate.text = formattedDate;
                                }
                              },
                            ),
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
                          ),
                        ],
                      ),
                    );
                  },
                  onTapDelete: () {
                    Get.dialog(
                      AlertDialog(
                        backgroundColor: Colors.white,
                        title: Text(
                          "Delete Medicine",
                          style: AppTextStyles.kBody15SemiBoldTextStyle,
                        ),
                        content: Text(
                          "Are you sure you want to delete *Arnica Montana*?",
                          style: AppTextStyles.kCaption12SemiBoldTextStyle,
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
                          ),
                        ],
                      ),
                    );
                  },
                ).marginOnly(bottom: 10, left: 10, right: 10);
              },
            ),
          );
        },
      ),
    );
  }
}
