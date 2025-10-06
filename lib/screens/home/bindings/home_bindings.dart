import 'package:get/get.dart';
import 'package:healnixd/screens/home/controller/home_controller.dart';
import 'package:healnixd/utils/const_toast.dart';

class HomeBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController(), fenix: true);
    Get.lazyPut(() => ConstToast());
  }
}