import 'package:get/get.dart';
import 'package:healnixd/screens/auth/controller/register_controller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegisterController>(() => RegisterController(), fenix: true);
  }
}