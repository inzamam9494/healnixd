import 'package:flutter/material.dart';

import '../../components/custom_Text_field.dart';
import '../../components/custom_buttons.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),
      body: Container(
        child: Column(
          children: [
            Text("New Password"),
            CustomTextField(),
            Text("Confirm Password"),
            CustomTextField(),
            authButton(text: "Reset Password", onPressed: (){})
          ],
        ),
      ),
    );
  }
}
