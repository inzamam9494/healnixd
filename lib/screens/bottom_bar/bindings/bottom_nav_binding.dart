import 'package:get/get.dart';
import 'package:healnixd/screens/bottom_bar/controller/bottom_nav_controller.dart';

class BottomNavBinding extends Bindings{
  @override
  void dependencies() {
    // lazy + recreated if needed
    Get.lazyPut<BottomNavController>(() => BottomNavController(), fenix: true);
  }
}