import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MedicinesStockController extends GetxController {
    var medicineNameController = TextEditingController();
    var selectQuantity = "30ML".obs;
    var potency = "30C".obs;
    var bottleSize = "30ML".obs;
    var expiryDate = TextEditingController();
}
