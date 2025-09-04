import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healnixd/components/custom_texts.dart';

import '../../components/custom_Text_field.dart';
import '../../components/custom_buttons.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( leading: IconButton(icon: Icon(Icons.arrow_back_ios), onPressed: () { Get.back(); },),),
      body: Container(
        margin: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            authHeadingText(text: "New Password"),
            CustomTextField(),
            authHeadingText(text: "Confirm Password"),
            CustomTextField(),
            authButton(text: "Reset Password", onPressed: () {}).marginOnly(top: 50.0),
          ],
        ),
      ),
    );
  }
}
