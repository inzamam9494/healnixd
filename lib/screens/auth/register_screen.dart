import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healnixd/components/custom_texts.dart';
import 'package:healnixd/routes/routes.dart';
import 'package:healnixd/screens/auth/controller/register_controller.dart';
import 'package:healnixd/style/text_style.dart';

import '../../components/custom_Text_field.dart';
import '../../components/custom_buttons.dart';

class RegisterScreen extends GetView<RegisterController> {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: appBarText(text: "Create account"),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Obx(
        () => Container(
          margin: EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
          child: Form(
            key: controller.formKey,
            child: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    authHeadingText(text: "Enter full name"),
                    CustomTextField(
                      controller: controller.registerNameController.value,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                    ),
                    authHeadingText(text: "Enter email address"),
                    CustomTextField(
                      controller: controller.registerEmailController.value,
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
                    authHeadingText(text: "Enter new password"),
                    CustomTextField(
                      controller: controller.registerPasswordController.value,
                      obscureText: controller.isVisiblePassword.value,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        if (value.length < 6) {
                          return 'Password must be at least 6 characters';
                        }
                        return null;
                      },
                      iconTap: () {
                        controller.isVisiblePassword.value =
                            !controller.isVisiblePassword.value;
                      },
                      suffixIcon: controller.isVisiblePassword.value == true
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                    Row(
                      children: [
                        Transform.scale(
                          scale: 0.8,
                          child: Checkbox(
                            activeColor: Colors.blue,
                            checkColor: Colors.white,
                            value: controller.isChecked.value,
                            onChanged: (value) {
                              controller.isChecked.value = value?? false;
                            },
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            visualDensity: VisualDensity.compact,
                          ),
                        ),
                        Text(
                          "Remember me",
                          style: AppTextStyles.kSmall10RegularTextStyle.copyWith(
                            color: Colors.blue,
                          ),
                        ),
                      ],
                    ),
                    authButton(
                      text: "Sign Up",
                      isLoading: controller.isLoading.value,
                      onPressed: () {
                        controller.signUp();
                        // Get.toNamed(ApplicationRoutes.onboardingScreen);
                      },
                    ).marginOnly(top: 70.0, bottom: 20.0),
                    SizedBox(
                      width: double.infinity,
                      child: Text("or sign up with", textAlign: TextAlign.center),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: () {},
                          child: Image.asset(
                            "assets/images/google.png",
                            height: 35,
                            width: 35,
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.apple, color: Colors.black, size: 35),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.facebook,
                            color: Colors.blue,
                            size: 35,
                          ),
                        ),
                      ],
                    ).paddingOnly(top: 15.0),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
