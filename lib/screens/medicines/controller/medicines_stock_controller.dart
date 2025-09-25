import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healnixd/utils/const_toast.dart';

class MedicinesStockController extends GetxController {
  var medicineNameController = TextEditingController();
  var selectQuantity = "30ML".obs;
  var potency = "30C".obs;
  var bottleSize = "30".obs;
  var unit = "ML".obs;
  var expiryDate = TextEditingController();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String get userId => _auth.currentUser?.uid ?? '';

  // Add new medicine for this user
  Future<void> addMedicine() async {
    print('Current userID $userId');
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
      ConstToast().showSuccess("Medicine added successfully");
    } catch (err) {
      ConstToast().showError(err.toString());
    }
  }

  // Edit or Update existing medicine for this user
  Future<void> updateMedicine(String docId) async {
    try {
      await _firestore
          .collection("user")
          .doc(userId)
          .collection("medicines")
          .doc(docId)
          .update({
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
      ConstToast().showSuccess("Medicine updated successfully");
    } catch (err) {
      ConstToast().showError(err.toString());
    }
  }

  // Increase stock of a medicine
  Future<void> increaseStock(String docId, int quantity) async {
    final docRef = _firestore
        .collection("user")
        .doc(userId)
        .collection("medicines")
        .doc(docId);

    final docSnap = await docRef.get();
    if (docSnap.exists) {
      int currentQty =
          int.tryParse(
            docSnap['quantity'].toString().replaceAll(RegExp(r'[^0-9]'), ''),
          ) ??
          0;
      await docRef.update({
        'quantity':
            '${currentQty + quantity}${docSnap['quantity'].toString().replaceAll(RegExp(r'[0-9]'), '')}',
      });
      ConstToast().showSuccess("Stock increased successfully");
    }
  }

  // Decrease stock of a medicine
  Future<void> decreaseStock(String docId, int quantity) async {
    final docRef = _firestore
        .collection("user")
        .doc(userId)
        .collection("medicines")
        .doc(docId);

    final docSnap = await docRef.get();
    if (docSnap.exists) {
      int currentQty =
          int.tryParse(
            docSnap['quantity'].toString().replaceAll(RegExp(r'[^0-9]'), ''),
          ) ??
          0;
      int newQty = currentQty - quantity;
      if (newQty < 0) newQty = 0;
      await docRef.update({
        'quantity':
            '$newQty${docSnap['quantity'].toString().replaceAll(RegExp(r'[0-9]'), '')}',
      });
      ConstToast().showSuccess("Stock decreased successfully");
    }
  }

  // Delete a medicine
  Future<void> deleteMedicine(String docId) async {
    try {
      await _firestore
          .collection("user")
          .doc(userId)
          .collection("medicines")
          .doc(docId)
          .delete();
      ConstToast().showSuccess("Medicine deleted successfully");
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
