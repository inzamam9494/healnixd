import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healnixd/utils/const_toast.dart';

class MedicinesStockController extends GetxController {
  var medicineNameController = TextEditingController();
  var selectQuantity = "30".obs; // Keep as string for consistency
  var potency = "30C".obs;
  var bottleSize = "30".obs; // Keep as string for consistency
  var unit = "ML".obs;
  var expiryDate = TextEditingController();
  var stockInputController = TextEditingController();

  var searchQuery = "".obs;
  var selectPotency = "All".obs;
  var sortBy = "Name (A-Z)".obs;
  var sortOrder = "Ascending".obs;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String get userId => _auth.currentUser?.uid ?? '';

  // master list from firestore
  var allMedicines = <DocumentSnapshot>[].obs;

  // filter list to UI
  var filteredMedicines = <DocumentSnapshot>[].obs;


  void applyFilters() {
    List<DocumentSnapshot> tempList = allMedicines.toList();

    // Search filter
    if (searchQuery.value.isNotEmpty) {
      tempList = tempList.where((doc) {
        final name = doc['medicineName'].toString().toLowerCase();
        return name.contains(searchQuery.value.toLowerCase());
      }).toList();
    }

    // Potency filter
    if (selectPotency.value != "All") {
      tempList = tempList.where((doc) {
        return doc['potency'] == selectPotency.value;
      }).toList();
    }
    if (sortBy.value == "Name (A-Z)") {
      tempList.sort((a, b) => a['medicineName'].compareTo(b['medicineName']));
    } else if (sortBy.value == "Bottle Size") {
      tempList.sort((a, b) => int.parse(a['bottleSize']).compareTo(int.parse(b['bottleSize'])));
    } else if (sortBy.value == "Expiry Date") {
      tempList.sort((a, b) {
        DateTime expA = parseDate(a['expiryDate']);
        DateTime expB = parseDate(b['expiryDate']);
        return expA.compareTo(expB);
      });
    }

    if (sortOrder.value == "Descending") {
      tempList = tempList.reversed.toList();
    }

    filteredMedicines.value = tempList;
  }

  DateTime parseDate(dynamic date) {
    if (date is Timestamp) {
      return date.toDate();
    }
    if (date is String) {
      try {
        return DateTime.parse(date);
      } catch (_) {
        return DateTime(1900); // fallback for invalid format
      }
    }
    return DateTime(1900); // fallback for null or unknown type
  }
  // void applyFilters() {
  //
  //   List<DocumentSnapshot> tempList = allMedicines.toList();
  //   if (searchQuery.value.isEmpty) {
  //     filteredMedicines.assignAll(allMedicines);
  //   } else {
  //     filteredMedicines.assignAll(
  //       allMedicines.where((doc) {
  //         final name = doc['medicineName'].toString().toLowerCase();
  //         return name.contains(searchQuery.value.toLowerCase());
  //       }).toList(),
  //     );
  //   }
  //   //filter by potency
  //   if (selectPotency.value != "All") {
  //     tempList = tempList.where((doc) {
  //       return doc['potency'] == selectPotency.value;
  //     }).toList();
  //   }
  //   filteredMedicines.value = tempList;
  // }

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
            "quantity": selectQuantity.value, // Store as string
            "potency": potency.value,
            "bottleSize": bottleSize.value,
            "expiryDate": expiryDate.text,
            "timestamp": FieldValue.serverTimestamp(),
          });
      clearFields();
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
            "quantity": selectQuantity.value, // Store as string
            "potency": potency.value,
            "bottleSize": bottleSize.value,
            "expiryDate": expiryDate.text,
            "timestamp": FieldValue.serverTimestamp(),
          });
      clearFields();
      ConstToast().showSuccess("Medicine updated successfully");
    } catch (err) {
      ConstToast().showError(err.toString());
    }
  }

  // Increase stock of a medicine
  Future<void> increaseStock(String docId, int quantity) async {
    try {
      final docRef = _firestore
          .collection("user")
          .doc(userId)
          .collection("medicines")
          .doc(docId);

      final docSnap = await docRef.get();
      if (docSnap.exists) {
        // Handle both string and int types from Firestore
        var currentQtyData = docSnap['quantity'];
        int currentQty;

        if (currentQtyData is int) {
          currentQty = currentQtyData;
        } else if (currentQtyData is String) {
          currentQty = int.tryParse(currentQtyData) ?? 0;
        } else {
          currentQty = 0;
        }

        int newQty = currentQty + quantity;
        await docRef.update({'quantity': newQty.toString()}); // Store as string
        ConstToast().showSuccess("Stock increased successfully");
      } else {
        ConstToast().showError("Medicine not found");
      }
    } catch (err) {
      ConstToast().showError("Error increasing stock: ${err.toString()}");
    }
  }

  // Decrease stock of a medicine
  Future<void> decreaseStock(String docId, int quantity) async {
    try {
      final docRef = _firestore
          .collection("user")
          .doc(userId)
          .collection("medicines")
          .doc(docId);

      final docSnap = await docRef.get();
      if (docSnap.exists) {
        // Handle both string and int types from Firestore
        var currentQtyData = docSnap['quantity'];
        int currentQty;

        if (currentQtyData is int) {
          currentQty = currentQtyData;
        } else if (currentQtyData is String) {
          currentQty = int.tryParse(currentQtyData) ?? 0;
        } else {
          currentQty = 0;
        }

        if (quantity > currentQty) {
          ConstToast().showError("Cannot remove more than current stock");
          return;
        }

        int newQty = currentQty - quantity;
        if (newQty < 0) newQty = 0;
        await docRef.update({'quantity': newQty.toString()}); // Store as string
        ConstToast().showSuccess("Stock decreased successfully");
      } else {
        ConstToast().showError("Medicine not found");
      }
    } catch (err) {
      ConstToast().showError("Error decreasing stock: ${err.toString()}");
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

  // Helper method to populate fields for editing
  void populateFieldsForEdit(Map<String, dynamic> medicineData) {
    medicineNameController.text = medicineData['medicineName'] ?? '';
    selectQuantity.value = medicineData['bottleSize']?.toString() ?? '30';
    potency.value = medicineData['potency'] ?? '30C';
    bottleSize.value = medicineData['bottleSize']?.toString() ?? '30';
    expiryDate.text = medicineData['expiryDate'] ?? '';
  }

  // Helper method to clear all fields
  Future<void> clearFields() async {
    medicineNameController.clear();
    expiryDate.clear();
    stockInputController.clear();
    selectQuantity.value = "30";
    potency.value = "30C";
    bottleSize.value = "30";
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
