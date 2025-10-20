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
  var registerPhoneController = TextEditingController().obs;
  var isVisiblePassword = false.obs;
  var isLoading = false.obs;
  var isChecked = false.obs;
  final formKey = GlobalKey<FormState>();
  String? _verificationId;

  // Firebase Auth instance can be added here for sign up functionality
  // sign up with email
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

  // verify by mobile number
  Future<void> _verifyPhoneNumber(String phoneNumber) async {
    isLoading.value = true;
    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: const Duration(seconds: 60),
        verificationCompleted: (PhoneAuthCredential credential) async {
          final user = FirebaseAuth.instance.currentUser;
          if (user != null) {
            try {
              await user.linkWithCredential(credential);
              await _saveUserDataToFirestore(user.uid, phoneNumber);
              CustomSnackBar.success("Phone Number Verified");
              Get.toNamed(ApplicationRoutes.onboardingScreen);
            } catch (e) {
              await FirebaseAuth.instance.signInWithCredential(credential);
            }
          }
        },
        verificationFailed: (FirebaseAuthException e) {
          CustomSnackBar.error("Phone verification failed : ${e.message}");
        },
        codeSent: (String verificationId, int? resendToken) {
          _verificationId = verificationId;
          Get.toNamed(
            ApplicationRoutes.otpVerificationScreen,
            arguments: {'verificationId': verificationId, 'phone': phoneNumber},
          );
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          _verificationId = verificationId;
        },
      );
    } catch (err) {
      CustomSnackBar.error("Failed to send OTP : ${err.toString()}");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> linkWithOtp(
    String smsCode,
    String verificationId,
    String phoneNumber,
  ) async {
    isLoading.value = true;
    try {
      final credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: smsCode,
      );
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await user.linkWithCredential(credential);
        await _saveUserDataToFirestore(user.uid, phoneNumber);
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('phone', phoneNumber);
        CustomSnackBar.success("Phone Number Verified");
        Get.toNamed(ApplicationRoutes.onboardingScreen);
      } else{
        await FirebaseAuth.instance.signInWithCredential(credential);
        final u = FirebaseAuth.instance.currentUser;
        await _saveUserDataToFirestore(u!.uid, phoneNumber);
        Get.toNamed(ApplicationRoutes.onboardingScreen);
      }
    } catch (err) {
      CustomSnackBar.error("Failed to verify OTP : ${err.toString()}");
    } finally {
      isLoading.value = false;
    }
  }
  Future<void> _saveUserDataToFirestore(String uid, String phoneNumber) async{
    await FirebaseFirestore.instance.collection('user').doc(uid).update({
      'phone': phoneNumber,
      'phoneVerifiedAt': FieldValue.serverTimestamp(),
    });
  }
}
