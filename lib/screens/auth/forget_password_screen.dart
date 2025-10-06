import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healnixd/components/custom_Text_field.dart';
import 'package:healnixd/components/custom_buttons.dart';
import 'package:healnixd/components/custom_texts.dart';
import 'package:healnixd/routes/routes.dart';
import 'package:healnixd/screens/auth/controller/login_controller.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final LoginController controller = Get.find<LoginController>();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back_ios), onPressed: () { Get.back(); },),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Form(
              key: controller.resetPasswordFormKey,
              child: Obx(() => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  appBarText(text: "Forget Password?").marginOnly(bottom: 20.0),
                  authHeadingText(text: "Enter your email"),
                  CustomTextField(
                    controller: controller.resetPasswordEmailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      if (!GetUtils.isEmail(value)) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                  ),
                  authButton(
                    text: "Send Email",
                    isLoading: controller.isLoading.value,
                    onPressed: () {
                      controller.resetPassword();
                      // Get.toNamed(ApplicationRoutes.otpVerificationScreen);
                    },
                  ).marginOnly(top: 40.0, bottom: 20.0),
                ],
              )),
            ),
          ),
        ),
      ),
    );
  }
}
