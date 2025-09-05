import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healnixd/components/custom_texts.dart';
import 'package:healnixd/routes/routes.dart';
import 'package:healnixd/style/text_style.dart';

import '../../components/custom_Text_field.dart';
import '../../components/custom_buttons.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: appBarText(text: 'Log In'),
        centerTitle: true,
        leading: IconButton(icon: Icon( Icons.arrow_back_ios), onPressed: () { Get.back(); },),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                appBarText(text: "Welcome"),
                Text(
                  "Welcome back! Log in to access your medicine services easily",
                  style: AppTextStyles.kSmall10RegularTextStyle,
                ).marginOnly(bottom: 20.0),
                authHeadingText(text: "Email or Mobile Number"),
                CustomTextField(),
                authHeadingText(text: "Password"),
                CustomTextField(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: (){
                        Get.toNamed(ApplicationRoutes.forgetPasswordScreen);
                      },
                      child: Text(
                        "Forgot Password",
                        style: AppTextStyles.kSmall10RegularTextStyle.copyWith(
                          color: Colors.blue,
                        ),
                      ).marginOnly(top: 5),
                    ),
                  ],
                ),
                authButton(
                  text: "Login",
                  onPressed: () {
                    Get.toNamed(ApplicationRoutes.bottomNavigationMenu);
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
                      icon: Icon(Icons.facebook, color: Colors.blue, size: 35),
                    ),
                  ],
                ).paddingOnly(top: 15.0),
                SizedBox(
                  width: double.infinity,
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: "Don't have an account? ",
                      style: const TextStyle(color: Colors.black, fontSize: 14),
                      children: [
                        TextSpan(
                          text: "Sign up",
                          style: const TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              print(
                                "Sign up clicked!",
                              );
                              Get.toNamed(ApplicationRoutes.registerScreen);
                            },
                        ),
                      ],
                    ),
                  ),
                ).paddingOnly(top: 20.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
