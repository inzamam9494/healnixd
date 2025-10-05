import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healnixd/routes/routes.dart';
import 'package:healnixd/utils/const_toast.dart';

class LoginController extends GetxController{
  var loginEmailController = TextEditingController();
  var loginPasswordController = TextEditingController();
  var isVisiblePassword = false.obs;
  var isLoading = false.obs;
  final formKey = GlobalKey<FormState>();
  var resetPasswordEmailController = TextEditingController();

  Future<void> login() async {
    final email = loginEmailController.value.text.trim();
    final password = loginPasswordController.value.text.trim();
    if(email.isEmpty || password.isEmpty){
      ConstToast().showInfo( "All fields are required");
      return;
    }
    if(formKey.currentState!.validate()){
      isLoading.value = true;
      try{
        await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
        debugPrint("Login UID : ${FirebaseAuth.instance.currentUser?.uid}");
        ConstToast().showSuccess("Logged in successfully");
        Get.toNamed(ApplicationRoutes.bottomNavigationMenu);
      }catch(err){
        ConstToast().showError( "Failed to login");
      }finally{
        isLoading.value = false;
      }
    }
  }

  Future<void> resetPassword() async {
    final email = resetPasswordEmailController.value.text.trim();
    if(email.isEmpty){
      Get.snackbar("Alert", "Please enter your email");
      return;
    }
    try{
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      Get.snackbar("Success", "Password reset email sent");
      Get.back();
    }catch(err){
      Get.snackbar("Error", "Failed to send password reset email");
    }
  }

}