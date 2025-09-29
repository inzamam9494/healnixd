import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healnixd/components/custom_Text_field.dart';
import 'package:healnixd/components/custom_buttons.dart';
import 'package:healnixd/components/custom_texts.dart';
import 'package:healnixd/routes/routes.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back_ios), onPressed: () { Get.back(); },),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                appBarText(text: "Forget Password?").marginOnly(bottom: 20.0),
                authHeadingText(text: "Enter your email"),
                CustomTextField(),
                authButton(
                  text: "Send Code",
                  onPressed: () {
                    Get.toNamed(ApplicationRoutes.otpVerificationScreen);
                  },
                ).marginOnly(top: 40.0, bottom: 20.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
