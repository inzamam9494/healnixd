import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:healnixd/utils/const_toast.dart';
import 'package:healnixd/utils/custom_snack_bar.dart';

class ProfileController extends GetxController {
  var userId = "".obs;
  var userName = "".obs;
  var userEmail = "".obs;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void onInit() {
    super.onInit();
    var user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      userId.value = user.uid;
      userEmail.value = user.email ?? "";
    }
    fetchUserDetails();
  }

  void fetchUserDetails() {
    _firestore.collection("user").doc(userId.value).get().then((doc) {
      if (doc.exists) {
        var data = doc.data();
        userName.value = data?['name'] ?? 'Guest';
        userEmail.value = data?['email'] ?? '';
      }
    });
  }

  Future<void> logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      userId.value = "";
      userEmail.value = "";
      // ConstToast().showSuccess("Logged out successfully");
      CustomSnackBar.success("Logged out successfully");
      Get.offAllNamed('/');
    } catch (err) {
      debugPrint("Logout Error: $err");
      // ConstToast().showError("Failed to logout");
      CustomSnackBar.error("Failed to logout");
    }
  }
}
