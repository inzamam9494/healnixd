import 'package:get/get.dart';
import 'package:healnixd/screens/medicines/controller/medicines_stock_controller.dart';

class MedicinesStockBinding extends Bindings{
  @override
  void dependencies() {
    // lazy + recreated if needed
    Get.lazyPut<MedicinesStockController>(() => MedicinesStockController(), fenix: true);
  }
}