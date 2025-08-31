import 'package:flutter/material.dart';

import '../../components/custom_Text_field.dart';
import '../../components/custom_buttons.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Account'),
      ),
      body: Container(
        child: Column(
          children: [
            Text("Enter full name"),
            CustomTextField(),
            Text("Enter email Address"),
            CustomTextField(),
            Text("Enter Password"),
            CustomTextField(),
            authButton(text: "SignUp", onPressed: (){})
          ],
        ),
      ),
    );
  }
}
