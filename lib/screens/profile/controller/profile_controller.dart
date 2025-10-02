import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:healnixd/utils/const_toast.dart';

class ProfileController extends GetxController {
  var userId = "".obs;
  var userEmail = "".obs;

  @override
  void onInit() {
    super.onInit();
    var user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      userId.value = user.uid;
      userEmail.value = user.email ?? "";
    }
  }

  Future<void> logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      userId.value = "";
      userEmail.value = "";
      ConstToast().showSuccess("Logged out successfully");
      Get.offAllNamed('/');
    } catch (err) {
      debugPrint("Logout Error: $err");
      ConstToast().showError("Failed to logout");
    }
  }
}
