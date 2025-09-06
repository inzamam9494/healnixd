import 'package:get/get.dart';
import 'package:healnixd/screens/home/home_screen.dart';
import 'package:healnixd/screens/medicines/medicines_stock_screen.dart';
import 'package:healnixd/screens/profile/profile_screen.dart';

class BottomNavController extends GetxController{
  RxInt currentIndex = 0.obs;

  final screens = [
    HomeScreen(),
    MedicinesStockScreen(),
    ProfileScreen()
  ];

}