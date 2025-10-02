import 'package:get/get.dart';
import 'package:healnixd/screens/home/controller/home_controller.dart';
import 'package:healnixd/screens/home/home_screen.dart';
import 'package:healnixd/screens/medicines/controller/medicines_stock_controller.dart';
import 'package:healnixd/screens/medicines/medicines_stock_screen.dart';
import 'package:healnixd/screens/profile/controller/profile_controller.dart';
import 'package:healnixd/screens/profile/profile_screen.dart';

class BottomNavController extends GetxController {
  RxInt currentIndex = 0.obs;
  final MedicinesStockController medicinesStockController = Get.put(
    MedicinesStockController(),
  );
  final HomeController homeController = Get.put(HomeController());
  final ProfileController profileController = Get.put(ProfileController());

  final screens = [HomeScreen(), MedicinesStockScreen(), ProfileScreen()];
}
