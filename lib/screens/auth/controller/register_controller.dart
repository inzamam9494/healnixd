import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:healnixd/routes/routes.dart';
import 'package:healnixd/utils/const_toast.dart';
import 'package:healnixd/utils/custom_snack_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterController extends GetxController {
  var registerNameController = TextEditingController().obs;
  var registerEmailController = TextEditingController().obs;
  var registerPasswordController = TextEditingController().obs;
  var isVisiblePassword = false.obs;
  var isLoading = false.obs;
  var isChecked = false.obs;
  final formKey = GlobalKey<FormState>();

  // Firebase Auth instance can be added here for sign up functionality
  Future<void> signUp() async {
    final name = registerNameController.value.text.trim();
    final email = registerEmailController.value.text.trim();
    final password = registerPasswordController.value.text.trim();
    // Implement Firebase sign up logic here
    if (name.isEmpty || email.isEmpty || password.isEmpty) {
      // ConstToast().showInfo("All fields are required");
      CustomSnackBar.info("All fields are required");
      return;
    }

    if (formKey.currentState!.validate()) {
      isLoading.value = true;
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        // save user data in Firestore
        String uid = FirebaseAuth.instance.currentUser!.uid;
        await FirebaseFirestore.instance.collection('user').doc(uid).set({
          'name': name,
          'email': email,
          'createdAt': FieldValue.serverTimestamp(),
        });

        // Save user info in SharedPreferences
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('name', name);
        await prefs.setString('email', email);

        // remember
        if (isChecked.value == true) {
          await prefs.setString('password', password);
        }
        // ConstToast().showSuccess("Account created successfully");
        CustomSnackBar.success("Account created successfully");
        Get.toNamed(ApplicationRoutes.onboardingScreen);
      } catch (err) {
        // ConstToast().showError("Failed to create account");
        CustomSnackBar.error("Failed to create account");
      } finally {
        isLoading.value = false;
      }
    }
  }
}
