import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healnixd/routes/routes.dart';
import 'package:healnixd/style/text_style.dart';
import 'package:healnixd/utils/const_toast.dart';
import 'package:flutter/material.dart';
import 'package:healnixd/utils/custom_snack_bar.dart';


class LoginController extends GetxController{
  var loginEmailController = TextEditingController();
  var loginPasswordController = TextEditingController();
  var isVisiblePassword = false.obs;
  var isLoading = false.obs;
  final formKey = GlobalKey<FormState>();
  var resetPasswordEmailController = TextEditingController();
  final resetPasswordFormKey = GlobalKey<FormState>();

  Future<void> login() async {
    final email = loginEmailController.value.text.trim();
    final password = loginPasswordController.value.text.trim();
    if(email.isEmpty || password.isEmpty){
      // ConstToast.to.showInfo( "All fields are required");
      CustomSnackBar.info("All fields are required");
      return;
    }
    if(formKey.currentState!.validate()){
      isLoading.value = true;
      try{
        await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
        debugPrint("Login UID : ${FirebaseAuth.instance.currentUser?.uid}");
        // ConstToast().showSuccess("Logged in successfully");
        CustomSnackBar.success("Logged in successfully");
        Get.toNamed(ApplicationRoutes.bottomNavigationMenu);
      }catch(err){
        // ConstToast().showError( "Failed to login");
        CustomSnackBar.error("Failed to login");
      }finally{
        isLoading.value = false;
      }
    }
  }

  Future<void> resetPassword() async {
    final email = resetPasswordEmailController.value.text.trim();

    if (email.isEmpty) {
      // ConstToast().showError("Please enter your email");
      CustomSnackBar.info("All fields are required");
      // ScaffoldMessenger.of(Get.context!).showSnackBar(
      //   SnackBar(
      //     content: Text("All fields are required", style: AppTextStyles.kCaption12SemiBoldTextStyle.copyWith(color: Colors.white),),
      //     backgroundColor: Colors.blue,
      //   ),
      // );
      return;
    }

    if (!resetPasswordFormKey.currentState!.validate()) {
      return;
    }

    isLoading.value = true;

    try {
      // This will work once you upgrade to Blaze!
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);

      // ConstToast().showSuccess("Password reset email sent! Check your inbox.");
      CustomSnackBar.success("Password reset email sent! Check your inbox");
      debugPrint("✅ Password reset email sent to: $email");
      Get.back();

    } on FirebaseAuthException catch (err) {
      debugPrint("Reset Password Error: ${err.code}");

      switch (err.code) {
        case 'user-not-found':
          // ConstToast().showError("No account found with this email.");
          CustomSnackBar.error("No account found with this email.");
          break;
        case 'invalid-email':
          // ConstToast().showError("Invalid email address.");
          CustomSnackBar.error("Invalid email address.");
          break;
        case 'too-many-requests':
          // ConstToast().showError("Too many attempts. Please try again later.");
        CustomSnackBar.error("Too many attempts. Please try again later.");
          break;
        default:
          // ConstToast().showError("Failed to send reset email.");
          CustomSnackBar.error("Failed to send reset email.");
      }
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    loginEmailController.dispose();
    loginPasswordController.dispose();
    resetPasswordEmailController.dispose();
    super.onClose();
  }
}

