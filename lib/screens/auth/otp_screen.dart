import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healnixd/components/custom_buttons.dart';
import 'package:healnixd/components/custom_texts.dart';
import 'package:healnixd/routes/routes.dart';

import '../../components/custom_Text_field.dart';

class OtpScreen extends StatelessWidget {
   OtpScreen({super.key});

  // final List<TextEditingController> otpControllers = List.generate(4, (_) => TextEditingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back_ios), onPressed: () { Get.back(); },),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
        child: Column(
          children: [
            appBarText(text: "Enter your OTP").marginOnly(top: 20.0, bottom: 20.0),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(4, (index) {
                  return Container(
                    height: 50,
                    width: 50,
                    child: CustomTextField(
                      maxLength: 1,
                      keyboardType: TextInputType.number
                    ),
                  );
                }),
              ),
            ),
            authButton(text: "Verify", onPressed: () {
              Get.toNamed(ApplicationRoutes.resetPasswordScreen);
            }).marginOnly(top: 20.0),
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            text: "Didn't received code? ",
            style: const TextStyle(color: Colors.black, fontSize: 14),
            children: [
              TextSpan(
                text: "Resend.",
                style: const TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    if (kDebugMode) {
                      print(
                      "Sign up clicked!",
                    );
                    } // 👈 Navigate or do something
                  },
              ),
            ],
          ),
        ).marginOnly(top: 20.0),

          ],
        )
      ),
    );
  }
}
