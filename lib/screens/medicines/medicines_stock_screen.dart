import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healnixd/components/custom_drop_down.dart';
import 'package:healnixd/components/custom_texts.dart';
import 'package:healnixd/components/medicine_stock_card.dart';
import 'package:healnixd/screens/medicines/controller/medicines_stock_controller.dart';
import 'package:healnixd/style/color.dart';
import 'package:healnixd/style/text_style.dart';
import 'package:healnixd/utils/const_toast.dart';
import 'package:healnixd/utils/custom_snack_bar.dart';

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
              content: SingleChildScrollView(
                child: Column(
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
                  child: TextFormField(
                    onChanged: (value) {
                      controller.searchQuery.value = value;
                      controller.applyFilters();
                    },
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
                                  trailing: Icon(
                                    Icons.arrow_forward_ios,
                                    size: 15,
                                  ),
                                  title: Text(
                                    "Filter by Potency",
                                    style: AppTextStyles
                                        .kCaption12RegularTextStyle,
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
                                          onChanged: (val) {
                                            controller.selectPotency.value =
                                                val!;
                                          },
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
                                              controller.applyFilters();
                                              Get.back();
                                            },
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                                ListTile(
                                  trailing: Icon(
                                    Icons.arrow_forward_ios,
                                    size: 15,
                                  ),
                                  title: Text(
                                    "Sorted by :",
                                    style: AppTextStyles
                                        .kCaption12RegularTextStyle,
                                  ),
                                  onTap: () {
                                    Get.dialog(
                                      AlertDialog(
                                        backgroundColor: Colors.white,
                                        title: Text("Sorted By"),
                                        content: CustomDropDown(
                                          labelText: "Sorted by :",
                                          items: [
                                            "Name (A-Z)",
                                            "Bottle Size",
                                            "Expiry Date",
                                          ],
                                          selectedValue: "Name (A-Z)",
                                          onChanged: (val) {
                                            controller.sortBy.value = val!;
                                          },
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
                                              controller.applyFilters();
                                              Get.back();
                                            },
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                                ListTile(
                                  trailing: Icon(
                                    Icons.arrow_forward_ios,
                                    size: 15,
                                  ),
                                  title: Text(
                                    "Filter by Order",
                                    style: AppTextStyles
                                        .kCaption12RegularTextStyle,
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
                                          onChanged: (val) {
                                            controller.sortOrder.value = val!;
                                          },
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
                                              controller.applyFilters();
                                              Get.back();
                                            },
                                          ),
                                        ],
                                      ),
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
      body: RefreshIndicator(
        color: Colors.blue,
        onRefresh: () async {
          // 1. Clear search & filters
          controller.searchQuery.value = "";
          controller.selectPotency.value = "All";
          controller.sortBy.value = "Name (A-Z)";
          controller.sortOrder.value = "Ascending";

          // 2. Clear input fields
          controller.clearFields();

          // 3. Re-fetch medicines from Firestore
          // StreamBuilder will automatically update, but if you want:
          var snapshot = await FirebaseFirestore.instance
              .collection("user")
              .doc(controller.userId)
              .collection("medicines")
              .orderBy("timestamp", descending: true)
              .get();

          controller.allMedicines.assignAll(snapshot.docs);
          controller.applyFilters();
        },
        child: StreamBuilder<QuerySnapshot>(
          stream: controller.getMedicines(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(color: Colors.blue),
              );
            }
            // var medicines = snapshot.data!.docs;
            // controller.allMedicines.value = medicines;
            // controller.allMedicines.assignAll(snapshot.data!.docs);
            // controller.applyFilters();
            //
            // if (controller.allMedicines.isEmpty) {
            //   return Center(
            //     child: Text(
            //       "No medicines found",
            //       style: AppTextStyles.kCaption12RegularTextStyle,
            //     ),
            //   );
            // }
            controller.allMedicines.assignAll(snapshot.data!.docs);
            controller.applyFilters(); // filter based on searchQuery

            return Obx(() {
              if (controller.filteredMedicines.isEmpty) {
                return ListView(
                  physics: const AlwaysScrollableScrollPhysics(), // 🔑 Scroll enable
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.8,
                      child: Center(
                        child: Text(
                          "No medicines found \n Try adding some \n or Refreshing the Screen",
                          style: AppTextStyles.kBody15RegularTextStyle,
                        ),
                      ),
                    ),
                  ],
                );
              }
              return Container(
                child: ListView.builder(
                  itemCount: controller.filteredMedicines.length,
                  itemBuilder: (context, index) {
                    var medicine = controller.filteredMedicines[index];
                    var docId = medicine.id;
                    // for low stock indication
                    var currentQty =
                        int.tryParse(medicine['quantity'].toString()) ?? 0;
                    var bottleSizeVal =
                        int.tryParse(medicine['bottleSize'].toString()) ?? 1;
                    bool isLowStock = currentQty <= 0.2 * bottleSizeVal;
                    // for expiry indication
                    DateTime today = DateTime.now();
                    bool isExpiredToday = false;
                    try {
                      List<String> parts = medicine['expiryDate'].split(
                        '-',
                      ); // "dd-mm-yyyy"
                      DateTime expiry = DateTime(
                        int.parse(parts[2]),
                        int.parse(parts[1]),
                        int.parse(parts[0]),
                      );
                      isExpiredToday = expiry.isBefore(DateTime(
                        today.year,
                        today.month,
                        today.day,
                      )) ||
                          expiry.isAtSameMomentAs(DateTime(
                            today.year,
                            today.month,
                            today.day,
                          ));
                    } catch (e) {
                      isExpiredToday = false;
                    }
                    return medicineStockCard(
                      medicineName: medicine['medicineName'],
                      medicineScale: medicine['potency'],
                      medicineQuantity: medicine['quantity'],
                      expiryDate: medicine['expiryDate'],
                      bottleSize: medicine['bottleSize'],
                      isLowStock: isLowStock,
                      isExpired: isExpiredToday,
                      onTapIncrease: () {
                        Get.dialog(
                          AlertDialog(
                            backgroundColor: Colors.white,
                            title: Text(
                              "${medicine['medicineName']} \n Increase Stock",
                              style: AppTextStyles.kBody15SemiBoldTextStyle,
                            ),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                addDialogTextField(
                                  controller: controller.stockInputController,
                                  labelText: "Enter Quantity",
                                  keyboardType: TextInputType.number,
                                ),
                                Text(
                                  "Current Quantity: ${medicine['quantity']}ML",
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
                                onPressed: () async {
                                  String inputText = controller
                                      .stockInputController
                                      .text
                                      .trim();

                                  if (inputText.isEmpty) {
                                    // ConstToast().showError(
                                    //   "Please enter quantity",
                                    // );
                                    CustomSnackBar.error("Please enter quantity");
                                    return;
                                  }

                                  int qty = int.tryParse(inputText) ?? 0;

                                  if (qty <= 0) {
                                    // ConstToast().showError(
                                    //   "Please enter valid quantity",
                                    // );
                                    CustomSnackBar.error("Please enter valid quantity");
                                    return;
                                  }

                                  // Close dialog first
                                  Get.back();

                                  // Then perform the operation
                                  await controller.increaseStock(docId, qty);
                                  controller.stockInputController.clear();
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
                              "${medicine['medicineName']} \n Decrease Stock",
                              style: AppTextStyles.kBody15SemiBoldTextStyle,
                            ),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                addDialogTextField(
                                  controller: controller.stockInputController,
                                  labelText: "Enter Quantity",
                                  keyboardType: TextInputType.number,
                                ),
                                Text(
                                  "Current Quantity: ${medicine['quantity']}ML",
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
                                onPressed: () async {
                                  String inputText = controller
                                      .stockInputController
                                      .text
                                      .trim();

                                  if (inputText.isEmpty) {
                                    // ConstToast().showError(
                                    //   "Please enter quantity",
                                    // );
                                    CustomSnackBar.error("Please enter quantity");
                                    return;
                                  }

                                  int qty = int.tryParse(inputText) ?? 0;

                                  if (qty <= 0) {
                                    // ConstToast().showError(
                                    //   "Please enter valid quantity",
                                    // );
                                    CustomSnackBar.error("Please enter valid quantity");
                                    return;
                                  }

                                  // Close dialog first
                                  Get.back();

                                  // Then perform the operation
                                  await controller.decreaseStock(docId, qty);
                                  controller.stockInputController.clear();
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
                                  controller: controller
                                      .medicineNameController, // no Obx
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
                                    },
                                    selectedValue: controller.bottleSize.value,
                                  ),
                                ),
                                addDialogTextField(
                                  controller: controller.expiryDate,
                                  // no Obx
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
                                      controller.expiryDate.text =
                                          formattedDate;
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
                                  controller.updateMedicine(docId);
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
                                  controller.deleteMedicine(docId);
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
            });
          },
        ),
      ),
    );
  }
}
