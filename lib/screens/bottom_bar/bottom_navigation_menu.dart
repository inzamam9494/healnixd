import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healnixd/screens/bottom_bar/controller/bottom_nav_controller.dart';

class BottomNavigationMenu extends GetView<BottomNavController> {
  const BottomNavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: Colors.blue.shade50,
        bottomNavigationBar: Padding(
          padding: EdgeInsets.symmetric(vertical: 14.0, horizontal: 52.0),
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(80.0)),
            child: NavigationBar(
              backgroundColor: Colors.black,
              destinations: [
                _buildNavBarItem(Icons.add_home_outlined, 0),
                _buildNavBarItem(Icons.medication_liquid_sharp, 1),
                _buildNavBarItem(CupertinoIcons.person, 2),
              ],
            ),
          ),
        ),
        body: controller.screens[controller.currentIndex.value],
      ),
    );
  }

  Widget _buildNavBarItem(IconData icon, int index) {
    bool isSelected = controller.currentIndex.value == index;

    return InkWell(
      borderRadius: const BorderRadius.all(Radius.circular(50)),
      onTap: () => controller.currentIndex.value = index,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        margin: const EdgeInsets.all(5),
        height: isSelected ? 100 : 100,
        // animate size
        width: isSelected ? 70 : 60,
        decoration: BoxDecoration(
          color: isSelected ? Colors.blueAccent : Colors.grey.shade900,
          borderRadius: const BorderRadius.all(Radius.circular(50)),
        ),
        child: AnimatedScale(
          scale: isSelected ? 1.2 : 1.0, // animate scale effect
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOutBack,
          child: Icon(
            icon,
            color: Colors.white,
            size: isSelected ? 28 : 25, // animate icon size
          ),
        ),
      ),
    );
  }
}
