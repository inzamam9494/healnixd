import 'package:get/get.dart';
import 'package:healnixd/screens/profile/controller/profile_controller.dart';
import 'package:healnixd/utils/const_toast.dart';

class ProfileBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<ProfileController>(() => ProfileController(), fenix: true);
    Get.lazyPut(() => ConstToast());
  }
}