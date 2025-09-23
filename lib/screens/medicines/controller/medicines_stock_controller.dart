import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MedicinesStockController extends GetxController {
  var medicineNameController = TextEditingController();
  var selectQuantity = "30ML".obs;
  var potency = "30C".obs;
  var bottleSize = "30ML".obs;
  var expiryDate = TextEditingController();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String get userId => _auth.currentUser?.uid ?? '';

  // Add new medicine for this user
  Future<void> addMedicine() async {
    try {
      await _firestore
          .collection("user")
          .doc(userId)
          .collection("medicines")
          .add({
            "medicineName": medicineNameController.text,
            "quantity": selectQuantity.value,
            "potency": potency.value,
            "bottleSize": bottleSize.value,
            "expiryDate": expiryDate.text,
            "timestamp": FieldValue.serverTimestamp(),
          });
      medicineNameController.clear();
      expiryDate.clear();
      selectQuantity.value = "30ML";
      potency.value = "30C";
      bottleSize.value = "30ML";

      Get.snackbar(
        "Success",
        "Medicine added successfully",
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (err) {
      Get.snackbar("404 Error", err.toString());
    }
  }

  Stream<QuerySnapshot> getMedicines() {
    return _firestore
        .collection("user")
        .doc(userId)
        .collection("medicines")
        .orderBy("timestamp", descending: true)
        .snapshots();
  }
}
