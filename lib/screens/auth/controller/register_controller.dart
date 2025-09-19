import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:healnixd/routes/routes.dart';
import 'package:healnixd/utils/const_toast.dart';
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
    Rx<String> name = registerNameController.value.text.obs;
    final email = registerEmailController.value.text.trim();
    final password = registerPasswordController.value.text.trim();
    // Implement Firebase sign up logic here
    if (name.isEmpty || email.isEmpty || password.isEmpty) {
      ConstToast().showInfo("All fields are required");
      return;
    }

    if (formKey.currentState!.validate()) {
      isLoading.value = true;
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        // remember
        if (isChecked.value == true) {
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('email', email);
          await prefs.setString('password', password);
        }
        ConstToast().showSuccess("Account created successfully");
        Get.toNamed(ApplicationRoutes.onboardingScreen);
      } catch (err) {
        ConstToast().showError("Failed to create account");
      } finally {
        isLoading.value = false;
      }
    }
  }
}
